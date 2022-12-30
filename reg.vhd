library ieee;
use ieee.std_logic_1164.all;

entity reg is

	port(
		clk		:	in	std_logic;							-- Sinal de Clock
		rst		:	in	std_logic;							-- Reset
		data	:	in	std_logic_vector(31 downto 0);	-- Entrada de dados
		q		:	out	std_logic_vector(31 downto 0)	-- Saida de dados

	);
end reg;

architecture behavioral of reg is
begin
	
	process(rst, clk, data)
	begin
		
		-- Reset if rst = 1
		if rst = '1' then
			q <= (others => '0');
		elsif rising_edge(clk) then 
			q <= data;
		end if;
		
	end process;
	
end behavioral; 