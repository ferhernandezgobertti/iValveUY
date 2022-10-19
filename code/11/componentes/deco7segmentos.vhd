library IEEE;
use ieee.std_logic_1164.all;

entity deco7segmentos is
	port(
		punto: in std_logic;
		numin : in std_logic_vector(3 downto 0);
		deco_out : out std_logic_vector(7 downto 0)
	);
end entity;

architecture comportamental of deco7segmentos is

signal c3, c2, c1, c0 : std_logic;

signal sel0, sel1, sel2, sel3, sel4, sel5, sel6, sel7, sel9, sel10, sel11, sel12, sel13, sel14, sel15 : std_logic;

begin

c3 <= numin(3);

c2 <= numin(2);

c1 <= numin(1);

c0 <= numin(0);

sel0 <= not(c3) and not(c2) and not(c1) and not(c0);

sel1 <= not(c3) and not(c2) and not(c1) and c0;

sel2 <= not(c3) and not(c2) and c1 and not(c0);

sel3 <= not(c3) and not(c2) and c1 and c0;

sel4 <= not(c3) and c2 and not(c1) and not(c0);

sel5 <= not(c3) and c2 and not(c1) and c0;

sel6 <= not(c3) and c2 and c1 and not(c0);

sel7 <= not(c3) and c2 and c1 and c0;

sel9 <= c3 and not(c2) and not(c1) and c0;

sel10 <= c3 and not(c2) and c1 and not(c0);

sel11 <= c3 and not(c2) and c1 and c0;

sel12 <= c3 and c2 and not(c1) and not(c0);

sel13 <= c3 and c2 and not(c1) and c0;

sel14 <= c3 and c2 and c1 and not(c0);

sel15 <= c3 and c2 and c1 and c0;

--DP
deco_out(7) <= punto;

--D6
deco_out(6) <= sel0 or sel1 or sel7 or sel12;

--D5
deco_out(5) <= sel1 or sel2 or sel3 or sel7 or sel13;

--D4
deco_out(4) <= sel1 or sel3 or sel4 or sel5 or sel7 or sel9;

--D3
deco_out(3) <= sel1 or sel4 or sel7 or sel9 or sel10 or sel15;

--D2
deco_out(2) <= sel2 or sel12 or sel14 or sel15;

--D1
deco_out(1) <= sel5 or sel6 or sel11 or sel12 or sel14 or sel15;

--D0
deco_out(0) <= sel1 or sel4 or sel11 or sel13;

end architecture;