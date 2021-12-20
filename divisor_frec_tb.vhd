----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2021 19:56:04
-- Design Name: 
-- Module Name: divisor_frec_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisor_frec_tb is
    --  Port ( );
end divisor_frec_tb;

architecture Behavioral of divisor_frec_tb is
    signal Reset: std_logic;
    signal CLK_in: std_logic;
    signal CLK_out: std_logic;
    component divisor_frec is
        port (
            clk_in : in  std_logic; -- 100 MHz
            reset : in  std_logic;
            clk_out : out  std_logic
        );
    end component;
    constant k: time := 10 ns;
begin
    uut: divisor_frec port map (reset, CLK_in,CLK_out);

    Reset <= '1' after 0.25 * k, '0' after 0.75 * k;

    p0: process
    begin
        CLK_in <= '0';
        wait for 0.5 * k;
        CLK_in<= '1';
        wait for 0.5 * k;
    end process;

    p1: process
    begin
        wait;
    end process;

end Behavioral;
