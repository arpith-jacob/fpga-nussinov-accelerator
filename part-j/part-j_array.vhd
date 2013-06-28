
-- File: part-k_array.vhd
-- Date: 16 December 2009
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Top level Nussinov systolic array for 2D along axis j array

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
    sequence         : in  RESIDUE_ARRAY;
    start            : in  sl;

    -- array is busy
    wait_upstrm      : out sl;

    -- OUTPUTS
    sequence_score   : out slv(31 downto 0);
    vld              : out sl
  );
end entity nussinov;

architecture top_level of nussinov is

  component pe_init_fsm is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      sequence             : in  RESIDUE_ARRAY;
      start                : in  sl;

      X_i_j_1              : in  slv(CELL_WIDTH-1 downto 0);

      vj_eq_tile_width_j   : in  sl;

      wait_upstrm          : out sl;

      init_seq             : out slv(1 to NO_PE_JP);
      initial_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
      initial_S_j          : out slv(RESIDUE_WIDTH-1 downto 0);

      start_aggr           : out slv(1 to NO_PE_JP);
      init_pipe14          : out slv(1 to NO_PE_JP);
      j_m_i_2              : out slv(1 to NO_PE_JP);

      sequence_score       : out slv(31 downto 0);
      vld                  : out sl
    );
  end component;

  -- nussinov processing elements
  component pe_other is
    generic (
      RESET_STATE            : slv (15 downto 0);
      USE_BRAM               : boolean := false
      );
    port (
      clk                    : in  sl;
      reset                  : in  sl;

      in_start_aggr          : in  sl;
      in_init_pipe14         : in  sl;

      in_X_i_vj_jp_kp1       : in  slv(CELL_WIDTH-1 downto 0);

      in_X1_i_Wjm1_jpm1_k    : in  slv(CELL_WIDTH-1 downto 0);
      in_X2_ip1_vj_jp_km1    : in  slv(CELL_WIDTH-1 downto 0);
      in_X3_i_Wjm1_jpm1_km1  : in  slv(CELL_WIDTH-1 downto 0);
      in_X3_i_vjm1_jp_km1    : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_vj_jp_k        : out slv(CELL_WIDTH-1 downto 0);
      out_X1_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);
      out_X2_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);
      out_X3_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr         : out sl;
      out_init_pipe14        : out sl
      );
  end component;

  component pe_bottom is
    generic (
      RESET_STATE            : slv (15 downto 0)
      );
    port (
      clk                    : in  sl;
      reset                  : in  sl;

      init_seq               : in  sl;
      initial_S_i            : in  slv(RESIDUE_WIDTH-1 downto 0);
      initial_S_j            : in  slv(RESIDUE_WIDTH-1 downto 0);

      in_start_aggr          : in  sl;
      in_init_pipe14         : in  sl;
      in_j_m_i_2             : in  sl;

      in_X1_i_Wjm1_jpm1_k    : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_Wj_jpm1_k       : in  slv(CELL_WIDTH-1 downto 0);
      in_X_ip1_Wj_jpm1_k     : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_vj_jp_kp1       : in  slv(CELL_WIDTH-1 downto 0);

      in_P_i_Wjm1_jpm1_k     : in  slv(RESIDUE_WIDTH-1 downto 0);

      out_X_i_vj_jp_k        : out slv(CELL_WIDTH-1 downto 0);
      out_X1_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);
      out_X2_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);
      out_X3_i_vj_jp_k       : out slv(CELL_WIDTH-1 downto 0);

      out_P_i_vj_jp_k        : out slv(RESIDUE_WIDTH-1 downto 0);

      out_vj_eq_tile_width_j : out sl;

      out_start_aggr         : out sl;
      out_init_pipe14        : out sl
      );
  end component;

  -- signals from initialization FSM
  signal init_seq             : slv(1 to NO_PE_JP);
  signal initial_S_i          : slv(RESIDUE_WIDTH-1 downto 0);
  signal initial_S_j          : slv(RESIDUE_WIDTH-1 downto 0);

  signal init_start_aggr      : slv(1 to NO_PE_JP);
  signal init_init_pipe14     : slv(1 to NO_PE_JP);
  signal j_m_i_2              : slv(1 to NO_PE_JP);

  -- max k value
  constant MAX_K              : integer := (SEQ_LEN - 1) / 2;

  -- wires connecting the processing elements
  type PE_CELL_ARRAY_K is array (1 to MAX_K + 1) of slv(CELL_WIDTH-1 downto 0);

  type PE_CELL_ARRAY is array (0 to NO_PE_JP) of PE_CELL_ARRAY_K;

  signal X_i_vj_jp_k          : PE_CELL_ARRAY;
  signal X1_i_vj_jp_k         : PE_CELL_ARRAY;
  signal X2_i_vj_jp_k         : PE_CELL_ARRAY;
  signal X3_i_vj_jp_k         : PE_CELL_ARRAY;

  type PE_BIT_ARRAY is array (1 to NO_PE_JP) of slv(1 to MAX_K + 1);

  signal start_aggr           : PE_BIT_ARRAY;
  signal init_pipe14          : PE_BIT_ARRAY;

  signal vj_eq_tile_width_j   : slv(1 to NO_PE_JP);

  type PE_RESIDUE_ARRAY is array (0 to NO_PE_JP) of
         slv(RESIDUE_WIDTH-1 downto 0);

  signal P_i_vj_jp_k          : PE_RESIDUE_ARRAY;

begin

  -----------------------------------------------------------------------------
  -- Initialize bottom PE using a finite state machine
  -----------------------------------------------------------------------------
  initialize_pes : pe_init_fsm
    port map (
      clk                  => clk,
      reset                => reset,

      sequence             => sequence,
      start                => start,

      X_i_j_1              => X_i_vj_jp_k(NO_PE_JP)(1),

      vj_eq_tile_width_j   => vj_eq_tile_width_j(1),

      wait_upstrm          => wait_upstrm,

      init_seq             => init_seq,
      initial_S_i          => initial_S_i,
      initial_S_j          => initial_S_j,

      start_aggr           => init_start_aggr,
      init_pipe14          => init_init_pipe14,
      j_m_i_2              => j_m_i_2,

      sequence_score       => sequence_score,
      vld                  => vld
    );

  -----------------------------------------------------------------------------
  -- Generate bottom PE
  -----------------------------------------------------------------------------
  -- seq_len should be a multiple of tile_width_j
  array_gen_bottom_jp : for jp in 1 to NO_PE_JP
    generate
      indiv_pe : pe_bottom
        generic map (
          RESET_STATE            => ZEROES(15 downto 0)
          )
        port map (
          clk                    => clk,
          reset                  => reset,

          init_seq               => init_seq(jp),
          initial_S_i            => initial_S_i,
          initial_S_j            => initial_S_j,

          in_start_aggr          => init_start_aggr(jp),
          in_init_pipe14         => init_init_pipe14(jp),
          in_j_m_i_2             => j_m_i_2(jp),

          in_X1_i_Wjm1_jpm1_k    => X1_i_vj_jp_k(jp-1)(1),
          in_X_i_Wj_jpm1_k       => X_i_vj_jp_k(jp-1)(1),
          in_X_ip1_Wj_jpm1_k     => X_i_vj_jp_k(jp-1)(1),
          in_X_i_vj_jp_kp1       => X_i_vj_jp_k(jp)(2),

          in_P_i_Wjm1_jpm1_k     => P_i_vj_jp_k(jp-1),

          out_X_i_vj_jp_k        => X_i_vj_jp_k(jp)(1),
          out_X1_i_vj_jp_k       => X1_i_vj_jp_k(jp)(1),
          out_X2_i_vj_jp_k       => X2_i_vj_jp_k(jp)(1),
          out_X3_i_vj_jp_k       => X3_i_vj_jp_k(jp)(1),

          out_P_i_vj_jp_k        => P_i_vj_jp_k(jp),

          out_vj_eq_tile_width_j => vj_eq_tile_width_j(jp),

          out_start_aggr         => start_aggr(jp)(1),
          out_init_pipe14        => init_pipe14(jp)(1)
          );
    end generate;

  -----------------------------------------------------------------------------
  -- Generate other PEs, k > 1
  -----------------------------------------------------------------------------
  array_gen_other_jp : for jp in 1 to NO_PE_JP
    generate
      array_gen_other_k : for k in 2 to ((jp*TILE_WIDTH_J) - 1) / 2
        generate
          indiv_pe : pe_other
            generic map (
              RESET_STATE            => conv_std_logic_vector
                                         ( (k-1) mod TILE_WIDTH_J, 16 ),
              USE_BRAM               => false
              )
            port map (
              clk                    => clk,
              reset                  => reset,

              in_start_aggr          => start_aggr(jp)(k-1),
              in_init_pipe14         => init_pipe14(jp)(k-1),

              in_X_i_vj_jp_kp1       => X_i_vj_jp_k(jp)(k+1),

              in_X1_i_Wjm1_jpm1_k    => X1_i_vj_jp_k(jp-1)(k),
              in_X2_ip1_vj_jp_km1    => X2_i_vj_jp_k(jp)(k-1),
              in_X3_i_Wjm1_jpm1_km1  => X3_i_vj_jp_k(jp-1)(k-1),
              in_X3_i_vjm1_jp_km1    => X3_i_vj_jp_k(jp)(k-1),

              out_X_i_vj_jp_k        => X_i_vj_jp_k(jp)(k),
              out_X1_i_vj_jp_k       => X1_i_vj_jp_k(jp)(k),
              out_X2_i_vj_jp_k       => X2_i_vj_jp_k(jp)(k),
              out_X3_i_vj_jp_k       => X3_i_vj_jp_k(jp)(k),

              out_start_aggr         => start_aggr(jp)(k),
              out_init_pipe14        => init_pipe14(jp)(k)
              );
        end generate;
      end generate;

    assert (vld = '0') report
      "Processing completed" severity note;

end architecture top_level;
