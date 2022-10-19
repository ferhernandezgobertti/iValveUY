LIBRARY ieee; 
USE ieee.std_logic_1164.all;

entity comparador_8bits is
	--agb = 1 entonces a > b
	--aeb = 1 entonces a = b
	--alb = 1 entonces a < b
	port(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end entity;

architecture flujo_datos of comparador_8bits is

signal g7, g6, g5, g4, g3, g2, g1, g0 : std_logic;

signal e7, e6, e5, e4, e3, e2, e1, e0 : std_logic;

signal mayor, igual, menor : std_logic;

begin

--busco a = b
e7 <= (a(7) and b(7)) or (not(a(7)) and not(b(7)));
e6 <= (a(6) and b(6)) or (not(a(6)) and not(b(6)));
e5 <= (a(5) and b(5)) or (not(a(5)) and not(b(5)));
e4 <= (a(4) and b(4)) or (not(a(4)) and not(b(4)));
e3 <= (a(3) and b(3)) or (not(a(3)) and not(b(3)));
e2 <= (a(2) and b(2)) or (not(a(2)) and not(b(2)));
e1 <= (a(1) and b(1)) or (not(a(1)) and not(b(1)));
e0 <= (a(0) and b(0)) or (not(a(0)) and not(b(0)));

igual <= e7 and e6 and e5 and e4 and e3 and e2 and e1 and e0;

--busco a > b
g7 <= a(7) and not(b(7));
g6 <= e7 and (a(6) and not(b(6)));
g5 <= e7 and e6 and (a(5) and not(b(5)));
g4 <= e7 and e6 and e5 and (a(4) and not(b(4)));
g3 <= e7 and e6 and e5 and e4 and (a(3) and not(b(3)));
g2 <= e7 and e6 and e5 and e4 and e3 and (a(2) and not(b(2)));
g1 <= e7 and e6 and e5 and e4 and e3 and e2 and (a(1) and not(b(1)));
g0 <= e7 and e6 and e5 and e4 and e3 and e2 and e1 and (a(0) and not(b(0)));

mayor <= g7 or g6 or g5 or g4 or g3 or g2 or g1 or g0;

--busco a < b

menor <= not(igual) and not(mayor);

--computo salidas
agb <= mayor;

aeb <= igual;

alb <= menor;

end architecture;

