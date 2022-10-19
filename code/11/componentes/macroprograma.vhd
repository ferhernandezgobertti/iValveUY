library IEEE;
use ieee.std_logic_1164.all;

entity macroprograma is
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
end entity;

architecture programas of macroprograma is

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

component programa1 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa2 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa3 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa4 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa5 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa6 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa7 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

component programa8 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end component;

signal llenado_P1, llenado_P2, llenado_P3, llenado_P4, llenado_P5, llenado_P6, llenado_P7, llenado_P8: std_logic_vector (3 downto 0);
signal compresion_P1, compresion_P2, compresion_P3, compresion_P4, compresion_P5, compresion_P6, compresion_P7, compresion_P8: std_logic;
signal giro_P1, giro_P2, giro_P3, giro_P4, giro_P5, giro_P6, giro_P7, giro_P8: std_logic_vector (1 downto 0);
signal calor_P1, calor_P2, calor_P3, calor_P4, calor_P5, calor_P6, calor_P7, calor_P8: std_logic;
signal vaciado_P1, vaciado_P2, vaciado_P3, vaciado_P4, vaciado_P5, vaciado_P6, vaciado_P7, vaciado_P8: std_logic;

begin 


MUX_COMPRIMIR: mux16a1_1bit
	port map (
		control => programa_in,
		x0 => '0',
		x1 => compresion_P1,
		x2 => compresion_P2,
		x3 => compresion_P3,
		x4 => compresion_P4,
		x5 => compresion_P5,
		x6 => compresion_P6,
		x7 => compresion_P7,
		x8 => compresion_P8,
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => comprimir
	);
	
MUX_CALENTAR: mux16a1_1bit
	port map (
		control => programa_in,
		x0 => '0',
		x1 => calor_P1,
		x2 => calor_P2,
		x3 => calor_P3,
		x4 => calor_P4,
		x5 => calor_P5,
		x6 => calor_P6,
		x7 => calor_P7,
		x8 => calor_P8,
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
		control => programa_in,
		x0 => '0',
		x1 => vaciado_P1,
		x2 => vaciado_P2,
		x3 => vaciado_P3,
		x4 => vaciado_P4,
		x5 => vaciado_P5,
		x6 => vaciado_P6,
		x7 => vaciado_P7,
		x8 => vaciado_P8,
		x9 => '0',
		x10 => '0',
		x11 => '0',
		x12 => '0',
		x13 => '0',
		x14 => '0',
		x15 => '0', 
		y => vaciar
	);

MUX_GIRAR: mux16a1_2bits
	port map ( 
		control => programa_in, 
		x0 => "00",
		x1 => giro_P1,
		x2 => giro_P2,
		x3 => giro_P3,
		x4 => giro_P4,
		x5 => giro_P5,
		x6 => giro_P6,
		x7 => giro_P7,
		x8 => giro_P8,
		x9 => "00",
		x10 => "00",
		x11 => "00",
		x12 => "00",
		x13 => "00",
		x14 => "00",
		x15 => "00", 
		y => girar
	);

MUX_LLENAR: mux16a1_4bits
	port map ( 
		control => programa_in,
		x0 => "0000",
		x1 => llenado_P1,
		x2 => llenado_P2,
		x3 => llenado_P3,
		x4 => llenado_P4,
		x5 => llenado_P5,
		x6 => llenado_P6,
		x7 => llenado_P7,
		x8 => llenado_P8,
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000", 
		y => llenar
	);
	
P1: programa1
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P1,
		compresion => compresion_P1,
		giro => giro_P1,
		calor => calor_P1,
		vaciado => vaciado_P1
		);
		
P2: programa2
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P2,
		compresion => compresion_P2,
		giro => giro_P2,
		calor => calor_P2,
		vaciado => vaciado_P2
	);
	
P3: programa3
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P3,
		compresion => compresion_P3,
		giro => giro_P3,
		calor => calor_P3,
		vaciado => vaciado_P3
	);
	
P4: programa4
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P4,
		compresion => compresion_P4,
		giro => giro_P4,
		calor => calor_P4,
		vaciado => vaciado_P4
	);
	
P5: programa5
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P5,
		compresion => compresion_P5,
		giro => giro_P5,
		calor => calor_P5,
		vaciado => vaciado_P5
	);

P6: programa6
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P6,
		compresion => compresion_P6,
		giro => giro_P6,
		calor => calor_P6,
		vaciado => vaciado_P6
	);

P7: programa7
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P7,
		compresion => compresion_P7,
		giro => giro_P7,
		calor => calor_P7,
		vaciado => vaciado_P7
	);
	
P8: programa8
	port map (
		decenas => segundosx10,
		segundos => segundosx1,
		decimas => segundosx01,
		clock => reloj,
		llenado => llenado_P8,
		compresion => compresion_P8,
		giro => giro_P8,
		calor => calor_P8,
		vaciado => vaciado_P8
	);

end architecture;