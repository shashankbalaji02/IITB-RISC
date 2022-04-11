library ieee;
use ieee.std_logic_1164.all;

entity demux8x1_1 is
	port(sel: in std_logic_vector(2 downto 0);
		  S: out std_logic_vector(7 downto 0));
end entity demux8x1_1;

architecture beh of  demux8x1_1 is
	signal temp: std_logic_vector(7 downto 0);
begin
	process(sel)
	begin	
		case sel is
			when "000" =>
				temp <= "10000000";
			when "000" =>
				temp <= "01000000";
			when "000" =>
				temp <= "00100000";
			when "000" =>
				temp <= "00010000";
			when "000" =>
				temp <= "00001000";
			when "000" =>
				temp <= "00000100";
			when "000" =>
				temp <= "00000010";
			when "000" =>
				temp <= "00000001";
			when others =>
				temp <= "00000000";
		end case;
	end process;
	S <= temp;
end beh;