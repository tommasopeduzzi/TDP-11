-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
-- Date        : Mon Aug 15 20:56:07 2022
-- Host        : framework running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/tommasopeduzzi/Documents/16-bit-RISC-processor/fpga/tdp11.gen/sources_1/bd/tdp11/ip/tdp11_pc_0_0/tdp11_pc_0_0_stub.vhdl
-- Design      : tdp11_pc_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tdp11_pc_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    inc : in STD_LOGIC;
    load : in STD_LOGIC;
    input : in STD_LOGIC_VECTOR ( 15 downto 0 );
    output : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end tdp11_pc_0_0;

architecture stub of tdp11_pc_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,inc,load,input[15:0],output[15:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "pc,Vivado 2022.1";
begin
end;
