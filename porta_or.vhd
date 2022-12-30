library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity porta_or is
	port(
	a,b,c,d,e:in std_logic;
	s:out std_logic
	);
end entity;

architecture main of porta_or is
	begin
		s <= a or b or c or d or e;
end architecture;