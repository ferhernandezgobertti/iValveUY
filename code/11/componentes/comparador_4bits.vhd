LIBRARY ieee; 
USE ieee.std_logic_1164.all;

entity comparador_4bits is
	--agb = 1 entonces a > b
	--aeb = 1 entonces a = b
	--alb = 1 entonces a < b
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end entity;

architecture flujo_datos of comparador_4bits is

signal g3, g2, g1, g0 : std_logic;

signal e3, e2, e1, e0 : std_logic;

signal mayor, igual, menor : std_logic;

begin

--busco a = b
e3 <= (a(3) and b(3)) or (not(a(3)) and not(b(3)));
e2 <= (a(2) and b(2)) or (not(a(2)) and not(b(2)));
e1 <= (a(1) and b(1)) or (not(a(1)) and not(b(1)));
e0 <= (a(0) and b(0)) or (not(a(0)) and not(b(0)));

igual <= e3 and e2 and e1 and e0;

--busco a > b
g3 <= (a(3) and not(b(3)));
g2 <= e3 and (a(2) and not(b(2)));
g1 <= e3 and e2 and (a(1) and not(b(1)));
g0 <= e3 and e2 and e1 and (a(0) and not(b(0)));

mayor <= g3 or g2 or g1 or g0;

--busco a < b

menor <= not(igual) and not(mayor);

--computo salidas
agb <= mayor;

aeb <= igual;

alb <= menor;

end architecture;
