
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mem_instrucao is
	port(
		endereco : in std_logic_vector(31 downto 0);
		instrucao	: out std_logic_vector(31 downto 0)
	);
end entity;

architecture rom of mem_instrucao is
	type array_signal is array(0 to 31) of std_logic_vector(31 downto 0); --Array de 31 elementos com 8 bits cada
	signal instrucao_memoria: array_signal := (
		0 => "00000000001000000000000010010011", -- addi x1,x0,2
		4 => "00000000001000001001000100010011", --srli x2,x1,2
		8 => "00000000000100010000000110110011", --addi x3,x2,x1
		12 => "00000000001100000010000000100011" ,--sw x3,0(x0)
		16 => "00000000000000000000001000000011", --lw x4,0(x0)
			others => x"00000000");
begin	
	
	instrucao <= instrucao_memoria(to_integer(unsigned(endereco))); 
	 
end architecture;
