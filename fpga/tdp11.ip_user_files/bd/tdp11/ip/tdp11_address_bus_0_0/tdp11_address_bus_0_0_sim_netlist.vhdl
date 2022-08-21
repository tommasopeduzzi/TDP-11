-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
-- Date        : Mon Aug 15 20:56:25 2022
-- Host        : framework running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim -rename_top tdp11_address_bus_0_0 -prefix
--               tdp11_address_bus_0_0_ tdp11_address_bus_0_0_sim_netlist.vhdl
-- Design      : tdp11_address_bus_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tdp11_address_bus_0_0_address_bus is
  port (
    output : out STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    pc : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pc_sel : in STD_LOGIC;
    sp : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sp_sel : in STD_LOGIC;
    control : in STD_LOGIC_VECTOR ( 15 downto 0 );
    control_sel : in STD_LOGIC;
    reg_sel : in STD_LOGIC_VECTOR ( 2 downto 0 );
    r3 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r7 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r6 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r5 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r4 : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end tdp11_address_bus_0_0_address_bus;

architecture STRUCTURE of tdp11_address_bus_0_0_address_bus is
  signal \output[0]_i_2_n_0\ : STD_LOGIC;
  signal \output[0]_i_3_n_0\ : STD_LOGIC;
  signal \output[0]_i_4_n_0\ : STD_LOGIC;
  signal \output[10]_i_2_n_0\ : STD_LOGIC;
  signal \output[10]_i_3_n_0\ : STD_LOGIC;
  signal \output[10]_i_4_n_0\ : STD_LOGIC;
  signal \output[11]_i_2_n_0\ : STD_LOGIC;
  signal \output[11]_i_3_n_0\ : STD_LOGIC;
  signal \output[11]_i_4_n_0\ : STD_LOGIC;
  signal \output[12]_i_2_n_0\ : STD_LOGIC;
  signal \output[12]_i_3_n_0\ : STD_LOGIC;
  signal \output[12]_i_4_n_0\ : STD_LOGIC;
  signal \output[13]_i_2_n_0\ : STD_LOGIC;
  signal \output[13]_i_3_n_0\ : STD_LOGIC;
  signal \output[13]_i_4_n_0\ : STD_LOGIC;
  signal \output[14]_i_2_n_0\ : STD_LOGIC;
  signal \output[14]_i_3_n_0\ : STD_LOGIC;
  signal \output[14]_i_4_n_0\ : STD_LOGIC;
  signal \output[15]_i_2_n_0\ : STD_LOGIC;
  signal \output[15]_i_3_n_0\ : STD_LOGIC;
  signal \output[15]_i_4_n_0\ : STD_LOGIC;
  signal \output[1]_i_2_n_0\ : STD_LOGIC;
  signal \output[1]_i_3_n_0\ : STD_LOGIC;
  signal \output[1]_i_4_n_0\ : STD_LOGIC;
  signal \output[2]_i_2_n_0\ : STD_LOGIC;
  signal \output[2]_i_3_n_0\ : STD_LOGIC;
  signal \output[2]_i_4_n_0\ : STD_LOGIC;
  signal \output[3]_i_2_n_0\ : STD_LOGIC;
  signal \output[3]_i_3_n_0\ : STD_LOGIC;
  signal \output[3]_i_4_n_0\ : STD_LOGIC;
  signal \output[4]_i_2_n_0\ : STD_LOGIC;
  signal \output[4]_i_3_n_0\ : STD_LOGIC;
  signal \output[4]_i_4_n_0\ : STD_LOGIC;
  signal \output[5]_i_2_n_0\ : STD_LOGIC;
  signal \output[5]_i_3_n_0\ : STD_LOGIC;
  signal \output[5]_i_4_n_0\ : STD_LOGIC;
  signal \output[6]_i_2_n_0\ : STD_LOGIC;
  signal \output[6]_i_3_n_0\ : STD_LOGIC;
  signal \output[6]_i_4_n_0\ : STD_LOGIC;
  signal \output[7]_i_2_n_0\ : STD_LOGIC;
  signal \output[7]_i_3_n_0\ : STD_LOGIC;
  signal \output[7]_i_4_n_0\ : STD_LOGIC;
  signal \output[8]_i_2_n_0\ : STD_LOGIC;
  signal \output[8]_i_3_n_0\ : STD_LOGIC;
  signal \output[8]_i_4_n_0\ : STD_LOGIC;
  signal \output[9]_i_2_n_0\ : STD_LOGIC;
  signal \output[9]_i_3_n_0\ : STD_LOGIC;
  signal \output[9]_i_4_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 15 downto 0 );
begin
\output[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(0),
      I1 => pc_sel,
      I2 => sp(0),
      I3 => sp_sel,
      I4 => \output[0]_i_2_n_0\,
      O => p_0_in(0)
    );
\output[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(0),
      I1 => control_sel,
      I2 => \output[0]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[0]_i_4_n_0\,
      O => \output[0]_i_2_n_0\
    );
\output[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(0),
      I1 => r6(0),
      I2 => reg_sel(1),
      I3 => r5(0),
      I4 => reg_sel(0),
      I5 => r4(0),
      O => \output[0]_i_3_n_0\
    );
\output[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(0),
      I1 => r2(0),
      I2 => reg_sel(1),
      I3 => r1(0),
      I4 => reg_sel(0),
      I5 => r0(0),
      O => \output[0]_i_4_n_0\
    );
\output[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(10),
      I1 => pc_sel,
      I2 => sp(10),
      I3 => sp_sel,
      I4 => \output[10]_i_2_n_0\,
      O => p_0_in(10)
    );
\output[10]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(10),
      I1 => control_sel,
      I2 => \output[10]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[10]_i_4_n_0\,
      O => \output[10]_i_2_n_0\
    );
\output[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(10),
      I1 => r6(10),
      I2 => reg_sel(1),
      I3 => r5(10),
      I4 => reg_sel(0),
      I5 => r4(10),
      O => \output[10]_i_3_n_0\
    );
\output[10]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(10),
      I1 => r2(10),
      I2 => reg_sel(1),
      I3 => r1(10),
      I4 => reg_sel(0),
      I5 => r0(10),
      O => \output[10]_i_4_n_0\
    );
\output[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(11),
      I1 => pc_sel,
      I2 => sp(11),
      I3 => sp_sel,
      I4 => \output[11]_i_2_n_0\,
      O => p_0_in(11)
    );
\output[11]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(11),
      I1 => control_sel,
      I2 => \output[11]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[11]_i_4_n_0\,
      O => \output[11]_i_2_n_0\
    );
\output[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(11),
      I1 => r6(11),
      I2 => reg_sel(1),
      I3 => r5(11),
      I4 => reg_sel(0),
      I5 => r4(11),
      O => \output[11]_i_3_n_0\
    );
\output[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(11),
      I1 => r2(11),
      I2 => reg_sel(1),
      I3 => r1(11),
      I4 => reg_sel(0),
      I5 => r0(11),
      O => \output[11]_i_4_n_0\
    );
\output[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(12),
      I1 => pc_sel,
      I2 => sp(12),
      I3 => sp_sel,
      I4 => \output[12]_i_2_n_0\,
      O => p_0_in(12)
    );
\output[12]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(12),
      I1 => control_sel,
      I2 => \output[12]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[12]_i_4_n_0\,
      O => \output[12]_i_2_n_0\
    );
\output[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(12),
      I1 => r6(12),
      I2 => reg_sel(1),
      I3 => r5(12),
      I4 => reg_sel(0),
      I5 => r4(12),
      O => \output[12]_i_3_n_0\
    );
\output[12]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(12),
      I1 => r2(12),
      I2 => reg_sel(1),
      I3 => r1(12),
      I4 => reg_sel(0),
      I5 => r0(12),
      O => \output[12]_i_4_n_0\
    );
\output[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(13),
      I1 => pc_sel,
      I2 => sp(13),
      I3 => sp_sel,
      I4 => \output[13]_i_2_n_0\,
      O => p_0_in(13)
    );
\output[13]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(13),
      I1 => control_sel,
      I2 => \output[13]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[13]_i_4_n_0\,
      O => \output[13]_i_2_n_0\
    );
\output[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(13),
      I1 => r6(13),
      I2 => reg_sel(1),
      I3 => r5(13),
      I4 => reg_sel(0),
      I5 => r4(13),
      O => \output[13]_i_3_n_0\
    );
\output[13]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(13),
      I1 => r2(13),
      I2 => reg_sel(1),
      I3 => r1(13),
      I4 => reg_sel(0),
      I5 => r0(13),
      O => \output[13]_i_4_n_0\
    );
\output[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(14),
      I1 => pc_sel,
      I2 => sp(14),
      I3 => sp_sel,
      I4 => \output[14]_i_2_n_0\,
      O => p_0_in(14)
    );
\output[14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(14),
      I1 => control_sel,
      I2 => \output[14]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[14]_i_4_n_0\,
      O => \output[14]_i_2_n_0\
    );
\output[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(14),
      I1 => r6(14),
      I2 => reg_sel(1),
      I3 => r5(14),
      I4 => reg_sel(0),
      I5 => r4(14),
      O => \output[14]_i_3_n_0\
    );
\output[14]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(14),
      I1 => r2(14),
      I2 => reg_sel(1),
      I3 => r1(14),
      I4 => reg_sel(0),
      I5 => r0(14),
      O => \output[14]_i_4_n_0\
    );
\output[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(15),
      I1 => pc_sel,
      I2 => sp(15),
      I3 => sp_sel,
      I4 => \output[15]_i_2_n_0\,
      O => p_0_in(15)
    );
\output[15]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(15),
      I1 => control_sel,
      I2 => \output[15]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[15]_i_4_n_0\,
      O => \output[15]_i_2_n_0\
    );
\output[15]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(15),
      I1 => r6(15),
      I2 => reg_sel(1),
      I3 => r5(15),
      I4 => reg_sel(0),
      I5 => r4(15),
      O => \output[15]_i_3_n_0\
    );
\output[15]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(15),
      I1 => r2(15),
      I2 => reg_sel(1),
      I3 => r1(15),
      I4 => reg_sel(0),
      I5 => r0(15),
      O => \output[15]_i_4_n_0\
    );
\output[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(1),
      I1 => pc_sel,
      I2 => sp(1),
      I3 => sp_sel,
      I4 => \output[1]_i_2_n_0\,
      O => p_0_in(1)
    );
\output[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(1),
      I1 => control_sel,
      I2 => \output[1]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[1]_i_4_n_0\,
      O => \output[1]_i_2_n_0\
    );
\output[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(1),
      I1 => r6(1),
      I2 => reg_sel(1),
      I3 => r5(1),
      I4 => reg_sel(0),
      I5 => r4(1),
      O => \output[1]_i_3_n_0\
    );
\output[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(1),
      I1 => r2(1),
      I2 => reg_sel(1),
      I3 => r1(1),
      I4 => reg_sel(0),
      I5 => r0(1),
      O => \output[1]_i_4_n_0\
    );
\output[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(2),
      I1 => pc_sel,
      I2 => sp(2),
      I3 => sp_sel,
      I4 => \output[2]_i_2_n_0\,
      O => p_0_in(2)
    );
\output[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(2),
      I1 => control_sel,
      I2 => \output[2]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[2]_i_4_n_0\,
      O => \output[2]_i_2_n_0\
    );
\output[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(2),
      I1 => r6(2),
      I2 => reg_sel(1),
      I3 => r5(2),
      I4 => reg_sel(0),
      I5 => r4(2),
      O => \output[2]_i_3_n_0\
    );
\output[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(2),
      I1 => r2(2),
      I2 => reg_sel(1),
      I3 => r1(2),
      I4 => reg_sel(0),
      I5 => r0(2),
      O => \output[2]_i_4_n_0\
    );
\output[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(3),
      I1 => pc_sel,
      I2 => sp(3),
      I3 => sp_sel,
      I4 => \output[3]_i_2_n_0\,
      O => p_0_in(3)
    );
\output[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(3),
      I1 => control_sel,
      I2 => \output[3]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[3]_i_4_n_0\,
      O => \output[3]_i_2_n_0\
    );
\output[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(3),
      I1 => r6(3),
      I2 => reg_sel(1),
      I3 => r5(3),
      I4 => reg_sel(0),
      I5 => r4(3),
      O => \output[3]_i_3_n_0\
    );
\output[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(3),
      I1 => r2(3),
      I2 => reg_sel(1),
      I3 => r1(3),
      I4 => reg_sel(0),
      I5 => r0(3),
      O => \output[3]_i_4_n_0\
    );
\output[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(4),
      I1 => pc_sel,
      I2 => sp(4),
      I3 => sp_sel,
      I4 => \output[4]_i_2_n_0\,
      O => p_0_in(4)
    );
\output[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(4),
      I1 => control_sel,
      I2 => \output[4]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[4]_i_4_n_0\,
      O => \output[4]_i_2_n_0\
    );
\output[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(4),
      I1 => r6(4),
      I2 => reg_sel(1),
      I3 => r5(4),
      I4 => reg_sel(0),
      I5 => r4(4),
      O => \output[4]_i_3_n_0\
    );
\output[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(4),
      I1 => r2(4),
      I2 => reg_sel(1),
      I3 => r1(4),
      I4 => reg_sel(0),
      I5 => r0(4),
      O => \output[4]_i_4_n_0\
    );
\output[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(5),
      I1 => pc_sel,
      I2 => sp(5),
      I3 => sp_sel,
      I4 => \output[5]_i_2_n_0\,
      O => p_0_in(5)
    );
\output[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(5),
      I1 => control_sel,
      I2 => \output[5]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[5]_i_4_n_0\,
      O => \output[5]_i_2_n_0\
    );
\output[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(5),
      I1 => r6(5),
      I2 => reg_sel(1),
      I3 => r5(5),
      I4 => reg_sel(0),
      I5 => r4(5),
      O => \output[5]_i_3_n_0\
    );
\output[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(5),
      I1 => r2(5),
      I2 => reg_sel(1),
      I3 => r1(5),
      I4 => reg_sel(0),
      I5 => r0(5),
      O => \output[5]_i_4_n_0\
    );
\output[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(6),
      I1 => pc_sel,
      I2 => sp(6),
      I3 => sp_sel,
      I4 => \output[6]_i_2_n_0\,
      O => p_0_in(6)
    );
\output[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(6),
      I1 => control_sel,
      I2 => \output[6]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[6]_i_4_n_0\,
      O => \output[6]_i_2_n_0\
    );
\output[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(6),
      I1 => r6(6),
      I2 => reg_sel(1),
      I3 => r5(6),
      I4 => reg_sel(0),
      I5 => r4(6),
      O => \output[6]_i_3_n_0\
    );
\output[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(6),
      I1 => r2(6),
      I2 => reg_sel(1),
      I3 => r1(6),
      I4 => reg_sel(0),
      I5 => r0(6),
      O => \output[6]_i_4_n_0\
    );
\output[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(7),
      I1 => pc_sel,
      I2 => sp(7),
      I3 => sp_sel,
      I4 => \output[7]_i_2_n_0\,
      O => p_0_in(7)
    );
\output[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(7),
      I1 => control_sel,
      I2 => \output[7]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[7]_i_4_n_0\,
      O => \output[7]_i_2_n_0\
    );
\output[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(7),
      I1 => r6(7),
      I2 => reg_sel(1),
      I3 => r5(7),
      I4 => reg_sel(0),
      I5 => r4(7),
      O => \output[7]_i_3_n_0\
    );
\output[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(7),
      I1 => r2(7),
      I2 => reg_sel(1),
      I3 => r1(7),
      I4 => reg_sel(0),
      I5 => r0(7),
      O => \output[7]_i_4_n_0\
    );
\output[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(8),
      I1 => pc_sel,
      I2 => sp(8),
      I3 => sp_sel,
      I4 => \output[8]_i_2_n_0\,
      O => p_0_in(8)
    );
\output[8]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(8),
      I1 => control_sel,
      I2 => \output[8]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[8]_i_4_n_0\,
      O => \output[8]_i_2_n_0\
    );
\output[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(8),
      I1 => r6(8),
      I2 => reg_sel(1),
      I3 => r5(8),
      I4 => reg_sel(0),
      I5 => r4(8),
      O => \output[8]_i_3_n_0\
    );
\output[8]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(8),
      I1 => r2(8),
      I2 => reg_sel(1),
      I3 => r1(8),
      I4 => reg_sel(0),
      I5 => r0(8),
      O => \output[8]_i_4_n_0\
    );
\output[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => pc(9),
      I1 => pc_sel,
      I2 => sp(9),
      I3 => sp_sel,
      I4 => \output[9]_i_2_n_0\,
      O => p_0_in(9)
    );
\output[9]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => control(9),
      I1 => control_sel,
      I2 => \output[9]_i_3_n_0\,
      I3 => reg_sel(2),
      I4 => \output[9]_i_4_n_0\,
      O => \output[9]_i_2_n_0\
    );
\output[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r7(9),
      I1 => r6(9),
      I2 => reg_sel(1),
      I3 => r5(9),
      I4 => reg_sel(0),
      I5 => r4(9),
      O => \output[9]_i_3_n_0\
    );
\output[9]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => r3(9),
      I1 => r2(9),
      I2 => reg_sel(1),
      I3 => r1(9),
      I4 => reg_sel(0),
      I5 => r0(9),
      O => \output[9]_i_4_n_0\
    );
\output_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(0),
      Q => output(0),
      R => '0'
    );
\output_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(10),
      Q => output(10),
      R => '0'
    );
\output_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(11),
      Q => output(11),
      R => '0'
    );
\output_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(12),
      Q => output(12),
      R => '0'
    );
\output_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(13),
      Q => output(13),
      R => '0'
    );
\output_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(14),
      Q => output(14),
      R => '0'
    );
\output_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(15),
      Q => output(15),
      R => '0'
    );
\output_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(1),
      Q => output(1),
      R => '0'
    );
\output_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(2),
      Q => output(2),
      R => '0'
    );
\output_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(3),
      Q => output(3),
      R => '0'
    );
\output_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(4),
      Q => output(4),
      R => '0'
    );
\output_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(5),
      Q => output(5),
      R => '0'
    );
\output_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(6),
      Q => output(6),
      R => '0'
    );
\output_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(7),
      Q => output(7),
      R => '0'
    );
\output_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(8),
      Q => output(8),
      R => '0'
    );
\output_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => p_0_in(9),
      Q => output(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tdp11_address_bus_0_0 is
  port (
    clk : in STD_LOGIC;
    pc_sel : in STD_LOGIC;
    sp_sel : in STD_LOGIC;
    control_sel : in STD_LOGIC;
    reg_sel : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pc : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sp : in STD_LOGIC_VECTOR ( 15 downto 0 );
    control : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r3 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r4 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r5 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r6 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    r7 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    output : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of tdp11_address_bus_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of tdp11_address_bus_0_0 : entity is "tdp11_address_bus_0_0,address_bus,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of tdp11_address_bus_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of tdp11_address_bus_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of tdp11_address_bus_0_0 : entity is "address_bus,Vivado 2022.1";
end tdp11_address_bus_0_0;

architecture STRUCTURE of tdp11_address_bus_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_clk_out1, INSERT_VIP 0";
begin
U0: entity work.tdp11_address_bus_0_0_address_bus
     port map (
      clk => clk,
      control(15 downto 0) => control(15 downto 0),
      control_sel => control_sel,
      output(15 downto 0) => output(15 downto 0),
      pc(15 downto 0) => pc(15 downto 0),
      pc_sel => pc_sel,
      r0(15 downto 0) => r0(15 downto 0),
      r1(15 downto 0) => r1(15 downto 0),
      r2(15 downto 0) => r2(15 downto 0),
      r3(15 downto 0) => r3(15 downto 0),
      r4(15 downto 0) => r4(15 downto 0),
      r5(15 downto 0) => r5(15 downto 0),
      r6(15 downto 0) => r6(15 downto 0),
      r7(15 downto 0) => r7(15 downto 0),
      reg_sel(2 downto 0) => reg_sel(2 downto 0),
      sp(15 downto 0) => sp(15 downto 0),
      sp_sel => sp_sel
    );
end STRUCTURE;