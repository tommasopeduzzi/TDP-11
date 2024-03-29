--------------------------------------------------------------------------------
-- File: pc.vhd
-- File history:
--      26.06.2022: Initial version
--
-- Description: 
--
-- Program counter module with ability to i_load arbitrary address, o_data 
--

-- Author: Tommaso Peduzzi (@tommasopeduzzi)
--
--------------------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PC IS
    PORT (
        i_clk : IN STD_LOGIC; -- clock
        i_rst : IN STD_LOGIC; -- reset
        i_inc : IN STD_LOGIC; -- increase program counter
        i_load : IN STD_LOGIC; -- i_load program counter
        i_load_lsb : IN STD_LOGIC; -- load lsb
        i_load_msb : IN STD_LOGIC; -- load msb
        i_data : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- input data
        o_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) -- o_data
    );
END PC;
ARCHITECTURE ARCHITECTURE_PC OF PC IS
    SIGNAL s_value : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    PROCESS (i_clk, i_rst) BEGIN
        IF i_rst = '1' THEN
            s_value <= (OTHERS => '0');
            o_data <= (OTHERS => '0');
        ELSIF rising_edge(i_clk) THEN
            IF i_inc = '1' THEN
                s_value <= STD_LOGIC_VECTOR(unsigned(s_value) + 1);
            ELSIF i_load = '1' THEN
                s_value <= i_data;
            ELSIF i_load_lsb = '1' THEN
                s_value(7 DOWNTO 0) <= i_data(7 DOWNTO 0);
            ELSIF i_load_msb = '1' THEN
                s_value(15 DOWNTO 8) <= i_data(7 DOWNTO 0);
            END IF;
        END IF;
        o_data <= s_value;
    END PROCESS;
END ARCHITECTURE_PC;