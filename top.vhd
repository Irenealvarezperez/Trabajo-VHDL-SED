
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    generic (num_entradas:positive:=4);
    port(
        entradas: in std_logic_vector (num_entradas -1 downto 0);
        boton: in std_logic;--botón inicio
        reloj: in std_logic;
        reset_n: in std_logic --asíncrono
    );
end top;

architecture Behavioral of top is

    --Generales
    constant long_opcion: positive:=3;
    signal clk: std_logic;
    signal boton_inicio: std_logic;
    signal sinc_detector: std_logic;
    signal detector_fsm1: std_logic;
    signal reset_global: std_logic;
    --fsm1
    signal modos: std_logic_vector (0 to 1);
    signal sel_leche: std_logic;
    signal sel_azucar: std_logic;
    signal modo_display: std_logic_vector (1 downto 0);----deberian ser 3
    signal tiempo_display: string (1 downto 0); --no entiendo esta signal
    signal led_encendida: std_logic;
    signal led_bomba: std_logic;
    signal led_leche: std_logic;
    signal param: std_logic;
    signal start: std_logic;
    signal done: std_logic;
    --Decodificador
    signal seleccion: std_logic_vector(long_opcion -1 downto 0);
    signal salida_disp0: std_logic_vector (6 downto 0);
    signal salida_disp1: std_logic_vector (6 downto 0);
    signal salida_disp2: std_logic_vector (6 downto 0);
    signal salida_disp3: std_logic_vector (6 downto 0);
    signal salida_disp4: std_logic_vector (6 downto 0);
    signal salida_disp5: std_logic_vector (6 downto 0);
    signal salida_disp6: std_logic_vector (6 downto 0);
    signal salida_disp7: std_logic_vector (6 downto 0);

    component detector_flanco
        port (
            CLK : in std_logic;
            EDGE_IN : in std_logic;
            EDGE_OUT : out std_logic
        );
    end component;

    component sincronizador
        PORT (
            CLK : in std_logic;
            SYNC_IN : in std_logic;
            SYNC_OUT : out std_logic
        );
    end component;
    component fsm1
        port (
            RESET : in std_logic;
            CLK : in std_logic;
            EDGE : in std_logic;
            --Añadir contadores o temporizadores (?)
            MODOS : in std_logic_vector(0 TO 1);
            SEL_LECHE: in std_logic;
            SEL_AZUCAR: in std_logic;
            MODO_DISPLAY: out std_logic_vector(1 downto 0); --salida para indicarle al display que enseñe el modo
            TIEMPO_DISPLAY: out string(1 downto 0);
            LED_ENCENDIDA: out std_logic;
            LED_BOMBA: out std_logic;
            LED_LECHE: out std_logic;
            --Salidas para la esclava
            PARAM: out std_logic;
            START: out std_logic;
            DONE: out std_logic
        );
    end component;
    component decodificador
        PORT (
            seleccion : IN std_logic_vector(long_opcion -1 DOWNTO 0);
            salida_disp0 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp1: OUT std_logic_vector(6 DOWNTO 0);
            salida_disp2 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp3 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp4 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp5 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp6 : OUT std_logic_vector(6 DOWNTO 0);
            salida_disp7 : OUT std_logic_vector(6 DOWNTO 0)
        );
    end component;

begin
    Inst_sincronizador: sincronizador port map(
            CLK => clk,
            SYNC_IN => boton_inicio,
            SYNC_OUT => sinc_detector
        );
    Inst_detector_flanco: detector_flanco port map(
            CLK =>clk,
            EDGE_IN =>sinc_detector,
            EDGE_OUT =>detector_fsm1
        );
    Inst_fsm1: fsm1 port map(
            RESET => reset_global,
            CLK => clk,
            EDGE => detector_fsm1,
            MODOS => modos,
            SEL_LECHE => sel_leche,
            SEL_AZUCAR => sel_azucar,
            MODO_DISPLAY => modo_display,
            TIEMPO_DISPLAY => tiempo_display,
            LED_ENCENDIDA =>led_encendida,
            LED_BOMBA => led_bomba,
            LED_LECHE => led_leche,
            PARAM => param,
            START => start,
            DONE =>done
        );
    Inst_decodificador: decodificador port map(
 seleccion => seleccion,
        salida_disp0 => salida_disp0,
        salida_disp1 => salida_disp1,
        salida_disp2 => salida_disp2,
        salida_disp3 => salida_disp3,
        salida_disp4 => salida_disp4,
        salida_disp5 => salida_disp5,
        salida_disp6 => salida_disp6,
        salida_disp7 => salida_disp7
 );
end Behavioral;
