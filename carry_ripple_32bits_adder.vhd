library ieee;
use ieee.std_logic_1164.all;


entity carry_ripple_32bits_adder is
	port(
		A,B: in std_logic_vector(31 downto 0);
		CARRY_IN: in std_logic;
		CARRY_OUT:out std_logic;
		S:out std_logic_vector(31 downto 0)
	);
end entity;

architecture main of carry_ripple_32bits_adder is
	
	component full_adder is 
	port(
		A,B:in std_logic; 
		CARRY_IN: in std_logic;
		SUM:out std_logic;
		CARRY:out std_logic
	);
	end component;
	
	signal C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,
	C21,C22,C23,C24,C25,C26,C27,C28,C29,C30,C31 : std_logic;
	
	begin
	--Instanciaçoes
	FA1: full_adder port map(A(0),B(0),CARRY_IN,S(0),C1);
	FA2: full_adder port map(A(1),B(1),C1,S(1),C2);
	FA3: full_adder port map(A(2),B(2),C2,S(2),C3);
	FA4: full_adder port map(A(3),B(3),C3,S(3),C4);
	FA5: full_adder port map(A(4),B(4),C4,S(4),C5);
	FA6: full_adder port map(A(5),B(5),C5,S(5),C6);
	FA7: full_adder port map(A(6),B(6),C6,S(6),C7);
	FA8: full_adder port map(A(7),B(7),C7,S(7),C8);
	FA9: full_adder port map(A(8),B(8),C8,S(8),C9);
	FA10: full_adder port map(A(9),B(9),C9,S(9),C10);
	FA11: full_adder port map(A(10),B(10),C10,S(10),C11);
	FA12: full_adder port map(A(11),B(11),C11,S(11),C12);
	FA13: full_adder port map(A(12),B(12),C12,S(12),C13);
	FA14: full_adder port map(A(13),B(13),C13,S(13),C14);
	FA15: full_adder port map(A(14),B(14),C14,S(14),C15);
	FA16: full_adder port map(A(15),B(15),C15,S(15),C16);
	FA17: full_adder port map(A(16),B(16),C16,S(16),C17);
	FA18: full_adder port map(A(17),B(17),C17,S(17),C18);
	FA19: full_adder port map(A(18),B(18),C18,S(18),C19);
	FA20: full_adder port map(A(19),B(19),C19,S(19),C20);
	FA21: full_adder port map(A(20),B(20),C20,S(20),C21);
	FA22: full_adder port map(A(21),B(21),C21,S(21),C22);
	FA23: full_adder port map(A(22),B(22),C22,S(22),C23);
	FA24: full_adder port map(A(23),B(23),C23,S(23),C24);
	FA25: full_adder port map(A(24),B(24),C24,S(24),C25);
	FA26: full_adder port map(A(25),B(25),C25,S(25),C26);
	FA27: full_adder port map(A(26),B(26),C26,S(26),C27);
	FA28: full_adder port map(A(27),B(27),C27,S(27),C28);
	FA29: full_adder port map(A(28),B(28),C28,S(28),C29);
	FA30: full_adder port map(A(29),B(29),C29,S(29),C30);
	FA31: full_adder port map(A(30),B(30),C30,S(30),C31);
	FA32: full_adder port map(A(31),B(31),C31,S(31),CARRY_OUT);
	
	
	
	
end architecture;