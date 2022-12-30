library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity demux is 
port(
	entrada:in std_logic_vector(31 downto 0);
	saida1:out std_logic_vector(31 downto 0);
	saida2:out std_logic_vector(31 downto 0);
	sel:in std_logic
	
);
end entity;

architecture main of demux is
	begin
	saida1 <= entrada when sel = '0';
	saida2 <= entrada when sel = '1';
end architecture;