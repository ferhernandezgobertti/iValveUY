library IEEE; 
use ieee.std_logic_1164.all;

entity agregar_4bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		c : out std_logic_vector(3 downto 0);
		cout : out std_logic
	);
end entity;

architecture estructural of agregar_4bits is

component sumador_2bits is
	port(
		cin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		cout : out std_logic
	);
end component;

component comparador_4bits is
	--agb = 1 entonces a > b
	--aeb = 1 entonces a = b
	--alb = 1 entonces a < b
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

component mux2a1_4bits is
	--Si selector = 0 entonces salida = entrada1
	--Si selector = 1 entonces salida = entrada2
	port(
		selector : in std_logic;
		entrada1 : in std_logic_vector(3 downto 0);
		entrada2 : in std_logic_vector(3 downto 0);
		salida : out std_logic_vector(3 downto 0)
	);
end component;

signal c0, c1, c2, mayor : std_logic;
signal suma : std_logic_vector(3 downto 0);

begin

sumador0 : sumador_2bits
	port map(
		cin => cin,
		a => a(0),
		b => b(0),
		s => suma(0),
		cout => c0
	);
	
sumador1 : sumador_2bits
	port map(
		cin => c0,
		a => a(1),
		b => b(1),
		s => suma(1),
		cout => c1
	);
	
sumador2 : sumador_2bits
	port map(
		cin => c1,
		a => a(2),
		b => b(2),
		s => suma(2),
		cout => c2
	);
	
sumador3 : sumador_2bits
	port map(
		cin => c2,
		a => a(3),
		b => b(3),
		s => suma(3),
		cout => cout
	);
	
COMPARA: comparador_4bits 
	--agb = 1 entonces a > b
	--aeb = 1 entonces a = b
	--alb = 1 entonces a < b
	port map(
		a => a,
		b => "0100",
		agb => mayor,
		aeb => open,
		alb => open
	);

MUX: mux2a1_4bits
	--Si selector = 0 entonces salida = entrada1
	--Si selector = 1 entonces salida = entrada2
	port map(
		selector => mayor,
		entrada1 => a,
		entrada2 => suma,
		salida => c
	);
	
end architecture;

