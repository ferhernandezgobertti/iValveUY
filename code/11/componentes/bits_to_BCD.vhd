library IEEE;
use ieee.std_logic_1164.all;

entity bits_to_BCD is
	port(
		entrada: in std_logic_vector (7 downto 0);
		centenas: out std_logic_vector (3 downto 0);
		decenas: out std_logic_vector (3 downto 0);
		unidades: out std_logic_vector (3 downto 0)
	);
end entity;

architecture separar of bits_to_BCD is

component agregar_4bits is
	port(
		cin : in std_logic;
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		c : out std_logic_vector(3 downto 0);
		cout : out std_logic
	);
end component;

signal suma1, suma2, suma3, suma4, suma5: std_logic_vector(3 downto 0);
signal auxiliar: std_logic_vector(11 downto 0);

begin

AGREGAR1: agregar_4bits
	port map(
		cin => '1',
		a => '0' & entrada(7 downto 5),
		b => "0010",
		c => suma1,
		cout => open
	);


AGREGAR2: agregar_4bits
	port map(
		cin => '1',
		a => suma1(2 downto 0) & entrada(4),
		b => "0010",
		c => suma2,
		cout => open
	);
	
	
AGREGAR3: agregar_4bits
	port map(
		cin => '1',
		a => suma2(2 downto 0) & entrada(3),
		b => "0010",
		c => suma3,
		cout => open
	);
	
	
AGREGAR4: agregar_4bits
	port map(
		cin => '1',
		a => suma3(2 downto 0) & entrada(2),
		b => "0010",
		c => suma4,
		cout => open
	);
	
	
AGREGAR5: agregar_4bits
	port map(
		cin => '1',
		a => suma4(2 downto 0) & entrada(1),
		b => "0010",
		c => auxiliar(4 downto 1),
		cout => open
	);
	
	
AGREGAR6: agregar_4bits
	port map(
		cin => '1',
		a => '0' & suma1(3) & suma2(3) & suma3(3),
		b => "0010",
		c => suma5,
		cout => open
	);
	
	
AGREGAR7: agregar_4bits
	port map(
		cin => '1',
		a => suma5(2 downto 0) & suma4(3),
		b => "0010",
		c => auxiliar(8 downto 5),
		cout => open
	);

auxiliar(11) <= '0';
auxiliar(10) <= '0';
auxiliar(9) <= suma5(3);
auxiliar(0) <= entrada(0);

unidades <= auxiliar(3 downto 0);
decenas <= auxiliar(7 downto 4);
centenas <= auxiliar(11 downto 8);

end architecture;