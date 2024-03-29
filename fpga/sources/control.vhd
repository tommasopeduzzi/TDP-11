--------------------------------------------------------------------------------
-- File: control.vhd
--
-- Description: 
--
-- Control unit driving the control lines in the CPU.
--

-- Author: Tommaso Peduzzi
--
--------------------------------------------------------------------------------

LIBRARY IEEE;
LIBRARY work;

USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.instructions.ALL;

ENTITY CONTROL IS
    PORT (
        i_clk : IN STD_LOGIC;
        i_rst : IN STD_LOGIC;
        i_memdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- i_memdata data from memory
        i_z : IN STD_LOGIC; -- i_z flag
        i_l : IN STD_LOGIC; -- n flag
        i_c : IN STD_LOGIC; -- c flag

        i_interrupt_request : IN STD_LOGIC; -- interrupt request
        i_interrupt_bus : STD_LOGIC_VECTOR(3 DOWNTO 0); -- interrupt bus

        o_mem_we : OUT STD_LOGIC; -- write enable memory

        o_pc_inc : OUT STD_LOGIC; -- increment PC
        o_pc_load : OUT STD_LOGIC; -- load PC from main bus
        o_pc_load_lsb : OUT STD_LOGIC; -- load LSB of PC from main bus
        o_pc_load_msb : OUT STD_LOGIC; -- load MSB of PC from main bus

        o_sp_inc : OUT STD_LOGIC; -- increment SP
        o_sp_decr : OUT STD_LOGIC; -- decrement SP

        o_alu_op : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- ALU operation
        o_alu_latch_result : OUT STD_LOGIC; -- ALU latch result 

        o_reg_we : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- write enable registers
        o_reg_we_l : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- write enable LSB registers
        o_reg_we_m : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- write enable MSB registers

        -- main bus
        o_main_alu_sel : OUT STD_LOGIC; -- ALU select
        o_main_mem_sel : OUT STD_LOGIC; -- memory select
        o_main_control_sel : OUT STD_LOGIC; -- control select
        o_main_pc_sel : OUT STD_LOGIC; -- pc select
        o_main_pc_msb_sel : OUT STD_LOGIC; -- pc select msb
        o_main_reg_sel : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- register select
        o_main_reg_l_sel : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- register LSB select
        o_main_reg_m_sel : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- register MSB select

        -- address bus
        o_addr_pc_sel : OUT STD_LOGIC; -- PC select
        o_addr_sp_sel : OUT STD_LOGIC; -- SP select
        o_addr_reg_sel : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- register select
        o_addr_control_sel : OUT STD_LOGIC; -- control select
        o_addr_alu_sel : OUT STD_LOGIC; -- ALU select

        -- alu operand bus
        o_alu_rhs_sel : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- rhs select
        o_alu_rhs_control_sel : OUT STD_LOGIC; -- rhs control
        o_alu_lhs_sel : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- lhs select
        o_alu_lhs_control_sel : OUT STD_LOGIC; -- rhs control

        -- immediate output
        o_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- immediate output
        o_rhs_alu_imm : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- rhs output
        o_lhs_alu_imm : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- rhs output

        -- device outputs
        o_device_read : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- device read output
        o_device_write : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- device write output
    );
END CONTROL;
ARCHITECTURE ARCHITECTURE_CONTROL OF CONTROL IS
    SIGNAL s_step : NATURAL := 0;
    SIGNAL s_opcode : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_op1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_op2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_imm : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_interrupt_request : STD_LOGIC := '0';
    SIGNAL s_interrupt : STD_LOGIC := '0';

    FUNCTION OP_TO_REG(op : IN STD_LOGIC_VECTOR(3 DOWNTO 0))
        RETURN STD_LOGIC_VECTOR IS
        VARIABLE value : STD_LOGIC_VECTOR(7 DOWNTO 0);
    BEGIN
        value := (OTHERS => '0');
        value(to_integer(unsigned(op(2 DOWNTO 0)))) := '1';
        RETURN value;
    END FUNCTION;
BEGIN

    s_interrupt_request <= '1' WHEN rising_edge(i_interrupt_request) ELSE
        '0' WHEN rising_edge(s_interrupt);

    PROCESS (i_clk, i_rst) BEGIN
        IF i_rst = '1' THEN
            s_step <= 0;
            s_opcode <= (OTHERS => '0');
            s_op1 <= (OTHERS => '0');
            s_op2 <= (OTHERS => '0');
            s_imm <= (OTHERS => '0');
        ELSIF falling_edge(i_clk) THEN
            -- reset control lines
            o_mem_we <= '0';
            o_pc_inc <= '0';
            o_pc_load <= '0';
            o_pc_load_lsb <= '0';
            o_pc_load_msb <= '0';
            o_sp_inc <= '0';
            o_sp_decr <= '0';
            o_alu_op <= (OTHERS => '0');
            o_reg_we <= (OTHERS => 'X');
            o_reg_we_l <= (OTHERS => 'X');
            o_reg_we_m <= (OTHERS => 'X');
            o_main_alu_sel <= '0';
            o_main_mem_sel <= '0';
            o_main_control_sel <= '0';
            o_main_pc_sel <= '0';
            o_main_pc_msb_sel <= '0';
            o_main_reg_sel <= (OTHERS => 'X');
            o_main_reg_l_sel <= (OTHERS => 'X');
            o_main_reg_m_sel <= (OTHERS => 'X');
            o_addr_pc_sel <= '0';
            o_addr_sp_sel <= '0';
            o_addr_control_sel <= '0';
            o_addr_alu_sel <= '1';
            o_addr_reg_sel <= (OTHERS => 'X');
            o_alu_rhs_sel <= (OTHERS => 'X');
            o_alu_lhs_sel <= (OTHERS => 'X');
            o_alu_rhs_control_sel <= '0';
            o_alu_lhs_control_sel <= '0';
            o_alu_latch_result <= '0';
            o_device_write <= (OTHERS => 'X');
            o_device_read <= (OTHERS => 'X');

            -- set appropriate control lines
            IF s_opcode = "111111" THEN -- halt
                CASE s_step IS
                    WHEN 0 =>
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = nop THEN -- nop
                IF s_interrupt = '0' THEN
                    IF s_interrupt_request = '1' THEN
                        o_data <= "01111111111" & i_interrupt_bus & "0";
                        o_addr_control_sel <= '1';
                    ELSE
                        o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    END IF;
                ELSE
                    CASE s_step IS
                        WHEN 1 => o_data <= "01111111111" & i_interrupt_bus & "1";
                            o_addr_control_sel <= '1';
                        WHEN 2 => o_addr_sp_sel <= '1';
                            o_sp_decr <= '1';
                            o_mem_we <= '1';
                            o_main_pc_msb_sel <= '1';
                        WHEN 3 => o_addr_sp_sel <= '1';
                            o_sp_decr <= '1';
                            o_mem_we <= '1';
                            o_main_pc_sel <= '1';
                        WHEN 4 => o_data <= s_imm;
                            o_main_control_sel <= '1';
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = set_reg_imm
                OR s_opcode = set_reg_addr THEN -- load-imm/load-addr reg imm
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_l <= OP_TO_REG(s_op1);
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_m <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = load8_reg_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_addr_control_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_l <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = load8_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_reg_sel <= s_op2(2 DOWNTO 0);
                        o_main_mem_sel <= '1';
                        o_reg_we_l <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = load_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_reg_sel <= s_op2(2 DOWNTO 0);
                        o_main_mem_sel <= '1';
                        o_reg_we_l <= OP_TO_REG(s_op1);
                        ----- calculate new adress
                        o_alu_latch_result <= '1';
                        o_alu_lhs_sel <= s_op2(2 DOWNTO 0);
                        o_rhs_alu_imm <= (0 => '1', OTHERS => '0');
                        o_alu_rhs_control_sel <= '1';
                        o_alu_op <= "0000";
                    WHEN 3 => o_addr_alu_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_m <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = load_reg_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_addr_control_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_l <= OP_TO_REG(s_op1);
                        ----- calculate new adress
                        o_alu_latch_result <= '1';
                        o_rhs_alu_imm <= (0 => '1', OTHERS => '0');
                        o_alu_rhs_control_sel <= '1';
                        o_alu_lhs_control_sel <= '1';
                        o_alu_op <= "0000";
                    WHEN 5 => o_addr_alu_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_m <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = store_reg_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_main_reg_l_sel <= s_op1(2 DOWNTO 0);
                        o_addr_control_sel <= '1';
                        o_mem_we <= '1';
                        ----- calculate new adress
                        o_alu_latch_result <= '1';
                        o_rhs_alu_imm <= (0 => '1', OTHERS => '0');
                        o_alu_rhs_control_sel <= '1';
                        o_alu_lhs_control_sel <= '1';
                        o_alu_op <= "0000";
                    WHEN 5 => o_addr_alu_sel <= '1';
                        o_main_reg_m_sel <= s_op1(2 DOWNTO 0);
                        o_mem_we <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = store_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_main_reg_l_sel <= s_op1(2 DOWNTO 0);
                        o_addr_reg_sel <= s_op2(2 DOWNTO 0);
                        o_mem_we <= '1';
                        ----- calculate new adress
                        o_alu_latch_result <= '1';
                        o_rhs_alu_imm <= (0 => '1', OTHERS => '0');
                        o_alu_rhs_control_sel <= '1';
                        o_alu_lhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_op <= "0000";
                    WHEN 3 => o_addr_alu_sel <= '1';
                        o_main_reg_m_sel <= s_op1(2 DOWNTO 0);
                        o_mem_we <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = storel_reg_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_main_reg_l_sel <= s_op1(2 DOWNTO 0);
                        o_addr_control_sel <= '1';
                        o_mem_we <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = storel_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_main_reg_l_sel <= s_op1(2 DOWNTO 0);
                        o_addr_reg_sel <= s_op2(2 DOWNTO 0);
                        o_mem_we <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = storeg_reg_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_main_reg_m_sel <= s_op1(2 DOWNTO 0);
                        o_addr_control_sel <= '1';
                        o_mem_we <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = storeg_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_main_reg_m_sel <= s_op1(2 DOWNTO 0);
                        o_addr_reg_sel <= s_op2(2 DOWNTO 0);
                        o_mem_we <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = copy_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_main_reg_sel <= s_op2(2 DOWNTO 0);
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = push_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_sp_sel <= '1';
                        o_sp_decr <= '1';
                        o_mem_we <= '1';
                        o_main_reg_m_sel <= s_op1(2 DOWNTO 0);
                    WHEN 3 => o_addr_sp_sel <= '1';
                        o_sp_decr <= '1';
                        o_mem_we <= '1';
                        o_main_reg_l_sel <= s_op1(2 DOWNTO 0);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = pop_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                        o_sp_inc <= '1';
                    WHEN 2 => o_addr_sp_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_sp_inc <= '1';
                        o_reg_we_l <= OP_TO_REG(s_op1);
                    WHEN 3 => o_addr_sp_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_reg_we_m <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = add_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0000";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = add_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_control_sel <= '1';
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0000";
                    WHEN 5 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = sub_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0001";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = sub_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_control_sel <= '1';
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0001";
                    WHEN 5 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = and_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0010";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = and_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_control_sel <= '1';
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0010";
                    WHEN 5 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = or_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0011";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = or_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_control_sel <= '1';
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0011";
                    WHEN 5 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = xor_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0100";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = xor_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_control_sel <= '1';
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0100";
                    WHEN 5 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = cmp_reg_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_sel <= s_op2(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0001";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = cmp_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 4 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_rhs_control_sel <= '1';
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0001";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = not_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0111";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = shiftl_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0101";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = shiftr_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_alu_lhs_sel <= s_op1(2 DOWNTO 0);
                        o_alu_latch_result <= '1';
                        o_alu_op <= "0110";
                    WHEN 3 => o_main_alu_sel <= '1';
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = jump_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_main_reg_sel <= s_op1(2 DOWNTO 0);
                        o_pc_load <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = jump_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_main_control_sel <= '1';
                        o_pc_load <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = jumpeq_reg THEN
                IF i_z = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_main_reg_sel <= s_op1(2 DOWNTO 0);
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpeq_addr THEN
                IF i_z = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 3 => o_main_control_sel <= '1';
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 1 => o_pc_inc <= '1';
                        WHEN 2 => o_pc_inc <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpg_reg THEN
                IF i_z = '0' AND i_l = '0' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_main_reg_sel <= s_op1(2 DOWNTO 0);
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpg_addr THEN
                IF i_z = '0' AND i_l = '0' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 3 => o_main_control_sel <= '1';
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 1 => o_pc_inc <= '1';
                        WHEN 2 => o_pc_inc <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpl_reg THEN
                IF i_l = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_main_reg_sel <= s_op1(2 DOWNTO 0);
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpl_addr THEN
                IF i_l = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 3 => o_main_control_sel <= '1';
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 1 => o_pc_inc <= '1';
                        WHEN 2 => o_pc_inc <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpc_reg THEN
                IF i_c = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_main_reg_sel <= s_op1(2 DOWNTO 0);
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpc_addr THEN
                IF i_c = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 2 => o_addr_pc_sel <= '1';
                            o_pc_inc <= '1';
                        WHEN 3 => o_main_control_sel <= '1';
                            o_pc_load <= '1';
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 1 => o_pc_inc <= '1';
                        WHEN 2 => o_pc_inc <= '1';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = call_addr THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 3 => o_addr_sp_sel <= '1';
                        o_sp_decr <= '1';
                        o_mem_we <= '1';
                        o_main_pc_msb_sel <= '1';
                    WHEN 4 => o_addr_sp_sel <= '1';
                        o_sp_decr <= '1';
                        o_mem_we <= '1';
                        o_main_pc_sel <= '1';
                    WHEN 5 => o_main_control_sel <= '1';
                        o_pc_load <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = ret THEN
                CASE s_step IS
                    WHEN 1 => o_sp_inc <= '1';
                    WHEN 2 => o_addr_sp_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_sp_inc <= '1';
                        o_pc_load_lsb <= '1';
                    WHEN 3 => o_addr_sp_sel <= '1';
                        o_main_mem_sel <= '1';
                        o_pc_load_msb <= '1';
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = in_reg_dev THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_device_write <= s_op2;
                        o_reg_we <= OP_TO_REG(s_op1);
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = out_dev_reg THEN
                CASE s_step IS
                    WHEN 1 => o_addr_pc_sel <= '1';
                        o_pc_inc <= '1';
                    WHEN 2 => o_device_read <= s_op1;
                        o_main_reg_sel <= s_op2(2 DOWNTO 0);
                    WHEN OTHERS =>
                END CASE;
            END IF;
        ELSIF rising_edge(i_clk) THEN
            -- set internal signals
            s_step <= s_step + 1;

            IF s_opcode = nop THEN
                IF s_interrupt = '0' THEN
                    s_step <= 1;
                    IF s_interrupt_request = '1' THEN
                        s_interrupt <= '1';
                        s_imm(7 DOWNTO 0) <= i_memdata;
                    ELSE
                        s_opcode <= i_memdata(5 DOWNTO 0);
                    END IF;
                ELSE
                    CASE s_step IS
                        WHEN 1 => s_imm(15 DOWNTO 8) <= i_memdata;
                        WHEN 4 => s_opcode <= "000000";
                            s_interrupt <= '0';
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = cmp_reg_reg
                OR s_opcode = copy_reg_reg
                OR s_opcode = load8_reg_reg
                OR s_opcode = storel_reg_reg
                OR s_opcode = storeg_reg_reg
                OR s_opcode = in_reg_dev
                OR s_opcode = out_dev_reg THEN
                CASE s_step IS
                    WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                        s_op2 <= i_memdata(3 DOWNTO 0);
                    WHEN 2 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = set_reg_imm
                OR s_opcode = set_reg_addr
                OR s_opcode = add_reg_reg
                OR s_opcode = sub_reg_reg
                OR s_opcode = and_reg_reg
                OR s_opcode = or_reg_reg
                OR s_opcode = xor_reg_reg
                OR s_opcode = not_reg
                OR s_opcode = shiftl_reg
                OR s_opcode = shiftr_reg
                OR s_opcode = load_reg_reg
                OR s_opcode = store_reg_reg
                OR s_opcode = not_reg
                OR s_opcode = shiftl_reg
                OR s_opcode = shiftr_reg
                OR s_opcode = storel_reg_reg
                OR s_opcode = storeg_reg_reg
                OR s_opcode = push_reg
                OR s_opcode = pop_reg THEN
                CASE s_step IS
                    WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                        s_op2 <= i_memdata(3 DOWNTO 0);
                    WHEN 3 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = load8_reg_addr
                OR s_opcode = storel_reg_addr
                OR s_opcode = storeg_reg_addr
                OR s_opcode = cmp_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                    WHEN 2 => o_data(7 DOWNTO 0) <= i_memdata;
                        o_lhs_alu_imm(7 DOWNTO 0) <= i_memdata;
                        o_rhs_alu_imm(7 DOWNTO 0) <= i_memdata;
                    WHEN 3 => o_data(15 DOWNTO 8) <= i_memdata;
                        o_lhs_alu_imm(15 DOWNTO 8) <= i_memdata;
                        o_rhs_alu_imm(15 DOWNTO 8) <= i_memdata;
                    WHEN 4 => s_opcode <= (OTHERS => '0');
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = load_reg_addr
                OR s_opcode = store_reg_addr
                OR s_opcode = add_reg_imm
                OR s_opcode = sub_reg_imm
                OR s_opcode = and_reg_imm
                OR s_opcode = or_reg_imm
                OR s_opcode = xor_reg_imm THEN
                CASE s_step IS
                    WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                        s_op2 <= i_memdata(3 DOWNTO 0);
                    WHEN 2 => o_data(7 DOWNTO 0) <= i_memdata;
                        o_lhs_alu_imm(7 DOWNTO 0) <= i_memdata;
                    WHEN 3 => o_data(15 DOWNTO 8) <= i_memdata;
                        o_lhs_alu_imm(15 DOWNTO 8) <= i_memdata;
                    WHEN 5 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = jump_reg THEN
                CASE s_step IS
                    WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                        s_op2 <= i_memdata(3 DOWNTO 0);
                    WHEN 2 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = jump_addr THEN
                CASE s_step IS
                    WHEN 1 => o_data(7 DOWNTO 0) <= i_memdata;
                    WHEN 2 => o_data(15 DOWNTO 8) <= i_memdata;
                    WHEN 3 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = jumpeq_reg THEN
                IF i_z = '1' THEN
                    CASE s_step IS
                        WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                            s_op2 <= i_memdata(3 DOWNTO 0);
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpeq_addr THEN
                IF i_z = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_data(7 DOWNTO 0) <= i_memdata;
                        WHEN 2 => o_data(15 DOWNTO 8) <= i_memdata;
                        WHEN 3 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpg_reg THEN
                IF i_z = '0' AND i_l = '0' THEN
                    CASE s_step IS
                        WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                            s_op2 <= i_memdata(3 DOWNTO 0);
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpg_addr THEN
                IF i_z = '0' AND i_l = '0' THEN
                    CASE s_step IS
                        WHEN 1 => o_data(7 DOWNTO 0) <= i_memdata;
                        WHEN 2 => o_data(15 DOWNTO 8) <= i_memdata;
                        WHEN 3 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpl_reg THEN
                IF i_l = '1' THEN
                    CASE s_step IS
                        WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                            s_op2 <= i_memdata(3 DOWNTO 0);
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpl_addr THEN
                IF i_l = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_data(7 DOWNTO 0) <= i_memdata;
                        WHEN 2 => o_data(15 DOWNTO 8) <= i_memdata;
                        WHEN 3 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpc_reg THEN
                IF i_c = '1' THEN
                    CASE s_step IS
                        WHEN 1 => s_op1 <= i_memdata(7 DOWNTO 4);
                            s_op2 <= i_memdata(3 DOWNTO 0);
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = jumpc_addr THEN
                IF i_c = '1' THEN
                    CASE s_step IS
                        WHEN 1 => o_data(7 DOWNTO 0) <= i_memdata;
                        WHEN 2 => o_data(15 DOWNTO 8) <= i_memdata;
                        WHEN 3 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                ELSE
                    CASE s_step IS
                        WHEN 2 => s_opcode <= "000000";
                        WHEN OTHERS =>
                    END CASE;
                END IF;
            ELSIF s_opcode = call_addr THEN
                CASE s_step IS
                    WHEN 1 => o_data(7 DOWNTO 0) <= i_memdata;
                    WHEN 2 => o_data(15 DOWNTO 8) <= i_memdata;
                    WHEN 5 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSIF s_opcode = ret THEN
                CASE s_step IS
                    WHEN 3 => s_opcode <= "000000";
                    WHEN OTHERS =>
                END CASE;
            ELSE
                REPORT "unknown instruction";
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE_CONTROL;