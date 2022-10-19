library IEEE;
use ieee.std_logic_1164.all;

entity programa1 is
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

architecture programar1 of programa1 is

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

component mux32a1_1bit is
	port (
		selector: in std_logic_vector (4 downto 0);
		entrada: in std_logic_vector (31 downto 0);
		salida : out std_logic
	);
end component;

component deco4a16 is
	port(
		entrada: in std_logic_vector(3 downto 0);
		salida: out std_logic_vector(15 downto 0)
	);
end component;

signal D3, D2, D1, D0, Q3, Q2, Q1, Q0, cuentaComparada1, cuentaComparada2, cuentaComparada3, cuentaComparada4, cuentaComparada5, cuentaComparada6, cuentaComparada7, cuentaComparada8, cuentaComparada9: std_logic;
signal s: std_logic_vector (15 downto 0);

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
		comparar2 => "0000",
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
		comparar1 => "0010",
		comparar2 => "0101",
		comparar3 => "0000",
		salida => cuentaComparada4
);

COMP5: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0011",
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
		comparar2 => "0000",
		comparar3 => "0000",
		salida => cuentaComparada6
);

COMP7: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0100",
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

COMP9: compararCuentas
port map(
		cuenta1 => decenas,
		cuenta2 => segundos,
		cuenta3 => decimas,
		comparar1 => "0101",
		comparar2 => "1001",
		comparar3 => "1001",
		salida => cuentaComparada9
);

D3 <= (not (Q3) and Q2 and Q1 and Q0 and cuentaComparada8) or (Q3 and not(Q2) and not(Q1) and not(Q0) and not(cuentaComparada9));
D2 <= (not(Q3) and not (Q2) and Q1 and Q0 and cuentaComparada4) or (not(Q3) and Q2 and not(Q1) and not(Q0)) or (not(Q3) and Q2 and not(Q1) and Q0) or (not(Q3) and Q2 and Q1 and not(Q0)) or (not(Q3) and Q2 and Q1 and Q0 and not(cuentaComparada8));
D1 <= (not(Q3) and not (Q2) and not (Q1) and Q0 and cuentaComparada2) or (not(Q3) and not(Q2) and Q1 and not(Q0)) or (not(Q3) and not(Q2) and Q1 and Q0 and not(cuentaComparada4)) or (not(Q3) and Q2 and not(Q1) and Q0 and cuentaComparada6) or (not(Q3) and Q2 and Q1 and not(Q0)) or (not(Q3) and Q2 and Q1 and Q0 and not(cuentaComparada8));
D0 <= (not(Q3) and not(Q2) and not(Q1) and not(Q0) and cuentaComparada1) or (not(Q3) and not(Q2) and not(Q1) and Q0 and not(cuentaComparada2)) or (not(Q3) and not(Q2) and Q1 and not(Q0) and cuentaComparada3) or (not(Q3) and not (Q2) and Q1 and Q0 and not (cuentaComparada4)) or (not(Q3) and Q2 and not(Q1) and not(Q0) and cuentaComparada5) or (not(Q3) and Q2 and not(Q1) and Q0 and not(cuentaComparada6)) or (not(Q3) and Q2 and Q1 and not(Q0) and cuentaComparada7) or (not(Q3) and Q2 and Q1 and Q0 and not(cuentaComparada8));


FF3: flip_flop_D_1bit 
	port map(
		D => D3,
		clk => clock,
		reset => '0',
		Q => Q3
	);

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

DECO4a16_A: deco4a16
	port map (
		entrada => D3 & D2 & D1 & D0,
		salida => s
	);

llenado(0) <= s(6);

llenado(1) <= s(3);

llenado(2) <= s(0);

llenado(3) <= s(1);

compresion <= s(4);

giro <= s(5) & (s(2) or s(7));

calor <= s(5);

vaciado <= s(8);


end architecture;