//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Jul 29 10:04:36 2024
//Host        : DESKTOP-68CQUKE running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    ZmodAdcClkIn_n_0,
    ZmodAdcClkIn_n_1,
    ZmodAdcClkIn_p_0,
    ZmodAdcClkIn_p_1,
    ZmodDcoClk_0,
    ZmodDcoClk_1,
    dZmodADC_Data_0,
    dZmodADC_Data_1,
    iZmodSync_0,
    iZmodSync_1,
    sZmodADC_CS_0,
    sZmodADC_CS_1,
    sZmodADC_SDIO_0,
    sZmodADC_SDIO_1,
    sZmodADC_Sclk_0,
    sZmodADC_Sclk_1,
    sZmodCh1CouplingH_0,
    sZmodCh1CouplingH_1,
    sZmodCh1CouplingL_0,
    sZmodCh1CouplingL_1,
    sZmodCh1GainH_0,
    sZmodCh1GainH_1,
    sZmodCh1GainL_0,
    sZmodCh1GainL_1,
    sZmodCh2CouplingH_0,
    sZmodCh2CouplingH_1,
    sZmodCh2CouplingL_0,
    sZmodCh2CouplingL_1,
    sZmodCh2GainH_0,
    sZmodCh2GainH_1,
    sZmodCh2GainL_0,
    sZmodCh2GainL_1,
    sZmodRelayComH_0,
    sZmodRelayComH_1,
    sZmodRelayComL_0,
    sZmodRelayComL_1,
    sys_clk_led);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output ZmodAdcClkIn_n_0;
  output ZmodAdcClkIn_n_1;
  output ZmodAdcClkIn_p_0;
  output ZmodAdcClkIn_p_1;
  input ZmodDcoClk_0;
  input ZmodDcoClk_1;
  input [13:0]dZmodADC_Data_0;
  input [13:0]dZmodADC_Data_1;
  output iZmodSync_0;
  output iZmodSync_1;
  output sZmodADC_CS_0;
  output sZmodADC_CS_1;
  inout sZmodADC_SDIO_0;
  inout sZmodADC_SDIO_1;
  output sZmodADC_Sclk_0;
  output sZmodADC_Sclk_1;
  output sZmodCh1CouplingH_0;
  output sZmodCh1CouplingH_1;
  output sZmodCh1CouplingL_0;
  output sZmodCh1CouplingL_1;
  output sZmodCh1GainH_0;
  output sZmodCh1GainH_1;
  output sZmodCh1GainL_0;
  output sZmodCh1GainL_1;
  output sZmodCh2CouplingH_0;
  output sZmodCh2CouplingH_1;
  output sZmodCh2CouplingL_0;
  output sZmodCh2CouplingL_1;
  output sZmodCh2GainH_0;
  output sZmodCh2GainH_1;
  output sZmodCh2GainL_0;
  output sZmodCh2GainL_1;
  output sZmodRelayComH_0;
  output sZmodRelayComH_1;
  output sZmodRelayComL_0;
  output sZmodRelayComL_1;
  output sys_clk_led;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire ZmodAdcClkIn_n_0;
  wire ZmodAdcClkIn_n_1;
  wire ZmodAdcClkIn_p_0;
  wire ZmodAdcClkIn_p_1;
  wire ZmodDcoClk_0;
  wire ZmodDcoClk_1;
  wire [13:0]dZmodADC_Data_0;
  wire [13:0]dZmodADC_Data_1;
  wire iZmodSync_0;
  wire iZmodSync_1;
  wire sZmodADC_CS_0;
  wire sZmodADC_CS_1;
  wire sZmodADC_SDIO_0;
  wire sZmodADC_SDIO_1;
  wire sZmodADC_Sclk_0;
  wire sZmodADC_Sclk_1;
  wire sZmodCh1CouplingH_0;
  wire sZmodCh1CouplingH_1;
  wire sZmodCh1CouplingL_0;
  wire sZmodCh1CouplingL_1;
  wire sZmodCh1GainH_0;
  wire sZmodCh1GainH_1;
  wire sZmodCh1GainL_0;
  wire sZmodCh1GainL_1;
  wire sZmodCh2CouplingH_0;
  wire sZmodCh2CouplingH_1;
  wire sZmodCh2CouplingL_0;
  wire sZmodCh2CouplingL_1;
  wire sZmodCh2GainH_0;
  wire sZmodCh2GainH_1;
  wire sZmodCh2GainL_0;
  wire sZmodCh2GainL_1;
  wire sZmodRelayComH_0;
  wire sZmodRelayComH_1;
  wire sZmodRelayComL_0;
  wire sZmodRelayComL_1;
  wire sys_clk_led;

  design_1 design_1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .ZmodAdcClkIn_n_0(ZmodAdcClkIn_n_0),
        .ZmodAdcClkIn_n_1(ZmodAdcClkIn_n_1),
        .ZmodAdcClkIn_p_0(ZmodAdcClkIn_p_0),
        .ZmodAdcClkIn_p_1(ZmodAdcClkIn_p_1),
        .ZmodDcoClk_0(ZmodDcoClk_0),
        .ZmodDcoClk_1(ZmodDcoClk_1),
        .dZmodADC_Data_0(dZmodADC_Data_0),
        .dZmodADC_Data_1(dZmodADC_Data_1),
        .iZmodSync_0(iZmodSync_0),
        .iZmodSync_1(iZmodSync_1),
        .sZmodADC_CS_0(sZmodADC_CS_0),
        .sZmodADC_CS_1(sZmodADC_CS_1),
        .sZmodADC_SDIO_0(sZmodADC_SDIO_0),
        .sZmodADC_SDIO_1(sZmodADC_SDIO_1),
        .sZmodADC_Sclk_0(sZmodADC_Sclk_0),
        .sZmodADC_Sclk_1(sZmodADC_Sclk_1),
        .sZmodCh1CouplingH_0(sZmodCh1CouplingH_0),
        .sZmodCh1CouplingH_1(sZmodCh1CouplingH_1),
        .sZmodCh1CouplingL_0(sZmodCh1CouplingL_0),
        .sZmodCh1CouplingL_1(sZmodCh1CouplingL_1),
        .sZmodCh1GainH_0(sZmodCh1GainH_0),
        .sZmodCh1GainH_1(sZmodCh1GainH_1),
        .sZmodCh1GainL_0(sZmodCh1GainL_0),
        .sZmodCh1GainL_1(sZmodCh1GainL_1),
        .sZmodCh2CouplingH_0(sZmodCh2CouplingH_0),
        .sZmodCh2CouplingH_1(sZmodCh2CouplingH_1),
        .sZmodCh2CouplingL_0(sZmodCh2CouplingL_0),
        .sZmodCh2CouplingL_1(sZmodCh2CouplingL_1),
        .sZmodCh2GainH_0(sZmodCh2GainH_0),
        .sZmodCh2GainH_1(sZmodCh2GainH_1),
        .sZmodCh2GainL_0(sZmodCh2GainL_0),
        .sZmodCh2GainL_1(sZmodCh2GainL_1),
        .sZmodRelayComH_0(sZmodRelayComH_0),
        .sZmodRelayComH_1(sZmodRelayComH_1),
        .sZmodRelayComL_0(sZmodRelayComL_0),
        .sZmodRelayComL_1(sZmodRelayComL_1),
        .sys_clk_led(sys_clk_led));
endmodule
