library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
	port(
		A,B:in std_logic; 
		CARRY_IN: in std_logic;
		SUM:out std_logic;
		CARRY:out std_logic
	);
end entity;

architecture rtl of full_adder is
	--Basicamente é a declaração do nosso componente
	component half_adder is
		port(
			A,B : in std_logic;
			SUM : out std_logic;
			CARRY: out std_logic
		);
	end component;
	signal x,y,z : std_logic;
	
begin
		CARRY <= y or z;
		--instanciação nominal
		half1: half_adder
			port map(
				A => A,
				B => B,
				SUM =>x,
				CARRY => y
			);
		half2: half_adder
			port map(
				A => x,
				B => CARRY_IN,
				SUM => SUM,
				CARRY => z
			);
		
	
end architecture;