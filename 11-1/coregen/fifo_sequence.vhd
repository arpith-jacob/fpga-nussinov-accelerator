--------------------------------------------------------------------------------
-- Copyright (c) 1995-2009 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: L.68
--  \   \         Application: netgen
--  /   /         Filename: fifo_sequence.vhd
-- /___/   /\     Timestamp: Tue Feb 16 17:25:40 2010
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl ./tmp/_cg/fifo_sequence.ngc ./tmp/_cg/fifo_sequence.vhd 
-- Device	: 4vlx100ff1148-12
-- Input file	: ./tmp/_cg/fifo_sequence.ngc
-- Output file	: ./tmp/_cg/fifo_sequence.vhd
-- # of Entities	: 1
-- Design Name	: fifo_sequence
-- Xilinx	: /syssoft/fpga_tools/xilinx_11.2i/ISE
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity fifo_sequence is
  port (
    valid : out STD_LOGIC; 
    rd_en : in STD_LOGIC := 'X'; 
    prog_full : out STD_LOGIC; 
    wr_en : in STD_LOGIC := 'X'; 
    full : out STD_LOGIC; 
    empty : out STD_LOGIC; 
    wr_clk : in STD_LOGIC := 'X'; 
    rst : in STD_LOGIC := 'X'; 
    rd_clk : in STD_LOGIC := 'X'; 
    dout : out STD_LOGIC_VECTOR ( 63 downto 0 ); 
    din : in STD_LOGIC_VECTOR ( 63 downto 0 ) 
  );
end fifo_sequence;

architecture STRUCTURE of fifo_sequence is
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux000312_513 : STD_LOGIC; 
  signal BU2_N6 : STD_LOGIC; 
  signal BU2_N4 : STD_LOGIC; 
  signal BU2_N2 : STD_LOGIC; 
  signal BU2_N01 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_tmp_ram_rd_en : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux00033_505 : STD_LOGIC; 
  signal BU2_U0_grf_rf_ram_regout_en : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_431 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_430 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_428 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_426 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_424 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_422 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_420 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_7_rt_418 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_8_rt_416 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count7 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count8 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_comp0 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_comp1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_comp1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_comp2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_353 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_308 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_0_rt_297 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_1_rt_296 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_2_rt_294 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_3_rt_292 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_4_rt_290 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_5_rt_288 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_6_rt_286 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_7_rt_284 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_8_rt_282 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count5 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count6 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count7 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count8 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0007 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0006 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0005 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0007 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0006 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0005 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0007 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0006 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0005 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0007 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0006 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0005 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0004 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_150 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_149 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_148 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_147 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_146 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_145 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_144 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_141 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000 : STD_LOGIC; 
  signal BU2_N1 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal din_2 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal dout_3 : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal BU2_U0_grf_rf_mem_dout_mem : STD_LOGIC_VECTOR ( 63 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d2 : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d1 : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1 : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad : STD_LOGIC_VECTOR ( 9 downto 3 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut : STD_LOGIC_VECTOR ( 9 downto 1 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000 : STD_LOGIC_VECTOR ( 9 downto 3 ); 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001 : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_d1 : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1 : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal BU2_U0_grf_rf_rstblk_wr_rst_reg : STD_LOGIC_VECTOR ( 1 downto 0 ); 
  signal BU2_U0_grf_rf_rstblk_rd_rst_reg : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal BU2_rd_data_count : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  dout(63) <= dout_3(63);
  dout(62) <= dout_3(62);
  dout(61) <= dout_3(61);
  dout(60) <= dout_3(60);
  dout(59) <= dout_3(59);
  dout(58) <= dout_3(58);
  dout(57) <= dout_3(57);
  dout(56) <= dout_3(56);
  dout(55) <= dout_3(55);
  dout(54) <= dout_3(54);
  dout(53) <= dout_3(53);
  dout(52) <= dout_3(52);
  dout(51) <= dout_3(51);
  dout(50) <= dout_3(50);
  dout(49) <= dout_3(49);
  dout(48) <= dout_3(48);
  dout(47) <= dout_3(47);
  dout(46) <= dout_3(46);
  dout(45) <= dout_3(45);
  dout(44) <= dout_3(44);
  dout(43) <= dout_3(43);
  dout(42) <= dout_3(42);
  dout(41) <= dout_3(41);
  dout(40) <= dout_3(40);
  dout(39) <= dout_3(39);
  dout(38) <= dout_3(38);
  dout(37) <= dout_3(37);
  dout(36) <= dout_3(36);
  dout(35) <= dout_3(35);
  dout(34) <= dout_3(34);
  dout(33) <= dout_3(33);
  dout(32) <= dout_3(32);
  dout(31) <= dout_3(31);
  dout(30) <= dout_3(30);
  dout(29) <= dout_3(29);
  dout(28) <= dout_3(28);
  dout(27) <= dout_3(27);
  dout(26) <= dout_3(26);
  dout(25) <= dout_3(25);
  dout(24) <= dout_3(24);
  dout(23) <= dout_3(23);
  dout(22) <= dout_3(22);
  dout(21) <= dout_3(21);
  dout(20) <= dout_3(20);
  dout(19) <= dout_3(19);
  dout(18) <= dout_3(18);
  dout(17) <= dout_3(17);
  dout(16) <= dout_3(16);
  dout(15) <= dout_3(15);
  dout(14) <= dout_3(14);
  dout(13) <= dout_3(13);
  dout(12) <= dout_3(12);
  dout(11) <= dout_3(11);
  dout(10) <= dout_3(10);
  dout(9) <= dout_3(9);
  dout(8) <= dout_3(8);
  dout(7) <= dout_3(7);
  dout(6) <= dout_3(6);
  dout(5) <= dout_3(5);
  dout(4) <= dout_3(4);
  dout(3) <= dout_3(3);
  dout(2) <= dout_3(2);
  dout(1) <= dout_3(1);
  dout(0) <= dout_3(0);
  din_2(63) <= din(63);
  din_2(62) <= din(62);
  din_2(61) <= din(61);
  din_2(60) <= din(60);
  din_2(59) <= din(59);
  din_2(58) <= din(58);
  din_2(57) <= din(57);
  din_2(56) <= din(56);
  din_2(55) <= din(55);
  din_2(54) <= din(54);
  din_2(53) <= din(53);
  din_2(52) <= din(52);
  din_2(51) <= din(51);
  din_2(50) <= din(50);
  din_2(49) <= din(49);
  din_2(48) <= din(48);
  din_2(47) <= din(47);
  din_2(46) <= din(46);
  din_2(45) <= din(45);
  din_2(44) <= din(44);
  din_2(43) <= din(43);
  din_2(42) <= din(42);
  din_2(41) <= din(41);
  din_2(40) <= din(40);
  din_2(39) <= din(39);
  din_2(38) <= din(38);
  din_2(37) <= din(37);
  din_2(36) <= din(36);
  din_2(35) <= din(35);
  din_2(34) <= din(34);
  din_2(33) <= din(33);
  din_2(32) <= din(32);
  din_2(31) <= din(31);
  din_2(30) <= din(30);
  din_2(29) <= din(29);
  din_2(28) <= din(28);
  din_2(27) <= din(27);
  din_2(26) <= din(26);
  din_2(25) <= din(25);
  din_2(24) <= din(24);
  din_2(23) <= din(23);
  din_2(22) <= din(22);
  din_2(21) <= din(21);
  din_2(20) <= din(20);
  din_2(19) <= din(19);
  din_2(18) <= din(18);
  din_2(17) <= din(17);
  din_2(16) <= din(16);
  din_2(15) <= din(15);
  din_2(14) <= din(14);
  din_2(13) <= din(13);
  din_2(12) <= din(12);
  din_2(11) <= din(11);
  din_2(10) <= din(10);
  din_2(9) <= din(9);
  din_2(8) <= din(8);
  din_2(7) <= din(7);
  din_2(6) <= din(6);
  din_2(5) <= din(5);
  din_2(4) <= din(4);
  din_2(3) <= din(3);
  din_2(2) <= din(2);
  din_2(1) <= din(1);
  din_2(0) <= din(0);
  VCC_0 : VCC
    port map (
      P => NLW_VCC_P_UNCONNECTED
    );
  GND_1 : GND
    port map (
      G => NLW_GND_G_UNCONNECTED
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor000611_SW1 : LUT3_L
    generic map(
      INIT => X"69"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(0),
      LO => BU2_N6
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor000611_SW1 : LUT3_L
    generic map(
      INIT => X"69"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0),
      LO => BU2_N2
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21 : LUT4_L
    generic map(
      INIT => X"2333"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_141,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I3 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      LO => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux000312 : LUT4_L
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(6),
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(5),
      I2 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(7),
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(8),
      LO => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux000312_513
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP : RAMB16
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      INVERT_CLK_DOA_REG => FALSE,
      INVERT_CLK_DOB_REG => FALSE,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "ALL",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36,
      SRVAL_B => X"000000000"
    )
    port map (
      CASCADEINA => BU2_rd_data_count(0),
      CASCADEINB => BU2_rd_data_count(0),
      CLKA => wr_clk,
      CLKB => rd_clk,
      ENA => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      REGCEA => BU2_rd_data_count(0),
      REGCEB => BU2_rd_data_count(0),
      ENB => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRA => BU2_rd_data_count(0),
      SSRB => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      CASCADEOUTA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED,
      ADDRA(14) => BU2_rd_data_count(0),
      ADDRA(13) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(8),
      ADDRA(12) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRA(11) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRA(10) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRA(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRA(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRA(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRA(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRA(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_rd_data_count(0),
      ADDRA(2) => BU2_rd_data_count(0),
      ADDRA(1) => BU2_rd_data_count(0),
      ADDRA(0) => BU2_rd_data_count(0),
      ADDRB(14) => BU2_rd_data_count(0),
      ADDRB(13) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(8),
      ADDRB(12) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(7),
      ADDRB(11) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(6),
      ADDRB(10) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_rd_data_count(0),
      ADDRB(2) => BU2_rd_data_count(0),
      ADDRB(1) => BU2_rd_data_count(0),
      ADDRB(0) => BU2_rd_data_count(0),
      DIA(31) => BU2_rd_data_count(0),
      DIA(30) => din_2(63),
      DIA(29) => din_2(62),
      DIA(28) => din_2(61),
      DIA(27) => din_2(60),
      DIA(26) => din_2(59),
      DIA(25) => din_2(58),
      DIA(24) => din_2(57),
      DIA(23) => BU2_rd_data_count(0),
      DIA(22) => din_2(56),
      DIA(21) => din_2(55),
      DIA(20) => din_2(54),
      DIA(19) => din_2(53),
      DIA(18) => din_2(52),
      DIA(17) => din_2(51),
      DIA(16) => din_2(50),
      DIA(15) => BU2_rd_data_count(0),
      DIA(14) => din_2(49),
      DIA(13) => din_2(48),
      DIA(12) => din_2(47),
      DIA(11) => din_2(46),
      DIA(10) => din_2(45),
      DIA(9) => din_2(44),
      DIA(8) => din_2(43),
      DIA(7) => BU2_rd_data_count(0),
      DIA(6) => din_2(42),
      DIA(5) => din_2(41),
      DIA(4) => din_2(40),
      DIA(3) => din_2(39),
      DIA(2) => din_2(38),
      DIA(1) => din_2(37),
      DIA(0) => din_2(36),
      DIB(31) => BU2_rd_data_count(0),
      DIB(30) => BU2_rd_data_count(0),
      DIB(29) => BU2_rd_data_count(0),
      DIB(28) => BU2_rd_data_count(0),
      DIB(27) => BU2_rd_data_count(0),
      DIB(26) => BU2_rd_data_count(0),
      DIB(25) => BU2_rd_data_count(0),
      DIB(24) => BU2_rd_data_count(0),
      DIB(23) => BU2_rd_data_count(0),
      DIB(22) => BU2_rd_data_count(0),
      DIB(21) => BU2_rd_data_count(0),
      DIB(20) => BU2_rd_data_count(0),
      DIB(19) => BU2_rd_data_count(0),
      DIB(18) => BU2_rd_data_count(0),
      DIB(17) => BU2_rd_data_count(0),
      DIB(16) => BU2_rd_data_count(0),
      DIB(15) => BU2_rd_data_count(0),
      DIB(14) => BU2_rd_data_count(0),
      DIB(13) => BU2_rd_data_count(0),
      DIB(12) => BU2_rd_data_count(0),
      DIB(11) => BU2_rd_data_count(0),
      DIB(10) => BU2_rd_data_count(0),
      DIB(9) => BU2_rd_data_count(0),
      DIB(8) => BU2_rd_data_count(0),
      DIB(7) => BU2_rd_data_count(0),
      DIB(6) => BU2_rd_data_count(0),
      DIB(5) => BU2_rd_data_count(0),
      DIB(4) => BU2_rd_data_count(0),
      DIB(3) => BU2_rd_data_count(0),
      DIB(2) => BU2_rd_data_count(0),
      DIB(1) => BU2_rd_data_count(0),
      DIB(0) => BU2_rd_data_count(0),
      DIPA(3) => BU2_rd_data_count(0),
      DIPA(2) => BU2_rd_data_count(0),
      DIPA(1) => BU2_rd_data_count(0),
      DIPA(0) => BU2_rd_data_count(0),
      DIPB(3) => BU2_rd_data_count(0),
      DIPB(2) => BU2_rd_data_count(0),
      DIPB(1) => BU2_rd_data_count(0),
      DIPB(0) => BU2_rd_data_count(0),
      WEA(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEA(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEA(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEA(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEB(3) => BU2_rd_data_count(0),
      WEB(2) => BU2_rd_data_count(0),
      WEB(1) => BU2_rd_data_count(0),
      WEB(0) => BU2_rd_data_count(0),
      DOA(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED,
      DOB(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_31_UNCONNECTED,
      DOB(30) => BU2_U0_grf_rf_mem_dout_mem(63),
      DOB(29) => BU2_U0_grf_rf_mem_dout_mem(62),
      DOB(28) => BU2_U0_grf_rf_mem_dout_mem(61),
      DOB(27) => BU2_U0_grf_rf_mem_dout_mem(60),
      DOB(26) => BU2_U0_grf_rf_mem_dout_mem(59),
      DOB(25) => BU2_U0_grf_rf_mem_dout_mem(58),
      DOB(24) => BU2_U0_grf_rf_mem_dout_mem(57),
      DOB(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_23_UNCONNECTED,
      DOB(22) => BU2_U0_grf_rf_mem_dout_mem(56),
      DOB(21) => BU2_U0_grf_rf_mem_dout_mem(55),
      DOB(20) => BU2_U0_grf_rf_mem_dout_mem(54),
      DOB(19) => BU2_U0_grf_rf_mem_dout_mem(53),
      DOB(18) => BU2_U0_grf_rf_mem_dout_mem(52),
      DOB(17) => BU2_U0_grf_rf_mem_dout_mem(51),
      DOB(16) => BU2_U0_grf_rf_mem_dout_mem(50),
      DOB(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_15_UNCONNECTED,
      DOB(14) => BU2_U0_grf_rf_mem_dout_mem(49),
      DOB(13) => BU2_U0_grf_rf_mem_dout_mem(48),
      DOB(12) => BU2_U0_grf_rf_mem_dout_mem(47),
      DOB(11) => BU2_U0_grf_rf_mem_dout_mem(46),
      DOB(10) => BU2_U0_grf_rf_mem_dout_mem(45),
      DOB(9) => BU2_U0_grf_rf_mem_dout_mem(44),
      DOB(8) => BU2_U0_grf_rf_mem_dout_mem(43),
      DOB(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOB_7_UNCONNECTED,
      DOB(6) => BU2_U0_grf_rf_mem_dout_mem(42),
      DOB(5) => BU2_U0_grf_rf_mem_dout_mem(41),
      DOB(4) => BU2_U0_grf_rf_mem_dout_mem(40),
      DOB(3) => BU2_U0_grf_rf_mem_dout_mem(39),
      DOB(2) => BU2_U0_grf_rf_mem_dout_mem(38),
      DOB(1) => BU2_U0_grf_rf_mem_dout_mem(37),
      DOB(0) => BU2_U0_grf_rf_mem_dout_mem(36),
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED,
      DOPB(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_3_UNCONNECTED,
      DOPB(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_2_UNCONNECTED,
      DOPB(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_1_UNCONNECTED,
      DOPB(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPB_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP : RAMB16
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      SRVAL_A => X"000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_FILE => "NONE",
      INVERT_CLK_DOA_REG => FALSE,
      INVERT_CLK_DOB_REG => FALSE,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "ALL",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36,
      SRVAL_B => X"000000000"
    )
    port map (
      CASCADEINA => BU2_rd_data_count(0),
      CASCADEINB => BU2_rd_data_count(0),
      CLKA => wr_clk,
      CLKB => rd_clk,
      ENA => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      REGCEA => BU2_rd_data_count(0),
      REGCEB => BU2_rd_data_count(0),
      ENB => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRA => BU2_rd_data_count(0),
      SSRB => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      CASCADEOUTA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED,
      ADDRA(14) => BU2_rd_data_count(0),
      ADDRA(13) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(8),
      ADDRA(12) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      ADDRA(11) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      ADDRA(10) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      ADDRA(9) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      ADDRA(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      ADDRA(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      ADDRA(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      ADDRA(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_rd_data_count(0),
      ADDRA(2) => BU2_rd_data_count(0),
      ADDRA(1) => BU2_rd_data_count(0),
      ADDRA(0) => BU2_rd_data_count(0),
      ADDRB(14) => BU2_rd_data_count(0),
      ADDRB(13) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(8),
      ADDRB(12) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(7),
      ADDRB(11) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(6),
      ADDRB(10) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      ADDRB(9) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      ADDRB(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_rd_data_count(0),
      ADDRB(2) => BU2_rd_data_count(0),
      ADDRB(1) => BU2_rd_data_count(0),
      ADDRB(0) => BU2_rd_data_count(0),
      DIA(31) => din_2(34),
      DIA(30) => din_2(33),
      DIA(29) => din_2(32),
      DIA(28) => din_2(31),
      DIA(27) => din_2(30),
      DIA(26) => din_2(29),
      DIA(25) => din_2(28),
      DIA(24) => din_2(27),
      DIA(23) => din_2(25),
      DIA(22) => din_2(24),
      DIA(21) => din_2(23),
      DIA(20) => din_2(22),
      DIA(19) => din_2(21),
      DIA(18) => din_2(20),
      DIA(17) => din_2(19),
      DIA(16) => din_2(18),
      DIA(15) => din_2(16),
      DIA(14) => din_2(15),
      DIA(13) => din_2(14),
      DIA(12) => din_2(13),
      DIA(11) => din_2(12),
      DIA(10) => din_2(11),
      DIA(9) => din_2(10),
      DIA(8) => din_2(9),
      DIA(7) => din_2(7),
      DIA(6) => din_2(6),
      DIA(5) => din_2(5),
      DIA(4) => din_2(4),
      DIA(3) => din_2(3),
      DIA(2) => din_2(2),
      DIA(1) => din_2(1),
      DIA(0) => din_2(0),
      DIB(31) => BU2_rd_data_count(0),
      DIB(30) => BU2_rd_data_count(0),
      DIB(29) => BU2_rd_data_count(0),
      DIB(28) => BU2_rd_data_count(0),
      DIB(27) => BU2_rd_data_count(0),
      DIB(26) => BU2_rd_data_count(0),
      DIB(25) => BU2_rd_data_count(0),
      DIB(24) => BU2_rd_data_count(0),
      DIB(23) => BU2_rd_data_count(0),
      DIB(22) => BU2_rd_data_count(0),
      DIB(21) => BU2_rd_data_count(0),
      DIB(20) => BU2_rd_data_count(0),
      DIB(19) => BU2_rd_data_count(0),
      DIB(18) => BU2_rd_data_count(0),
      DIB(17) => BU2_rd_data_count(0),
      DIB(16) => BU2_rd_data_count(0),
      DIB(15) => BU2_rd_data_count(0),
      DIB(14) => BU2_rd_data_count(0),
      DIB(13) => BU2_rd_data_count(0),
      DIB(12) => BU2_rd_data_count(0),
      DIB(11) => BU2_rd_data_count(0),
      DIB(10) => BU2_rd_data_count(0),
      DIB(9) => BU2_rd_data_count(0),
      DIB(8) => BU2_rd_data_count(0),
      DIB(7) => BU2_rd_data_count(0),
      DIB(6) => BU2_rd_data_count(0),
      DIB(5) => BU2_rd_data_count(0),
      DIB(4) => BU2_rd_data_count(0),
      DIB(3) => BU2_rd_data_count(0),
      DIB(2) => BU2_rd_data_count(0),
      DIB(1) => BU2_rd_data_count(0),
      DIB(0) => BU2_rd_data_count(0),
      DIPA(3) => din_2(35),
      DIPA(2) => din_2(26),
      DIPA(1) => din_2(17),
      DIPA(0) => din_2(8),
      DIPB(3) => BU2_rd_data_count(0),
      DIPB(2) => BU2_rd_data_count(0),
      DIPB(1) => BU2_rd_data_count(0),
      DIPB(0) => BU2_rd_data_count(0),
      WEA(3) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEA(2) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEA(1) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEA(0) => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      WEB(3) => BU2_rd_data_count(0),
      WEB(2) => BU2_rd_data_count(0),
      WEB(1) => BU2_rd_data_count(0),
      WEB(0) => BU2_rd_data_count(0),
      DOA(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED,
      DOB(31) => BU2_U0_grf_rf_mem_dout_mem(34),
      DOB(30) => BU2_U0_grf_rf_mem_dout_mem(33),
      DOB(29) => BU2_U0_grf_rf_mem_dout_mem(32),
      DOB(28) => BU2_U0_grf_rf_mem_dout_mem(31),
      DOB(27) => BU2_U0_grf_rf_mem_dout_mem(30),
      DOB(26) => BU2_U0_grf_rf_mem_dout_mem(29),
      DOB(25) => BU2_U0_grf_rf_mem_dout_mem(28),
      DOB(24) => BU2_U0_grf_rf_mem_dout_mem(27),
      DOB(23) => BU2_U0_grf_rf_mem_dout_mem(25),
      DOB(22) => BU2_U0_grf_rf_mem_dout_mem(24),
      DOB(21) => BU2_U0_grf_rf_mem_dout_mem(23),
      DOB(20) => BU2_U0_grf_rf_mem_dout_mem(22),
      DOB(19) => BU2_U0_grf_rf_mem_dout_mem(21),
      DOB(18) => BU2_U0_grf_rf_mem_dout_mem(20),
      DOB(17) => BU2_U0_grf_rf_mem_dout_mem(19),
      DOB(16) => BU2_U0_grf_rf_mem_dout_mem(18),
      DOB(15) => BU2_U0_grf_rf_mem_dout_mem(16),
      DOB(14) => BU2_U0_grf_rf_mem_dout_mem(15),
      DOB(13) => BU2_U0_grf_rf_mem_dout_mem(14),
      DOB(12) => BU2_U0_grf_rf_mem_dout_mem(13),
      DOB(11) => BU2_U0_grf_rf_mem_dout_mem(12),
      DOB(10) => BU2_U0_grf_rf_mem_dout_mem(11),
      DOB(9) => BU2_U0_grf_rf_mem_dout_mem(10),
      DOB(8) => BU2_U0_grf_rf_mem_dout_mem(9),
      DOB(7) => BU2_U0_grf_rf_mem_dout_mem(7),
      DOB(6) => BU2_U0_grf_rf_mem_dout_mem(6),
      DOB(5) => BU2_U0_grf_rf_mem_dout_mem(5),
      DOB(4) => BU2_U0_grf_rf_mem_dout_mem(4),
      DOB(3) => BU2_U0_grf_rf_mem_dout_mem(3),
      DOB(2) => BU2_U0_grf_rf_mem_dout_mem(2),
      DOB(1) => BU2_U0_grf_rf_mem_dout_mem(1),
      DOB(0) => BU2_U0_grf_rf_mem_dout_mem(0),
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_noinit_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED,
      DOPB(3) => BU2_U0_grf_rf_mem_dout_mem(35),
      DOPB(2) => BU2_U0_grf_rf_mem_dout_mem(26),
      DOPB(1) => BU2_U0_grf_rf_mem_dout_mem(17),
      DOPB(0) => BU2_U0_grf_rf_mem_dout_mem(8)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_1 : LUT4
    generic map(
      INIT => X"2333"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_141,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I3 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262
    );
  BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_144,
      O => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux000314 : LUT4
    generic map(
      INIT => X"C080"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(3),
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux000312_513,
      I2 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux00033_505,
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux0003
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_9_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(8),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(8),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(9)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00071 : LUT4
    generic map(
      INIT => X"9669"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I3 => BU2_N6,
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0007
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00062 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I3 => BU2_N4,
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0006
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor000611_SW0 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1),
      O => BU2_N4
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00071 : LUT4
    generic map(
      INIT => X"9669"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I3 => BU2_N2,
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0007
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00062 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I3 => BU2_N01,
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0006
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor000611_SW0 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1),
      O => BU2_N01
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_8_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(7),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(8)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_7_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(7)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_6_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(6)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_5_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_4_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_3_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_2_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut_1_Q : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(8),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_8_rt_416
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(8),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_8_rt_282
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_431
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_430
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_428
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_426
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_424
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_422
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(6),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_420
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(7),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_7_rt_418
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_0_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_0_rt_297
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_1_rt_296
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_2_rt_294
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_3_rt_292
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_4_rt_290
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(5),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_5_rt_288
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(6),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_6_rt_286
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(7),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_7_rt_284
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1_0_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(0)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1_0_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1_0_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1_0_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or00001 : LUT4
    generic map(
      INIT => X"FF20"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_144,
      I2 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_comp2,
      I3 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_comp1,
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or00001 : LUT3
    generic map(
      INIT => X"F8"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      I1 => BU2_U0_grf_rf_gl0_rd_gras_rsts_comp1,
      I2 => BU2_U0_grf_rf_gl0_rd_gras_rsts_comp0,
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000
    );
  BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1 : LUT2
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => wr_en,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_144,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001
    );
  BU2_U0_grf_rf_mem_tmp_ram_rd_en1 : LUT3
    generic map(
      INIT => X"DC"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_141,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      O => BU2_U0_grf_rf_mem_tmp_ram_rd_en
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1_1_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(1)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1_1_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(1)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1_1_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(1)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1_1_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(1)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1_2_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(2)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1_2_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(5),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1_2_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1_2_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(2)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1_3_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(7),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(7),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(6),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(6),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(3)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1_3_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(7),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(7),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(6),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(6),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1_3_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(7),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(6),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1_3_and00001 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(7),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(6),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(3)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1_4_not00001 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(8),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(8),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(4)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1_4_not00001 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(8),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(8),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1_4_not00001 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(8),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(8),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1_4_not00001 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(8),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(8),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00051 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0005
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00051 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0005
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00041 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00041 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00032 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00032 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_REGOUT_EN11 : LUT3
    generic map(
      INIT => X"B0"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      O => BU2_U0_grf_rf_ram_regout_en
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not00011 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_353,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_144,
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not0001
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux00033 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_353,
      I1 => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(9),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux00033_505
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux00001 : LUT4
    generic map(
      INIT => X"8E8A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_308,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I3 => rd_en,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00021 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(8),
      I3 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(7),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00021 : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(8),
      I3 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001_0_1 : LUT4
    generic map(
      INIT => X"40FF"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      I3 => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_141,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00011 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(8),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(6),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00011 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(8),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      I2 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001_1_1 : LUT3
    generic map(
      INIT => X"F2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0),
      I1 => rd_en,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1),
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(1)
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(8),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(7),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(7),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(6),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(6),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0003_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0004_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0005_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0005
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0006_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0006
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_rd_pntr_gc_xor0007_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0007
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0000_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(8),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0001_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0002_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0003_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0004_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0005_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0005
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0006_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0006
    );
  BU2_U0_grf_rf_gcx_clkx_Mxor_wr_pntr_gc_xor0007_Result1 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0007
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor00001 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(7),
      I1 => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(8),
      O => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor00001 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7),
      I1 => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(8),
      O => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000
    );
  BU2_U0_grf_rf_rstblk_rd_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_146,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_149,
      O => BU2_U0_grf_rf_rstblk_rd_rst_comb
    );
  BU2_U0_grf_rf_rstblk_wr_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_148,
      I1 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_150,
      O => BU2_U0_grf_rf_rstblk_wr_rst_comb
    );
  BU2_U0_grf_rf_mem_dout_i_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(0),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(0)
    );
  BU2_U0_grf_rf_mem_dout_i_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(1),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(1)
    );
  BU2_U0_grf_rf_mem_dout_i_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(2),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(2)
    );
  BU2_U0_grf_rf_mem_dout_i_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(3),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(3)
    );
  BU2_U0_grf_rf_mem_dout_i_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(4),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(4)
    );
  BU2_U0_grf_rf_mem_dout_i_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(5),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(5)
    );
  BU2_U0_grf_rf_mem_dout_i_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(6),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(6)
    );
  BU2_U0_grf_rf_mem_dout_i_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(7),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(7)
    );
  BU2_U0_grf_rf_mem_dout_i_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(8),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(8)
    );
  BU2_U0_grf_rf_mem_dout_i_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(9),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(9)
    );
  BU2_U0_grf_rf_mem_dout_i_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(10),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(10)
    );
  BU2_U0_grf_rf_mem_dout_i_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(11),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(11)
    );
  BU2_U0_grf_rf_mem_dout_i_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(12),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(12)
    );
  BU2_U0_grf_rf_mem_dout_i_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(13),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(13)
    );
  BU2_U0_grf_rf_mem_dout_i_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(14),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(14)
    );
  BU2_U0_grf_rf_mem_dout_i_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(15),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(15)
    );
  BU2_U0_grf_rf_mem_dout_i_16 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(16),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(16)
    );
  BU2_U0_grf_rf_mem_dout_i_17 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(17),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(17)
    );
  BU2_U0_grf_rf_mem_dout_i_18 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(18),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(18)
    );
  BU2_U0_grf_rf_mem_dout_i_19 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(19),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(19)
    );
  BU2_U0_grf_rf_mem_dout_i_20 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(20),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(20)
    );
  BU2_U0_grf_rf_mem_dout_i_21 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(21),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(21)
    );
  BU2_U0_grf_rf_mem_dout_i_22 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(22),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(22)
    );
  BU2_U0_grf_rf_mem_dout_i_23 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(23),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(23)
    );
  BU2_U0_grf_rf_mem_dout_i_24 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(24),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(24)
    );
  BU2_U0_grf_rf_mem_dout_i_25 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(25),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(25)
    );
  BU2_U0_grf_rf_mem_dout_i_26 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(26),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(26)
    );
  BU2_U0_grf_rf_mem_dout_i_27 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(27),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(27)
    );
  BU2_U0_grf_rf_mem_dout_i_28 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(28),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(28)
    );
  BU2_U0_grf_rf_mem_dout_i_29 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(29),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(29)
    );
  BU2_U0_grf_rf_mem_dout_i_30 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(30),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(30)
    );
  BU2_U0_grf_rf_mem_dout_i_31 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(31),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(31)
    );
  BU2_U0_grf_rf_mem_dout_i_32 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(32),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(32)
    );
  BU2_U0_grf_rf_mem_dout_i_33 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(33),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(33)
    );
  BU2_U0_grf_rf_mem_dout_i_34 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(34),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(34)
    );
  BU2_U0_grf_rf_mem_dout_i_35 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(35),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(35)
    );
  BU2_U0_grf_rf_mem_dout_i_36 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(36),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(36)
    );
  BU2_U0_grf_rf_mem_dout_i_37 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(37),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(37)
    );
  BU2_U0_grf_rf_mem_dout_i_38 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(38),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(38)
    );
  BU2_U0_grf_rf_mem_dout_i_39 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(39),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(39)
    );
  BU2_U0_grf_rf_mem_dout_i_40 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(40),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(40)
    );
  BU2_U0_grf_rf_mem_dout_i_41 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(41),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(41)
    );
  BU2_U0_grf_rf_mem_dout_i_42 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(42),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(42)
    );
  BU2_U0_grf_rf_mem_dout_i_43 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(43),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(43)
    );
  BU2_U0_grf_rf_mem_dout_i_44 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(44),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(44)
    );
  BU2_U0_grf_rf_mem_dout_i_45 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(45),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(45)
    );
  BU2_U0_grf_rf_mem_dout_i_46 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(46),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(46)
    );
  BU2_U0_grf_rf_mem_dout_i_47 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(47),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(47)
    );
  BU2_U0_grf_rf_mem_dout_i_48 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(48),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(48)
    );
  BU2_U0_grf_rf_mem_dout_i_49 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(49),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(49)
    );
  BU2_U0_grf_rf_mem_dout_i_50 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(50),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(50)
    );
  BU2_U0_grf_rf_mem_dout_i_51 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(51),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(51)
    );
  BU2_U0_grf_rf_mem_dout_i_52 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(52),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(52)
    );
  BU2_U0_grf_rf_mem_dout_i_53 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(53),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(53)
    );
  BU2_U0_grf_rf_mem_dout_i_54 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(54),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(54)
    );
  BU2_U0_grf_rf_mem_dout_i_55 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(55),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(55)
    );
  BU2_U0_grf_rf_mem_dout_i_56 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(56),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(56)
    );
  BU2_U0_grf_rf_mem_dout_i_57 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(57),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(57)
    );
  BU2_U0_grf_rf_mem_dout_i_58 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(58),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(58)
    );
  BU2_U0_grf_rf_mem_dout_i_59 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(59),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(59)
    );
  BU2_U0_grf_rf_mem_dout_i_60 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(60),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(60)
    );
  BU2_U0_grf_rf_mem_dout_i_61 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(61),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(61)
    );
  BU2_U0_grf_rf_mem_dout_i_62 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(62),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(62)
    );
  BU2_U0_grf_rf_mem_dout_i_63 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      D => BU2_U0_grf_rf_mem_dout_mem(63),
      R => BU2_U0_grf_rf_rstblk_rd_rst_reg(0),
      Q => dout_3(63)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d2_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(8),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(8)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_431,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_0_rt_431,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_430,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(0),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_1_rt_430,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_428,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(1),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_2_rt_428,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_426,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(2),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_3_rt_426,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_424,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(3),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_4_rt_424,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(4),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_422,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(4),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_5_rt_422,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(5),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_420,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(5),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_6_rt_420,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(6),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_7_rt_418,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(6),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy_7_rt_418,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count7
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_cy(7),
      LI => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_8_rt_416,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count8
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_1 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count1,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count2,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count4,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count5,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count7,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count8,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(8)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(8),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(8)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(7),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(6),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(5),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(4),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_gmux_gm_0_gm1_m1 : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(0),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(0)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_gmux_gm_1_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(1),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(1)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_gmux_gm_2_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(2),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(2)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_gmux_gm_3_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(3),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(3)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_gmux_gm_4_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_carrynet(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c0_v1(4),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_comp0
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_gmux_gm_0_gm1_m1 : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(0),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(0)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_gmux_gm_1_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(1),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(1)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_gmux_gm_2_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(2),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(2)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_gmux_gm_3_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(3),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(3)
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_gmux_gm_4_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_carrynet(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_gras_rsts_c1_v1(4),
      O => BU2_U0_grf_rf_gl0_rd_gras_rsts_comp1
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_gmux_gm_0_gm1_m1 : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_gmux_gm_1_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(1)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_gmux_gm_2_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_gmux_gm_3_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_gmux_gm_4_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_carrynet(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c1_v1(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_comp1
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_gmux_gm_0_gm1_m1 : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_gmux_gm_1_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(1)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_gmux_gm_2_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_gmux_gm_3_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_gmux_gm_4_gms_ms : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_carrynet(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_wsts_c2_v1(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_wsts_comp2
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_not0001,
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_prog_full_i_mux0003,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => prog_full
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_wr_rst_d1_353
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(3),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(4),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(5),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(6),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(6)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(7),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(7)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(8),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(8)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_9 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(9),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad(9)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1_345,
      S => BU2_rd_data_count(0),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(0),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(1),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(1)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(1),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(2),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(2)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(2),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(2),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(3),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(3)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(3),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(3),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(4),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(4)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(4),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(4),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(5),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(4),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(5),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(5)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(5),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(5),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(6)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(5),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(6),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(6)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(6),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(6),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(7),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(7)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(6),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(7),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(7)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy_8_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(7),
      DI => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(7),
      S => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(8),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(8)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(7),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(8),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(8)
    );
  BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_xor_9_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_cy(8),
      LI => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_Madd_diff_pntr_pad_add0000_lut(9),
      O => BU2_U0_grf_rf_gl0_wr_gwas_gpf_wrpf_diff_pntr_pad_add0000(9)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(1),
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(0)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(0),
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state(1)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => empty
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_308
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_user_valid : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_mux0001(1),
      Q => valid
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(4),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(4)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(5),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(5)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(6),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(6)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(7),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(7)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(8),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(8)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_0_Q : MUXCY
    port map (
      CI => BU2_N1,
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_0_rt_297,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_0_Q : XORCY
    port map (
      CI => BU2_N1,
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_0_rt_297,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_1_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(0),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_1_rt_296,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_1_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(0),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_1_rt_296,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_2_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(1),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_2_rt_294,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_2_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(1),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_2_rt_294,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_3_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(2),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_3_rt_292,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_3_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(2),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_3_rt_292,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_4_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(3),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_4_rt_290,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(4)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_4_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(3),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_4_rt_290,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_5_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(4),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_5_rt_288,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(5)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_5_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(4),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_5_rt_288,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count5
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_6_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(5),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_6_rt_286,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(6)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_6_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(5),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_6_rt_286,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count6
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_7_Q : MUXCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(6),
      DI => BU2_rd_data_count(0),
      S => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_7_rt_284,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(7)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_7_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(6),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy_7_rt_284,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count7
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_8_Q : XORCY
    port map (
      CI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_cy(7),
      LI => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_8_rt_282,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count8
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count2,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count1,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count4,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(4)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count5,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(5)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count6,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(6)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count7,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(7)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_Mmux_RAM_RD_EN_FWFT21_262,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count8,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(8)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0007,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0006,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0005,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(7)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count_d2(8),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(8)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0007,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0006,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0005,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(5)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(6)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(8),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(8)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(0),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(1),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(2),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(5),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(5)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(6),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(6)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(7),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc(8),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(8)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(0),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(1),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(2),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(4),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(6),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(7),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(7)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc(8),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(8)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(0),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(1),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(2),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(3),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(4),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(5),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(5)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(6),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(6)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(7),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg(8),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(8)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(0),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(1),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(2),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(3),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(4),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(5),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(6),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(7),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(7)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg(8),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(8)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0007,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0006,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0005,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(4)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(5)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(6)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(7)
    );
  BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg(1),
      D => BU2_U0_grf_rf_gcx_clkx_wr_pntr_gc_asreg_d1(8),
      Q => BU2_U0_grf_rf_gcx_clkx_wr_pntr_bin(8)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0007,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(0)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0006,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(1)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0005,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(2)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0004,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(3)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0003,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(4)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0002,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(5)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0001,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(6)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_xor0000,
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(7)
    );
  BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(0),
      D => BU2_U0_grf_rf_gcx_clkx_rd_pntr_gc_asreg_d1(8),
      Q => BU2_U0_grf_rf_gcx_clkx_rd_pntr_bin(8)
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(0)
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_0 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(0)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_2 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg(2)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg : FDPE
    port map (
      C => rd_clk,
      CE => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_145,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_149
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_150,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_147
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg : FDPE
    port map (
      C => wr_clk,
      CE => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_147,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_150
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_149,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_145
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_147,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_148
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_145,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_146
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_fb_i_144
    );
  BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => wr_clk,
      D => BU2_U0_grf_rf_gl0_wr_gwas_wsts_ram_full_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => full
    );
  BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => rd_clk,
      D => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg(2),
      Q => BU2_U0_grf_rf_gl0_rd_gras_rsts_ram_empty_fb_i_141
    );
  BU2_XST_VCC : VCC
    port map (
      P => BU2_N1
    );
  BU2_XST_GND : GND
    port map (
      G => BU2_rd_data_count(0)
    );

end STRUCTURE;

-- synthesis translate_on
