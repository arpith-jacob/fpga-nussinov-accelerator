--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: J.40
--  \   \         Application: netgen
--  /   /         Filename: fifo_score.vhd
-- /___/   /\     Timestamp: Fri Mar 13 18:14:27 2009
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -w -sim -ofmt vhdl /project/mercury/jarpith/research/hardware/nussinov/modules/gjq-clustered/hdl/coregen/coregen/tmp/_cg/fifo_score.ngc /project/mercury/jarpith/research/hardware/nussinov/modules/gjq-clustered/hdl/coregen/coregen/tmp/_cg/fifo_score.vhd 
-- Device	: 4vlx100ff1148-12
-- Input file	: /project/mercury/jarpith/research/hardware/nussinov/modules/gjq-clustered/hdl/coregen/coregen/tmp/_cg/fifo_score.ngc
-- Output file	: /project/mercury/jarpith/research/hardware/nussinov/modules/gjq-clustered/hdl/coregen/coregen/tmp/_cg/fifo_score.vhd
-- # of Entities	: 1
-- Design Name	: fifo_score
-- Xilinx	: /net/syssoft/xilinx_9.2i
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Development System Reference Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synopsys translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity fifo_score is
  port (
    valid : out STD_LOGIC; 
    rd_en : in STD_LOGIC := 'X'; 
    wr_en : in STD_LOGIC := 'X'; 
    full : out STD_LOGIC; 
    empty : out STD_LOGIC; 
    clk : in STD_LOGIC := 'X'; 
    rst : in STD_LOGIC := 'X'; 
    dout : out STD_LOGIC_VECTOR ( 98 downto 0 ); 
    din : in STD_LOGIC_VECTOR ( 98 downto 0 ) 
  );
end fifo_score;

architecture STRUCTURE of fifo_score is
  signal BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map10 : STD_LOGIC; 
  signal BU2_N235 : STD_LOGIC; 
  signal BU2_N234 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or0000_map28 : STD_LOGIC; 
  signal BU2_N232 : STD_LOGIC; 
  signal BU2_N236 : STD_LOGIC; 
  signal BU2_N230 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map21 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map29 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map16 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or0000_map26 : STD_LOGIC; 
  signal BU2_U0_grf_rf_mem_tmp_ram_rd_en : STD_LOGIC; 
  signal BU2_U0_grf_rf_ram_regout_en : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_2 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_or0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_In : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_In : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count9 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count6 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count9 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_fb_i_5 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwss_wsts_wr_rst_d1_6 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_7 : STD_LOGIC; 
  signal BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_mux0000 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_comb : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_8 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_9 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_10 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_11 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_12 : STD_LOGIC; 
  signal BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_13 : STD_LOGIC; 
  signal BU2_N1 : STD_LOGIC; 
  signal NLW_VCC_P_UNCONNECTED : STD_LOGIC; 
  signal NLW_GND_G_UNCONNECTED : STD_LOGIC; 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED : STD_LOGIC;
 
  signal NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED : STD_LOGIC;
 
  signal din_14 : STD_LOGIC_VECTOR ( 98 downto 0 ); 
  signal dout_15 : STD_LOGIC_VECTOR ( 98 downto 0 ); 
  signal BU2_U0_grf_rf_mem_dout_mem : STD_LOGIC_VECTOR ( 98 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count_d1 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_wr_wpntr_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count_d1 : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_gl0_rd_rpntr_count : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal BU2_U0_grf_rf_rstblk_wr_rst_reg : STD_LOGIC_VECTOR ( 1 downto 1 ); 
  signal BU2_rd_data_count : STD_LOGIC_VECTOR ( 0 downto 0 ); 
begin
  dout(98) <= dout_15(98);
  dout(97) <= dout_15(97);
  dout(96) <= dout_15(96);
  dout(95) <= dout_15(95);
  dout(94) <= dout_15(94);
  dout(93) <= dout_15(93);
  dout(92) <= dout_15(92);
  dout(91) <= dout_15(91);
  dout(90) <= dout_15(90);
  dout(89) <= dout_15(89);
  dout(88) <= dout_15(88);
  dout(87) <= dout_15(87);
  dout(86) <= dout_15(86);
  dout(85) <= dout_15(85);
  dout(84) <= dout_15(84);
  dout(83) <= dout_15(83);
  dout(82) <= dout_15(82);
  dout(81) <= dout_15(81);
  dout(80) <= dout_15(80);
  dout(79) <= dout_15(79);
  dout(78) <= dout_15(78);
  dout(77) <= dout_15(77);
  dout(76) <= dout_15(76);
  dout(75) <= dout_15(75);
  dout(74) <= dout_15(74);
  dout(73) <= dout_15(73);
  dout(72) <= dout_15(72);
  dout(71) <= dout_15(71);
  dout(70) <= dout_15(70);
  dout(69) <= dout_15(69);
  dout(68) <= dout_15(68);
  dout(67) <= dout_15(67);
  dout(66) <= dout_15(66);
  dout(65) <= dout_15(65);
  dout(64) <= dout_15(64);
  dout(63) <= dout_15(63);
  dout(62) <= dout_15(62);
  dout(61) <= dout_15(61);
  dout(60) <= dout_15(60);
  dout(59) <= dout_15(59);
  dout(58) <= dout_15(58);
  dout(57) <= dout_15(57);
  dout(56) <= dout_15(56);
  dout(55) <= dout_15(55);
  dout(54) <= dout_15(54);
  dout(53) <= dout_15(53);
  dout(52) <= dout_15(52);
  dout(51) <= dout_15(51);
  dout(50) <= dout_15(50);
  dout(49) <= dout_15(49);
  dout(48) <= dout_15(48);
  dout(47) <= dout_15(47);
  dout(46) <= dout_15(46);
  dout(45) <= dout_15(45);
  dout(44) <= dout_15(44);
  dout(43) <= dout_15(43);
  dout(42) <= dout_15(42);
  dout(41) <= dout_15(41);
  dout(40) <= dout_15(40);
  dout(39) <= dout_15(39);
  dout(38) <= dout_15(38);
  dout(37) <= dout_15(37);
  dout(36) <= dout_15(36);
  dout(35) <= dout_15(35);
  dout(34) <= dout_15(34);
  dout(33) <= dout_15(33);
  dout(32) <= dout_15(32);
  dout(31) <= dout_15(31);
  dout(30) <= dout_15(30);
  dout(29) <= dout_15(29);
  dout(28) <= dout_15(28);
  dout(27) <= dout_15(27);
  dout(26) <= dout_15(26);
  dout(25) <= dout_15(25);
  dout(24) <= dout_15(24);
  dout(23) <= dout_15(23);
  dout(22) <= dout_15(22);
  dout(21) <= dout_15(21);
  dout(20) <= dout_15(20);
  dout(19) <= dout_15(19);
  dout(18) <= dout_15(18);
  dout(17) <= dout_15(17);
  dout(16) <= dout_15(16);
  dout(15) <= dout_15(15);
  dout(14) <= dout_15(14);
  dout(13) <= dout_15(13);
  dout(12) <= dout_15(12);
  dout(11) <= dout_15(11);
  dout(10) <= dout_15(10);
  dout(9) <= dout_15(9);
  dout(8) <= dout_15(8);
  dout(7) <= dout_15(7);
  dout(6) <= dout_15(6);
  dout(5) <= dout_15(5);
  dout(4) <= dout_15(4);
  dout(3) <= dout_15(3);
  dout(2) <= dout_15(2);
  dout(1) <= dout_15(1);
  dout(0) <= dout_15(0);
  din_14(98) <= din(98);
  din_14(97) <= din(97);
  din_14(96) <= din(96);
  din_14(95) <= din(95);
  din_14(94) <= din(94);
  din_14(93) <= din(93);
  din_14(92) <= din(92);
  din_14(91) <= din(91);
  din_14(90) <= din(90);
  din_14(89) <= din(89);
  din_14(88) <= din(88);
  din_14(87) <= din(87);
  din_14(86) <= din(86);
  din_14(85) <= din(85);
  din_14(84) <= din(84);
  din_14(83) <= din(83);
  din_14(82) <= din(82);
  din_14(81) <= din(81);
  din_14(80) <= din(80);
  din_14(79) <= din(79);
  din_14(78) <= din(78);
  din_14(77) <= din(77);
  din_14(76) <= din(76);
  din_14(75) <= din(75);
  din_14(74) <= din(74);
  din_14(73) <= din(73);
  din_14(72) <= din(72);
  din_14(71) <= din(71);
  din_14(70) <= din(70);
  din_14(69) <= din(69);
  din_14(68) <= din(68);
  din_14(67) <= din(67);
  din_14(66) <= din(66);
  din_14(65) <= din(65);
  din_14(64) <= din(64);
  din_14(63) <= din(63);
  din_14(62) <= din(62);
  din_14(61) <= din(61);
  din_14(60) <= din(60);
  din_14(59) <= din(59);
  din_14(58) <= din(58);
  din_14(57) <= din(57);
  din_14(56) <= din(56);
  din_14(55) <= din(55);
  din_14(54) <= din(54);
  din_14(53) <= din(53);
  din_14(52) <= din(52);
  din_14(51) <= din(51);
  din_14(50) <= din(50);
  din_14(49) <= din(49);
  din_14(48) <= din(48);
  din_14(47) <= din(47);
  din_14(46) <= din(46);
  din_14(45) <= din(45);
  din_14(44) <= din(44);
  din_14(43) <= din(43);
  din_14(42) <= din(42);
  din_14(41) <= din(41);
  din_14(40) <= din(40);
  din_14(39) <= din(39);
  din_14(38) <= din(38);
  din_14(37) <= din(37);
  din_14(36) <= din(36);
  din_14(35) <= din(35);
  din_14(34) <= din(34);
  din_14(33) <= din(33);
  din_14(32) <= din(32);
  din_14(31) <= din(31);
  din_14(30) <= din(30);
  din_14(29) <= din(29);
  din_14(28) <= din(28);
  din_14(27) <= din(27);
  din_14(26) <= din(26);
  din_14(25) <= din(25);
  din_14(24) <= din(24);
  din_14(23) <= din(23);
  din_14(22) <= din(22);
  din_14(21) <= din(21);
  din_14(20) <= din(20);
  din_14(19) <= din(19);
  din_14(18) <= din(18);
  din_14(17) <= din(17);
  din_14(16) <= din(16);
  din_14(15) <= din(15);
  din_14(14) <= din(14);
  din_14(13) <= din(13);
  din_14(12) <= din(12);
  din_14(11) <= din(11);
  din_14(10) <= din(10);
  din_14(9) <= din(9);
  din_14(8) <= din(8);
  din_14(7) <= din(7);
  din_14(6) <= din(6);
  din_14(5) <= din(5);
  din_14(4) <= din(4);
  din_14(3) <= din(3);
  din_14(2) <= din(2);
  din_14(1) <= din(1);
  din_14(0) <= din(0);
  VCC_0 : VCC
    port map (
      P => NLW_VCC_P_UNCONNECTED
    );
  GND_1 : GND
    port map (
      G => NLW_GND_G_UNCONNECTED
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000077 : LUT4_L
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or0000_map26,
      I1 => BU2_N230,
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      LO => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or0000_map28
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or00003132 : LUT4_D
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      LO => BU2_N236,
      O => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map10
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP : RAMB16
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
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
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INVERT_CLK_DOA_REG => FALSE,
      INVERT_CLK_DOB_REG => FALSE,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "NONE",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36,
      SRVAL_B => X"000000000"
    )
    port map (
      CASCADEINA => BU2_rd_data_count(0),
      CASCADEINB => BU2_rd_data_count(0),
      CLKA => clk,
      CLKB => clk,
      ENA => BU2_N1,
      REGCEA => BU2_rd_data_count(0),
      REGCEB => BU2_rd_data_count(0),
      ENB => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRA => BU2_rd_data_count(0),
      SSRB => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      CASCADEOUTA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED,
      ADDRA(14) => BU2_rd_data_count(0),
      ADDRA(13) => BU2_rd_data_count(0),
      ADDRA(12) => BU2_rd_data_count(0),
      ADDRA(11) => BU2_rd_data_count(0),
      ADDRA(10) => BU2_rd_data_count(0),
      ADDRA(9) => BU2_rd_data_count(0),
      ADDRA(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      ADDRA(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      ADDRA(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      ADDRA(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_rd_data_count(0),
      ADDRA(2) => BU2_rd_data_count(0),
      ADDRA(1) => BU2_rd_data_count(0),
      ADDRA(0) => BU2_rd_data_count(0),
      ADDRB(14) => BU2_rd_data_count(0),
      ADDRB(13) => BU2_rd_data_count(0),
      ADDRB(12) => BU2_rd_data_count(0),
      ADDRB(11) => BU2_rd_data_count(0),
      ADDRB(10) => BU2_rd_data_count(0),
      ADDRB(9) => BU2_rd_data_count(0),
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
      DIA(30) => BU2_rd_data_count(0),
      DIA(29) => din_14(98),
      DIA(28) => din_14(97),
      DIA(27) => din_14(96),
      DIA(26) => din_14(95),
      DIA(25) => din_14(94),
      DIA(24) => din_14(93),
      DIA(23) => BU2_rd_data_count(0),
      DIA(22) => din_14(92),
      DIA(21) => din_14(91),
      DIA(20) => din_14(90),
      DIA(19) => din_14(89),
      DIA(18) => din_14(88),
      DIA(17) => din_14(87),
      DIA(16) => din_14(86),
      DIA(15) => BU2_rd_data_count(0),
      DIA(14) => din_14(85),
      DIA(13) => din_14(84),
      DIA(12) => din_14(83),
      DIA(11) => din_14(82),
      DIA(10) => din_14(81),
      DIA(9) => din_14(80),
      DIA(8) => din_14(79),
      DIA(7) => BU2_rd_data_count(0),
      DIA(6) => din_14(78),
      DIA(5) => din_14(77),
      DIA(4) => din_14(76),
      DIA(3) => din_14(75),
      DIA(2) => din_14(74),
      DIA(1) => din_14(73),
      DIA(0) => din_14(72),
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
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED,
      DOB(31) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_31_UNCONNECTED,
      DOB(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_30_UNCONNECTED,
      DOB(29) => BU2_U0_grf_rf_mem_dout_mem(98),
      DOB(28) => BU2_U0_grf_rf_mem_dout_mem(97),
      DOB(27) => BU2_U0_grf_rf_mem_dout_mem(96),
      DOB(26) => BU2_U0_grf_rf_mem_dout_mem(95),
      DOB(25) => BU2_U0_grf_rf_mem_dout_mem(94),
      DOB(24) => BU2_U0_grf_rf_mem_dout_mem(93),
      DOB(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_23_UNCONNECTED,
      DOB(22) => BU2_U0_grf_rf_mem_dout_mem(92),
      DOB(21) => BU2_U0_grf_rf_mem_dout_mem(91),
      DOB(20) => BU2_U0_grf_rf_mem_dout_mem(90),
      DOB(19) => BU2_U0_grf_rf_mem_dout_mem(89),
      DOB(18) => BU2_U0_grf_rf_mem_dout_mem(88),
      DOB(17) => BU2_U0_grf_rf_mem_dout_mem(87),
      DOB(16) => BU2_U0_grf_rf_mem_dout_mem(86),
      DOB(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_15_UNCONNECTED,
      DOB(14) => BU2_U0_grf_rf_mem_dout_mem(85),
      DOB(13) => BU2_U0_grf_rf_mem_dout_mem(84),
      DOB(12) => BU2_U0_grf_rf_mem_dout_mem(83),
      DOB(11) => BU2_U0_grf_rf_mem_dout_mem(82),
      DOB(10) => BU2_U0_grf_rf_mem_dout_mem(81),
      DOB(9) => BU2_U0_grf_rf_mem_dout_mem(80),
      DOB(8) => BU2_U0_grf_rf_mem_dout_mem(79),
      DOB(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOB_7_UNCONNECTED,
      DOB(6) => BU2_U0_grf_rf_mem_dout_mem(78),
      DOB(5) => BU2_U0_grf_rf_mem_dout_mem(77),
      DOB(4) => BU2_U0_grf_rf_mem_dout_mem(76),
      DOB(3) => BU2_U0_grf_rf_mem_dout_mem(75),
      DOB(2) => BU2_U0_grf_rf_mem_dout_mem(74),
      DOB(1) => BU2_U0_grf_rf_mem_dout_mem(73),
      DOB(0) => BU2_U0_grf_rf_mem_dout_mem(72),
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED,
      DOPB(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_3_UNCONNECTED,
      DOPB(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_2_UNCONNECTED,
      DOPB(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_1_UNCONNECTED,
      DOPB(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_2_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPB_0_UNCONNECTED
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP : RAMB16
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
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
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INVERT_CLK_DOA_REG => FALSE,
      INVERT_CLK_DOB_REG => FALSE,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "NONE",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36,
      SRVAL_B => X"000000000"
    )
    port map (
      CASCADEINA => BU2_rd_data_count(0),
      CASCADEINB => BU2_rd_data_count(0),
      CLKA => clk,
      CLKB => clk,
      ENA => BU2_N1,
      REGCEA => BU2_rd_data_count(0),
      REGCEB => BU2_rd_data_count(0),
      ENB => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRA => BU2_rd_data_count(0),
      SSRB => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      CASCADEOUTA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED,
      ADDRA(14) => BU2_rd_data_count(0),
      ADDRA(13) => BU2_rd_data_count(0),
      ADDRA(12) => BU2_rd_data_count(0),
      ADDRA(11) => BU2_rd_data_count(0),
      ADDRA(10) => BU2_rd_data_count(0),
      ADDRA(9) => BU2_rd_data_count(0),
      ADDRA(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      ADDRA(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      ADDRA(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      ADDRA(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_rd_data_count(0),
      ADDRA(2) => BU2_rd_data_count(0),
      ADDRA(1) => BU2_rd_data_count(0),
      ADDRA(0) => BU2_rd_data_count(0),
      ADDRB(14) => BU2_rd_data_count(0),
      ADDRB(13) => BU2_rd_data_count(0),
      ADDRB(12) => BU2_rd_data_count(0),
      ADDRB(11) => BU2_rd_data_count(0),
      ADDRB(10) => BU2_rd_data_count(0),
      ADDRB(9) => BU2_rd_data_count(0),
      ADDRB(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_rd_data_count(0),
      ADDRB(2) => BU2_rd_data_count(0),
      ADDRB(1) => BU2_rd_data_count(0),
      ADDRB(0) => BU2_rd_data_count(0),
      DIA(31) => din_14(70),
      DIA(30) => din_14(69),
      DIA(29) => din_14(68),
      DIA(28) => din_14(67),
      DIA(27) => din_14(66),
      DIA(26) => din_14(65),
      DIA(25) => din_14(64),
      DIA(24) => din_14(63),
      DIA(23) => din_14(61),
      DIA(22) => din_14(60),
      DIA(21) => din_14(59),
      DIA(20) => din_14(58),
      DIA(19) => din_14(57),
      DIA(18) => din_14(56),
      DIA(17) => din_14(55),
      DIA(16) => din_14(54),
      DIA(15) => din_14(52),
      DIA(14) => din_14(51),
      DIA(13) => din_14(50),
      DIA(12) => din_14(49),
      DIA(11) => din_14(48),
      DIA(10) => din_14(47),
      DIA(9) => din_14(46),
      DIA(8) => din_14(45),
      DIA(7) => din_14(43),
      DIA(6) => din_14(42),
      DIA(5) => din_14(41),
      DIA(4) => din_14(40),
      DIA(3) => din_14(39),
      DIA(2) => din_14(38),
      DIA(1) => din_14(37),
      DIA(0) => din_14(36),
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
      DIPA(3) => din_14(71),
      DIPA(2) => din_14(62),
      DIPA(1) => din_14(53),
      DIPA(0) => din_14(44),
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
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED,
      DOB(31) => BU2_U0_grf_rf_mem_dout_mem(70),
      DOB(30) => BU2_U0_grf_rf_mem_dout_mem(69),
      DOB(29) => BU2_U0_grf_rf_mem_dout_mem(68),
      DOB(28) => BU2_U0_grf_rf_mem_dout_mem(67),
      DOB(27) => BU2_U0_grf_rf_mem_dout_mem(66),
      DOB(26) => BU2_U0_grf_rf_mem_dout_mem(65),
      DOB(25) => BU2_U0_grf_rf_mem_dout_mem(64),
      DOB(24) => BU2_U0_grf_rf_mem_dout_mem(63),
      DOB(23) => BU2_U0_grf_rf_mem_dout_mem(61),
      DOB(22) => BU2_U0_grf_rf_mem_dout_mem(60),
      DOB(21) => BU2_U0_grf_rf_mem_dout_mem(59),
      DOB(20) => BU2_U0_grf_rf_mem_dout_mem(58),
      DOB(19) => BU2_U0_grf_rf_mem_dout_mem(57),
      DOB(18) => BU2_U0_grf_rf_mem_dout_mem(56),
      DOB(17) => BU2_U0_grf_rf_mem_dout_mem(55),
      DOB(16) => BU2_U0_grf_rf_mem_dout_mem(54),
      DOB(15) => BU2_U0_grf_rf_mem_dout_mem(52),
      DOB(14) => BU2_U0_grf_rf_mem_dout_mem(51),
      DOB(13) => BU2_U0_grf_rf_mem_dout_mem(50),
      DOB(12) => BU2_U0_grf_rf_mem_dout_mem(49),
      DOB(11) => BU2_U0_grf_rf_mem_dout_mem(48),
      DOB(10) => BU2_U0_grf_rf_mem_dout_mem(47),
      DOB(9) => BU2_U0_grf_rf_mem_dout_mem(46),
      DOB(8) => BU2_U0_grf_rf_mem_dout_mem(45),
      DOB(7) => BU2_U0_grf_rf_mem_dout_mem(43),
      DOB(6) => BU2_U0_grf_rf_mem_dout_mem(42),
      DOB(5) => BU2_U0_grf_rf_mem_dout_mem(41),
      DOB(4) => BU2_U0_grf_rf_mem_dout_mem(40),
      DOB(3) => BU2_U0_grf_rf_mem_dout_mem(39),
      DOB(2) => BU2_U0_grf_rf_mem_dout_mem(38),
      DOB(1) => BU2_U0_grf_rf_mem_dout_mem(37),
      DOB(0) => BU2_U0_grf_rf_mem_dout_mem(36),
      DOPA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_1_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED,
      DOPB(3) => BU2_U0_grf_rf_mem_dout_mem(71),
      DOPB(2) => BU2_U0_grf_rf_mem_dout_mem(62),
      DOPB(1) => BU2_U0_grf_rf_mem_dout_mem(53),
      DOPB(0) => BU2_U0_grf_rf_mem_dout_mem(44)
    );
  BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP : RAMB16
    generic map(
      DOA_REG => 0,
      DOB_REG => 0,
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
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INVERT_CLK_DOA_REG => FALSE,
      INVERT_CLK_DOB_REG => FALSE,
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 36,
      SIM_COLLISION_CHECK => "NONE",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      WRITE_WIDTH_A => 36,
      WRITE_WIDTH_B => 36,
      SRVAL_B => X"000000000"
    )
    port map (
      CASCADEINA => BU2_rd_data_count(0),
      CASCADEINB => BU2_rd_data_count(0),
      CLKA => clk,
      CLKB => clk,
      ENA => BU2_N1,
      REGCEA => BU2_rd_data_count(0),
      REGCEB => BU2_rd_data_count(0),
      ENB => BU2_U0_grf_rf_mem_tmp_ram_rd_en,
      SSRA => BU2_rd_data_count(0),
      SSRB => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      CASCADEOUTA => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTA_UNCONNECTED,
      CASCADEOUTB => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_CASCADEOUTB_UNCONNECTED,
      ADDRA(14) => BU2_rd_data_count(0),
      ADDRA(13) => BU2_rd_data_count(0),
      ADDRA(12) => BU2_rd_data_count(0),
      ADDRA(11) => BU2_rd_data_count(0),
      ADDRA(10) => BU2_rd_data_count(0),
      ADDRA(9) => BU2_rd_data_count(0),
      ADDRA(8) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      ADDRA(7) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      ADDRA(6) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      ADDRA(5) => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      ADDRA(4) => BU2_rd_data_count(0),
      ADDRA(3) => BU2_rd_data_count(0),
      ADDRA(2) => BU2_rd_data_count(0),
      ADDRA(1) => BU2_rd_data_count(0),
      ADDRA(0) => BU2_rd_data_count(0),
      ADDRB(14) => BU2_rd_data_count(0),
      ADDRB(13) => BU2_rd_data_count(0),
      ADDRB(12) => BU2_rd_data_count(0),
      ADDRB(11) => BU2_rd_data_count(0),
      ADDRB(10) => BU2_rd_data_count(0),
      ADDRB(9) => BU2_rd_data_count(0),
      ADDRB(8) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      ADDRB(7) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      ADDRB(6) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      ADDRB(5) => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      ADDRB(4) => BU2_rd_data_count(0),
      ADDRB(3) => BU2_rd_data_count(0),
      ADDRB(2) => BU2_rd_data_count(0),
      ADDRB(1) => BU2_rd_data_count(0),
      ADDRB(0) => BU2_rd_data_count(0),
      DIA(31) => din_14(34),
      DIA(30) => din_14(33),
      DIA(29) => din_14(32),
      DIA(28) => din_14(31),
      DIA(27) => din_14(30),
      DIA(26) => din_14(29),
      DIA(25) => din_14(28),
      DIA(24) => din_14(27),
      DIA(23) => din_14(25),
      DIA(22) => din_14(24),
      DIA(21) => din_14(23),
      DIA(20) => din_14(22),
      DIA(19) => din_14(21),
      DIA(18) => din_14(20),
      DIA(17) => din_14(19),
      DIA(16) => din_14(18),
      DIA(15) => din_14(16),
      DIA(14) => din_14(15),
      DIA(13) => din_14(14),
      DIA(12) => din_14(13),
      DIA(11) => din_14(12),
      DIA(10) => din_14(11),
      DIA(9) => din_14(10),
      DIA(8) => din_14(9),
      DIA(7) => din_14(7),
      DIA(6) => din_14(6),
      DIA(5) => din_14(5),
      DIA(4) => din_14(4),
      DIA(3) => din_14(3),
      DIA(2) => din_14(2),
      DIA(1) => din_14(1),
      DIA(0) => din_14(0),
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
      DIPA(3) => din_14(35),
      DIPA(2) => din_14(26),
      DIPA(1) => din_14(17),
      DIPA(0) => din_14(8),
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
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_31_UNCONNECTED,
      DOA(30) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_30_UNCONNECTED,
      DOA(29) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_29_UNCONNECTED,
      DOA(28) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_28_UNCONNECTED,
      DOA(27) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_27_UNCONNECTED,
      DOA(26) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_26_UNCONNECTED,
      DOA(25) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_25_UNCONNECTED,
      DOA(24) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_24_UNCONNECTED,
      DOA(23) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_23_UNCONNECTED,
      DOA(22) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_22_UNCONNECTED,
      DOA(21) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_21_UNCONNECTED,
      DOA(20) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_20_UNCONNECTED,
      DOA(19) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_19_UNCONNECTED,
      DOA(18) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_18_UNCONNECTED,
      DOA(17) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_17_UNCONNECTED,
      DOA(16) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_16_UNCONNECTED,
      DOA(15) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_15_UNCONNECTED,
      DOA(14) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_14_UNCONNECTED,
      DOA(13) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_13_UNCONNECTED,
      DOA(12) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_12_UNCONNECTED,
      DOA(11) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_11_UNCONNECTED,
      DOA(10) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_10_UNCONNECTED,
      DOA(9) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_9_UNCONNECTED,
      DOA(8) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_8_UNCONNECTED,
      DOA(7) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_7_UNCONNECTED,
      DOA(6) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_6_UNCONNECTED,
      DOA(5) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_5_UNCONNECTED,
      DOA(4) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_4_UNCONNECTED,
      DOA(3) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_3_UNCONNECTED,
      DOA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_2_UNCONNECTED,
      DOA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_1_UNCONNECTED,
      DOA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOA_0_UNCONNECTED,
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
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_3_UNCONNECTED,
      DOPA(2) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_2_UNCONNECTED,
      DOPA(1) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_1_UNCONNECTED,
      DOPA(0) => 
NLW_BU2_U0_grf_rf_mem_gbm_gbmg_gbmga_ngecc_bmg_blk_mem_generator_valid_cstr_ramloop_0_ram_r_v4_ram_SDP_SINGLE_PRIM_SDP_DOPA_0_UNCONNECTED,
      DOPB(3) => BU2_U0_grf_rf_mem_dout_mem(35),
      DOPB(2) => BU2_U0_grf_rf_mem_dout_mem(26),
      DOPB(1) => BU2_U0_grf_rf_mem_dout_mem(17),
      DOPB(0) => BU2_U0_grf_rf_mem_dout_mem(8)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_0_11_INV_0 : INV
    port map (
      I => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_0_11_INV_0 : INV
    port map (
      I => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb97_G : LUT3
    generic map(
      INIT => X"A8"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map4,
      I1 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map10,
      I2 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map21,
      O => BU2_N235
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb97_F : LUT4
    generic map(
      INIT => X"FF80"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map16,
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      I2 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map29,
      I3 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map4,
      O => BU2_N234
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb97 : MUXF5
    port map (
      I0 => BU2_N234,
      I1 => BU2_N235,
      S => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      O => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000089 : LUT4
    generic map(
      INIT => X"FAF8"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_7,
      I1 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map21,
      I2 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or0000_map28,
      I3 => BU2_N232,
      O => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_mux0000
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000089_SW0 : LUT3
    generic map(
      INIT => X"FB"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_fb_i_5,
      I1 => wr_en,
      I2 => BU2_N236,
      O => BU2_N232
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000077_SW0 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_N230
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or00003159 : LUT4
    generic map(
      INIT => X"6FF6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0),
      O => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000031_map21
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb71 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1),
      O => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map29
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb41 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3),
      O => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map16
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb8 : LUT3
    generic map(
      INIT => X"A2"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_fb_i_5,
      I1 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_wr_rst_d1_6,
      I2 => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      O => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb_map4
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or000062 : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2),
      O => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_or0000_map26
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_RAM_RD_EN_FWFT1 : LUT4
    generic map(
      INIT => X"5545"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_7,
      I1 => rd_en,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4,
      I3 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3,
      O => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001
    );
  BU2_U0_grf_rf_gl0_wr_ram_wr_en_i1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_fb_i_5,
      I1 => wr_en,
      O => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001
    );
  BU2_U0_grf_rf_mem_tmp_ram_rd_en1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      O => BU2_U0_grf_rf_mem_tmp_ram_rd_en
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_RAM_REGOUT_EN1 : LUT3
    generic map(
      INIT => X"38"
    )
    port map (
      I0 => rd_en,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3,
      O => BU2_U0_grf_rf_ram_regout_en
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_In1 : LUT4
    generic map(
      INIT => X"69C1"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3,
      I2 => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_7,
      I3 => rd_en,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_In
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_3_11 : LUT4
    generic map(
      INIT => X"6CCC"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count9
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_3_11 : LUT4
    generic map(
      INIT => X"6CCC"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I3 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count9
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_or00001 : LUT4
    generic map(
      INIT => X"CA8A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_2,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4,
      I2 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3,
      I3 => rd_en,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_or0000
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_2_11 : LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I2 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count6
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_2_11 : LUT3
    generic map(
      INIT => X"6A"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I2 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_In1 : LUT3
    generic map(
      INIT => X"6E"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4,
      I1 => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3,
      I2 => rd_en,
      O => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_In
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      I1 => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      O => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count_xor_1_11 : LUT2
    generic map(
      INIT => X"6"
    )
    port map (
      I0 => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      I1 => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      O => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3
    );
  BU2_U0_grf_rf_rstblk_rd_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_12,
      I1 => BU2_U0_grf_rf_rstblk_rd_rst_asreg_9,
      O => BU2_U0_grf_rf_rstblk_rd_rst_comb
    );
  BU2_U0_grf_rf_rstblk_wr_rst_comb1 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_10,
      I1 => BU2_U0_grf_rf_rstblk_wr_rst_asreg_8,
      O => BU2_U0_grf_rf_rstblk_wr_rst_comb
    );
  BU2_U0_grf_rf_mem_dout_i_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(0),
      Q => dout_15(0)
    );
  BU2_U0_grf_rf_mem_dout_i_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(1),
      Q => dout_15(1)
    );
  BU2_U0_grf_rf_mem_dout_i_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(2),
      Q => dout_15(2)
    );
  BU2_U0_grf_rf_mem_dout_i_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(3),
      Q => dout_15(3)
    );
  BU2_U0_grf_rf_mem_dout_i_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(4),
      Q => dout_15(4)
    );
  BU2_U0_grf_rf_mem_dout_i_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(5),
      Q => dout_15(5)
    );
  BU2_U0_grf_rf_mem_dout_i_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(6),
      Q => dout_15(6)
    );
  BU2_U0_grf_rf_mem_dout_i_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(7),
      Q => dout_15(7)
    );
  BU2_U0_grf_rf_mem_dout_i_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(8),
      Q => dout_15(8)
    );
  BU2_U0_grf_rf_mem_dout_i_9 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(9),
      Q => dout_15(9)
    );
  BU2_U0_grf_rf_mem_dout_i_10 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(10),
      Q => dout_15(10)
    );
  BU2_U0_grf_rf_mem_dout_i_11 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(11),
      Q => dout_15(11)
    );
  BU2_U0_grf_rf_mem_dout_i_12 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(12),
      Q => dout_15(12)
    );
  BU2_U0_grf_rf_mem_dout_i_13 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(13),
      Q => dout_15(13)
    );
  BU2_U0_grf_rf_mem_dout_i_14 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(14),
      Q => dout_15(14)
    );
  BU2_U0_grf_rf_mem_dout_i_15 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(15),
      Q => dout_15(15)
    );
  BU2_U0_grf_rf_mem_dout_i_16 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(16),
      Q => dout_15(16)
    );
  BU2_U0_grf_rf_mem_dout_i_17 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(17),
      Q => dout_15(17)
    );
  BU2_U0_grf_rf_mem_dout_i_18 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(18),
      Q => dout_15(18)
    );
  BU2_U0_grf_rf_mem_dout_i_19 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(19),
      Q => dout_15(19)
    );
  BU2_U0_grf_rf_mem_dout_i_20 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(20),
      Q => dout_15(20)
    );
  BU2_U0_grf_rf_mem_dout_i_21 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(21),
      Q => dout_15(21)
    );
  BU2_U0_grf_rf_mem_dout_i_22 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(22),
      Q => dout_15(22)
    );
  BU2_U0_grf_rf_mem_dout_i_23 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(23),
      Q => dout_15(23)
    );
  BU2_U0_grf_rf_mem_dout_i_24 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(24),
      Q => dout_15(24)
    );
  BU2_U0_grf_rf_mem_dout_i_25 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(25),
      Q => dout_15(25)
    );
  BU2_U0_grf_rf_mem_dout_i_26 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(26),
      Q => dout_15(26)
    );
  BU2_U0_grf_rf_mem_dout_i_27 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(27),
      Q => dout_15(27)
    );
  BU2_U0_grf_rf_mem_dout_i_28 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(28),
      Q => dout_15(28)
    );
  BU2_U0_grf_rf_mem_dout_i_29 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(29),
      Q => dout_15(29)
    );
  BU2_U0_grf_rf_mem_dout_i_30 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(30),
      Q => dout_15(30)
    );
  BU2_U0_grf_rf_mem_dout_i_31 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(31),
      Q => dout_15(31)
    );
  BU2_U0_grf_rf_mem_dout_i_32 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(32),
      Q => dout_15(32)
    );
  BU2_U0_grf_rf_mem_dout_i_33 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(33),
      Q => dout_15(33)
    );
  BU2_U0_grf_rf_mem_dout_i_34 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(34),
      Q => dout_15(34)
    );
  BU2_U0_grf_rf_mem_dout_i_35 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(35),
      Q => dout_15(35)
    );
  BU2_U0_grf_rf_mem_dout_i_36 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(36),
      Q => dout_15(36)
    );
  BU2_U0_grf_rf_mem_dout_i_37 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(37),
      Q => dout_15(37)
    );
  BU2_U0_grf_rf_mem_dout_i_38 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(38),
      Q => dout_15(38)
    );
  BU2_U0_grf_rf_mem_dout_i_39 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(39),
      Q => dout_15(39)
    );
  BU2_U0_grf_rf_mem_dout_i_40 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(40),
      Q => dout_15(40)
    );
  BU2_U0_grf_rf_mem_dout_i_41 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(41),
      Q => dout_15(41)
    );
  BU2_U0_grf_rf_mem_dout_i_42 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(42),
      Q => dout_15(42)
    );
  BU2_U0_grf_rf_mem_dout_i_43 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(43),
      Q => dout_15(43)
    );
  BU2_U0_grf_rf_mem_dout_i_44 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(44),
      Q => dout_15(44)
    );
  BU2_U0_grf_rf_mem_dout_i_45 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(45),
      Q => dout_15(45)
    );
  BU2_U0_grf_rf_mem_dout_i_46 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(46),
      Q => dout_15(46)
    );
  BU2_U0_grf_rf_mem_dout_i_47 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(47),
      Q => dout_15(47)
    );
  BU2_U0_grf_rf_mem_dout_i_48 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(48),
      Q => dout_15(48)
    );
  BU2_U0_grf_rf_mem_dout_i_49 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(49),
      Q => dout_15(49)
    );
  BU2_U0_grf_rf_mem_dout_i_50 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(50),
      Q => dout_15(50)
    );
  BU2_U0_grf_rf_mem_dout_i_51 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(51),
      Q => dout_15(51)
    );
  BU2_U0_grf_rf_mem_dout_i_52 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(52),
      Q => dout_15(52)
    );
  BU2_U0_grf_rf_mem_dout_i_53 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(53),
      Q => dout_15(53)
    );
  BU2_U0_grf_rf_mem_dout_i_54 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(54),
      Q => dout_15(54)
    );
  BU2_U0_grf_rf_mem_dout_i_55 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(55),
      Q => dout_15(55)
    );
  BU2_U0_grf_rf_mem_dout_i_56 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(56),
      Q => dout_15(56)
    );
  BU2_U0_grf_rf_mem_dout_i_57 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(57),
      Q => dout_15(57)
    );
  BU2_U0_grf_rf_mem_dout_i_58 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(58),
      Q => dout_15(58)
    );
  BU2_U0_grf_rf_mem_dout_i_59 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(59),
      Q => dout_15(59)
    );
  BU2_U0_grf_rf_mem_dout_i_60 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(60),
      Q => dout_15(60)
    );
  BU2_U0_grf_rf_mem_dout_i_61 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(61),
      Q => dout_15(61)
    );
  BU2_U0_grf_rf_mem_dout_i_62 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(62),
      Q => dout_15(62)
    );
  BU2_U0_grf_rf_mem_dout_i_63 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(63),
      Q => dout_15(63)
    );
  BU2_U0_grf_rf_mem_dout_i_64 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(64),
      Q => dout_15(64)
    );
  BU2_U0_grf_rf_mem_dout_i_65 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(65),
      Q => dout_15(65)
    );
  BU2_U0_grf_rf_mem_dout_i_66 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(66),
      Q => dout_15(66)
    );
  BU2_U0_grf_rf_mem_dout_i_67 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(67),
      Q => dout_15(67)
    );
  BU2_U0_grf_rf_mem_dout_i_68 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(68),
      Q => dout_15(68)
    );
  BU2_U0_grf_rf_mem_dout_i_69 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(69),
      Q => dout_15(69)
    );
  BU2_U0_grf_rf_mem_dout_i_70 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(70),
      Q => dout_15(70)
    );
  BU2_U0_grf_rf_mem_dout_i_71 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(71),
      Q => dout_15(71)
    );
  BU2_U0_grf_rf_mem_dout_i_72 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(72),
      Q => dout_15(72)
    );
  BU2_U0_grf_rf_mem_dout_i_73 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(73),
      Q => dout_15(73)
    );
  BU2_U0_grf_rf_mem_dout_i_74 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(74),
      Q => dout_15(74)
    );
  BU2_U0_grf_rf_mem_dout_i_75 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(75),
      Q => dout_15(75)
    );
  BU2_U0_grf_rf_mem_dout_i_76 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(76),
      Q => dout_15(76)
    );
  BU2_U0_grf_rf_mem_dout_i_77 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(77),
      Q => dout_15(77)
    );
  BU2_U0_grf_rf_mem_dout_i_78 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(78),
      Q => dout_15(78)
    );
  BU2_U0_grf_rf_mem_dout_i_79 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(79),
      Q => dout_15(79)
    );
  BU2_U0_grf_rf_mem_dout_i_80 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(80),
      Q => dout_15(80)
    );
  BU2_U0_grf_rf_mem_dout_i_81 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(81),
      Q => dout_15(81)
    );
  BU2_U0_grf_rf_mem_dout_i_82 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(82),
      Q => dout_15(82)
    );
  BU2_U0_grf_rf_mem_dout_i_83 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(83),
      Q => dout_15(83)
    );
  BU2_U0_grf_rf_mem_dout_i_84 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(84),
      Q => dout_15(84)
    );
  BU2_U0_grf_rf_mem_dout_i_85 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(85),
      Q => dout_15(85)
    );
  BU2_U0_grf_rf_mem_dout_i_86 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(86),
      Q => dout_15(86)
    );
  BU2_U0_grf_rf_mem_dout_i_87 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(87),
      Q => dout_15(87)
    );
  BU2_U0_grf_rf_mem_dout_i_88 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(88),
      Q => dout_15(88)
    );
  BU2_U0_grf_rf_mem_dout_i_89 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(89),
      Q => dout_15(89)
    );
  BU2_U0_grf_rf_mem_dout_i_90 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(90),
      Q => dout_15(90)
    );
  BU2_U0_grf_rf_mem_dout_i_91 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(91),
      Q => dout_15(91)
    );
  BU2_U0_grf_rf_mem_dout_i_92 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(92),
      Q => dout_15(92)
    );
  BU2_U0_grf_rf_mem_dout_i_93 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(93),
      Q => dout_15(93)
    );
  BU2_U0_grf_rf_mem_dout_i_94 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(94),
      Q => dout_15(94)
    );
  BU2_U0_grf_rf_mem_dout_i_95 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(95),
      Q => dout_15(95)
    );
  BU2_U0_grf_rf_mem_dout_i_96 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(96),
      Q => dout_15(96)
    );
  BU2_U0_grf_rf_mem_dout_i_97 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(97),
      Q => dout_15(97)
    );
  BU2_U0_grf_rf_mem_dout_i_98 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_ram_regout_en,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q,
      D => BU2_U0_grf_rf_mem_dout_mem(98),
      Q => dout_15(98)
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_fb_2
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_empty_fwft_i_or0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      Q => empty
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_user_valid : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_In,
      Q => valid
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_In,
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd2_3
    );
  BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_In,
      Q => BU2_U0_grf_rf_gl0_rd_gr1_rfwft_curr_fwft_state_FFd1_4
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count9,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count6,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count9,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count6,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count3,
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_0 : FDPE
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      D => BU2_U0_grf_rf_gl0_wr_wpntr_Mcount_count,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count(0)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_wr_wpntr_count_d1_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_wr_wpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      D => BU2_U0_grf_rf_gl0_wr_wpntr_count(0),
      Q => BU2_U0_grf_rf_gl0_wr_wpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_fb_i : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_fb_i_5
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_wr_rst_d1 : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => BU2_U0_grf_rf_gl0_wr_gwss_wsts_wr_rst_d1_6
    );
  BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_i : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_gl0_wr_gwss_wsts_ram_full_comb,
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_reg(1),
      Q => full
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(3),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(3)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(2),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(2)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(1),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(1)
    );
  BU2_U0_grf_rf_gl0_rd_rpntr_count_d1_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_gl0_rd_rpntr_count_not0001,
      CLR => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      D => BU2_U0_grf_rf_gl0_rd_rpntr_count(0),
      Q => BU2_U0_grf_rf_gl0_rd_rpntr_count_d1(0)
    );
  BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i : FDP
    generic map(
      INIT => '1'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_mux0000,
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q,
      Q => BU2_U0_grf_rf_gl0_rd_grss_rsts_ram_empty_fb_i_7
    );
  BU2_U0_grf_rf_rstblk_wr_rst_reg_1 : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_wr_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_reg(1)
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_0 : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg_0_Q
    );
  BU2_U0_grf_rf_rstblk_rd_rst_reg_2 : FDP
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_rd_data_count(0),
      PRE => BU2_U0_grf_rf_rstblk_rd_rst_comb,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_reg_2_Q
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg : FDPE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_13,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_9
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_8,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_11
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg : FDPE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      CE => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_11,
      D => BU2_rd_data_count(0),
      PRE => rst,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_8
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_9,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_13
    );
  BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d1_11,
      Q => BU2_U0_grf_rf_rstblk_wr_rst_asreg_d2_10
    );
  BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => clk,
      D => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d1_13,
      Q => BU2_U0_grf_rf_rstblk_rd_rst_asreg_d2_12
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

-- synopsys translate_on
