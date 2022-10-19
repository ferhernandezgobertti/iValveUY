library IEEE;
use ieee.std_logic_1164.all;

entity compararCuentas is
	port(
		cuenta1: in std_logic_vector(3 downto 0);
		cuenta2: in std_logic_vector(3 downto 0);
		cuenta3: in std_logic_vector(3 downto 0);
		comparar1: in std_logic_vector(3 downto 0);
		comparar2: in std_logic_vector(3 downto 0);
		comparar3: in std_logic_vector(3 downto 0);
		salida: out std_logic
	);
end entity;

architecture comparacion of compararCuentas is

component comparador_4bits is
	port(
		a : in std_logic_vector(3 downto 0);
		b : in std_logic_vector(3 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

signal out1, out2, out3: std_logic;

begin

C1: comparador_4bits
	port map(
		a => cuenta1,
		b => comparar1,
		agb => open,
		aeb => out1,
		alb => open
	);

C2: comparador_4bits
	port map(
		a => cuenta2,
		b => comparar2,
		agb => open,
		aeb => out2,
		alb => open
	);

C3: comparador_4bits
	port map(
		a => cuenta3,
		b => comparar3,
		agb => open,
		aeb => out3,
		alb => open
	);

salida <= out1 and out2 and out3;

end architecture;