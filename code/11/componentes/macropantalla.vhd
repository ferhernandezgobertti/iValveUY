library IEEE;
use ieee.std_logic_1164.all;

entity macropantalla is
	port(
		clk: in std_logic;
		reset: in std_logic;
		llenar: in std_logic;
		comprimir: in std_logic;
		girar: in std_logic_vector (1 downto 0);
		switchs: in std_logic_vector (1 downto 0);
		decimas_bin: in std_logic_vector (3 downto 0);
		seg_bin: in std_logic_vector (3 downto 0);
		decenas_bin: in std_logic_vector (3 downto 0);
		programa: in std_logic_vector(3 downto 0);
		velocidad: in std_logic_vector (7 downto 0);
		temperatura: in std_logic_vector (7 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0);
		animacion: out std_logic_vector (7 downto 0)
	);
end entity;

architecture pantallas of macropantalla is

component pantalla1 is
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
end component;

component pantalla2 is
	port(
		velocidad_mezcla: in std_logic_vector (7 downto 0);
		hm: in std_logic_vector (1 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0)
	);
end component;

component pantalla3 is
	port(
		temperatura_mezcla: in std_logic_vector (7 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0)
	);
end component;

component pantalla4 is
	port(
		clock_in: in std_logic;
		programa: in std_logic_vector(3 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0)
	);
end component;

component mux4a1_8bits is 
	port ( 
		control : in std_logic_vector (1 downto 0); 
		x0  : in std_logic_vector (7 downto 0);
		x1  : in std_logic_vector (7 downto 0);
		x2  : in std_logic_vector (7 downto 0);
		x3  : in std_logic_vector (7 downto 0);
		y:out std_logic_vector(7 downto 0)
	); 
end component; 

component modul_10Hz is
	port (
		clk_in : std_logic;
		clk_out : out std_logic
	);
end component ;

component contador_decimal is
	port (
		clock: in std_logic;
		binario1: out std_logic_vector(3 downto 0);
		binario2: out std_logic_vector(3 downto 0);
		binario3: out std_logic_vector(3 downto 0);
		cuenta1: out std_logic_vector(7 downto 0);
		cuenta2: out std_logic_vector(7 downto 0);
		cuenta3: out std_logic_vector(7 downto 0);
		carryin: in std_logic;
		ud: in std_logic;
		reset: in std_logic
	);
end component;

signal reloj: std_logic;
signal hex0_P1, hex0_P2, hex0_P3, hex0_P4: std_logic_vector (7 downto 0);
signal hex1_P1, hex1_P2, hex1_P3, hex1_P4: std_logic_vector (7 downto 0);
signal hex2_P1, hex2_P2, hex2_P3, hex2_P4: std_logic_vector (7 downto 0);
signal hex3_P1, hex3_P2, hex3_P3, hex3_P4: std_logic_vector (7 downto 0);

begin

P1: pantalla1
	port map (
		clk_in => clk,
		rst => reset,
		hm => girar,
		llenado => llenar,
		compresion => comprimir,
		segundosx10 => decenas_bin,
		segundosx1 => seg_bin,
		segundosx01 => decimas_bin,
		hex_0 => hex0_P1,
		hex_1 => hex1_P1,
		hex_2 => hex2_P1,
		hex_3 => hex3_P1
	);
	
animacion <= hex3_P1;
	
P2: pantalla2
	port map (
		velocidad_mezcla => velocidad,
		hm => girar,
		hex_0 => hex0_P2,
		hex_1 => hex1_P2,
		hex_2 => hex2_P2,
		hex_3 => hex3_P2
	);

P3: pantalla3
	port map (
		temperatura_mezcla => temperatura,
		hex_0 => hex0_P3,
		hex_1 => hex1_P3,
		hex_2 => hex2_P3,
		hex_3 => hex3_P3
	);

P4: pantalla4
	port map (
		clock_in => clk,
		programa => programa,
		hex_0 => hex0_P4,
		hex_1 => hex1_P4,
		hex_2 => hex2_P4,
		hex_3 => hex3_P4
	);

MUX_HEX0: mux4a1_8bits 
	port map ( 
		control => switchs, 
		x0  => hex0_P1,
		x1  => hex0_P2,
		x2  => hex0_P3,
		x3  => hex0_P4,
		y => hex_0
	);

MUX_HEX1: mux4a1_8bits 
	port map ( 
		control => switchs, 
		x0  => hex1_P1,
		x1  => hex1_P2,
		x2  => hex1_P3,
		x3  => hex1_P4,
		y => hex_1
	);

MUX_HEX2: mux4a1_8bits 
	port map ( 
		control => switchs, 
		x0  => hex2_P1,
		x1  => hex2_P2,
		x2  => hex2_P3,
		x3  => hex2_P4,
		y => hex_2
	);

MUX_HEX3: mux4a1_8bits 
	port map ( 
		control => switchs, 
		x0  => hex3_P1,
		x1  => hex3_P2,
		x2  => hex3_P3,
		x3  => hex3_P4,
		y => hex_3
	);

end architecture;
