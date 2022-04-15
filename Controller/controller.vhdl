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
	
begin
	
	opcode <= IR(15 downto 12);
	mode <= IR(1 downto 0);
	
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
	
	
	process(state)
	begin
		
	end process;
end beh;