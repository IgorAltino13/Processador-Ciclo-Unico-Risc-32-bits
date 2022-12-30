library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity banco_reg is
	port(
		clk: in std_logic;
		enable_write: in std_logic; --Habilita a escrita
		end_1: in std_logic_vector(4 downto 0); --Endereço reg 1
		end_2:in std_logic_vector(4 downto 0);		--Endereço reg 2
		end_dest:in std_logic_vector(4 downto 0); --Endereço reg dest
		conteudo_reg_dest: in std_logic_vector(31 downto 0); --Conteudo reg destino
		
		
		conteudo_reg1: out std_logic_vector(31 downto 0); --Conteudo reg 1
		conteudo_reg2: out std_logic_vector(31 downto 0);	--Conteudo reg 2
		
		saida_teste: out std_logic_vector(31 downto 0);
		saida_teste1: out std_logic_vector(31 downto 0);
		saida_teste2: out std_logic_vector(31 downto 0);
		saida_teste3: out std_logic_vector(31 downto 0);
		saida_teste4: out std_logic_vector(31 downto 0)
		
		
		
		
		
	);
end entity;

architecture ram of banco_reg is
	type array_signal is array(0 to 31) of std_logic_vector(31 downto 0); --Array de 32 elementos com 8 bits cada
	signal instrucao_memoria: array_signal := (
	0 => x"00000000",1 => x"00000000",2 => x"00000000",3 => x"00000000",
	4 => x"00000000",5 => x"00000000",6 => x"00000000",7 => x"00000000",
	8 => x"00000000",9 => x"00000000",10 => x"00000000",11 => x"00000000",
	12 => x"00000000",13 => x"00000000",14 => x"00000000",15 => x"00000000",
	16 => x"00000000",17 => x"00000000",18 => x"00000000",19 => x"00000000",
	20 => x"00000000",21 => x"00000000",22 => x"00000000",23 => x"00000000",
	24 => x"00000000",25 => x"00000000",26 => x"00000000",27 => x"00000000",
	28 => x"00000000",29 => x"00000000",30 => x"00000000",31 => x"00000000"
	);
	
	begin	
	--Leitura Assincrona		
	conteudo_reg1 <= instrucao_memoria(to_integer(unsigned(end_1))); --Leitura r1
	conteudo_reg2 <= instrucao_memoria(to_integer(unsigned(end_2))); --Leitura r2
	--Escrita sincrona
	process(clk)
	begin 
		if(enable_write = '1' and (rising_edge(clk))) then
			if(end_dest = "00000") then 
				instrucao_memoria(to_integer(unsigned(end_dest))) <= x"00000000";
			else
				instrucao_memoria(to_integer(unsigned(end_dest))) <= conteudo_reg_dest; --Escreve na memoria
			end if;
		end if;
	end process;
	saida_teste <= instrucao_memoria(0);
	saida_teste1 <= instrucao_memoria(1);
	saida_teste2 <= instrucao_memoria(2);
	saida_teste3 <= instrucao_memoria(3); 
	saida_teste4 <= instrucao_memoria(4); 

	 
end architecture;