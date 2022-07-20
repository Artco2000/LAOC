library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_GPIO is
end entity tb_GPIO;

architecture teste of tb_GPIO is
    component GPIO
        port (
            -- genericos
            Clock           : std_logic;
            Reset           : std_logic;
            --sinais internos
            instrucao       : in std_logic_vector(0 to 7); --instrucao vinda do registrador especial
            Data            : in std_logic_vector(0 to 7); -- dados que serão utilizados para vários fins
            interrupt_flag  : out std_logic_vector(0 to 7);
            Data_read       : out std_logic_vector(0 to 7);
            Pins            : inout std_logic_vector(0 to 7)
        );
        end component;

    signal Clock, Reset : std_logic := '1';
    signal instrucao, Data, interrupt_flag, Data_read, Pins :std_logic_vector(0 to 7);
	 
begin

    teste_GPIO: GPIO
        port map(
            Clock          => Clock,      
            Reset          => Reset,
            --sinais internos
            instrucao       => instrucao,
            Data            => Data,
            interrupt_flag  => interrupt_flag,
            Data_read       => Data_read,
            Pins            => Pins
        );

    Clock <= not Clock after 10 ns;
    Reset <= '1', '0' after 50 ns;

    instrucao <= x"03", x"04" after 70 ns, x"02" after 90 ns; --Int enable, Dir enable, write data
    Data <= x"FF", x"F0" after 70 ns, x"AF" after 90 ns; -- todas int, metade é saida, escreve A na saida, F é ignorado
    
    
end architecture teste;