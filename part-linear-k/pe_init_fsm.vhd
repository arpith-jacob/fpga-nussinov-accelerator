
-- File: pe_init_fsm.vhd
-- Date: 10 October 2009
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
    clk                     : in  sl;
    reset                   : in  sl;

    -- INPUTS
    isequence               : in  RESIDUE_ARRAY;
    istart                  : in  sl;

    -- bottom pe X score
    iX_i_j_1_1              : in  slv(CELL_WIDTH-1 downto 0);

    -- array is busy
    wait_upstrm             : out sl;

    --
    -- INITIALIZATION
    --
    -- X(i+1, j, vk, k')
    init_X_ip1_j_vk_kp      : out sl;
    initial_X_ip1_j_vk_kp   : out slv(CELL_WIDTH-1 downto 0);
    -- X(i, j-1, vk, k')
    init_X_i_jm1_vk_kp      : out sl;
    initial_X_i_jm1_vk_kp   : out slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, vk, k')
    init_X_ip1_jm1_vk_kp    : out sl;
    initial_X_ip1_jm1_vk_kp : out slv(CELL_WIDTH-1 downto 0);
    -- X(i+2, j, vk, k')
    init_X_ip2_j_vk_kp      : out sl;
    initial_X_ip2_j_vk_kp   : out slv(CELL_WIDTH-1 downto 0);

    -- sequence characters: initialization input
    -- sequence character S_i
    init_S_i                : out sl;
    initial_S_i             : out slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    init_S_j                : out sl;
    initial_S_j             : out slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    start_aggr              : out sl;
                             -- start max aggregating along k axis
    init_pipe14             : out sl;
                             -- initialize pipelines 5 and 8

    osequence_score         : out slv(31 downto 0);
    ovld                    : out sl
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

  type input_states is (idle, preface, run, epilogue);

  signal state                        : input_states;
  signal next_state                   : input_states;

  -----------------------------------------------------------------------------
  -- State of processing element
  -----------------------------------------------------------------------------
  signal state_counter                  : slv(15 downto 0);
  signal vk_eq_2                        : sl;

  -- store sequence data internally
  signal int_seqdata                  : RESIDUE_ARRAY;

  -- count up to N, the sequence length
  signal counter                      : slv(15 downto 0);

  -- count indices of the loop
  -- used for control pipeline initialization
  signal index_i                      : slv(15 downto 0);
  signal index_j                      : slv(15 downto 0);
  signal index_k                      : slv(15 downto 0);
  signal diff_j_i                     : slv(15 downto 0);

  signal border_init_in               : slv(0 downto 0);
  signal border_init_out              : slv(0 downto 0);
  signal border2_init_out             : slv(0 downto 0);

  -- valid signal to track score
  signal score_vld                    : slv( ((SEQ_LEN - 4)*TILE_WIDTH_K) downto 0);
  signal score_high                   : sl;

  -- wait upstream signals
  signal wait_upstrm_int              : sl;

  -- initial values
  -- xor values of adjacent sequence residues (for initialization)
  signal seqdata_xor                  : RESIDUE_ARRAY;

  type PE_INIT_ARRAY is array (1 to SEQ_LEN) of slv(CELL_WIDTH-1 downto 0);
  signal X_diag_2                     : PE_INIT_ARRAY;

  -- internal output signals
  signal ifsm_init_X_ip1_j_vk_kp      : sl;
  signal ifsm_initial_X_ip1_j_vk_kp   : slv(CELL_WIDTH-1 downto 0);
  signal ifsm_init_X_i_jm1_vk_kp      : sl;
  signal ifsm_initial_X_i_jm1_vk_kp   : slv(CELL_WIDTH-1 downto 0);
  signal ifsm_init_X_ip1_jm1_vk_kp    : sl;
  signal ifsm_initial_X_ip1_jm1_vk_kp : slv(CELL_WIDTH-1 downto 0);
  signal ifsm_init_X_ip2_j_vk_kp      : sl;
  signal ifsm_initial_X_ip2_j_vk_kp   : slv(CELL_WIDTH-1 downto 0);

  signal ifsm_init_S_i                : sl;
  signal ifsm_initial_S_i             : slv(RESIDUE_WIDTH-1 downto 0);
  signal ifsm_init_S_j                : sl;
  signal ifsm_initial_S_j             : slv(RESIDUE_WIDTH-1 downto 0);

  signal ifsm_start_aggr              : sl;
  signal ifsm_init_pipe14             : sl;

begin

  -- TODO: fixme
  wait_upstrm   <= '1' when score_vld /= 0 else wait_upstrm_int;

  -- control pipeline for j - i = 2 condition.
  -- we need to initialize a border PE on j - i = 2 line every
  -- N-2 clocks, when the schedule is Nj - 2i - k.
  delay_init_border : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => -SCHEDULE(-1, -1, 0, 0),
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => border_init_in,
      dout           => border_init_out
      );

  -- control pipeline for j - i = 3 condition.
  -- we need to initialize a border PE on j - i = 3 line.
  -- according to the schedule, this is two clocks after the j - i = 2.
  delay_init_border2 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => -SCHEDULE(1, 0, 0, 0),
      NEEDS_RESET    => true,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => border_init_out,
      dout           => border2_init_out
      );

  -- X(i)(i + 1) = delta(), 1 <= i <= N
  -- each point is initialized to 0 or 1
  init_X_diag_2 : for j in 2 to SEQ_LEN
    generate
      seqdata_xor(j)      <= int_seqdata(j - 1) xor int_seqdata(j);
      
      X_diag_2(j)(CELL_WIDTH-1 downto 1) <= (others => '0');
      X_diag_2(j)(0) <= not (int_seqdata(j - 1)(2) or int_seqdata(j)(2))
                        when seqdata_xor(j)(1 downto 0) = "11"
                        else '0';
    end generate;

  -----------------------------------------------------------------------------
  -- Compute state of PE
  -----------------------------------------------------------------------------

  gen_state : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_counter            <= conv_std_logic_vector(RESET_STATE,
                                                          state_counter'length);

        vk_eq_2                  <= '0';
      else
        state_counter            <= state_counter - 1;

        if state_counter = 1 then
          state_counter          <= conv_std_logic_vector(TILE_WIDTH_K,
                                                          state_counter'length);
        end if;

        -- v_k = 2.
        if state_counter = 3 then  -- next clock has v_k = 2
          vk_eq_2                <= '1';
        else
          vk_eq_2                <= '0';
        end if;
      end if;
    end if;  -- end rising_edge
  end process gen_state;

  -----------------------------------------------------------------------------
  -- Input FSM state assignment
  -----------------------------------------------------------------------------
  set_curr_state: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state <= idle;
      else
        state <= next_state;
      end if;
    end if;
  end process set_curr_state;

  -----------------------------------------------------------------------------
  -- Input FSM state transition process
  -----------------------------------------------------------------------------
  set_next_state: process (state, istart, counter, vk_eq_2,
                           index_i, index_j, index_k)
  begin 
    next_state <= state;

    case state is
      when idle =>
        if istart = '1' then
          next_state <= preface;
        end if;

      when preface =>
        -- we want to start when pe_bottom is at vk = 1.
        -- we use the condition vk = 2 because we're registering the
        -- output of this module
        if vk_eq_2 = '1' then
          next_state <= run;
        end if;

      when run =>
        if counter = conv_std_logic_vector(SEQ_LEN - 1, 16) then
          next_state <= epilogue;
        end if;

      when epilogue =>
        if index_i = x"0001" and index_k = x"0001" and
             index_j = conv_std_logic_vector(SEQ_LEN, index_j'length) then
          next_state <= idle;
        end if;

    end case;
  end process set_next_state;
  
  reg_inputs: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        -- not resetting int_seqdata

        counter       <= (others => '0');

        index_i       <= (others => '0');
        index_j       <= (others => '0');
        index_k       <= (others => '0');
      else

        case state is
          when idle =>
            if istart = '1' then
              int_seqdata <= isequence;
            end if;

          when preface =>
            counter         <= x"0003";

            -- we want to start when pe_bottom is at vk = 1.
            -- we use the condition vk = 2 because we're registering the
            -- output of this module
            if vk_eq_2 = '1' then
              -- shift down next sequence character
              for i in 1 to SEQ_LEN-1 loop
                int_seqdata(i)     <= int_seqdata(i+1);
              end loop;
              int_seqdata(SEQ_LEN) <= "100";  -- add invalid character

              -- assign next state
              index_i <= conv_std_logic_vector(SEQ_LEN, index_i'length);
              index_j <= x"0004";
              index_k <= conv_std_logic_vector(TILE_WIDTH_K, index_k'length);
            end if;

          when run =>

            -- increment index counters
            --
            
            -- index k decrements every clock: 1 <= k <= TILE_WIDTH
            if index_k = x"0001" then
              index_k <= conv_std_logic_vector(TILE_WIDTH_K, index_k'length);
            else
              index_k <= index_k - 1;
            end if;

            -- index i decrements: 1 <= i <= SEQ_LEN
            if index_k = x"0001" then
              if index_i = x"0001" then
                index_i <= conv_std_logic_vector(SEQ_LEN, index_i'length);
              else
                index_i <= index_i - 1;
              end if;
            end if;

            -- index j decrements: 1 <= j <= SEQ_LEN
            if index_k = x"0001" and index_i = x"0001" then
              index_j <= index_j + 1;
            end if;

            if border2_init_out(0) = '1' then
              counter            <= counter + 1;

              -- shift down next sequence character
              for i in 1 to SEQ_LEN-1 loop
                int_seqdata(i)   <= int_seqdata(i+1);
              end loop;
              int_seqdata(SEQ_LEN) <= "100";  -- add invalid character
            end if;

          when epilogue =>

            -- increment index counters
            --
            
            -- index k decrements every clock: 1 <= k <= TILE_WIDTH
            if index_k = x"0001" then
              index_k <= conv_std_logic_vector(TILE_WIDTH_K, index_k'length);
            else
              index_k <= index_k - 1;
            end if;

            -- index i decrements: 1 <= i <= SEQ_LEN
            if index_k = x"0001" then
              if index_i = x"0001" then
                index_i <= conv_std_logic_vector(SEQ_LEN, index_i'length);
              else
                index_i <= index_i - 1;
              end if;
            end if;

            -- index j decrements: 1 <= j <= SEQ_LEN
            if index_k = x"0001" and index_i = x"0001" then
              index_j <= index_j + 1;
            end if;

            if border2_init_out(0) = '1' then
              counter            <= counter + 1;

              -- shift down next sequence character
              for i in 1 to SEQ_LEN-1 loop
                int_seqdata(i)   <= int_seqdata(i+1);
              end loop;
              int_seqdata(SEQ_LEN) <= "100";  -- add invalid character
            end if;

          when others => null;
                         
        end case;        
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs;

  -----------------------------------------------------------------------------
  -- Process to handle combinational signals for the output FSM
  -----------------------------------------------------------------------------
  diff_j_i <= index_j - index_i;

  output_comb: process (state, X_diag_2, int_seqdata,
                        istart, border_init_out,
                        border2_init_out, vk_eq_2,
                        index_j, index_i, diff_j_i, index_k)
  begin  -- process set_outputs

    ifsm_init_X_ip1_j_vk_kp      <= '0';
    ifsm_initial_X_ip1_j_vk_kp   <= (others => '0');
    ifsm_init_X_i_jm1_vk_kp      <= '0';
    ifsm_initial_X_i_jm1_vk_kp   <= (others => '0');
    ifsm_init_X_ip1_jm1_vk_kp    <= '0';
    ifsm_initial_X_ip1_jm1_vk_kp <= (others => '0');
    ifsm_init_X_ip2_j_vk_kp      <= '0';
    ifsm_initial_X_ip2_j_vk_kp   <= (others => '0');

    ifsm_init_S_i                <= '0';
    ifsm_initial_S_i             <= (others => '0');
    ifsm_init_S_j                <= '0';
    ifsm_initial_S_j             <= (others => '0');

    ifsm_start_aggr              <= '0';
    ifsm_init_pipe14             <= '0';

    score_high                   <= '0';

    wait_upstrm_int              <= '0';

    border_init_in(0)            <= '0';

    case state is
      when idle =>
        if istart = '1' then
          wait_upstrm_int            <= '1';
        end if;
      
      when preface =>
        wait_upstrm_int              <= '1';

        -- we want to start when pe_bottom is at vk = 1.
        -- we use the condition vk = 2 because we're registering the
        -- output of this module

        -- compute row j = 3
        ifsm_init_X_ip1_j_vk_kp      <= vk_eq_2;
        ifsm_initial_X_ip1_j_vk_kp   <= X_diag_2(3);

        ifsm_init_X_i_jm1_vk_kp      <= vk_eq_2;
        ifsm_initial_X_i_jm1_vk_kp   <= X_diag_2(2);

        ifsm_init_X_ip1_jm1_vk_kp    <= vk_eq_2;
        ifsm_initial_X_ip1_jm1_vk_kp <= (others => '0');

        ifsm_init_X_ip2_j_vk_kp      <= vk_eq_2;
        ifsm_initial_X_ip2_j_vk_kp   <= (others => '0');

        ifsm_init_S_i                <= vk_eq_2;
        ifsm_initial_S_i             <= int_seqdata(1);

        ifsm_init_S_j                <= vk_eq_2;
        ifsm_initial_S_j             <= int_seqdata(3);

        ifsm_start_aggr              <= vk_eq_2;
        ifsm_init_pipe14             <= vk_eq_2;

        border_init_in(0)            <= vk_eq_2;

      when run =>
        wait_upstrm_int              <= '1';

        -- check if floor [ (j - i) / 2 ] == k
        if (index_i < index_j) and 
            ('0' & diff_j_i(diff_j_i'length - 1 downto 1)) = index_k then
          ifsm_start_aggr            <= '1';
        end if;

        -- check if (j - i) / 2 == k
        if (index_i < index_j) and 
            (diff_j_i = index_k(index_k'length - 1 downto 0) & '0') then
          ifsm_init_pipe14           <= '1';
        end if;

        if border_init_out(0) = '1' then
          ifsm_init_X_ip1_j_vk_kp      <= '1';
          ifsm_initial_X_ip1_j_vk_kp   <= X_diag_2(3);

          ifsm_init_X_i_jm1_vk_kp      <= '1';
          ifsm_initial_X_i_jm1_vk_kp   <= X_diag_2(2);

          ifsm_init_X_ip1_jm1_vk_kp    <= '1';
          ifsm_initial_X_ip1_jm1_vk_kp <= (others => '0');

          ifsm_init_X_ip2_j_vk_kp      <= '1';
          ifsm_initial_X_ip2_j_vk_kp   <= (others => '0');

          ifsm_init_S_i                <= '1';
          ifsm_initial_S_i             <= int_seqdata(1);

          ifsm_init_S_j                <= '1';
          ifsm_initial_S_j             <= int_seqdata(3);

--          ifsm_start_aggr              <= '1';
--          ifsm_init_pipe14             <= '1';

          border_init_in(0)            <= '1';
        elsif border2_init_out(0) = '1' then
          ifsm_init_X_ip1_jm1_vk_kp    <= '1';
          ifsm_initial_X_ip1_jm1_vk_kp <= X_diag_2(2);

          ifsm_init_X_ip2_j_vk_kp      <= '1';
          ifsm_initial_X_ip2_j_vk_kp   <= X_diag_2(3);

--          ifsm_start_aggr              <= '1';
--          ifsm_init_pipe14             <= '0';
        end if;

      when epilogue =>
        wait_upstrm_int                <= '1';

        -- check if floor [ (j - i) / 2 ] == k
        if (index_i < index_j) and 
            ('0' & diff_j_i(diff_j_i'length - 1 downto 1)) = index_k then
          ifsm_start_aggr            <= '1';
        end if;

        -- check if (j - i) / 2 == k
        if (index_i < index_j) and 
            (diff_j_i = index_k(index_k'length - 1 downto 0) & '0') then
          ifsm_init_pipe14           <= '1';
        end if;

        if border_init_out(0) = '1' then
          ifsm_init_X_ip1_j_vk_kp      <= '1';
          ifsm_initial_X_ip1_j_vk_kp   <= X_diag_2(3);

          ifsm_init_X_i_jm1_vk_kp      <= '1';
          ifsm_initial_X_i_jm1_vk_kp   <= X_diag_2(2);

          ifsm_init_X_ip1_jm1_vk_kp    <= '1';
          ifsm_initial_X_ip1_jm1_vk_kp <= (others => '0');

          ifsm_init_X_ip2_j_vk_kp      <= '1';
          ifsm_initial_X_ip2_j_vk_kp   <= (others => '0');

          ifsm_init_S_i                <= '1';
          ifsm_initial_S_i             <= int_seqdata(1);

          ifsm_init_S_j                <= '1';
          ifsm_initial_S_j             <= int_seqdata(3);

--          ifsm_start_aggr              <= '1';
--          ifsm_init_pipe14             <= '1';
        elsif border2_init_out(0) = '1' then
          ifsm_init_X_ip1_jm1_vk_kp    <= '1';
          ifsm_initial_X_ip1_jm1_vk_kp <= X_diag_2(2);

          ifsm_init_X_ip2_j_vk_kp      <= '1';
          ifsm_initial_X_ip2_j_vk_kp   <= X_diag_2(3);

--          ifsm_start_aggr              <= '1';
--          ifsm_init_pipe14             <= '0';

          score_high                   <= '1';
        end if;

    end case;
  end process output_comb;

  reg_outputs: process (clk)
  begin  -- process set_outputs
    if rising_edge(clk) then 
      if reset = '1' then
        init_X_ip1_j_vk_kp      <= '0';
        initial_X_ip1_j_vk_kp   <= (others => '0');
        init_X_i_jm1_vk_kp      <= '0';
        initial_X_i_jm1_vk_kp   <= (others => '0');
        init_X_ip1_jm1_vk_kp    <= '0';
        initial_X_ip1_jm1_vk_kp <= (others => '0');
        init_X_ip2_j_vk_kp      <= '0';
        initial_X_ip2_j_vk_kp   <= (others => '0');

        init_S_i                <= '0';
        initial_S_i             <= (others => '0');
        init_S_j                <= '0';
        initial_S_j             <= (others => '0');

        start_aggr              <= '0';
        init_pipe14             <= '0';

        score_vld               <= (others => '0');
        osequence_score         <= (others => '0');
        ovld                    <= '0';
      else
        init_X_ip1_j_vk_kp      <= ifsm_init_X_ip1_j_vk_kp;
        initial_X_ip1_j_vk_kp   <= ifsm_initial_X_ip1_j_vk_kp;
        init_X_i_jm1_vk_kp      <= ifsm_init_X_i_jm1_vk_kp;
        initial_X_i_jm1_vk_kp   <= ifsm_initial_X_i_jm1_vk_kp;
        init_X_ip1_jm1_vk_kp    <= ifsm_init_X_ip1_jm1_vk_kp;
        initial_X_ip1_jm1_vk_kp <= ifsm_initial_X_ip1_jm1_vk_kp;
        init_X_ip2_j_vk_kp      <= ifsm_init_X_ip2_j_vk_kp;
        initial_X_ip2_j_vk_kp   <= ifsm_initial_X_ip2_j_vk_kp;

        init_S_i                <= ifsm_init_S_i;
        initial_S_i             <= ifsm_initial_S_i;
        init_S_j                <= ifsm_init_S_j;
        initial_S_j             <= ifsm_initial_S_j;

        start_aggr              <= ifsm_start_aggr;
        init_pipe14             <= ifsm_init_pipe14;

        score_vld               <= score_high & score_vld(score_vld'high downto 1);

        osequence_score(31 downto CELL_WIDTH)  <= (others => '0');
        osequence_score(CELL_WIDTH-1 downto 0) <= iX_i_j_1_1;
        ovld                    <= score_vld(0);
      end if;
    end if;
  end process reg_outputs;

end architecture top_level; 
