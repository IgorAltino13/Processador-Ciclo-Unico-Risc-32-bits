library ieee;
use ieee.std_logic_1164.all;

entity mux_2X1 is 
	port(
		A,B : in std_logic_vector(31 downto 0);
		SEL : in std_logic;
		S : out std_logic_vector(31 downto 0)
	);
end entity;

architecture comp of mux_2X1 is
	begin
		S <= A when SEL = '0' else B;  ---X recebera A quando SEL = 0,caso contrario recebera B,
end architecture;