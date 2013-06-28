
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
    init_seq             : out slv(1 to SEQ_LEN);
    initial_S_i          : out RESIDUE_ARRAY;
    initial_S_j          : out RESIDUE_ARRAY;

    -- input control signals
    start_aggr           : out slv(1 to SEQ_LEN);
                             -- start max aggregating along k axis
    init_pipe58          : out slv(1 to SEQ_LEN);
                             -- initialize pipelines 5 and 8
    j_m_i_eq_1           : out slv(1 to SEQ_LEN);
    j_m_i_eq_2           : out slv(1 to SEQ_LEN);

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

  type states_latency_t is (idle, run);
  signal state_latency                  : states_latency_t;
  signal next_state_latency             : states_latency_t;
  signal counter_latency                : slv(15 downto 0);

  type states_seqdata_t is (idle, run);
  signal state_seqdata                  : states_seqdata_t;
  signal next_state_seqdata             : states_seqdata_t;

  type states_pipe58_t is (idle, preface, run);
  signal state_pipe58                   : states_pipe58_t;
  signal next_state_pipe58              : states_pipe58_t;

  type states_j_m_i_eq_3_start_aggr_t is (idle, preface, run);
  signal state_j_m_i_eq_3_start_aggr      : states_j_m_i_eq_3_start_aggr_t;
  signal next_state_j_m_i_eq_3_start_aggr : states_j_m_i_eq_3_start_aggr_t;

  -- store sequence data internally
  signal int_seqdata                    : RESIDUE_ARRAY;

  signal delay_j_m_i_eq_2_in            : slv(0 downto 0);
  signal delay_j_m_i_eq_2_out           : slv(0 downto 0);

  signal delay_wait_j_m_i_eq_3_start_aggr_in  : slv(0 downto 0);
  signal delay_wait_j_m_i_eq_3_start_aggr_out : slv(0 downto 0);

  -- internal signals that need to be flopped to improve timing
  signal ifsm_init_seq                  : slv(1 to SEQ_LEN);
  signal ifsm_initial_S_i               : RESIDUE_ARRAY;
  signal ifsm_initial_S_j               : RESIDUE_ARRAY;

  signal ifsm_j_m_i_eq_1                : slv(1 to SEQ_LEN);
  signal ifsm_j_m_i_eq_2                : slv(1 to SEQ_LEN);

  signal ifsm_j_m_i_eq_2_start_aggr     : slv(1 to SEQ_LEN);
  signal ifsm_j_m_i_eq_3_start_aggr     : slv(1 to SEQ_LEN);
  signal ifsm_init_pipe58               : slv(1 to SEQ_LEN);


  signal int1_init_seq                  : slv(1 to SEQ_LEN);
  signal int1_initial_S_i               : RESIDUE_ARRAY;
  signal int1_initial_S_j               : RESIDUE_ARRAY;
  signal int1_start_aggr                : slv(1 to SEQ_LEN);
  signal int1_init_pipe58               : slv(1 to SEQ_LEN);
  signal int1_j_m_i_eq_1                : slv(1 to SEQ_LEN);
  signal int1_j_m_i_eq_2                : slv(1 to SEQ_LEN);

  signal int2_init_seq                  : slv(1 to SEQ_LEN);
  signal int2_initial_S_i               : RESIDUE_ARRAY;
  signal int2_initial_S_j               : RESIDUE_ARRAY;
  signal int2_start_aggr                : slv(1 to SEQ_LEN);
  signal int2_init_pipe58               : slv(1 to SEQ_LEN);
  signal int2_j_m_i_eq_1                : slv(1 to SEQ_LEN);
  signal int2_j_m_i_eq_2                : slv(1 to SEQ_LEN);

begin

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  init_seq    <= int2_init_seq;
  initial_S_i <= int2_initial_S_i;
  initial_S_j <= int2_initial_S_j;
  start_aggr  <= int2_start_aggr;
  init_pipe58 <= int2_init_pipe58;
  j_m_i_eq_1  <= int2_j_m_i_eq_1;
  j_m_i_eq_2  <= int2_j_m_i_eq_2;

  sequence_score <= x"000" & "0000" & X_i_j_k;
  vld            <= '1' when counter_latency = 0 else '0';

  -- register output signals to improve timing
  output_signals : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        int1_init_seq    <= (others => '0');
        int1_initial_S_i <= (others => (others => '0'));
        int1_initial_S_j <= (others => (others => '0'));
        int1_start_aggr  <= (others => '0');
        int1_init_pipe58 <= (others => '0');
        int1_j_m_i_eq_1  <= (others => '0');
        int1_j_m_i_eq_2  <= (others => '0');

        int2_init_seq    <= (others => '0');
        int2_initial_S_i <= (others => (others => '0'));
        int2_initial_S_j <= (others => (others => '0'));
        int2_start_aggr  <= (others => '0');
        int2_init_pipe58 <= (others => '0');
        int2_j_m_i_eq_1  <= (others => '0');
        int2_j_m_i_eq_2  <= (others => '0');
      else
        int1_init_seq    <= ifsm_init_seq;
        int1_initial_S_i <= ifsm_initial_S_i;
        int1_initial_S_j <= ifsm_initial_S_j;
        int1_start_aggr  <= ifsm_j_m_i_eq_2_start_aggr or
                              ifsm_j_m_i_eq_3_start_aggr;
        int1_init_pipe58 <= ifsm_init_pipe58;
        int1_j_m_i_eq_1  <= ifsm_j_m_i_eq_1;
        int1_j_m_i_eq_2  <= ifsm_j_m_i_eq_2;

        int2_init_seq    <= int1_init_seq;
        int2_initial_S_i <= int1_initial_S_i;
        int2_initial_S_j <= int1_initial_S_j;
        int2_start_aggr  <= int1_start_aggr;
        int2_init_pipe58 <= int1_init_pipe58;
        int2_j_m_i_eq_1  <= int1_j_m_i_eq_1;
        int2_j_m_i_eq_2  <= int1_j_m_i_eq_2;
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
  set_next_state_latency: process (state_latency, start, counter_latency)
  begin 

    next_state_latency <= state_latency;

    case state_latency is
      when idle =>
        -- register input sequence data
        if start = '1' then
          next_state_latency <= run;
        end if;

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
                                       ARRAY_LATENCY + 1,
                                       counter_latency'length
                                       );
      else

        wait_upstrm     <= '0';

        case state_latency is
          when idle =>
            if start = '1' then
              counter_latency <= conv_std_logic_vector(
                                       ARRAY_LATENCY + 1,
                                       counter_latency'length
                                       );

              wait_upstrm     <= '1';
            end if;

          when run =>
            wait_upstrm       <= '1';
            counter_latency   <= counter_latency - 1;

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
  set_next_state_seqdata: process (state_seqdata, start)
  begin 

    next_state_seqdata <= state_seqdata;

    case state_seqdata is
      when idle =>
        -- register input sequence data
        if start = '1' then
          next_state_seqdata <= run;
        end if;

      when run =>
        next_state_seqdata   <= idle;

    end case;
  end process set_next_state_seqdata;

  set_inputs_seqdata: process (state_seqdata, int_seqdata)
  begin

      ifsm_init_seq                 <= (others => '0');
      ifsm_j_m_i_eq_1               <= (others => '0');

      for j in 2 to SEQ_LEN loop
        ifsm_initial_S_j(j)         <= int_seqdata(j);
        ifsm_initial_S_i(j)         <= int_seqdata(j-1);
      end loop;

      case state_seqdata is
        when idle =>
          null;

        when run =>
          ifsm_init_seq             <= (others => '1');
          ifsm_j_m_i_eq_1           <= (others => '1');

      end case;

  end process set_inputs_seqdata;

  reg_inputs_seqdata: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        int_seqdata                   <= (others => (others => '0'));
      else

        case state_seqdata is
          when idle =>
            -- register the new RNA
            if start = '1' then
              int_seqdata             <= sequence;
            end if;

          when others =>
            null;

        end case;
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs_seqdata;

  -----------------------------------------------------------------------------
  -- Handle control input for init_pipe58
  -- Handle control input for start_aggr at j - i = 2
  -- Handle control input for j - i = 2
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
  set_next_state_pipe58: process (state_pipe58, start, delay_j_m_i_eq_2_out)
  begin 

    next_state_pipe58 <= state_pipe58;

    case state_pipe58 is
      when idle =>
        -- register input sequence data
        if start = '1' then
          next_state_pipe58 <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_pipe58   <= run;

      when run =>
        if delay_j_m_i_eq_2_out(0) = '1' then
          next_state_pipe58 <= idle;
        end if;

    end case;
  end process set_next_state_pipe58;

  -- notify when we're processing the first cell of j - i = 2 anti-diagonal
  -- one cycle delay is in the input flop
  delay_j_m_i_eq_2 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => 2,    -- delay by 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_j_m_i_eq_2_in,
      dout           => delay_j_m_i_eq_2_out
      );

  set_inputs_pipe58: process (state_pipe58, delay_j_m_i_eq_2_out)
  begin

      delay_j_m_i_eq_2_in(0)       <= '0';

      ifsm_init_pipe58             <= (others => '0');
      ifsm_j_m_i_eq_2              <= (others => '0');

      ifsm_j_m_i_eq_2_start_aggr   <= (others => '0');

      case state_pipe58 is
        when idle =>
          null;

        when preface =>
          delay_j_m_i_eq_2_in(0) <= '1';

        when run =>
          if delay_j_m_i_eq_2_out(0) = '1' then
            -- send control
            ifsm_init_pipe58           <= (others => '1');
            ifsm_j_m_i_eq_2            <= (others => '1');

            ifsm_j_m_i_eq_2_start_aggr <= (others => '1');
          end if;

      end case;

  end process set_inputs_pipe58;

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
                                      state_j_m_i_eq_3_start_aggr, start,
                                      delay_wait_j_m_i_eq_3_start_aggr_out
                                      )
  begin

    next_state_j_m_i_eq_3_start_aggr <= state_j_m_i_eq_3_start_aggr;

    case state_j_m_i_eq_3_start_aggr is
      when idle =>
        -- register input sequence data
        if start = '1' then
          next_state_j_m_i_eq_3_start_aggr <= preface;
        end if;

      when preface =>
        -- prepare controls
        next_state_j_m_i_eq_3_start_aggr   <= run;

      when run =>
        if delay_wait_j_m_i_eq_3_start_aggr_out(0) = '1' then
          next_state_j_m_i_eq_3_start_aggr <= idle;
        end if;

    end case;
  end process set_next_state_j_m_i_eq_3_start_aggr;

  -- notify when we're processing the first cell of j - i = 3 anti-diagonal
  -- one cycle delay is in the input flop
  delay_wait_j_m_i_eq_3_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => 4,    -- delay by 4
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => delay_wait_j_m_i_eq_3_start_aggr_in,
      dout           => delay_wait_j_m_i_eq_3_start_aggr_out
      );

  set_inputs_j_m_i_eq_3_start_aggr: process (
                              state_j_m_i_eq_3_start_aggr,
                              delay_wait_j_m_i_eq_3_start_aggr_out
                              )
  begin

      delay_wait_j_m_i_eq_3_start_aggr_in(0)      <= '0';

      ifsm_j_m_i_eq_3_start_aggr                  <= (others => '0');

      case state_j_m_i_eq_3_start_aggr is
        when idle =>
          null;

        when preface =>
          delay_wait_j_m_i_eq_3_start_aggr_in(0)  <= '1';

        when run =>
          if delay_wait_j_m_i_eq_3_start_aggr_out(0) = '1' then
            ifsm_j_m_i_eq_3_start_aggr            <= (others => '1');
          end if;

      end case;

  end process set_inputs_j_m_i_eq_3_start_aggr;

end architecture top_level;
