-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dbg_hub is
  Port ( 
    sl_iport0_o : out STD_LOGIC_VECTOR ( 36 downto 0 );
    sl_iport1_o : out STD_LOGIC_VECTOR ( 36 downto 0 );
    sl_oport0_i : in STD_LOGIC_VECTOR ( 16 downto 0 );
    sl_oport1_i : in STD_LOGIC_VECTOR ( 16 downto 0 );
    clk : in STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of dbg_hub : entity is "dbg_hub,xsdbm_v3_0_3_xsdbm,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of dbg_hub : entity is "dbg_hub,xsdbm_v3_0_3_xsdbm,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xsdbm,x_ipVersion=3.0,x_ipCoreRevision=3,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_FIFO_STYLE=SUBCORE,C_XDEVICEFAMILY=artix7,C_MAJOR_VERSION=14,C_MINOR_VERSION=1,C_BUILD_REVISION=0,C_CORE_MAJOR_VER=1,C_CORE_MINOR_VER=0,C_CORE_MINOR_ALPHA_VER=97,C_XSDB_NUM_SLAVES=2,C_XSDB_PERIOD_INT=10,C_XSDB_PERIOD_FRC=0,C_USE_BUFR=0,C_DCLK_HAS_RESET=0,C_EN_INT_SIM=1,C_CORE_TYPE=1,C_USER_SCAN_CHAIN=1,C_CLKFBOUT_MULT_F=10.000,C_DIVCLK_DIVIDE=3,C_CLKOUT0_DIVIDE_F=10.000,C_CLK_INPUT_FREQ_HZ=300000000,C_ENABLE_CLK_DIVIDER=0,C_USE_EXT_BSCAN=0,C_USE_STARTUP_CLK=0,C_EN_BSCANID_VEC=0,C_TWO_PRIM_MODE=0,C_USER_SCAN_CHAIN1=1,C_BSCANID=76546592,C_BSCAN_MODE=0,C_BSCAN_MODE_WITH_CORE=0,C_NUM_BSCAN_MASTER_PORTS=0}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of dbg_hub : entity is "yes";
end dbg_hub;

architecture stub of dbg_hub is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 signal_clock CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME signal_clock, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "xsdbm_v3_0_3_xsdbm,Vivado 2024.2";
begin
end;
