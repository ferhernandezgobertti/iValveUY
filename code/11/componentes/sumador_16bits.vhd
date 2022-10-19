library IEEE; 
use ieee.std_logic_1164.all;

entity sumador_16bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(15 downto 0);
		b : in std_logic_vector(15 downto 0);
		s : out std_logic_vector(15 downto 0);
		cout : out std_logic
	);
end entity;

architecture estructural of sumador_16bits is

component sumador_8bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		s : out std_logic_vector(7 downto 0);
		cout : out std_logic
	);
end component;

signal coutL : std_logic;

begin

sumadorL : sumador_8bits
	port map(
		cin => cin,
		a => a(7 downto 0),
		b => b(7 downto 0),
		s => s(7 downto 0),
		cout => coutL
	);
	
sumadorH : sumador_8bits
	port map(
		cin => coutL,
		a => a(15 downto 8),
		b => b(15 downto 8),
		s => s(15 downto 8),
		cout => cout
	);

end architecture;