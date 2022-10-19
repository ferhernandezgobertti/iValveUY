library IEEE;
use ieee . std_logic_1164. all;
 
entity mux16a1_1bit is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic;
		x1  : in std_logic;
		x2  : in std_logic;
		x3  : in std_logic;
		x4  : in std_logic;
		x5  : in std_logic;
		x6  : in std_logic;
		x7  : in std_logic;
		x8  : in std_logic;
		x9  : in std_logic;
		x10 : in std_logic;
		x11 : in std_logic;
		x12 : in std_logic;
		x13 : in std_logic;
		x14 : in std_logic;
		x15 : in std_logic; 
		y:out std_logic
	); 
end entity; 

architecture mux of mux16a1_1bit is 

signal c3, c2 , c1 , c0 : std_logic ; 
signal sel0, sel1, sel2, sel3, sel4, sel5, sel6, sel7, sel8, sel9, sel10, sel11, sel12, sel13, sel14, sel15: std_logic ; 

begin 

c3 <= control(3);

c2 <= control(2); 

c1 <= control(1); 

c0 <= control(0); 

sel0 <= not (c3) and not (c2) and not (c1) and not (c0);

sel1 <= not (c3) and not (c2) and not (c1) and (c0);

sel2 <= not (c3) and not (c2) and (c1) and not (c0);

sel3 <= not (c3) and not (c2) and (c1) and (c0);

sel4 <= not (c3) and (c2) and not (c1) and not (c0);

sel5 <= not (c3) and (c2) and not (c1) and (c0);

sel6 <= not (c3) and (c2) and (c1) and not (c0);

sel7 <= not (c3) and (c2) and (c1) and (c0);

sel8 <= (c3) and not (c2) and not (c1) and not (c0);

sel9 <= (c3) and not (c2) and not (c1) and (c0);

sel10 <= (c3) and not (c2) and (c1) and not (c0);

sel11 <= (c3) and not (c2) and (c1) and (c0);

sel12 <= (c3) and (c2) and not (c1) and not (c0);

sel13 <= (c3) and (c2) and not (c1) and (c0);

sel14 <= (c3) and (c2) and (c1) and not (c0);

sel15 <= (c3) and (c2) and (c1) and (c0);

y <= (sel0 and x0) or (sel1 and x1) or (sel2 and x2) or (sel3 and x3) or (sel4 and x4) or (sel5 and x5) or (sel6 and x6) or ( sel7 and x7) or ( sel8 and x8) or ( sel9 and x9) or ( sel10 and x10) or ( sel11 and x11) or ( sel12 and x12) or ( sel13 and x13) or ( sel14 and x14) or ( sel15 and x15); 

end architecture; 