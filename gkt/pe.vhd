
-- File: pe.vhd
-- Date: 10 Feb 2008
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing the nussinov GKT array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe is
  port (
    clk              : in  sl;
    reset            : in  sl;

    --
    -- INPUT
    --
    -- input control signals
    in_start_aggr    : in  sl;   -- start max aggregating along k axis
    in_end_aggr      : in  sl;   -- complete max aggregating along k axis
    in_init_pipe58   : in  sl;   -- initialize pipelines 5 and 8
    in_init_pipe67   : in  sl;   -- initialize pipelines 6 and 7

    -- X dependencies
    -- X(i+1, j, k)
    in_X_south       : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i, j-1, k)
    in_X_west        : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, k)
    in_X_south_west  : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+2, j, k)
    in_X_south_x2    : in  slv(CELL_WIDTH-1 downto 0);

    -- pipeline dependencies
    -- X5(i, j-1, k)
    in_X5_west       : in  slv(CELL_WIDTH-1 downto 0);
    -- X6(i+1, j, k-1)
    in_X6_south      : in  slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j-1, k-1)
    in_X7_west       : in  slv(CELL_WIDTH-1 downto 0);
    -- X8(i+1, j, k)
    in_X8_south      : in  slv(CELL_WIDTH-1 downto 0);

    -- sequence character S_i
    in_S_i           : in  slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    in_S_j           : in  slv(RESIDUE_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X dependencies
    -- X(i+1, j, k)
    out_X_north      : out slv(CELL_WIDTH-1 downto 0);
    -- X(i, j-1, k)
    out_X_east       : out slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, k)
    out_X_north_east : out slv(CELL_WIDTH-1 downto 0);
    -- X(i+2, j, k)
    out_X_north_x2   : out slv(CELL_WIDTH-1 downto 0);

    -- pipeline dependencies
    -- X5(i, j-1, k)
    out_X5           : out slv(CELL_WIDTH-1 downto 0);
    -- X6(i+1, j, k-1)
    out_X6           : out slv(CELL_WIDTH-1 downto 0);
    -- X7(i, j-1, k-1)
    out_X7           : out slv(CELL_WIDTH-1 downto 0);
    -- X8(i+1, j, k)
    out_X8           : out slv(CELL_WIDTH-1 downto 0);

    -- output control signals
    out_start_aggr   : out sl;
    out_end_aggr     : out sl;
    out_init_pipe58  : out sl;
    out_init_pipe67  : out sl;

    -- output sequence characters
    out_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
    out_S_j          : out slv(RESIDUE_WIDTH-1 downto 0)
    );
end entity;

architecture rtl of pe is

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X5_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X6_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);
  signal X8_i_j_k_max            : slv(CELL_WIDTH-1 downto 0);

  signal X5_i_j_k_plus_X6_i_j_k  : slv(CELL_WIDTH-1 downto 0);
  signal X7_i_j_k_plus_X8_i_j_k  : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                 : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt       : sl;
  signal X_max_pipeline          : slv(CELL_WIDTH-1 downto 0);

  signal X_max_kaggr_gt          : sl;
  signal X_max_kaggr             : slv(CELL_WIDTH-1 downto 0);

  signal X_ip1_j_k_gt_X_i_jm1_k  : sl;
  signal X_ip1_j_k_max_X_i_jm1_k : slv(CELL_WIDTH-1 downto 0);

  signal base_pair_xor           : slv(RESIDUE_WIDTH-1 downto 0);
  signal base_pair               : slv(CELL_WIDTH-1 downto 0);

  signal X_ip1_jm1_k_plus_delta  : slv(CELL_WIDTH-1 downto 0);

  signal X_max_simple3_gt        : sl;
  signal X_max_simple3           : slv(CELL_WIDTH-1 downto 0);

  signal X_all_gt                : sl;
  signal X_all                   : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  signal X           : slv(CELL_WIDTH-1 downto 0);
  signal X5          : slv(CELL_WIDTH-1 downto 0);
  signal X6          : slv(CELL_WIDTH-1 downto 0);
  signal X7          : slv(CELL_WIDTH-1 downto 0);
  signal X8          : slv(CELL_WIDTH-1 downto 0);

  signal start_aggr  : sl;
  signal end_aggr    : sl;
  signal init_pipe58 : sl;
  signal init_pipe67 : sl;

  signal S_i         : slv(RESIDUE_WIDTH-1 downto 0);
  signal S_j         : slv(RESIDUE_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Register output signals to keep in synch with the timing function
  -----------------------------------------------------------------------------
  -- 3 clocks
  signal start_aggr_1   : sl;
  signal start_aggr_2   : sl;

  -- 2 clocks
  signal end_aggr_1     : sl;

  -- 3 clocks
  signal init_pipe58_1  : sl;
  signal init_pipe58_2  : sl;

  -- 2 clocks
  signal init_pipe67_1  : sl;

  -- 2 clocks
  signal X_north_1      : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal X_east_1       : slv(CELL_WIDTH-1 downto 0);

  -- 4 clocks
  signal X_north_east_1 : slv(CELL_WIDTH-1 downto 0);
  signal X_north_east_2 : slv(CELL_WIDTH-1 downto 0);
  signal X_north_east_3 : slv(CELL_WIDTH-1 downto 0);

  -- 4 clocks
  signal X_north_x2_1   : slv(CELL_WIDTH-1 downto 0);
  signal X_north_x2_2   : slv(CELL_WIDTH-1 downto 0);
  signal X_north_x2_3   : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal X5_1           : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks
  signal X8_1           : slv(CELL_WIDTH-1 downto 0);

  -- 2 clocks each
  signal S_i_1          : slv(RESIDUE_WIDTH-1 downto 0);
  signal S_j_1          : slv(RESIDUE_WIDTH-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- Compute values for data variables
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Pipeline variable X5
  -----------------------------------------------------------------------------

  X5_i_j_k_max <= X7_i_j_k_max when in_init_pipe58 = '1' else
                  in_X5_west;

  -----------------------------------------------------------------------------
  -- Pipeline variable X6
  -----------------------------------------------------------------------------

  X6_i_j_k_max <= in_X_south_x2 when in_init_pipe67 = '1' else
                  in_X6_south;

  -----------------------------------------------------------------------------
  -- Pipeline variable X7
  -----------------------------------------------------------------------------

  X7_i_j_k_max <= in_X_west when in_init_pipe67 = '1' else
                  in_X7_west;

  -----------------------------------------------------------------------------
  -- Pipeline variable X8
  -----------------------------------------------------------------------------

  X8_i_j_k_max <= X6_i_j_k_max when in_init_pipe58 = '1' else
                  in_X8_south;

  -----------------------------------------------------------------------------
  -- Sum pipeline variables
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
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr = '1'
             else
             X;

  -- Compute max of aggregate term and pipeline
  X_max_kaggr_gt <= '1' when X_max_pipeline > X_kaggr
                    else
                    '0';
  X_max_kaggr    <= X_max_pipeline when X_max_kaggr_gt = '1'
                    else
                    X_kaggr;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

  -- max ( X(i + 1, j, k) , X(i, j - 1, k) );
  X_ip1_j_k_gt_X_i_jm1_k  <= '1' when in_X_south > in_X_west else
                             '0';
  X_ip1_j_k_max_X_i_jm1_k <= in_X_south when X_ip1_j_k_gt_X_i_jm1_k = '1'
                             else
                             in_X_west;

  -- a base is defined as a A, U pair or a C, G pair
  -- Encoding for residues: A = 000, C = 001, G = 010, U = 011
  -- We have a A, U or C, G if and only if S[i] xor S[j] = 11
  --           and they are both valid residues
  base_pair_xor <= in_S_i xor in_S_j;
  base_pair(CELL_WIDTH-1 downto 1) <= (others => '0');
  base_pair(0)  <= not (in_S_i(2) or in_S_j(2)) when
                   (base_pair_xor(1 downto 0) = "11") else
                   '0';

  -- X(i + 1, j - 1, k) + delta (S_i, S_j)
  X_ip1_jm1_k_plus_delta <= in_X_south_west + base_pair;

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


  -- Compute final max between top 3 dependencies, k aggregate
  -- and the pipeline dependencies
  X_all_gt  <= '1' when X_max_simple3 > X_max_kaggr else '0';
  X_all     <= X_max_simple3 when
               (X_all_gt and in_end_aggr) = '1'
               else
               X_max_kaggr;

  -----------------------------------------------------------------------------
  -- Process to register computed values for data variables and to keep in
  -- synch with timing function
  -----------------------------------------------------------------------------
  reg_values: process (clk)
  begin 
    if rising_edge(clk) then
--      if reset = '1' then
--        X              <= (others => '0');
--        X_north_1      <= (others => '0');
--        X_east_1       <= (others => '0');
--        X_north_east_1 <= (others => '0');
--        X_north_east_2 <= (others => '0');
--        X_north_east_3 <= (others => '0');
--        X_north_x2_1   <= (others => '0');
--        X_north_x2_2   <= (others => '0');
--        X_north_x2_3   <= (others => '0');

--        X5             <= (others => '0');
--        X5_1           <= (others => '0');
---        X6             <= (others => '0');
--        X7             <= (others => '0');
--        X8             <= (others => '0');
--        X8_1           <= (others => '0');

--        start_aggr     <= '0';
--        start_aggr_1   <= '0';
--        start_aggr_2   <= '0';
--        end_aggr       <= '0';
--        end_aggr_1     <= '0';
--        init_pipe58    <= '0';
--        init_pipe58_1  <= '0';
--        init_pipe58_2  <= '0';
--        init_pipe67    <= '0';
--        init_pipe67_1  <= '0';

--        S_i            <= (others => '0');
--        S_i_1          <= (others => '0');
--        S_j            <= (others => '0');
--        S_j_1          <= (others => '0');
--      else
        -- register computed values: output
        X              <= X_all;
        X_north_1      <= X;

        X_east_1       <= X;

        X_north_east_1 <= X;
        X_north_east_2 <= X_north_east_1;
        X_north_east_3 <= X_north_east_2;

        X_north_x2_1   <= X;
        X_north_x2_2   <= X_north_x2_1;
        X_north_x2_3   <= X_north_x2_2;

        X5             <= X5_i_j_k_max;
        X5_1           <= X5;

        X6             <= X6_i_j_k_max;
        X7             <= X7_i_j_k_max;

        X8             <= X8_i_j_k_max;
        X8_1           <= X8;

        -- register control signals
        start_aggr     <= in_start_aggr;
        start_aggr_1   <= start_aggr;
        start_aggr_2   <= start_aggr_1;

        end_aggr       <= in_end_aggr;
        end_aggr_1     <= end_aggr;

        init_pipe58    <= in_init_pipe58;
        init_pipe58_1  <= init_pipe58;
        init_pipe58_2  <= init_pipe58_1;

        init_pipe67    <= in_init_pipe67;
        init_pipe67_1  <= init_pipe67;

        -- register sequence
        S_i            <= in_S_i;
        S_i_1          <= S_i;

        S_j            <= in_S_j;
        S_j_1          <= S_j;
--      end if;
    end if;  -- end rising_edge
  end process reg_values;

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------
  out_X_north      <= X_north_1;
  out_X_east       <= X_east_1;
  out_X_north_east <= X_north_east_3;
  out_X_north_x2   <= X_north_x2_3;

  out_X5           <= X5_1;
  out_X6           <= X6;
  out_X7           <= X7;
  out_X8           <= X8_1;

  out_start_aggr   <= start_aggr_2;
  out_end_aggr     <= end_aggr_1;
  out_init_pipe58  <= init_pipe58_2;
  out_init_pipe67  <= init_pipe67_1;

  out_S_i          <= S_i_1;
  out_S_j          <= S_j_1;

end rtl;
