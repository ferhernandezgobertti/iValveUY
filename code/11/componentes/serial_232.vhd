library IEEE;
use ieee.std_logic_1164.all;

entity serial_232 is
	port(
		clock_in: in std_logic;
		rx: in std_logic;
		reset: in std_logic;
		byte_direccion_out: out std_logic_vector (7 downto 0);
		byte_comando_out: out std_logic_vector (7 downto 0);
		byte_datos_out: out std_logic_vector (7 downto 0);
		bytes_listos: out std_logic;
		contar3: out std_logic_vector (3 downto 0)
	);
end entity;

architecture transmision of serial_232 is

component contador_16bits is
	port(
		clk: in std_logic;
		carryin: in std_logic;
		updown: in std_logic;
		presetEnable: in std_logic;
		cuentaReset: in std_logic_vector (15 downto 0);
		outputs: out std_logic_vector(15 downto 0)
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

component flip_flop_D_1bit_descendente is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;

component flip_flop_D_2bits is
	port(
		D: in std_logic_vector (1 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector (1 downto 0)
	);
end component;

component comparador_16bits is
	port(
		a : in std_logic_vector(15 downto 0);
		b : in std_logic_vector(15 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

component deco2a4 is
	port(
		entrada: in std_logic_vector(1 downto 0);
		salida: out std_logic_vector(3 downto 0)
	);
end component;

component shift_register_1byte is
	port(
		reloj: in std_logic;
		rx: in std_logic;
		rst: in std_logic;
		byte: out std_logic_vector (7 downto 0)
	);
end component;

component shift_register_3bytes is
	port(
		guardar_byte: in std_logic;
		señal: in std_logic_vector (7 downto 0);
		rst: in std_logic;
		byte_direccion: out std_logic_vector (7 downto 0);
		byte_comando: out std_logic_vector (7 downto 0);
		byte_datos: out std_logic_vector (7 downto 0)
	);
end component;

signal reloj115200, reloj, preset1, preset2, preset3: std_logic;
signal cuenta1_igual_217, cuenta1_igual_434, cuenta1_mayor_434, cuenta2_igual_9, cuenta2_igual_9_filtrada, cuenta3_igual_3: std_logic;
signal X_signal: std_logic_vector(3 downto 0);
signal Q_signal, D_signal: std_logic_vector (1 downto 0);
signal byte_actual: std_logic_vector (7 downto 0);
signal cuenta1: std_logic_vector (15 downto 0);
signal cuenta2, cuenta3: std_logic_vector (3 downto 0);


begin

CONT16a: contador_16bits
	port map(
		clk => clock_in,
		carryin => '1',
		updown => '1',
		presetEnable => preset1,
		cuentaReset => "0000000111110100",
		outputs => cuenta1
	);

CONT4a: contador_4bits
	port map(
		clk => reloj115200,
		carryin => '1',
		updown => '1',
		presetEnable => preset2,
		cuentaReset => "1111",
		carryout => open,
		outputs => cuenta2
	);
	
CONT4b: contador_4bits
	port map(
		clk => cuenta2_igual_9_filtrada,
		carryin => '1',
		updown => '1',
		presetEnable => not (preset3),
		cuentaReset => "1111",
		carryout => open,
		outputs => cuenta3
	);
	
FF1: flip_flop_D_1bit
	port map(
		D => cuenta2_igual_9,
		clk => clock_in,
		reset => reset,
		Q => cuenta2_igual_9_filtrada
	);

FF2: flip_flop_D_2bits
	port map(
		D => D_signal,
		clk => clock_in,
		reset => '0',
		Q => Q_signal
	);

COMP16_con217: comparador_16bits
	port map(
		a => cuenta1,
		b => "0000000011011001",
		agb => open,
		aeb => cuenta1_igual_217,
		alb => open
	);

COMP16_con434: comparador_16bits
	port map(
		a => cuenta1,
		b => "0000000110110010",
		agb => cuenta1_mayor_434,
		aeb => cuenta1_igual_434,
		alb => open
	);

	
cuenta2_igual_9 <= ((cuenta2(3)) and not (cuenta2(2)) and not (cuenta2(1)) and (cuenta2(0)));


MOD_10: modul_10Hz
	port map(
		clk_in => clock_in,
		clk_out => reloj
	);

WAI: flip_flop_D_1bit_descendente
	port map(
		D => (not (cuenta3(3)) and not (cuenta3(2)) and (cuenta3(1)) and (cuenta3(0))),
		clk => reloj,
		reset => reset,
		Q => preset3
	);
	
BYTES: flip_flop_D_1bit_descendente
	port map(
		D => (not (cuenta3(3)) and not (cuenta3(2)) and (cuenta3(1)) and (cuenta3(0))),
		clk => reloj,
		reset => reset,
		Q => bytes_listos
	);

DECO: deco2a4
	port map(
		entrada => Q_signal,
		salida => X_signal
	);

SHIFT: shift_register_1byte
	port map(
		reloj => reloj115200,
		rx => rx,
		rst => reset,
		byte => byte_actual
	);


SHIFT_3B: shift_register_3bytes
	port map(
		guardar_byte => cuenta2_igual_9_filtrada,
		señal => byte_actual,
		rst => reset,
		byte_direccion => byte_direccion_out,
		byte_comando => byte_comando_out,
		byte_datos => byte_datos_out
	);

D_signal(0) <= (X_signal(0) and not (rx)) or (not (cuenta1_igual_217) and X_signal(1)) or (cuenta1_igual_434 and X_signal(2) and not(cuenta2_igual_9_filtrada));

D_signal(1) <= (X_signal(1) and cuenta1_igual_217) or (not (cuenta1_igual_434) and X_signal(2));


preset1 <= not (X_signal(0) or (X_signal(1) and cuenta1_mayor_434));
preset2 <= not (X_signal(0) and cuenta2_igual_9_filtrada);

reloj115200 <= X_signal(2);

contar3 <= cuenta3;

end architecture;