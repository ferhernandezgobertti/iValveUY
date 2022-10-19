LIBRARY ieee; 
USE ieee.std_logic_1164.all;

entity comparador_16bits is
	--agb = 1 entonces a > b
	--aeb = 1 entonces a = b
	--alb = 1 entonces a < b
	port(
		a : in std_logic_vector(15 downto 0);
		b : in std_logic_vector(15 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end entity;

architecture comportamental of comparador_16bits is

component comparador_8bits is
	port(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		agb : out std_logic;
		aeb : out std_logic;
		alb : out std_logic
	);
end component;

signal mayorH, igualH : std_logic;

signal mayorL, igualL : std_logic;

signal mayor, igual, menor : std_logic;

begin

comparadorH : comparador_8bits
	port map(
		a => a(15 downto 8),
		b => b(15 downto 8),
		agb => mayorH,
		aeb => igualH,
		alb => open
	);	
	
comparadorL : comparador_8bits
	port map(
		a => a(7 downto 0),
		b => b(7 downto 0),
		agb => mayorL,
		aeb => igualL,
		alb => open
	);
	
igual <= igualH and igualL;

mayor <= mayorH or (igualH and mayorL);

aeb <= igual;

agb <= mayor;

alb <= not(mayor) and not(igual);


end architecture;