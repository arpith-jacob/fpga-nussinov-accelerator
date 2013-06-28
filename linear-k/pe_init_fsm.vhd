
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
    clk                  : in  sl;
    reset                : in  sl;

    -- INPUTS
    isequence            : in  RESIDUE_ARRAY;
    istart               : in  sl;

    -- bottom pe X score
    iX_i_j_1             : in  slv(CELL_WIDTH-1 downto 0);

    -- array is busy
    wait_upstrm          : out sl;

    --
    -- INITIALIZATION
    --
    -- X(i+1, j, k)
    init_X_ip1_j_k       : out sl;
    initial_X_ip1_j_k    : out slv(CELL_WIDTH-1 downto 0);
    -- X(i, j-1, k)
    init_X_i_jm1_k       : out sl;
    initial_X_i_jm1_k    : out slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, k)
    init_X_ip1_jm1_k     : out sl;
    initial_X_ip1_jm1_k  : out slv(CELL_WIDTH-1 downto 0);
    -- X(i+2, j, k)
    init_X_ip2_j_k       : out sl;
    initial_X_ip2_j_k    : out slv(CELL_WIDTH-1 downto 0);

    -- sequence characters: initialization input
    -- sequence character S_i
    init_S_i             : out sl;
    initial_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    init_S_j             : out sl;
    initial_S_j          : out slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    start_aggr           : out sl;
                             -- start max aggregating along k axis
    init_pipe58          : out sl;
                             -- initialize pipelines 5 and 8

    osequence_score      : out slv(31 downto 0);
    ovld                 : out sl
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

  signal state                    : input_states;
  signal next_state               : input_states;

  -- store sequence data internally
  signal int_seqdata              : RESIDUE_ARRAY;

  -- count up to N, the sequence length
  signal counter                  : slv(15 downto 0);

  signal border_init_in           : slv(0 downto 0);
  signal border_init_out          : slv(0 downto 0);
  signal border2_init_out         : slv(0 downto 0);

  -- valid signal to track score
  signal score_vld                : slv((NO_PE-3)*2-1 downto 0);
  signal score_high               : sl;

  -- wait upstream signals
  signal wait_upstrm_int          : sl;

  -- initial values
  -- xor values of adjacent sequence residues (for initialization)
  signal seqdata_xor              : RESIDUE_ARRAY;

  type PE_INIT_ARRAY is array (1 to NO_PE) of slv(CELL_WIDTH-1 downto 0);
  signal X_diag_2                 : PE_INIT_ARRAY;

  -- internal output signals
  signal ifsm_init_X_ip1_j_k      : sl;
  signal ifsm_initial_X_ip1_j_k   : slv(CELL_WIDTH-1 downto 0);
  signal ifsm_init_X_i_jm1_k      : sl;
  signal ifsm_initial_X_i_jm1_k   : slv(CELL_WIDTH-1 downto 0);
  signal ifsm_init_X_ip1_jm1_k    : sl;
  signal ifsm_initial_X_ip1_jm1_k : slv(CELL_WIDTH-1 downto 0);
  signal ifsm_init_X_ip2_j_k      : sl;
  signal ifsm_initial_X_ip2_j_k   : slv(CELL_WIDTH-1 downto 0);

  signal ifsm_init_S_i            : sl;
  signal ifsm_initial_S_i         : slv(RESIDUE_WIDTH-1 downto 0);
  signal ifsm_init_S_j            : sl;
  signal ifsm_initial_S_j         : slv(RESIDUE_WIDTH-1 downto 0);

  signal ifsm_start_aggr          : sl;
  signal ifsm_init_pipe58         : sl;

begin

  -- TODO: fixme
  wait_upstrm   <= '1' when score_vld /= 0 else wait_upstrm_int;

  -- control pipeline for j - i = 2 condition.
  -- we need to initialize a border PE on j - i = 2 line every
  -- N-2 clocks, when the schedule is Nj - 2i - k.
  delay_init_border : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => NO_PE-2,  -- delay = NO_PE - 2
      NEEDS_RESET    => false,
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
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
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
  init_X_diag_2 : for j in 2 to NO_PE
    generate
      seqdata_xor(j)      <= int_seqdata(j - 1) xor int_seqdata(j);
      
      X_diag_2(j)(CELL_WIDTH-1 downto 1) <= (others => '0');
      X_diag_2(j)(0) <= not (int_seqdata(j - 1)(2) or int_seqdata(j)(2))
                        when seqdata_xor(j)(1 downto 0) = "11"
                        else '0';
    end generate;

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
  set_next_state: process (state, istart, counter)
  begin 
    next_state <= state;

    case state is
      when idle =>
        if istart = '1' then
          next_state <= preface;
        end if;

      when preface =>
        next_state <= run;

      when run =>
        if counter = conv_std_logic_vector(NO_PE - 1, 16) then
          next_state <= epilogue;
        end if;

      when epilogue =>
        if counter = conv_std_logic_vector(NO_PE, 16) then
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
      else

        case state is
          when idle =>
            if istart = '1' then
              int_seqdata  <= isequence;
            end if;

          when preface =>
            counter         <= x"0003";

            -- shift down next sequence character
            for i in 1 to NO_PE-1 loop
              int_seqdata(i)   <= int_seqdata(i+1);
            end loop;
            int_seqdata(NO_PE) <= "100";  -- add invalid character

          when run =>
            if border2_init_out(0) = '1' then
              counter            <= counter + 1;

              -- shift down next sequence character
              for i in 1 to NO_PE-1 loop
                int_seqdata(i)   <= int_seqdata(i+1);
              end loop;
              int_seqdata(NO_PE) <= "100";  -- add invalid character
            end if;

          when epilogue =>
            if border2_init_out(0) = '1' then
              counter            <= counter + 1;

              -- shift down next sequence character
              for i in 1 to NO_PE-1 loop
                int_seqdata(i)   <= int_seqdata(i+1);
              end loop;
              int_seqdata(NO_PE) <= "100";  -- add invalid character
            end if;

          when others => null;
                         
        end case;        
      end if; -- end reset 
    end if;  -- end rising_edge
  end process reg_inputs;

  -----------------------------------------------------------------------------
  -- Process to handle combinational signals for the output FSM
  -----------------------------------------------------------------------------
  output_comb: process (state, X_diag_2, int_seqdata,
                        istart, border_init_out,
                        border2_init_out)
  begin  -- process set_outputs

    ifsm_init_X_ip1_j_k      <= '0';
    ifsm_initial_X_ip1_j_k   <= (others => '0');
    ifsm_init_X_i_jm1_k      <= '0';
    ifsm_initial_X_i_jm1_k   <= (others => '0');
    ifsm_init_X_ip1_jm1_k    <= '0';
    ifsm_initial_X_ip1_jm1_k <= (others => '0');
    ifsm_init_X_ip2_j_k      <= '0';
    ifsm_initial_X_ip2_j_k   <= (others => '0');

    ifsm_init_S_i            <= '0';
    ifsm_initial_S_i         <= (others => '0');
    ifsm_init_S_j            <= '0';
    ifsm_initial_S_j         <= (others => '0');

    ifsm_start_aggr          <= '0';
    ifsm_init_pipe58         <= '0';

    score_high               <= '0';

    wait_upstrm_int          <= '0';

    border_init_in(0)        <= '0';

    case state is
      when idle =>
        if istart = '1' then
          wait_upstrm_int        <= '1';
        end if;
      
      when preface =>
        wait_upstrm_int          <= '1';

        -- compute row j = 3
        ifsm_init_X_ip1_j_k      <= '1';
        ifsm_initial_X_ip1_j_k   <= X_diag_2(3);

        ifsm_init_X_i_jm1_k      <= '1';
        ifsm_initial_X_i_jm1_k   <= X_diag_2(2);

        ifsm_init_X_ip1_jm1_k    <= '1';
        ifsm_initial_X_ip1_jm1_k <= (others => '0');

        ifsm_init_X_ip2_j_k      <= '1';
        ifsm_initial_X_ip2_j_k   <= (others => '0');

        ifsm_init_S_i            <= '1';
        ifsm_initial_S_i         <= int_seqdata(1);

        ifsm_init_S_j            <= '1';
        ifsm_initial_S_j         <= int_seqdata(3);

        ifsm_start_aggr          <= '1';
        ifsm_init_pipe58         <= '1';

        border_init_in(0)        <= '1';

      when run =>
        wait_upstrm_int          <= '1';

        if border_init_out(0) = '1' then
          ifsm_init_X_ip1_j_k      <= '1';
          ifsm_initial_X_ip1_j_k   <= X_diag_2(3);

          ifsm_init_X_i_jm1_k      <= '1';
          ifsm_initial_X_i_jm1_k   <= X_diag_2(2);

          ifsm_init_X_ip1_jm1_k    <= '1';
          ifsm_initial_X_ip1_jm1_k <= (others => '0');

          ifsm_init_X_ip2_j_k      <= '1';
          ifsm_initial_X_ip2_j_k   <= (others => '0');

          ifsm_init_S_i            <= '1';
          ifsm_initial_S_i         <= int_seqdata(1);

          ifsm_init_S_j            <= '1';
          ifsm_initial_S_j         <= int_seqdata(3);

          ifsm_start_aggr          <= '1';
          ifsm_init_pipe58         <= '1';

          border_init_in(0)        <= '1';
        elsif border2_init_out(0) = '1' then
          ifsm_init_X_ip1_jm1_k    <= '1';
          ifsm_initial_X_ip1_jm1_k <= X_diag_2(2);

          ifsm_init_X_ip2_j_k      <= '1';
          ifsm_initial_X_ip2_j_k   <= X_diag_2(3);

          ifsm_start_aggr          <= '1';
          ifsm_init_pipe58         <= '0';
        end if;

      when epilogue =>
        wait_upstrm_int            <= '1';

        if border_init_out(0) = '1' then
          ifsm_init_X_ip1_j_k      <= '1';
          ifsm_initial_X_ip1_j_k   <= X_diag_2(3);

          ifsm_init_X_i_jm1_k      <= '1';
          ifsm_initial_X_i_jm1_k   <= X_diag_2(2);

          ifsm_init_X_ip1_jm1_k    <= '1';
          ifsm_initial_X_ip1_jm1_k <= (others => '0');

          ifsm_init_X_ip2_j_k      <= '1';
          ifsm_initial_X_ip2_j_k   <= (others => '0');

          ifsm_init_S_i            <= '1';
          ifsm_initial_S_i         <= int_seqdata(1);

          ifsm_init_S_j            <= '1';
          ifsm_initial_S_j         <= int_seqdata(3);

          ifsm_start_aggr          <= '1';
          ifsm_init_pipe58         <= '1';
        elsif border2_init_out(0) = '1' then
          ifsm_init_X_ip1_jm1_k    <= '1';
          ifsm_initial_X_ip1_jm1_k <= X_diag_2(2);

          ifsm_init_X_ip2_j_k      <= '1';
          ifsm_initial_X_ip2_j_k   <= X_diag_2(3);

          ifsm_start_aggr          <= '1';
          ifsm_init_pipe58         <= '0';

          score_high               <= '1';
        end if;

    end case;
  end process output_comb;

  reg_outputs: process (clk)
  begin  -- process set_outputs
    if rising_edge(clk) then 
      if reset = '1' then
        init_X_ip1_j_k      <= '0';
        initial_X_ip1_j_k   <= (others => '0');
        init_X_i_jm1_k      <= '0';
        initial_X_i_jm1_k   <= (others => '0');
        init_X_ip1_jm1_k    <= '0';
        initial_X_ip1_jm1_k <= (others => '0');
        init_X_ip2_j_k      <= '0';
        initial_X_ip2_j_k   <= (others => '0');

        init_S_i            <= '0';
        initial_S_i         <= (others => '0');
        init_S_j            <= '0';
        initial_S_j         <= (others => '0');

        start_aggr          <= '0';
        init_pipe58         <= '0';

        score_vld           <= (others => '0');
        osequence_score     <= (others => '0');
        ovld                <= '0';
      else
        init_X_ip1_j_k      <= ifsm_init_X_ip1_j_k;
        initial_X_ip1_j_k   <= ifsm_initial_X_ip1_j_k;
        init_X_i_jm1_k      <= ifsm_init_X_i_jm1_k;
        initial_X_i_jm1_k   <= ifsm_initial_X_i_jm1_k;
        init_X_ip1_jm1_k    <= ifsm_init_X_ip1_jm1_k;
        initial_X_ip1_jm1_k <= ifsm_initial_X_ip1_jm1_k;
        init_X_ip2_j_k      <= ifsm_init_X_ip2_j_k;
        initial_X_ip2_j_k   <= ifsm_initial_X_ip2_j_k;

        init_S_i            <= ifsm_init_S_i;
        initial_S_i         <= ifsm_initial_S_i;
        init_S_j            <= ifsm_init_S_j;
        initial_S_j         <= ifsm_initial_S_j;

        start_aggr          <= ifsm_start_aggr;
        init_pipe58         <= ifsm_init_pipe58;

        score_vld           <= score_high & score_vld(score_vld'high downto 1);

        osequence_score(31 downto CELL_WIDTH)  <= (others => '0');
        osequence_score(CELL_WIDTH-1 downto 0) <= iX_i_j_1;
        ovld                <= score_vld(0);
      end if;
    end if;
  end process reg_outputs;

end architecture top_level; 
