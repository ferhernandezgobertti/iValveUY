library IEEE;
use ieee.std_logic_1164.all;

entity pantalla4 is
	port(
		clock_in: in std_logic;
		rst: in std_logic;
		programa: in std_logic_vector(3 downto 0);
		hex_0: out std_logic_vector (7 downto 0);
		hex_1: out std_logic_vector (7 downto 0);
		hex_2: out std_logic_vector (7 downto 0);
		hex_3: out std_logic_vector (7 downto 0)
	);
end entity;

architecture mostrar4 of pantalla4 is

component comparador_4bits is
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

component contador_4bits is
	port(
		clk: in std_logic;
		carryin: in std_logic;
		updown: in std_logic;
		presetEnable: in std_logic;
		cuentaReset: in std_logic_vector (3 downto 0);
		carryout: out std_logic;
		outputs: out std_logic_vector(3 downto 0)
	);
end component;

component modul_05Hz is
	port (
		clk_in : in std_logic;
		clk_out : out std_logic
	);
end component ;

component mux8a1_1bit is
	port(
		selector: in std_logic_vector (2 downto 0);
		entrada: in std_logic_vector (7 downto 0);
		salida : out std_logic
	);
end component;

component flip_flop_D_2bits is
	port (
		D: in std_logic_vector (1 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector (1 downto 0)
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

component mux4a1_4bits is 
	port ( 
		control : in std_logic_vector (1 downto 0) ; 
		x0: in std_logic_vector (3 downto 0);
		x1: in std_logic_vector (3 downto 0);
		x2: in std_logic_vector (3 downto 0);
		x3: in std_logic_vector (3 downto 0);
		y:out std_logic_vector(3 downto 0)
	); 
end component; 

component deco7segmentos is
	port(
		punto: in std_logic;
		numin : in std_logic_vector(3 downto 0);
		deco_out : out std_logic_vector(7 downto 0)
	);
end component;

--los a son los numeros mas significativos (decenas) y los b las unidades
signal L1_actual_a, L1_actual_b, L2_actual_a, L2_actual_b, L3_actual_a: std_logic_vector (3 downto 0); 
signal L3_actual_b, L4_actual_a, L4_actual_b: std_logic_vector (3 downto 0);
signal D_signal, Q_signal: std_logic_vector (1 downto 0);
signal cuenta, cuenta_comparada, num_hex0, num_hex1, num_hex2: std_logic_vector (3 downto 0);
signal reloj: std_logic;

begin

MODUL: modul_05Hz
	port map (
		clk_in => clock_in,
		clk_out => reloj
	);

CONT: contador_4bits
	port map(
		clk => reloj,
		carryin => '1',
		updown => '1',
		presetEnable => not(cuenta_comparada(3)),
		cuentaReset => "1000",
		carryout => open,
		outputs => cuenta
	);

FF1: flip_flop_D_2bits
	port map(
		D => D_signal,
		clk => reloj,
		reset => rst,
		Q => Q_signal
	);

MUX_L1a: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0001",
		x2 => "0000",
		x3 => "0010",
		x4 => "1000",
		x5 => "0000",
		x6 => "0010",
		x7 => "0000",
		x8 => "0011",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L1_actual_a
	);
	
MUX_L1b: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0010",
		x2 => "0101",
		x3 => "0101",
		x4 => "0000",
		x5 => "0000",
		x6 => "0000",
		x7 => "0101",
		x8 => "0011",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L1_actual_b
	);

MUX_L2a: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0010",
		x2 => "0001",
		x3 => "0010",
		x4 => "0000",
		x5 => "0000",
		x6 => "0001",
		x7 => "0010",
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L2_actual_a
	);
	
MUX_L2b: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0101",
		x2 => "0101",
		x3 => "0101",
		x4 => "0111",
		x5 => "0000",
		x6 => "0000",
		x7 => "0111",
		x8 => "0100",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L2_actual_b
	);
	
MUX_L3a: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0101",
		x2 => "0011",
		x3 => "0010",
		x4 => "0001",
		x5 => "0010",
		x6 => "0011",
		x7 => "0000",
		x8 => "0011",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L3_actual_a
	);
	
MUX_L3b: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0011",
		x2 => "0000",
		x3 => "0101",
		x4 => "0011",
		x5 => "0101",
		x6 => "0000",
		x7 => "1000",
		x8 => "0011",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L3_actual_b
	);
	
MUX_L4a: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0001",
		x2 => "0101",
		x3 => "0010",
		x4 => "0000",
		x5 => "0101",
		x6 => "0100",
		x7 => "0000",
		x8 => "0011",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L4_actual_a
	);
	
MUX_L4b: mux16a1_4bits
	port map(
		control => programa,
		x0 => "0000",
		x1 => "0000",
		x2 => "0000",
		x3 => "0101",
		x4 => "0000",
		x5 => "0000",
		x6 => "0000",
		x7 => "0101",
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => L4_actual_b
	);

COMP_con1: comparador_4bits
	port map(
		a => cuenta,
		b => "0001",
		agb => open,
		aeb => cuenta_comparada(0),
		alb => open
	);


COMP_con2: comparador_4bits
	port map(
		a => cuenta,
		b => "0010",
		agb => open,
		aeb => cuenta_comparada(1),
		alb => open
	);


COMP_con3: comparador_4bits
	port map(
		a => cuenta,
		b => "0011",
		agb => open,
		aeb => cuenta_comparada(2),
		alb => open
	);
	
	
COMP_con4: comparador_4bits
	port map(
		a => cuenta,
		b => "0100",
		agb => open,
		aeb => cuenta_comparada(3),
		alb => open
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

MUX_HEX0: mux16a1_4bits
	port map( 
		control => cuenta,
		x0 => L4_actual_b,
		x1 => L1_actual_b,
		x2 => L2_actual_b,
		x3 => L3_actual_b,
		x4 => "0000",
		x5 => "0000",
		x6 => "0000",
		x7 => "0000",
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => num_hex0
	); 

MUX_HEX1: mux16a1_4bits
	port map( 
		control => cuenta,
		x0 => L4_actual_a,
		x1 => L1_actual_a,
		x2 => L2_actual_a,
		x3 => L3_actual_a,
		x4 => "0000",
		x5 => "0000",
		x6 => "0000",
		x7 => "0000",
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => num_hex1
	); 

MUX1: mux16a1_4bits
	port map(
		control => cuenta,
		x0 => "0100",
		x1 => "0001",
		x2 => "0010",
		x3 => "0011",
		x4 => "0000",
		x5 => "0000",
		x6 => "0000",
		x7 => "0000",
		x8 => "0000",
		x9 => "0000",
		x10 => "0000",
		x11 => "0000",
		x12 => "0000",
		x13 => "0000",
		x14 => "0000",
		x15 => "0000",
		y => num_hex2
	);

D_signal (0) <= (not(Q_signal(1)) and not(Q_signal(0)) and (cuenta_comparada(0))) or (not(Q_signal(1)) and (Q_signal(0)) and not (cuenta_comparada(1))) or (Q_signal(1) and not (Q_signal(0) and cuenta_comparada(2))) or (Q_signal(1) and Q_signal(0) and not (cuenta_Comparada(3)));
D_signal (1) <= (not (Q_signal(1)) and Q_signal(0) and cuenta_comparada(1)) or (Q_signal(1) and not (Q_signal(0))) or (Q_signal(1) and Q_signal(0) and not (cuenta_comparada (3)));

hex_3 <= "11000111";
end architecture;