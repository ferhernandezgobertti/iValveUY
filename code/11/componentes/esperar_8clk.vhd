library IEEE;
use ieee.std_logic_1164.all;

entity esperar_8clk is
	port(
		reloj: in std_logic;
		senal: in std_logic;
		rst: in std_logic;
		salida: out std_logic
	);
end entity;

architecture registar of esperar_8clk is

component flip_flop_D_1bit is
	port(
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;

signal byte_signal: std_logic_vector (1 downto 0);

begin

FF6: flip_flop_D_1bit
	port map(
		D => senal,
		clk => reloj,
		reset => rst,
		Q => byte_signal(1)
	);

FF7: flip_flop_D_1bit
	port map(
		D => byte_signal(1),
		clk => reloj,
		reset => rst,
		Q => byte_signal(0)
	);

FF8: flip_flop_D_1bit
	port map(
		D => byte_signal(0),
		clk => reloj,
		reset => rst,
		Q => salida
	);


end architecture;