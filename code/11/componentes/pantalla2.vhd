library IEEE;
use ieee.std_logic_1164.all;

entity pantalla2 is
	port(
		velocidad_mezcla: in std_logic_vector (7 downto 0);
		hm: in std_logic_vector (1 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0)
	);
end entity;

architecture mostrar2 of pantalla2 is

component mux2a1_8bits
	port(
		selector : in std_logic;
		entrada1 : in std_logic_vector(7 downto 0);
		entrada2 : in std_logic_vector(7 downto 0);
		salida : out std_logic_vector(7 downto 0)
	);
end component;

component bits_to_BCD is
	port(
		entrada: in std_logic_vector (7 downto 0);
		centenas: out std_logic_vector (3 downto 0);
		decenas: out std_logic_vector (3 downto 0);
		unidades: out std_logic_vector (3 downto 0)
	);
end component;

component deco7segmentos is
	port(
		punto: in std_logic;
		numin : in std_logic_vector(3 downto 0);
		deco_out : out std_logic_vector(7 downto 0)
	);
end component;

signal num_hex0, num_hex1, num_hex2: std_logic_vector (3 downto 0);

begin

SEPARADOR: bits_to_BCD
	port map (
		entrada => velocidad_mezcla,
		centenas => num_hex2,
		decenas => num_hex1,
		unidades => num_hex0
	);

	
MUX_hex3: mux2a1_8bits
	port map (
		selector => hm(1),
		entrada1 => "11111111",
		entrada2 => "10111111",
		salida => hex_3
	);

DECO_HEX0: deco7segmentos
	port map(
		punto => '1',
		numin => num_hex0,
		deco_out => hex_0
	);	
	

DECO_HEX1: deco7segmentos
	port map(
		punto => '1',
		numin => num_hex1,
		deco_out => hex_1
	);	
	

DECO_HEX2: deco7segmentos
	port map(
		punto => '1',
		numin => num_hex2,
		deco_out => hex_2
	);	

end architecture;