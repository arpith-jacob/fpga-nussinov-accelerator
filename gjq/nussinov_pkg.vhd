
-- File: nussinov_pkg.vhd
-- Date: 9 Feb 2008
-- Project: Nussinov
-- Author: Arpith Chacko Jacob
--         Department of Computer Science and Engineering
--         Washington University in Saint Louis
-- Description:
--      This file defines the package header for the Nussinov systolic array.

library ieee;  
use ieee.std_logic_1164.all;

package nussinov_pkg is

  -- aliases
  alias sl is std_logic;
  alias slv is std_logic_vector;

  constant ZEROES               : slv(1023 downto 0) := (others => '0');
  constant ONES                 : slv(1023 downto 0) := (others => '1');

  ---------------------------------------------------------------------------
  -- design constants
  ---------------------------------------------------------------------------

  -- number of nussinov arrays running simultaneously
  constant NO_UNITS             : integer := 1;
  -- constant NO_UNITS             : integer := 3;

  -- number of processing elements: (SEQ_LEN - 1) should be divisible by 2
    --constant SEQ_LEN            : integer := 83;
    --constant SEQ_LEN            : integer := 65;
    constant SEQ_LEN            : integer := 47;
  -- 47 pes with 20 bits at 80 Mhz
  -- 81 pes with 6  bits at 80 Mhz

  -- latency of array
  constant ARRAY_LATENCY        : integer := ((2*SEQ_LEN) - 3);

  -- number of residues received per clock from input stream
  constant RESIDUES_PER_CLK     : integer := 21;

  -- number of residues to store for the nussinov computation
  -- this is >= length of sequence
  -- multiple of 64 bits
  constant NO_RESIDUES          : integer := 63;

  -- number of sequences to buffer before sending to the array
  constant SEQUENCES_TO_BUFFER  : integer := 1;

  -- bits for residue
  constant RESIDUE_WIDTH        : integer := 3;

  -- bits for cell score
  --constant CELL_WIDTH           : integer := 6;
  --constant CELL_WIDTH           : integer := 8;
  constant CELL_WIDTH           : integer := 16;

  -- invalid residue type
  constant INVALID_RESIDUE      : slv(RESIDUE_WIDTH-1 downto 0) := "111";

  ---------------------------------------------------------------------------
  -- design types
  ---------------------------------------------------------------------------

  -- query residues array for all PEs
  type RESIDUE_ARRAY is array (1 to NO_RESIDUES) of
         slv(RESIDUE_WIDTH-1 downto 0);

  -- multiple sequences into the underutilized array
  type BUFF_SEQUENCE_ARRAY is array (0 to SEQUENCES_TO_BUFFER - 1) of
         RESIDUE_ARRAY;

  -- sequences for multiple units
  type UNIT_RESIDUE_ARRAY is array (0 to NO_UNITS - 1) of RESIDUE_ARRAY;

  -- scores from multiple units
  type SCORE_ARRAY is array (0 to NO_UNITS - 1) of slv(31 downto 0);

end package nussinov_pkg;

package body nussinov_pkg is
  
end package body nussinov_pkg;
