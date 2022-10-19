library IEEE; 
use ieee.std_logic_1164.all;

entity restador_4bits is
	port(
		bin : in std_logic;
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		r : out std_logic_vector(3 downto 0);
		bout : out std_logic
	);
end entity;

architecture estructural of restador_4bits is

component restador_2bits is
	port(
		bin : in std_logic;
		a : in std_logic;
		b : in std_logic;
		r : out std_logic;
		bout : out std_logic
	);
end component;

signal bout0, bout1, bout2, bout3 : std_logic;

begin

restador0 : restador_2bits
	port map(
		bin => bin,
		a => a(0),
		b => b(0),
		r => r(0),
		bout => bout0
	);
	
restador1 : restador_2bits
	port map(
		bin => bout0,
		a => a(1),
		b => b(1),
		r => r(1),
		bout => bout1
	);
	
restador2 : restador_2bits
	port map(
		bin => bout1,
		a => a(2),
		b => b(2),
		r => r(2),
		bout => bout2
	);
	
restador3 : restador_2bits
	port map(
		bin => bout2,
		a => a(3),
		b => b(3),
		r => r(3),
		bout => bout
	);
	
end architecture;