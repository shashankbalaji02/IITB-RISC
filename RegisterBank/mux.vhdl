library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_16 is
	port(sel: in std_logic_vector(2 downto 0);
		  A0, A1, A2, A3, A4, A5, A6, A7: in std_logic_vector(15 downto 0);
		  S: out std_logic_vector(15 downto 0));
end entity mux8x1_16;

architecture beh of mux8x1_16 is
	signal temp: std_logic_vector(15 downto 0);
begin
	process(sel, temp, A0, A1, A2, A3, A4, A5, A6, A7)
	begin
		case sel is
			when "000" =>
				temp <= A0;
			when "001" =>
				temp <= A1;
			when "010" =>
				temp <= A2;
			when "011" =>
				temp <= A3;
			when "100" =>
				temp <= A4;
			when "101" =>
				temp <= A5;
			when "110" =>
				temp <= A6;
			when "111" =>
				temp <= A7;
			when others =>
				temp <= "0000000000000000";
		end case;
	end process;
	S <= temp;
end beh;