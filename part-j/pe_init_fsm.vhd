
-- File: pe_init_fsm.vhd
-- Date: 14 January 2010
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
    X_i_j_1              : in  slv(CELL_WIDTH-1 downto 0);

    -- wait till pe_bottom is in state 0
    vj_eq_tile_width_j   : in  sl;

    -- array is busy
    wait_upstrm          : out sl;

    -- sequence characters: initialization input
    -- sequence character S_i, S_j
    init_seq             : out slv(1 to NO_PE_JP);
    initial_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
    initial_S_j          : out slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    start_aggr           : out slv(1 to NO_PE_JP);
                             -- start max aggregating along k axis
    init_pipe14          : out slv(1 to NO_PE_JP);
                             -- initialize pipelines 5 and 8
    j_m_i_2              : out slv(1 to NO_PE_JP);

    sequence_score       : out slv(31 downto 0);
    vld                  : out sl
  );
end entity pe_init_fsm;

architecture top_level of pe_init_fsm is

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

  type states_latency_t is (idle, pe_wait, preface, run);
  signal state_latency                  : states_latency_t;
  signal next_state_latency             : states_latency_t;
  signal counter_latency                : slv(15 downto 0);

  type states_seqdata_t is (idle, pe_wait, preface, run);
  signal state_seqdata                  : states_seqdata_t;
  signal next_state_seqdata             : states_seqdata_t;
  signal counter_seqdata                : slv(15 downto 0);

  type states_pipe14_t is (idle, pe_wait, preface, pause, run);
  signal state_pipe14                   : states_pipe14_t;
  signal next_state_pipe14              : states_pipe14_t;
  signal counter_pipe14                 : slv(15 downto 0);

  type states_j_m_i_2_start_aggr_t is (idle, pe_wait, preface, pause, run);
  signal state_j_m_i_2_start_aggr       : states_j_m_i_2_start_aggr_t;
  signal next_state_j_m_i_2_start_aggr  : states_j_m_i_2_start_aggr_t;
  signal counter_j_m_i_2_start_aggr     : slv(15 downto 0);

  type states_j_m_i_3_start_aggr_t is (idle, pe_wait, preface, pause, run);
  signal state_j_m_i_3_start_aggr       : states_j_m_i_3_start_aggr_t;
  signal next_state_j_m_i_3_start_aggr  : states_j_m_i_3_start_aggr_t;
  signal counter_j_m_i_3_start_aggr     : slv(15 downto 0);

  -- store sequence data internally
  signal int_seqdata                    : RESIDUE_ARRAY;

  signal reset_delays                   : sl;

  signal delay_init_seqdata_in          : slv(0 downto 0);
  signal delay_init_seqdata_out         : slv(0 downto 0);
  signal delay_switch_pe_seqdata_in     : slv(0 downto 0);
  signal delay_switch_pe_seqdata_out    : slv(0 downto 0);

  signal delay_j_m_i_2_in               : slv(0 downto 0);
  signal delay_j_m_i_2_out              : slv(0 downto 0);
  signal delay_pipe14_in                : slv(0 downto 0);
  signal delay_pipe14_out               : slv(0 downto 0);
  signal delay_switch_pe_pipe14_in      : slv(0 downto 0);
  signal delay_switch_pe_pipe14_out     : slv(0 downto 0);

  signal delay_wait_j_m_i_2_start_aggr_in       : slv(0 downto 0);
  signal delay_wait_j_m_i_2_start_aggr_out      : slv(0 downto 0);
  signal delay_j_m_i_2_start_aggr_in            : slv(0 downto 0);
  signal delay_j_m_i_2_start_aggr_out           : slv(0 downto 0);
  signal delay_switch_pe_j_m_i_2_start_aggr_in  : slv(0 downto 0);
  signal delay_switch_pe_j_m_i_2_start_aggr_out : slv(0 downto 0);

  signal delay_wait_j_m_i_3_start_aggr_in       : slv(0 downto 0);
  signal delay_wait_j_m_i_3_start_aggr_out      : slv(0 downto 0);
  signal delay_j_m_i_3_start_aggr_in            : slv(0 downto 0);
  signal delay_j_m_i_3_start_aggr_out           : slv(0 downto 0);
  signal delay_switch_pe_j_m_i_3_start_aggr_in  : slv(0 downto 0);
  signal delay_switch_pe_j_m_i_3_start_aggr_out : slv(0 downto 0);

  -- internal signals that need to be flopped to improve timing
  signal ifsm_init_seq                  : slv(0 to NO_PE_JP);
  signal ifsm_initial_S_i               : slv(RESIDUE_WIDTH-1 downto 0);
  signal ifsm_initial_S_j               : slv(RESIDUE_WIDTH-1 downto 0);
  signal ifsm_j_m_i_2_start_aggr        : slv(0 to NO_PE_JP);
  signal ifsm_j_m_i_3_start_aggr        : slv(0 to NO_PE_JP);
  signal ifsm_init_pipe14               : slv(0 to NO_PE_JP);
  signal ifsm_j_m_i_2                   : slv(0 to NO_PE_JP);

  signal int1_init_seq                  : slv(1 to NO_PE_JP);
  signal int1_initial_S_i               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int1_initial_S_j               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int1_start_aggr                : slv(1 to NO_PE_JP);
  signal int1_init_pipe14               : slv(1 to NO_PE_JP);
  signal int1_j_m_i_2                   : slv(1 to NO_PE_JP);

  signal int2_init_seq                  : slv(1 to NO_PE_JP);
  signal int2_initial_S_i               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int2_initial_S_j               : slv(RESIDUE_WIDTH-1 downto 0);
  signal int2_start_aggr                : slv(1 to NO_PE_JP);
  signal int2_init_pipe14               : slv(1 to NO_PE_JP);
  signal int2_j_m_i_2                   : slv(1 to NO_PE_JP);

begin

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  init_seq    <= int2_init_seq;
  initial_S_i <= int2_initial_S_i;
  initial_S_j <= int2_initial_S_j;
  start_aggr  <= int2_start_aggr;
  init_pipe14 <= int2_init_pipe14;
  j_m_i_2     <= int2_j_m_i_2;

  sequence_score <= ZEROES(31 downto CELL_WIDTH) & X_i_j_1;
--  sequence_score <= x"00000" & "000000" & X_i_j_1;
  vld            <= '1' when counter_latency = 0 else '0';

  -- register output signals to improve timing
  output_signals : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        int1_init_seq    <= (others => '0');
        int1_initial_S_i <= (others => '0');
        int1_initial_S_j <= (others => '0');
        int1_start_aggr  <= (others => '0');
        int1_init_pipe14 <= (others => '0');
        int1_j_m_i_2     <= (others => '0');

        int2_init_seq    <= (others => '0');
        int2_initial_S_i <= (others => '0');
        int2_initial_S_j <= (others => '0');
        int2_start_aggr  <= (others => '0');
        int2_init_pipe14 <= (others => '0');
        int2_j_m_i_2     <= (others => '0');
      else
        int1_init_seq    <= ifsm_init_seq(1 to NO_PE_JP);
        int1_initial_S_i <= ifsm_initial_S_i;
        int1_initial_S_j <= ifsm_initial_S_j;
        int1_start_aggr  <= ifsm_j_m_i_2_start_aggr(1 to NO_PE_JP) or
                              ifsm_j_m_i_3_start_aggr(1 to NO_PE_JP);
        int1_init_pipe14 <= ifsm_init_pipe14(1 to NO_PE_JP);
        int1_j_m_i_2     <= ifsm_j_m_i_2(1 to NO_PE_JP);

        int2_init_seq    <= int1_init_seq;
        int2_initial_S_i <= int1_initial_S_i;
        int2_initial_S_j <= int1_initial_S_j;
        int2_start_aggr  <= int1_start_aggr;
        int2_init_pipe14 <= int1_init_pipe14;
        int2_j_m_i_2     <= int1_j_m_i_2;
      end if;
    end if;
  end process output_signals;

  -----------------------------------------------------------------------------
  -- Count Latency
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_latency : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_latency <= idle;
      else
        state_latency <= next_state_latency;
      end if;
    end if;
  end process set_curr_state_latency;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_latency: process (state_latency, start, counter_latency,
                                   vj_eq_tile_width_j)
  begin 

    next_state_latency <= state_latency;

    case state_latency is
      when idle =>
        -- register input sequence data
        if start = '1' and vj_eq_tile_width_j = '1' then
          next_state_latency <= preface;
        elsif start = '1' then
          next_state_latency <= pe_wait;
        end if;

      when pe_wait =>
        if vj_eq_tile_width_j = '1' then
          next_state_latency <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_latency   <= run;

      when run => -- start computation in this state
        -- done sending input to all PEs
        if counter_latency = 0 then
          next_state_latency <= idle;
        end if;

    end case;
  end process set_next_state_latency;

  reg_inputs_latency: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        wait_upstrm     <= '0';

        counter_latency <= conv_std_logic_vector(
                                       TILE_WIDTH_J * (SEQ_LEN - 2) + 3,
                                       counter_latency'length
                                       );
      else
        wait_upstrm     <= '0';

        case state_latency is
          when idle =>
            if start = '1' then
              counter_latency <= conv_std_logic_vector(
                                       TILE_WIDTH_J * (SEQ_LEN - 2) + 3,
                                       counter_latency'length
                                       );

              wait_upstrm     <= '1';
            end if;

          when pe_wait =>
            wait_upstrm       <= '1';

          when preface =>
            wait_upstrm       <= '1';
            counter_latency   <= counter_latency - 1;

          when run =>
            wait_upstrm       <= '1';
            counter_latency   <= counter_latency - 1;

          when others =>
            null;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_latency;

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
  set_next_state_seqdata: process (state_seqdata, start, counter_seqdata,
                                   vj_eq_tile_width_j,
                                   delay_switch_pe_seqdata_out)
  begin 

    next_state_seqdata <= state_seqdata;

    reset_delays       <= '0';

    case state_seqdata is
      when idle =>
        if start = '1' then
          reset_delays    <= '1';
        end if;

        -- register input sequence data
        if start = '1' and vj_eq_tile_width_j = '1' then
          next_state_seqdata <= preface;
        elsif start = '1' then
          next_state_seqdata <= pe_wait;
        end if;

      when pe_wait =>
        if vj_eq_tile_width_j = '1' then
          next_state_seqdata <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_seqdata   <= run;

      when run => -- start computation in this state
        -- done sending input to all PEs
        if delay_switch_pe_seqdata_out(0) = '1' and counter_seqdata = 1 then
          next_state_seqdata <= idle;
        end if;

    end case;
  end process set_next_state_seqdata;

  -- every TILE_WIDTH_J-2 clock cycles we send a new sequence character
  -- along the anti diagonal
  delay_init_seqdata : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J-2, -- delay by TILE_WIDTH_J-2
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_init_seqdata_in,
      dout           => delay_init_seqdata_out
      );

  -- every X clock cycles we switch to the next PE
  delay_switch_pe_seqdata : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J*(TILE_WIDTH_J - 2),
        -- delay by TILE_WIDTH_J*TILE_WIDTH_J - 2*TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_switch_pe_seqdata_in,
      dout           => delay_switch_pe_seqdata_out
      );

  set_inputs_seqdata: process (state_seqdata, counter_seqdata,
                               int_seqdata,
                               delay_init_seqdata_out,
                               delay_switch_pe_seqdata_out)
  begin

      delay_init_seqdata_in(0)      <= '0';
      delay_switch_pe_seqdata_in(0) <= '0';

      ifsm_init_seq                 <= (others => '0');

      ifsm_initial_S_i              <= int_seqdata(SEQ_LEN-1);
      ifsm_initial_S_j              <= int_seqdata(SEQ_LEN);

      case state_seqdata is
        when idle =>
          null;

        when pe_wait =>
          null;

        when preface =>
          delay_init_seqdata_in(0)                     <= '1';
          delay_switch_pe_seqdata_in(0)                <= '1';

          -- send control to the correct PE
          ifsm_init_seq(conv_integer(counter_seqdata)) <= '1';

        when run =>
          if delay_init_seqdata_out(0) = '1' then
            -- ready to send sequence character to PE # "counter"
            delay_init_seqdata_in(0) <= '1';

            if delay_switch_pe_seqdata_out(0) = '1' then
              -- send control to the correct PE
              ifsm_init_seq(conv_integer(counter_seqdata - 1)) <= '1';
            else
              -- send control to the correct PE
              ifsm_init_seq(conv_integer(counter_seqdata))     <= '1';
            end if;
          end if;

          if delay_switch_pe_seqdata_out(0) = '1' then
            -- ready to switch to next PE
            delay_switch_pe_seqdata_in(0) <= '1';
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
              int_seqdata      <= sequence;

              -- start by sending sequence data to the last PE
              counter_seqdata  <= conv_std_logic_vector(NO_PE_JP,
                                       counter_seqdata'length);
            end if;

          when pe_wait =>
            null;

          when preface =>
            -- switch to next sequence character to send
            -- shift by 1 character
            for i in 2 to NO_RESIDUES loop
              int_seqdata(i) <= int_seqdata(i-1);
            end loop;

          when run =>
            if delay_init_seqdata_out(0) = '1' then
              -- switch to next sequence character to send
              -- shift by 1 character
              for i in 2 to NO_RESIDUES loop
                int_seqdata(i) <= int_seqdata(i-1);
              end loop;
            end if;

            if delay_switch_pe_seqdata_out(0) = '1' then
              counter_seqdata  <= counter_seqdata - 1;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_seqdata;

  -----------------------------------------------------------------------------
  -- Handle control input for init_pipe14
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_pipe14: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_pipe14 <= idle;
      else
        state_pipe14 <= next_state_pipe14;
      end if;
    end if;
  end process set_curr_state_pipe14;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_pipe14: process (state_pipe14, start, vj_eq_tile_width_j,
                                  delay_j_m_i_2_out, counter_pipe14,
                                  delay_switch_pe_pipe14_out)
  begin 

    next_state_pipe14 <= state_pipe14;

    case state_pipe14 is
      when idle =>
        -- register input sequence data
        if start = '1' and vj_eq_tile_width_j = '1' then
          next_state_pipe14 <= preface;
        elsif start = '1' then
          next_state_pipe14 <= pe_wait;
        end if;

      when pe_wait =>
        if vj_eq_tile_width_j = '1' then
          next_state_pipe14 <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_pipe14   <= pause;

      when pause =>
        if delay_j_m_i_2_out(0) = '1' then
          next_state_pipe14 <= run;
        end if;

      when run => -- start computation in this state
        -- done sending control to all PEs
        if delay_switch_pe_pipe14_out(0) = '1' and counter_pipe14 = 1 then
          next_state_pipe14 <= idle;
        end if;

    end case;
  end process set_next_state_pipe14;

  -- notify when we're processing the first cell of j - i = 2 anti-diagonal
  -- one cycle delay is in the input flop
  delay_j_m_i_2 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J,    -- delay by TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_j_m_i_2_in,
      dout           => delay_j_m_i_2_out
      );

  -- every TILE_WIDTH_J-2 clock cycles we send a control signal
  -- along the anti diagonal
  delay_pipe14 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J-2, -- delay by TILE_WIDTH_J-2
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_pipe14_in,
      dout           => delay_pipe14_out
      );

  -- every TILE_WIDTH_J - 2 clock cycles we switch to the next PE
  delay_switch_pe_pipe14 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J*(TILE_WIDTH_J - 2),
        -- delay by TILE_WIDTH_J*TILE_WIDTH_J - 2*TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_switch_pe_pipe14_in,
      dout           => delay_switch_pe_pipe14_out
      );

  set_inputs_pipe14: process (state_pipe14, counter_pipe14,
                              delay_j_m_i_2_out, delay_pipe14_out,
                              delay_switch_pe_pipe14_out)
  begin

      delay_j_m_i_2_in(0)          <= '0';
      delay_pipe14_in(0)           <= '0';
      delay_switch_pe_pipe14_in(0) <= '0';

      ifsm_init_pipe14             <= (others => '0');
      ifsm_j_m_i_2                 <= (others => '0');

      case state_pipe14 is
        when idle =>
          null;

        when pe_wait =>
          null;

        when preface =>
          delay_j_m_i_2_in(0) <= '1';

        when pause =>
          if delay_j_m_i_2_out(0) = '1' then
            -- send control to the correct PE
            ifsm_init_pipe14(conv_integer(counter_pipe14)) <= '1';
            ifsm_j_m_i_2(conv_integer(counter_pipe14))     <= '1';

            delay_pipe14_in(0)                             <= '1';
            delay_switch_pe_pipe14_in(0)                   <= '1';
          end if;

        when run =>
          if delay_pipe14_out(0) = '1' then
            -- ready to send control signal to PE # "counter"
            delay_pipe14_in(0) <= '1';

            if delay_switch_pe_pipe14_out(0) = '1' then
              -- send control to the correct PE
              ifsm_init_pipe14(conv_integer(counter_pipe14 - 1)) <= '1';
              ifsm_j_m_i_2(conv_integer(counter_pipe14 - 1))     <= '1';
            else
              -- send control to the correct PE
              ifsm_init_pipe14(conv_integer(counter_pipe14))     <= '1';
              ifsm_j_m_i_2(conv_integer(counter_pipe14))         <= '1';
            end if;
          end if;

          if delay_switch_pe_pipe14_out(0) = '1' then
            -- ready to switch to next PE
            delay_switch_pe_pipe14_in(0) <= '1';
          end if;

      end case;

  end process set_inputs_pipe14;

  reg_inputs_pipe14: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        counter_pipe14 <= (others => '0');
      else

        case state_pipe14 is
          when idle =>
            if start = '1' then
              counter_pipe14 <= conv_std_logic_vector(NO_PE_JP,
                                       counter_pipe14'length);
            end if;

          when pe_wait =>
            null;

          when preface =>
            null;

          when pause =>
            null;

          when run =>
            if delay_switch_pe_pipe14_out(0) = '1' then
              counter_pipe14 <= counter_pipe14 - 1;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_pipe14;

  -----------------------------------------------------------------------------
  -- Handle control input for start_aggr at j - i = 2
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_j_m_i_2_start_aggr: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_j_m_i_2_start_aggr <= idle;
      else
        state_j_m_i_2_start_aggr <= next_state_j_m_i_2_start_aggr;
      end if;
    end if;
  end process set_curr_state_j_m_i_2_start_aggr;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_j_m_i_2_start_aggr: process (
                                      state_j_m_i_2_start_aggr, start,
                                      vj_eq_tile_width_j,
                                      delay_wait_j_m_i_2_start_aggr_out,
                                      delay_switch_pe_j_m_i_2_start_aggr_out,
                                      counter_j_m_i_2_start_aggr
                                      )
  begin

    next_state_j_m_i_2_start_aggr <= state_j_m_i_2_start_aggr;

    case state_j_m_i_2_start_aggr is
      when idle =>
        -- register input sequence data
        if start = '1' and vj_eq_tile_width_j = '1' then
          next_state_j_m_i_2_start_aggr <= preface;
        elsif start = '1' then
          next_state_j_m_i_2_start_aggr <= pe_wait;
        end if;

      when pe_wait =>
        if vj_eq_tile_width_j = '1' then
          next_state_j_m_i_2_start_aggr <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_j_m_i_2_start_aggr   <= pause;

      when pause =>
        if delay_wait_j_m_i_2_start_aggr_out(0) = '1' then
          next_state_j_m_i_2_start_aggr <= run;
        end if;

      when run => -- start computation in this state
        -- done sending control to all PEs
        if delay_switch_pe_j_m_i_2_start_aggr_out(0) = '1' and
           counter_j_m_i_2_start_aggr = 1 then
          next_state_j_m_i_2_start_aggr <= idle;
        end if;

    end case;
  end process set_next_state_j_m_i_2_start_aggr;

  -- notify when we're processing the first cell of j - i = 2 anti-diagonal
  -- one cycle delay is in the input flop
  delay_wait_j_m_i_2_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J,    -- delay by TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_wait_j_m_i_2_start_aggr_in,
      dout           => delay_wait_j_m_i_2_start_aggr_out
      );

  -- every TILE_WIDTH_J-2 clock cycles we send a control signal
  -- along the anti diagonal
  delay_j_m_i_2_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J-2, -- delay by TILE_WIDTH_J-2
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_j_m_i_2_start_aggr_in,
      dout           => delay_j_m_i_2_start_aggr_out
      );

  -- every TILE_WIDTH_J - 2 clock cycles we switch to the next PE
  delay_switch_pe_j_m_i_2_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J*(TILE_WIDTH_J - 2),
        -- delay by TILE_WIDTH_J*TILE_WIDTH_J - 2*TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_switch_pe_j_m_i_2_start_aggr_in,
      dout           => delay_switch_pe_j_m_i_2_start_aggr_out
      );

  set_inputs_j_m_i_2_start_aggr: process (state_j_m_i_2_start_aggr,
                              counter_j_m_i_2_start_aggr,
                              delay_wait_j_m_i_2_start_aggr_out,
                              delay_j_m_i_2_start_aggr_out,
                              delay_switch_pe_j_m_i_2_start_aggr_out)
  begin

      delay_wait_j_m_i_2_start_aggr_in(0)      <= '0';
      delay_j_m_i_2_start_aggr_in(0)           <= '0';
      delay_switch_pe_j_m_i_2_start_aggr_in(0) <= '0';

      ifsm_j_m_i_2_start_aggr                  <= (others => '0');

      case state_j_m_i_2_start_aggr is
        when idle =>
          null;

        when pe_wait =>
          null;

        when preface =>
          delay_wait_j_m_i_2_start_aggr_in(0)  <= '1';

        when pause =>
          if delay_wait_j_m_i_2_start_aggr_out(0) = '1' then
            -- send control to the correct PE
            ifsm_j_m_i_2_start_aggr(
              conv_integer(counter_j_m_i_2_start_aggr)) <= '1';

            delay_j_m_i_2_start_aggr_in(0)              <= '1';
            delay_switch_pe_j_m_i_2_start_aggr_in(0)    <= '1';
          end if;

        when run =>
          if delay_j_m_i_2_start_aggr_out(0) = '1' then
            -- ready to send control signal to PE # "counter"
            delay_j_m_i_2_start_aggr_in(0) <= '1';

            if delay_switch_pe_j_m_i_2_start_aggr_out(0) = '1' then
              -- send control to the correct PE
              ifsm_j_m_i_2_start_aggr(
                conv_integer(counter_j_m_i_2_start_aggr - 1)) <= '1';
            else
              -- send control to the correct PE
              ifsm_j_m_i_2_start_aggr(
                conv_integer(counter_j_m_i_2_start_aggr))     <= '1';
            end if;
          end if;

          if delay_switch_pe_j_m_i_2_start_aggr_out(0) = '1' then
            -- ready to switch to next PE
            delay_switch_pe_j_m_i_2_start_aggr_in(0) <= '1';
          end if;

      end case;

  end process set_inputs_j_m_i_2_start_aggr;

  reg_inputs_j_m_i_2_start_aggr: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        counter_j_m_i_2_start_aggr <= (others => '0');
      else

        case state_j_m_i_2_start_aggr is
          when idle =>
            if start = '1' then
              counter_j_m_i_2_start_aggr <= conv_std_logic_vector(NO_PE_JP,
                                            counter_j_m_i_2_start_aggr'length);
            end if;

          when pe_wait =>
            null;

          when preface =>
            null;

          when pause =>
            null;

          when run =>
            if delay_switch_pe_j_m_i_2_start_aggr_out(0) = '1' then
              counter_j_m_i_2_start_aggr <= counter_j_m_i_2_start_aggr - 1;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_j_m_i_2_start_aggr;

  -----------------------------------------------------------------------------
  -- Handle control input for start_aggr at j - i = 3
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state_j_m_i_3_start_aggr: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_j_m_i_3_start_aggr <= idle;
      else
        state_j_m_i_3_start_aggr <= next_state_j_m_i_3_start_aggr;
      end if;
    end if;
  end process set_curr_state_j_m_i_3_start_aggr;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state_j_m_i_3_start_aggr: process (
                                      state_j_m_i_3_start_aggr, start,
                                      vj_eq_tile_width_j,
                                      delay_wait_j_m_i_3_start_aggr_out,
                                      delay_switch_pe_j_m_i_3_start_aggr_out,
                                      counter_j_m_i_3_start_aggr
                                      )
  begin

    next_state_j_m_i_3_start_aggr <= state_j_m_i_3_start_aggr;

    case state_j_m_i_3_start_aggr is
      when idle =>
        -- register input sequence data
        if start = '1' and vj_eq_tile_width_j = '1' then
          next_state_j_m_i_3_start_aggr <= preface;
        elsif start = '1' then
          next_state_j_m_i_3_start_aggr <= pe_wait;
        end if;

      when pe_wait =>
        if vj_eq_tile_width_j = '1' then
          next_state_j_m_i_3_start_aggr <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_j_m_i_3_start_aggr   <= pause;

      when pause =>
        if delay_wait_j_m_i_3_start_aggr_out(0) = '1' then
          next_state_j_m_i_3_start_aggr <= run;
        end if;

      when run => -- start computation in this state
        -- done sending control to all PEs
        if delay_switch_pe_j_m_i_3_start_aggr_out(0) = '1' and
           counter_j_m_i_3_start_aggr = 1 then
          next_state_j_m_i_3_start_aggr <= idle;
        end if;

    end case;
  end process set_next_state_j_m_i_3_start_aggr;

  -- notify when we're processing the first cell of j - i = 3 anti-diagonal
  -- one cycle delay is in the input flop
  delay_wait_j_m_i_3_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => 2*TILE_WIDTH_J,    -- delay by 2*TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_wait_j_m_i_3_start_aggr_in,
      dout           => delay_wait_j_m_i_3_start_aggr_out
      );

  -- every TILE_WIDTH_J-2 clock cycles we send a control signal
  -- along the anti diagonal
  delay_j_m_i_3_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J-2, -- delay by TILE_WIDTH_J-2
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_j_m_i_3_start_aggr_in,
      dout           => delay_j_m_i_3_start_aggr_out
      );

  -- every TILE_WIDTH_J - 2 clock cycles we switch to the next PE
  delay_switch_pe_j_m_i_3_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => TILE_WIDTH_J*(TILE_WIDTH_J - 2),
        -- delay by TILE_WIDTH_J*TILE_WIDTH_J - 2*TILE_WIDTH_J
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset_delays,
      din            => delay_switch_pe_j_m_i_3_start_aggr_in,
      dout           => delay_switch_pe_j_m_i_3_start_aggr_out
      );

  set_inputs_j_m_i_3_start_aggr: process (state_j_m_i_3_start_aggr,
                              counter_j_m_i_3_start_aggr,
                              delay_wait_j_m_i_3_start_aggr_out,
                              delay_j_m_i_3_start_aggr_out,
                              delay_switch_pe_j_m_i_3_start_aggr_out)
  begin

      delay_wait_j_m_i_3_start_aggr_in(0)      <= '0';
      delay_j_m_i_3_start_aggr_in(0)           <= '0';
      delay_switch_pe_j_m_i_3_start_aggr_in(0) <= '0';

      ifsm_j_m_i_3_start_aggr                  <= (others => '0');

      case state_j_m_i_3_start_aggr is
        when idle =>
          null;

        when pe_wait =>
          null;

        when preface =>
          delay_wait_j_m_i_3_start_aggr_in(0)  <= '1';

        when pause =>
          if delay_wait_j_m_i_3_start_aggr_out(0) = '1' then
            -- send control to the correct PE
            ifsm_j_m_i_3_start_aggr(
              conv_integer(counter_j_m_i_3_start_aggr)) <= '1';

            delay_j_m_i_3_start_aggr_in(0)              <= '1';
            delay_switch_pe_j_m_i_3_start_aggr_in(0)    <= '1';
          end if;

        when run =>
          if delay_j_m_i_3_start_aggr_out(0) = '1' then
            -- ready to send control signal to PE # "counter"
            delay_j_m_i_3_start_aggr_in(0) <= '1';

            if delay_switch_pe_j_m_i_3_start_aggr_out(0) = '1' then
              -- send control to the correct PE
              ifsm_j_m_i_3_start_aggr(
                conv_integer(counter_j_m_i_3_start_aggr - 1)) <= '1';
            else
              -- send control to the correct PE
              ifsm_j_m_i_3_start_aggr(
                conv_integer(counter_j_m_i_3_start_aggr))     <= '1';
            end if;
          end if;

          if delay_switch_pe_j_m_i_3_start_aggr_out(0) = '1' then
            -- ready to switch to next PE
            delay_switch_pe_j_m_i_3_start_aggr_in(0) <= '1';
          end if;

      end case;

  end process set_inputs_j_m_i_3_start_aggr;

  reg_inputs_j_m_i_3_start_aggr: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        counter_j_m_i_3_start_aggr <= (others => '0');
      else

        case state_j_m_i_3_start_aggr is
          when idle =>
            if start = '1' then
              counter_j_m_i_3_start_aggr <= conv_std_logic_vector(NO_PE_JP,
                                            counter_j_m_i_3_start_aggr'length);
            end if;

          when pe_wait =>
            null;

          when preface =>
            null;

          when pause =>
            null;

          when run =>
            if delay_switch_pe_j_m_i_3_start_aggr_out(0) = '1' then
              counter_j_m_i_3_start_aggr <= counter_j_m_i_3_start_aggr - 1;
            end if;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_j_m_i_3_start_aggr;

end architecture top_level;
