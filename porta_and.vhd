library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity porta_and is 
	port(
	A : in std_logic;
	B : in std_logic;
	S : out std_logic
	);
end entity;

architecture main of porta_and is
	begin
		S <= A and B;
end architecture;