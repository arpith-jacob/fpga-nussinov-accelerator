
-- File: pe_bottom_j_1.vhd
-- Date: 28 Jan 2010
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      Processing element implementing the bottom cells of the nussinov 110
-- array. PE j = 1, k = 1

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.nussinov_pkg.all;

entity pe_bottom_j_1 is
  port (
    clk                  : in  sl;
    reset                : in  sl;

    --
    -- INPUT
    --
    -- INITIALIZATION
    --
    -- sequence characters: initialization input
    -- sequence character S_i
    init_seq             : in  sl;
    initial_S_i          : in  slv(RESIDUE_WIDTH-1 downto 0);
    -- sequence character S_j
    initial_S_j          : in  slv(RESIDUE_WIDTH-1 downto 0);

    --
    -- OUTPUT
    --
    -- output dependencies
    -- X(i, j, k)
    out_X_i_j_k          : out slv(CELL_WIDTH-1 downto 0);

    -- output sequence characters
    out_S_i              : out slv(RESIDUE_WIDTH-1 downto 0);
    out_S_j              : out slv(RESIDUE_WIDTH-1 downto 0)
    );
end entity;

architecture rtl of pe_bottom_j_1 is

  -----------------------------------------------------------------------------
  -- Intermediate computation signals
  -----------------------------------------------------------------------------
  signal base_pair_xor : slv(RESIDUE_WIDTH-1 downto 0);
  signal base_pair     : sl;

  signal X_init        : slv(CELL_WIDTH-1 downto 0);

  -----------------------------------------------------------------------------
  -- Output signals
  -----------------------------------------------------------------------------
  signal X_i_j_k       : slv(CELL_WIDTH-1 downto 0);

  signal S_i           : slv(RESIDUE_WIDTH-1 downto 0);
  signal S_j           : slv(RESIDUE_WIDTH-1 downto 0);

begin

  -----------------------------------------------------------------------------
  -- Compute values for data variables
  -----------------------------------------------------------------------------

  -- a base is defined as a A, U pair or a C, G pair
  -- Encoding for residues: A = 000, C = 001, G = 010, U = 011
  -- We have a A, U or C, G if and only if S[i] xor S[j] = 11
  --           and they are both valid residues
  base_pair_xor <= initial_S_i xor initial_S_j;
  base_pair     <= not (initial_S_i(2) or initial_S_j(2)) when
                   (base_pair_xor(1 downto 0) = "11") else
                   '0';

  X_init(CELL_WIDTH-1 downto 1) <= (others => '0');
  X_init(0)                     <= base_pair;

  -- Compute X variable
  X_i_j_k         <= X_init;

  -----------------------------------------------------------------------------
  -- Sequence data variables
  -----------------------------------------------------------------------------

  -- sequence
  S_i             <= initial_S_i;
  S_j             <= initial_S_j;

  -----------------------------------------------------------------------------
  -- Assign output signals
  -----------------------------------------------------------------------------

  out_X_i_j_k     <= X_i_j_k;

  out_S_i         <= S_i;
  out_S_j         <= S_j;

end rtl;
