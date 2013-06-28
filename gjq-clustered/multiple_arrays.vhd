
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
    reset            : in  sl;

    sequences        : in  UNIT_RESIDUE_ARRAY;
    starts           : in  slv(NO_UNITS-1 downto 0);

    wait_dnstrm      : in  sl;

    arrays_have_data : out sl;
    wait_upstrm      : out slv(NO_UNITS-1 downto 0);

    score            : out slv(31 downto 0);
    score_vld        : out sl
  );
end entity multiple_arrays;

architecture rtl of multiple_arrays is

  component nussinov
    port (
      clk              : in  sl;
      reset            : in  sl;

      isequence        : in  RESIDUE_ARRAY;
      istart           : in  sl;

      array_working    : out sl;
      wait_upstrm      : out sl;

      osequence_score  : out slv(31 downto 0);
      ovld             : out sl
    );
  end component;

  component fifo_score
    port (
      valid            : out sl;
      rd_en            : in  sl;
      wr_en            : in  sl;
      full             : out sl;
      empty            : out sl;
      clk              : in  sl;
      rst              : in  sl;
      dout             : out slv(98 downto 0);
      din              : in  slv(98 downto 0)
    );
  end component;

  type input_states is (run, send_scores
                        );

  signal state          : input_states;
  signal next_state     : input_states;

  signal all_scores     : SCORE_ARRAY;
  signal all_scores_vld : slv(NO_UNITS-1 downto 0);
  signal all_working    : slv(NO_UNITS-1 downto 0);

  -- fifo signals
  signal fifo_valid     : sl;
  signal fifo_rd        : sl;
  signal fifo_wr        : sl;
  signal fifo_empty     : sl;
  signal fifo_dout      : slv(98 downto 0);
  signal fifo_din       : slv(98 downto 0);

  -- internal score word
  signal score_word     : slv(98 downto 0);
  signal unit_cntr      : slv(7 downto 0);

  signal score_int      : slv(31 downto 0);
  signal score_vld_int  : sl;

  -- all signals to make sure arrays_have_data is low only when this code
  -- does not have any more output
  signal fifo_wr_1      : sl;
  signal fifo_wr_2      : sl;
  signal busy_int       : sl;

begin

  -- instantiate multiple nussinov arrays
  nussinov_gen : for i in 0 to NO_UNITS - 1
    generate
      one_array : nussinov
        port map (
          clk              => clk,
          reset            => reset,

          isequence        => sequences(i),
          istart           => starts(i),

          array_working    => all_working(i),
          wait_upstrm      => wait_upstrm(i),

          osequence_score  => all_scores(i),
          ovld             => all_scores_vld(i)
        );
    end generate;

  wire_array_outputs: process (all_working, fifo_wr_1, fifo_wr_2, fifo_empty,
                               busy_int, score_int, score_vld_int)
    variable working_int : sl;
  begin

    -- see if any array is working
    working_int := '0';
    for i in 0 to NO_UNITS-1 loop
      working_int := working_int or all_working(i);
    end loop;
    arrays_have_data <= working_int or fifo_wr_1 or fifo_wr_2 or
                        not fifo_empty or busy_int or score_vld_int;

    -- send score and vld
    score     <= score_int;
    score_vld <= score_vld_int;

  end process wire_array_outputs;

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
      fifo_din((i+1)*33 - 1 downto i*33) <= all_scores(i) &
                                            all_scores_vld(i);
      fifo_wr_int := fifo_wr_int or all_scores_vld(i);
    end loop;

    -- write signal is high if any one of the scores is valid
    fifo_wr <= fifo_wr_int;
  end process wire_fifo_inputs;

  -- save nussinov scores into a fifo
  save_score : fifo_score
    port map (
      clk   => clk,
      rst   => reset,

      valid => fifo_valid,
      full  => open,
      wr_en => fifo_wr,
      din   => fifo_din,

      empty => fifo_empty,
      rd_en => fifo_rd,
      dout  => fifo_dout
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
  set_next_state: process (state, fifo_valid, unit_cntr, wait_dnstrm
                           )
  begin 
    next_state <= state;

    case state is
      when run =>
        -- if there is a score in the fifo, go process it
        if fifo_valid = '1' and wait_dnstrm = '0' then
          next_state <= send_scores;
        end if;

      -- send scores
      when send_scores =>
        -- after sending all the scores, continue to next fifo word
        if unit_cntr <= 1 then
          next_state <= run;
        end if;

    end case;
  end process set_next_state;

  -----------------------------------------------------------------------------
  -- Process to handle combinational signals for the input FSM
  -----------------------------------------------------------------------------
  input_comb: process (state, fifo_valid, wait_dnstrm
                      )
  begin

    fifo_rd  <= '0';
    busy_int <= '0';

    case state is
      when run =>
        -- if there is a score in the fifo, read it
        fifo_rd  <= fifo_valid and not wait_dnstrm;
        busy_int <= fifo_valid;

      -- send scores
      when send_scores =>
        busy_int <= '1';

    end case;
  end process input_comb;

  reg_outputs: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        unit_cntr     <= (others => '0');
        score_word    <= (others => '0');

        score_int     <= (others => '0');
        score_vld_int <= '0';

        fifo_wr_1     <= '0';
        fifo_wr_2     <= '0';
      else

        score_int     <= score_word(32 downto 1);
        score_vld_int <= '0';

        fifo_wr_1     <= fifo_wr;
        fifo_wr_2     <= fifo_wr_1;

        case state is
          when run =>
            -- if fifo is not empty, then read the current data word
            if fifo_valid = '1' and wait_dnstrm = '0' then
              score_word <= fifo_dout;
              unit_cntr  <= conv_std_logic_vector(NO_UNITS, 8);
            end if;

          -- send scores
          when send_scores =>
            if wait_dnstrm = '0' then
              unit_cntr     <= unit_cntr - 1;

              score_vld_int <= score_word(0);
              score_word    <= '0' & x"00000000" &
                               score_word(score_word'length-1 downto 33);
            end if;

        end case;        
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_outputs;

end architecture rtl;
