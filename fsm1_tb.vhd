----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2021 12:03:03
-- Design Name: 
-- Module Name: fsm1_tb - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm1_tb is
end fsm1_tb;

architecture tb of fsm1_tb is

    component fsm1
        port (
            RESET : in std_logic;
            CLK : in std_logic;
            EDGE : in std_logic;
            --Añadir contadores o temporizadores (?)
            MODOS : in std_logic_vector(0 TO 1);
            SEL_LECHE: in std_logic;
            SEL_AZUCAR: in std_logic;
            SEL_OKEY: in std_logic;
            MODO_DISPLAY: out std_logic_vector(2 downto 0); --salida para indicarle al display el modo
            --  TIEMPO_DISPLAY: out string(1 downto 0);
            LED_ENCENDIDA: out std_logic;
            LED_BOMBA: out std_logic;
            LED_LECHE: out std_logic;
            LED_AZUCAR: out std_logic;
            --Salidas para la esclava
            --  PARAM: out std_logic;
            START: out std_logic;
            DONE: in std_logic;
            DELAY : out unsigned (7 downto 0)
        );
    end component;

    signal SEL_LECHE           : std_logic;
    signal SEL_AZUCAR       : std_logic;
    signal SEL_OKEY: std_logic;
    signal EDGE          : std_logic;
    signal RESET         : std_logic;
    signal CLK           : std_logic := '0';
    signal MODOS    :  std_logic_vector(0 TO 1);
    -- signal TIEMPO_DISPLAY : string( 1 downto 0);
    signal  MODO_DISPLAY : std_logic_vector(2 downto 0);
    signal  DONE:  std_logic;
    signal LED_LECHE           : std_logic;
    signal LED_BOMBA          : std_logic;
    signal LED_ENCENDIDA          : std_logic;
    signal LED_AZUCAR        : std_logic;
    signal START       : std_logic;
    signal delay :  unsigned (7 downto 0);
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: fsm1
        port map (
            SEL_LECHE => SEL_LECHE,
            EDGE => EDGE,
            SEL_AZUCAR => SEL_AZUCAR,
            SEL_OKEY => SEL_OKEY,
            RESET => RESET,
            CLK => CLK,
            MODOS => MODOS,
            LED_LECHE => LED_LECHE,
            LED_AZUCAR => LED_AZUCAR,
            LED_BOMBA => LED_BOMBA,
            LED_ENCENDIDA => LED_ENCENDIDA,
            START=>START,
            --    TIEMPO_DISPLAY => TIEMPO_DISPLAY,
            MODO_DISPLAY => MODO_DISPLAY,
            DELAY=>DELAY,
            DONE => done
            
        );

    -- Clock generation
    CLK <= not CLK after 0.5 * CLK_PERIOD;

    stimuli: process
    begin
        -- Reset generation
        RESET <= '0' after 0.25 * CLK_PERIOD, '1' after 0.75 * CLK_PERIOD;
        wait until RESET = '1';

        -- Inputs initialization
        SEL_LECHE <= '0';
        SEL_AZUCAR <= '0';
        EDGE <= '0';
        RESET <= '1';
        MODOS <= "00";

        -- ???
        wait for 5 * CLK_PERIOD;
        EDGE <= '1';
        wait for 12.5 * CLK_PERIOD;
        DONE<='1';
        wait for CLK_PERIOD;
        DONE<='0';
        wait for 5 * CLK_PERIOD;
        SEL_AZUCAR <= '1';
        wait for 5 * CLK_PERIOD;
        DONE<= '1';
        wait for CLK_PERIOD;
        DONE<='0';
        wait for 5 * CLK_PERIOD;
        MODOS <= "01";
        wait for 3*CLK_PERIOD;
        SEL_OKEY<='1';
 
        wait for 5 * CLK_PERIOD;
        DONE <= '1';
        wait for CLK_PERIOD;
        DONE<='0';
        wait for 5 * CLK_PERIOD;
        SEL_LECHE <= '1';
        wait for 5 * CLK_PERIOD;
        DONE<= '1';
        wait for CLK_PERIOD;
        DONE<='0';


        -- EDIT Add stimuli here
        wait for 100 * CLK_PERIOD;

        -- Stop the clock and hence terminate the simulation
        assert false
        report "[EXITO]: Simulacion finalizada."
        severity failure;
    end process;
end tb;