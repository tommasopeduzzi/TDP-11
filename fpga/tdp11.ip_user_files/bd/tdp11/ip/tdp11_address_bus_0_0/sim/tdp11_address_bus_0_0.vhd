-- (c) Copyright 1995-2022 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:address_bus:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tdp11_address_bus_0_0 IS
  PORT (
    clk : IN STD_LOGIC;
    pc_sel : IN STD_LOGIC;
    sp_sel : IN STD_LOGIC;
    control_sel : IN STD_LOGIC;
    reg_sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    sp : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    control : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r5 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r6 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    r7 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END tdp11_address_bus_0_0;

ARCHITECTURE tdp11_address_bus_0_0_arch OF tdp11_address_bus_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF tdp11_address_bus_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT address_bus IS
    PORT (
      clk : IN STD_LOGIC;
      pc_sel : IN STD_LOGIC;
      sp_sel : IN STD_LOGIC;
      control_sel : IN STD_LOGIC;
      reg_sel : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      pc : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      sp : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      control : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r5 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r6 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      r7 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
  END COMPONENT address_bus;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk: SIGNAL IS "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_clk_out1, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 clk CLK";
BEGIN
  U0 : address_bus
    PORT MAP (
      clk => clk,
      pc_sel => pc_sel,
      sp_sel => sp_sel,
      control_sel => control_sel,
      reg_sel => reg_sel,
      pc => pc,
      sp => sp,
      control => control,
      r0 => r0,
      r1 => r1,
      r2 => r2,
      r3 => r3,
      r4 => r4,
      r5 => r5,
      r6 => r6,
      r7 => r7,
      output => output
    );
END tdp11_address_bus_0_0_arch;