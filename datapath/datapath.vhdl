library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
	port(A1, A2, A3: in std_logic_vector(2 downto 0);
		  register_bank_WE: in std_logic;
		  PC_to_inc: in std_logic;
		  inc_to_PC: in std_logic;
		  SP_to_inc: in std_logic;
		  inc_to_SP: in std_logic;
		  CE: in std_logic;
		  ZE: in std_logic;
		  ALU_input_select: in std_logic_vector(2 downto 0);
		  memory_WE: in std_logic;
		  IR_WE: in std_logic;
		  register_bank_Din_select: in std_logic_vector(1 downto 0);
		  ALU_out: in std_logic;
		  memory_address_select: in std_logic_vector(1 downto 0);
		  A_to_SP_WE: in std_logic;
		  ALU_op: in std_logic;
		  IRout: out std_logic_vector(15 downto 0);
		  Cout: out std_logic;
		  Zout: out std_logic);
end entity;

architecture behavioral of datapath is
	signal A, B, registers_Din, shifted_B, ALU_B, extended_imm6, extended_imm9: std_logic_vector(15 downto 0);
	signal PC_in, PC_out, bank_to_PC, inc_to_PC_data,ALU_result, temp_out: std_logic_vector(15 downto 0);
	signal memory_address, zero_extend_imm9, inc_to_SP_data: std_logic_vector(15 downto 0);
	signal SP_in, SP_out, memory_out, IR_out: std_logic_vector(15 downto 0);
	signal PC_WE, bank_PC_WE, SP_WE, C, Z: std_logic;
	
	component reg is
		port(Din: in std_logic_vector(15 downto 0);
			  WE: in std_logic;
			  Dout: out std_logic_vector(15 downto 0));
	end component;
	component register_bank is
		port(A1, A2, A3: in std_logic_vector(2 downto 0);
			  Din: in std_logic_vector(15 downto 0);
			  WE: in std_logic;
			  D1, D2: out std_logic_vector(15 downto 0);
			  from_PC: in std_logic_vector(15 downto 0);
			  to_PC: out std_logic_vector(15 downto 0);
			  PC_WE: out std_logic);
	end component;
	component incrementer is
		port (Din: in std_logic_vector(15 downto 0);
				RE: in std_logic;
				Dout: out std_logic_vector(15 downto 0));
	end component;
	component flags is
		port(Cin, Zin, CE, ZE: in std_logic;
			  Cout, Zout: out std_logic);
	end component;
	component ALU is 
		port (A, B: in std_logic_vector(15 downto 0);
				sel: in std_logic;
				S: out std_logic_vector(15 downto 0);
				C, Z: out std_logic);
	end component;
	component RAM is
		port(address: in std_logic_vector(15 downto 0);
			  data_in: in std_logic_vector(15 downto 0);
			  write_enable: in std_logic;
			  data_out: out std_logic_vector(15 downto 0));
	end component;

begin
	IR: reg
		port map(memory_out, IR_WE, IR_out);
	PC: reg
		port map(PC_in, PC_WE, PC_out);
	registers: register_bank
		port map(A1, A2, A3, registers_Din, register_bank_WE, A, B, PC_out, bank_to_PC, bank_PC_WE);
	PC_incrementer: incrementer
		port map(PC_out, PC_to_inc, inc_to_PC_data);
	SP_incrementer: incrementer
		port map(SP_out, SP_to_inc, inc_to_SP_data);
	flags_register: flags
		port map(C, Z, CE, ZE, Cout, Zout);
	ALU_component: ALU
		port map(A, ALU_B, ALU_op, ALU_result, C, Z);
	T: reg
		port map(ALU_result, ALU_out, temp_out);
	SP: reg
		port map(SP_in, SP_WE, SP_out);
	memory: RAM
		port map(memory_address, B, memory_WE, memory_out);
	
	PC_WE <= inc_to_PC or bank_PC_WE;
	PC_in <= bank_to_PC when (bank_PC_WE = '1') else
				inc_to_PC_data when (inc_to_PC = '1') else
				(others => 'X');
	
	SP_WE <= inc_to_SP or A_to_SP_WE;
	SP_in <= A when (A_to_SP_WE = '1') else
				inc_to_SP_data when (inc_to_SP = '1') else
				(others => 'X');

	shifted_B(0) <= '0';
	shifted_B(15 downto 1) <= B(14 downto 0);

	extended_imm6(5 downto 0) <= IR_out(5 downto 0);
	extended_imm6(15 downto 6) <= (others => IR_out(5));

	extended_imm9(8 downto 0) <= IR_out(8 downto 0);
	extended_imm9(15 downto 8) <= (others => IR_out(8));

	ALU_B <= B when (ALU_input_select = "000") else
				shifted_B when (ALU_input_select = "001") else
				extended_imm6 when (ALU_input_select = "010") else
				extended_imm9 when (ALU_input_select = "011") else
				"0000000000000001" when (ALU_input_select = "100") else
				"0000000000000000" when (ALU_input_select = "101") else
				"XXXXXXXXXXXXXXXX";
	
	memory_address <= PC_out when (memory_address_select = "00") else
							SP_out when (memory_address_select = "01") else
							temp_out when (memory_address_select = "10") else
							(others => 'X');
	
	zero_extend_imm9(15 downto 7) <= IR_out(8 downto 0);
	zero_extend_imm9(6 downto 0) <= (others => '0');
	
	registers_Din <= temp_out when (register_bank_Din_select = "00") else
						  SP_out when (register_bank_Din_select = "01") else
						  memory_out when (register_bank_Din_select = "10") else
						  (others => 'X');
	
	IRout <= IR_out;
end architecture;