library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity porta_or_salto is
	port(
	a,b:in std_logic;
	s:out std_logic
	);
end entity;

architecture main of porta_or is
	begin
		s <= a or b;
end architecture;