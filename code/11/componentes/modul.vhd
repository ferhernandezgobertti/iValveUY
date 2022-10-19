library IEEE;
use ieee.std_logic_1164.all;

entity modul is
	port (
		clk_in : std_logic;
		periodo : in std_logic_vector (15 downto 0) ;
		ciclo_trabajo: in std_logic_vector (15 downto 0);
		clk_out : out std_logic
	);
end entity ;

architecture mixta of modul is

component flip_flop_D_16bits is
	port (
		reset : in std_logic;
		D : in std_logic_vector (15 downto 0) ;
		clk : in std_logic;
		Q : out std_logic_vector (15 downto 0)
	);
end component ;

component sumador_16bits is
	port (
		cin : in std_logic ;
		a : in std_logic_vector (15 downto 0) ;
		b : in std_logic_vector (15 downto 0) ;
		s : out std_logic_vector (15 downto 0) ;
		cout : out std_logic
	);
end component ;

component flip_flop_D_1bit is
	port (
		reset : in std_logic ;
		D : in std_logic ;
		clk : in std_logic ;
		Q : out std_logic
	);
end component ;

component comparador_16bits is
	port (
		a : in std_logic_vector (15 downto 0) ;
		b : in std_logic_vector (15 downto 0) ;
		agb : out std_logic ;
		aeb : out std_logic ;
		alb : out std_logic
	);
end component ;

signal cuenta , suma : std_logic_vector (15 downto 0) ;
signal reset: std_logic;
signal igual_periodo , menor_periodo , mayor_periodo : std_logic ;
signal igual_ciclo_trabajo , menor_ciclo_trabajo : std_logic;
signal d0 , d1 , q0 , q1 : std_logic ;

begin

contador : flip_flop_D_16bits
	port map(
		reset => reset,
		D => suma,
		clk => clk_in,
		Q => cuenta
	);

sumador : sumador_16bits
	port map(
		cin => '0',
		a => cuenta,
		b => "0000000000000001",
		s => suma,
		cout => open
	);

comparador_periodo : comparador_16bits
	port map(
		a => cuenta,
		b => periodo,
		agb => mayor_periodo,
		aeb => igual_periodo,
		alb => menor_periodo
	);

comparador_ciclo_trabajo : comparador_16bits
	port map(
		a => cuenta,
		b => ciclo_trabajo,
		agb => open,
		aeb => igual_ciclo_trabajo,
		alb => menor_ciclo_trabajo
	);

ff1 : flip_flop_D_1bit
	port map(
		reset => '0',
		D => d1,
		clk => clk_in,
		Q => q1
	);

ff0 : flip_flop_D_1bit
	port map(
		reset => '0',
		D => d0,
		clk => clk_in,
		Q => q0
	);

d1 <= ( not ( q1 ) and q0 and igual_ciclo_trabajo ) or ( q1 and not ( q0 ) and menor_periodo ) ;

d0 <= ( not ( q1 ) and not ( q0 ) ) or ( not ( q1 ) and q0 and menor_ciclo_trabajo ) or ( q1 and not ( q0 ) and igual_periodo ) ;

reset <= ( not ( q1 ) and not ( q0 ) ) or ( not ( q1 ) and q0 and mayor_periodo ) ;

clk_out <= not ( q1 ) and q0 ;

end architecture ;