-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
-- Date        : Mon Aug 15 20:56:07 2022
-- Host        : framework running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /home/tommasopeduzzi/Documents/16-bit-RISC-processor/fpga/tdp11.gen/sources_1/bd/tdp11/ip/tdp11_pc_0_0/tdp11_pc_0_0_sim_netlist.vhdl
-- Design      : tdp11_pc_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tdp11_pc_0_0_pc is
  port (
    output : out STD_LOGIC_VECTOR ( 15 downto 0 );
    input : in STD_LOGIC_VECTOR ( 15 downto 0 );
    load : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    inc : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of tdp11_pc_0_0_pc : entity is "pc";
end tdp11_pc_0_0_pc;

architecture STRUCTURE of tdp11_pc_0_0_pc is
  signal p_0_in : STD_LOGIC;
  signal \value[0]_i_1_n_0\ : STD_LOGIC;
  signal \value[0]_i_3_n_0\ : STD_LOGIC;
  signal \value[0]_i_4_n_0\ : STD_LOGIC;
  signal \value[0]_i_5_n_0\ : STD_LOGIC;
  signal \value[0]_i_6_n_0\ : STD_LOGIC;
  signal \value[0]_i_7_n_0\ : STD_LOGIC;
  signal \value[12]_i_2_n_0\ : STD_LOGIC;
  signal \value[12]_i_3_n_0\ : STD_LOGIC;
  signal \value[12]_i_4_n_0\ : STD_LOGIC;
  signal \value[12]_i_5_n_0\ : STD_LOGIC;
  signal \value[4]_i_2_n_0\ : STD_LOGIC;
  signal \value[4]_i_3_n_0\ : STD_LOGIC;
  signal \value[4]_i_4_n_0\ : STD_LOGIC;
  signal \value[4]_i_5_n_0\ : STD_LOGIC;
  signal \value[8]_i_2_n_0\ : STD_LOGIC;
  signal \value[8]_i_3_n_0\ : STD_LOGIC;
  signal \value[8]_i_4_n_0\ : STD_LOGIC;
  signal \value[8]_i_5_n_0\ : STD_LOGIC;
  signal value_reg : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \value_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \value_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \value_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \value_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \value_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \NLW_value_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \value_reg[0]_i_2\ : label is 11;
  attribute ADDER_THRESHOLD of \value_reg[12]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \value_reg[4]_i_1\ : label is 11;
  attribute ADDER_THRESHOLD of \value_reg[8]_i_1\ : label is 11;
begin
\output[15]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst,
      O => p_0_in
    );
\output_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(0),
      Q => output(0),
      R => '0'
    );
\output_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(10),
      Q => output(10),
      R => '0'
    );
\output_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(11),
      Q => output(11),
      R => '0'
    );
\output_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(12),
      Q => output(12),
      R => '0'
    );
\output_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(13),
      Q => output(13),
      R => '0'
    );
\output_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(14),
      Q => output(14),
      R => '0'
    );
\output_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(15),
      Q => output(15),
      R => '0'
    );
\output_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(1),
      Q => output(1),
      R => '0'
    );
\output_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(2),
      Q => output(2),
      R => '0'
    );
\output_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(3),
      Q => output(3),
      R => '0'
    );
\output_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(4),
      Q => output(4),
      R => '0'
    );
\output_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(5),
      Q => output(5),
      R => '0'
    );
\output_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(6),
      Q => output(6),
      R => '0'
    );
\output_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(7),
      Q => output(7),
      R => '0'
    );
\output_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(8),
      Q => output(8),
      R => '0'
    );
\output_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => p_0_in,
      D => value_reg(9),
      Q => output(9),
      R => '0'
    );
\value[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => load,
      I1 => inc,
      O => \value[0]_i_1_n_0\
    );
\value[0]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(0),
      I1 => load,
      I2 => value_reg(0),
      O => \value[0]_i_3_n_0\
    );
\value[0]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(3),
      I1 => load,
      I2 => value_reg(3),
      O => \value[0]_i_4_n_0\
    );
\value[0]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(2),
      I1 => load,
      I2 => value_reg(2),
      O => \value[0]_i_5_n_0\
    );
\value[0]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(1),
      I1 => load,
      I2 => value_reg(1),
      O => \value[0]_i_6_n_0\
    );
\value[0]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C5"
    )
        port map (
      I0 => value_reg(0),
      I1 => input(0),
      I2 => load,
      O => \value[0]_i_7_n_0\
    );
\value[12]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(15),
      I1 => load,
      I2 => value_reg(15),
      O => \value[12]_i_2_n_0\
    );
\value[12]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(14),
      I1 => load,
      I2 => value_reg(14),
      O => \value[12]_i_3_n_0\
    );
\value[12]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(13),
      I1 => load,
      I2 => value_reg(13),
      O => \value[12]_i_4_n_0\
    );
\value[12]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(12),
      I1 => load,
      I2 => value_reg(12),
      O => \value[12]_i_5_n_0\
    );
\value[4]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(7),
      I1 => load,
      I2 => value_reg(7),
      O => \value[4]_i_2_n_0\
    );
\value[4]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(6),
      I1 => load,
      I2 => value_reg(6),
      O => \value[4]_i_3_n_0\
    );
\value[4]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(5),
      I1 => load,
      I2 => value_reg(5),
      O => \value[4]_i_4_n_0\
    );
\value[4]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(4),
      I1 => load,
      I2 => value_reg(4),
      O => \value[4]_i_5_n_0\
    );
\value[8]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(11),
      I1 => load,
      I2 => value_reg(11),
      O => \value[8]_i_2_n_0\
    );
\value[8]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(10),
      I1 => load,
      I2 => value_reg(10),
      O => \value[8]_i_3_n_0\
    );
\value[8]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(9),
      I1 => load,
      I2 => value_reg(9),
      O => \value[8]_i_4_n_0\
    );
\value[8]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => input(8),
      I1 => load,
      I2 => value_reg(8),
      O => \value[8]_i_5_n_0\
    );
\value_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[0]_i_2_n_7\,
      Q => value_reg(0)
    );
\value_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \value_reg[0]_i_2_n_0\,
      CO(2) => \value_reg[0]_i_2_n_1\,
      CO(1) => \value_reg[0]_i_2_n_2\,
      CO(0) => \value_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => \value[0]_i_3_n_0\,
      O(3) => \value_reg[0]_i_2_n_4\,
      O(2) => \value_reg[0]_i_2_n_5\,
      O(1) => \value_reg[0]_i_2_n_6\,
      O(0) => \value_reg[0]_i_2_n_7\,
      S(3) => \value[0]_i_4_n_0\,
      S(2) => \value[0]_i_5_n_0\,
      S(1) => \value[0]_i_6_n_0\,
      S(0) => \value[0]_i_7_n_0\
    );
\value_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[8]_i_1_n_5\,
      Q => value_reg(10)
    );
\value_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[8]_i_1_n_4\,
      Q => value_reg(11)
    );
\value_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[12]_i_1_n_7\,
      Q => value_reg(12)
    );
\value_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \value_reg[8]_i_1_n_0\,
      CO(3) => \NLW_value_reg[12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \value_reg[12]_i_1_n_1\,
      CO(1) => \value_reg[12]_i_1_n_2\,
      CO(0) => \value_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \value_reg[12]_i_1_n_4\,
      O(2) => \value_reg[12]_i_1_n_5\,
      O(1) => \value_reg[12]_i_1_n_6\,
      O(0) => \value_reg[12]_i_1_n_7\,
      S(3) => \value[12]_i_2_n_0\,
      S(2) => \value[12]_i_3_n_0\,
      S(1) => \value[12]_i_4_n_0\,
      S(0) => \value[12]_i_5_n_0\
    );
\value_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[12]_i_1_n_6\,
      Q => value_reg(13)
    );
\value_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[12]_i_1_n_5\,
      Q => value_reg(14)
    );
\value_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[12]_i_1_n_4\,
      Q => value_reg(15)
    );
\value_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[0]_i_2_n_6\,
      Q => value_reg(1)
    );
\value_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[0]_i_2_n_5\,
      Q => value_reg(2)
    );
\value_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[0]_i_2_n_4\,
      Q => value_reg(3)
    );
\value_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[4]_i_1_n_7\,
      Q => value_reg(4)
    );
\value_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \value_reg[0]_i_2_n_0\,
      CO(3) => \value_reg[4]_i_1_n_0\,
      CO(2) => \value_reg[4]_i_1_n_1\,
      CO(1) => \value_reg[4]_i_1_n_2\,
      CO(0) => \value_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \value_reg[4]_i_1_n_4\,
      O(2) => \value_reg[4]_i_1_n_5\,
      O(1) => \value_reg[4]_i_1_n_6\,
      O(0) => \value_reg[4]_i_1_n_7\,
      S(3) => \value[4]_i_2_n_0\,
      S(2) => \value[4]_i_3_n_0\,
      S(1) => \value[4]_i_4_n_0\,
      S(0) => \value[4]_i_5_n_0\
    );
\value_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[4]_i_1_n_6\,
      Q => value_reg(5)
    );
\value_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[4]_i_1_n_5\,
      Q => value_reg(6)
    );
\value_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[4]_i_1_n_4\,
      Q => value_reg(7)
    );
\value_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[8]_i_1_n_7\,
      Q => value_reg(8)
    );
\value_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \value_reg[4]_i_1_n_0\,
      CO(3) => \value_reg[8]_i_1_n_0\,
      CO(2) => \value_reg[8]_i_1_n_1\,
      CO(1) => \value_reg[8]_i_1_n_2\,
      CO(0) => \value_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \value_reg[8]_i_1_n_4\,
      O(2) => \value_reg[8]_i_1_n_5\,
      O(1) => \value_reg[8]_i_1_n_6\,
      O(0) => \value_reg[8]_i_1_n_7\,
      S(3) => \value[8]_i_2_n_0\,
      S(2) => \value[8]_i_3_n_0\,
      S(1) => \value[8]_i_4_n_0\,
      S(0) => \value[8]_i_5_n_0\
    );
\value_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \value[0]_i_1_n_0\,
      CLR => rst,
      D => \value_reg[8]_i_1_n_6\,
      Q => value_reg(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity tdp11_pc_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    inc : in STD_LOGIC;
    load : in STD_LOGIC;
    input : in STD_LOGIC_VECTOR ( 15 downto 0 );
    output : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of tdp11_pc_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of tdp11_pc_0_0 : entity is "tdp11_pc_0_0,pc,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of tdp11_pc_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of tdp11_pc_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of tdp11_pc_0_0 : entity is "pc,Vivado 2022.1";
end tdp11_pc_0_0;

architecture STRUCTURE of tdp11_pc_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /clk_clk_out1, INSERT_VIP 0";
  attribute x_interface_info of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute x_interface_parameter of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
U0: entity work.tdp11_pc_0_0_pc
     port map (
      clk => clk,
      inc => inc,
      input(15 downto 0) => input(15 downto 0),
      load => load,
      output(15 downto 0) => output(15 downto 0),
      rst => rst
    );
end STRUCTURE;
