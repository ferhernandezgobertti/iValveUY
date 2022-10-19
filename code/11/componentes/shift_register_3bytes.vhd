library IEEE;
use ieee.std_logic_1164.all;

entity shift_register_3bytes is
	port(
		guardar_byte: in std_logic;
		señal: in std_logic_vector (7 downto 0);
		rst: in std_logic;
		byte_direccion: out std_logic_vector (7 downto 0);
		byte_comando: out std_logic_vector (7 downto 0);
		byte_datos: out std_logic_vector (7 downto 0)
	);
end entity;

architecture registrando of shift_register_3bytes is

component flip_flop_D_8bits_descendente is
	port(
		D: in std_logic_vector (7 downto 0);
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic_vector (7 downto 0)
	);
end component;

signal byte1, byte2: std_logic_vector (7 downto 0);

begin

FF1: flip_flop_D_8bits_descendente
	port map(
		D => señal,
		clk => guardar_byte,
		reset => rst,
		Q => byte1
	);

FF2: flip_flop_D_8bits_descendente
	port map(
		D => byte1,
		clk => guardar_byte,
		reset => rst,
		Q => byte2
	);

FF3: flip_flop_D_8bits_descendente
	port map(
		D => byte2,
		clk => guardar_byte,
		reset => rst,
		Q => byte_direccion
	);

byte_comando <= byte2;

byte_datos <= byte1;

end architecture;