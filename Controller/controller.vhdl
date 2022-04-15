library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	port (IR: in std_logic_vector(15 downto 0);
			clk, cy, zflag: in std_logic;
			A1, A2, A3, MUX_ALU: out std_logic_vector(2 downto 0);
			Ain, Din, inc_PC, inc_SP, C, Z, MemDin, Mem_Dout_IR, ALU_T: out std_logic; 
			MUX_Din, MUX_Ain: out std_logic_vector(1 downto 0);
			count: out std_logic_vector(3 downto 0));
end entity controller;

architecture beh of controller is
---A1 address for read
---A2 same as above
---A3 write
---Din write enable to reg bank
---inc_PC if we need to inc PC or not
---inc_SP same for SP
---C if carry has to be set 
---Z same for zero
---MUX_ALU second address of ALU
---Mem_Din reg to mem 
---Mem_Dout_IR to write to IR
---MUX_Din the input going to reg bank 
---ALU_T to store the output of ALU in T(temp reg)
---MUX_Ain where address lines are coming from

component counter is
	port (rst,clk: in std_logic; 
			S: out std_logic_vector(3 downto 0));
end component counter;

signal opcode, temp: std_logic_vector(3 downto 0);
signal mode: std_logic_vector(1 downto 0);
signal tA1, tA2, tA3, tMUX_ALU: std_logic_vector(2 downto 0) := "000";
signal tAin, tDin, tinc_PC, tinc_SP, tC, tZ, tMemDin, tMem_Dout_IR, tALU_T, rst: std_logic := '0'; 
signal tMUX_Din, tMUX_Ain: std_logic_vector(1 downto 0) := "00";


begin
	
	counter1: counter port map (rst, clk, temp);

	opcode(3 downto 0) <= IR(15 downto 12);
	mode(1 downto 0) <= IR(1 downto 0);
	process(temp)
		begin
			if(temp = "0001") then
				tMUX_Ain <= "00";
				tAin <= '1';
				tMem_Dout_IR <= '1';
			elsif(temp = "0010") then 
				tAin <= '0';
				tMem_Dout_IR <= '0';
				tinc_PC <= '1';
			elsif(temp = "0011") then
				tinc_PC <= '0';
			end if;
		end process;
		
	process(opcode, temp, mode)
		begin
			case opcode is
				when "0001" =>  --ADD/ADC/ADZ/ADL
					if temp = "0011" then
						tA1 <= IR(5 downto 3);
						tA2 <= IR(8 downto 6);
						tA3 <= IR(11 downto 9);
						tALU_T <= '1';
						tC <= '1';
						tZ <= '1';
					elsif temp = "0100" then
						tA1 <= "000";
						tA2 <= "000";
						tA3 <= "000";
						tALU_T <= '0';
						tC <= '0';
						tZ <= '0';
						case mode is
							when "00" =>
								tDin <= '1';
							when "01" =>
								if cy = '1' then
									tDin <= '1';
								end if;
							when "10" =>
								if zflag = '1' then 
									tDin <= '1';
								end if;
							when "11" =>
								tDin <= '1';
								tMUX_ALU <= "001";
							when others =>
								tDin <= '0';
						end case;
					elsif temp = "0101" then
						tDin <= '0';
						tMUX_ALU <= "000";
						rst <= '1';
					end if;
				when "0000" =>  --ADI
					if temp = "0011" then
						tA1 <= IR(8 downto 6);
						tA3 <= IR(11 downto 9);
						tC <= '1';
						tZ <= '1';
						tALU_T <= '1';
						tMUX_ALU <= "010";
					elsif temp = "0100" then
						tA1 <= "000";
						tA3 <= "000";
						tC <= '0';
						tZ <= '0';
						tALU_T <= '0';
						tMUX_ALU <= "000";
						tDin <= '1';
					elsif temp = "0101" then
						tDin <= '0';
						temp <= "0000";
					end if;
				when "0010" =>  --NDU/NDC/NDZ
				when "0100" =>  --LHI
				when "0111" =>  --LW
				when "0101" =>  --SW
				when "1100" =>  --LM
				when "1101" =>  --SM
				when "1000" =>  --BEQ
				when "1001" =>  --JAL
				when "1010" =>  --JLR
				when "1011" =>  --JRI
				when others =>  --silently fail
			end case;
		end process;

	A1 <= tA1;
	A2 <= tA2;
	A3 <= tA3;
	MUX_ALU <= tMUX_ALU;
	Ain <= tAin;
	Din <= tDin;
	inc_PC <= tinc_PC;
	inc_SP <= tinc_SP;
	C <= tC;
	Z <= tZ;
	MemDin <= tMemDin;
	Mem_Dout_IR <= tMem_DOut_IR;
	ALU_T <= tALU_T;
	MUX_Din <= tMUX_Din;
	MUX_Ain <= tMUX_Ain;
	count <= temp;
end beh;