library IEEE;
use ieee.std_logic_1164.all;

entity pantalla1 is
	port(
		clk_in: in std_logic;
		rst: in std_logic;
		hm: in std_logic_vector (1 downto 0);
		llenado: in std_logic;
		compresion: in std_logic;
		segundosx10: in std_logic_vector (3 downto 0);
		segundosx1: in std_logic_vector (3 downto 0);
		segundosx01: in std_logic_vector (3 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0)
	);
end entity;

architecture mostrar1 of pantalla1 is

component animacion_giro_horario is
	port(
		clk: in std_logic;
		leds: out std_logic_vector(7 downto 0)
	);
end component;

component animacion_giro_antihorario is
	port(
		clk: in std_logic;
		leds: out std_logic_vector(7 downto 0)
	);
end component;

component animacion_llenado is
	port(
		clk: in std_logic;
		leds: out std_logic_vector(7 downto 0)
	);
end component;

component animacion_compresion is
	port(
		clk: in std_logic;
		leds: out std_logic_vector(7 downto 0)
	);
end component;

component mux16a1_8bits is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic_vector (7 downto 0);
		x1  : in std_logic_vector (7 downto 0);
		x2  : in std_logic_vector (7 downto 0);
		x3  : in std_logic_vector (7 downto 0);
		x4  : in std_logic_vector (7 downto 0);
		x5  : in std_logic_vector (7 downto 0);
		x6  : in std_logic_vector (7 downto 0);
		x7  : in std_logic_vector (7 downto 0);
		x8  : in std_logic_vector (7 downto 0);
		x9  : in std_logic_vector (7 downto 0);
		x10 : in std_logic_vector (7 downto 0);
		x11 : in std_logic_vector (7 downto 0);
		x12 : in std_logic_vector (7 downto 0);
		x13 : in std_logic_vector (7 downto 0);
		x14 : in std_logic_vector (7 downto 0);
		x15 : in std_logic_vector (7 downto 0); 
		y:out std_logic_vector(7 downto 0)
	); 
end component;

component deco7segmentos is
	port(
		punto: in std_logic;
		numin : in std_logic_vector(3 downto 0);
		deco_out : out std_logic_vector(7 downto 0)
	);
end component;

component modul_10Hz is
	port (
		clk_in: std_logic;
		clk_out: out std_logic
	);
end component;

signal reloj: std_logic;
signal rotar_horario, rotar_antihorario, compresar, llenar: std_logic_vector (7 downto 0);

begin

MODUL: modul_10Hz
	port map (
		clk_in => clk_in,
		clk_out => reloj
	);

GIRO_HORARIO: animacion_giro_horario
	port map(
		clk => reloj,
		leds => rotar_horario
	);

GIRO_ANTIHORARIO: animacion_giro_antihorario
	port map(
		clk => reloj,
		leds => rotar_antihorario
	);
	
LLENAR1: animacion_llenado
	port map(
		clk => reloj,
		leds => llenar
	);
	
COMPRESION1: animacion_compresion
	port map(
		clk => reloj,
		leds => compresar
	);
	
MUX: mux16a1_8bits 
	port map ( 
		control => hm & compresion & llenado, 
		x0  => "11111111",
		x1  => llenar,
		x2  => compresar,
		x3  => "11111111",
		x4  => rotar_horario,
		x5  => "11111111",
		x6  => rotar_horario,
		x7  => "11111111",
		x8  => rotar_antihorario,
		x9  => "11111111",
		x10 => rotar_antihorario,
		x11 => "11111111",
		x12 => "11111111",
		x13 => "11111111",
		x14 => "11111111",
		x15 => "11111111", 
		y => hex_3
	); 
	
DECO7SEG_HEX0: deco7segmentos
	port map(
		punto => '1',
		numin => segundosx01,
		deco_out => hex_0
	);


DECO7SEG_HEX1: deco7segmentos
	port map(
		punto => '0',
		numin => segundosx1,
		deco_out => hex_1
	);
	
	
DECO7SEG_HEX2: deco7segmentos
	port map(
		punto => '1',
		numin => segundosx10,
		deco_out => hex_2
	);

end architecture;
