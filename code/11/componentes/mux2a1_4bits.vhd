library IEEE; 
use ieee.std_logic_1164.all;

entity mux2a1_4bits is
	--Si selector = 0 entonces salida = entrada1
	--Si selector = 1 entonces salida = entrada2
	port(
		selector : in std_logic;
		entrada1 : in std_logic_vector(3 downto 0);
		entrada2 : in std_logic_vector(3 downto 0);
		salida : out std_logic_vector(3 downto 0)
	);
end entity;

architecture flujo_datos of mux2a1_4bits is

begin

salida(3) <= (not(selector) and entrada1(3)) or (selector and entrada2(3));

salida(2) <= (not(selector) and entrada1(2)) or (selector and entrada2(2));

salida(1) <= (not(selector) and entrada1(1)) or (selector and entrada2(1));

salida(0) <= (not(selector) and entrada1(0)) or (selector and entrada2(0));

end architecture;