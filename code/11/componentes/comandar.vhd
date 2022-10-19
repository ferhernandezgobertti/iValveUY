library IEEE;
use ieee.std_logic_1164.all;

entity comandar is
	port(
		clock: in std_logic;
		reset_datos: in std_logic;
		reset_estado: in std_logic;
		bytes_listos: in std_logic;
		comando: in std_logic_vector (7 downto 0);
		datos: in std_logic_vector (7 downto 0);
		programa_actual: out std_logic_vector (3 downto 0);
		pertenece_grupo_actual: out std_logic_vector (3 downto 0);
		velocidad_angular_actual: out std_logic_vector (7 downto 0);
		temperatura_actual: out std_logic_vector (7 downto 0);
		error: out std_logic;
		start: out std_logic; -- Programa iniciado
		stop: out std_logic -- Parada de Emergencia
	);
end entity;

architecture com of comandar is

component flip_flop_D_1bit_descendente is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;	

component flip_flop_D_4bits is
	port (
		D: in std_logic_vector (3 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector (3 downto 0)
	);
end component;
	
component flip_flop_D_4bits_descendente is
	port (
		D: in std_logic_vector (3 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector (3 downto 0)
	);
end component;

component flip_flop_D_8bits_descendente is
	port (
		D: in std_logic_vector (7 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector (7 downto 0)
	);
end component;

component deco4a16 is
	port(
		entrada: in std_logic_vector(3 downto 0);
		salida: out std_logic_vector(15 downto 0)
	);
end component;

component multiplicador_4bits is
	port (
		a: in std_logic_vector (3 downto 0);
		b: in std_logic_vector (3 downto 0);
		c: out std_logic_vector (7 downto 0)
	);
end component;

component comparador_4bits is
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

component comparador_8bits is
	port(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

signal com: std_logic_vector (15 downto 0);
signal velocidad_angular_registro, velocidad_actual_signal, temp_sensor, temp_actual: std_logic_vector (7 downto 0);
signal programa_actual_signal, comando_filtrado: std_logic_vector (3 downto 0);
signal g1, g2, g3, g4, error_aux, sin_programa_actual, sin_temp_actual, sin_temp_sensor, sin_velocidad_actual, res, rst_datos, rst_estado: std_logic;

begin

DECO_COM: deco4a16
	port map(
		entrada => comando(3 downto 0),
		salida => com
	);

PROG: flip_flop_D_4bits_descendente
	port map(
		D => datos(3 downto 0),
		clk => (com(1) and bytes_listos),
		reset => rst_datos,
		Q => programa_actual_signal
	);
	
MUL: multiplicador_4bits
	port map(
		a => datos(7 downto 4),
		b => datos(3 downto 0),
		c => velocidad_angular_registro
	);
	
VEL: flip_flop_D_8bits_descendente
	port map(
		D => velocidad_angular_registro,
		clk => (com(2) and bytes_listos),
		reset => rst_datos,
		Q => velocidad_actual_signal
	);

GRUP1: flip_flop_D_1bit_descendente
	port map(
		D => datos(0),
		clk => (com(3) and bytes_listos),
		reset => rst_datos,
		Q => g1
	);
	
GRUP2: flip_flop_D_1bit_descendente
	port map(
		D => datos(0),
		clk => (com(4) and bytes_listos),
		reset => rst_datos,
		Q => g2
	);

GRUP3: flip_flop_D_1bit_descendente
	port map(
		D => datos(0),
		clk => (com(5) and bytes_listos),
		reset => rst_datos,
		Q => g3
	);

GRUP4: flip_flop_D_1bit_descendente
	port map(
		D => datos(0),
		clk => (com(6) and bytes_listos),
		reset => rst_datos,
		Q => g4
	);

pertenece_grupo_actual <= (g4 & g3 & g2 & g1);

TEMP: flip_flop_D_8bits_descendente
	port map(
		D => datos,
		clk => (com(7) and bytes_listos),
		reset => rst_datos,
		Q => temp_actual
	);
	
TEMP_SENS: flip_flop_D_8bits_descendente
	port map(
		D => datos,
		clk => (com(8) and bytes_listos),
		reset => rst_estado,
		Q => temp_sensor
	);

COMPA: comparador_8bits
	port map(
		a => temp_sensor,
		b => temp_actual,
		agb => error_aux,
		aeb => open,
		alb => open
	);
	
COMPB: comparador_8bits
	port map(
		a => temp_sensor,
		b => "00000000",
		agb => open,
		aeb => sin_temp_sensor,
		alb => open
	);
	
COMPC: comparador_8bits
	port map(
		a => "00000000",
		b => temp_actual,
		agb => open,
		aeb => sin_temp_actual,
		alb => open
	);
	
COMPD: comparador_8bits
	port map(
		a => "00000000",
		b => velocidad_actual_signal,
		agb => open,
		aeb => sin_velocidad_actual,
		alb => open
	);
	
COMPE: comparador_4bits
	port map(
		a => "0000",
		b => programa_actual_signal,
		agb => open,
		aeb => sin_programa_actual,
		alb => open
	);

error <= error_aux and not(sin_temp_actual) and not(sin_temp_sensor);
temperatura_actual <= temp_actual;
programa_actual <= programa_actual_signal;
velocidad_angular_actual <= velocidad_actual_signal;

STRT: flip_flop_D_1bit_descendente
	port map(
		D => '1',
		clk => (com(9) and bytes_listos and (not(sin_velocidad_actual)) and (not(sin_temp_actual)) and (not(sin_programa_actual))),
		reset => rst_estado,
		Q => start
	);
	
STP: flip_flop_D_1bit_descendente
	port map(
		D => '1',
		clk => (com(10) and bytes_listos),
		reset => rst_estado,
		Q => stop
	);

RESET: flip_flop_D_1bit_descendente
	port map(
		D => '1',
		clk => (com(11) and bytes_listos),
		reset => rst_estado,
		Q => res
	);

rst_estado <= reset_estado or res;
rst_datos <= reset_datos or res;
	
end architecture;