
-- File: gkt_array.vhd
-- Date: 9 Feb 2008
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
--    array_working    : out sl;

    -- array is busy
    wait_upstrm      : out sl;

    -- OUTPUTS
    osequence_score  : out slv(31 downto 0);
    ovld             : out sl
  );
end entity nussinov;

architecture top_level of nussinov is

  -- nussinov GKT processing element
  component pe
    port (
      clk              : in  sl;
      reset            : in  sl;

      in_start_aggr    : in  sl;
      in_end_aggr      : in  sl;
      in_init_pipe58   : in  sl;
      in_init_pipe67   : in  sl;

      in_X_south       : in  slv(CELL_WIDTH-1 downto 0);
      in_X_west        : in  slv(CELL_WIDTH-1 downto 0);
      in_X_south_west  : in  slv(CELL_WIDTH-1 downto 0);
      in_X_south_x2    : in  slv(CELL_WIDTH-1 downto 0);

      in_X5_west       : in  slv(CELL_WIDTH-1 downto 0);
      in_X6_south      : in  slv(CELL_WIDTH-1 downto 0);
      in_X7_west       : in  slv(CELL_WIDTH-1 downto 0);
      in_X8_south      : in  slv(CELL_WIDTH-1 downto 0);

      in_S_i           : in  slv(RESIDUE_WIDTH-1 downto 0);
      in_S_j           : in  slv(RESIDUE_WIDTH-1 downto 0);

      out_X_north      : out slv(CELL_WIDTH-1 downto 0);
      out_X_east       : out slv(CELL_WIDTH-1 downto 0);
      out_X_north_east : out slv(CELL_WIDTH-1 downto 0);
      out_X_north_x2   : out slv(CELL_WIDTH-1 downto 0);

      out_X5           : out slv(CELL_WIDTH-1 downto 0);
      out_X6           : out slv(CELL_WIDTH-1 downto 0);
      out_X7           : out slv(CELL_WIDTH-1 downto 0);
      out_X8           : out slv(CELL_WIDTH-1 downto 0);

      out_start_aggr   : out sl;
      out_end_aggr     : out sl;
      out_init_pipe58  : out sl;
      out_init_pipe67  : out sl;

      out_S_i          : out slv(RESIDUE_WIDTH-1 downto 0);
      out_S_j          : out slv(RESIDUE_WIDTH-1 downto 0)
      );
  end component;

  -- period counter.  This is the number of clock cycles the array is
  -- busy before it can accept the next input.
  signal period_cntr       : slv(15 downto 0);
  -- latency counter.  This is the number of clock cycles the array takes
  -- to process one input.
  signal latency_cntr      : slv(15 downto 0);

  -- nussinov array is busy
  signal array_busy        : sl;
  signal array_working_int : sl;

  signal isequence_reg : RESIDUE_ARRAY;

  signal istart_1          : sl;
  signal istart_2          : sl;
  
  -- wires connecting the processing elements
  type PE_BIT_ARRAY is array (1 to NO_PE) of slv(1 to NO_PE);

  type PE_CELL_ARRAY_1D is array (1 to NO_PE) of slv(CELL_WIDTH-1 downto 0);
  type PE_CELL_ARRAY is array (1 to NO_PE) of PE_CELL_ARRAY_1D;

  type PE_SEQ_ARRAY_1D is array (1 to NO_PE) of slv(RESIDUE_WIDTH-1 downto 0);
  type PE_SEQ_ARRAY is array (1 to NO_PE) of PE_SEQ_ARRAY_1D;

  -- xor values of adjacent sequence residues (for initialization)
  signal seqdata_xor       : RESIDUE_ARRAY;
  signal seqdata_xor_1     : RESIDUE_ARRAY;

  signal start_aggr        : PE_BIT_ARRAY;
  signal end_aggr          : PE_BIT_ARRAY;
  signal init_pipe58       : PE_BIT_ARRAY;
  signal init_pipe67       : PE_BIT_ARRAY;

  signal X_north           : PE_CELL_ARRAY;
  signal X_east            : PE_CELL_ARRAY;
  signal X_north_east      : PE_CELL_ARRAY;
  signal X_north_x2        : PE_CELL_ARRAY;

  signal X5                : PE_CELL_ARRAY;
  signal X6                : PE_CELL_ARRAY;
  signal X7                : PE_CELL_ARRAY;
  signal X8                : PE_CELL_ARRAY;

  signal S_i               : PE_SEQ_ARRAY;
  signal S_j               : PE_SEQ_ARRAY;

begin

  -----------------------------------------------------------------------------
  -- Process to register sequence information.  Needed for init control signals
  -- to work
  -----------------------------------------------------------------------------
  reg_seqstart : process (clk)
  begin 
    if rising_edge(clk) then
      if reset = '1' then
        istart_1        <= '0';
        istart_2        <= '0';

        isequence_reg   <= (others => (others => '0'));
      else
        istart_1        <= istart;
        istart_2        <= istart_1;

        -- register input sequence
        if istart = '1' then
          isequence_reg <= isequence;
        end if;
      end if;
    end if;
  end process reg_seqstart;

  -----------------------------------------------------------------------------
  -- Initialize border of GKT array
  --
  -- Connect border wires to initial values
  -----------------------------------------------------------------------------

  -- X(i)(i) = 0, 1 <= i <= N
  init_X_1 : for i in 1 to NO_PE
    generate
      X_north_east(i)(i) <= (others => '0');
      X_north_x2(i)(i)   <= (others => '0');
    end generate;

  -- X(i)(i + 1) = delta(), 1 <= i <= N
  -- each point is initialized to 0 or 1
  init_X_2 : for i in 1 to NO_PE - 1
    generate
      seqdata_xor(i)       <= isequence(i) xor isequence(i + 1);
      seqdata_xor_1(i)     <= isequence_reg(i) xor isequence_reg(i + 1);
      
      X_east(i)(i + 1)(CELL_WIDTH-1 downto 1) <= (others => '0');
      X_east(i)(i + 1)(0) <= not (isequence(i)(2) or isequence(i + 1)(2))
                                when seqdata_xor(i)(1 downto 0) = "11"
                                else
                              '0';

      X_north(i)(i + 1)(CELL_WIDTH-1 downto 1) <= (others => '0');
      X_north(i)(i + 1)(0) <= not (isequence(i)(2) or isequence(i + 1)(2))
                                when seqdata_xor(i)(1 downto 0) = "11"
                                else
                              '0';

      X_north_east(i)(i + 1)(CELL_WIDTH-1 downto 1) <= (others => '0');
      X_north_east(i)(i + 1)(0) <= not (isequence_reg(i)(2) or
                                        isequence_reg(i + 1)(2))
                                when seqdata_xor_1(i)(1 downto 0) = "11"
                                else
                              '0';

      X_north_x2(i)(i + 1)(CELL_WIDTH-1 downto 1) <= (others => '0');
      X_north_x2(i)(i + 1)(0) <= not (isequence_reg(i)(2) or
                                      isequence_reg(i + 1)(2))
                                when seqdata_xor_1(i)(1 downto 0) = "11"
                                else
                              '0';
    end generate;

  -- generate control information
  init_ctrl_1 : for i in 1 to NO_PE - 1
    generate
      end_aggr(i)(i + 1)    <= istart;
      init_pipe67(i)(i + 1) <= istart;
    end generate;

  init_ctrl_2 : for i in 1 to NO_PE
    generate
      start_aggr(i)(i)      <= istart;

      -- this signal can only ever be high for every other diagonal of PEs
      init_pipe58(i)(i)     <= istart;
    end generate;

  init_ctrl_3 : for i in 1 to NO_PE - 1
    generate
      start_aggr(i)(i + 1)  <= istart_2;
      init_pipe58(i)(i + 1) <= '0';
    end generate;

  -- init sequence data pipeline
  init_seq_pipei : for i in 1 to NO_PE - 2
    generate
      S_i(i + 1)(i + 2) <= isequence(i + 2);
    end generate;

  init_seq_pipej : for i in 1 to NO_PE - 2
    generate
      S_j(i)(i + 1)     <= isequence(i);
    end generate;

  -----------------------------------------------------------------------------
  -- Generate GKT pe array
  -----------------------------------------------------------------------------
  array_gen_i : for i in 1 to NO_PE - 2
    generate
      array_gen_j : for j in i + 2 to NO_PE
        generate
          indiv_pe : pe
            port map (
              clk              => clk,
              reset            => reset,

              in_start_aggr    => start_aggr(i + 1)(j - 1),
              in_end_aggr      => end_aggr(i + 1)(j),
              in_init_pipe58   => init_pipe58(i + 1)(j - 1),
              in_init_pipe67   => init_pipe67(i + 1)(j),

              in_X_south       => X_north(i + 1)(j),
              in_X_west        => X_east(i)(j - 1),
              in_X_south_west  => X_north_east(i + 1)(j - 1),
              in_X_south_x2    => X_north_x2(i + 2)(j),

              in_X5_west       => X5(i)(j - 1),
              in_X6_south      => X6(i + 1)(j),
              in_X7_west       => X7(i)(j - 1),
              in_X8_south      => X8(i + 1)(j),

              in_S_i           => S_i(i + 1)(j),
              in_S_j           => S_j(i)(j - 1),

              out_X_north      => X_north(i)(j),
              out_X_east       => X_east(i)(j),
              out_X_north_east => X_north_east(i)(j),
              out_X_north_x2   => X_north_x2(i)(j),

              out_X5           => X5(i)(j),
              out_X6           => X6(i)(j),
              out_X7           => X7(i)(j),
              out_X8           => X8(i)(j),

              out_start_aggr   => start_aggr(i)(j),
              out_end_aggr     => end_aggr(i)(j),
              out_init_pipe58  => init_pipe58(i)(j),
              out_init_pipe67  => init_pipe67(i)(j),

              out_S_i          => S_i(i)(j),
              out_S_j          => S_j(i)(j)
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
        period_cntr    <= (others => '0');
        latency_cntr   <= (others => '0');
      else

        if period_cntr > 1 then
          period_cntr  <= period_cntr - 1;
        end if;

        if latency_cntr > 1 then
          latency_cntr <= latency_cntr - 1;
        end if;

        -- start counting latency
        if istart = '1' then
          period_cntr  <= conv_std_logic_vector(ARRAY_LATENCY - 1, 16);
          -- period_cntr  <= conv_std_logic_vector(ARRAY_PERIOD - 2, 16);
          -- wait for one more than the latency
          latency_cntr <= conv_std_logic_vector(ARRAY_LATENCY, 16);
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

        if period_cntr <= 1 then
          array_busy        <= '0';
        end if;

        if latency_cntr <= 1 then
          array_working_int <= '0';
        end if;

        -- register sequence id
        if istart = '1' then
          array_busy        <= '1';
          array_working_int <= '1';
        end if;
      end if;
    end if;
  end process output_proc;

  -- pause the top level if nussinov array is processing data
  wait_upstrm      <= istart or array_busy;

  -- array is processing an input.  flush only after this signal goes low
--  array_working    <= array_working_int;

  osequence_score(31 downto CELL_WIDTH)  <= (others => '0');
  osequence_score(CELL_WIDTH-1 downto 0) <= slv(X_east(1)(NO_PE));

  ovld             <= end_aggr(1)(NO_PE);

end architecture top_level;
