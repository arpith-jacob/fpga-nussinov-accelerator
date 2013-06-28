
-- File: multiple_arrays.vhd
-- Date: 13 Mar 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Instantiate multiple Nussinov systolic arrays
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity multiple_arrays is
  port (
    clk              : in  sl;
    clk_array        : in  sl;

    reset            : in  sl;
    reset_array      : in  sl;

    sequence_word    : in  slv(63 downto 0);
    sequence_vld     : in  sl;

    wait_dnstrm      : in  sl;

    wait_upstrm      : out sl;

    score            : out slv(31 downto 0);
    score_vld        : out sl
  );
end entity multiple_arrays;

architecture rtl of multiple_arrays is

  component nussinov
    port (
      clk              : in  sl;
      reset            : in  sl;

      iresidue_S_i     : in  slv(RESIDUE_WIDTH-1 downto 0);
      iresidue_S_j     : in  slv(RESIDUE_WIDTH-1 downto 0);
      istart           : in  sl;

      wait_upstrm      : out sl;

      osequence_score  : out slv(31 downto 0);
      ovld             : out sl
    );
  end component;

  component fifo_score is
    port (
      valid            : out sl;
      rd_en            : in  sl;
      wr_en            : in  sl;
      full             : out sl;
      empty            : out sl;
      wr_clk           : in  sl;
      rst              : in  sl;
      rd_clk           : in  sl;
      dout             : out slv(98 downto 0);
      din              : in  slv(98 downto 0)
    );
  end component;

  component fifo_sequence is
    port (
      valid            : out sl;
      prog_full        : out sl;
      rd_en            : in  sl;
      wr_en            : in  sl;
      full             : out sl;
      empty            : out sl;
      wr_clk           : in  sl;
      rst              : in  sl;
      rd_clk           : in  sl;
      dout             : out slv(63 downto 0);
      din              : in  slv(63 downto 0);
      rd_data_count    : out slv(8 downto 0) 
    );
  end component;

  --
  --  Sequence FIFO
  --
  type seq_input_states is (run, wait4array);

  signal seq_state            : seq_input_states;
  signal seq_next_state       : seq_input_states;

  -- sequence fifo signals
  signal seq_fifo_valid       : sl;
  signal seq_fifo_rd          : sl;
  signal seq_fifo_dout        : slv(63 downto 0);
  signal seq_fifo_count       : slv(8 downto 0);

  -- nussinov array busy from all units
  signal arrays_wait          : slv(NO_UNITS-1 downto 0);
  -- wait from the array being addressed
  signal curr_array_wait      : sl;

  -- count number of sequence residues sent to array
  signal residue_seq_count    : slv(15 downto 0);
  -- count number of residues from a single word sent to array
  signal residue_word_count   : slv(6 downto 0);

  -- wires to all arrays
  signal sequence_residue_S_i : UNIT_RESIDUE_ARRAY;
  signal sequence_residue_S_j : UNIT_RESIDUE_ARRAY;
  -- residue to send into array
  signal residue_S_i          : slv(RESIDUE_WIDTH-1 downto 0);
  signal residue_S_j          : slv(RESIDUE_WIDTH-1 downto 0);

  -- one word of sequence residues + one residue
  signal residue_word         : slv(65 downto 0);
  -- start, finish nussinov array
  signal starts               : slv(NO_UNITS-1 downto 0);
  -- indicate which unit is being processed
  signal seq_unit_cntr        : slv(7 downto 0);

  --
  --  Score FIFO
  --
  type input_states is (run, send_scores);

  signal state                : input_states;
  signal next_state           : input_states;

  signal all_scores           : SCORE_ARRAY;
  signal all_scores_vld       : slv(NO_UNITS-1 downto 0);

  -- score fifo signals
  signal score_fifo_valid     : sl;
  signal score_fifo_rd        : sl;
  signal score_fifo_wr        : sl;
  signal score_fifo_dout      : slv(98 downto 0);
  signal score_fifo_din       : slv(98 downto 0);

  -- internal score word
  signal score_word           : slv(98 downto 0);
  signal score_unit_cntr      : slv(7 downto 0);

  signal score_int            : slv(31 downto 0);
  signal score_vld_int        : sl;

begin

  -----------------------------------------------------------------------------
  -- Store scores from all units in a FIFO
  -----------------------------------------------------------------------------

  -- store sequence information
  store_sequence : fifo_sequence
    port map (
      rd_clk        => clk_array,
      rst           => reset,
      valid         => seq_fifo_valid,
      rd_en         => seq_fifo_rd,
      empty         => open,
      dout          => seq_fifo_dout,
      rd_data_count => seq_fifo_count,

      wr_clk        => clk,
      wr_en         => sequence_vld,
      full          => open,
      prog_full     => wait_upstrm,
      din           => sequence_word
    );

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  seq_set_curr_state: process (clk_array)
  begin 
    if rising_edge(clk_array) then
      if reset_array = '1' then
        seq_state <= run;
      else
        seq_state <= seq_next_state;
      end if;
    end if;
  end process seq_set_curr_state;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  seq_set_next_state: process (seq_state, seq_fifo_valid, seq_fifo_count,
                               curr_array_wait, residue_seq_count)
  begin 
    seq_next_state <= seq_state;

    case seq_state is
      when wait4array =>
        -- wait until array is able to accept input
        -- ensure that the entire sequence is available in the buffer so that
        -- we can perform computation without stopping the array
        if seq_fifo_valid = '1' and
           seq_fifo_count >= NO_WORDS_FOR_SEQUENCE and
           curr_array_wait = '0' then
          seq_next_state <= run;
        end if;

      when run =>
        if residue_seq_count <= 1 then
          seq_next_state <= wait4array;
        end if;

    end case;
  end process seq_set_next_state;

  -----------------------------------------------------------------------------
  -- Process to handle combinational signals for the input FSM
  -----------------------------------------------------------------------------
  seq_input_comb: process (seq_state, seq_fifo_count, curr_array_wait,
                           seq_fifo_valid, residue_word_count,
                           residue_seq_count)
  begin

    seq_fifo_rd  <= '0';

    case seq_state is
      when wait4array =>
        if seq_fifo_count >= NO_WORDS_FOR_SEQUENCE and
             curr_array_wait = '0' then
          seq_fifo_rd <= seq_fifo_valid;
        end if;

      when run =>
        if residue_word_count <= 1 and residue_seq_count > 1 then
          seq_fifo_rd <= seq_fifo_valid;
        end if;

    end case;
  end process seq_input_comb;

  seq_reg_outputs: process (clk_array)
  begin
    if rising_edge(clk_array) then
      if reset_array = '1' then
        seq_unit_cntr      <= (others => '0');

        -- not resetting sequence data
        starts             <= (others => '0');

        residue_word       <= (others => '0');
        residue_S_i        <= (others => '0');
        residue_S_j        <= (others => '0');

        residue_word_count <= (others => '0');
        residue_seq_count  <= (others => '0');
      else

        -- set start valid to zero, except for current array when sequence
        -- is being sent
        starts             <= (others => '0');

        case seq_state is
          when wait4array =>
            if seq_fifo_valid = '1' and
               seq_fifo_count >= NO_WORDS_FOR_SEQUENCE and
               curr_array_wait = '0' then
              -- store sequence word
              residue_word <= "000000" & seq_fifo_dout(62 downto 3);
              residue_S_i  <= seq_fifo_dout(RESIDUE_WIDTH-1 downto 0);
              residue_S_j  <= seq_fifo_dout(2*RESIDUE_WIDTH-1 downto RESIDUE_WIDTH);

              -- count residues off of word
              residue_word_count <= conv_std_logic_vector(RESIDUES_PER_CLK - 2,
                                                    residue_word_count'length);
              -- count sequence residues
              residue_seq_count  <= conv_std_logic_vector(SEQ_LEN - 1,
                                                    residue_seq_count'length);

              -- signal start of sequence
              starts(conv_integer(seq_unit_cntr)) <= '1';
            end if;

          when run =>
            -- send out next residue
            residue_S_i  <= residue_word(RESIDUE_WIDTH-1 downto 0);
            residue_S_j  <= residue_word(2*RESIDUE_WIDTH-1 downto RESIDUE_WIDTH);

            -- right shift residue word
            for i in 59 downto 0 loop
              residue_word(i) <= residue_word(i + 3);
            end loop;

            -- increment counters
            residue_word_count <= residue_word_count - 1;
            residue_seq_count  <= residue_seq_count - 1;

            if residue_seq_count <= 1 then
              -- end of sequence
              -- send sequence to next unit, wrap on underflow
              if seq_unit_cntr = 0 then
                seq_unit_cntr  <= conv_std_logic_vector(NO_UNITS - 1, 8);
              else
                seq_unit_cntr  <= seq_unit_cntr - 1;
              end if;
            end if;

            -- read next set of words
            if residue_word_count <= 1 and residue_seq_count > 1 then
              residue_word_count <= conv_std_logic_vector(RESIDUES_PER_CLK,
                                                    residue_word_count'length);

              residue_word       <= seq_fifo_dout(62 downto 0) &
                                    residue_word(2*RESIDUE_WIDTH-1 downto RESIDUE_WIDTH);
            end if;

        end case;        

      end if; -- end reset 
    end if;  -- end rising_edge
  end process seq_reg_outputs;

  wire_array_inputs: process (residue_S_i, residue_S_j)
  begin

    for i in 0 to NO_UNITS-1 loop
      -- simply wire the sequence residue to all arrays
      sequence_residue_S_i(i) <= residue_S_i;
      sequence_residue_S_j(i) <= residue_S_j;
    end loop;

  end process wire_array_inputs;

  wire_array_outputs: process (seq_unit_cntr, arrays_wait)
  begin

    -- signal sent to state machine from currently addressed array unit  
    curr_array_wait    <= arrays_wait(conv_integer(seq_unit_cntr));

  end process wire_array_outputs;


  -----------------------------------------------------------------------------
  -- Instantiate multiple nussinov arrays
  -----------------------------------------------------------------------------
  nussinov_gen : for i in 0 to NO_UNITS - 1
    generate
      one_array : nussinov
        port map (
          clk              => clk_array,
          reset            => reset_array,

          iresidue_S_i     => sequence_residue_S_i(i),
          iresidue_S_j     => sequence_residue_S_j(i),
          istart           => starts(i),

          wait_upstrm      => arrays_wait(i),

          osequence_score  => all_scores(i),
          ovld             => all_scores_vld(i)
        );
    end generate;

  -- send score and vld
  score     <= score_int;
  score_vld <= score_vld_int;

  -----------------------------------------------------------------------------
  -- Store scores from all units in a FIFO
  -----------------------------------------------------------------------------
  wire_fifo_inputs: process (all_scores, all_scores_vld)
    variable fifo_wr_int : sl;
  begin
  
    -- see if at least one score has been output by the arrays
    fifo_wr_int := '0';
    for i in 0 to NO_UNITS-1 loop
      -- wire the score into the fifo
      score_fifo_din((i+1)*33 - 1 downto i*33) <= all_scores(i) &
                                                  all_scores_vld(i);
      fifo_wr_int := fifo_wr_int or all_scores_vld(i);
    end loop;

    -- write signal is high if any one of the scores is valid
    score_fifo_wr <= fifo_wr_int;
  end process wire_fifo_inputs;

  -- save nussinov scores into a fifo
  save_score : fifo_score
    port map (
      rd_clk => clk,
      rst    => reset,
      valid  => score_fifo_valid,
      rd_en  => score_fifo_rd,
      empty  => open,
      dout   => score_fifo_dout,

      wr_clk => clk_array,
      wr_en  => score_fifo_wr,
      full   => open,
      din    => score_fifo_din
    );

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state <= run;
      else
        state <= next_state;
      end if;
    end if;
  end process set_curr_state;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state: process (state, score_fifo_valid, score_unit_cntr, wait_dnstrm
                           )
  begin 
    next_state <= state;

    case state is
      when run =>
        -- if there is a score in the fifo, go process it
        if score_fifo_valid = '1' and wait_dnstrm = '0' then
          next_state <= send_scores;
        end if;

      -- send scores
      when send_scores =>
        -- after sending all the scores, continue to next fifo word
        if score_unit_cntr <= 1 then
          next_state <= run;
        end if;

    end case;
  end process set_next_state;

  -----------------------------------------------------------------------------
  -- Process to handle combinational signals for the input FSM
  -----------------------------------------------------------------------------
  input_comb: process (state, score_fifo_valid, wait_dnstrm
                      )
  begin

    score_fifo_rd  <= '0';

    case state is
      when run =>
        -- if there is a score in the fifo, read it
        score_fifo_rd  <= score_fifo_valid and not wait_dnstrm;

      when send_scores =>
        null;

    end case;
  end process input_comb;

  reg_outputs: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        score_unit_cntr <= (others => '0');
        score_word      <= (others => '0');

        score_int       <= (others => '0');
        score_vld_int   <= '0';
      else

        score_int       <= score_word(32 downto 1);
        score_vld_int   <= '0';

        case state is
          when run =>
            -- if fifo is not empty, then read the current data word
            if score_fifo_valid = '1' and wait_dnstrm = '0' then
              score_word      <= score_fifo_dout;
              score_unit_cntr <= conv_std_logic_vector(NO_UNITS, 8);
            end if;

          -- send scores
          when send_scores =>
            if wait_dnstrm = '0' then
              score_unit_cntr <= score_unit_cntr - 1;

              score_vld_int   <= score_word(0);
              score_word      <= '0' & x"00000000" &
                                 score_word(score_word'length-1 downto 33);
            end if;

        end case;        
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_outputs;

end architecture rtl;
