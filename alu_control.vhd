library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity alu_control is 
	port(
		alu_op : in std_logic_vector(1 downto 0);
		funct_3: in std_logic_vector(2 downto 0);
		funct_7: in std_logic_vector(6 downto 0);
		verifica,negativo,chave:out std_logic;
		alu_operation: out std_logic_vector(3 downto 0)
	);
end entity;

architecture alu of alu_control is
	
	begin
	
	process(alu_op,funct_7,funct_3)
	begin
		case alu_op is 
			when "00" => 
				alu_operation <= "0000"; --ld/sd
			when "01" =>
				alu_operation <= "0001"; --beq
				case funct_3 is 
					when "000" =>
					verifica <= '0';
					when "001" =>
					verifica <= '1';
					chave <= '0';
					when "100" =>
					verifica <= '1';
					negativo <= '1';
					chave <= '1';
					when "101" =>
					negativo <= '0';
					verifica <= '1';
					chave <= '1';
					when others => NULL;
				end case;
			when "10" =>
			
				case funct_3 is
					when "000" => 
						case funct_7 is
							when "0000000" =>
								alu_operation <= "0000"; --Soma
							when "0100000" =>
								alu_operation <= "0001"; --Subtração
							when others =>
								alu_operation <= "0000";
						end case;
				
				
					when "001" =>
						case funct_7 is
							when "0000000" =>
								alu_operation <= "0010"; --sll
							when others =>
								alu_operation <= "0000";
						end case;
				
					when "101" =>
						case funct_7 is
							when "0000000" =>
								alu_operation <= "0011"; --srl
							when others =>
								alu_operation <= "0000";
						end case;
				
				
					when "100" =>
						case funct_7 is
							when "0000000" =>
								alu_operation <= "0100"; --xor
							when others =>
								alu_operation <= "0000";
						end case;
				
				
				
					when "110" =>
						case funct_7 is
							when "0000000" =>
								alu_operation <= "0101"; --or
							when others =>
								alu_operation <= "0000";
						end case;
		
				
				
					when "111" =>
						case funct_7 is
							when "0000000" =>
								alu_operation <= "0110"; --and
							when others =>
								alu_operation <= "0000";
						end case;
						
					when others => 
						alu_operation <= "0000";
				end case;
				
		when others =>
			alu_operation <= "0000";
		end case;
	end process;
								
end architecture;