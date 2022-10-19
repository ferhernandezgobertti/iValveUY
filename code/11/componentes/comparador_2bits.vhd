LIBRARY ieee; 
USE ieee.std_logic_1164.all;

entity comparador_2bits is
	--agb = 1 entonces a > b
	--aeb = 1 entonces a = b
	--alb = 1 entonces a < b
	port(
		a : in std_logic_vector(1 downto 0);
		b : in std_logic_vector(1 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end entity;

architecture flujo_datos of comparador_2bits is

signal g1, g0 : std_logic;

signal e1, e0 : std_logic;

signal mayor, igual, menor : std_logic;

begin

--busco a = b
e1 <= (a(1) and b(1)) or (not(a(1)) and not(b(1)));
e0 <= (a(0) and b(0)) or (not(a(0)) and not(b(0)));

igual <= e1 and e0;

--busco a > b
g1 <= (a(1) and not(b(1)));
g0 <= e1 and (a(0) and not(b(0)));

mayor <= g1 or g0;

--busco a < b

menor <= not(igual) and not(mayor);

--computo salidas
agb <= mayor;

aeb <= igual;

alb <= menor;

end architecture;
