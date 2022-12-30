library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity comparadores is 
	port(
	numero:in std_logic_vector(31 downto 0);
	s:out std_logic;
	ativa:in std_logic
	);
end entity;

architecture main of comparadores is
	begin 
		s <= '1' when ((numero > x"00000000") and (ativa = '1'))  else '0';
	
end architecture;