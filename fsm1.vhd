----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 11:13:59
-- Design Name: 
-- Module Name: fsm1 - Behavioral
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

entity fsm1 is
port (
RESET : in std_logic;
 CLK : in std_logic;
 EDGE : in std_logic;
 --Añadir contadores o temporizadores (?)
 MODOS : in std_logic_vector(0 TO 1);
 DISPLAY1: out string(4 downto 1); --indica el modo en el que esta
 LED_BOMBA: out std_logic;
 LED_LECHE: out std_logic;
 PARAM: out std_logic;
 START: out std_logic;
 DONE: out std_logic
  );
end fsm1;

architecture Behavioral of fsm1 is
type STATES is (S0, S1, S2, S3, S4); 
-- estado 0 :espera  estado 1 :encendida 
-- estado 2: modo corto  estado 3: modo largo  estado 4: echar leche
signal current_state: STATES := S0; 
signal next_state: STATES;

begin
state_register: process (RESET, CLK)

begin

-- completar
end process;
end Behavioral;
