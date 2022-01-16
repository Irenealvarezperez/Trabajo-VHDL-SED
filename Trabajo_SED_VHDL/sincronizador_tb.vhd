----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 10:13:18
-- Design Name: 
-- Module Name: sincronizador_tb - Behavioral
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

ENTITY sincronizador_tb IS
END sincronizador_tb;
ARCHITECTURE tb OF sincronizador_tb IS
 procedure espera_ticks(ticks : positive; signal clk : std_logic) is
    begin
        for i in 1 to ticks loop
            wait until clk = '1';
        end loop;
    end procedure;
    
component sincronizador
 port (CLK : in std_logic;
              SYNC_IN  : in std_logic;
              SYNC_OUT : out std_logic);
    end component;
    
 signal CLK : std_logic := '0';
    signal SYNC_IN  : std_logic;
    signal SYNC_OUT : std_logic;
constant CLK_PERIOD : time := 10 ns;

begin
    --Unit Under Test
    uut: sincronizador
        port map (
            CLK      => CLK,
            SYNC_IN  => SYNC_IN,
            SYNC_OUT => SYNC_OUT
            
        );
        
    clkgen: clk <= not CLK after 0.5 * CLK_PERIOD;

    stimuligen: process
    begin
        wait for 0.25 * CLK_PERIOD;
        SYNC_IN <= '0';
        espera_ticks(6, CLK);
        
        wait for 0.25 * CLK_PERIOD;
        SYNC_IN <= '1';
        espera_ticks(6, CLK);
        
        wait for 0.25 * CLK_PERIOD;
        SYNC_IN <= '0';
        espera_ticks(6, CLK);

        assert false  
           report "[EXITO]: Simulacion finalizada."    
           severity failure; 
    end process;
end tb;