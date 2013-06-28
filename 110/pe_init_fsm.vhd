
-- File: pe_init_fsm.vhd
-- Date: 27 January 2010
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      FSM to initialize processing element in array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_init_fsm is
  port (
    clk                  : in  sl;
    reset                : in  sl;

    -- INPUTS
    sequence             : in  RESIDUE_ARRAY;
    start                : in  sl;

    -- bottom pe X score
    X_i_j_k              : in  slv(CELL_WIDTH-1 downto 0);

    -- array is busy
    wait_upstrm          : out sl;

    -- sequence characters: initialization input
    -- sequence character S_i, S_j
    init_seq             : out sl;
    initial_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
    initial_S_j          : out slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    start_aggr           : out slv(1 to 2);
                             -- start max aggregating along k axis
    init_pipe58          : out slv(1 to 1);
                             -- initialize pipelines 5 and 8

    sequence_score       : out slv(31 downto 0);
    vld                  : out sl
  );
end entity pe_init_fsm;

architecture top_level of pe_init_fsm is

  -- latency of array
  constant ARRAY_LATENCY        : integer := ( SCHEDULE(1, SEQ_LEN, 1) -
                                               SCHEDULE(1, 2, 1) );

  -- block pipelining period of array
  -- we assume utilization of array = 100%, i.e., lambda u = 1
  constant ARRAY_PERIOD         : integer := ( SEQ_LEN - 2 );

  component delay_pipe is
    generic (
      DATA_WIDTH     : natural := 1;
      DELAY_STATES   : natural := 1;
      NEEDS_RESET    : boolean := true;

      -- When needs reset=true, True: set all vals to 1, else 0
      RESET_VAL_HIGH : boolean := false
      );
    port (
      clk   : in  sl;
      reset : in  sl;
      din   : in  slv (DATA_WIDTH-1 downto 0);
      dout  : out slv (DATA_WIDTH-1 downto 0)
      );
  end component;

  signal delay_count_latency_in         : slv(0 downto 0);
  signal delay_count_latency_out        : slv(0 downto 0);

  type states_period_t is (idle, run);
  signal state_period                   : states_period_t;
  signal next_state_period              : states_period_t;
  signal counter_period                 : slv(15 downto 0);

  type states_seqdata_t is (idle, run);
  signal state_seqdata                  : states_seqdata_t;
  signal next_state_seqdata             : states_seqdata_t;
  signal counter_seqdata                : slv(15 downto 0);

  type states_pipe58_t is (idle, run);
  signal state_pipe58                   : states_pipe58_t;
  signal next_state_pipe58              : states_pipe58_t;
  signal counter_pipe58                 : slv(15 downto 0);

  type states_j_m_i_eq_3_start_aggr_t is (idle, run);
  signal state_j_m_i_eq_3_start_aggr      : states_j_m_i_eq_3_start_aggr_t;
  signal next_state_j_m_i_eq_3_start_aggr : states_j_m_i_eq_3_start_aggr_t;
  signal counter_j_m_i_eq_3_start_aggr    : slv(15 downto 0);

  -- store sequence data internally
  signal int_seqdata                    : RESIDUE_ARRAY;

  signal delay_init_seqdata_in          : slv(0 downto 0);
  signal delay_init_seqdata_out         : slv(0 downto 0);

  signal delay_j_m_i_eq_2_in            : slv(0 downto 0);
  signal delay_j_m_i_eq_2_out           : slv(0 downto 0);
  signal delay_pipe58_in                : slv(0 downto 0);
  signal delay_pipe58_out               : slv(0 downto 0);

  signal delay_wait_j_m_i_eq_3_start_aggr_in  : slv(0 downto 0);
  signal delay_wait_j_m_i_eq_3_start_aggr_out : slv(0 downto 0);
  signal delay_j_m_i_eq_3_start_aggr_in       : slv(0 downto 0);
  signal delay_j_m_i_eq_3_start_aggr_out      : slv(0 downto 0);

  -- internal signals that need to be flopped to improve timing
  signal ifsm_init_seq                  : sl;
  signal ifsm_initial_S_i               : slv(RESIDUE_WIDTH-1 downto 0);
  signal ifsm_initial_S_j               : slv(RESIDUE_WIDTH-1 downto 0);

  signal ifsm_j_m_i_eq_2_start_aggr     : slv(1 to 1);
  signal ifsm_j_m_i_eq_3_start_aggr     : slv(1 to 1);
  signal ifsm_init_pipe58               : slv(1 to 1);

  signal int1_init_seq                  : sl;
  signal int1_initial_S_i               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int1_initial_S_j               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int1_start_aggr                : slv(1 to 2);
  signal int1_init_pipe58               : slv(1 to 1);

  signal int2_init_seq                  : sl;
  signal int2_initial_S_i               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int2_initial_S_j               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int2_start_aggr                : slv(1 to 2);
  signal int2_init_pipe58               : slv(1 to 1);

  -- output scores
  signal sequence_score_1               : slv(31 downto 0);
  signal vld_1                          : sl;

begin

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  init_seq    <= int2_init_seq;
  initial_S_i <= int2_initial_S_i;
  initial_S_j <= int2_initial_S_j;
  start_aggr  <= int2_start_aggr;
  init_pipe58 <= int2_init_pipe58;

  output_score : process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        sequence_score_1 <= (others => '0');
        sequence_score   <= (others => '0');

        vld_1            <= '0';
        vld              <= '0';
      else
        vld_1            <= delay_count_latency_out(0);
        sequence_score_1 <= x"000000" & "00" & X_i_j_k;
        -- sequence_score_1 <= x"00000" & "0000" & X_i_j_k;

        vld              <= vld_1;
        sequence_score   <= sequence_score_1;
      end if;
    end if;
  end process output_score;

  -- register output signals to improve timing
  output_signals : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        int1_init_seq      <= '0';
        int1_initial_S_i   <= (others => '0');
        int1_initial_S_j   <= (others => '0');
        int1_start_aggr    <= (others => '0');
        int1_init_pipe58   <= (others => '0');

        int2_init_seq      <= '0';
        int2_initial_S_i   <= (others => '0');
        int2_initial_S_j   <= (others => '0');
        int2_start_aggr    <= (others => '0');
        int2_init_pipe58   <= (others => '0');
      else
        int1_init_seq      <= ifsm_init_seq;
        int1_initial_S_i   <= ifsm_initial_S_i;
        int1_initial_S_j   <= ifsm_initial_S_j;
        int1_start_aggr(1) <= ifsm_j_m_i_eq_2_start_aggr(1);
        int1_start_aggr(2) <= ifsm_j_m_i_eq_3_start_aggr(1);
        int1_init_pipe58   <= ifsm_init_pipe58;

        int2_init_seq      <= int1_init_seq;
        int2_initial_S_i   <= int1_initial_S_i;
        int2_initial_S_j   <= int1_initial_S_j;
        int2_start_aggr    <= int1_start_aggr;
        int2_init_pipe58   <= int1_init_pipe58;
      end if;
    end if;
  end process output_signals;

  -----------------------------------------------------------------------------
  -- Count Latency
  -----------------------------------------------------------------------------

  -- count latency
  delay_count_latency : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => ARRAY_LATENCY + 2,
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_count_latency_in,
      dout           => delay_count_latency_out
      );
  delay_count_latency_in(0) <= start;

  -----------------------------------------------------------------------------
  -- Count Period
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_period : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_period <= idle;
      else
        state_period <= next_state_period;
      end if;
    end if;
  end process set_curr_state_period;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_period: process (state_period, start, counter_period)
  begin 

    next_state_period <= state_period;

    case state_period is
      when idle =>
        -- register input sequence data
        if start = '1' then
          next_state_period <= run;
        end if;

      when run => -- start computation in this state
        -- done sending input to all PEs
        if counter_period = 0 then
          next_state_period <= idle;
        end if;

    end case;
  end process set_next_state_period;

  reg_inputs_period: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        wait_upstrm     <= '0';

        counter_period  <= conv_std_logic_vector(
                                       ARRAY_PERIOD - 3,
                                       counter_period'length
                                       );
      else

        wait_upstrm     <= '0';

        case state_period is
          when idle =>
            if start = '1' then
              -- wait for 3 less than array period.  This is time it takes
              -- for the upstream state to respond and send a new sequence
              counter_period <= conv_std_logic_vector(
                                       ARRAY_PERIOD - 3,
                                       counter_period'length
                                       );

              wait_upstrm     <= '1';
            end if;

          when run =>
            wait_upstrm       <= '1';
            counter_period    <= counter_period - 1;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_period;

  -----------------------------------------------------------------------------
  -- Handle sequence data input into the array: S_i, S_j
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_seqdata : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_seqdata <= idle;
      else
        state_seqdata <= next_state_seqdata;
      end if;
    end if;
  end process set_curr_state_seqdata;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_seqdata: process (state_seqdata, start,
                                   delay_init_seqdata_out, counter_seqdata)
  begin 

    next_state_seqdata <= state_seqdata;

    case state_seqdata is
      when idle =>
        -- register input sequence data
        if start = '1' then
          next_state_seqdata <= run;
        end if;

      when run =>
        if delay_init_seqdata_out(0) = '1' and counter_seqdata = 1 then
          next_state_seqdata <= idle;
        end if;

    end case;
  end process set_next_state_seqdata;

  -- every X clock cycles we send a new sequence character
  -- along the anti diagonal
  delay_init_seqdata : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => SCHEDULE(2, 3, 1) - SCHEDULE(1, 2, 1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_init_seqdata_in,
      dout           => delay_init_seqdata_out
      );

  set_inputs_seqdata: process (state_seqdata, start, sequence, int_seqdata,
                               delay_init_seqdata_out)
  begin

      delay_init_seqdata_in(0) <= '0';

      ifsm_init_seq            <= '0';
      ifsm_initial_S_i         <= int_seqdata(1);
      ifsm_initial_S_j         <= int_seqdata(2);

      case state_seqdata is
        when idle =>
          if start = '1' then
            delay_init_seqdata_in(0) <= '1';
            ifsm_init_seq            <= '1';

            ifsm_initial_S_i         <= sequence(1);
            ifsm_initial_S_j         <= sequence(2);
          end if;

        when run =>
          if delay_init_seqdata_out(0) = '1' then
            -- ready to send sequence character to PE # "counter"
            delay_init_seqdata_in(0) <= '1';

            ifsm_init_seq            <= '1';

            ifsm_initial_S_i         <= int_seqdata(1);
            ifsm_initial_S_j         <= int_seqdata(2);
          end if;

      end case;

  end process set_inputs_seqdata;

  reg_inputs_seqdata: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        int_seqdata                   <= (others => (others => '0'));

        counter_seqdata               <= (others => '0');
      else

        case state_seqdata is
          when idle =>
            -- register the new RNA
            if start = '1' then
              counter_seqdata  <= conv_std_logic_vector(SEQ_LEN - 2,
                                       counter_seqdata'length);

              -- skip one character already sent in this clock
              for i in 1 to NO_RESIDUES-1 loop
                int_seqdata(i) <= sequence(i+1);
              end loop;

            end if;

          when run =>
            if delay_init_seqdata_out(0) = '1' then
              counter_seqdata <= counter_seqdata - 1;

              -- switch to next sequence character to send
              -- shift by 1 character
              for i in 1 to NO_RESIDUES-1 loop
                int_seqdata(i) <= int_seqdata(i+1);
              end loop;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_seqdata;

  -----------------------------------------------------------------------------
  -- Start signals for control input j - i = 2
  -- Start signals for control input j - i = 3
  -----------------------------------------------------------------------------

  -- wait till j - i = 2
  delay_j_m_i_eq_2_in(0) <= start;

  -- notify when we're processing the first cell of j - i = 2 anti-diagonal
  -- one cycle delay is in the input flop
  delay_j_m_i_eq_2 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => SCHEDULE(1, 3, 1) - SCHEDULE(1, 2, 1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_j_m_i_eq_2_in,
      dout           => delay_j_m_i_eq_2_out
      );

  -- wait till j - i = 3
  delay_wait_j_m_i_eq_3_start_aggr_in(0) <= start;

  -- notify when we're processing the first cell of j - i = 3 anti-diagonal
  -- one cycle delay is in the input flop
  delay_wait_j_m_i_eq_3_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => SCHEDULE(1, 4, 1) - SCHEDULE(1, 2, 1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_wait_j_m_i_eq_3_start_aggr_in,
      dout           => delay_wait_j_m_i_eq_3_start_aggr_out
      );

  -----------------------------------------------------------------------------
  -- Handle control input for init_pipe58
  -- Handle control input for start_aggr at j - i = 2
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_pipe58: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_pipe58 <= idle;
      else
        state_pipe58 <= next_state_pipe58;
      end if;
    end if;
  end process set_curr_state_pipe58;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_pipe58: process (state_pipe58,
                                  delay_j_m_i_eq_2_out,
                                  delay_pipe58_out,
                                  counter_pipe58)
  begin 

    next_state_pipe58 <= state_pipe58;

    case state_pipe58 is
      when idle =>
        if delay_j_m_i_eq_2_out(0) = '1' then
          next_state_pipe58   <= run;
        end if;

      when run =>
        -- done sending control to all PEs
        if delay_pipe58_out(0) = '1' and counter_pipe58 = 1 then
          next_state_pipe58 <= idle;
        end if;

    end case;
  end process set_next_state_pipe58;

  -- every X clock cycles we send a new sequence character
  -- along the anti diagonal
  delay_pipe58 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => SCHEDULE(2, 4, 1) - SCHEDULE(1, 3, 1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_pipe58_in,
      dout           => delay_pipe58_out
      );

  set_inputs_pipe58: process (state_pipe58, delay_j_m_i_eq_2_out, 
                              delay_pipe58_out)
  begin

      delay_pipe58_in(0)           <= '0';

      ifsm_init_pipe58             <= (others => '0');
      ifsm_j_m_i_eq_2_start_aggr   <= (others => '0');

      case state_pipe58 is
        when idle =>
          if delay_j_m_i_eq_2_out(0) = '1' then
            delay_pipe58_in(0)            <= '1';

            ifsm_init_pipe58(1)           <= '1';
            ifsm_j_m_i_eq_2_start_aggr(1) <= '1';
          end if;

        when run =>
          if delay_pipe58_out(0) = '1' then
            delay_pipe58_in(0)            <= '1';

            -- send control
            ifsm_init_pipe58(1)           <= '1';
            ifsm_j_m_i_eq_2_start_aggr(1) <= '1';
          end if;

      end case;

  end process set_inputs_pipe58;

  reg_inputs_pipe58: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        counter_pipe58 <= (others => '0');
      else

        case state_pipe58 is
          when idle =>
            if delay_j_m_i_eq_2_out(0) = '1' then
              counter_pipe58 <= conv_std_logic_vector(SEQ_LEN - 3,
                                         counter_pipe58'length);
            end if;

          when run =>
            if delay_pipe58_out(0) = '1' then
              counter_pipe58 <= counter_pipe58 - 1;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_pipe58;

  -----------------------------------------------------------------------------
  -- Handle control input for start_aggr at j - i = 3
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_j_m_i_eq_3_start_aggr: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_j_m_i_eq_3_start_aggr <= idle;
      else
        state_j_m_i_eq_3_start_aggr <= next_state_j_m_i_eq_3_start_aggr;
      end if;
    end if;
  end process set_curr_state_j_m_i_eq_3_start_aggr;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_j_m_i_eq_3_start_aggr: process (
                                      state_j_m_i_eq_3_start_aggr,
                                      delay_wait_j_m_i_eq_3_start_aggr_out,
                                      delay_j_m_i_eq_3_start_aggr_out,
                                      counter_j_m_i_eq_3_start_aggr
                                      )
  begin

    next_state_j_m_i_eq_3_start_aggr <= state_j_m_i_eq_3_start_aggr;

    case state_j_m_i_eq_3_start_aggr is
      when idle =>
        if delay_wait_j_m_i_eq_3_start_aggr_out(0) = '1' then
          next_state_j_m_i_eq_3_start_aggr <= run;
        end if;

      when run =>
        if delay_j_m_i_eq_3_start_aggr_out(0) = '1' and
             counter_j_m_i_eq_3_start_aggr = 1 then
          next_state_j_m_i_eq_3_start_aggr <= idle;
        end if;

    end case;
  end process set_next_state_j_m_i_eq_3_start_aggr;

  -- every X clock cycles we send a control signal
  -- along the anti diagonal
  delay_j_m_i_eq_3_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => SCHEDULE(2, 5, 1) - SCHEDULE(1, 4, 1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_j_m_i_eq_3_start_aggr_in,
      dout           => delay_j_m_i_eq_3_start_aggr_out
      );

  set_inputs_j_m_i_eq_3_start_aggr: process (
                              state_j_m_i_eq_3_start_aggr,
                              delay_wait_j_m_i_eq_3_start_aggr_out,
                              delay_j_m_i_eq_3_start_aggr_out
                              )
  begin

      delay_j_m_i_eq_3_start_aggr_in(0)           <= '0';

      ifsm_j_m_i_eq_3_start_aggr                  <= (others => '0');

      case state_j_m_i_eq_3_start_aggr is
        when idle =>
          if delay_wait_j_m_i_eq_3_start_aggr_out(0) = '1' then
            delay_j_m_i_eq_3_start_aggr_in(0)     <= '1';

            ifsm_j_m_i_eq_3_start_aggr(1)         <= '1';
          end if;

        when run =>
          if delay_j_m_i_eq_3_start_aggr_out(0) = '1' then
            delay_j_m_i_eq_3_start_aggr_in(0)     <= '1';

            ifsm_j_m_i_eq_3_start_aggr(1)         <= '1';
          end if;

      end case;

  end process set_inputs_j_m_i_eq_3_start_aggr;

  reg_inputs_j_m_i_eq_3_start_aggr: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        counter_j_m_i_eq_3_start_aggr <= (others => '0');
      else

        case state_j_m_i_eq_3_start_aggr is
          when idle =>
            if delay_wait_j_m_i_eq_3_start_aggr_out(0) = '1' then
              counter_j_m_i_eq_3_start_aggr <= conv_std_logic_vector(SEQ_LEN-4,
                                                 counter_j_m_i_eq_3_start_aggr'length);
            end if;

          when run =>
            if delay_j_m_i_eq_3_start_aggr_out(0) = '1' then
              counter_j_m_i_eq_3_start_aggr <= counter_j_m_i_eq_3_start_aggr - 1;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_j_m_i_eq_3_start_aggr;

end architecture top_level;
