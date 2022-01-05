----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2021 12:05:10
-- Design Name: 
-- Module Name: fsm_esclava - Behavioral
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
use IEEE.numeric_std.all;

-- Implementamos un timer
entity fsm_esclava is
port(
    CLK     : in std_logic; --señal de reloj
    RESET   : in std_logic; --reset activo a nivel alto
    START   : in std_logic; -- señal de inicio
    DELAY   : in unsigned (14 downto 0); -- tiempo de espera
    DONE    : out std_logic --señal de fin
    --SEGUNDOS : out std_logic (7 downto 0) Posible señal para sacar 
);
end fsm_esclava;

architecture Behavioral of fsm_esclava is
  signal cuenta : unsigned (DELAY'range);
  -- signal tiempo_actual : unsigned (segundos'range);
begin
    process(RESET, CLK)
    begin
    if RESET = '0' then --si pulsamos el reset ponemos todo a 0
      cuenta <=(others => '0');
      --tiempo_actual <=(others => '0');
    elsif rising_edge(CLK) then
      if START ='1' then
        cuenta <= DELAY;
      elsif cuenta /= 0 then
        cuenta <= cuenta -1;
        --tiempo_actual<= tiempo_actual+1;
      end if;
    end if;
  end process; 
    DONE <= '1' when cuenta = 1 else '0';
    --Segundos <= std_logic_vector(tiempo_actual);    
end Behavioral;
