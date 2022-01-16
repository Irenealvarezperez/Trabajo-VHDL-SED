
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_frec is
    generic ( 
       freq: integer :=50000
    );
    port (
        clk_in : in  std_logic; -- 100 MHz
        reset : in  std_logic;
        clk_out : out  std_logic
    );
end;

architecture Behavioral of divisor_frec is

    signal count: integer range 1 to freq;
    signal clk_out_i: std_logic := '0';

BEGIN
    frequency_divider: process (clk_in , reset)
    BEGIN
        if reset = '0' then
            count <= 1;
            clk_out_i <= '0';
        elsif clk_in'event and clk_in = '1' then
            if (count = freq) then
                count <= 1;
                clk_out_i <= not (clk_out_i);
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_out_i ;

end Behavioral;

