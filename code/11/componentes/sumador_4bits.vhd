library IEEE; 
use ieee.std_logic_1164.all;

entity sumador_4bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		s : out std_logic_vector(3 downto 0);
		cout : out std_logic
	);
end entity;

architecture estructural of sumador_4bits is

component sumador_2bits is
	port(
		cin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		cout : out std_logic
	);
end component;

signal c0, c1, c2 : std_logic;

begin

sumador0 : sumador_2bits
	port map(
		cin => cin,
		a => a(0),
		b => b(0),
		s => s(0),
		cout => c0
	);
	
sumador1 : sumador_2bits
	port map(
		cin => c0,
		a => a(1),
		b => b(1),
		s => s(1),
		cout => c1
	);
	
sumador2 : sumador_2bits
	port map(
		cin => c1,
		a => a(2),
		b => b(2),
		s => s(2),
		cout => c2
	);
	
sumador3 : sumador_2bits
	port map(
		cin => c2,
		a => a(3),
		b => b(3),
		s => s(3),
		cout => cout
	);
	
end architecture;

