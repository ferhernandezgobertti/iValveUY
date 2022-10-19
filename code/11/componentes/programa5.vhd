library IEEE;
use ieee.std_logic_1164.all;

entity programa5 is
	port(
		decenas: in std_logic_vector (3 downto 0);
		segundos: in std_logic_vector (3 downto 0);
		decimas: in std_logic_vector (3 downto 0);
		clock: in std_logic;
		llenado: out std_logic_vector (3 downto 0);
		compresion: out std_logic;
		giro: out std_logic_vector (1 downto 0);
		calor: out std_logic;
		vaciado: out std_logic
	);
end entity;

architecture programar5 of programa5 is

component compararCuentas is
	port(
		cuenta1: in std_logic_vector(3 downto 0);
		cuenta2: in std_logic_vector(3 downto 0);
		cuenta3: in std_logic_vector(3 downto 0);
		comparar1: in std_logic_vector(3 downto 0);
		comparar2: in std_logic_vector(3 downto 0);
		comparar3: in std_logic_vector(3 downto 0);
		salida: out std_logic
	);
	end component;

component flip_flop_D_1bit is
	port (
		D: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		Q: out std_logic
	);
end component;

component mux16a1_1bit is
	port (
		selector: in std_logic_vector (3 downto 0);
		entrada: in std_logic_vector (15 downto 0);
		salida : out std_logic
	);
end component;

component deco3a8 is
	port(
		entrada: in std_logic_vector(2 downto 0);
		salida: out std_logic_vector(7 downto 0)
	);
end component;

signal D2, D1, D0, Q2, Q1, Q0, cuentaComparada1, cuentaComparada2, cuentaComparada3, cuentaComparada4, cuentaComparada5, cuentaComparada6, cuentaComparada7, cuentaComparada8: std_logic;
signal s: std_logic_vector (7 downto 0);

begin

COMP1: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0000",
		comparar2 => "0101",
		comparar3 => "0000",
		salida => cuentaComparada1
);

COMP2: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0001",
		comparar2 => "0101",
		comparar3 => "0000",
		salida => cuentaComparada2
);

COMP3: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0010",
		comparar2 => "0000",
		comparar3 => "0000",
		salida => cuentaComparada3
);

COMP4: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0011",
		comparar2 => "0000",
		comparar3 => "0000",
		salida => cuentaComparada4
);

COMP5: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0100",
		comparar2 => "0000",
		comparar3 => "0000",
		salida => cuentaComparada5
);

COMP6: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0100",
		comparar2 => "1001",
		comparar3 => "0000",
		salida => cuentaComparada6
);

COMP7: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0101",
		comparar2 => "0101",
		comparar3 => "0000",
		salida => cuentaComparada7
);

COMP8: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0101",
		comparar2 => "0101",
		comparar3 => "0000",
		salida => cuentaComparada8
);


D2 <= (not (Q2) and Q1 and Q0 and cuentaComparada4) or (Q2 and not(Q1) and not(Q0)) or (Q2 and not(Q1) and Q0) or (Q2 and Q1 and not(Q0)) or (Q2 and Q1 and Q0 and not(cuentaComparada8));
D1 <= (not (Q2) and not (Q1) and Q0 and cuentaComparada2) or (not(Q2) and Q1 and not(Q0)) or (not(Q2) and Q1 and Q0 and not(cuentaComparada4)) or (Q2 and not(Q1) and Q0 and cuentaComparada6) or (Q2 and Q1 and not(Q0)) or (Q2 and Q1 and Q0 and not(cuentaComparada8));
D0 <= (not(Q2) and not(Q1) and not(Q0) and cuentaComparada1) or (not(Q2) and not(Q1) and Q0 and not(cuentaComparada2)) or (not(Q2) and Q1 and not(Q0) and cuentaComparada3) or (not (Q2) and Q1 and Q0 and not (cuentaComparada4)) or (Q2 and not(Q1) and not(Q0) and cuentaComparada5) or (Q2 and not(Q1) and Q0 and not(cuentaComparada6)) or (Q2 and Q1 and not(Q0) and cuentaComparada7) or (Q2 and Q1 and Q0 and not(cuentaComparada8));


FF2: flip_flop_D_1bit 
	port map(
		D => D2,
		clk => clock,
		reset => '0',
		Q => Q2
	);

FF1: flip_flop_D_1bit 
	port map(
		D => D1,
		clk => clock,
		reset => '0',
		Q => Q1
	);

FF0: flip_flop_D_1bit 
	port map(
		D => D0,
		clk => clock,
		reset => '0',
		Q => Q0
	);

DECO3a8_A: deco3a8
	port map (
		entrada => D2 & D1 & D0,
		salida => s
	);

llenado(0) <= '0';

llenado(1) <= '0';

llenado(2) <= s(0);

llenado(3) <= s(2);

compresion <= s(3);

giro <= s(3) & (s(1) or s(4));

calor <= s(1) or s(3);

vaciado <= s(6);


end architecture;