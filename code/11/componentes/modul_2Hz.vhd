library IEEE;
use ieee.std_logic_1164.all;

entity modul_2Hz is
	port (
		clk_in : std_logic;
		clk_out : out std_logic
	);
end entity ;

architecture mixta2 of modul_2Hz is

component modul is
	port (
		clk_in : std_logic;
		periodo : in std_logic_vector (15 downto 0) ;
		ciclo_trabajo: in std_logic_vector (15 downto 0);
		clk_out : out std_logic
	);
end component;

signal clk1: std_logic;

begin


M1: modul
	port map(
		clk_in => clk_in,
		periodo => "0001001110001000",
		ciclo_trabajo => "0000100111000100",
		clk_out => clk1
	);


M2: modul
	port map(
		clk_in => clk1,
		periodo => "0001001110001000",
		ciclo_trabajo => "0000100111000100",
		clk_out => clk_out
	);

end architecture ;
