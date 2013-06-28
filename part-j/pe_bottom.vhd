
-- File: pe_bottom.vhd
-- Date: 15 December 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing the bottom cells.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_bottom is
  generic (
    -- reset state.  state of pe when its reset.  state is:
    -- 0 ... TILE_WIDTH_J - 1
    RESET_STATE            : slv (15 downto 0)
    );
  port (
    clk                    : in  sl;
    reset                  : in  sl;

    -- sequence characters: initialization input
    -- sequence character S_i
    init_seq               : in  sl;
    initial_S_i            : in  slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    initial_S_j            : in  slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    in_start_aggr          : in  sl;
                             -- start max aggregating along k axis
    in_init_pipe14         : in  sl;
                             -- initialize pipelines 1 and 4
    in_j_m_i_2             : in  sl;
                             -- j - i = 2

    -- DEPENDENCIES
    --
    -- X dependencies
    -- X1(i, W_j-1, j'-1, k)
    in_X1_i_Wjm1_jpm1_k    : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i, W_j, j'-1, k)
    in_X_i_Wj_jpm1_k       : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, W_j, j'-1, k)
    in_X_ip1_Wj_jpm1_k     : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i, v_j, j', k+1)
    in_X_i_vj_jp_kp1       : in  slv(CELL_WIDTH-1 downto 0);

    -- P(i, W_j-1, j'-1, k)
    in_P_i_Wjm1_jpm1_k     : in  slv(RESIDUE_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X(i, v_j, j', k)
    out_X_i_vj_jp_k        : out slv(CELL_WIDTH-1 downto 0);
    -- X1(i, v_j, j', k)
    out_X1_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);
    -- X2(i, v_j, j', k)
    out_X2_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);
    -- X3(i, v_j, j', k)
    out_X3_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);

    -- P(i, v_j, j', k)
    out_P_i_vj_jp_k        : out slv(RESIDUE_WIDTH-1 downto 0);

    -- internal state: pe is computing last cell in its tile
    out_vj_eq_tile_width_j : out sl;

    -- output control signals
    out_start_aggr         : out sl;
    out_init_pipe14        : out sl
    );
end entity;

architecture rtl of pe_bottom is

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

  -----------------------------------------------------------------------------
  -- Delay signals from a processing element
  -----------------------------------------------------------------------------
  signal in_X1_i_Wjm1_jpm1_k_delayed    : slv(CELL_WIDTH-1 downto 0);
  signal in_X1_i_vjm1_jp_k_delayed      : slv(CELL_WIDTH-1 downto 0);
  signal in_X4_ip1_vj_jp_k_delayed      : slv(CELL_WIDTH-1 downto 0);

  signal in_X_i_Wj_jpm1_k_delayed       : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_vjm1_jp_k_delayed       : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_vj_jp_k_delayed       : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_Wj_jpm1_k_delayed     : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_vjm1_jp_k_delayed     : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip2_vj_jp_k_delayed       : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_vj_jp_kp1_delayed       : slv(CELL_WIDTH-1 downto 0);

  signal in_P_i_Wjm1_jpm1_k_delayed     : slv(RESIDUE_WIDTH-1 downto 0);
  signal in_P_i_vjm1_jp_k_delayed       : slv(RESIDUE_WIDTH-1 downto 0);
  signal in_Q_ip1_vj_jp_k_delayed       : slv(RESIDUE_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- State of processing element
  -----------------------------------------------------------------------------
  signal state_counter                  : slv(15 downto 0);
  signal vj_eq_1                        : sl;

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X1_i_vj_jp_k                   : slv(CELL_WIDTH-1 downto 0);
  signal X2_i_vj_jp_k                   : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_vj_jp_k                   : slv(CELL_WIDTH-1 downto 0);
  signal X4_i_vj_jp_k                   : slv(CELL_WIDTH-1 downto 0);

  signal P_i_vj_jp_k                    : slv(RESIDUE_WIDTH-1 downto 0);
  signal Q_i_vj_jp_k                    : slv(RESIDUE_WIDTH-1 downto 0);

  signal mux_X_i_jm1_k_delayed          : slv(CELL_WIDTH-1 downto 0);

  signal X_ip1_vj_jp_k_gt_X_i_jm1_k     : sl;
  signal X_ip1_vj_jp_k_max_X_i_jm1_k    : slv(CELL_WIDTH-1 downto 0);

  signal base_pair_xor                  : slv(RESIDUE_WIDTH-1 downto 0);
  signal base_pair                      : sl;

  signal mux_X_ip1_jm1_k_delayed        : slv(CELL_WIDTH-1 downto 0);

  signal X_ip1_jm1_k_plus_delta         : slv(CELL_WIDTH-1 downto 0);

  signal X_max_simple3_gt               : sl;
  signal X_max_simple3                  : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt              : sl;
  signal X_max_pipeline                 : slv(CELL_WIDTH-1 downto 0);

  signal X1_i_vj_jp_k_plus_X2_i_vj_jp_k : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_vj_jp_k_plus_X4_i_vj_jp_k : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                        : slv(CELL_WIDTH-1 downto 0);

  signal X_simple3_gt_kaggr             : sl;
  signal X_simple3_max_kaggr            : slv(CELL_WIDTH-1 downto 0);

  signal X_all_gt                       : sl;
  signal X_init                         : slv(CELL_WIDTH-1 downto 0);
  signal X_all                          : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  signal X_i_vj_jp_k_reg                : slv(CELL_WIDTH-1 downto 0);
  signal X1_i_vj_jp_k_reg               : slv(CELL_WIDTH-1 downto 0);
  signal X2_i_vj_jp_k_reg               : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_vj_jp_k_reg               : slv(CELL_WIDTH-1 downto 0);
  signal X4_i_vj_jp_k_reg               : slv(CELL_WIDTH-1 downto 0);

  signal start_aggr_reg                 : sl;
  signal init_pipe14_reg                : sl;

  signal P_i_vj_jp_k_reg                : slv(RESIDUE_WIDTH-1 downto 0);
  signal Q_i_vj_jp_k_reg                : slv(RESIDUE_WIDTH-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- Delay communication links according to the schedule
  -----------------------------------------------------------------------------
  -- X1(i, W_j, j'-1, k)
  delay_X1_i_Wjm1_jpm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 1,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X1_i_Wjm1_jpm1_k,
      dout           => in_X1_i_Wjm1_jpm1_k_delayed
      );

  -- X1(i, v_j-1, j', k)
  delay_X1_i_vjm1_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 1,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X1_i_vj_jp_k_reg,
      dout           => in_X1_i_vjm1_jp_k_delayed
      );

  -- X4(i+1, v_j, j', k)
  delay_X4_ip1_vj_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => TILE_WIDTH_J-1,  -- delay = TILE_WIDTH_J
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X4_i_vj_jp_k_reg,
      dout           => in_X4_ip1_vj_jp_k_delayed
      );

  -- X(i, W_j, j'-1, k)
  delay_X_i_Wj_jpm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 1,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_i_Wj_jpm1_k,
      dout           => in_X_i_Wj_jpm1_k_delayed
      );

  -- X(i, v_j-1, j', k)
  delay_X_i_vjm1_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 1,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_vj_jp_k_reg,
      dout           => in_X_i_vjm1_jp_k_delayed
      );

  -- X(i+1, v_j, j', k)
  delay_X_ip1_vj_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => TILE_WIDTH_J-1,  -- delay = TILE_WIDTH_J
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_vj_jp_k_reg,
      dout           => in_X_ip1_vj_jp_k_delayed
      );

  -- X(i+1, W_j, j'-1, k)
  delay_X_ip1_Wj_jpm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => TILE_WIDTH_J+1,  -- delay = TILE_WIDTH_J+2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_ip1_Wj_jpm1_k,
      dout           => in_X_ip1_Wj_jpm1_k_delayed
      );

  -- X(i+1, v_j-1, j', k)
  delay_X_ip1_vjm1_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => TILE_WIDTH_J+1,  -- delay = TILE_WIDTH_J+2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_vj_jp_k_reg,
      dout           => in_X_ip1_vjm1_jp_k_delayed
      );

  -- X(i+2, v_j, j', k)
  delay_X_ip2_vj_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => (2*TILE_WIDTH_J)-1,  -- delay = 2*TILE_WIDTH_J
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_vj_jp_k_reg,
      dout           => in_X_ip2_vj_jp_k_delayed
      );

  -- X(i, v_j, j', k+1)
  -- delay = 1
  in_X_i_vj_jp_kp1_delayed <= in_X_i_vj_jp_kp1;

  -- P(i, W_j, j'-1, k)
  delay_P_i_Wjm1_jpm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => 1,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_P_i_Wjm1_jpm1_k,
      dout           => in_P_i_Wjm1_jpm1_k_delayed
      );

  -- P(i, v_j-1, j', k)
  delay_P_i_vjm1_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => 1,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => P_i_vj_jp_k_reg,
      dout           => in_P_i_vjm1_jp_k_delayed
      );

  -- Q(i, v_j-1, j', k)
  delay_Q_i_vjm1_jp_k : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => TILE_WIDTH_J-1,  -- delay = TILE_WIDTH_J
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => Q_i_vj_jp_k_reg,
      dout           => in_Q_ip1_vj_jp_k_delayed
      );

  -----------------------------------------------------------------------------
  -- Compute state of PE
  -----------------------------------------------------------------------------

  gen_state : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_counter            <= RESET_STATE;

        vj_eq_1                  <= '0';
        out_vj_eq_tile_width_j   <= '0';
      else
        state_counter            <= state_counter + 1;

        if state_counter = TILE_WIDTH_J-1 then
          state_counter          <= (others => '0');
        end if;

        -- v_j = 1.  use this signal to mux input
        if state_counter = TILE_WIDTH_J-1 then -- next clock has v_j = 1
          vj_eq_1                <= '1';
        else
          vj_eq_1                <= '0';
        end if;

        -- v_j = TILE_WIDTH_J.
        -- latency of pe_init_fsm is 3
        if state_counter = ((TILE_WIDTH_J-1-5) mod TILE_WIDTH_J) then
          out_vj_eq_tile_width_j <= '1';
        else
          out_vj_eq_tile_width_j <= '0';
        end if;
      end if;
    end if;  -- end rising_edge
  end process gen_state;

  -----------------------------------------------------------------------------
  -- Pipeline variable X1
  -----------------------------------------------------------------------------

  X1_i_vj_jp_k <= X3_i_vj_jp_k when in_init_pipe14 = '1' else
                  in_X1_i_Wjm1_jpm1_k_delayed when vj_eq_1 = '1' else
                  in_X1_i_vjm1_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X2
  -----------------------------------------------------------------------------

  X2_i_vj_jp_k <= ZEROES(CELL_WIDTH-1 downto 0) when in_j_m_i_2 = '1' else
                  in_X_ip2_vj_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X3
  -----------------------------------------------------------------------------

  -- NOT NEEDED?
  X3_i_vj_jp_k <= in_X_i_Wj_jpm1_k_delayed when vj_eq_1 = '1' else
                  in_X_i_vjm1_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X4
  -----------------------------------------------------------------------------

  X4_i_vj_jp_k <= X2_i_vj_jp_k when in_init_pipe14 = '1' else
                  in_X4_ip1_vj_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Variable P
  -----------------------------------------------------------------------------

  P_i_vj_jp_k  <= initial_S_i                when init_seq = '1' else
                  in_P_i_Wjm1_jpm1_k_delayed when vj_eq_1 = '1' else
                  in_P_i_vjm1_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Variable Q
  -----------------------------------------------------------------------------

  Q_i_vj_jp_k  <= initial_S_j              when init_seq = '1' else
                  in_Q_ip1_vj_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

  -- X(i, j - 1, k) is X(i, W_j, j' - 1, k) if v_j = 1 and
  --                   X(i, v_j - 1, j', k) if v_j > 1
  mux_X_i_jm1_k_delayed <= in_X_i_Wj_jpm1_k_delayed when vj_eq_1 = '1' else
                           in_X_i_vjm1_jp_k_delayed;

  -- max ( X(i + 1, v_j, j', k) , X(i, j - 1, k) );
  X_ip1_vj_jp_k_gt_X_i_jm1_k  <= '1' when in_X_ip1_vj_jp_k_delayed >
                                          mux_X_i_jm1_k_delayed
                                 else '0';
  X_ip1_vj_jp_k_max_X_i_jm1_k <= in_X_ip1_vj_jp_k_delayed when
                                     X_ip1_vj_jp_k_gt_X_i_jm1_k = '1'
                                 else
                                 mux_X_i_jm1_k_delayed;

  -- a base is defined as a A, U pair or a C, G pair
  -- Encoding for residues: A = 000, C = 001, G = 010, U = 011
  -- We have a A, U or C, G if and only if S[i] xor S[j] = 11
  --           and they are both valid residues
  base_pair_xor <= P_i_vj_jp_k xor Q_i_vj_jp_k;
  base_pair     <= not (P_i_vj_jp_k(2) or Q_i_vj_jp_k(2)) when
                   (base_pair_xor(1 downto 0) = "11") else
                   '0';

  -- X(i + 1, j - 1, k) is X(i + 1, W_j, j' - 1, k) if v_j = 1 and
  --                       X(i + 1, v_j - 1, j', k) if v_j > 1
  mux_X_ip1_jm1_k_delayed <= ZEROES(CELL_WIDTH-1 downto 0) when
                                                          in_j_m_i_2 = '1' else
                             in_X_ip1_Wj_jpm1_k_delayed when vj_eq_1 = '1' else
                             in_X_ip1_vjm1_jp_k_delayed;

  -- X(i + 1, j - 1, k) + delta (S_i, S_j)
  X_ip1_jm1_k_plus_delta <= mux_X_ip1_jm1_k_delayed + base_pair;

  -- max of top 3 simple dependencies
  -- max ( X(i + 1, j - 1, k) + delta (S_i, S_j),
  --       X(i + 1, v_j, j', k) , X(i, j - 1, k)
  --     )
  X_max_simple3_gt <= '1' when X_ip1_vj_jp_k_max_X_i_jm1_k >
                                X_ip1_jm1_k_plus_delta
                      else
                      '0';
  X_max_simple3    <= X_ip1_vj_jp_k_max_X_i_jm1_k when
                            X_max_simple3_gt = '1'
                      else
                      X_ip1_jm1_k_plus_delta;



  -- X1(i, v_j, j', k) + X2(i, v_j, j', k)
  X1_i_vj_jp_k_plus_X2_i_vj_jp_k <= X1_i_vj_jp_k + X2_i_vj_jp_k;

  -- X3(i, v_j, j', k) + X4(i, v_j, j', k)
  X3_i_vj_jp_k_plus_X4_i_vj_jp_k <= X3_i_vj_jp_k + X4_i_vj_jp_k;
  
  -- max of pipeline dependencies
  -- max ( X1(i, v_j, j', k) + X2(i, v_j, j', k),
  --       X3(i, v_j, j', k) + X4(i, v_j, j', k)
  --     )
  X_max_pipeline_gt <= '1' when X1_i_vj_jp_k_plus_X2_i_vj_jp_k >
                                X3_i_vj_jp_k_plus_X4_i_vj_jp_k
                       else
                       '0';
  X_max_pipeline    <= X1_i_vj_jp_k_plus_X2_i_vj_jp_k
                       when X_max_pipeline_gt = '1'
                       else X3_i_vj_jp_k_plus_X4_i_vj_jp_k;

  -- Compute aggregate term: initialize, or previous value
  -- X(i, j, k + 1)
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr = '1'
             else
             in_X_i_vj_jp_kp1_delayed;

  -- if k = 1 then
  --   max ( 
  --         max ( X(i + 1, j - 1, k) + delta (S_i, S_j),
  --               X(i + 1, j, k), X(i, j - 1, k)
  --             ),
  --         X(i, j, k + 1)
  --       )
  -- else
  --   X(i, j, k + 1)
  --
  X_simple3_gt_kaggr  <= '1' when X_max_simple3 > X_kaggr
                         else
                         '0';
  X_simple3_max_kaggr <= X_max_simple3 when X_simple3_gt_kaggr = '1'
                         else
                         X_kaggr;

  X_init(CELL_WIDTH-1 downto 1) <= (others => '0');
  X_init(0)                     <= base_pair;

  -- Compute final max between top 3 dependencies, k aggregate
  -- and the pipeline dependencies
  X_all_gt <= '1' when X_max_pipeline > X_simple3_max_kaggr
              else
              '0';
  X_all    <= X_init              when init_seq = '1' else
              X_max_pipeline      when X_all_gt = '1' else
              X_simple3_max_kaggr;

  -----------------------------------------------------------------------------
  -- Process to register computed values for data variables
  -----------------------------------------------------------------------------
  reg_values_noreset: process (clk)
  begin 
    if rising_edge(clk) then
        -- register computed values: output
        X_i_vj_jp_k_reg  <= X_all;
        X1_i_vj_jp_k_reg <= X1_i_vj_jp_k;
        X2_i_vj_jp_k_reg <= X2_i_vj_jp_k;
        X3_i_vj_jp_k_reg <= X3_i_vj_jp_k;
        X4_i_vj_jp_k_reg <= X4_i_vj_jp_k;

        -- register sequence
        P_i_vj_jp_k_reg <= P_i_vj_jp_k;
        Q_i_vj_jp_k_reg <= Q_i_vj_jp_k;
    end if;  -- end rising_edge
  end process reg_values_noreset;

  reg_values: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        -- register control signals
        start_aggr_reg  <= '0';
        init_pipe14_reg <= '0';
      else
        -- register control signals
        start_aggr_reg  <= in_start_aggr;
        init_pipe14_reg <= in_init_pipe14;
      end if;
    end if;  -- end rising_edge
  end process reg_values;

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_vj_jp_k     <= X_i_vj_jp_k_reg;
  out_X1_i_vj_jp_k    <= X1_i_vj_jp_k_reg;
  out_X2_i_vj_jp_k    <= X2_i_vj_jp_k_reg;
  out_X3_i_vj_jp_k    <= X3_i_vj_jp_k_reg;

  out_P_i_vj_jp_k     <= P_i_vj_jp_k_reg;

  out_start_aggr      <= start_aggr_reg;
  out_init_pipe14     <= init_pipe14_reg;

end rtl;
