library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity imm_control is
	port(
	inst: in std_logic_vector(31 downto 0);
	imm: out std_logic_vector(31 downto 0)
	);
end entity;

architecture main of imm_control is
	begin 
	process(inst)
	begin
		case inst(6 downto 0) is 
			when  "0100011" =>  --Tipo S
				if (inst(31) ='0') then
					imm <= "00000000000000000000"&inst(31 downto 25) & inst(11 downto 7);
				else
					imm <= "11111111111111111111"&inst(31 downto 25) & inst(11 downto 7);
				end if;
			when "0110111" =>--Tipo U
					imm <= inst(31 downto 12)&"000000000000";
				
			when "1100011" => --Tipo Sb
				if (inst(31) ='0') then
					imm <= "00000000000000000000" & inst(31 downto 25) & inst(11 downto 7);
				else 
					imm <= "11111111111111111111" & inst(31 downto 25) & inst(11 downto 7);
				end if;
			when "1101111" => --Tipo Uj
				if (inst(31) ='0') then
					imm <= "000000000000"&inst(31 downto 12);
				else
					imm <= "111111111111"&inst(31 downto 12);
				end if;
			when "1100111" =>
				if (inst(31) ='0') then
					imm <= "00000000000000000000"&inst(31 downto 20); -- Tipo I
				else
					imm <= "11111111111111111111"&inst(31 downto 20); -- Tipo I
				end if;
				
			when others => 
				if (inst(31) ='0') then
					imm <= "00000000000000000000"&inst(31 downto 20); -- Tipo I
				else
					imm <= "11111111111111111111"&inst(31 downto 20); -- Tipo I
				end if;
		end case;
	end process;
		
end architecture;