
library ieee;
use ieee.std_logic_1164.all;


entity pc is 
	port(
		clk, rst : in std_logic
		--Reg_X0		: out std_logic_vector(31 downto 0);
		--Reg_X1   :out std_logic_vector(31 downto 0);
		--Reg_X2		: out std_logic_vector(31 downto 0);
		--Reg_X3   :out std_logic_vector(31 downto 0);
		--Reg_X4		: out std_logic_vector(31 downto 0);
		
		--memoria:out std_logic_vector(31 downto 0);
		--PC_reg: out std_logic_vector(31 downto 0)
		
		
		
	);
end entity;

architecture sum_pc of pc is
	signal x, --Saida do somador+4
	y, --Saida do somador jump
	z, -- Saida do Mux
	inst, --Saida da memoria intruçao
	q_temp, --Saida do registrador(PC),
	conteudo_a, --Saida A do banco de registradores
	conteudo_b, ---Saida B do banco de registradores
	mux_alu_imm, --saida do imediato e entrada do mux
	mux_alu_saida, --Saida do mux da alu(entrada)
	res,  -----Saida da Alu
	read_data, --Leitura da memoria
	write_data_reg,--Dado escrito no registrador
	shift_adder, --- Saida do shift e entrada do somador
	demux_alu,
	signal_lui,
	saida_mux,
	saida_mux_jal,
	saida_jalr
	: std_logic_vector(31 downto 0);
	signal signal_branch, ---Saida branch da controladora
	signal_mem_read, --Saida MemRead da controladora
	signal_mem_to_reg, --Saida MemtoReg da controladora
	signal_mem_write, --Saida MemWrite da controladora
	signal_alu_src, --Saida AluSrc da controladora
	signal_regWrite, --Saida RegWrite da controladora 
	signal_zero,  --Entrada zero da And
	sel_mux_branch, --Seletora do mux de branch
	lui_1,
	mux_lui,
	sel_jal,
	sel_jalr
	: std_logic;
	signal signal_alu_op : std_logic_vector(1 downto 0); --Saida AluOp da controladora
	signal sel_alu : std_logic_vector(3 downto 0); --Seletora da alu e saida da alu control
	signal saida,saida1,saida2,saida3,saida4,saida5,saida6,saida7,saida8,saida9:std_logic_vector(31 downto 0); --Saidas temporarias
	signal signal_verifica,signal_chave,signal_negativo,signal_diferente,signal_maior,signal_menor,saida_or: std_logic;
	begin
	
		--Somador
		S1: entity work.carry_ripple_32bits_adder(main)
		port map(
			A => q_temp,
			B => x"00000004",
			CARRY_IN => '0',
			S => x,
			CARRY_OUT => open -- nao utilizado
			);
			
		S2: entity work.carry_ripple_32bits_adder(main)
		port map(
			A => q_temp,
			B => shift_adder,
			CARRY_IN => '0',
			S => y,
			CARRY_OUT => open -- nao utilizado
			);
		
		mux_jal: entity work.mux_2X1(comp)
		port map(
			A => write_data_reg,
			B => x,
			S => saida_mux_jal,
			SEL => sel_jal
		);
		mux_jalr: entity work.mux_2X1(comp)
		port map(
			A => z,
			B => res,
			S => saida_jalr,
			SEL => sel_jalr
		);


		--MUX
		mux: entity work.mux_2X1(comp)
		port map(
			A => x,
			B => y,
			S => z,
			SEL => sel_mux_branch
		);
		--REG/PC
		R1: entity work.reg(behavioral)
		port map(
			clk => clk,
			rst => rst,
			data => saida_jalr,
			q => q_temp
			
		);
		mem_instrucao: entity work.mem_instrucao(rom)
		port map(
			endereco => q_temp,
			instrucao =>inst
		);
		banco_reg: entity work.banco_reg(ram)
		port map(
			end_1 => inst(19 downto 15),
			end_2 => inst(24 downto 20),
			end_dest => inst(11 downto 7),
			clk => clk,
			enable_write => signal_regWrite,
			conteudo_reg_dest => saida_mux_jal,
			conteudo_reg1 => conteudo_a,
			conteudo_reg2 => conteudo_b,
			
			
			saida_teste => saida,
			saida_teste1 => saida1,
			saida_teste2 => saida2,
			saida_teste3 => saida3, 
			saida_teste4 => saida4
			
			
		);
		imm: entity work.imm_control(main)
			port map(
				inst => inst, --mesmo nome,
				imm => mux_alu_imm
			);
		shift: entity work.shift(main_shift)
			port map(
				numero => mux_alu_imm,
				saida => shift_adder
			);
		mux_alu: entity work.mux_2X1(comp)
		port map(
			A => conteudo_b,
			B => mux_alu_imm,
			S => mux_alu_saida,
			SEL => signal_alu_src
		);
		
		demux:entity work.demux(main)
		port map(
			entrada => mux_alu_saida,
			saida1 => demux_alu,
			saida2 => signal_lui,
			sel => lui_1
		);
		mux_alu_lui: entity work.mux_2X1(comp)
		port map(
			A => res,
			B => signal_lui,
			S => saida_mux,
			SEL => mux_lui
		);
		alu: entity work.alu(alu_main)
		port map(
			alu_control => sel_alu,
			a => conteudo_a,
			b => demux_alu,
			s => res,
			zero => signal_zero,
			verifica => signal_verifica,
			negativo => signal_negativo,
			chave => signal_chave,
			diferente => signal_diferente,
			menor => signal_menor,
			maior => signal_maior
		);
		porta_or:entity work.porta_or(main)
		port map(
			a => signal_zero,
			b => signal_diferente,
			c => signal_menor,
			d => signal_maior,
			e => sel_jal,
			s => saida_or
		);
		mem_dados: entity work.mem_dados(main_mem)
		port map(
			clk => clk,
			endereco => res,
			conteudo => conteudo_b,
			escrita => signal_mem_write, 
			leitura => signal_mem_read ,
			data => read_data
			
		);
		mux_mem_dados: entity work.mux_2X1(comp)
		port map(
			A => read_data,
			B => saida_mux,
			S => write_data_reg,
			SEL => signal_mem_to_reg
		);
		
		controladora: entity work.controladora(main_controladora)
		port map(
			opcode => inst(6 downto 0),
			branch => signal_branch,
			MemRead => signal_mem_read,
			MemtoReg => signal_mem_to_reg,
			AluOp => signal_alu_op,
			MemWrite => signal_mem_write,
			AluSrc => signal_alu_src,
			RegWrite => signal_regWrite,
			lui=> lui_1,
			mux_lui_1 => mux_lui,
			jal => sel_jal,
			jalr => sel_jalr
			 
		);
		porta_and: entity work.porta_and(main)
		port map(
			A => signal_branch,
			B => saida_or,
			S => sel_mux_branch
		);
		
		ALU_control: entity work.alu_control(alu)
		port map(
			alu_op => signal_alu_op,
			funct_3 => inst(14 downto 12),
			funct_7 => inst(31 downto 25),
			alu_operation => sel_alu,
			verifica => signal_verifica,
			negativo => signal_negativo,
			chave => signal_chave
		);
		
		
		
		--Reg_X0 <= saida;
		--Reg_X1 <= saida1;
		--Reg_X2 <= saida2;
		--Reg_X3 <= saida3;
		--Reg_X4 <= saida4;
		--PC_reg <=q_temp;
		--memoria <= read_data;
		
end architecture;