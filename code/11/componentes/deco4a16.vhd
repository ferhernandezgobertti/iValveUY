library IEEE;
use ieee.std_logic_1164.all;

entity deco4a16 is
	port(
		entrada: in std_logic_vector(3 downto 0);
		salida: out std_logic_vector(15 downto 0)
	);
end entity;

architecture decodificar of deco4a16 is

begin

salida(0) <= not (entrada(0)) and not (entrada(1)) and not (entrada(2)) and not (entrada(3));

salida(1) <= (entrada(0)) and not (entrada(1)) and not (entrada(2)) and not (entrada(3));

salida(2) <= not (entrada(0)) and (entrada(1)) and not (entrada(2)) and not (entrada(3));

salida(3) <= (entrada(0)) and (entrada(1)) and not (entrada(2)) and not (entrada(3));

salida(4) <= not (entrada(0)) and not (entrada(1)) and (entrada(2)) and not (entrada(3));

salida(5) <= (entrada(0)) and not (entrada(1)) and (entrada(2)) and not (entrada(3));

salida(6) <= not (entrada(0)) and (entrada(1)) and (entrada(2)) and not (entrada(3));

salida(7) <= (entrada(0)) and (entrada(1)) and (entrada(2)) and not (entrada(3));

salida(8) <= not (entrada(0)) and not (entrada(1)) and not (entrada(2)) and (entrada(3));

salida(9) <= (entrada(0)) and not (entrada(1)) and not (entrada(2)) and (entrada(3));

salida(10) <= not (entrada(0)) and (entrada(1)) and not (entrada(2)) and (entrada(3));

salida(11) <= (entrada(0)) and (entrada(1)) and not(entrada(2)) and (entrada(3));

salida(12) <= not (entrada(0)) and not (entrada(1)) and (entrada(2)) and (entrada(3));

salida(13) <= (entrada(0)) and not (entrada(1)) and (entrada(2)) and (entrada(3));

salida(14) <= not (entrada(0)) and (entrada(1)) and (entrada(2)) and (entrada(3));

salida(15) <= (entrada(0)) and (entrada(1)) and (entrada(2)) and (entrada(3));

end architecture;