
-- File: pe_clustered_bottom.vhd
-- Date: 7 Mar 2009
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

entity pe_clustered_bottom is
  port (
    clk                  : in  sl;
    reset                : in  sl;

    --
    -- INPUT
    --
    -- INITIALIZATION
    --
    -- X(i+1, j, k)
    init_X_ip1_j_k       : in  sl;
    initial_X_ip1_j_k    : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i, j-1, k)
    init_X_i_jm1_k       : in  sl;
    initial_X_i_jm1_k    : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, k)
    init_X_ip1_jm1_k     : in  sl;
    initial_X_ip1_jm1_k  : in  slv(CELL_WIDTH-1 downto 0);
    init2_X_ip1_jm1_k    : in  sl;
    initial2_X_ip1_jm1_k : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+2, j, k)
    init_X_ip2_j_k       : in  sl;
    initial_X_ip2_j_k    : in  slv(CELL_WIDTH-1 downto 0);
    init2_X_ip2_j_k      : in  sl;
    initial2_X_ip2_j_k   : in  slv(CELL_WIDTH-1 downto 0);

    -- sequence characters: initialization input
    -- sequence character S_i
    init_S_i             : in  sl;
    initial_S_i          : in  slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    init_S_j             : in  sl;
    initial_S_j          : in  slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    in_start_aggr        : in  sl;   -- start max aggregating along k axis
    in_init_pipe58       : in  sl;   -- initialize pipelines 5 and 8

    in_clust_start_aggr  : in  sl;   -- start max aggregating along k axis
    in_clust_init_pipe58 : in  sl;   -- initialize pipelines 5 and 8

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

    -- X7(i, j-1, k-1) clustered input
    in_clust_X7_i_jm1_km1 : in  slv(CELL_WIDTH-1 downto 0);

    -- sequence character S_i
    in_S_i               : in  slv(RESIDUE_WIDTH-1 downto 0);

    -- input valid bit: pass thru
    in_vld               : in  sl;

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
    out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0);

    -- output valid bit: used to recognize target score X(1)(N)(1)
    out_vld              : out sl
    );
end entity;

architecture rtl of pe_clustered_bottom is

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
  signal in_X_ip1_j_k_1   : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal in_X_i_jm1_k_1   : slv(CELL_WIDTH-1 downto 0);

  -- 4 clocks
  signal in_X_ip1_jm1_k_1 : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_jm1_k_2 : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_jm1_k_3 : slv(CELL_WIDTH-1 downto 0);

  -- 4 clocks
  signal in_X_ip2_j_k_1   : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip2_j_k_2   : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip2_j_k_3   : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal in_X5_i_jm1_k_1  : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal in_X8_ip1_j_k_1  : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks each
  signal in_S_i_1         : slv(RESIDUE_WIDTH-1 downto 0);
  signal in_S_j_1         : slv(RESIDUE_WIDTH-1 downto 0);
  
  -- 2 clocks
  signal in_vld_1         : sl;

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X5_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X6_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X8_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);

  signal X_ip1_j_k_gt_X_i_jm1_k  : sl;
  signal X_ip1_j_k_max_X_i_jm1_k : slv(CELL_WIDTH-1 downto 0);

  signal base_pair_xor           : slv(RESIDUE_WIDTH-1 downto 0);
  signal base_pair               : sl;

  signal X_ip1_jm1_k_plus_delta  : slv(CELL_WIDTH-1 downto 0);

  signal X_max_simple3_gt        : sl;
  signal X_max_simple3           : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt       : sl;
  signal X_max_pipeline          : slv(CELL_WIDTH-1 downto 0);

  signal X_max_kaggr_gt          : sl;
  signal X_max_kaggr             : slv(CELL_WIDTH-1 downto 0);

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

  signal S_i         : slv(RESIDUE_WIDTH-1 downto 0);
  signal S_j         : slv(RESIDUE_WIDTH-1 downto 0);

  signal vld         : sl;

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

        in_X_ip1_j_k_1         <= (others => '0');

        in_X_i_jm1_k_1         <= (others => '0');

        in_X_ip1_jm1_k_1       <= (others => '0');
        in_X_ip1_jm1_k_2       <= (others => '0');
        in_X_ip1_jm1_k_3       <= (others => '0');

        in_X_ip2_j_k_1         <= (others => '0');
        in_X_ip2_j_k_2         <= (others => '0');
        in_X_ip2_j_k_3         <= (others => '0');

        in_X5_i_jm1_k_1        <= (others => '0');

        in_X8_ip1_j_k_1        <= (others => '0');

        in_S_i_1               <= (others => '0');
        in_S_j_1               <= (others => '0');

        in_vld_1               <= '0';
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
        if init_X_ip1_j_k = '1' then
          -- initialize border value
          in_X_ip1_j_k_1       <= initial_X_ip1_j_k;
        else
          in_X_ip1_j_k_1       <= X_i_j_k;
        end if;

        -- 2 clocks
        if init_X_i_jm1_k = '1' then
          -- initialize border value
          in_X_i_jm1_k_1       <= initial_X_i_jm1_k;
        else
          in_X_i_jm1_k_1       <= in_X_i_jm1_k;
        end if;

        -- 4 clocks
        if init_X_ip1_jm1_k = '1' then
          -- initialize first border value
          in_X_ip1_jm1_k_1     <= initial_X_ip1_jm1_k;
        elsif init2_X_ip1_jm1_k = '1' then
          -- initialize second border value
          in_X_ip1_jm1_k_1     <= initial2_X_ip1_jm1_k;
        else
          in_X_ip1_jm1_k_1     <= in_X_ip1_jm1_k;
        end if;
        in_X_ip1_jm1_k_2       <= in_X_ip1_jm1_k_1;
        in_X_ip1_jm1_k_3       <= in_X_ip1_jm1_k_2;

        -- 4 clocks
        if init_X_ip2_j_k = '1' then
          -- initialize first border value
          in_X_ip2_j_k_1       <= initial_X_ip2_j_k;
        elsif init2_X_ip2_j_k = '1' then
          -- initialize second border value
          in_X_ip2_j_k_1       <= initial2_X_ip2_j_k;
        else
          in_X_ip2_j_k_1       <= X_i_j_k;
        end if;
        in_X_ip2_j_k_2         <= in_X_ip2_j_k_1;
        in_X_ip2_j_k_3         <= in_X_ip2_j_k_2;

        -- 2 clocks
        in_X5_i_jm1_k_1        <= in_X5_i_jm1_k;

        -- 2 clocks
        in_X8_ip1_j_k_1        <= X8_i_j_k;

        -- 2 clocks each
        if init_S_i = '1' then
          -- initialize sequence character from input
          in_S_i_1             <= initial_S_i;
        else
          -- take value from previous cell
          in_S_i_1             <= in_S_i;
        end if;

        if init_S_j = '1' then
          -- initialize sequence character from input
          in_S_j_1             <= initial_S_j;
        else
          -- retain previous value
          in_S_j_1             <= S_j;
        end if;

        in_vld_1               <= in_vld;
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

  clustered_X6_ip1_j_km1 <= X6_i_j_k when pe_in_progress = '1'
                            else (others => '0');
  clustered_X7_i_jm1_km1 <= in_clust_X7_i_jm1_km1 when pe_in_progress = '1'
                            else (others => '0');

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

  X6_i_j_k_max <= in_X_ip2_j_k_3 when pe_in_progress = '0' else
                  clustered_X6_ip1_j_km1;

  -----------------------------------------------------------------------------
  -- Pipeline variable X7
  -----------------------------------------------------------------------------

  X7_i_j_k_max <= in_X_i_jm1_k_1 when pe_in_progress = '0' else
                  clustered_X7_i_jm1_km1;

  -----------------------------------------------------------------------------
  -- Pipeline variable X8
  -----------------------------------------------------------------------------

  X8_i_j_k_max <= X6_i_j_k_max when clustered_init_pipe58 = '1' else
                  in_X8_ip1_j_k_1;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

  -- max ( X(i + 1, j, k) , X(i, j - 1, k) );
  X_ip1_j_k_gt_X_i_jm1_k  <= '1' when in_X_ip1_j_k_1 > in_X_i_jm1_k_1 else
                             '0';
  X_ip1_j_k_max_X_i_jm1_k <= in_X_ip1_j_k_1 when X_ip1_j_k_gt_X_i_jm1_k = '1'
                             else
                             in_X_i_jm1_k_1;

  -- a base is defined as a A, U pair or a C, G pair
  -- Encoding for residues: A = 000, C = 001, G = 010, U = 011
  -- We have a A, U or C, G if and only if S[i] xor S[j] = 11
  --           and they are both valid residues
  base_pair_xor <= in_S_i_1 xor in_S_j_1;
  base_pair     <= not (in_S_i_1(2) or in_S_j_1(2)) when
                   (base_pair_xor(1 downto 0) = "11") else
                   '0';

  -- X(i + 1, j - 1, k) + delta (S_i, S_j)
  X_ip1_jm1_k_plus_delta <= in_X_ip1_jm1_k_3 + base_pair;

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

  -- Compute max of aggregate term and pipeline
  X_max_kaggr_gt <= '1' when X_max_pipeline > X_kaggr
                    else
                    '0';
  X_max_kaggr    <= X_max_pipeline when X_max_kaggr_gt = '1'
                    else
                    X_kaggr;



  -- Compute final max between top 3 dependencies, k aggregate
  -- and the pipeline dependencies
  X_all_gt <= '1' when X_max_simple3 > X_max_kaggr
              else
              '0';
  X_all    <= X_max_simple3 when
              (X_all_gt and (not pe_in_progress)) = '1'
              else
              X_max_kaggr;

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

        -- register sequence
        S_i         <= (others => '0');
        S_j         <= (others => '0');

        vld         <= '0';
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

        -- register sequence
        S_i         <= in_S_i_1;
        S_j         <= in_S_j_1;

        vld         <= in_vld_1;
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

  out_S_i         <= S_i;

  out_vld         <= vld;

end rtl;
