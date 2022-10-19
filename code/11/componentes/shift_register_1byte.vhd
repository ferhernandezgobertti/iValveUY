library IEEE;
use ieee.std_logic_1164.all;

entity shift_register_1byte is
	port(
		reloj: in std_logic;
		rx: in std_logic;
		rst: in std_logic;
		byte: out std_logic_vector (7 downto 0)
	);
end entity;

architecture registar of shift_register_1byte is

component flip_flop_D_1bit is
	port(
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;

signal byte_signal: std_logic_vector (7 downto 0);

begin

FF1: flip_flop_D_1bit
	port map(
		D => rx,
		clk => reloj,
		reset => rst,
		Q => byte_signal(7)
	);

FF2: flip_flop_D_1bit
	port map(
		D => byte_signal(7),
		clk => reloj,
		reset => rst,
		Q => byte_signal(6)
	);

FF3: flip_flop_D_1bit
	port map(
		D => byte_signal(6),
		clk => reloj,
		reset => rst,
		Q => byte_signal(5)
	);

FF4: flip_flop_D_1bit
	port map(
		D => byte_signal(5),
		clk => reloj,
		reset => rst,
		Q => byte_signal(4)
	);

FF5: flip_flop_D_1bit
	port map(
		D => byte_signal(4),
		clk => reloj,
		reset => rst,
		Q => byte_signal(3)
	);

FF6: flip_flop_D_1bit
	port map(
		D => byte_signal(3),
		clk => reloj,
		reset => rst,
		Q => byte_signal(2)
	);

FF7: flip_flop_D_1bit
	port map(
		D => byte_signal(2),
		clk => reloj,
		reset => rst,
		Q => byte_signal(1)
	);

FF8: flip_flop_D_1bit
	port map(
		D => byte_signal(1),
		clk => reloj,
		reset => rst,
		Q => byte_signal(0)
	);

byte <= byte_signal;

end architecture;