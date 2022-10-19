library IEEE;
use ieee.std_logic_1164.all;

entity deco3a8 is
	port(
		entrada: in std_logic_vector(2 downto 0);
		salida: out std_logic_vector(7 downto 0)
	);
end entity;

architecture decodificar of deco3a8 is

begin

salida(0) <= not (entrada(0)) and not (entrada(1)) and not (entrada(2));

salida(1) <= (entrada(0)) and not (entrada(1)) and not (entrada(2));

salida(2) <= not (entrada(0)) and (entrada(1)) and not (entrada(2));

salida(3) <= (entrada(0)) and (entrada(1)) and not (entrada(2));

salida(4) <= not (entrada(0)) and not (entrada(1)) and (entrada(2));

salida(5) <= (entrada(0)) and not (entrada(1)) and (entrada(2));

salida(6) <= not (entrada(0)) and (entrada(1)) and (entrada(2));

salida(7) <= (entrada(0)) and (entrada(1)) and (entrada(2));

end architecture;