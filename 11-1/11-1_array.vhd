
-- File: 11-1_array.vhd
-- Date: 11 Feb 2010
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

      sequence             : in  RESIDUE_ARRAY;
      start                : in  sl;

      X_i_j_k              : in  slv(CELL_WIDTH-1 downto 0);

      wait_upstrm          : out sl;

      init_seq             : out sl;
      initial_S_i          : out RESIDUE_ARRAY;
      initial_S_j          : out RESIDUE_ARRAY;

      k_eq_1               : out slv(1 to 1);
      start_aggr           : out slv(1 to 2);
      init_pipe58          : out slv(1 to 1);

      sequence_score       : out slv(31 downto 0);
      vld                  : out sl
    );
  end component;

  -- nussinov 11-1 processing elements
  component pe_j_1 is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      init_seq             : in  sl;
      initial_S_i          : in  slv(RESIDUE_WIDTH-1 downto 0);
      initial_S_j          : in  slv(RESIDUE_WIDTH-1 downto 0);

      out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);

      out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0);
      out_S_j              : out slv(RESIDUE_WIDTH-1 downto 0)
      );
  end component;

  component pe_j_2 is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      in_k_eq_1            : in  sl;
      in_start_aggr        : in  sl;
      in_init_pipe58       : in  sl;

      in_X_ip1_j_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);

      in_S_i               : in  slv(RESIDUE_WIDTH-1 downto 0);
      in_S_j               : in  slv(RESIDUE_WIDTH-1 downto 0);

      out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X5_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X8_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

      out_k_eq_1           : out sl;
      out_start_aggr       : out sl;
      out_init_pipe58      : out sl;

      out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0);
      out_S_j              : out slv(RESIDUE_WIDTH-1 downto 0)
      );
  end component;

  component pe_j_3 is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      in_k_eq_1            : in  sl;
      in_start_aggr        : in  sl;
      in_init_pipe58       : in  sl;

      in_X_ip1_j_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_ip2_j_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_ip1_jm1_k       : in  slv(CELL_WIDTH-1 downto 0);

      in_X5_i_jm1_k        : in  slv(CELL_WIDTH-1 downto 0);
      in_X8_ip1_j_k        : in  slv(CELL_WIDTH-1 downto 0);

      in_S_i               : in  slv(RESIDUE_WIDTH-1 downto 0);
      in_S_j               : in  slv(RESIDUE_WIDTH-1 downto 0);

      out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X5_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X8_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

      out_k_eq_1           : out sl;
      out_start_aggr       : out sl;
      out_init_pipe58      : out sl;

      out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0);
      out_S_j              : out slv(RESIDUE_WIDTH-1 downto 0)
      );
  end component;

  component pe_all is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      in_k_eq_1            : in  sl;
      in_start_aggr        : in  sl;
      in_init_pipe58       : in  sl;

      in_X_ip1_j_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_ip2_j_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_jm1_k         : in  slv(CELL_WIDTH-1 downto 0);
      in_X_ip1_jm1_k       : in  slv(CELL_WIDTH-1 downto 0);
      in_X_i_j_kp1         : in  slv(CELL_WIDTH-1 downto 0);

      in_X5_i_jm1_k        : in  slv(CELL_WIDTH-1 downto 0);
      in_X6_ip1_j_km1      : in  slv(CELL_WIDTH-1 downto 0);
      in_X7_i_jm1_km1      : in  slv(CELL_WIDTH-1 downto 0);
      in_X8_ip1_j_k        : in  slv(CELL_WIDTH-1 downto 0);

      in_S_i               : in  slv(RESIDUE_WIDTH-1 downto 0);
      in_S_j               : in  slv(RESIDUE_WIDTH-1 downto 0);

      out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X5_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X8_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

      out_k_eq_1           : out sl;
      out_start_aggr       : out sl;
      out_init_pipe58      : out sl;

      out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0);
      out_S_j              : out slv(RESIDUE_WIDTH-1 downto 0)
      );
  end component;

  component pe_other is
    port (
      clk                  : in  sl;
      reset                : in  sl;

      in_start_aggr        : in  sl;
      in_init_pipe58       : in  sl;

      in_X_i_j_kp1         : in  slv(CELL_WIDTH-1 downto 0);

      in_X5_i_jm1_k        : in  slv(CELL_WIDTH-1 downto 0);
      in_X6_ip1_j_km1      : in  slv(CELL_WIDTH-1 downto 0);
      in_X7_i_jm1_km1      : in  slv(CELL_WIDTH-1 downto 0);
      in_X8_ip1_j_k        : in  slv(CELL_WIDTH-1 downto 0);

      out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);
      out_X5_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X6_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X7_i_j_k         : out slv(CELL_WIDTH-1 downto 0);
      out_X8_i_j_k         : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr       : out sl;
      out_init_pipe58      : out sl
      );
  end component;

  -- signals from initialization FSM
  signal init_seq             : sl;
  signal initial_S_i          : RESIDUE_ARRAY;
  signal initial_S_j          : RESIDUE_ARRAY;

  signal init_k_eq_1          : slv(1 to 1);
  signal init_start_aggr      : slv(1 to 2);
  signal init_init_pipe58     : slv(1 to 1);

  -- max k value
  constant MAX_K              : integer := SEQ_LEN;

  -- wires connecting the processing elements
  type PE_CELL_ARRAY_K is array (1 to MAX_K + 1) of slv(CELL_WIDTH-1 downto 0);

  type PE_CELL_ARRAY is array (1 to SEQ_LEN) of PE_CELL_ARRAY_K;

  signal X_i_j_k              : PE_CELL_ARRAY;
  signal X5_i_j_k             : PE_CELL_ARRAY;
  signal X6_i_j_k             : PE_CELL_ARRAY;
  signal X7_i_j_k             : PE_CELL_ARRAY;
  signal X8_i_j_k             : PE_CELL_ARRAY;

  type PE_BIT_ARRAY is array (1 to SEQ_LEN) of slv(1 to MAX_K);

  signal k_eq_1               : PE_BIT_ARRAY;
  signal start_aggr           : PE_BIT_ARRAY;
  signal init_pipe58          : PE_BIT_ARRAY;

  type PE_RESIDUE_ARRAY_K is array (2 to MAX_K) of
         slv(RESIDUE_WIDTH-1 downto 0);

  type PE_RESIDUE_ARRAY is array (1 to SEQ_LEN) of PE_RESIDUE_ARRAY_K;

  signal S_i                  : PE_RESIDUE_ARRAY;
  signal S_j                  : PE_RESIDUE_ARRAY;

begin

  -----------------------------------------------------------------------------
  -- Initialize bottom PE using a finite state machine
  -----------------------------------------------------------------------------
  initialize_pes : pe_init_fsm
    port map (
      clk                  => clk,
      reset                => reset,

      sequence             => isequence,
      start                => istart,

      X_i_j_k              => X_i_j_k(SEQ_LEN - 1)(2),

      wait_upstrm          => wait_upstrm,

      init_seq             => init_seq,
      initial_S_i          => initial_S_i,
      initial_S_j          => initial_S_j,

      k_eq_1               => init_k_eq_1,
      start_aggr           => init_start_aggr,
      init_pipe58          => init_init_pipe58,

      sequence_score       => osequence_score,
      vld                  => ovld
    );

  -----------------------------------------------------------------------------
  -- Generate bottom PE
  -----------------------------------------------------------------------------
  -- pe j - i = 1
  array_gen_j_1 : for k in 2 to SEQ_LEN
    generate
      indiv_pe : pe_j_1
        port map (
          clk                  => clk,
          reset                => reset,

          init_seq             => init_seq,
          initial_S_i          => initial_S_i(k),
          initial_S_j          => initial_S_j(k),

          out_X_i_j_k          => X_i_j_k(1)(k),

          out_S_i              => S_i(1)(k),
          out_S_j              => S_j(1)(k)
          );
    end generate;

  -- pe j - i = 2
  array_gen_j_2 : for k in 2 to SEQ_LEN-1
    generate
      indiv_pe : pe_j_2
        port map (
          clk                  => clk,
          reset                => reset,

          in_k_eq_1            => init_k_eq_1(1),
          in_start_aggr        => init_start_aggr(1),
          in_init_pipe58       => init_init_pipe58(1),

          in_X_ip1_j_k         => X_i_j_k(1)(k+1),
          in_X_i_jm1_k         => X_i_j_k(1)(k),

          in_S_i               => S_i(1)(k),
          in_S_j               => S_j(1)(k+1),

          out_X_i_j_k          => X_i_j_k(2)(k),
          out_X5_i_j_k         => X5_i_j_k(2)(k),
          out_X6_i_j_k         => X6_i_j_k(2)(k),
          out_X7_i_j_k         => X7_i_j_k(2)(k),
          out_X8_i_j_k         => X8_i_j_k(2)(k),

          out_k_eq_1           => k_eq_1(2)(k),
          out_start_aggr       => start_aggr(2)(k),
          out_init_pipe58      => init_pipe58(2)(k),

          out_S_i              => S_i(2)(k),
          out_S_j              => S_j(2)(k)
          );
    end generate;

  -- pe j - i = 3
  array_gen_j_3 : for k in 2 to SEQ_LEN-2
    generate
      indiv_pe : pe_j_3
        port map (
          clk                  => clk,
          reset                => reset,

          in_k_eq_1            => k_eq_1(2)(k+1),
          in_start_aggr        => init_start_aggr(2),
          in_init_pipe58       => ZEROES(0),

          in_X_ip1_j_k         => X_i_j_k(2)(k+1),
          in_X_ip2_j_k         => X_i_j_k(1)(k+2),
          in_X_i_jm1_k         => X_i_j_k(2)(k),
          in_X_ip1_jm1_k       => X_i_j_k(1)(k+1),

          in_X5_i_jm1_k        => X5_i_j_k(2)(k),
          in_X8_ip1_j_k        => X8_i_j_k(2)(k+1),

          in_S_i               => S_i(2)(k),
          in_S_j               => S_j(2)(k+1),

          out_X_i_j_k          => X_i_j_k(3)(k),
          out_X5_i_j_k         => X5_i_j_k(3)(k),
          out_X6_i_j_k         => X6_i_j_k(3)(k),
          out_X7_i_j_k         => X7_i_j_k(3)(k),
          out_X8_i_j_k         => X8_i_j_k(3)(k),

          out_k_eq_1           => k_eq_1(3)(k),
          out_start_aggr       => start_aggr(3)(k),
          out_init_pipe58      => init_pipe58(3)(k),

          out_S_i              => S_i(3)(k),
          out_S_j              => S_j(3)(k)
          );
    end generate;

  gen_start_aggr_zeroes : for j in 2 to SEQ_LEN
    generate
      start_aggr(j)(1)  <= '0';
      init_pipe58(j)(1) <= '0';
    end generate;

  -- other pes
  array_gen_j_others : for j in 4 to SEQ_LEN-1
    generate
      array_gen_k_all : for k in 2 to SEQ_LEN-j+1
        generate
          indiv_pe : pe_all
            port map (
              clk                  => clk,
              reset                => reset,

              in_k_eq_1            => k_eq_1(j-1)(k+1),
              in_start_aggr        => start_aggr(j-2)(k-1),
              in_init_pipe58       => init_pipe58(j-2)(k-1),

              in_X_ip1_j_k         => X_i_j_k(j-1)(k+1),
              in_X_ip2_j_k         => X_i_j_k(j-2)(k+2),
              in_X_i_jm1_k         => X_i_j_k(j-1)(k),
              in_X_ip1_jm1_k       => X_i_j_k(j-2)(k+1),
              in_X_i_j_kp1         => X_i_j_k(j)(k+1),

              in_X5_i_jm1_k        => X5_i_j_k(j-1)(k),
              in_X6_ip1_j_km1      => X6_i_j_k(j-1)(k),
              in_X7_i_jm1_km1      => X7_i_j_k(j-1)(k-1),
              in_X8_ip1_j_k        => X8_i_j_k(j-1)(k+1),

              in_S_i               => S_i(j-1)(k),
              in_S_j               => S_j(j-1)(k+1),

              out_X_i_j_k          => X_i_j_k(j)(k),
              out_X5_i_j_k         => X5_i_j_k(j)(k),
              out_X6_i_j_k         => X6_i_j_k(j)(k),
              out_X7_i_j_k         => X7_i_j_k(j)(k),
              out_X8_i_j_k         => X8_i_j_k(j)(k),

              out_k_eq_1           => k_eq_1(j)(k),
              out_start_aggr       => start_aggr(j)(k),
              out_init_pipe58      => init_pipe58(j)(k),

              out_S_i              => S_i(j)(k),
              out_S_j              => S_j(j)(k)
              );
        end generate;

      array_gen_k_others : for k in SEQ_LEN-j+2 to SEQ_LEN-j+(j/2)
        generate
          indiv_pe : pe_other
            port map (
              clk                  => clk,
              reset                => reset,

              in_start_aggr        => start_aggr(j-2)(k-1),
              in_init_pipe58       => init_pipe58(j-2)(k-1),

              in_X_i_j_kp1         => X_i_j_k(j)(k+1),

              in_X5_i_jm1_k        => X5_i_j_k(j-1)(k),
              in_X6_ip1_j_km1      => X6_i_j_k(j-1)(k),
              in_X7_i_jm1_km1      => X7_i_j_k(j-1)(k-1),
              in_X8_ip1_j_k        => X8_i_j_k(j-1)(k+1),

              out_X_i_j_k          => X_i_j_k(j)(k),
              out_X5_i_j_k         => X5_i_j_k(j)(k),
              out_X6_i_j_k         => X6_i_j_k(j)(k),
              out_X7_i_j_k         => X7_i_j_k(j)(k),
              out_X8_i_j_k         => X8_i_j_k(j)(k),

              out_start_aggr       => start_aggr(j)(k),
              out_init_pipe58      => init_pipe58(j)(k)
              );
        end generate;
      end generate;

    assert (ovld = '0') report
      "Processing completed" severity note;

end architecture top_level;
