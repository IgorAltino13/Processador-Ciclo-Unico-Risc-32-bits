library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mem_dados is 
	port(
		clk:in std_logic;
		endereco : in std_logic_vector(31 downto 0);
		conteudo: in std_logic_vector(31 downto 0);
		escrita: in std_logic;
		leitura: in std_logic;
		data: out std_logic_vector(31 downto 0)
	);
end entity;

architecture main_mem of mem_dados is
	type array_signal is array(63 downto 0) of std_logic_vector(7 downto 0);
	signal dado : array_signal := (others => (others => '0'));
	
	begin
	
		process(clk)
		begin
			if((rising_edge(clk)) and (escrita = '1')) then
				dado(to_integer(unsigned(endereco))) <= conteudo(7 downto 0);
				dado(to_integer(unsigned(endereco+1))) <= conteudo(15 downto 8);
				dado(to_integer(unsigned(endereco+2))) <= conteudo(23 downto 16);
				dado(to_integer(unsigned(endereco+3))) <= conteudo(31 downto 24);
			end if;
		end process;
	data <= (dado(to_integer(unsigned(endereco+3))) & dado(to_integer(unsigned(endereco+2))) & 
				dado(to_integer(unsigned(endereco+1))) & dado(to_integer(unsigned(endereco)))
	) when leitura = '1' else (others => '0');
end architecture;