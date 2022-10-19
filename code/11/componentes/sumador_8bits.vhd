library IEEE; 
use ieee.std_logic_1164.all;

entity sumador_8bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		s : out std_logic_vector(7 downto 0);
		cout : out std_logic
	);
end entity;

architecture estructural of sumador_8bits is

component sumador_2bits is
	port(
		cin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		cout : out std_logic
	);
end component;

signal c0, c1, c2, c3, c4, c5, c6 : std_logic;

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
		cout => c3
	);
	
sumador4 : sumador_2bits
	port map(
		cin => c3,
		a => a(4),
		b => b(4),
		s => s(4),
		cout => c4
	);
	
sumador5 : sumador_2bits
	port map(
		cin => c4,
		a => a(5),
		b => b(5),
		s => s(5),
		cout => c5
	);
	
sumador6 : sumador_2bits
	port map(
		cin => c5,
		a => a(6),
		b => b(6),
		s => s(6),
		cout => c6
	);
	
sumador7 : sumador_2bits
	port map(
		cin => c6,
		a => a(7),
		b => b(7),
		s => s(7),
		cout => cout
	);

end architecture;