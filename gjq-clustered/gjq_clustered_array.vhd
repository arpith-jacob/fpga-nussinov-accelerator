
-- File: gjq_clustered_array.vhd
-- Date: 6 Mar 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Top level Nussinov systolic array

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity nussinov is
  port (
    clk              : in  sl;
    reset            : in  sl;

    -- INPUTS
    isequence        : in  RESIDUE_ARRAY;
    istart           : in  sl;

    -- array is working: don't flush until this signal is low
    array_working    : out sl;

    -- array is busy
    wait_upstrm      : out sl;

    -- OUTPUTS
    osequence_score  : out slv(31 downto 0);
    ovld             : out sl
  );
end entity nussinov;

architecture top_level of nussinov is

  component pe_clustered_other is
    port (
      clk                   : in  sl;
      reset                 : in  sl;

      in_start_aggr         : in  sl;
      in_init_pipe58        : in  sl;

      in_clust_start_aggr   : in  sl;
      in_clust_init_pipe58  : in  sl;

      in_X_i_j_kp1          : in  slv(CELL_WIDTH-1 downto 0);

      in_X5_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X6_ip1_j_km1       : in  slv(CELL_WIDTH-1 downto 0);
      in_X7_i_jm1_km1       : in  slv(CELL_WIDTH-1 downto 0);
      in_clust_X7_i_jm1_km1 : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_j_k           : out slv(CELL_WIDTH-1 downto 0);
      out_X5_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k          : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr        : out sl;
      out_init_pipe58       : out sl
      );
  end component;

  component pe_clustered_bottom is
    port (
      clk                   : in  sl;
      reset                 : in  sl;

      init_X_ip1_j_k        : in  sl;
      initial_X_ip1_j_k     : in  slv(CELL_WIDTH-1 downto 0);
      init_X_i_jm1_k        : in  sl;
      initial_X_i_jm1_k     : in  slv(CELL_WIDTH-1 downto 0);
      init_X_ip1_jm1_k      : in  sl;
      initial_X_ip1_jm1_k   : in  slv(CELL_WIDTH-1 downto 0);
      init2_X_ip1_jm1_k     : in  sl;
      initial2_X_ip1_jm1_k  : in  slv(CELL_WIDTH-1 downto 0);
      init_X_ip2_j_k        : in  sl;
      initial_X_ip2_j_k     : in  slv(CELL_WIDTH-1 downto 0);
      init2_X_ip2_j_k       : in  sl;
      initial2_X_ip2_j_k    : in  slv(CELL_WIDTH-1 downto 0);

      init_S_i              : in  sl;
      initial_S_i           : in  slv(RESIDUE_WIDTH-1 downto 0);
      init_S_j              : in  sl;
      initial_S_j           : in  slv(RESIDUE_WIDTH-1 downto 0);

      in_start_aggr         : in  sl;
      in_init_pipe58        : in  sl;

      in_clust_start_aggr   : in  sl;
      in_clust_init_pipe58  : in  sl;

      in_X_i_jm1_k          : in  slv(CELL_WIDTH-1 downto 0);
      in_X_ip1_jm1_k        : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_j_kp1          : in  slv(CELL_WIDTH-1 downto 0);

      in_X5_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);

      in_clust_X7_i_jm1_km1 : in  slv(CELL_WIDTH-1 downto 0);

      in_S_i                : in  slv(RESIDUE_WIDTH-1 downto 0);

      in_vld                : in  sl;

      out_X_i_j_k           : out slv(CELL_WIDTH-1 downto 0);
      out_X5_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k          : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr        : out sl;
      out_init_pipe58       : out sl;

      out_S_i               : out slv(RESIDUE_WIDTH-1 downto 0);

      out_vld               : out sl
      );
  end component;

  -- latency counter.  This is the number of clock cycles the array takes
  -- to process one input.
  signal latency_cntr      : slv(15 downto 0);

  -- signal to specify which clustered cell is being processed
  signal pe_in_progress    : sl;

  -- shift register containing the sequence residues
  signal iseqdata_1        : RESIDUE_ARRAY;
  signal iseqdata_2        : RESIDUE_ARRAY;

  -- sequence data ready, start nussinov computation
  signal istart_1          : sl;
  signal istart_2          : sl;
  signal istart_3          : sl;

  -- nussinov array is busy
  signal array_busy        : sl;
  signal array_working_int : sl;

  -- max k value
  constant MAX_K           : integer := (NO_PE - 1) / 2;

  -- wires connecting the processing elements
  type PE_BIT_ARRAY is array (0 to NO_PE) of slv(0 to MAX_K);

  type PE_CELL_ARRAY_1D is array (1 to MAX_K + 1) of slv(CELL_WIDTH-1 downto 0);
  type PE_CELL_ARRAY is array (1 to NO_PE + 1) of PE_CELL_ARRAY_1D;

  type PE_INIT_ARRAY is array (1 to NO_PE) of slv(CELL_WIDTH-1 downto 0);

  type PE_SEQ_ARRAY is array (0 to NO_PE) of slv(RESIDUE_WIDTH-1 downto 0);

  -- xor values of adjacent sequence residues (for initialization)
  signal seqdata_xor       : RESIDUE_ARRAY;

  signal start_aggr        : PE_BIT_ARRAY;
  signal init_pipe58       : PE_BIT_ARRAY;

  signal data_vld          : slv(0 to NO_PE);

  -- initial values
  signal init_X_jmi_1      : PE_INIT_ARRAY;
  signal init_X_jmi_0      : PE_INIT_ARRAY;

  signal X_i_j_k           : PE_CELL_ARRAY;
  signal X5_i_j_k          : PE_CELL_ARRAY;
  signal X6_i_j_k          : PE_CELL_ARRAY;
  signal X7_i_j_k          : PE_CELL_ARRAY;

  signal S_i               : PE_SEQ_ARRAY;

begin

  -----------------------------------------------------------------------------
  -- Process to register sequence information.  Needed for init control signals
  -- to work
  -----------------------------------------------------------------------------
  reg_seqdata : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        istart_1   <= '0';
        istart_2   <= '0';
        istart_3   <= '0';

        iseqdata_1 <= (others => (others => '0'));
        iseqdata_2 <= (others => (others => '0'));
      else
        istart_1   <= istart;
        istart_2   <= istart_1;
        istart_3   <= istart_2;

        iseqdata_1 <= isequence;
        iseqdata_2 <= iseqdata_1;
      end if;
    end if;
  end process reg_seqdata;

  -- determine which row of PEs is being computed in each physical PE
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
  -- Initialize border of GJQ array
  --
  -- Connect border wires to initial values
  -----------------------------------------------------------------------------

  -- X(i)(i) = 0, 1 <= i <= N
  init_X_1 : for i in 1 to NO_PE
    generate
      init_X_jmi_0(i) <= (others => '0');
    end generate;

  -- X(i)(i + 1) = delta(), 1 <= i <= N
  -- each point is initialized to 0 or 1
  init_X_2 : for j in 2 to NO_PE
    generate
      seqdata_xor(j)      <= iseqdata_2(j - 1) xor iseqdata_2(j);
      
      init_X_jmi_1(j)(CELL_WIDTH-1 downto 1) <= (others => '0');
      init_X_jmi_1(j)(0) <= not (iseqdata_2(j - 1)(2) or iseqdata_2(j)(2))
                                when seqdata_xor(j)(1 downto 0) = "11"
                                else
                              '0';
    end generate;

  -- X(j)(k + 1) = 0
  init_X_3 : for k in 1 to (NO_PE - 1) / 2
    generate
      X_i_j_k(2 * (k - 1) + 3)(k + 1) <= (others => '0');
      X_i_j_k(2 * (k - 1) + 4)(k + 1) <= (others => '0');
    end generate;

  -- generate control information
  init_ctrl : for j in 0 to NO_PE
    generate
      -- start aggr is 1 when k = floor(j - i) / 2
      start_aggr(j)(0)      <= istart_1 or istart_3;
      -- init pipe is 1 when k = j - i / 2
      init_pipe58(j)(0)     <= istart_1;
    end generate;

  -- generate control information: zeroes for clustered PE's input
  zero_ctrl : for k in 1 to (NO_PE - 1) / 4
    generate
      -- zero start aggr and init_pipe
      start_aggr(4 * (k - 1) + 2)(2*k - 1)  <= '0';
      init_pipe58(4 * (k - 1) + 2)(2*k - 1) <= '0';
    end generate;

  -- data valid signal
  -- This signal propogates through the bottom pes, taking 2 clock cycles
  -- to transfer to a right neighbor.  When the valid signal is output
  -- from the final pe in the bottom array, the target value is valid.
  data_vld(2) <= istart_2;

  -----------------------------------------------------------------------------
  -- Generate GJQ pe array
  -----------------------------------------------------------------------------
  array_gen_bottom_k_1_and_2 : for j in 3 to NO_PE
    generate
      indiv_pe : pe_clustered_bottom
        port map (
          clk                   => clk,
          reset                 => reset,

          init_X_ip1_j_k        => istart_2,
          initial_X_ip1_j_k     => init_X_jmi_1(j),
          init_X_i_jm1_k        => istart_2,
          initial_X_i_jm1_k     => init_X_jmi_1(j - 1),
          init_X_ip1_jm1_k      => istart,
          initial_X_ip1_jm1_k   => init_X_jmi_0(j - 1),
          init2_X_ip1_jm1_k     => istart_2,
          initial2_X_ip1_jm1_k  => init_X_jmi_1(j - 1),
          init_X_ip2_j_k        => istart,
          initial_X_ip2_j_k     => init_X_jmi_0(j),
          init2_X_ip2_j_k       => istart_2,
          initial2_X_ip2_j_k    => init_X_jmi_1(j),

          init_S_i              => istart_2,
          initial_S_i           => iseqdata_2(j - 2),
          init_S_j              => istart_2,
          initial_S_j           => iseqdata_2(j),

          in_start_aggr         => start_aggr(j - 1)(0),
          in_init_pipe58        => init_pipe58(j - 1)(0),

          in_clust_start_aggr   => start_aggr(j - 1)(1),
          in_clust_init_pipe58  => init_pipe58(j - 1)(1),

          in_X_i_jm1_k          => X_i_j_k(j - 1)(1),
          in_X_ip1_jm1_k        => X_i_j_k(j - 1)(1),
          in_X_i_j_kp1          => X_i_j_k(j)(3),

          in_X5_i_jm1_k         => X5_i_j_k(j - 1)(1),

          in_clust_X7_i_jm1_km1 => X7_i_j_k(j - 1)(1),

          in_S_i                => S_i(j - 3),

          in_vld                => data_vld(j - 1),

          out_X_i_j_k           => X_i_j_k(j)(1),
          out_X5_i_j_k          => X5_i_j_k(j)(1),
          out_X6_i_j_k          => X6_i_j_k(j)(1),
          out_X7_i_j_k          => X7_i_j_k(j)(1),

          out_start_aggr        => start_aggr(j)(1),
          out_init_pipe58       => init_pipe58(j)(1),

          out_S_i               => S_i(j - 2),
          out_vld               => data_vld(j)
          );
    end generate;

  array_gen_clustered_other_k : for k in 2 to (NO_PE - 1) / 4
    generate
      array_gen_clustered_other_j : for j in 4 * (k - 1) + 3 to NO_PE
        generate
          indiv_pe : pe_clustered_other
            port map (
              clk                   => clk,
              reset                 => reset,

              in_start_aggr         => start_aggr(j - 1)(2*k - 3),
              in_init_pipe58        => init_pipe58(j - 1)(2*k - 3),

              in_clust_start_aggr   => start_aggr(j - 1)(2*k - 1),
              in_clust_init_pipe58  => init_pipe58(j - 1)(2*k - 1),

              in_X_i_j_kp1          => X_i_j_k(j)(2*k + 1),

              in_X5_i_jm1_k         => X5_i_j_k(j - 1)(2*k - 1),
              in_X6_ip1_j_km1       => X6_i_j_k(j)(2*k - 3),
              in_X7_i_jm1_km1       => X7_i_j_k(j - 1)(2*k - 3),

              in_clust_X7_i_jm1_km1 => X7_i_j_k(j - 1)(2*k - 1),

              out_X_i_j_k           => X_i_j_k(j)(2*k - 1),
              out_X5_i_j_k          => X5_i_j_k(j)(2*k - 1),
              out_X6_i_j_k          => X6_i_j_k(j)(2*k - 1),
              out_X7_i_j_k          => X7_i_j_k(j)(2*k - 1),

              out_start_aggr        => start_aggr(j)(2*k - 1),
              out_init_pipe58       => init_pipe58(j)(2*k - 1)
              );
        end generate;
    end generate;

  -----------------------------------------------------------------------------
  -- Process to count latency of computation
  -----------------------------------------------------------------------------
  count_latency : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        latency_cntr   <= (others => '0');
      else

        if latency_cntr > 1 then
          latency_cntr <= latency_cntr - 1;
        end if;

        -- start counting latency
        if istart = '1' then
          -- wait for three more than the latency (istart is delayed)
          latency_cntr <= conv_std_logic_vector(ARRAY_LATENCY + 3, 16);
        end if;

      end if;
    end if;
  end process count_latency;

  -----------------------------------------------------------------------------
  -- Process to register sequence id and generate score & back pressure
  -----------------------------------------------------------------------------
  output_proc : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        array_busy          <= '0';
        array_working_int   <= '0';
      else

        if latency_cntr <= 1 then
          array_working_int <= '0';
        end if;

        -- done folding sequence
        if data_vld(NO_PE) = '1' then
          array_busy      <= '0';
        end if;

        -- send busy signal when folding sequence
        if istart = '1' then
          array_busy        <= '1';
          array_working_int <= '1';
        end if;

      end if;
    end if;
  end process output_proc;

  -- pause the top level if nussinov array is processing data
  -- send wait_upstream until next clock cycle is going to be first virtual
  -- PE being computed
  wait_upstrm      <= istart or array_busy or pe_in_progress;

  -- array is processing an input.  flush only after this signal goes low
  array_working    <= array_working_int;

  osequence_score(31 downto CELL_WIDTH)  <= (others => '0');
  osequence_score(CELL_WIDTH-1 downto 0) <= slv(X_i_j_k(NO_PE)(1));

  ovld             <= data_vld(NO_PE);

end architecture top_level;
