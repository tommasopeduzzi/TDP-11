library IEEE;
use IEEE.std_logic_1164.all;
package instructions is
	constant halt : std_logic_vector(5 downto 0) := "111111";
	constant nop : std_logic_vector(5 downto 0) := "000000";
	constant load_reg_reg : std_logic_vector(5 downto 0) := "000001";
	constant load8_reg_reg : std_logic_vector(5 downto 0) := "000010";
	constant load_reg_addr : std_logic_vector(5 downto 0) := "000011";
	constant load8_reg_addr : std_logic_vector(5 downto 0) := "000100";
	constant loadimm_reg_imm : std_logic_vector(5 downto 0) := "000101";
	constant loadaddr_reg_addr : std_logic_vector(5 downto 0) := "000110";
	constant store_reg_reg : std_logic_vector(5 downto 0) := "000111";
	constant storel_reg_reg : std_logic_vector(5 downto 0) := "001000";
	constant storeg_reg_reg : std_logic_vector(5 downto 0) := "001001";
	constant store_reg_addr : std_logic_vector(5 downto 0) := "001010";
	constant storel_reg_addr : std_logic_vector(5 downto 0) := "001011";
	constant storeg_reg_addr : std_logic_vector(5 downto 0) := "001100";
	constant copy_reg_reg : std_logic_vector(5 downto 0) := "001101";
	constant push_reg : std_logic_vector(5 downto 0) := "001110";
	constant pop_reg : std_logic_vector(5 downto 0) := "001111";
	constant add_reg_reg : std_logic_vector(5 downto 0) := "010000";
	constant sub_reg_reg : std_logic_vector(5 downto 0) := "010001";
	constant cmp_reg_reg : std_logic_vector(5 downto 0) := "010010";
	constant not_reg : std_logic_vector(5 downto 0) := "010011";
	constant shiftl_reg : std_logic_vector(5 downto 0) := "010100";
	constant shiftr_reg : std_logic_vector(5 downto 0) := "010101";
	constant and_reg_reg : std_logic_vector(5 downto 0) := "010110";
	constant or_reg_reg : std_logic_vector(5 downto 0) := "010111";
	constant xor_reg_reg : std_logic_vector(5 downto 0) := "011000";
	constant jump_addr : std_logic_vector(5 downto 0) := "011001";
	constant jumpeq_addr : std_logic_vector(5 downto 0) := "011010";
	constant jumpl_addr : std_logic_vector(5 downto 0) := "011011";
	constant jumpg_addr : std_logic_vector(5 downto 0) := "011100";
	constant jumpc_addr : std_logic_vector(5 downto 0) := "011101";
	constant in_reg_dev : std_logic_vector(5 downto 0) := "011110";
	constant out_reg_dev : std_logic_vector(5 downto 0) := "011111";
end package instructions;