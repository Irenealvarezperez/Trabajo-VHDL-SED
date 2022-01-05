----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2021 20:02:13
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
    --  Port ( );
end top_tb;


architecture Behavioral of top_tb is
    constant num_entradas:positive:=2;
    constant periodo_reloj: time := 10 ns;
    signal entradas: std_logic_vector (num_entradas -1 downto 0);
    signal sel_leche: std_logic;
    signal sel_azucar: std_logic;
    signal sensor: std_logic;
    signal boton_inicio: std_logic;
    signal clk_entrada: std_logic;
    signal reset_global: std_logic;
    --signal segment: std_logic_vector(7 downto 0);
    signal led_leche: std_logic;
    signal led_azucar: std_logic;
    signal led_bomba: std_logic;
    signal led_encendida: std_logic;
    --signal digctrl: std_logic_vector(7 downto 0);
    signal numero_display: std_logic_vector(6 downto 0);
    signal seleccion_display: std_logic_vector(7 downto 0);

    component top is
        port(
            entradas: in std_logic_vector (num_entradas -1 downto 0);
            sel_leche: in std_logic;
            sel_azucar: in std_logic;
            sensor: in std_logic;
            boton_inicio: in std_logic;--botón inicio
            clk_entrada: in std_logic;
            reset_global: in std_logic; --asíncrono
            -- segment: out std_logic_vector (7 downto 0);
            led_leche: out std_logic;
            led_azucar: out std_logic;
            led_bomba: out std_logic;
            led_encendida: out std_logic;
            -- digctrl : out std_logic_vector(7 downto 0);
            numero_display: out std_logic_vector(6 downto 0);
            seleccion_display : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    uut:top port map(
            entradas=>entradas,
            sel_leche=> sel_leche,
            sel_azucar=>sel_azucar,
            sensor=>sensor,
            boton_inicio=>boton_inicio,
            clk_entrada => clk_entrada,
            reset_global => reset_global,
            --segment=> segment,
            led_leche => led_leche,
            led_azucar=> led_azucar,
            led_bomba => led_bomba,
            led_encendida => led_encendida,
            -- digctrl=> digctrl,
            numero_display=> numero_display,
            seleccion_display => seleccion_display
        );
    reloj:process
    begin
        clk_entrada<='0';--Cambiar formato
        wait for 2*periodo_reloj;
        clk_entrada<='1';
        wait for 2*periodo_reloj;
    end process;

    reset_global<='1','0' after periodo_reloj;
    funcionamiento:process
    begin
        wait for 2*periodo_reloj;
        boton_inicio<='1';
        wait for 2*periodo_reloj;
        boton_inicio<='0';
        wait for 25*periodo_reloj;
        sel_azucar<='1';
        wait for 25*periodo_reloj;
        sensor<='1';
        wait for periodo_reloj;
        entradas<="10";
        wait for periodo_reloj;
    end process;

end Behavioral;
