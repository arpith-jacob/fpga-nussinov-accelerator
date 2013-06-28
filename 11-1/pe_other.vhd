
-- File: pe_other.vhd
-- Date: 11 Feb 2010
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing all except the bottom cells of the
-- nussinov 110 array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_other is
  port (
    clk                  : in  sl;
    reset                : in  sl;

    --
    -- INPUT
    --
    -- input control signals
    in_start_aggr        : in  sl;   -- start max aggregating along k axis
    in_init_pipe58       : in  sl;   -- initialize pipelines 5 and 8

    -- X dependencies
    -- X(i, j, k+1)
    in_X_i_j_kp1         : in  slv(CELL_WIDTH-1 downto 0);

    -- pipeline dependencies
    -- X5(i, j-1, k)
    in_X5_i_jm1_k        : in  slv(CELL_WIDTH-1 downto 0);
    -- X6(i+1, j, k-1)
    in_X6_ip1_j_km1      : in  slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j-1, k-1)
    in_X7_i_jm1_km1      : in  slv(CELL_WIDTH-1 downto 0);
    -- X8(i+1, j, k)
    in_X8_ip1_j_k        : in  slv(CELL_WIDTH-1 downto 0);

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
    -- X8(i, j, k)
    out_X8_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

    -- output control signals
    out_start_aggr       : out sl;
    out_init_pipe58      : out sl
    );
end entity;

architecture rtl of pe_other is

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
  signal mux_start_aggr          : slv(0 downto 0);
  signal mux_init_pipe58         : slv(0 downto 0);

  signal in_start_aggr_delayed   : slv(0 downto 0);
  signal in_init_pipe58_delayed  : slv(0 downto 0);

  signal in_X_i_j_kp1_delayed   : slv(CELL_WIDTH-1 downto 0);

  signal in_X5_i_jm1_k_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X6_ip1_j_km1_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X7_i_jm1_km1_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X8_ip1_j_k_delayed   : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X_max_pipeline_gt       : sl;
  signal X_max_pipeline          : slv(CELL_WIDTH-1 downto 0);

  signal X5_i_j_k_plus_X6_i_j_k  : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_plus_X8_i_j_k  : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                 : slv(CELL_WIDTH-1 downto 0);

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

begin

  -----------------------------------------------------------------------------
  -- Delay communication links according to the schedule
  -----------------------------------------------------------------------------
  -- start_aggr(i, j-2, k-1)   -- to start aggregation at k = (j-i)/2
  mux_start_aggr(0) <= in_start_aggr;
  delay_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => -SCHEDULE(0, -2, -1),  -- delay = 3
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => mux_start_aggr,
      dout           => in_start_aggr_delayed
      );

  -- init_pipe58(i, j-2, k-1)
  mux_init_pipe58(0) <= in_init_pipe58;
  delay_init_pipe58 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => -SCHEDULE(0, -2, -1),  -- delay = 3
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => mux_init_pipe58,
      dout           => in_init_pipe58_delayed
      );

  -- X(i, j, k+1)
  delay_X_i_j_kp1 : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, 0, 1),  -- delay = 1
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_i_j_kp1,
      dout           => in_X_i_j_kp1_delayed
      );

  -- X5(i, j-1, k)
  delay_X5_i_jm1_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, -1, 0),  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X5_i_jm1_k,
      dout           => in_X5_i_jm1_k_delayed
      );

  -- X6(i+1, j, k-1)
  delay_X6_ip1_j_km1 : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, -1),  -- delay = 1
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X6_ip1_j_km1,
      dout           => in_X6_ip1_j_km1_delayed
      );

  -- X7(i, j-1, k-1)
  delay_X7_i_jm1_km1 : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, -1, -1),  -- delay = 1
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X7_i_jm1_km1,
      dout           => in_X7_i_jm1_km1_delayed
      );

  -- X8(i+1, j, k)
  delay_X8_ip1_j_k : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, 0),  -- delay = 2
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X8_ip1_j_k,
      dout           => in_X8_ip1_j_k_delayed
      );

  -----------------------------------------------------------------------------
  -- Compute values for data variables
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Pipeline variable X5
  -----------------------------------------------------------------------------

  X5_i_j_k <= X7_i_j_k when in_init_pipe58_delayed(0) = '1' else
              in_X5_i_jm1_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X6
  -----------------------------------------------------------------------------

  X6_i_j_k <= in_X6_ip1_j_km1_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X7
  -----------------------------------------------------------------------------

  X7_i_j_k <= in_X7_i_jm1_km1_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X8
  -----------------------------------------------------------------------------

  X8_i_j_k <= X6_i_j_k when in_init_pipe58_delayed(0) = '1' else
              in_X8_ip1_j_k_delayed;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

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
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr_delayed(0) = '1'
             else
             in_X_i_j_kp1_delayed;

  -- Compute final max between k aggregate
  -- and the pipeline dependencies
  X_i_j_k_gt <= '1' when X_max_pipeline > X_kaggr
                  else
                '0';
  X_i_j_k    <= X_max_pipeline when X_i_j_k_gt = '1'
                else
                X_kaggr;

  -----------------------------------------------------------------------------
  -- Control pipelines
  -----------------------------------------------------------------------------

  start_aggr  <= in_start_aggr_delayed(0);
  init_pipe58 <= in_init_pipe58_delayed(0);

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_j_k     <= X_i_j_k;
  out_X5_i_j_k    <= X5_i_j_k;
  out_X6_i_j_k    <= X6_i_j_k;
  out_X7_i_j_k    <= X7_i_j_k;
  out_X8_i_j_k    <= X8_i_j_k;

  out_start_aggr  <= start_aggr;
  out_init_pipe58 <= init_pipe58;

end rtl;

