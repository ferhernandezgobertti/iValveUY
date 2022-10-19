library IEEE;
use ieee . std_logic_1164. all;
 
entity mux16a1_2bits is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic_vector (1 downto 0);
		x1  : in std_logic_vector (1 downto 0);
		x2  : in std_logic_vector (1 downto 0);
		x3  : in std_logic_vector (1 downto 0);
		x4  : in std_logic_vector (1 downto 0);
		x5  : in std_logic_vector (1 downto 0);
		x6  : in std_logic_vector (1 downto 0);
		x7  : in std_logic_vector (1 downto 0);
		x8  : in std_logic_vector (1 downto 0);
		x9  : in std_logic_vector (1 downto 0);
		x10 : in std_logic_vector (1 downto 0);
		x11 : in std_logic_vector (1 downto 0);
		x12 : in std_logic_vector (1 downto 0);
		x13 : in std_logic_vector (1 downto 0);
		x14 : in std_logic_vector (1 downto 0);
		x15 : in std_logic_vector (1 downto 0); 
		y:out std_logic_vector(1 downto 0)
	); 
end entity; 

architecture mux of mux16a1_2bits is 

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

y(0) <= (sel0 and x0(0)) or (sel1 and x1(0)) or (sel2 and x2(0)) or (sel3 and x3(0)) or (sel4 and x4(0)) or (sel5 and x5(0)) or (sel6 and x6(0)) or ( sel7 and x7(0)) or ( sel8 and x8(0)) or ( sel9 and x9(0)) or ( sel10 and x10(0)) or ( sel11 and x11(0)) or ( sel12 and x12(0)) or ( sel13 and x13(0)) or ( sel14 and x14(0)) or ( sel15 and x15(0)); 

y(1) <= (sel0 and x0(1)) or (sel1 and x1(1)) or (sel2 and x2(1)) or (sel3 and x3(1)) or (sel4 and x4(1)) or (sel5 and x5(1)) or (sel6 and x6(1)) or ( sel7 and x7(1)) or (sel8 and x8(1)) or (sel9 and x9(1)) or (sel10 and x10(1)) or (sel11 and x11(1)) or (sel12 and x12(1)) or (sel13 and x13(1)) or (sel14 and x14(1)) or ( sel15 and x15(1)); 

end architecture; 