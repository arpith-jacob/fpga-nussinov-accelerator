
-- File: pe_clustered_other.vhd
-- Date: 6 Mar 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing all except the bottom cells of the
-- nussinov GJQ array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_clustered_other is
  port (
    clk                   : in  sl;
    reset                 : in  sl;

    --
    -- INPUT
    --
    -- input control signals
    in_start_aggr         : in  sl;   -- start max aggregating along k axis
    in_init_pipe58        : in  sl;   -- initialize pipelines 5 and 8

    in_clust_start_aggr   : in  sl;   -- start max aggregating along k axis
    in_clust_init_pipe58  : in  sl;   -- initialize pipelines 5 and 8

    -- X dependencies
    -- X(i, j, k+1)
    in_X_i_j_kp1          : in  slv(CELL_WIDTH-1 downto 0);

    -- pipeline dependencies
    -- X5(i, j-1, k)
    in_X5_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);
    -- X6(i+1, j, k-1)
    in_X6_ip1_j_km1       : in  slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j-1, k-1)
    in_X7_i_jm1_km1       : in  slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j-1, k-1) clustered input
    in_clust_X7_i_jm1_km1 : in  slv(CELL_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X(i, j, k)
    out_X_i_j_k           : out slv(CELL_WIDTH-1 downto 0);
    -- X5(i, j, k)
    out_X5_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
    -- X6(i, j, k)
    out_X6_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j, k)
    out_X7_i_j_k          : out slv(CELL_WIDTH-1 downto 0);

    -- output control signals
    out_start_aggr        : out sl;
    out_init_pipe58       : out sl
    );
end entity;

architecture rtl of pe_clustered_other is

  -- signal to specify which clustered cell is being processed
  signal pe_in_progress   : sl;

  -----------------------------------------------------------------------------
  -- Register input signals to keep in synch with the timing function
  -----------------------------------------------------------------------------
  -- 3 clocks
  signal in_start_aggr_1         : sl;
  signal in_start_aggr_2         : sl;

  signal in_clust_start_aggr_1   : sl;
  signal in_clust_start_aggr_2   : sl;

  -- 3 clocks
  signal in_init_pipe58_1        : sl;
  signal in_init_pipe58_2        : sl;

  signal in_clust_init_pipe58_1  : sl;
  signal in_clust_init_pipe58_2  : sl;

  -- 2 clocks
  signal in_X5_i_jm1_k_1         : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal in_X8_ip1_j_k_1         : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X5_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X6_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X8_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt       : sl;
  signal X_max_pipeline          : slv(CELL_WIDTH-1 downto 0);

  signal X5_i_j_k_plus_X6_i_j_k  : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_plus_X8_i_j_k  : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                 : slv(CELL_WIDTH-1 downto 0);

  signal X_all_gt                : sl;
  signal X_all                   : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Clustered result signals
  -----------------------------------------------------------------------------
  signal clustered_start_aggr    : sl;
  signal clustered_init_pipe58   : sl;

  -- X(i, j, k+1)
  signal clustered_X_i_j_kp1     : slv(CELL_WIDTH-1 downto 0);

  -- X6(i+1, j, k-1)
  signal clustered_X6_ip1_j_km1  : slv(CELL_WIDTH-1 downto 0);
  -- X7(i, j-1, k-1)
  signal clustered_X7_i_jm1_km1  : slv(CELL_WIDTH-1 downto 0);

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
  -- Process to register inputs to keep in synch with timing function
  -----------------------------------------------------------------------------
  reg_inputs: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        in_start_aggr_1        <= '0';
        in_start_aggr_2        <= '0';

        in_clust_start_aggr_1  <= '0';
        in_clust_start_aggr_2  <= '0';

        in_init_pipe58_1       <= '0';
        in_init_pipe58_2       <= '0';

        in_clust_init_pipe58_1 <= '0';
        in_clust_init_pipe58_2 <= '0';

        in_X5_i_jm1_k_1        <= (others => '0');

        in_X8_ip1_j_k_1        <= (others => '0');
      else
        -- 3 clocks
        in_start_aggr_1        <= in_start_aggr;
        in_start_aggr_2        <= in_start_aggr_1;

        in_clust_start_aggr_1  <= in_clust_start_aggr;
        in_clust_start_aggr_2  <= in_clust_start_aggr_1;

        -- 3 clocks
        in_init_pipe58_1       <= in_init_pipe58;
        in_init_pipe58_2       <= in_init_pipe58_1;

        in_clust_init_pipe58_1 <= in_clust_init_pipe58;
        in_clust_init_pipe58_2 <= in_clust_init_pipe58_1;

        -- 2 clocks
        in_X5_i_jm1_k_1        <= in_X5_i_jm1_k;

        -- 2 clocks
        in_X8_ip1_j_k_1        <= X8_i_j_k;
      end if;
    end if;  -- end rising_edge
  end process reg_inputs;

  -----------------------------------------------------------------------------
  -- Process to read clustered signals
  -----------------------------------------------------------------------------
  clustered_start_aggr   <= in_start_aggr_2 when pe_in_progress = '0'
                            else in_clust_start_aggr_2;
  clustered_init_pipe58  <= in_init_pipe58_2 when pe_in_progress = '0'
                            else in_clust_init_pipe58_2;

  clustered_X_i_j_kp1    <= in_X_i_j_kp1 when pe_in_progress = '1'
                            else X_i_j_k;
  clustered_X6_ip1_j_km1 <= in_X6_ip1_j_km1 when pe_in_progress = '0'
                            else X6_i_j_k;
  clustered_X7_i_jm1_km1 <= in_X7_i_jm1_km1 when pe_in_progress = '0'
                            else in_clust_X7_i_jm1_km1;

  gen_clustered: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        pe_in_progress <= '0';
      else
        pe_in_progress <= not pe_in_progress;
      end if;
    end if;  -- end rising_edge
  end process gen_clustered;

  -----------------------------------------------------------------------------
  -- Compute values for data variables
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Pipeline variable X5
  -----------------------------------------------------------------------------

  X5_i_j_k_max <= X7_i_j_k_max when clustered_init_pipe58 = '1' else
                  in_X5_i_jm1_k_1;

  -----------------------------------------------------------------------------
  -- Pipeline variable X6
  -----------------------------------------------------------------------------

  X6_i_j_k_max <= clustered_X6_ip1_j_km1;

  -----------------------------------------------------------------------------
  -- Pipeline variable X7
  -----------------------------------------------------------------------------

  X7_i_j_k_max <= clustered_X7_i_jm1_km1;

  -----------------------------------------------------------------------------
  -- Pipeline variable X8
  -----------------------------------------------------------------------------

  X8_i_j_k_max <= X6_i_j_k_max when clustered_init_pipe58 = '1' else
                  in_X8_ip1_j_k_1;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

  -- X5(i, j, k) + X6(i, j, k)
  X5_i_j_k_plus_X6_i_j_k <= X5_i_j_k_max + X6_i_j_k_max;

  -- X7(i, j, k) + X8(i, j, k)
  X7_i_j_k_plus_X8_i_j_k <= X7_i_j_k_max + X8_i_j_k_max;
  
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
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when clustered_start_aggr = '1'
             else
             clustered_X_i_j_kp1;

  -- Compute final max between k aggregate
  -- and the pipeline dependencies
  X_all_gt <= '1' when X_max_pipeline > X_kaggr
              else
              '0';
  X_all    <= X_max_pipeline when X_all_gt = '1'
              else
              X_kaggr;

  -----------------------------------------------------------------------------
  -- Process to register computed values for data variables
  -----------------------------------------------------------------------------
  reg_values: process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        X_i_j_k     <= (others => '0');
        X5_i_j_k    <= (others => '0');
        X6_i_j_k    <= (others => '0');
        X7_i_j_k    <= (others => '0');
        X8_i_j_k    <= (others => '0');

        -- register control signals
        start_aggr  <= '0';
        init_pipe58 <= '0';
      else
        -- register computed values: output
        X_i_j_k     <= X_all;
        X5_i_j_k    <= X5_i_j_k_max;
        X6_i_j_k    <= X6_i_j_k_max;
        X7_i_j_k    <= X7_i_j_k_max;
        X8_i_j_k    <= X8_i_j_k_max;

        -- register control signals
        start_aggr  <= clustered_start_aggr;
        init_pipe58 <= clustered_init_pipe58;
      end if;
    end if;  -- end rising_edge
  end process reg_values;

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_j_k     <= X_i_j_k;
  out_X5_i_j_k    <= X5_i_j_k;
  out_X6_i_j_k    <= X6_i_j_k;
  out_X7_i_j_k    <= X7_i_j_k;

  out_start_aggr  <= start_aggr;
  out_init_pipe58 <= init_pipe58;

end rtl;

