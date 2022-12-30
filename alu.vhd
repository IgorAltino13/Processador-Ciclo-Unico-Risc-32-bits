library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity alu is 
	port(
		alu_control: in std_logic_vector(3 downto 0);
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		s: out std_logic_vector(31 downto 0);
		zero:out std_logic;
		verifica,negativo,chave:in std_logic;
		diferente,menor,maior:out std_logic
	);
end entity;

architecture alu_main of alu is
	signal shift : std_logic_vector(4 downto 0);
	signal aux: std_logic_vector(31 downto 0);
	begin
	shift <= b(4 downto 0);
	process(alu_control,a,b)
		begin
		case alu_control is
			when "0000" =>
				aux <= a+b;
			when "0001" =>
				aux <= a-b;
				
			when "0010" =>
				case shift is 
					when  "00001" => --deslocamento 1 bit
						aux(31 downto 1) <= a(30 downto 0);
						aux(0) <= '0';
					when "00010" => --deslocamento 2 bits
						aux(31 downto 2) <= a(29 downto 0);
						aux(1 downto 0) <= "00";
					when "00011" => --deslocamento de 3 bits
						aux(31 downto 3) <= a(28 downto 0);
						aux(2 downto 0) <= "000";
					when "00100" => --deslocamento de 4 bits
						aux(31 downto 4) <= a(27 downto 0);
						aux(3 downto 0) <= "0000";
					when "00101" => --deslocamento de 5 bits
						aux(31 downto 5) <= a(26 downto 0);
						aux(4 downto 0) <= "00000";
					when "00110" => --deslocamento de 6 bits
						aux(31 downto 6) <= a(25 downto 0);
						aux(5 downto 0) <= "000000";
					when "00111" => --deslocamento de 7 bits
						aux(31 downto 7) <= a(24 downto 0);
						aux(6 downto 0) <= "0000000";
					when "01000" => --deslocamento de 8 bits
						aux(31 downto 8) <= a(23 downto 0);
						aux(7 downto 0) <= "00000000";
					when "01001" => --deslocamento de 9 bits
						aux(31 downto 9) <= a(22 downto 0);
						aux(8 downto 0) <= "000000000";
					when "01010" => --deslocamento de 10 bits
						aux(31 downto 10) <= a(21 downto 0);
						aux(9 downto 0) <= "0000000000";
					when "01011" => --deslocamento de 11 bits
						aux(31 downto 11) <= a(20 downto 0);
						aux(10 downto 0) <= "00000000000";
					when "01100" => --deslocamento de 12 bits
						aux(31 downto 12) <= a(19 downto 0);
						aux(11 downto 0) <= "000000000000";
					when "01101" => --deslocamento de 13 bits
						aux(31 downto 13) <= a(18 downto 0);
						aux(12 downto 0) <= "0000000000000";
					when "01110" => --deslocamento de 14 bits
						aux(31 downto 14) <= a(17 downto 0);
						aux(13 downto 0) <= "00000000000000";
					when "01111" => --deslocamento de 15 bits
						aux(31 downto 15) <= a(16 downto 0);
						aux(14 downto 0) <= "000000000000000";
					when "10000" => --deslocamento de 16 bits
						aux(31 downto 16) <= a(15 downto 0);
						aux(15 downto 0) <= "0000000000000000";
					when others => NULL;
				end case;
				
			when "0011" =>
				case shift is 
				when  "00001" => --deslocamento 1 bit
						aux(30 downto 0) <= a(31 downto 1);
						aux(31) <= '0';
					when "00010" => --deslocamento 2 bits
						aux(29 downto 0) <= a(31 downto 2);
						aux(31 downto 30) <= "00";
					when "00011" => --deslocamento de 3 bits
						aux(28 downto 0) <= a(31 downto 3);
						aux(31 downto 29) <= "000";
					when "00100" => --deslocamento de 4 bits
						aux(27 downto 0) <= a(31 downto 4);
						aux(31 downto 28) <= "0000";
					when "00101" => --deslocamento de 5 bits
						aux(26 downto 0) <= a(31 downto 5);
						aux(31 downto 27) <= "00000";
					when "00110" => --deslocamento de 6 bits
						aux(25 downto 0) <= a(31 downto 6);
						aux(31 downto 26) <= "000000";
					when "00111" => --deslocamento de 7 bits
						aux(24 downto 0) <= a(31 downto 7);
						aux(31 downto 25) <= "0000000";
					when "01000" => --deslocamento de 8 bits
						aux(23 downto 0) <= a(31 downto 8);
						aux(31 downto 24) <= "00000000";
					when "01001" => --deslocamento de 9 bits
						aux(22 downto 0) <= a(31 downto 9);
						aux(31 downto 23) <= "000000000";
					when "01010" => --deslocamento de 10 bits
						aux(21 downto 0) <= a(31 downto 10);
						aux(31 downto 22) <= "0000000000";
					when "01011" => --deslocamento de 11 bits
						aux(20 downto 0) <= a(31 downto 11);
						aux(31 downto 21) <= "00000000000";
					when "01100" => --deslocamento de 12 bits
						aux(19 downto 0) <= a(31 downto 12);
						aux(31 downto 20) <= "000000000000";
					when "01101" => --deslocamento de 13 bits
						aux(18 downto 0) <= a(31 downto 13);
						aux(31 downto 19) <= "0000000000000";
					when "01110" => --deslocamento de 14 bits
						aux(17 downto 0) <= a(31 downto 14);
						aux(31 downto 18) <= "00000000000000";
					when "01111" => --deslocamento de 15 bits
						aux(16 downto 0) <= a(31 downto 15);
						aux(31 downto 17) <= "000000000000000";
					when "10000" => --deslocamento de 16 bits
						aux(15 downto 0) <= a(31 downto 16);
						aux(31 downto 16) <= "0000000000000000";
					when others => NULL;
				end case;
					
			
			when "0100" =>
				aux <= a xor b;
			when "0101" =>
				aux<= a or b;
			when "0110" =>
				aux <= a and b;
			when others => NULL;
		end case;
	end process;
	zero <= '1' when ((aux = x"00000000") and (verifica = '0')) else '0';
	diferente <= '1' when ((aux > x"00000000" or aux < x"00000000") 
	and (verifica = '1') and (chave = '0')) else '0';
	
	
	menor <= '1' when ((aux(31) = '1') and (negativo = '1') 
	and (verifica ='1') and (chave = '1')) else '0';
	maior <= '1' when ((aux(31) = '0') and (negativo = '0') 
	and (verifica = '1') and (chave ='1')) else '0';
	
	s <= aux;
end architecture;