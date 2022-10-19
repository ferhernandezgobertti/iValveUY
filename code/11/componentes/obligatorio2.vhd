library IEEE;
use ieee.std_logic_1164.all;

entity obligatorio2 is
	port(
		rx_in: in std_logic; 
		clock: in std_logic;
		switchs: in std_logic_vector (9 downto 0);
		botones: in std_logic_vector (2 downto 0);
		hex0: out std_logic_vector (7 downto 0);
		hex1: out std_logic_vector (7 downto 0);
		hex2: out std_logic_vector (7 downto 0);
		hex3: out std_logic_vector (7 downto 0);
		llenar: out std_logic_vector (3 downto 0);
		comprimir: out std_logic;
		giro: out std_logic;
		calentar: out std_logic;
		vaciar: out std_logic;
		error: out std_logic;
		stop_salida: out std_logic;
		Mss: out std_logic_vector(3 downto 0)
	);
end entity;

architecture macrobloque of obligatorio2 is

component mezcladora is
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
end component;

component flip_flop_D_1bit is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;

component modul_2Hz is
	port (
		clk_in : std_logic;
		clk_out : out std_logic
	);
end component;

component serial_232 is
	port(
		clock_in: in std_logic;
		rx: in std_logic;
		reset: in std_logic;
		byte_direccion_out: out std_logic_vector (7 downto 0);
		byte_comando_out: out std_logic_vector (7 downto 0);
		byte_datos_out: out std_logic_vector (7 downto 0);
		bytes_listos: out std_logic
	);
end component;

component contador_decimal is
	port (
		clock: in std_logic;
		cuenta1: out std_logic_vector(7 downto 0);
		cuenta2: out std_logic_vector(7 downto 0);
		cuenta3: out std_logic_vector(7 downto 0);
		carryin: in std_logic;
		ud: in std_logic;
		reset: in std_logic
	);
end component;

component mux2a1_8bits is
	port(
		selector : in std_logic;
		entrada1 : in std_logic_vector(7 downto 0);
		entrada2 : in std_logic_vector(7 downto 0);
		salida : out std_logic_vector(7 downto 0)
	);
end component;

component mux16a1_1bit is
	port(
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic;
		x1  : in std_logic;
		x2  : in std_logic;
		x3  : in std_logic;
		x4  : in std_logic;
		x5  : in std_logic;
		x6  : in std_logic;
		x7  : in std_logic;
		x8  : in std_logic;
		x9  : in std_logic;
		x10 : in std_logic;
		x11 : in std_logic;
		x12 : in std_logic;
		x13 : in std_logic;
		x14 : in std_logic;
		x15 : in std_logic; 
		y:out std_logic
	);
end component;

component mux16a1_2bits is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic_vector (1 downto 0);
		x1  : in std_logic_vector (1 downto 0);
		x2  : in std_logic_vector (1 downto 0);
		x3  : in std_logic_vector (1 downto 0);
		x4  : in std_logic_vector (1 downto 0);
		x5  : in std_logic_vector (1 downto 0);
		x6  : in std_logic_vector (1 downto 0);
		x7  : in std_logic_vector (1 downto 0);
		x8  : in std_logic_vector (1 downto 0);
		x9  : in std_logic_vector (1 downto 0);
		x10 : in std_logic_vector (1 downto 0);
		x11 : in std_logic_vector (1 downto 0);
		x12 : in std_logic_vector (1 downto 0);
		x13 : in std_logic_vector (1 downto 0);
		x14 : in std_logic_vector (1 downto 0);
		x15 : in std_logic_vector (1 downto 0); 
		y:out std_logic_vector(1 downto 0)
	); 
end component; 

component mux16a1_4bits is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic_vector (3 downto 0);
		x1  : in std_logic_vector (3 downto 0);
		x2  : in std_logic_vector (3 downto 0);
		x3  : in std_logic_vector (3 downto 0);
		x4  : in std_logic_vector (3 downto 0);
		x5  : in std_logic_vector (3 downto 0);
		x6  : in std_logic_vector (3 downto 0);
		x7  : in std_logic_vector (3 downto 0);
		x8  : in std_logic_vector (3 downto 0);
		x9  : in std_logic_vector (3 downto 0);
		x10 : in std_logic_vector (3 downto 0);
		x11 : in std_logic_vector (3 downto 0);
		x12 : in std_logic_vector (3 downto 0);
		x13 : in std_logic_vector (3 downto 0);
		x14 : in std_logic_vector (3 downto 0);
		x15 : in std_logic_vector (3 downto 0); 
		y:out std_logic_vector(3 downto 0)
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

signal reloj_2Hz, bytes_listos_signal, reset_general, reset_estado, reset_datos: std_logic;
signal m1_signal, m2_signal, m3_signal, m4_signal, comprimir_m1, comprimir_m2, comprimir_m3, comprimir_m4: std_logic;
signal calentar_m1, calentar_m2, calentar_m3, calentar_m4, vaciar_m1, vaciar_m2, vaciar_m3, vaciar_m4: std_logic;
signal error_m1, error_m2, error_m3, error_m4, stop_m1, stop_m2, stop_m3, stop_m4: std_logic;
signal girar_m1, girar_m2, girar_m3, girar_m4, girar: std_logic_vector (1 downto 0);
signal btns: std_logic_vector (2 downto 0);
signal llenar_m1, llenar_m2, llenar_m3, llenar_m4: std_logic_vector (3 downto 0);
signal programa_m1, programa_m2, programa_m3, programa_m4, programa_actual: std_logic_vector (3 downto 0);
signal direccion_signal, comando_signal, datos_signal, programa_actual_deco: std_logic_vector (7 downto 0);
signal decimas_signal, unidades_signal, decenas_signal: std_logic_vector (7 downto 0);
signal display_error, animacion_m1, animacion_m2, animacion_m3, animacion_m4: std_logic_vector (7 downto 0);
signal hex0_m1, hex0_m2, hex0_m3, hex0_m4, hex0_general, hex1_m1, hex1_m2, hex1_m3, hex1_m4, hex1_general: std_logic_vector (7 downto 0);
signal hex2_m1, hex2_m2, hex2_m3, hex2_m4, hex2_general, hex3_m1, hex3_m2, hex3_m3, hex3_m4, hex3_general: std_logic_vector (7 downto 0);
signal hex0_aux, hex1_aux, hex2_aux, hex3_aux: std_logic_vector(7 downto 0);

begin

MODUL2Hz: modul_2Hz
	port map (
		clk_in => clock,
		clk_out => reloj_2Hz
	);

SERIAL1: serial_232
	port map (
		clock_in => clock,
		rx => rx_in,
		reset => reset_estado or reset_general,
		byte_direccion_out => direccion_signal,
		byte_comando_out => comando_signal,
		byte_datos_out => datos_signal,
		bytes_listos => bytes_listos_signal
	);
	
MEZCLADORA_1: mezcladora
	port map (
		clock => clock,
		reset_general => reset_general,
		reset_datos => reset_datos,
		reset_estado => reset_estado,
		stop_in => btns(0),
		switches => switchs,
		maquina => "00",
		direccion => direccion_signal,
		comando => comando_signal,
		datos => datos_signal,
		bytes_listos => bytes_listos_signal,
		hex0 => hex0_m1,
		hex1 => hex1_m1,
		hex2 => hex2_m1,
		hex3 => hex3_m1,
		llenar => llenar_m1,
		comprimir => comprimir_m1,
		girar => girar_m1,
		calentar => calentar_m1,
		vaciar => vaciar_m1,
		programa_configurado => programa_m1,
		error_out => error_m1,
		stop_out => stop_m1,
		animacion_actual => animacion_m1
	);

MEZCLADORA_2: mezcladora
	port map (
		clock => clock,
		reset_general => reset_general,
		reset_datos => reset_datos,
		reset_estado => reset_estado,
		stop_in => btns(0),
		switches => switchs,
		maquina => "01",
		direccion => direccion_signal,
		comando => comando_signal,
		datos => datos_signal,
		bytes_listos => bytes_listos_signal,
		hex0 => hex0_m2,
		hex1 => hex1_m2,
		hex2 => hex2_m2,
		hex3 => hex3_m2,
		llenar => llenar_m2,
		comprimir => comprimir_m2,
		girar => girar_m2,
		calentar => calentar_m2,
		vaciar => vaciar_m2,
		programa_configurado => programa_m2,
		error_out => error_m2,
		stop_out => stop_m2,
		animacion_actual => animacion_m2
	);
	
MEZCLADORA_3: mezcladora
	port map (
		clock => clock,
		reset_general => reset_general,
		reset_datos => reset_datos,
		reset_estado => reset_estado,
		stop_in => btns(0),
		switches => switchs,
		maquina => "10",
		direccion => direccion_signal,
		comando => comando_signal,
		datos => datos_signal,
		bytes_listos => bytes_listos_signal,
		hex0 => hex0_m3,
		hex1 => hex1_m3,
		hex2 => hex2_m3,
		hex3 => hex3_m3,
		llenar => llenar_m3,
		comprimir => comprimir_m3,
		girar => girar_m3,
		calentar => calentar_m3,
		vaciar => vaciar_m3,
		programa_configurado => programa_m3,
		error_out => error_m3,
		stop_out => stop_m3,
		animacion_actual => animacion_m3
	);
	
MEZCLADORA_4: mezcladora
	port map (
		clock => clock,
		reset_general => reset_general,
		reset_datos => reset_datos,
		reset_estado => reset_estado,
		stop_in => btns(0),
		switches => switchs,
		maquina => "11",
		direccion => direccion_signal,
		comando => comando_signal,
		datos => datos_signal,
		bytes_listos => bytes_listos_signal,
		hex0 => hex0_m4,
		hex1 => hex1_m4,
		hex2 => hex2_m4,
		hex3 => hex3_m4,
		llenar => llenar_m4,
		comprimir => comprimir_m4,
		girar => girar_m4,
		calentar => calentar_m4,
		vaciar => vaciar_m4,
		programa_configurado => programa_m4,
		error_out => error_m4,
		stop_out => stop_m4,
		animacion_actual => animacion_m4
	);


MUX_HEX0: mux16a1_8bits 
	port map ( 
		control => btns(2) & switchs(2 downto 0),
		x0 => hex0_general,
		x1 => hex0_m1,
		x2 => "11111111",
		x3 => hex0_m2,
		x4 => "11111111",
		x5 => hex0_m3,
		x6 => "11111111",
		x7 => hex0_m4,
		x8 => hex0_general,
		x9 => programa_actual_deco,
		x10 => "11111111",
		x11 => programa_actual_deco,
		x12 => "11111111",
		x13 => programa_actual_deco,
		x14 => "11111111",
		x15 => programa_actual_deco, 
		y => hex0
	); 


MUX_HEX1: mux16a1_8bits 
	port map ( 
		control => btns(2) & switchs(2 downto 0),
		x0 => hex1_general,
		x1 => hex1_m1,
		x2 => "11111111",
		x3 => hex1_m2,
		x4 => "11111111",
		x5 => hex1_m3,
		x6 => "11111111",
		x7 => hex1_m4,
		x8 => hex0_general,
		x9 => "10001100",
		x10 => "11111111",
		x11 => "10001100",
		x12 => "11111111",
		x13 => "10001100",
		x14 => "11111111",
		x15 => "10001100",
		y => hex1
	); 
	
	
MUX_HEX2: mux16a1_8bits 
	port map ( 
		control => btns(2) & switchs(2 downto 0),
		x0 => hex2_general,
		x1 => hex2_m1,
		x2 => "11111111",
		x3 => hex2_m2,
		x4 => "11111111",
		x5 => hex2_m3,
		x6 => "11111111",
		x7 => hex2_m4,
		x8 => hex0_general,
		x9 => "11111001",
		x10 => "11111111",
		x11 => "10100100",
		x12 => "11111111",
		x13 => "10110000",
		x14 => "11111111",
		x15 => "10011001", 
		y => hex2
	); 
	
	
MUX_HEX3: mux16a1_8bits 
	port map ( 
		control => btns(2) & switchs(2 downto 0),
		x0 => hex3_general,
		x1 => hex3_m1,
		x2 => "11111111",
		x3 => hex3_m2,
		x4 => "11111111",
		x5 => hex3_m3,
		x6 => "11111111",
		x7 => hex3_m4,
		x8 => hex0_general,
		x9 => "11000000",
		x10 => "11111111",
		x11 => "11000000",
		x12 => "11111111",
		x13 => "11000000",
		x14 => "11111111",
		x15 => "11000000", 
		y =>  hex3
	); 

MUX_LLENAR: mux16a1_4bits
	port map ( 
		control => '0' & switchs(2 downto 0),
		x0 => "0000",
		x1 => llenar_m1,
		x2 => "0000",
		x3 => llenar_m2,
		x4 => "0000",
		x5 => llenar_m3,
		x6 => "0000",
		x7 => llenar_m4,
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000", 
		y => llenar
	);

MUX_COMPRIMIR: mux16a1_1bit
	port map (
		control => '0' & switchs(2 downto 0),
		x0 => '0',
		x1 => comprimir_m1,
		x2 => '0',
		x3 => comprimir_m2,
		x4 => '0',
		x5 => comprimir_m3,
		x6 => '0',
		x7 => comprimir_m4,
		x8 => '0',
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => comprimir
	);
	
MUX_GIRAR: mux16a1_2bits
	port map ( 
		control => '0' & switchs(2 downto 0), 
		x0 => "00",
		x1 => girar_m1,
		x2 => "00",
		x3 => girar_m2,
		x4 => "00",
		x5 => girar_m3,
		x6 => "00",
		x7 => girar_m4,
		x8 => "00",
		x9 => "00",
		x10 => "00",
		x11 => "00",
		x12 => "00",
		x13 => "00",
		x14 => "00",
		x15 => "00", 
		y => girar
	);
	
MUX_CALENTAR: mux16a1_1bit
	port map (
		control => '0' & switchs(2 downto 0),
		x0 => '0',
		x1 => calentar_m1,
		x2 => '0',
		x3 => calentar_m2,
		x4 => '0',
		x5 => calentar_m3,
		x6 => '0',
		x7 => calentar_m4,
		x8 => '0',
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => calentar
	);
	
MUX_VACIAR: mux16a1_1bit
	port map (
		control => '0' & switchs(2 downto 0),
		x0 => '0',
		x1 => vaciar_m1,
		x2 => '0',
		x3 => vaciar_m2,
		x4 => '0',
		x5 => vaciar_m3,
		x6 => '0',
		x7 => vaciar_m4,
		x8 => '0',
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => vaciar
		);

MUX_PROGRAMAR: mux16a1_4bits
	port map ( 
		control => '0' & switchs(2 downto 0),
		x0 => "0000",
		x1 => programa_m1,
		x2 => "0000",
		x3 => programa_m2,
		x4 => "0000",
		x5 => programa_m3,
		x6 => "0000",
		x7 => programa_m4,
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000", 
		y => programa_actual
	);

MUX_ERROR: mux16a1_1bit
	port map (
		control => '0' & switchs(2 downto 0),
		x0 => '0',
		x1 => error_m1,
		x2 => '0',
		x3 => error_m2,
		x4 => '0',
		x5 => error_m3,
		x6 => '0',
		x7 => error_m4,
		x8 => '0',
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => error
	);
	
MUX_STOP: mux16a1_1bit
	port map (
		control => '0' & switchs(2 downto 0),
		x0 => '0',
		x1 => stop_m1,
		x2 => '0',
		x3 => stop_m2,
		x4 => '0',
		x5 => stop_m3,
		x6 => '0',
		x7 => stop_m4,
		x8 => '0',
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => stop_salida
	);

DECO1: deco7segmentos
	port map (
		punto => '1',
		numin => programa_actual,
		deco_out => programa_actual_deco
	);

MUX2a1_ERROR4: mux2a1_8bits
	port map (
		selector => error_m4 or stop_m4,
		entrada1 => animacion_m4,
		entrada2 => display_error,
		salida => hex0_general
	);

MUX2a1_ERROR3: mux2a1_8bits
	port map (
		selector => error_m3 or stop_m3,
		entrada1 => animacion_m3,
		entrada2 => display_error,
		salida => hex1_general
	);
	
MUX2a1_ERROR2: mux2a1_8bits
	port map (
		selector => error_m2 or stop_m2,
		entrada1 => animacion_m2,
		entrada2 => display_error,
		salida => hex2_general
	);

MUX2a1_ERROR1: mux2a1_8bits
	port map (
		selector => error_m1 or stop_m1,
		entrada1 => animacion_m1,
		entrada2 => display_error,
		salida => hex3_general
	);

MUX_E: mux2a1_8bits
	port map (
		selector => reloj_2Hz,
		entrada1 => "11111111",
		entrada2 => "10000110",
		salida => display_error
	);
	
reset_general <= btns(1);
reset_estado <= btns(1);
reset_datos <= btns(1);
giro <= girar(0) or girar(1);
btns <= not(botones);
	
end architecture;