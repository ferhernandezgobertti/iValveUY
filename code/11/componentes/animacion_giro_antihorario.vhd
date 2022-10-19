library IEEE;
use ieee.std_logic_1164.all;

entity animacion_giro_antihorario is
	port(
		clk: in std_logic;
		leds: out std_logic_vector(7 downto 0)
	);
end entity;

architecture anim of animacion_giro_antihorario is

component flip_flop_D_1bit is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;


signal leds_signal : std_logic_vector(7 downto 0);
signal r, clk1 : std_logic;

begin

FF1: flip_flop_D_1bit
	port map(
		D =>'1',
		clk => clk,
		reset => r,
		Q => leds_signal(5)
	);
	
FF2: flip_flop_D_1bit
	port map(
		D =>leds_signal(5),
		clk => clk,
		reset => r,
		Q => leds_signal(4)
	);
	
FF3: flip_flop_D_1bit
	port map(
		D =>leds_signal(4),
		clk => clk,
		reset => r,
		Q => leds_signal(3)
	);
	
FF4: flip_flop_D_1bit
	port map(
		D =>leds_signal(3),
		clk => clk,
		reset => r,
		Q => leds_signal(2)
	);
	
FF5: flip_flop_D_1bit
	port map(
		D =>leds_signal(2),
		clk => clk,
		reset => r,
		Q => leds_signal(1)
	);
	
FF6: flip_flop_D_1bit
	port map(
		D =>leds_signal(1),
		clk => clk,
		reset => r,
		Q => r
	);

leds_signal(0) <= '1';
leds_signal(6) <= '0';
leds_signal(7) <= '0';
	
leds <= not(leds_signal);

end architecture;