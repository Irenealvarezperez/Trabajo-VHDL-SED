
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity visualizar_display is
    Port (
        clk : in  STD_LOGIC;
        salida_disp0 : IN std_logic_vector(6 downto 0);
        salida_disp1 : in std_logic_vector(6 downto 0);
        salida_disp2: IN std_logic_vector(6 downto 0);
        salida_disp3 : IN std_logic_vector(6 downto 0);
        salida_disp4 : IN std_logic_vector(6 downto 0);
        salida_disp5 : IN std_logic_vector(6 downto 0);
        salida_disp6 : IN std_logic_vector(6 downto 0);
        salida_disp7 : IN std_logic_vector(6 downto 0);
        numero_display: out  STD_LOGIC_VECTOR (6 downto 0);
        seleccion_display : out  STD_LOGIC_VECTOR (7 downto 0)

    );
end visualizar_display;

architecture Behavioral of visualizar_display is
begin
    process (clk, salida_disp0, salida_disp1,salida_disp2, salida_disp3)
        variable cuenta:integer range 0 to 7;
    begin
        if (clk'event and clk='1' ) then --flanco ascendente
            if cuenta=7 then
                cuenta:=0;
            else
                cuenta:=cuenta+1;
            end if;
        end if;

        case cuenta is
            when 0 => seleccion_display<="11111110";--Activa display 0
                numero_display<=salida_disp0;

            when 1 => seleccion_display<="11111101";--Activa display 1
                numero_display<=salida_disp1;

            when 2 => seleccion_display<="11111011";--Activa display 2
                numero_display<=salida_disp2;

            when 3 => seleccion_display<="11110111";--Activa display 3
                numero_display<=salida_disp3;

            when 4 => seleccion_display<="11101111";--Activa display 4
                numero_display<=salida_disp4;

            when 5 => seleccion_display<="11011111";--Activa display 5
                numero_display<=salida_disp5;

            when 6 => seleccion_display<="10111111";--Activa display 6
                numero_display<=salida_disp6;

            when 7 => seleccion_display<="01111111";--Activa display 7
                numero_display<=salida_disp7;
        end case;

    end process;

end Behavioral;
