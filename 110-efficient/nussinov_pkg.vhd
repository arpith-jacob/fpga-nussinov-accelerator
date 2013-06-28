
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

  -- number of processing elements: (SEQ_LEN - 1) should be divisible by 2
  constant SEQ_LEN              : integer := 131;
  -- constant SEQ_LEN              : integer := 31;  -- 16-bit
  -- constant SEQ_LEN              : integer := 41; 8-bit

  -- GJQ array: 8-bit @ 180 MHz, 47% slices, 2% slicemems

  -- schedule parameters
  -- minimum number of pe pipeline stages = 1 @ 180 MHz, 38% slices, 7% slicemems
                                   --- 16-bit @ 180 MHz, 29% slices, 4% slicemems
  constant SCHEDULE_A           : integer := (-2);
  constant SCHEDULE_B           : integer := (3);
  constant SCHEDULE_C           : integer := (-1);

  -- minimum number of pe pipeline stages = 2 @ 250 MHz, 41% slices, 14% slicemems
--  constant SCHEDULE_A           : integer := (-4);
--  constant SCHEDULE_B           : integer := (5);
--  constant SCHEDULE_C           : integer := (-2);

  -- minimum number of pe pipeline stages = 3 @ 290 MHz, 42% slices, 22% slicems
                                   --- 16-bit @ 280 MHz, 31% slices, 12% slicemems
--  constant SCHEDULE_A           : integer := (-6);
--  constant SCHEDULE_B           : integer := (7);
--  constant SCHEDULE_C           : integer := (-3);

  -- minimum number of pe pipeline stages = 4 @ 340 MHz, 45% slices, 29% slicems
--  constant SCHEDULE_A           : integer := (-8);
--  constant SCHEDULE_B           : integer := (9);
--  constant SCHEDULE_C           : integer := (-4);

  -- minimum number of pe pipeline stages = 5 @ 340 MHz, ? % slices, % slicems
--  constant SCHEDULE_A           : integer := (-10);
--  constant SCHEDULE_B           : integer := (11);
--  constant SCHEDULE_C           : integer := (-5);

  -- minimum number of pe pipeline stages = 6 @ 360 MHz, 52% slices, 31% slicems
--  constant SCHEDULE_A           : integer := (-12);
--  constant SCHEDULE_B           : integer := (13);
--  constant SCHEDULE_C           : integer := (-6);

  -- number of residues received per clock from input stream
  constant RESIDUES_PER_CLK     : integer := 21;

  -- number of residues to store for the nussinov computation
  -- this is >= length of sequence
  -- multiple of 64 bits
  constant NO_RESIDUES          : integer := 147;

  -- number of fifo sequence words (in multiple_arrays.vhd) required to
  -- store an entire sequence.  We ensure that these many words are
  -- present in the buffer before proceeding with computation.
  constant NO_WORDS_FOR_SEQUENCE : integer := NO_RESIDUES / RESIDUES_PER_CLK;

  -- number of sequences to buffer before sending to the array
  constant SEQUENCES_TO_BUFFER  : integer := 1;

  -- bits for residue
  constant RESIDUE_WIDTH        : integer := 3;

  -- bits for cell score
  constant CELL_WIDTH           : integer := 7;
  --constant CELL_WIDTH           : integer := 16;

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

  -- sequence residues for multiple units
  type UNIT_RESIDUE_ARRAY is array (0 to NO_UNITS - 1) of
       slv(RESIDUE_WIDTH-1 downto 0);

  -- scores from multiple units
  type SCORE_ARRAY is array (0 to NO_UNITS - 1) of slv(31 downto 0);

  ---------------------------------------------------------------------------
  -- list of functions
  ---------------------------------------------------------------------------

  function SCHEDULE (i : integer; j : integer; k : integer) return integer;

end package nussinov_pkg;

package body nussinov_pkg is
  
  -- function to compute schedule time
  function SCHEDULE (i : integer; j : integer; k : integer)
    return integer is
  begin
    return ( (i * SCHEDULE_A) + (j * SCHEDULE_B) + (k * SCHEDULE_C) );
  end SCHEDULE;

end package body nussinov_pkg;
