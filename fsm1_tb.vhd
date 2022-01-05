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
            sensor: in std_logic;
            MODO_DISPLAY: out std_logic_vector(3 downto 0); --salida para indicarle al display el modo
            --TIEMPO_DISPLAY: out string(1 downto 0);
            LED_ENCENDIDA: out std_logic;
            LED_BOMBA: out std_logic;
            LED_LECHE: out std_logic;
            LED_AZUCAR: out std_logic;
            --Salidas para la esclava
            --PARAM: out std_logic;
            START: out std_logic;
            DONE: in std_logic
        );
    end component;

    signal SEL_LECHE: std_logic;
    signal SEL_AZUCAR: std_logic;
    signal EDGE: std_logic;
    signal RESET: std_logic;
    signal CLK : std_logic := '0';
    signal done:std_logic;
    signal start:std_logic;
    signal sensor:std_logic;
    signal led_azucar:std_logic;
    signal led_leche:std_logic;
    signal led_bomba:std_logic;
    signal led_encendida:std_logic;
    signal MODOS    :  std_logic_vector(0 TO 1);
    --signal TIEMPO_DISPLAY : string( 1 downto 0);
    signal  MODO_DISPLAY : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 20 ns;

begin

    uut: fsm1
        port map (
            SEL_LECHE => SEL_LECHE,
            EDGE => EDGE,
            SEL_AZUCAR => SEL_AZUCAR,
            RESET => RESET,
            CLK => CLK,
            MODOS => MODOS,
            --TIEMPO_DISPLAY => TIEMPO_DISPLAY,
            MODO_DISPLAY => MODO_DISPLAY,
            done=>done,
            led_azucar=>led_azucar,
            led_leche=> led_leche,
            led_bomba=> led_bomba,
            led_encendida=> led_encendida,
            start=> start,
            sensor=> sensor

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
        MODOS <= "00";
        start<='0';
        done<='0';
        sensor<='0';

        --Estado 0
        wait for CLK_PERIOD;
        EDGE<= '1';
        wait for 3*CLK_PERIOD;
        edge<='0';
        --Paso a estado 1
        done<= '1';
        wait for 2*CLK_PERIOD;
        done<= '0';
        --Paso a estado 2
        wait for 2*CLK_PERIOD;
        SEL_AZUCAR <= '1';
        wait for 2*CLK_PERIOD;
        done<= '1';
        wait for 2*CLK_PERIOD;
        done<= '0';
        --Paso a estado 3  
        wait for 2*CLK_PERIOD;
        MODOS <= "01";
        wait for 2*CLK_PERIOD;
        done<='1';
        wait for CLK_PERIOD;
        done<='0';
        sensor<='1';
        --Paso a estado 4
        wait for 2*CLK_PERIOD;
        sensor<='0';
        wait for 2*CLK_PERIOD;
        done<='1';
        wait for 2*CLK_PERIOD;
        done<= '0';
        --Paso a estado 5
        wait for 5*CLK_PERIOD;
        sel_leche<='1';
        wait for CLK_PERIOD;
        sensor<='1';
        wait for 2*CLK_PERIOD;
        --Paso a estado 6
        wait for 2*CLK_PERIOD;
        done<='1';
        wait for 2*CLK_PERIOD;
        done<= '0';
        wait for 6*CLK_PERIOD;


        -- Stop the clock and hence terminate the simulation
        assert false
        report "[EXITO]: Simulacion finalizada."
        severity failure;
    end process;
end tb;