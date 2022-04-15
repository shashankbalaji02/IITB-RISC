library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
	port(CLK: in std_logic;
		  memory_address: out std_logic_vector(15 downto 0);
		  to_memory: out std_logic_vector(15 downto 0);
		  memory_WE_out: out std_logic;
		  from_memory: in std_logic_vector(15 downto 0));
end entity;

architecture behavioral of processor is
	signal IR: std_logic_vector(15 downto 0);
	signal S: std_logic_vector(27 downto 0);
	signal C, Z: std_logic;

	component controller is
		port (IR: in std_logic_vector(15 downto 0);
				clk, cy, zflag: in std_logic;
				S: out std_logic_vector(27 downto 0));
	end component;
	component datapath is
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
			  Zout: out std_logic;
			  memory_address: out std_logic_vector(15 downto 0);
			  to_memory: out std_logic_vector(15 downto 0);
			  memory_WE_out: out std_logic;
			  from_memory: in std_logic_vector(15 downto 0));
	end component;

begin
	controller_component: controller
		port map(IR, CLK, C, Z, S);
	datapath_component: datapath
		port map(S(27 downto 25), S(24 downto 22), S(21 downto 19),
					S(18), S(17), S(16), S(15), S(14), S(13), S(12),
					S(11 downto 9), S(8), S(7), S(6 downto 5), S(4), S(3 downto 2), S(1), S(0),
					IR, C, Z, memory_address, to_memory, memory_WE_out, from_memory);
end architecture;