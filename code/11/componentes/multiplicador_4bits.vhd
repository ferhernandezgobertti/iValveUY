library IEEE;
use ieee.std_logic_1164.all;

entity multiplicador_4bits is
port (
a: in std_logic_vector (3 downto 0);
b: in std_logic_vector (3 downto 0);
c: out std_logic_vector (7 downto 0)
);
end entity;

architecture a1 of multiplicador_4bits is
	
component sumador_2bits is
	port(
		cin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		cout : out std_logic
	);
end component;


signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, auxa, auxb, auxc, auxd, auxe, auxf: std_logic;


begin

c(0) <= a(0) and b(0);

SUM1: sumador_2bits
	port map(
		cin => '0',
		a => (a(0) and b(1)),
		b => (a(1) and b(0)),
		s => c(1),
		cout => c1
	);
	
SUM2: sumador_2bits
	port map(
		cin => c1,
		a => (a(1) and b(1)),
		b => (a(2) and b(0)),
		s => auxa,
		cout => c2
	);
	
SUM3: sumador_2bits
	port map(
		cin => c2,
		a => (a(2) and b(1)),
		b => (a(3) and b(0)),
		s => auxb,
		cout => c3
	);
	
SUM4: sumador_2bits
	port map(
		cin => c3,
		a => (a(3) and b(1)),
		b => '0',
		s => auxc,
		cout => c7
	);
	
SUM5: sumador_2bits
	port map(
		cin => '0',
		a => (a(0) and b(2)),
		b => auxa,
		s => c(2),
		cout => c4
	);

SUM6: sumador_2bits
	port map(
		cin => c4,
		a => (a(1) and b(2)),
		b => auxb,
		s => auxd,
		cout => c5
	);
	
SUM7: sumador_2bits
	port map(
		cin => c5,
		a => (a(2) and b(2)),
		b => auxc,
		s => auxe,
		cout => c6
	);
	
SUM8: sumador_2bits
	port map(
		cin => c6,
		a => (a(3) and b(2)),
		b => c7,
		s => auxf,
		cout => c11
	);
	
SUM9: sumador_2bits
	port map(
		cin => '0',
		a => (a(0) and b(3)),
		b => auxd,
		s => c(3),
		cout => c8
	);
	
SUM10: sumador_2bits
	port map(
		cin => c8,
		a => (a(1) and b(3)),
		b => auxe,
		s => c(4),
		cout => c9
	);
	
SUM11: sumador_2bits
	port map(
		cin => c9,
		a => (a(2) and b(3)),
		b => auxf,
		s => c(5),
		cout => c10
	);

SUM12: sumador_2bits
	port map(
		cin => c10,
		a => (a(3) and b(3)),
		b => c11,
		s => c(6),
		cout => c(7)
	);
	
	
end architecture;