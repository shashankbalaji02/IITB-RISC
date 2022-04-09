library ieee;
use ieee.std_logic_1164.all;

entity demux8x1_16 is
	port(A: in std_logic_vector(15 downto 0);
		  sel: in std_logic_vector(2 downto 0);
		  S0, S1, S2, S3, S4, S5, S6, S7: out std_logic_vector(15 downto 0));
end entity demux8x1_16;

architecture beh of  demux8x1_16 is
	signal t0, t1, t2, t3, t4, t5, t6, t7: std_logic_vector(15 downto 0) := "0000000000000000";
begin
	process(A, sel, t0, t1, t2, t3, t4, t5, t6, t7)
	begin
		case sel is
			when "000" =>
				t0 <= A;
			when "001" =>
				t1 <= A;
			when "010" =>
				t2 <= A;
			when "011" =>
				t3 <= A;
			when "100" =>
				t4 <= A;
			when "101" =>
				t5 <= A;
			when "110" =>
				t6 <= A;
			when "111" =>
				t7 <= A;
			when others =>
		end case;	
	end process;
	S0 <= t0;
	S1 <= t1;
	S2 <= t2;
	S3 <= t3;
	S4 <= t4;
	S5 <= t5;
	S6 <= t6;
	S7 <= t7;
end beh;