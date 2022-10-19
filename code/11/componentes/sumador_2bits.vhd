library IEEE; 
use ieee.std_logic_1164.all;

entity sumador_2bits is 
	port(
		cin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		cout : out std_logic
	);
end entity;

architecture flujo_datos of sumador_2bits is

begin

s <= (not(cin) and (a xor b)) or (cin and a and b) or (cin and not(a) and not(b));

cout <= (a and b) or (cin and (a xor b));

end architecture;