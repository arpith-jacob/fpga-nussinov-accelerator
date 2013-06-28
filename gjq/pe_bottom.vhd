
-- File: pe_bottom.vhd
-- Date: 16 Feb 2008
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing the bottom cells of the nussinov GJQ
-- array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_bottom is
  port (
    clk                  : in  sl;
    reset                : in  sl;

    --
    -- INPUT
    --
    -- INITIALIZATION
    --
    -- sequence characters: initialization input
    -- sequence character S_i
    init_seq             : in  sl;
    initial_S_i          : in  slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    initial_S_j          : in  slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    in_j_m_i_eq_1        : in  sl;   -- j - i = 1
    in_j_m_i_eq_2        : in  sl;   -- j - i = 2
    in_start_aggr        : in  sl;   -- start max aggregating along k axis
    in_init_pipe58       : in  sl;   -- initialize pipelines 5 and 8

    -- DEPENDENCIES
    --
    -- X dependencies
    -- X(i, j-1, k)
    in_X_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, k)
    in_X_ip1_jm1_k       : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i, j, k+1)
    in_X_i_j_kp1         : in  slv(CELL_WIDTH-1 downto 0);

    -- pipeline dependencies
    -- X5(i, j-1, k)
    in_X5_i_jm1_k        : in  slv(CELL_WIDTH-1 downto 0);

    -- sequence character S_i
    in_S_i               : in  slv(RESIDUE_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X(i, j, k)
    out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
    -- X5(i, j, k)
    out_X5_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
    -- X6(i, j, k)
    out_X6_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j, k)
    out_X7_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

    -- output control signals
    out_start_aggr       : out sl;
    out_init_pipe58      : out sl;

    -- output sequence characters
    out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0)
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
  -- Mux signal along communication link: either an initialization value, or
  -- the value sent from a processing element
  -----------------------------------------------------------------------------
  signal mux_X_ip1_jm1_k        : slv(CELL_WIDTH-1 downto 0);
  signal mux_X_ip2_j_k          : slv(CELL_WIDTH-1 downto 0);
  signal mux_X_i_j_kp1          : slv(CELL_WIDTH-1 downto 0);

  signal mux_S_i                : slv(RESIDUE_WIDTH-1 downto 0);
  signal mux_S_j                : slv(RESIDUE_WIDTH-1 downto 0);

  signal in_X_ip1_j_k_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_jm1_k_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_jm1_k_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip2_j_k_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_j_kp1_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X5_i_jm1_k_delayed  : slv(CELL_WIDTH-1 downto 0);
  signal in_X8_ip1_j_k_delayed  : slv(CELL_WIDTH-1 downto 0);

  signal in_S_i_delayed         : slv(RESIDUE_WIDTH-1 downto 0);
  signal in_S_j_delayed         : slv(RESIDUE_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X_ip1_j_k_gt_X_i_jm1_k  : sl;
  signal X_ip1_j_k_max_X_i_jm1_k : slv(CELL_WIDTH-1 downto 0);

  signal base_pair_xor           : slv(RESIDUE_WIDTH-1 downto 0);
  signal base_pair               : sl;

  signal X_ip1_jm1_k_plus_delta  : slv(CELL_WIDTH-1 downto 0);

  signal X_max_simple3_gt        : sl;
  signal X_max_simple3           : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt       : sl;
  signal X_max_pipeline          : slv(CELL_WIDTH-1 downto 0);

  signal X5_i_j_k_plus_X6_i_j_k  : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_plus_X8_i_j_k  : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                 : slv(CELL_WIDTH-1 downto 0);

  signal X_simple3_gt_kaggr      : sl;
  signal X_simple3_max_kaggr     : slv(CELL_WIDTH-1 downto 0);

  signal X_init                  : slv(CELL_WIDTH-1 downto 0);
  signal X_i_j_k_gt              : sl;

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  signal X_i_j_k     : slv(CELL_WIDTH-1 downto 0);
  signal X5_i_j_k    : slv(CELL_WIDTH-1 downto 0);
  signal X6_i_j_k    : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k    : slv(CELL_WIDTH-1 downto 0);
  signal X8_i_j_k    : slv(CELL_WIDTH-1 downto 0);

  signal start_aggr  : sl;
  signal init_pipe58 : sl;

  signal S_i         : slv(RESIDUE_WIDTH-1 downto 0);
  signal S_j         : slv(RESIDUE_WIDTH-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- Delay communication links according to the schedule
  -----------------------------------------------------------------------------
  -- X(i+1, j, k)
  delay_X_ip1_j_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_k,
      dout           => in_X_ip1_j_k_delayed
      );

  -- X(i, j-1, k)
  delay_X_i_jm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_i_jm1_k,
      dout           => in_X_i_jm1_k_delayed
      );

  -- X(i+1, j-1, k)
  delay_X_ip1_jm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 4,  -- delay = 4
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_ip1_jm1_k,
      dout           => mux_X_ip1_jm1_k
      );
  in_X_ip1_jm1_k_delayed <= ZEROES(CELL_WIDTH-1 downto 0) when in_j_m_i_eq_2 = '1' else
                            mux_X_ip1_jm1_k;

  -- X(i+2, j, k)
  delay_X_ip2_j_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 4,  -- delay = 4
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_k,
      dout           => mux_X_ip2_j_k
      );
  in_X_ip2_j_k_delayed <= ZEROES(CELL_WIDTH-1 downto 0) when in_j_m_i_eq_2 = '1' else
                          mux_X_ip2_j_k;

  -- X(i, j, k+1)
  delay_X_i_j_kp1 : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 1,  -- delay = 1
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_i_j_kp1,
      dout           => mux_X_i_j_kp1
      );
  in_X_i_j_kp1_delayed <= mux_X_i_j_kp1;

  -- X5(i, j-1, k)
  delay_X5_i_jm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X5_i_jm1_k,
      dout           => in_X5_i_jm1_k_delayed
      );

  -- X8(i+1, j, k)
  delay_X8_ip1_j_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X8_i_j_k,
      dout           => in_X8_ip1_j_k_delayed
      );

  -- S_i(i, j-1, k)
  delay_Si_i_jm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_S_i,
      dout           => mux_S_i
      );
  in_S_i_delayed <= initial_S_i when init_seq = '1' else
                    mux_S_i;

  -- S_j(i+1, j, k)
  delay_Sj_ip1_j_k : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => 2,  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => S_j,
      dout           => mux_S_j
      );
  in_S_j_delayed <= initial_S_j when init_seq = '1' else
                    mux_S_j;

  -----------------------------------------------------------------------------
  -- Compute values for data variables
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Pipeline variable X5
  -----------------------------------------------------------------------------

  X5_i_j_k <= X7_i_j_k when in_init_pipe58 = '1' else
              in_X5_i_jm1_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X6
  -----------------------------------------------------------------------------

  X6_i_j_k <= in_X_ip2_j_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X7
  -----------------------------------------------------------------------------

  X7_i_j_k <= in_X_i_jm1_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X8
  -----------------------------------------------------------------------------

  X8_i_j_k <= X6_i_j_k when in_init_pipe58 = '1' else
              in_X8_ip1_j_k_delayed;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

  -- max ( X(i + 1, j, k) , X(i, j - 1, k) );
  X_ip1_j_k_gt_X_i_jm1_k  <= '1' when in_X_ip1_j_k_delayed >
                                      in_X_i_jm1_k_delayed else
                             '0';
  X_ip1_j_k_max_X_i_jm1_k <= in_X_ip1_j_k_delayed when
                               X_ip1_j_k_gt_X_i_jm1_k = '1'
                             else
                             in_X_i_jm1_k_delayed;

  -- a base is defined as a A, U pair or a C, G pair
  -- Encoding for residues: A = 000, C = 001, G = 010, U = 011
  -- We have a A, U or C, G if and only if S[i] xor S[j] = 11
  --           and they are both valid residues
  base_pair_xor <= in_S_i_delayed xor in_S_j_delayed;
  base_pair     <= not (in_S_i_delayed(2) or in_S_j_delayed(2)) when
                   (base_pair_xor(1 downto 0) = "11") else
                   '0';

  -- X(i + 1, j - 1, k) + delta (S_i, S_j)
  X_ip1_jm1_k_plus_delta <= in_X_ip1_jm1_k_delayed + base_pair;

  -- max of top 3 simple dependencies
  -- max ( X(i + 1, j - 1, k) + delta (S_i, S_j),
  --       X(i + 1, j, k), X(i, j - 1, k)
  --     )
  X_max_simple3_gt <= '1' when X_ip1_j_k_max_X_i_jm1_k >
                                X_ip1_jm1_k_plus_delta
                      else
                      '0';
  X_max_simple3    <= X_ip1_j_k_max_X_i_jm1_k when X_max_simple3_gt = '1'
                      else
                      X_ip1_jm1_k_plus_delta;



  -- X5(i, j, k) + X6(i, j, k)
  X5_i_j_k_plus_X6_i_j_k <= X5_i_j_k + X6_i_j_k;

  -- X7(i, j, k) + X8(i, j, k)
  X7_i_j_k_plus_X8_i_j_k <= X7_i_j_k + X8_i_j_k;
  
  -- max of pipeline dependencies
  -- max ( X5(i, j, k) + X6(i, j, k),
  --       X7(i, j, k) + X8(i, j, k)
  --     )
  X_max_pipeline_gt <= '1' when X5_i_j_k_plus_X6_i_j_k > X7_i_j_k_plus_X8_i_j_k
                       else
                       '0';
  X_max_pipeline    <= X5_i_j_k_plus_X6_i_j_k when X_max_pipeline_gt = '1'
                       else
                       X7_i_j_k_plus_X8_i_j_k;

  -- Compute aggregate term: initialize, or previous value
  -- X(i, j, k + 1)
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr = '1'
             else
             in_X_i_j_kp1_delayed;

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
  X_i_j_k_gt  <= '1' when X_max_pipeline > X_simple3_max_kaggr
                 else
                 '0';
  X_i_j_k     <= X_init              when in_j_m_i_eq_1 = '1' else
                 X_max_pipeline      when X_i_j_k_gt = '1' else
                 X_simple3_max_kaggr;

  -----------------------------------------------------------------------------
  -- Sequence data variables
  -----------------------------------------------------------------------------

  -- sequence
  S_i             <= in_S_i_delayed;
  S_j             <= in_S_j_delayed;

  -----------------------------------------------------------------------------
  -- Control pipelines
  -----------------------------------------------------------------------------

  start_aggr      <= in_start_aggr;
  init_pipe58     <= in_init_pipe58;

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_j_k     <= X_i_j_k;
  out_X5_i_j_k    <= X5_i_j_k;
  out_X6_i_j_k    <= X6_i_j_k;
  out_X7_i_j_k    <= X7_i_j_k;

  out_start_aggr  <= start_aggr;
  out_init_pipe58 <= init_pipe58;

  out_S_i         <= S_i;

end rtl;
