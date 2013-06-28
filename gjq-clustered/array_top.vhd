
-- File: array_top.vhd
-- Date: 11 Mar 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Top level Nussinov systolic array
--
--  The top level accepts query sequences to send to the nussinov array.
--  Command xx - returns information on compile time constants for the nussinov
--               array.
--  Command xx - Start of Queries.  Prepare state machine to accept RNA
--               sequences.  Each base is 3 bits (111 - invalid base). 
--               Up to 21 bases are transfered in a single clock.  Sequences
--               end with a '1' at bit 64.
--               Once all sequences have been transfered, command EF is sent.
--
--               Accepts multiple sequences to send them to multiple
--               arrays.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity array_top is
  port (
    clk            : in  sl;
    reset          : in  sl;
    module_id      : in  slv(5 downto 0) := "000011";

    -- module chain bus signals
    data_in        : in  slv(63 downto 0);
    data_cnt_in    : in  slv(2 downto 0);
    ctrl_vld_in    : in  sl;
    data_vld_in    : in  sl;
    wait_dnstrm    : in  sl;

    data_out       : out slv(63 downto 0);
    data_cnt_out   : out slv(2 downto 0);
    ctrl_vld_out   : out sl;
    data_vld_out   : out sl;
    wait_upstrm    : out sl
  );
end entity array_top;

architecture top_level of array_top is

  constant MODULE_NAME : std_logic_vector(23 downto 0) := x"474A43";   -- GJC (GJQ clustered)

  type input_states is (run, read_sequence, wait4array,
                        reset_module, flush, send_ver, send_cmd
                        );

  signal state           : input_states;
  signal next_state      : input_states;

  -- registered module input signals (from inputBuf.v)
  signal data_in_reg     : slv(63 downto 0);
  signal ctrl_vld_in_reg : sl;
  signal data_vld_in_reg : sl;
  signal data_cnt_in_reg : slv(2 downto 0);

  -- input FSM signals, used for output
  signal ifsm_data_vld   : sl;
  signal ifsm_data_cnt   : slv(2 downto 0);
  signal ifsm_ctrl_vld   : sl;
  signal ifsm_data       : slv(63 downto 0);
  signal command_buff_reg: slv(63 downto 0);
  signal ifsm_busy       : sl;
  signal wait2inbuf      : sl;

  -- internal FSM signals
  signal reset_cmd       : sl;
  signal reset_mod       : sl;
  signal passthru_mode   : sl;

  component inputbuffer
    port (
      clk          : in  sl;
      reset        : in  sl;
      data_in      : in  slv(63 downto 0);
      data_cnt_in  : in  slv(2 downto 0);
      data_vld_in  : in  sl;
      ctrl_vld_in  : in  sl;
      wait_dn      : in  sl;
      data_out     : out slv(63 downto 0);
      data_cnt_out : out slv(2 downto 0);
      data_vld_out : out sl;
      ctrl_vld_out : out sl;
      wait_up      : out sl  
    );
  end component;

  component multiple_arrays
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
  end component;

  -- sequence id
  signal sequence_id        : slv(31 downto 0);

  -- wires to all arrays
  signal sequences          : UNIT_RESIDUE_ARRAY;
  -- sequence array
  signal sequence           : RESIDUE_ARRAY;

  -- start nussinov array
  signal starts             : slv(NO_UNITS-1 downto 0);

  -- nussinov array busy/wait from all units
  signal arrays_wait        : slv(NO_UNITS-1 downto 0);
  signal arrays_have_data   : sl;

  -- wait from the array being addressed
  signal curr_array_wait    : sl;

  signal sequence_score     : slv(31 downto 0);
  signal score_vld          : sl;

  -- indicate which unit is being processed
  signal unit_cntr          : slv(7 downto 0);

begin

  -- reset signal
  reset_mod  <= reset or reset_cmd;

  -- wait to input buffer
  wait2inbuf <= ifsm_busy or wait_dnstrm;

  -- buffer module chain input
  in_buff1 : inputbuffer
    port map (
      clk          => clk,
      reset        => reset,
      data_in      => data_in,
      data_cnt_in  => data_cnt_in,
      data_vld_in  => data_vld_in,
      ctrl_vld_in  => ctrl_vld_in,
      wait_dn      => wait2inbuf,
      data_out     => data_in_reg,
      data_cnt_out => data_cnt_in_reg,
      data_vld_out => data_vld_in_reg,
      ctrl_vld_out => ctrl_vld_in_reg,
      wait_up      => wait_upstrm
      );

  -----------------------------------------------------------------------------
  -- Send nussinov sequences
  -----------------------------------------------------------------------------
  wire_array_inputs: process (sequence)
  begin
  
    for i in 0 to NO_UNITS-1 loop
      -- simply wire the sequence to all arrays, use vld to indicate active
      sequences(i) <= sequence;
    end loop;

  end process wire_array_inputs;

  -- multiple nussinov arrays
  all_arrays : multiple_arrays
    port map (
      clk              => clk,
      reset            => reset_mod,

      sequences        => sequences,
      starts           => starts,

      wait_dnstrm      => wait_dnstrm,

      arrays_have_data => arrays_have_data,
      wait_upstrm      => arrays_wait,

      score            => sequence_score,
      score_vld        => score_vld
    );

  wire_array_outputs: process (unit_cntr, arrays_wait)
  begin

    -- signal sent to state machine from currently addressed array unit  
    curr_array_wait    <= arrays_wait(conv_integer(unit_cntr));

  end process wire_array_outputs;

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
  set_next_state: process (state, ctrl_vld_in_reg, data_vld_in_reg,
                           data_in_reg, module_id, curr_array_wait,
                           arrays_have_data
                           )
  begin 
    next_state <= state;

    case state is
      when run =>
        if ctrl_vld_in_reg = '1' then
            case data_in_reg(xx downto xx) is
              when x"xxxx" => next_state <= reset_module;    -- ""
              when x"xxxx" => next_state <= flush;           -- ""
              when x"xxxx" => next_state <= send_ver;        -- ""

              when x"xxxx" => next_state <= read_sequence;   -- ""

              when others  => next_state <= run;
            end case;
        end if;

      -- read query sequence
      when read_sequence =>
        if ctrl_vld_in_reg = '1' then
            case data_in_reg(xx downto xx) is
              -- done processing sequences
              when x"xxxx" => next_state <= flush;           -- ""

              -- any other command sends it back to the run state
              when others  => next_state <= run;
            end case;
          end if;
        elsif data_vld_in_reg = '1' then
          -- received end of sequence separator; send query to array.
          if data_in_reg(xx) = '1' then
            if curr_array_wait = '1' then
              -- wait for array to free up
              next_state <= wait4array;
            else
              -- send this sequence to array and wait for next sequence
              next_state <= read_sequence;
            end if;
          end if;
        end if;

      -- wait till array is free
      when wait4array =>
         if curr_array_wait = '0' then
           next_state <= read_sequence;
         end if;

      when reset_module =>
        next_state <= run;

      when flush =>
        if arrays_have_data = '0' then
          next_state <= send_cmd;
        end if;

      when send_ver =>
        next_state <= send_cmd;

      when send_cmd =>
        next_state <= run;

    end case;
  end process set_next_state;
  
  -----------------------------------------------------------------------------
  -- Process to handle combinational signals for the input FSM
  -----------------------------------------------------------------------------
  input_comb: process (state, ctrl_vld_in_reg, data_vld_in_reg, wait_dnstrm,
                       data_in_reg, data_cnt_in_reg, module_id,
                       command_buff_reg, curr_array_wait, arrays_have_data,
                       sequence_id, sequence_score, score_vld
                      )
  begin  -- process set_outputs
    ifsm_busy     <= '0';
    ifsm_data_vld <= '0';
    ifsm_ctrl_vld <= '0';
    ifsm_data     <= data_in_reg;
    ifsm_data_cnt <= data_cnt_in_reg;

    case state is
      when run =>
        if ctrl_vld_in_reg = '1' then
            case data_in_reg(xx downto xx) is
              when x"xxxx" =>           -- ""
                ifsm_busy     <= '1';
                ifsm_data     <= data_in_reg;
                ifsm_data_vld <= '0';
                ifsm_data_cnt <= "000";
                ifsm_ctrl_vld <= '1';

              when x"xxxx" =>           -- ""
                ifsm_busy <= '1';

              when x"xxxx" =>           -- "WH"  Which module is loaded?
                                        -- Return module name + no pes and other
                                        -- information
                ifsm_data     <= MODULE_NAME & x"00" &
                                 conv_std_logic_vector(CELL_WIDTH, 8) &
                                 conv_std_logic_vector(NO_RESIDUES, 8) &
                                 conv_std_logic_vector(NO_UNITS, 8) &
                                 conv_std_logic_vector(NO_PE, 8);
                ifsm_data_vld <= '1';
                ifsm_data_cnt <= "000";
                ifsm_ctrl_vld <= '0';

              when others =>
                ifsm_ctrl_vld <= '1';

            end case;
          else  -- Command not global, and not our module ID
            ifsm_ctrl_vld <= '1';
          end if;
        elsif data_vld_in_reg = '1' then
          -- Data incoming, passthru
          ifsm_data     <= data_in_reg;
          ifsm_data_vld <= '1';
        end if;

        -- if there is a nussinov score to report, send it
        if score_vld = '1' then
          ifsm_data     <= sequence_id & sequence_score;
          ifsm_data_vld <= '1';
          ifsm_ctrl_vld <= '0';
        end if;

      -- read query sequence
      when read_sequence =>
        if ctrl_vld_in_reg = '1' then
            case data_in_reg(xx downto xx) is
              -- done processing sequences
              when x"xxxx" =>           -- ""
                ifsm_busy     <= '1';

              -- any other command sends it back to the run state
              when others  =>
                ifsm_ctrl_vld <= '1';

            end case;
        elsif data_vld_in_reg = '1' then
          -- received end of sequence separator
          if data_in_reg(xx) = '1' then
            if curr_array_wait = '1' then
              -- wait for array to free up
              ifsm_busy <= '1';
            end if;
          end if;
        end if;

        -- if there is a nussinov score to report, send it
        if score_vld = '1' then
          ifsm_data     <= sequence_id & sequence_score;
          ifsm_data_vld <= '1';
          ifsm_ctrl_vld <= '0';
        end if;

      when wait4array =>
        ifsm_busy <= '1';

        -- if there is a nussinov score to report, send it
        if score_vld = '1' then
          ifsm_data     <= sequence_id & sequence_score;
          ifsm_data_vld <= '1';
          ifsm_ctrl_vld <= '0';
        end if;

      when reset_module =>
        ifsm_busy <= '1';

      when flush =>
        ifsm_busy <= '1';

        if arrays_have_data = '0' then
          ifsm_data <= (others => '0');
          ifsm_data_cnt <= "000";
          ifsm_ctrl_vld <= '1';
        end if;

        -- if there is a nussinov score to report, send it
        if score_vld = '1' then
          ifsm_data     <= sequence_id & sequence_score;
          ifsm_data_vld <= '1';
          ifsm_ctrl_vld <= '0';
        end if;

      when send_ver =>
        ifsm_busy <= '1';
        ifsm_data <= (others => '0'); 
        ifsm_data_vld <= '0';
        ifsm_ctrl_vld <= not wait_dnstrm;

      when send_cmd =>
        ifsm_data <= command_buff_reg;
        ifsm_ctrl_vld <= '1';

    end case;
  end process input_comb;

  reg_inputs: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        passthru_mode  <= '0';
        reset_cmd      <= '0';

        unit_cntr      <= (others => '0');

        sequence_id    <= (others => '0');
        sequence       <= (others => INVALID_RESIDUE);
        starts         <= (others => '0');
      else
        reset_cmd      <= '0';

        -- set start valid to zero, except for current array when sequence
        -- is being sent
        starts         <= (others => '0');

        if starts /= 0 then
          -- send sequence to next unit, wrap on underflow
          if unit_cntr = 0 then
            unit_cntr  <= conv_std_logic_vector(NO_UNITS - 1, 8);
          else
            unit_cntr  <= unit_cntr - 1;
          end if; 
        end if;

        if score_vld = '1' then
          sequence_id  <= sequence_id + 1;
        end if;

        case state is
          when run =>
            if ctrl_vld_in_reg = '1' then
                case data_in_reg(xx downto xx) is
                  when x"xxxx" =>       -- ""
                    reset_cmd     <= '1';

                  when x"xxxx" =>       -- ""
                    unit_cntr     <= conv_std_logic_vector(NO_UNITS - 1, 8);
                    sequence_id   <= (others => '0');

                  when others => null;
                end case;
            end if;

          -- read query sequence
          when read_sequence =>
            if data_vld_in_reg = '1' then
              -- register sequence data

              -- shift residues to make way for 21 input residues
              for i in NO_RESIDUES - RESIDUES_PER_CLK downto 1 loop
                sequence(i) <= sequence(i + RESIDUES_PER_CLK);
              end loop;

              -- now read in the input residues
              -- MSB: last to first
              for i in RESIDUES_PER_CLK downto 1 loop
                sequence(NO_RESIDUES - RESIDUES_PER_CLK + i) <=
                    data_in_reg(i*RESIDUE_WIDTH-1 downto (i-1)*RESIDUE_WIDTH);
              end loop;

              if data_in_reg(xx) = '1' then
                if curr_array_wait = '0' then
                  starts(conv_integer(unit_cntr)) <= '1';
                end if;
              end if;
            end if;

          when wait4array =>
            if curr_array_wait = '0' then
              starts(conv_integer(unit_cntr)) <= '1';
            end if;

          when flush =>
            null;

          when others => null;
                         
        end case;        
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs;

  -- purpose: Register module outputs
  -- type   : sequential
  -- inputs : clk, reset
  -- outputs: data_out, data_vld_out, ctrl_vld_out
  reg_outputs: process (clk)
  begin  -- process set_outputs
    if rising_edge(clk) then 
      if reset = '1' then
        data_out <= (others => '0');
        data_vld_out <= '0';
        data_cnt_out <= "000";
        ctrl_vld_out <= '0';
        command_buff_reg <= (others => '0');
      else
        data_out     <= ifsm_data;
        data_vld_out <= ifsm_data_vld;
        data_cnt_out <= ifsm_data_cnt;
        ctrl_vld_out <= ifsm_ctrl_vld;

        if ctrl_vld_in_reg = '1' then
          command_buff_reg <= data_in_reg;
        end if;
      end if;
    end if;
  end process reg_outputs;

end architecture top_level; 
