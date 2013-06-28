
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
use ieee.math_real.all;

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

  -- sequence length
  constant SEQ_LEN              : integer := 207;
  -- constant SEQ_LEN              : integer := 600;
  -- constant SEQ_LEN              : integer := 597;

  -- TILE_WIDTH_K and (SEQ_LEN / TILE_WIDTH_K) must be relatively prime
  constant TILE_WIDTH_K         : integer := 5;
  -- constant TILE_WIDTH_K         : integer := 3;

  -- number of physical processors along axis k'
  -- 1 <= k' <= ceil ( ceil ((SEQ_LEN - 1) / 2) / TILE_WIDTH_K )
  constant NO_PE_K              : integer := integer ( ceil ( ceil ((real(SEQ_LEN) - 1.0) / 2.0) / real(TILE_WIDTH_K) ) );

  -- schedule parameters
  constant SCHEDULE_A           : integer := (-TILE_WIDTH_K);
  constant SCHEDULE_B           : integer := (SEQ_LEN * TILE_WIDTH_K);
  constant SCHEDULE_C           : integer := (-1);
  constant SCHEDULE_D           : integer := (-TILE_WIDTH_K);

  -- number of residues received per clock from input stream
  constant RESIDUES_PER_CLK     : integer := 21;

  -- number of residues to store for the nussinov computation
  -- this is >= length of sequence
  -- multiple of 64 bits
  constant NO_RESIDUES          : integer := 210;
  -- constant NO_RESIDUES          : integer := 609;

  -- number of sequences to buffer before sending to the array
  constant SEQUENCES_TO_BUFFER  : integer := 1;

  -- bits for residue
  constant RESIDUE_WIDTH        : integer := 3;

  -- bits for cell score
  constant CELL_WIDTH           : integer := 7;
  -- constant CELL_WIDTH           : integer := 9;

  -- invalid residue type
  constant INVALID_RESIDUE      : slv(RESIDUE_WIDTH-1 downto 0) := "111";

  -- maximum number of PEs that may use block rams
  -- this value is device dependent
  constant NO_BRAM_PES          : integer := 79;

  -- reset state
  constant RESET_STATE          : integer := TILE_WIDTH_K;

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

  ---------------------------------------------------------------------------
  -- list of functions
  ---------------------------------------------------------------------------

  function SCHEDULE (i : integer; j : integer; k : integer; l : integer) return integer;

end package nussinov_pkg;

package body nussinov_pkg is

  -- function to compute schedule time
  function SCHEDULE (i : integer; j : integer; k : integer; l : integer)
    return integer is
  begin
    return ( ((i) * SCHEDULE_A) + ((j) * SCHEDULE_B) + ((k) * SCHEDULE_C) + ((l) * SCHEDULE_D) );
  end SCHEDULE;
  
end package body nussinov_pkg;
