library IEEE;
use ieee.std_logic_1164.all;

entity mezcladora is
	port(
		clock: in std_logic;
		reset_general: in std_logic;
		reset_datos: in std_logic;
		reset_estado: in std_logic;
		stop_in: in std_logic;
		switches: in std_logic_vector (9 downto 0);
		maquina: in std_logic_vector (1 downto 0);
		direccion: in std_logic_vector (7 downto 0);
		comando: in std_logic_vector (7 downto 0);
		datos: in std_logic_vector (7 downto 0);
		bytes_listos: in std_logic;
		hex0: out std_logic_vector (7 downto 0);
		hex1: out std_logic_vector (7 downto 0);
		hex2: out std_logic_vector (7 downto 0);
		hex3: out std_logic_vector (7 downto 0);
		llenar: out std_logic_vector (3 downto 0);
		comprimir: out std_logic;
		girar: out std_logic_vector (1 downto 0);
		calentar: out std_logic;
		vaciar: out std_logic;
		programa_configurado: out std_logic_vector (3 downto 0);
		error_out: out std_logic;
		stop_out: out std_logic;
		animacion_actual: out std_logic_vector (7 downto 0)
	);
end entity;

architecture mezclar_mezcladora of mezcladora is
	
component direccionar is
	port(
		numero_mezcladora: in std_logic_vector (1 downto 0);
		direccion: in std_logic_vector (7 downto 0);
		pertenece_grupo: in std_logic_vector (3 downto 0);
		M: out std_logic
	);
end component;

component comandar is
	port(
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
		start: out std_logic; -- Comenzar programa
		stop: out std_logic -- Parada de Emergencia
	);
end component;

component macroprograma is
	port(
		segundosx10: in std_logic_vector (3 downto 0);
		segundosx1: in std_logic_vector (3 downto 0);
		segundosx01: in std_logic_vector (3 downto 0);
		programa_in: in std_logic_vector (3 downto 0);
		reloj: in std_logic;
		llenar: out std_logic_vector (3 downto 0);
		comprimir: out std_logic;
		girar: out std_logic_vector (1 downto 0);
		calentar: out std_logic;
		vaciar: out std_logic
	);
end component;

component macropantalla is
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
end component;

component comparador_2bits is
	port(
		a : in std_logic_vector(1 downto 0);
		b : in std_logic_vector(1 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

component mux16a1_2bits is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0 ?: in std_logic_vector (1 downto 0);
		x1 ?: in std_logic_vector (1 downto 0);
		x2 ?: in std_logic_vector (1 downto 0);
		x3 ?: in std_logic_vector (1 downto 0);
		x4 ?: in std_logic_vector (1 downto 0);
		x5 ?: in std_logic_vector (1 downto 0);
		x6 ?: in std_logic_vector (1 downto 0);
		x7 ?: in std_logic_vector (1 downto 0);
		x8? : in std_logic_vector (1 downto 0);
		x9? : in std_logic_vector (1 downto 0);
		x10?: in std_logic_vector (1 downto 0);
		x11?: in std_logic_vector (1 downto 0);
		x12?: in std_logic_vector (1 downto 0);
		x13?: in std_logic_vector (1 downto 0);
		x14?: in std_logic_vector (1 downto 0);
		x15?: in std_logic_vector (1 downto 0); 
		y:out std_logic_vector(1 downto 0)
	); 
end component; 

component mux2a1_4bits is
	port(
		selector : in std_logic;
		entrada1 : in std_logic_vector(3 downto 0);
		entrada2 : in std_logic_vector(3 downto 0);
		salida : out std_logic_vector(3 downto 0)
	);
end component;

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

component modul_10Hz is
	port (
		clk_in : std_logic;
		clk_out : out std_logic
	);
end component;

component flip_flop_D_1bit is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;

signal start_signal, stop_signal, stop_manual, error_signal, programar_manual, calentado, compresion, vaciado, reloj, condiciones, M_signal: std_logic; 
signal maquina_switchs, girado: std_logic_vector (1 downto 0);
signal programa_signal, programa_mezclar, llenado, grupo: std_logic_vector (3 downto 0);
signal decimas_signal, unidades_signal, decenas_signal: std_logic_vector (3 downto 0);
signal velocidad_signal, temperatura_signal: std_logic_vector (7 downto 0);

begin

F: flip_flop_D_1bit
	port map(
		D => '1',
		clk => not(stop_in),
		reset => reset_general,
		Q => stop_manual
	);

condiciones <= (start_signal or (programar_manual and (switches(6) or switches (5) or switches(4) or switches(3)))) and (programa_signal(0) or programa_signal(1) or programa_signal(2) or programa_signal(3));

DIRECCION1: direccionar
	port map(
		numero_mezcladora => maquina,
		direccion => direccion,
		pertenece_grupo => grupo,
		M => M_signal
	);

COMANDO1: comandar
	port map (
		reset_datos => reset_datos or reset_general,
		reset_estado => reset_estado or reset_general,
		bytes_listos => bytes_listos and M_signal,
		comando => comando,
		datos => datos,
		programa_actual => programa_signal,
		pertenece_grupo_actual => grupo,
		velocidad_angular_actual => velocidad_signal,
		temperatura_actual => temperatura_signal,
		error => error_signal,
		start => start_signal, -- Programa iniciado
		stop => stop_signal -- Parada de Emergencia
	);

error_out <= error_signal;
stop_out <= stop_signal;

MODUL1: modul_10Hz
	port map (
		clk_in => clock,
		clk_out => reloj
	);

CONT: contador_decimal
	port map (
		clock => reloj,
		binario1 => decimas_signal,
		binario2 => unidades_signal,
		binario3 => decenas_signal,
		cuenta1 => open,
		cuenta2 => open,
		cuenta3 => open,
		carryin => (switches(7) or error_signal or not(condiciones)),
		ud => '1',
		reset => (reset_estado or reset_general or stop_manual or stop_signal)
	);
	

	
MACROPROGRAMA1: macroprograma
	port map (
		segundosx10 => decenas_signal,
		segundosx1 => unidades_signal,
		segundosx01 => decimas_signal,
		programa_in => programa_signal,
		reloj => clock,
		llenar => llenado,
		comprimir => compresion,
		girar => girado,
		calentar => calentado,
		vaciar => vaciado
	);
	
MACROPANTALLA1: macropantalla
	port map (
		clk => clock and start_signal,
		reset => reset_estado or reset_general or stop_manual,
		llenar => llenado(0) or llenado(1) or llenado(2) or llenado(3),
		comprimir => compresion,
		girar => girado,
		switchs => switches(9 downto 8),
		decimas_bin => decimas_signal,
		seg_bin => unidades_signal,
		decenas_bin => decenas_signal,
		programa => programa_signal,
		velocidad => velocidad_signal,
		temperatura => temperatura_signal,
		hex_0 => hex0,
		hex_1 => hex1,
		hex_2 => hex2,
		hex_3 => hex3,
		animacion => animacion_actual
	);

COMP1: comparador_2bits
	port map (
		a => maquina,
		b => maquina_switchs,
		agb => open,
		aeb => programar_manual,
		alb => open
	);

MUX1: mux16a1_2bits
	port map ( 
		control => switches(6 downto 3),
		x0 => "00",
		x1 => "00",
		x2 => "01",
		x3 => "00",
		x4 => "10",
		x5 => "00",
		x6 => "00",
		x7 => "00",
		x8?=> "11",
		x9?=> "00",
		x10?=> "00",
		x11?=> "00",
		x12?=> "00",
		x13?=> "00",
		x14?=> "00",
		x15?=> "00",
		y => maquina_switchs
	); 

llenar <= llenado;
comprimir <= compresion;
calentar <= calentado;
girar <= girado;
vaciar <= vaciado;
programa_configurado <= programa_signal;
	
end architecture;