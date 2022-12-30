library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity imm_32bits is 
	port(
		entrada: in std_logic_vector(11 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);
end entity;

architecture imm of imm_32bits is
	begin
	saida <= "00000000000000000000" & entrada(11 downto 0);
end architecture;