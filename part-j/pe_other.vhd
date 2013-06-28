
-- File: pe_other.vhd
-- Date: 16 December 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing all except the bottom cells.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_other is
  generic (
    -- reset state.  state of pe when its reset.  state is:
    -- 0 ... TILE_WIDTH_J - 1
    RESET_STATE            : slv (15 downto 0);
    -- When true delay registers are placed in block ram memories
    USE_BRAM               : boolean := false
    );
  port (
    clk                    : in  sl;
    reset                  : in  sl;

    --
    -- INPUT
    --
    -- input control signals
    in_start_aggr          : in  sl;   -- start max aggregating along k axis
    in_init_pipe14         : in  sl;   -- initialize pipelines 5 and 8

    -- X dependencies
    -- X(i, v_j, j', k+1)
    in_X_i_vj_jp_kp1       : in  slv(CELL_WIDTH-1 downto 0);

    -- X1(i, W_j-1, j'-1, k)
    in_X1_i_Wjm1_jpm1_k    : in  slv(CELL_WIDTH-1 downto 0);
    -- X2(i+1, v_j, j', k-1)
    in_X2_ip1_vj_jp_km1    : in  slv(CELL_WIDTH-1 downto 0);
    -- X3(i, W_j-1, j'-1, k-1)
    in_X3_i_Wjm1_jpm1_km1  : in  slv(CELL_WIDTH-1 downto 0);
    -- X3(i, v_j-1, j', k-1)
    in_X3_i_vjm1_jp_km1    : in  slv(CELL_WIDTH-1 downto 0);

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

    -- output control signals
    out_start_aggr         : out sl;
    out_init_pipe14        : out sl
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

  component delay_fifo is
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
  -- Mux signal along communication link: either an initialization value, or
  -- the value sent from a processing element
  -----------------------------------------------------------------------------
  signal in_X_i_vj_jp_kp1_delayed       : slv(CELL_WIDTH-1 downto 0);

  signal in_X1_i_Wjm1_jpm1_k_delayed    : slv(CELL_WIDTH-1 downto 0);
  signal in_X1_i_vjm1_jp_k_delayed      : slv(CELL_WIDTH-1 downto 0);
  signal in_X2_ip1_vj_jp_km1_delayed    : slv(CELL_WIDTH-1 downto 0);
  signal in_X3_i_Wjm1_jpm1_km1_delayed  : slv(CELL_WIDTH-1 downto 0);
  signal in_X3_i_vjm1_jp_km1_delayed    : slv(CELL_WIDTH-1 downto 0);
  signal in_X4_ip1_vj_jp_k_delayed      : slv(CELL_WIDTH-1 downto 0);

  signal mux_start_aggr                 : slv(0 downto 0);
  signal mux_init_pipe14                : slv(0 downto 0);

  signal in_start_aggr_delayed          : slv(0 downto 0);
  signal in_init_pipe14_delayed         : slv(0 downto 0);

  -- signals used for FIFO delay
  signal delay_dout_del                 : slv(17 downto 0); 
  signal delay_dout                     : slv(17 downto 0); 
  signal delay_din                      : slv(17 downto 0); 

  signal wr_start                       : slv(0 downto 0);
  signal delay_wr                       : slv(0 downto 0);
  signal delay_rd                       : slv(0 downto 0);

  signal in_X4_ip1_vj_jp_k_fifo         : slv(CELL_WIDTH-1 downto 0);

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

  signal X_max_pipeline_gt              : sl;
  signal X_max_pipeline                 : slv(CELL_WIDTH-1 downto 0);

  signal X1_i_vj_jp_k_plus_X2_i_vj_jp_k : slv(CELL_WIDTH-1 downto 0);
  signal X3_i_vj_jp_k_plus_X4_i_vj_jp_k : slv(CELL_WIDTH-1 downto 0);

  signal X_kaggr                        : slv(CELL_WIDTH-1 downto 0);

  signal X_all_gt                       : sl;
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

  -- X3(i, W_j-1, j'-1, k-1)
  -- delay = 1
  in_X3_i_Wjm1_jpm1_km1_delayed <= in_X3_i_Wjm1_jpm1_km1;

  -- X3(i, v_j-1, j', k-1)
  -- delay = 1
  in_X3_i_vjm1_jp_km1_delayed   <= in_X3_i_vjm1_jp_km1;

  -- X(i, v_j, j', k+1)
  -- delay = 1
  in_X_i_vj_jp_kp1_delayed      <= in_X_i_vj_jp_kp1;

 -----------------------------------------------------------------------------
  -- Generate memory intensive link delays using LUTS
  -----------------------------------------------------------------------------
  gen_delays_luts : if (not USE_BRAM) generate
    -- X2(i+1, v_j, j', k-1)
    delay_X2_ip1_vj_jp_km1 : delay_pipe
      generic map (
        DATA_WIDTH     => CELL_WIDTH,
        DELAY_STATES   => TILE_WIDTH_J-2,  -- delay = TILE_WIDTH_J-1
        NEEDS_RESET    => false,
        RESET_VAL_HIGH => false
        )
      port map (
        clk            => clk,
        reset          => reset,
        din            => in_X2_ip1_vj_jp_km1,
        dout           => in_X2_ip1_vj_jp_km1_delayed
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
  end generate gen_delays_luts;

  -----------------------------------------------------------------------------
  -- Generate memory intensive link delays using block RAMs
  -----------------------------------------------------------------------------
  gen_delays_bram : if (USE_BRAM) generate
    -- delay of SEQ_LEN-2 should not exceed capacity of block ram which is
    -- 1024.
    assert (SEQ_LEN-2 <= 1024) report
      "pe_other block ram has insufficient capacity" severity error;

    -- instantiates block ram
    delay_links : delay_fifo
      port map (
        clk    => clk,
        srst   => reset,

        rd_en  => delay_rd(0),
        dout   => delay_dout_del,
        full   => open,

        wr_en  => delay_wr(0),
        din    => delay_din,
        empty  => open
      );

    -- input into delay block ram
    delay_din               <= "000000" & X4_i_vj_jp_k_reg & in_X2_ip1_vj_jp_km1;

    -- output from delay block ram
    -- register output of FIFO by one clock cycle here to improve timing
    -- we could have placed this flop in the fifo itself, but we place it
    -- here explicitly so that the critical path from the block ram output
    -- to the logic is decreased
    reg_fifo_output : process (clk)
    begin 
      if rising_edge(clk) then
        delay_dout <= delay_dout_del;
      end if;  -- end rising_edge
    end process reg_fifo_output;

    -- X4 element needs one extra clock delay
    in_X2_ip1_vj_jp_km1_delayed <= delay_dout(CELL_WIDTH-1 downto 0);
    in_X4_ip1_vj_jp_k_fifo      <= delay_dout(2*CELL_WIDTH-1 downto CELL_WIDTH);

    -- delay element to read from fifo at correct time
    delay_fifo_rd : delay_pipe
      generic map (
        DATA_WIDTH     => 1,
        DELAY_STATES   => TILE_WIDTH_J-4,  -- delay = TILE_WIDTH_J-1
        NEEDS_RESET    => true,            -- -1 for block ram read latency
        RESET_VAL_HIGH => false            -- -1 because data value registered
                                           --    at source
        )
      port map (
        clk            => clk,
        reset          => reset,
        din            => delay_wr,
        dout           => delay_rd
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
          wr_start                  <= (others => '0');

          in_X4_ip1_vj_jp_k_delayed <= (others => '0');
        else
          -- keep writing into block ram based delay register
          wr_start(0)               <= '1';

          in_X4_ip1_vj_jp_k_delayed <= in_X4_ip1_vj_jp_k_fifo;
        end if;
      end if;  -- end rising_edge
    end process reg_fifo;
  end generate gen_delays_bram;

  -----------------------------------------------------------------------------
  -- Delay control links according to the schedule
  -----------------------------------------------------------------------------
  -- start_aggr(i, v', j', k) = start_aggr(i+2, v', j', k-1)
  -- to start aggregation at k = (j-i)/2
  mux_start_aggr(0) <= in_start_aggr;
  delay_start_aggr : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => 2*TILE_WIDTH_J-2,  -- delay = 2*TILE_WIDTH_J-1
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => mux_start_aggr,
      dout           => in_start_aggr_delayed
      );

  mux_init_pipe14(0) <= in_init_pipe14;
  delay_init_pipe14 : delay_pipe
    generic map (
      DATA_WIDTH     => 1,
      DELAY_STATES   => 2*TILE_WIDTH_J-2,  -- delay = 2*TILE_WIDTH_J-1
      NEEDS_RESET    => false,
      RESET_VAL_HIGH => false
      )
    port map (
      clk            => clk,
      reset          => reset,
      din            => mux_init_pipe14,
      dout           => in_init_pipe14_delayed
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
      else
        state_counter            <= state_counter + 1;

        if state_counter = TILE_WIDTH_J-1 then
          state_counter          <= (others => '0');
        end if;

        -- v_j = 1.  use this signal to mux input
        if state_counter = TILE_WIDTH_J-1 then
          vj_eq_1                <= '1';
        else
          vj_eq_1                <= '0';
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

  X1_i_vj_jp_k <= X3_i_vj_jp_k when in_init_pipe14_delayed(0) = '1' else
                  in_X1_i_Wjm1_jpm1_k_delayed when vj_eq_1 = '1' else
                  in_X1_i_vjm1_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X2
  -----------------------------------------------------------------------------

  X2_i_vj_jp_k <= in_X2_ip1_vj_jp_km1_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X3
  -----------------------------------------------------------------------------

  X3_i_vj_jp_k <= in_X3_i_Wjm1_jpm1_km1_delayed when vj_eq_1 = '1' else
                  in_X3_i_vjm1_jp_km1_delayed;

  -----------------------------------------------------------------------------
  -- Pipeline variable X4
  -----------------------------------------------------------------------------

  X4_i_vj_jp_k <= X2_i_vj_jp_k when in_init_pipe14_delayed(0) = '1' else
                  in_X4_ip1_vj_jp_k_delayed;

  -----------------------------------------------------------------------------
  -- Data variable X
  -----------------------------------------------------------------------------

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
  X_kaggr <= ZEROES(CELL_WIDTH-1 downto 0) when in_start_aggr_delayed(0) = '1'
             else
             in_X_i_vj_jp_kp1_delayed;

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
  reg_values_noreset: process (clk)
  begin 
    if rising_edge(clk) then
        -- register computed values: output
        X_i_vj_jp_k_reg  <= X_all;
        X1_i_vj_jp_k_reg <= X1_i_vj_jp_k;
        X2_i_vj_jp_k_reg <= X2_i_vj_jp_k;
        X3_i_vj_jp_k_reg <= X3_i_vj_jp_k;
        X4_i_vj_jp_k_reg <= X4_i_vj_jp_k;
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
        start_aggr_reg  <= in_start_aggr_delayed(0);
        init_pipe14_reg <= in_init_pipe14_delayed(0);
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

  out_start_aggr      <= start_aggr_reg;
  out_init_pipe14     <= init_pipe14_reg;

end rtl;
