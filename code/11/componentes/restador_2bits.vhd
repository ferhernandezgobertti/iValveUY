library IEEE; 
use ieee.std_logic_1164.all;

entity restador_2bits is 
	port(
		bin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		r : out std_logic;
		bout : out std_logic
	);
end entity;

architecture flujo_datos of restador_2bits is

begin

r <= (not(bin) and (a xor b)) or (bin and a and b) or (bin and not(a) and not(b));

bout <= (not(a) and b) or (bin and a and b) or (bin and not(a) and not(b));

end architecture;