library IEEE;
use ieee.std_logic_1164.all;

entity flip_flop_D_1bit is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end entity;

architecture a1 of flip_flop_D_1bit is
begin

	p1: process (D, reset, clk)
	begin
		if (reset='1') then
			Q<='0';
		elsif(clk'event and clk='1') then
			Q<=D;
		end if;
		
	end process;
	
end architecture;