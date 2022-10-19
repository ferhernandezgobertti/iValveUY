library IEEE; 
use ieee.std_logic_1164.all;

entity mux8a1_1bit is
	--selector(3): cuenta
	--selector(2): B
	--selector(1): C
	--selector(0): D
	port(
		selector: in std_logic_vector (2 downto 0);
		entrada: in std_logic_vector (7 downto 0);
		salida : out std_logic
	);
end entity;

architecture multiplexor of mux8a1_1bit is
signal c0,c1,c2: std_logic;
signal sel: std_logic_vector (7 downto 0);

begin

c2 <= selector(2);

c1 <= selector(1);

c0 <= selector(0);


sel(0) <= not (c2) and not (c1) and not (c0);

sel(1) <= not (c2) and not (c1) and (c0);

sel(2) <= not (c2) and (c1) and not (c0);

sel(3) <= not (c2) and (c1) and (c0);

sel(4) <= (c2) and not (c1) and not (c0);

sel(5) <= (c2) and not (c1) and (c0);

sel(6) <= (c2) and (c1) and not (c0);

sel(7) <= (c2) and (c1) and (c0);


salida <= (sel(0) and entrada(0)) or (sel(1) and entrada(1)) or (sel(2) and entrada(2)) or (sel(3) and entrada(3)) or (sel(4) and entrada(4)) or (sel(5) and entrada(5)) or (sel(6) and entrada(6)) or (sel(7) and entrada(7));

end architecture;