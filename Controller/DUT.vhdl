library ieee;
use ieee.std_logic_1164.all;

entity DUT is 
	port(input_vector: in std_logic_vector(18 downto 0);
		  output_vector: out std_logic_vector(28 downto 0));
end entity;

architecture DUTWrap of DUT is
	component controller is
		port (IR: in std_logic_vector(15 downto 0);
				clk, cy, zflag: in std_logic;
				A1, A2, A3, MUX_ALU: out std_logic_vector(2 downto 0);
				Ain, Din, inc_PC, inc_SP, C, Z, MemDin, Mem_Dout_IR, ALU_T: out std_logic; 
				MUX_Din, MUX_Ain: out std_logic_vector(1 downto 0);
				count: out std_logic_vector(3 downto 0));
	end component controller;
begin
	
	add_instance: controller
		port map (IR          => input_vector(15 downto 0),
					 clk         => input_vector(16),
					 zflag       => input_vector(17),
					 cy          => input_vector(18),
					 A1          => output_vector(24 downto 22),
					 A2          => output_vector(21 downto 19),
					 A3          => output_vector(18 downto 16),
					 MUX_ALU     => output_vector(15 downto 13),
					 Ain         => output_vector(12),
					 Din         => output_vector(11),
					 inc_PC      => output_vector(10),
					 inc_SP      => output_vector(9),
					 C           => output_vector(8),
					 Z           => output_vector(7),
					 MemDin      => output_vector(6),
					 Mem_Dout_IR => output_vector(5),
					 ALU_T       => output_vector(4),
					 MUX_Din     => output_vector(3 downto 2),
					 MUX_Ain     => output_vector(1 downto 0),
					 count       => output_vector(28 downto 25));
end DUTWrap;