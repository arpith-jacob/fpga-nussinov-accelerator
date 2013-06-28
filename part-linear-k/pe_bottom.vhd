
-- File: pe_bottom.vhd
-- Date: 27 July 2010
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing the bottom cells of the partitioned linear-k
-- nussinov array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_bottom is
  port (
    clk                      : in  sl;
    reset                    : in  sl;

    --
    -- INPUT
    --
    -- INITIALIZATION
    --
    -- X(i+1, j, vk, k')
    init_X_ip1_j_vk_kp       : in  sl;
    initial_X_ip1_j_vk_kp    : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i, j-1, vk, k')
    init_X_i_jm1_vk_kp       : in  sl;
    initial_X_i_jm1_vk_kp    : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+1, j-1, vk, k')
    init_X_ip1_jm1_vk_kp     : in  sl;
    initial_X_ip1_jm1_vk_kp  : in  slv(CELL_WIDTH-1 downto 0);
    -- X(i+2, j, vk, k')
    init_X_ip2_j_vk_kp       : in  sl;
    initial_X_ip2_j_vk_kp    : in  slv(CELL_WIDTH-1 downto 0);

    -- sequence characters: initialization input
    -- sequence character S_i
    init_S_i                 : in  sl;
    initial_S_i              : in  slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    init_S_j                 : in  sl;
    initial_S_j              : in  slv(RESIDUE_WIDTH-1 downto 0);

    -- input control signals
    in_start_aggr            : in  sl;
                             -- start max aggregating along k axis
    in_init_pipe14           : in  sl;
                              -- initialize pipelines 2 and 4

    -- DEPENDENCIES
    --
    -- X dependencies
    -- X(i, j, vk, k'+1)
    in_X_i_j_vk_kpp1         : in  slv(CELL_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X(i, j, vk, k')
    out_X_i_j_vk_kp          : out slv(CELL_WIDTH-1 downto 0);
    -- X2(i, j, vk, k')
    out_X2_i_j_vk_kp         : out slv(CELL_WIDTH-1 downto 0);
    -- X3(i, j, vk, k')
    out_X3_i_j_vk_kp         : out slv(CELL_WIDTH-1 downto 0);

    -- output control signals
    out_start_aggr           : out sl;
    out_init_pipe14          : out sl
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
  -- State of processing element
  -----------------------------------------------------------------------------
  signal state_counter                  : slv(15 downto 0);
  signal vk_eq_1                        : sl;
  signal vk_eq_tile_width_k             : sl;

  -----------------------------------------------------------------------------
  -- Mux signal along communication link: either an initialization value, or
  -- the value sent from a processing element
  -----------------------------------------------------------------------------
  signal mux_X_ip1_j_vk_kp             : slv(CELL_WIDTH-1 downto 0);
  signal mux_X_i_jm1_vk_kp             : slv(CELL_WIDTH-1 downto 0);
  signal mux_X_ip1_jm1_vk_kp           : slv(CELL_WIDTH-1 downto 0);
  signal mux_X_ip2_j_vk_kp             : slv(CELL_WIDTH-1 downto 0);

  signal mux_S_i                       : slv(RESIDUE_WIDTH-1 downto 0);
  signal mux_S_j                       : slv(RESIDUE_WIDTH-1 downto 0);

  signal in_X_ip1_j_vk_kp_delayed      : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_jm1_vk_kp_delayed      : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip1_jm1_vk_kp_delayed    : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_j_vkp1_kp_delayed      : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_j_1_kpp1_delayed       : slv(CELL_WIDTH-1 downto 0);
  signal in_X_ip2_j_vk_kp_delayed      : slv(CELL_WIDTH-1 downto 0);
  signal in_X1_i_jm1_vk_kp_delayed     : slv(CELL_WIDTH-1 downto 0);
  signal in_X2_ip1_j_vkm1_kp_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X3_i_jm1_vkm1_kp_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X4_ip1_j_vk_kp_delayed     : slv(CELL_WIDTH-1 downto 0);

  signal in_S_i_delayed                : slv(RESIDUE_WIDTH-1 downto 0);
  signal in_S_j_delayed                : slv(RESIDUE_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X1_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);
  signal X2_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);
  signal X4_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);

  signal X_ip1_j_vk_kp_gt_X_i_jm1_vk_kp  : sl;
  signal X_ip1_j_vk_kp_max_X_i_jm1_vk_kp : slv(CELL_WIDTH-1 downto 0);

  signal base_pair_xor                   : slv(RESIDUE_WIDTH-1 downto 0);
  signal base_pair                       : sl;

  signal X_ip1_jm1_vk_kp_plus_delta      : slv(CELL_WIDTH-1 downto 0);

  signal X_max_simple3_gt                : sl;
  signal X_max_simple3                   : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt               : sl;
  signal X_max_pipeline                  : slv(CELL_WIDTH-1 downto 0);

  signal X1_i_j_vk_kp_plus_X2_i_j_vk_kp  : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_j_vk_kp_plus_X4_i_j_vk_kp  : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                         : slv(CELL_WIDTH-1 downto 0);

  signal X_pipeline_gt_kaggr             : sl;
  signal X_pipeline_max_kaggr            : slv(CELL_WIDTH-1 downto 0);

  signal X_all_gt                        : sl;
  signal X_all                           : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  signal X_i_j_vk_kp     : slv(CELL_WIDTH-1 downto 0);
  signal X1_i_j_vk_kp    : slv(CELL_WIDTH-1 downto 0);
  signal X2_i_j_vk_kp    : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_j_vk_kp    : slv(CELL_WIDTH-1 downto 0);
  signal X4_i_j_vk_kp    : slv(CELL_WIDTH-1 downto 0);

  signal start_aggr  : sl;
  signal init_pipe14 : sl;

  signal S_i         : slv(RESIDUE_WIDTH-1 downto 0);
  signal S_j         : slv(RESIDUE_WIDTH-1 downto 0);

begin


  -----------------------------------------------------------------------------
  -- Delay communication links according to the schedule
  -----------------------------------------------------------------------------
  -- X(i+1, j, vk, k')
  delay_X_ip1_j_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_vk_kp,
      dout           => mux_X_ip1_j_vk_kp
      );
  in_X_ip1_j_vk_kp_delayed <= initial_X_ip1_j_vk_kp when init_X_ip1_j_vk_kp = '1' else
                              mux_X_ip1_j_vk_kp;

  -- X(i, j-1, vk, k')
  delay_X_i_jm1_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, -1, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_vk_kp,
      dout           => mux_X_i_jm1_vk_kp
      );
  in_X_i_jm1_vk_kp_delayed <= initial_X_i_jm1_vk_kp when init_X_i_jm1_vk_kp = '1' else
                              mux_X_i_jm1_vk_kp;

  -- X(i+1, j-1, vk, k')
  delay_X_ip1_jm1_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, -1, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_vk_kp,
      dout           => mux_X_ip1_jm1_vk_kp
      );
  in_X_ip1_jm1_vk_kp_delayed <= initial_X_ip1_jm1_vk_kp when init_X_ip1_jm1_vk_kp = '1'
                                else mux_X_ip1_jm1_vk_kp;

  -- X(i, j, vk+1, k')
  delay_X_i_j_vkp1_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, 0, 1, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_vk_kp,
      dout           => in_X_i_j_vkp1_kp_delayed
      );

  -- X(i, j, 1, k'+1)
  delay_X_i_j_1_kpp1 : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, 0, 1 - TILE_WIDTH_K, 1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X_i_j_vk_kpp1,
      dout           => in_X_i_j_1_kpp1_delayed
      );

  -- X(i+2, j, vk, k')
  delay_X_ip2_j_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(2, 0, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X_i_j_vk_kp,
      dout           => mux_X_ip2_j_vk_kp
      );
  in_X_ip2_j_vk_kp_delayed <= initial_X_ip2_j_vk_kp when init_X_ip2_j_vk_kp = '1' else
                              mux_X_ip2_j_vk_kp;

  -- X1(i, j-1, vk, k')
  delay_X1_i_jm1_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, -1, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X1_i_j_vk_kp,
      dout           => in_X1_i_jm1_vk_kp_delayed
      );

  -- X2(i+1, j, vk-1, k')
  delay_X2_ip1_j_vkm1_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, -1, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X2_i_j_vk_kp,
      dout           => in_X2_ip1_j_vkm1_kp_delayed
      );

  -- X3(i, j-1, vk-1, k')
  delay_X3_i_jm1_vkm1_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, -1, -1, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X3_i_j_vk_kp,
      dout           => in_X3_i_jm1_vkm1_kp_delayed
      );

  -- X4(i+1, j, vk, k')
  delay_X4_ip1_j_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => X4_i_j_vk_kp,
      dout           => in_X4_ip1_j_vk_kp_delayed
      );

  -- S_i(i, j-1, vk, k')
  delay_Si_i_jm1_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => -SCHEDULE(0, -1, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => S_i,
      dout           => mux_S_i
      );
  in_S_i_delayed <= initial_S_i when init_S_i = '1' else
                    mux_S_i;

  -- S_j(i+1, j, vk, k')
  delay_Sj_ip1_j_vk_kp : delay_pipe
    generic map (
      DATA_WIDTH     => RESIDUE_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, 0, 0),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => S_j,
      dout           => mux_S_j
      );
  in_S_j_delayed <= initial_S_j when init_S_j = '1' else
                    mux_S_j;

  -----------------------------------------------------------------------------
  -- Compute state of PE
  -----------------------------------------------------------------------------

  gen_state : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        state_counter            <= conv_std_logic_vector(RESET_STATE,
                                                          state_counter'length);

        vk_eq_1                  <= '0';
        vk_eq_tile_width_k       <= '0';
      else
        state_counter            <= state_counter - 1;

        if state_counter = 1 then
          state_counter          <= conv_std_logic_vector(TILE_WIDTH_K,
                                                          state_counter'length);
        end if;

        -- v_k = 1.  use this signal to mux input
        if state_counter = 2 then -- next clock has v_k = 1
          vk_eq_1                <= '1';
        else
          vk_eq_1                <= '0';
        end if;

        -- v_k = TILE_WIDTH_K.
        if state_counter = 1 then  -- next clock has v_k = TILE_WIDTH_K
          vk_eq_tile_width_k <= '1';
        else
          vk_eq_tile_width_k <= '0';
        end if;
      end if;
    end if;  -- end rising_edge
  end process gen_state;

  -----------------------------------------------------------------------------
  -- Compute values for data variables
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Pipeline variable X1
  -----------------------------------------------------------------------------

  X1_i_j_vk_kp_max <= X3_i_j_vk_kp_max when in_init_pipe14 = '1' else
                      in_X1_i_jm1_vk_kp_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X2
  -----------------------------------------------------------------------------

  X2_i_j_vk_kp_max <= in_X_ip2_j_vk_kp_delayed when vk_eq_1 = '1' else
                      in_X2_ip1_j_vkm1_kp_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X3
  -----------------------------------------------------------------------------

  X3_i_j_vk_kp_max <= in_X_i_jm1_vk_kp_delayed when vk_eq_1 = '1' else
                      in_X3_i_jm1_vkm1_kp_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X4
  -----------------------------------------------------------------------------

  X4_i_j_vk_kp_max <= X2_i_j_vk_kp_max when in_init_pipe14 = '1' else
                      in_X4_ip1_j_vk_kp_delayed;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

  -- max ( X(i + 1, j, vk, k') , X(i, j - 1, vk, k') );
  X_ip1_j_vk_kp_gt_X_i_jm1_vk_kp  <= '1' when in_X_ip1_j_vk_kp_delayed >
                                              in_X_i_jm1_vk_kp_delayed else
                                     '0';
  X_ip1_j_vk_kp_max_X_i_jm1_vk_kp <= in_X_ip1_j_vk_kp_delayed when
                                       X_ip1_j_vk_kp_gt_X_i_jm1_vk_kp = '1'
                                     else
                                       in_X_i_jm1_vk_kp_delayed;

  -- a base is defined as a A, U pair or a C, G pair
  -- Encoding for residues: A = 000, C = 001, G = 010, U = 011
  -- We have a A, U or C, G if and only if S[i] xor S[j] = 11
  --           and they are both valid residues
  base_pair_xor <= in_S_i_delayed xor in_S_j_delayed;
  base_pair     <= not (in_S_i_delayed(2) or in_S_j_delayed(2)) when
                   (base_pair_xor(1 downto 0) = "11") else
                   '0';

  -- X(i + 1, j - 1, vk, k') + delta (S_i, S_j)
  X_ip1_jm1_vk_kp_plus_delta <= in_X_ip1_jm1_vk_kp_delayed + base_pair;

  -- max of top 3 simple dependencies
  -- max ( X(i + 1, j - 1, k) + delta (S_i, S_j),
  --       X(i + 1, j, k), X(i, j - 1, k)
  --     )
  X_max_simple3_gt <= '1' when X_ip1_j_vk_kp_max_X_i_jm1_vk_kp >
                                X_ip1_jm1_vk_kp_plus_delta
                      else
                      '0';
  X_max_simple3    <= X_ip1_j_vk_kp_max_X_i_jm1_vk_kp when X_max_simple3_gt = '1'
                      else
                      X_ip1_jm1_vk_kp_plus_delta;



  -- X1(i, j, vk, k') + X2(i, j, vk, k')
  X1_i_j_vk_kp_plus_X2_i_j_vk_kp <= X1_i_j_vk_kp_max + X2_i_j_vk_kp_max;

  -- X3(i, j, vk, k') + X4(i, j, vk, k')
  X3_i_j_vk_kp_plus_X4_i_j_vk_kp <= X3_i_j_vk_kp_max + X4_i_j_vk_kp_max;
  
  -- max of pipeline dependencies
  -- max ( X1(i, j, vk, k') + X2(i, j, vk, k'),
  --       X3(i, j, vk, k') + X4(i, j, vk, k')
  --     )
  X_max_pipeline_gt <= '1' when X1_i_j_vk_kp_plus_X2_i_j_vk_kp >
                                X3_i_j_vk_kp_plus_X4_i_j_vk_kp
                       else '0';
  X_max_pipeline    <= X1_i_j_vk_kp_plus_X2_i_j_vk_kp when X_max_pipeline_gt = '1'
                       else
                       X3_i_j_vk_kp_plus_X4_i_j_vk_kp;

  -- Compute aggregate term: initialize, or previous value
  -- X(i, j, k + 1)
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr = '1' else
             in_X_i_j_1_kpp1_delayed       when vk_eq_tile_width_k = '1' else
             in_X_i_j_vkp1_kp_delayed;

  X_pipeline_gt_kaggr  <= '1' when X_max_pipeline > X_kaggr
                          else
                          '0';
  X_pipeline_max_kaggr <= X_max_pipeline when X_pipeline_gt_kaggr = '1'
                         else
                         X_kaggr;

  -- Compute final max between top 3 dependencies, k aggregate
  -- and the pipeline dependencies
  X_all_gt <= '1' when X_max_simple3 > X_pipeline_max_kaggr
              else
              '0';
  X_all    <= X_max_simple3 when X_all_gt = '1' and vk_eq_1 = '1'
              else
              X_pipeline_max_kaggr;

  -----------------------------------------------------------------------------
  -- Assign signals for data variables
  -----------------------------------------------------------------------------
  X_i_j_vk_kp  <= X_all;
  X1_i_j_vk_kp <= X1_i_j_vk_kp_max;
  X2_i_j_vk_kp <= X2_i_j_vk_kp_max;
  X3_i_j_vk_kp <= X3_i_j_vk_kp_max;
  X4_i_j_vk_kp <= X4_i_j_vk_kp_max;

  S_i          <= in_S_i_delayed;
  S_j          <= in_S_j_delayed;

  start_aggr   <= in_start_aggr;
  init_pipe14  <= in_init_pipe14;

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_j_vk_kp  <= X_i_j_vk_kp;
  out_X2_i_j_vk_kp <= X2_i_j_vk_kp;
  out_X3_i_j_vk_kp <= X3_i_j_vk_kp;

  out_start_aggr   <= start_aggr;
  out_init_pipe14  <= init_pipe14;

end rtl;
