library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity shift is 
	port(
	numero: in std_logic_vector(31 downto 0);
	saida: out std_logic_vector(31 downto 0)
	);
end entity;

architecture main_shift of shift is
	begin
	saida(31 downto 1) <= numero(30 downto 0);
	saida(0) <= '0';
end architecture;