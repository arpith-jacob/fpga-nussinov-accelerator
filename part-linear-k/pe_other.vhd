
-- File: pe_other.vhd
-- Date: 28 July 2010
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing all except the bottom cells of the
--      Processing element implementing all except the bottom cells of the
-- partitioned linear-k nussinov array.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_other is
  generic (
    -- When true delay registers are placed in block ram memories
    USE_BRAM             : boolean := false
    );
  port (
    clk                  : in  sl;
    reset                : in  sl;

    --
    -- INPUT
    --
    -- input control signals
    in_start_aggr        : in  sl;   -- start max aggregating along k axis
    in_init_pipe14       : in  sl;   -- initialize pipelines 5 and 8

    -- X dependencies
    -- X(i, j, vk, k'+1)
    in_X_i_j_vk_kpp1     : in  slv(CELL_WIDTH-1 downto 0);

    -- pipeline dependencies
    -- X2(i+1, j, k-1)
    in_X2_ip1_j_km1      : in  slv(CELL_WIDTH-1 downto 0);
    -- X3(i, j-1, k-1)
    in_X3_i_jm1_km1      : in  slv(CELL_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X(i, j, vk, k')
    out_X_i_j_vk_kp      : out slv(CELL_WIDTH-1 downto 0);
    -- X2(i, j, vk, k')
    out_X2_i_j_vk_kp     : out slv(CELL_WIDTH-1 downto 0);
    -- X3(i, j, vk, k')
    out_X3_i_j_vk_kp     : out slv(CELL_WIDTH-1 downto 0);

    -- output control signals
    out_start_aggr       : out sl;
    out_init_pipe14      : out sl
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

  component delay_fifo_2k is
    port (
      rd_en : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      clk : in STD_LOGIC := 'X'; 
      srst : in STD_LOGIC := 'X'; 
      dout : out STD_LOGIC_VECTOR ( 17 downto 0 ); 
      din : in STD_LOGIC_VECTOR ( 17 downto 0 ) 
    );
  end component;

  -----------------------------------------------------------------------------
  -- State of processing element
  -----------------------------------------------------------------------------
  signal state_counter               : slv(15 downto 0);
  signal vk_eq_1                     : sl;
  signal vk_eq_tile_width_k          : sl;

  -----------------------------------------------------------------------------
  -- Mux signal along communication link: either an initialization value, or
  -- the value sent from a processing element
  -----------------------------------------------------------------------------
  signal mux_start_aggr              : slv(0 downto 0);
  signal mux_init_pipe14             : slv(0 downto 0);

  signal in_start_aggr_delayed       : slv(0 downto 0);
  signal in_init_pipe14_delayed      : slv(0 downto 0);

  signal in_X_i_j_vkp1_kp_delayed    : slv(CELL_WIDTH-1 downto 0);
  signal in_X_i_j_1_kpp1_delayed     : slv(CELL_WIDTH-1 downto 0);
  signal in_X1_i_jm1_vk_kp_delayed   : slv(CELL_WIDTH-1 downto 0);
  signal in_X2_ip1_j_vkm1_kp_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X2_ip1_j_Wk_kpm1_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X3_i_jm1_vkm1_kp_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X3_i_jm1_Wk_kpm1_delayed : slv(CELL_WIDTH-1 downto 0);
  signal in_X4_ip1_j_vk_kp_delayed   : slv(CELL_WIDTH-1 downto 0);

  -- signals used for FIFO delay
  signal delay_dout_del1             : slv(17 downto 0); 
  signal delay_dout1                 : slv(17 downto 0); 
  signal delay_din1                  : slv(17 downto 0); 

  signal delay_dout_del2             : slv(17 downto 0); 
  signal delay_dout2                 : slv(17 downto 0); 
  signal delay_din2                  : slv(17 downto 0); 

  signal wr_start                    : slv(0 downto 0);
  signal delay_wr                    : slv(0 downto 0);
  signal delay_rd1                   : slv(0 downto 0);
  signal delay_rd2                   : slv(0 downto 0);

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal X1_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);
  signal X2_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);
  signal X4_i_j_vk_kp_max                : slv(CELL_WIDTH-1 downto 0);

  signal X_max_pipeline_gt       : sl;
  signal X_max_pipeline          : slv(CELL_WIDTH-1 downto 0);

  signal X1_i_j_vk_kp_plus_X2_i_j_vk_kp  : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_j_vk_kp_plus_X4_i_j_vk_kp  : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                 : slv(CELL_WIDTH-1 downto 0);

  signal X_all_gt                : sl;
  signal X_all                   : slv(CELL_WIDTH-1 downto 0);

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

begin

  -----------------------------------------------------------------------------
  -- Delay communication links according to the schedule
  -----------------------------------------------------------------------------
  -- start_aggr(i+1, j-1, k-1)   -- to start aggregation at k = (j-i)/2
  mux_start_aggr(0) <= in_start_aggr;
  delay_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => -SCHEDULE(2*TILE_WIDTH_K, 0, 0, -1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => mux_start_aggr,
      dout           => in_start_aggr_delayed
      );

  -- init_pipe14(i+1, j-1, k-1)
  mux_init_pipe14(0) <= in_init_pipe14;
  delay_init_pipe14 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => -SCHEDULE(2*TILE_WIDTH_K, 0, 0, -1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => mux_init_pipe14,
      dout           => in_init_pipe14_delayed
      );

  ---
  -- the following delays do not grow with the sequence length, so we will use LUTs
  -- to implement them
  ---
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

  -- X2(i+1, j, Wk, k'-1)
  delay_X2_ip1_j_Wk_kpm1 : delay_pipe
    generic map (
      DATA_WIDTH     => CELL_WIDTH,
      DELAY_STATES   => -SCHEDULE(1, 0, TILE_WIDTH_K-1, -1),
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => in_X2_ip1_j_km1,
      dout           => in_X2_ip1_j_Wk_kpm1_delayed
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

  -----------------------------------------------------------------------------
  -- Generate memory intensive link delays using LUTS
  -----------------------------------------------------------------------------
  gen_delays_luts : if (not USE_BRAM) generate
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

    -- X3(i, j-1, Wk, k'-1)
    delay_X3_i_jm1_Wk_kpm1 : delay_pipe
      generic map (
        DATA_WIDTH     => CELL_WIDTH,
        DELAY_STATES   => -SCHEDULE(0, -1, TILE_WIDTH_K-1, -1),
        NEEDS_RESET    => false,
        RESET_VAL_HIGH => false
        )
      port map (
        clk            => clk,
        reset          => reset,
        din            => in_X3_i_jm1_km1,
        dout           => in_X3_i_jm1_Wk_kpm1_delayed
        );
  end generate gen_delays_luts;

  -----------------------------------------------------------------------------
  -- Generate memory intensive link delays using block RAMs
  -----------------------------------------------------------------------------
  gen_delays_bram : if (USE_BRAM) generate
    -- delay should not exceed capacity of block ram which is 1024.
    assert (-SCHEDULE(0, -1, -1, 0) <= 2048) report
      "pe_other block ram has insufficient capacity" severity error;

    assert (-SCHEDULE(0, -1, 0, 0) <= 2048) report
      "pe_other block ram has insufficient capacity" severity error;

    -- instantiates block ram
    delay_links1 : delay_fifo_2k
      port map (
        clk    => clk,
        srst   => reset,

        rd_en  => delay_rd1(0),
        dout   => delay_dout_del1,
        full   => open,

        wr_en  => delay_wr(0),
        din    => delay_din1,
        empty  => open
      );

    -- input into delay block ram
    delay_din1  <= "0000" & in_X3_i_jm1_km1 & X3_i_j_vk_kp;

    delay_links2 : delay_fifo_2k
      port map (
        clk    => clk,
        srst   => reset,

        rd_en  => delay_rd2(0),
        dout   => delay_dout_del2,
        full   => open,

        wr_en  => delay_wr(0),
        din    => delay_din2,
        empty  => open
      );

    -- input into delay block ram
    delay_din2  <= "0000" & ZEROES(CELL_WIDTH-1 downto 0) & X1_i_j_vk_kp;

    -- output from delay block ram
    -- register output of FIFO by one clock cycle here to improve timing
    -- we could have placed this flop in the fifo itself, but we place it
    -- here explicitly so that the critical path from the block ram output
    -- to the logic is decreased
    reg_fifo_output : process (clk)
    begin 
      if rising_edge(clk) then
        delay_dout1 <= delay_dout_del1;
        delay_dout2 <= delay_dout_del2;
      end if;  -- end rising_edge
    end process reg_fifo_output;

    in_X3_i_jm1_vkm1_kp_delayed <= delay_dout1(CELL_WIDTH-1 downto 0);
    in_X3_i_jm1_Wk_kpm1_delayed <= delay_dout1(2*CELL_WIDTH-1 downto CELL_WIDTH);
    in_X1_i_jm1_vk_kp_delayed   <= delay_dout2(CELL_WIDTH-1 downto 0);

    -- delay element to read from fifo at correct time
    delay_fifo_rd1 : delay_pipe
      generic map (
        DATA_WIDTH     => 1,
        DELAY_STATES   => -SCHEDULE(0, -1, -1, 0) - 2,  
        NEEDS_RESET    => true,     -- delay is two less than required because
        RESET_VAL_HIGH => false     -- read takes one cycle and output is registered
        )
      port map (
        clk            => clk,
        reset          => reset,
        din            => delay_wr,
        dout           => delay_rd1
        );

    delay_fifo_rd2 : delay_pipe
      generic map (
        DATA_WIDTH     => 1,
        DELAY_STATES   => -SCHEDULE(0, -1, 0, 0) - 2,  
        NEEDS_RESET    => true,     -- delay is two less than required because
        RESET_VAL_HIGH => false     -- read takes one cycle and output is registered
        )
      port map (
        clk            => clk,
        reset          => reset,
        din            => delay_wr,
        dout           => delay_rd2
        );

    -- delay element to write to fifo a few clocks after reset is asserted
    delay_fifo_wr : delay_pipe
      generic map (
        DATA_WIDTH     => 1,
        DELAY_STATES   => 5,        -- delay = 5 clocks
        NEEDS_RESET    => true,     -- wait for a few clocks so that block
        RESET_VAL_HIGH => false     -- ram has a chance to settle
        )
      port map (
        clk            => clk,
        reset          => reset,
        din            => wr_start,
        dout           => delay_wr
        );

    -- registers to control reading and writing into block ram
    reg_fifo : process (clk)
    begin 
      if rising_edge(clk) then
        if reset = '1' then
          wr_start              <= (others => '0');
        else
          -- keep writing into block ram based delay register
          wr_start(0)           <= '1';
        end if;
      end if;  -- end rising_edge
    end process reg_fifo;
  end generate gen_delays_bram;

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

  X1_i_j_vk_kp_max <= X3_i_j_vk_kp_max when in_init_pipe14_delayed(0) = '1' else
                      in_X1_i_jm1_vk_kp_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X2
  -----------------------------------------------------------------------------

  X2_i_j_vk_kp_max <= in_X2_ip1_j_Wk_kpm1_delayed when vk_eq_1 = '1' else
                      in_X2_ip1_j_vkm1_kp_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X3
  -----------------------------------------------------------------------------

  X3_i_j_vk_kp_max <= in_X3_i_jm1_Wk_kpm1_delayed when vk_eq_1 = '1' else
                      in_X3_i_jm1_vkm1_kp_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X4
  -----------------------------------------------------------------------------

  X4_i_j_vk_kp_max <= X2_i_j_vk_kp_max when in_init_pipe14_delayed(0) = '1' else
                      in_X4_ip1_j_vk_kp_delayed;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

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
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr_delayed(0) = '1' else
             in_X_i_j_1_kpp1_delayed       when vk_eq_tile_width_k = '1' else
             in_X_i_j_vkp1_kp_delayed;

  -- Compute final max between k aggregate
  -- and the pipeline dependencies
  X_all_gt <= '1' when X_max_pipeline > X_kaggr
              else
              '0';
  X_all    <= X_max_pipeline when X_all_gt = '1'
              else
              X_kaggr;

  -----------------------------------------------------------------------------
  -- Assign signals for data variables
  -----------------------------------------------------------------------------
  X_i_j_vk_kp  <= X_all;
  X1_i_j_vk_kp <= X1_i_j_vk_kp_max;
  X2_i_j_vk_kp <= X2_i_j_vk_kp_max;
  X3_i_j_vk_kp <= X3_i_j_vk_kp_max;
  X4_i_j_vk_kp <= X4_i_j_vk_kp_max;

  start_aggr   <= in_start_aggr_delayed(0);
  init_pipe14  <= in_init_pipe14_delayed(0);

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_j_vk_kp  <= X_i_j_vk_kp;
  out_X2_i_j_vk_kp <= X2_i_j_vk_kp;
  out_X3_i_j_vk_kp <= X3_i_j_vk_kp;

  out_start_aggr   <= start_aggr;
  out_init_pipe14  <= init_pipe14;

end rtl;
