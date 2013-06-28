
-- File: part-linear-k_array.vhd
-- Date: 27 July 2010
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Top level Nussinov systolic array for partitioned linear along axis k
--      array

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
      clk                     : in  sl;
      reset                   : in  sl;

      isequence               : in  RESIDUE_ARRAY;
      istart                  : in  sl;

      iX_i_j_1_1              : in  slv(CELL_WIDTH-1 downto 0);

      wait_upstrm             : out sl;

      init_X_ip1_j_vk_kp      : out sl;
      initial_X_ip1_j_vk_kp   : out slv(CELL_WIDTH-1 downto 0);
      init_X_i_jm1_vk_kp      : out sl;
      initial_X_i_jm1_vk_kp   : out slv(CELL_WIDTH-1 downto 0);
      init_X_ip1_jm1_vk_kp    : out sl;
      initial_X_ip1_jm1_vk_kp : out slv(CELL_WIDTH-1 downto 0);
      init_X_ip2_j_vk_kp      : out sl;
      initial_X_ip2_j_vk_kp   : out slv(CELL_WIDTH-1 downto 0);

      init_S_i                : out sl;
      initial_S_i             : out slv(RESIDUE_WIDTH-1 downto 0);
      init_S_j                : out sl;
      initial_S_j             : out slv(RESIDUE_WIDTH-1 downto 0);

      start_aggr              : out sl;
      init_pipe14             : out sl;

      osequence_score         : out slv(31 downto 0);
      ovld                    : out sl
    );
  end component;

  -- nussinov GJQ processing elements
  component pe_other is
    generic (
      USE_BRAM             : boolean := false
      );
    port (
      clk                  : in  sl;
      reset                : in  sl;

      in_start_aggr        : in  sl;
      in_init_pipe14       : in  sl;

      in_X_i_j_vk_kpp1     : in  slv(CELL_WIDTH-1 downto 0);

      in_X2_ip1_j_km1      : in  slv(CELL_WIDTH-1 downto 0);
      in_X3_i_jm1_km1      : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_j_vk_kp      : out slv(CELL_WIDTH-1 downto 0);
      out_X2_i_j_vk_kp     : out slv(CELL_WIDTH-1 downto 0);
      out_X3_i_j_vk_kp     : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr       : out sl;
      out_init_pipe14      : out sl
      );
  end component;

  component pe_bottom is
    port (
      clk                      : in  sl;
      reset                    : in  sl;

      init_X_ip1_j_vk_kp       : in  sl;
      initial_X_ip1_j_vk_kp    : in  slv(CELL_WIDTH-1 downto 0);
      init_X_i_jm1_vk_kp       : in  sl;
      initial_X_i_jm1_vk_kp    : in  slv(CELL_WIDTH-1 downto 0);
      init_X_ip1_jm1_vk_kp     : in  sl;
      initial_X_ip1_jm1_vk_kp  : in  slv(CELL_WIDTH-1 downto 0);
      init_X_ip2_j_vk_kp       : in  sl;
      initial_X_ip2_j_vk_kp    : in  slv(CELL_WIDTH-1 downto 0);

      init_S_i                 : in  sl;
      initial_S_i              : in  slv(RESIDUE_WIDTH-1 downto 0);
      init_S_j                 : in  sl;
      initial_S_j              : in  slv(RESIDUE_WIDTH-1 downto 0);

      in_start_aggr            : in  sl;
      in_init_pipe14           : in  sl;

      in_X_i_j_vk_kpp1         : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_j_vk_kp          : out slv(CELL_WIDTH-1 downto 0);
      out_X2_i_j_vk_kp         : out slv(CELL_WIDTH-1 downto 0);
      out_X3_i_j_vk_kp         : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr           : out sl;
      out_init_pipe14          : out sl
      );
  end component;

  -- signals from initialization FSM
  signal init_X_ip1_j_vk_kp       : sl;
  signal initial_X_ip1_j_vk_kp    : slv(CELL_WIDTH-1 downto 0);
  signal init_X_i_jm1_vk_kp       : sl;
  signal initial_X_i_jm1_vk_kp    : slv(CELL_WIDTH-1 downto 0);
  signal init_X_ip1_jm1_vk_kp     : sl;
  signal initial_X_ip1_jm1_vk_kp  : slv(CELL_WIDTH-1 downto 0);
  signal init_X_ip2_j_vk_kp       : sl;
  signal initial_X_ip2_j_vk_kp    : slv(CELL_WIDTH-1 downto 0);

  signal init_S_i                 : sl;
  signal initial_S_i              : slv(RESIDUE_WIDTH-1 downto 0);
  signal init_S_j                 : sl;
  signal initial_S_j              : slv(RESIDUE_WIDTH-1 downto 0);

  signal init_start_aggr          : sl;
  signal init_init_pipe14         : sl;

  -- wires connecting the processing elements
  type PE_CELL_ARRAY is array (1 to NO_PE_K + 1) of slv(CELL_WIDTH-1 downto 0);

  signal X_i_j_vk_kp              : PE_CELL_ARRAY;
  signal X1_i_j_vk_kp             : PE_CELL_ARRAY;
  signal X2_i_j_vk_kp             : PE_CELL_ARRAY;
  signal X3_i_j_vk_kp             : PE_CELL_ARRAY;

  signal start_aggr               : slv(0 to NO_PE_K);
  signal init_pipe14              : slv(0 to NO_PE_K);

begin

  -----------------------------------------------------------------------------
  -- Initialize bottom PE using a finite state machine
  -----------------------------------------------------------------------------
  initialize_pes : pe_init_fsm
    port map (
      clk                     => clk,
      reset                   => reset,

      isequence               => isequence,
      istart                  => istart,

      iX_i_j_1_1              => X_i_j_vk_kp(1),

      wait_upstrm             => wait_upstrm,

      init_X_ip1_j_vk_kp      => init_X_ip1_j_vk_kp,
      initial_X_ip1_j_vk_kp   => initial_X_ip1_j_vk_kp,
      init_X_i_jm1_vk_kp      => init_X_i_jm1_vk_kp,
      initial_X_i_jm1_vk_kp   => initial_X_i_jm1_vk_kp,
      init_X_ip1_jm1_vk_kp    => init_X_ip1_jm1_vk_kp,
      initial_X_ip1_jm1_vk_kp => initial_X_ip1_jm1_vk_kp,
      init_X_ip2_j_vk_kp      => init_X_ip2_j_vk_kp,
      initial_X_ip2_j_vk_kp   => initial_X_ip2_j_vk_kp,

      init_S_i                => init_S_i,
      initial_S_i             => initial_S_i,
      init_S_j                => init_S_j,
      initial_S_j             => initial_S_j,

      start_aggr              => init_start_aggr,
      init_pipe14             => init_init_pipe14,

      osequence_score         => osequence_score,
      ovld                    => ovld
    );

  -----------------------------------------------------------------------------
  -- Generate bottom PE
  -----------------------------------------------------------------------------
  bottom_pe : pe_bottom
    port map (
      clk                      => clk,
      reset                    => reset,

      init_X_ip1_j_vk_kp       => init_X_ip1_j_vk_kp,
      initial_X_ip1_j_vk_kp    => initial_X_ip1_j_vk_kp,
      init_X_i_jm1_vk_kp       => init_X_i_jm1_vk_kp,
      initial_X_i_jm1_vk_kp    => initial_X_i_jm1_vk_kp,
      init_X_ip1_jm1_vk_kp     => init_X_ip1_jm1_vk_kp,
      initial_X_ip1_jm1_vk_kp  => initial_X_ip1_jm1_vk_kp,
      init_X_ip2_j_vk_kp       => init_X_ip2_j_vk_kp,
      initial_X_ip2_j_vk_kp    => initial_X_ip2_j_vk_kp,

      init_S_i                 => init_S_i,
      initial_S_i              => initial_S_i,
      init_S_j                 => init_S_j,
      initial_S_j              => initial_S_j,

      in_start_aggr            => init_start_aggr,
      in_init_pipe14           => init_init_pipe14,

      in_X_i_j_vk_kpp1         => X_i_j_vk_kp(2),

      out_X_i_j_vk_kp          => X_i_j_vk_kp(1),
      out_X2_i_j_vk_kp         => X2_i_j_vk_kp(1),
      out_X3_i_j_vk_kp         => X3_i_j_vk_kp(1),

      out_start_aggr           => start_aggr(1),
      out_init_pipe14          => init_pipe14(1)
      );

  -----------------------------------------------------------------------------
  -- Generate other PEs, k' > 1
  -----------------------------------------------------------------------------
  array_gen_other_kp : for kp in 2 to NO_PE_K
    generate
      indiv_pe : pe_other
        generic map (
          USE_BRAM        => (kp <= NO_BRAM_PES + 1)
                                 -- use block rams for some PEs.
                                 -- 'true' to use block rams for
                                 -- large delays, 'false' to use
                                 -- LUT memories.
          )
        port map (
          clk              => clk,
          reset            => reset,

          in_start_aggr    => start_aggr(kp - 1),
          in_init_pipe14   => init_pipe14(kp - 1),

          in_X_i_j_vk_kpp1 => X_i_j_vk_kp(kp + 1),

          in_X2_ip1_j_km1  => X2_i_j_vk_kp(kp - 1),
          in_X3_i_jm1_km1  => X3_i_j_vk_kp(kp - 1),

          out_X_i_j_vk_kp  => X_i_j_vk_kp(kp),
          out_X2_i_j_vk_kp => X2_i_j_vk_kp(kp),
          out_X3_i_j_vk_kp => X3_i_j_vk_kp(kp),

          out_start_aggr   => start_aggr(kp),
          out_init_pipe14  => init_pipe14(kp)
          );
    end generate;

end architecture top_level;
