library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	port (IR: in std_logic_vector(15 downto 0);
			clk, cy, zflag: in std_logic;
			S: out std_logic_vector(27 downto 0));
end entity controller;

architecture beh of controller is

	type fsm_states is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21,
							  S22, S23, S24, S25, S26, S27, S28, S29, S30, S31, S32, S33, S34, S35, S36, S37, S38,
						     S39, S40, S41, S42, S43, S44, S45, S46, S47, S48, S49, S50, S51, S52, S53, S54, S55, S56);
	
	signal state, next_state: fsm_states;
	signal opcode: std_logic_vector(3 downto 0);
	signal mode: std_logic_vector(1 downto 0);
	signal temp: std_logic_vector(27 downto 0);
	signal temp1, temp2: std_logic := '1';
	
begin
	
	opcode(3 downto 0) <= IR(15 downto 12);
	mode(1 downto 0) <= IR(1 downto 0);
	
	process(clk, next_state) --next state progress
	begin
		if(rising_edge(clk)) then
			state <= next_state;
		end if;
	end process;
	
	process(state, temp, cy, zflag, IR) --state definition
	begin
		
		case state is
			when S0 =>
				temp <= (others => '0');
				temp(17) <= '1';
				temp(7)  <= '1';
				temp(0)  <= '1';
			when S1 =>
				temp <= (others => '0');
				temp(16) <= '1';
			when S2 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(5 downto 3);
				temp(24 downto 22) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(13) <= '1';
				temp(12) <= '1';
				temp(4) <= '1';
			when S3 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(5 downto 3);
				temp(24 downto 22) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(18) <= '1';
			when S4 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(5 downto 3);
				temp(24 downto 22) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				if cy = '1' then
					temp(18) <= '1';
				end if;
			when S5 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(5 downto 3);
				temp(24 downto 22) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				if zflag = '1' then
					temp(18) <= '1';
				end if;
			when S6 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(5 downto 3);
				temp(24 downto 22) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(13) <= '1';
				temp(12) <= '1';
				temp(11 downto 9) <= "001";
				temp(4) <= '1';
			when S7 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(13) <= '1';
				temp(12) <= '1';
				temp(11 downto 9) <= "010";
				temp(4) <= '1';
			when S8 =>
				temp <= (others => '0');
				temp(21 downto 19) <= IR(11 downto 9);
			when S9 =>
				temp <= (others => '0');
				temp(21 downto 19) <= IR(11 downto 9);
				temp(18) <= '1';
				temp(6 downto 5) <= "11";
			when S10 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(18) <= '1';
				temp(6 downto 5) <= "10";
				temp(3 downto 2) <= "10";
			when S11 =>
				temp <= (others => '0');
				temp(3 downto 2) <= "10";
			when S12 =>
				temp <= (others => '0');
				temp(24 downto 22) <= IR(11 downto 9);
				temp(8) <= '1';
				temp(3 downto 2) <= "10";
			when S13 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(11 downto 9);
				temp(24 downto 22) <= IR(8 downto 6);
			when S14 =>
				temp <= (others => '0');
				temp(27 downto 25) <= "111";
				temp(21 downto 19) <= "111";
				temp(11 downto 9) <= "010";
				temp(4) <= '1';
			when S15 =>
				temp <= (others => '0');
				temp(27 downto 25) <= "111";
				temp(21 downto 19) <= IR(11 downto 9);
				temp(11 downto 9) <= "100";
				temp(4) <= '1';
			when S16 =>
				temp <= (others => '0');
				temp(27 downto 25) <= "111";
				temp(21 downto 19) <= "111";
				temp(11 downto 9) <= "011";
				temp(4) <= '1';
			when S17 =>
				temp <= (others => '0');
				temp(27 downto 25) <= "111";
				temp(21 downto 19) <= IR(11 downto 9);
				temp(11 downto 9) <= "010";
				temp(4) <= '1';
			when S18 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(8 downto 6);
				temp(21 downto 19) <= "111";
				temp(11 downto 9) <= "010";
				temp(4) <= '1';
			when S19 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(11 downto 9);
				temp(21 downto 19) <= "111";
				temp(11 downto 9) <= "011";
				temp(4) <= '1';
			when S20 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(13) <= '1';
				temp(11 downto 9) <= "010";
				temp(4) <= '1';
			when S21 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(8 downto 6);
				temp(24 downto 22) <= IR(11 downto 9);
				temp(11 downto 9) <= "010";
				temp(4) <= '1';
			when S22 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(11 downto 9);
				temp(11 downto 9) <= "101";
				temp(4) <= '1';
				temp(3 downto 2) <= "10";
				temp(0) <= '1';
			when S23 =>
				temp <= (others => '0');
			when S24 =>
				temp <= (others => '0');
				if IR(0) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S25 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "001";
			when S26 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "001";
				if IR(1) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S27 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "010";
			when S28 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "010";
				if IR(2) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S29 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "011";
			when S30 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "011";
				if IR(3) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S31 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "100";
			when S32 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "100";
				if IR(4) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S33 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "101";
			when S34 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "101";
				if IR(5) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S35 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "110";
			when S36 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "110";
				if IR(6) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S37 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "111";
			when S38 =>
				temp <= (others => '0');
				temp(21 downto 19) <= "111";
				if IR(7) = '1' then
					temp(18) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S39 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(11 downto 9);
				temp(4) <= '1';
			when S40 =>
				temp <= (others => '0');
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S41 =>
				temp <= (others => '0');
				temp(14) <= '1';
				if IR(0) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S42 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "001";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S43 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "001";
				temp(14) <= '1';
				if IR(1) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S44 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "010";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S45 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "010";
				temp(14) <= '1';
				if IR(2) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S46 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "011";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S47 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "011";
				temp(14) <= '1';
				if IR(3) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S48 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "100";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S49 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "100";
				temp(14) <= '1';
				if IR(4) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S50 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "101";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S51 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "101";
				temp(14) <= '1';
				if IR(5) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S52 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "110";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S53 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "110";
				temp(14) <= '1';
				if IR(6) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S54 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "111";
				temp(15) <= '1';
				temp(3 downto 2) <= "01";
			when S55 =>
				temp <= (others => '0');
				temp(24 downto 22) <= "111";
				temp(14) <= '1';
				if IR(7) = '1' then
					temp(8) <= '1';
				end if;
				temp(6 downto 5) <= "10";
			when S56 =>
				temp <= (others => '0');
				temp(27 downto 25) <= IR(5 downto 3);
				temp(24 downto 22) <= IR(8 downto 6);
				temp(21 downto 19) <= IR(11 downto 9);
				temp(13) <= '1';
				temp(12) <= '1';
				temp(4) <= '1';
				temp(1) <= '1';
			when others =>
				temp <= (others => '0');
		end case;
		S <= temp;
	end process;
	
	
	process(state, opcode, mode, temp1, temp2, zflag, cy)
	begin
		next_state <= state;
		
		case state is
			when S0 =>
				next_state <= S1;
			when S1 =>
				if opcode = "0001" then --ADd/ADC/ADZ/ADL
					if mode = "11" then
						next_state <= S6;
					else
						next_state <= S2;
					end if;
				elsif opcode = "0000" then --ADI
					next_state <= S7;
				elsif opcode = "0010" then --NDU/NDC/NDZ
					next_state <= S56;
				elsif opcode = "0011" then --LHI
					next_state <= S8;
				elsif opcode = "0111" then --LW
					next_state <= S20;
				elsif opcode = "0101" then --SW
					next_state <= S21;
				elsif opcode = "1100" then --LM
					next_state <= S22;
				elsif opcode = "1101" then --SM
					next_state <= S39;
				elsif opcode = "1000" then --BEQ
					next_state <= S13;
				elsif opcode = "1001" then --JAL
					next_state <= S15;
				elsif opcode = "1010" then --JLR
					next_state <= S17;
				elsif opcode = "1011" then --JRI
					next_state <= S19;
				else
					next_state <= S1;
				end if;
			when S2 =>
				if mode = "00" then
					next_state <= S3;
				elsif mode = "01" then
					next_state <= S4;
				elsif mode = "10" then
					next_state <= S5;
				end if;
			when S3 =>
				if opcode = "1001" and temp1 = '1' then
					temp1 <= '0';
					next_state <= S16;
				elsif opcode = "1010" and temp2 = '1' then
					temp2 <= '0';
					next_state <= S18;
				else
					next_state <= S0;
				end if;
			when S4 =>
				next_state <= S0;
			when S5 =>
				next_state <= S0;
			when S6 =>
				next_state <= S3;
			when S7 =>
				next_state <= S3;
			when S8 =>
				next_state <= S9;
			when S9 =>
				next_state <= S0;
			when S10 =>
				next_state <= S0;
			when S11 =>
				next_state <= S12;
			when S12 =>
				next_state <= S0;
			when S13 =>
				if zflag = '1' then
					next_state <= S14;
				else 
					next_state <= S3;
				end if;
			when S14 =>
				next_state <= S3;
			when S15 =>
				next_state <= S3;
			when S16 =>
				next_state <= S3;
			when S17 =>
				next_state <= S3;
			when S18 =>
				next_state <= S3;
			when S19 =>
				next_state <= S3;
			when S20 =>
				next_state <= S10;
			when S21 =>
				next_state <= S11;
			when S22 =>
				next_state <= S23;
			when S23 =>
				next_state <= S24;
			when S24 =>
				next_state <= S25;
			when S25 =>
				next_state <= S26;
			when S26 =>
				next_state <= S27;
			when S27 =>
				next_state <= S28;
			when S28 =>
				next_state <= S29;
			when S29 =>
				next_state <= S30;
			when S30 =>
				next_state <= S31;
			when S31 =>
				next_state <= S32;
			when S32 =>
				next_state <= S33;
			when S33 =>
				next_state <= S34;
			when S34 =>
				next_state <= S35;
			when S35 =>
				next_state <= S36;
			when S36 =>
				next_state <= S37;
			when S37 =>
				next_state <= S38;
			when S38 =>
				next_state <= S3;
			when S39 =>
				next_state <= S40;
			when S40 =>
				next_state <= S41;
			when S41 =>
				next_state <= S42;
			when S42 =>
				next_state <= S43;
			when S43 =>
				next_state <= S44;
			when S44 =>
				next_state <= S45;
			when S45 =>
				next_state <= S46;
			when S46 =>
				next_state <= S47;
			when S47 =>
				next_state <= S48;
			when S48 =>
				next_state <= S49;
			when S49 =>
				next_state <= S50;
			when S50 =>
				next_state <= S51;
			when S51 =>
				next_state <= S52;
			when S52 =>
				next_state <= S53;
			when S53 =>
				next_state <= S54;
			when S54 =>
				next_state <= S55;
			when S55 =>
				next_state <= S3;
			when others =>
				next_state <= S0;
			end case;
	end process;
end beh;