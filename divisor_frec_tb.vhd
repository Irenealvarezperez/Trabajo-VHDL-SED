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
    signal Reset: std_logic :='0';
    signal CLK_in: std_logic:='0';
    signal CLK_out: std_logic;
    component divisor_frec is
    	generic ( 
	   freq : integer := 50000
	);
        port (
            clk_in : in  std_logic; -- 100 MHz
            reset : in  std_logic;
            clk_out : out  std_logic
        );
    end component;
    constant k: time := 10 ns;
begin
   uut_clk_divider: divisor_frec
	port map (
        clk_in => clk_in, -- 100 MHz
        reset => reset,
        clk_out => clk_out
    );

    clkgen_100MHz: process
    begin
        clk_in <= '0';
		wait for k/2;
		clk_in <= '1';
		wait for k/2;
    end process;
    
    stim_proc: process
    begin    

        reset <= '0';
        wait for 50 ns;
        reset <= '1';
        wait for 50 ns;
        reset <= '1'; 
        wait for 10 ns;
        wait for 2020 ms; -- tiempo simulacion 1 Hz
        --wait for 5200 us; -- tiempo simulacion 200 Hz
        
        assert false
        report "[SUCCESS: simulation finished]."
        severity failure;
    end process;

end Behavioral;
