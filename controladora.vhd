library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity controladora is
	port(
		opcode : in std_logic_vector(6 downto 0);
		branch: out std_logic;
		MemRead: out std_logic;
		MemtoReg: out std_logic;
		ALUOp : out std_logic_vector(1 downto 0);
		MemWrite: out std_logic;
		AluSrc: out std_logic;
		RegWrite: out std_logic;
		lui:out std_logic;
		mux_lui_1: out std_logic;
		jal:out std_logic;
		jalr:out std_logic
	);
end entity;

architecture main_controladora of controladora is
	begin
		process(opcode)
		begin
			case opcode is
				when "0110011" =>  --Tipo R
					branch <= '0';
					MemRead <= '0';
					MemtoReg <= '1';
					AluOp <= "10";
					MemWrite <= '0';
					AluSrc <= '0';
					RegWrite <= '1';
					lui <= '0';
					mux_lui_1 <= '0';
					jal <= '0';
					jalr <= '0';
					
				when "0000011" => --Tipo I --Ld,lw...
					branch <= '0';
					MemRead <= '1';
					MemtoReg <= '0';
					AluOp <= "00";
					MemWrite <= '0';
					AluSrc <= '1';
					RegWrite <= '1';
					lui <= '0';
					mux_lui_1 <= '0';
					jal <= '0';
					jalr <= '0';
					
				when "0010011" => --Tipo I --Addi,sli...
					branch <= '0';
					MemRead <= '0';
					MemtoReg <= '1';
					AluOp <= "10";
					MemWrite <= '0';
					AluSrc <= '1';
					RegWrite <= '1';
					lui <= '0';
					mux_lui_1 <= '0';
					jal <= '0';
					jalr <= '0';
				
				when "0100011" =>	 --Tipo S
					branch <= '0';
					MemRead <= '0';
					MemtoReg <= '-';
					AluOp <= "00";
					MemWrite <= '1';
					AluSrc <= '1';
					RegWrite <= '0';
					lui <= '0';
					mux_lui_1 <= '0';
					jal <= '0';
					jalr <= '0';
					
				when "1100011" => --Tipo Sb
				
					branch <= '1';
					MemRead <= '0';
					MemtoReg <= '-';
					AluOp <= "01";
					MemWrite <= '0';
					AluSrc <= '0';
					RegWrite <= '0';
					lui <= '0';
					mux_lui_1 <= '0';
					jal <= '0';
					jalr <= '0';
				when "0110111" => --Tipo U
					branch <= '0';
					MemRead <= '0';
					MemtoReg <= '1';
					AluOp <= "--";
					MemWrite <= '0';
					AluSrc <= '1';
					RegWrite <= '1';
					lui <= '1';
					mux_lui_1 <= '1';
					jal <= '0';
					jalr <= '0';
				when "1101111" => --Tipo UJ
					branch <= '1';
					MemRead <= '0';
					MemtoReg <= '-';
					AluOp <= "--";
					MemWrite <= '0';
					AluSrc <= '-';
					RegWrite <= '1';
					lui <= '0';
					mux_lui_1 <= '-';
					jal <= '1';
					jalr <= '0';
				when "1100111" => --Tipo jalr
					branch <= '1';
					MemRead <= '0';
					MemtoReg <= '-';
					AluOp <= "10";
					MemWrite <= '0';
					AluSrc <= '1';
					RegWrite <= '0';
					lui <= '-';
					mux_lui_1 <= '-';
					jal <= '1';
					jalr <= '1';
				when others => 
					branch <= '0';
					MemRead <= '0';
					MemtoReg <= '0';
					AluOp <= "00";
					MemWrite <= '0';
					AluSrc <= '0';
					RegWrite <= '0';
					lui <= '0';
					mux_lui_1 <= '0';
					jal <= '0';
					jalr <= '0';
					
			end case;
			end process;
			
end architecture;