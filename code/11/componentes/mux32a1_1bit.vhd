library IEEE; 
use ieee.std_logic_1164.all;

entity mux32a1_1bit is
	--selector(4): Cuenta
	--selector(3): B
	--selector(2): C
	--selector(1): D
	--selector(0): E
	port(
		selector: in std_logic_vector (4 downto 0);
		entrada: in std_logic_vector (31 downto 0);
		salida : out std_logic
	);
end entity;

architecture multiplexor of mux32a1_1bit is

signal c0, c1, c2, c3, c4: std_logic;
signal sel: std_logic_vector (31 downto 0);

begin

c4 <= selector(4);

c3 <= selector(3);

c2 <= selector(2);

c1 <= selector(1);

c0 <= selector(0);


sel(0) <= not (c4) and not (c3) and not (c2) and not (c1) and not (c0);

sel(1) <= not (c4) and not (c3) and not (c2) and not (c1) and (c0);

sel(2) <= not (c4) and not (c3) and not (c2) and (c1) and not (c0);

sel(3) <= not (c4) and not (c3) and not (c2) and (c1) and (c0);

sel(4) <= not (c4) and not (c3) and (c2) and not (c1) and not (c0);

sel(5) <= not (c4) and not (c3) and (c2) and not (c1) and (c0);

sel(6) <= not (c4) and not (c3) and (c2) and (c1) and not (c0);

sel(7) <= not (c4) and not (c3) and (c2) and (c1) and (c0);

sel(8) <= not (c4) and (c3) and not (c2) and not (c1) and not (c0);

sel(9) <= not (c4) and (c3) and not (c2) and not (c1) and (c0);

sel(10) <= not (c4) and (c3) and not (c2) and (c1) and not (c0);

sel(11) <= not (c4) and (c3) and not (c2) and (c1) and (c0);

sel(12) <= not (c4) and (c3) and (c2) and not (c1) and not (c0);

sel(13) <= not (c4) and (c3) and (c2) and not (c1) and (c0);

sel(14) <= not (c4) and (c3) and (c2) and (c1) and not (c0);

sel(15) <= not (c4) and (c3) and (c2) and (c1) and (c0);

sel(16) <= (c4) and not (c3) and not (c2) and not (c1) and not (c0);

sel(17) <= (c4) and not (c3) and not (c2) and not (c1) and (c0);

sel(18) <= (c4) and not (c3) and not (c2) and (c1) and not (c0);

sel(19) <= (c4) and not (c3) and not (c2) and (c1) and (c0);

sel(20) <= (c4) and not (c3) and (c2) and not (c1) and not (c0);

sel(21) <= (c4) and not (c3) and (c2) and not (c1) and (c0);

sel(22) <= (c4) and not (c3) and (c2) and (c1) and not (c0);

sel(23) <= (c4) and not (c3) and (c2) and (c1) and (c0);

sel(24) <= (c4) and (c3) and not (c2) and not (c1) and not (c0);

sel(25) <= (c4) and (c3) and not (c2) and not (c1) and (c0);

sel(26) <= (c4) and (c3) and not (c2) and (c1) and not (c0);

sel(27) <= (c4) and (c3) and not (c2) and (c1) and (c0);

sel(28) <= (c4) and (c3) and (c2) and not (c1) and not (c0);

sel(29) <= (c4) and (c3) and (c2) and not (c1) and (c0);

sel(30) <= (c4) and (c3) and (c2) and (c1) and not (c0);

sel(31) <= (c4) and (c3) and (c2) and (c1) and (c0);


salida <= (sel(0) and entrada(0)) or (sel(1) and entrada(1)) or (sel(2) and entrada(2)) or (sel(3) and entrada(3)) or (sel(4) and entrada(4)) or (sel(5) and entrada(5)) or (sel(6) and entrada(6)) or (sel(7) and entrada(7)) or (sel(8) and entrada(8)) or (sel(9) and entrada(9)) or (sel(10) and entrada(10)) or (sel(11) and entrada(11)) or (sel(12) and entrada(12)) or (sel(13) and entrada(13)) or (sel(14) and entrada(14)) or (sel(15) and entrada(15)) or (sel(16) and entrada(16)) or (sel(17) and entrada(17)) or (sel(18) and entrada(18)) or (sel(19) and entrada(19)) or (sel(20) and entrada(20)) or (sel(21) and entrada(21)) or (sel(22) and entrada(22)) or (sel(23) and entrada(23)) or (sel(24) and entrada(24)) or (sel(25) and entrada(25)) or (sel(26) and entrada(26)) or (sel(27) and entrada(27)) or (sel(28) and entrada(28)) or (sel(29) and entrada(29)) or (sel(30) and entrada(30)) or (sel(31) and entrada(31));

end architecture;