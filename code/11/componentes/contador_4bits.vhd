library IEEE;
use ieee.std_logic_1164.all;

entity contador_4bits is
	port(
		clk: in std_logic;
		carryin: in std_logic;
		updown: in std_logic;
		presetEnable: in std_logic;
		cuentaReset: in std_logic_vector (3 downto 0);
		carryout: out std_logic;
		outputs: out std_logic_vector(3 downto 0)
	);
end entity;

architecture contar of contador_4bits is

component mux2a1_4bits is
	port(
		selector : in std_logic;
		entrada1 : in std_logic_vector(3 downto 0);
		entrada2 : in std_logic_vector(3 downto 0);
		salida : out std_logic_vector(3 downto 0)
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

component sumador_4bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		s : out std_logic_vector(3 downto 0);
		cout : out std_logic
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

signal suma, resta, mux, cuenta, Dsignal: std_logic_vector (3 downto 0);
signal r, igual: std_logic;

begin

M1: mux2a1_4bits
	port map (
		selector => carryin,
		entrada1 => cuenta,
		entrada2 => mux,
		salida => Dsignal
	);


M2: mux2a1_4bits
	port map (
		selector => not(updown), 
		entrada1 => suma,
		entrada2 => resta,
		salida => mux
	);

FF: flip_flop_D_4bits
	port map (
		D => Dsignal,
		clk => clk,
		reset => r,
		Q => cuenta
);

outputs <= cuenta;

SUM1: sumador_4bits
	port map(
		cin => '0',
		a => cuenta,
		b => "0001",
		s => suma,
		cout => open
	);

SUM2: sumador_4bits
	port map(
		cin => '0',
		a => cuenta,
		b => "1111",
		s => resta,
		cout => open
	);

COMP: comparador_4bits
	port map(
		a => cuenta,
		b => cuentaReset,
		agb => open,
		aeb => igual,
		alb =>open
	);

--resetea si el preset enable está activo o si la cuenta ascendente llega a 9
r <= not(presetEnable) or igual;


carryout<=((cuenta(3)) and not (cuenta(2)) and (cuenta(1)) and not (cuenta(0)));
		--or cuenta(3) and (cuenta(2)) and (cuenta(1)) and (cuenta(0));


end architecture;