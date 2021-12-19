----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2021 17:20:54
-- Design Name: 
-- Module Name: fsm_esclava_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_esclava_tb is
--  Port ( );
end fsm_esclava_tb;

architecture tb of fsm_esclava_tb is
component fsm_esclava is
port(
    CLK     : in std_logic; --señal de reloj
    RESET   : in std_logic; --reset activo a nivel alto
    START   : in std_logic; -- señal de inicio
    DELAY   : in unsigned (7 downto 0); -- tiempo de espera
    DONE    : out std_logic --señal de fin
);
    end component;
  signal clk     : std_logic := '0';
  signal reset   : std_logic;
  signal start : std_logic;
  signal delay: unsigned (7 downto 0);
  signal done : std_logic;
  constant CLK_PERIOD : time := 10 ns; 
begin
  uut: fsm_esclava
    port map (
      clk   => clk,
      Reset => reset,
      start => start,
      delay => delay,
      done  => done
    );
 clk <= not clk after 0.5 * CLK_PERIOD;
 reset<='0' after 0.25 *CLK_PERIOD, '1' after 0.75*CLK_PERIOD;
 
 stimuli:process
 begin
 start<='0';
 delay<=(others=>'0');
 wait until reset='1';
 start<='1';
 wait for CLK_PERIOD*2;
 delay<=to_unsigned(5-2, delay'length);
wait for CLK_PERIOD;
 start<='0';
 delay<=(others=>'0');

 


 wait for 100*CLK_PERIOD;
  	assert false
  	report "[SUCCESS]: Simulation finished."
  	severity failure ;
 end process;
end tb;
