library IEEE;
use ieee.std_logic_1164.all;

entity deco2a4 is
	port(
		entrada: in std_logic_vector(1 downto 0);
		salida: out std_logic_vector(3 downto 0)
	);
end entity;

architecture decodificar of deco2a4 is

begin

salida(0) <= not (entrada(0)) and not (entrada(1));

salida(1) <= (entrada(0)) and not (entrada(1));

salida(2) <= not (entrada(0)) and (entrada(1));

salida(3) <= (entrada(0)) and (entrada(1));

end architecture;