
-- File: linear-k_array.vhd
-- Date: 9 October 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Top level Nussinov systolic array for linear along axis k array

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

    -- array is busy
    wait_upstrm      : out sl;

    -- OUTPUTS
    osequence_score  : out slv(31 downto 0);
    ovld             : out sl
  );
end entity nussinov;

architecture top_level of nussinov is

  component pe_init_fsm is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      isequence            : in  RESIDUE_ARRAY;
      istart               : in  sl;

      iX_i_j_1             : in  slv(CELL_WIDTH-1 downto 0);

      wait_upstrm          : out sl;

      init_X_ip1_j_k       : out sl;
      initial_X_ip1_j_k    : out slv(CELL_WIDTH-1 downto 0);
      init_X_i_jm1_k       : out sl;
      initial_X_i_jm1_k    : out slv(CELL_WIDTH-1 downto 0);
      init_X_ip1_jm1_k     : out sl;
      initial_X_ip1_jm1_k  : out slv(CELL_WIDTH-1 downto 0);
      init_X_ip2_j_k       : out sl;
      initial_X_ip2_j_k    : out slv(CELL_WIDTH-1 downto 0);

      init_S_i             : out sl;
      initial_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
      init_S_j             : out sl;
      initial_S_j          : out slv(RESIDUE_WIDTH-1 downto 0);

      start_aggr           : out sl;
      init_pipe58          : out sl;

      osequence_score      : out slv(31 downto 0);
      ovld                 : out sl
    );
  end component;

  -- nussinov GJQ processing elements
  component pe_other is
    generic (
      USE_BRAM        : boolean := false
      );
    port (
      clk             : in  sl;
      reset           : in  sl;

      in_start_aggr   : in  sl;
      in_init_pipe58  : in  sl;

      in_X_i_j_kp1    : in  slv(CELL_WIDTH-1 downto 0);

      in_X6_ip1_j_km1 : in  slv(CELL_WIDTH-1 downto 0);
      in_X7_i_jm1_km1 : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_j_k     : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k    : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k    : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr  : out sl;
      out_init_pipe58 : out sl
      );
  end component;

  component pe_bottom is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      init_X_ip1_j_k       : in  sl;
      initial_X_ip1_j_k    : in  slv(CELL_WIDTH-1 downto 0);
      init_X_i_jm1_k       : in  sl;
      initial_X_i_jm1_k    : in  slv(CELL_WIDTH-1 downto 0);
      init_X_ip1_jm1_k     : in  sl;
      initial_X_ip1_jm1_k  : in  slv(CELL_WIDTH-1 downto 0);
      init_X_ip2_j_k       : in  sl;
      initial_X_ip2_j_k    : in  slv(CELL_WIDTH-1 downto 0);

      init_S_i             : in  sl;
      initial_S_i          : in  slv(RESIDUE_WIDTH-1 downto 0);
      init_S_j             : in  sl;
      initial_S_j          : in  slv(RESIDUE_WIDTH-1 downto 0);

      in_start_aggr        : in  sl;
      in_init_pipe58       : in  sl;

      in_X_i_j_kp1         : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr       : out sl;
      out_init_pipe58      : out sl
      );
  end component;

  -- signals from initialization FSM
  signal init_X_ip1_j_k       : sl;
  signal initial_X_ip1_j_k    : slv(CELL_WIDTH-1 downto 0);
  signal init_X_i_jm1_k       : sl;
  signal initial_X_i_jm1_k    : slv(CELL_WIDTH-1 downto 0);
  signal init_X_ip1_jm1_k     : sl;
  signal initial_X_ip1_jm1_k  : slv(CELL_WIDTH-1 downto 0);
  signal init_X_ip2_j_k       : sl;
  signal initial_X_ip2_j_k    : slv(CELL_WIDTH-1 downto 0);

  signal init_S_i             : sl;
  signal initial_S_i          : slv(RESIDUE_WIDTH-1 downto 0);
  signal init_S_j             : sl;
  signal initial_S_j          : slv(RESIDUE_WIDTH-1 downto 0);

  signal init_start_aggr      : sl;
  signal init_init_pipe58     : sl;

  -- max k value
  constant MAX_K              : integer := (NO_PE - 1) / 2;

  -- wires connecting the processing elements
  type PE_CELL_ARRAY is array (1 to MAX_K + 1) of slv(CELL_WIDTH-1 downto 0);

  signal X_i_j_k              : PE_CELL_ARRAY;
  signal X5_i_j_k             : PE_CELL_ARRAY;
  signal X6_i_j_k             : PE_CELL_ARRAY;
  signal X7_i_j_k             : PE_CELL_ARRAY;

  signal start_aggr           : slv(0 to MAX_K);
  signal init_pipe58          : slv(0 to MAX_K);

begin

  -----------------------------------------------------------------------------
  -- Initialize bottom PE using a finite state machine
  -----------------------------------------------------------------------------
  initialize_pes : pe_init_fsm
    port map (
      clk                  => clk,
      reset                => reset,

      isequence            => isequence,
      istart               => istart,

      iX_i_j_1             => X_i_j_k(1),

      wait_upstrm          => wait_upstrm,

      init_X_ip1_j_k       => init_X_ip1_j_k,
      initial_X_ip1_j_k    => initial_X_ip1_j_k,
      init_X_i_jm1_k       => init_X_i_jm1_k,
      initial_X_i_jm1_k    => initial_X_i_jm1_k,
      init_X_ip1_jm1_k     => init_X_ip1_jm1_k,
      initial_X_ip1_jm1_k  => initial_X_ip1_jm1_k,
      init_X_ip2_j_k       => init_X_ip2_j_k,
      initial_X_ip2_j_k    => initial_X_ip2_j_k,

      init_S_i             => init_S_i,
      initial_S_i          => initial_S_i,
      init_S_j             => init_S_j,
      initial_S_j          => initial_S_j,

      start_aggr           => init_start_aggr,
      init_pipe58          => init_init_pipe58,
      
      osequence_score      => osequence_score,
      ovld                 => ovld
    );

  -----------------------------------------------------------------------------
  -- Generate bottom PE
  -----------------------------------------------------------------------------
  bottom_pe : pe_bottom
    port map (
      clk                  => clk,
      reset                => reset,

      init_X_ip1_j_k       => init_X_ip1_j_k,
      initial_X_ip1_j_k    => initial_X_ip1_j_k,
      init_X_i_jm1_k       => init_X_i_jm1_k,
      initial_X_i_jm1_k    => initial_X_i_jm1_k,
      init_X_ip1_jm1_k     => init_X_ip1_jm1_k,
      initial_X_ip1_jm1_k  => initial_X_ip1_jm1_k,
      init_X_ip2_j_k       => init_X_ip2_j_k,
      initial_X_ip2_j_k    => initial_X_ip2_j_k,

      init_S_i             => init_S_i,
      initial_S_i          => initial_S_i,
      init_S_j             => init_S_j,
      initial_S_j          => initial_S_j,

      in_start_aggr        => init_start_aggr,
      in_init_pipe58       => init_init_pipe58,

      in_X_i_j_kp1         => X_i_j_k(2),

      out_X_i_j_k          => X_i_j_k(1),
      out_X6_i_j_k         => X6_i_j_k(1),
      out_X7_i_j_k         => X7_i_j_k(1),

      out_start_aggr       => start_aggr(1),
      out_init_pipe58      => init_pipe58(1)
      );

  -----------------------------------------------------------------------------
  -- Generate other PEs, k > 1
  -----------------------------------------------------------------------------
  array_gen_other_k : for k in 2 to (NO_PE - 1) / 2
    generate
      indiv_pe : pe_other
        generic map (
          USE_BRAM        => (k <= NO_BRAM_PES + 1)
                                 -- use block rams for some PEs
                                 -- 'true' to use block rams for
                                 -- large delays, 'false' to use
                                 -- LUT memories.
          )
        port map (
          clk             => clk,
          reset           => reset,

          in_start_aggr   => start_aggr(k - 1),
          in_init_pipe58  => init_pipe58(k - 1),

          in_X_i_j_kp1    => X_i_j_k(k + 1),

          in_X6_ip1_j_km1 => X6_i_j_k(k - 1),
          in_X7_i_jm1_km1 => X7_i_j_k(k - 1),

          out_X_i_j_k     => X_i_j_k(k),
          out_X6_i_j_k    => X6_i_j_k(k),
          out_X7_i_j_k    => X7_i_j_k(k),

          out_start_aggr  => start_aggr(k),
          out_init_pipe58 => init_pipe58(k)
          );
    end generate;

end architecture top_level;
