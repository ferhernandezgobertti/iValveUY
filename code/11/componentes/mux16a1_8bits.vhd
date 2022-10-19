library IEEE;
use ieee . std_logic_1164. all;
 
entity mux16a1_8bits is 
	port ( 
		control : in std_logic_vector (3 downto 0) ; 
		x0  : in std_logic_vector (7 downto 0);
		x1  : in std_logic_vector (7 downto 0);
		x2  : in std_logic_vector (7 downto 0);
		x3  : in std_logic_vector (7 downto 0);
		x4  : in std_logic_vector (7 downto 0);
		x5  : in std_logic_vector (7 downto 0);
		x6  : in std_logic_vector (7 downto 0);
		x7  : in std_logic_vector (7 downto 0);
		x8  : in std_logic_vector (7 downto 0);
		x9  : in std_logic_vector (7 downto 0);
		x10 : in std_logic_vector (7 downto 0);
		x11 : in std_logic_vector (7 downto 0);
		x12 : in std_logic_vector (7 downto 0);
		x13 : in std_logic_vector (7 downto 0);
		x14 : in std_logic_vector (7 downto 0);
		x15 : in std_logic_vector (7 downto 0); 
		y:out std_logic_vector(7 downto 0)
	); 
end entity; 

architecture mux of mux16a1_8bits is 

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

y(2) <= (sel0 and x0(2)) or (sel1 and x1(2)) or (sel2 and x2(2)) or (sel3 and x3(2)) or (sel4 and x4(2)) or (sel5 and x5(2)) or (sel6 and x6(2)) or ( sel7 and x7(2)) or (sel8 and x8(2)) or (sel9 and x9(2)) or (sel10 and x10(2)) or (sel11 and x11(2)) or (sel12 and x12(2)) or (sel13 and x13(2)) or (sel14 and x14(2)) or ( sel15 and x15(2)); 

y(3) <= (sel0 and x0(3)) or (sel1 and x1(3)) or (sel2 and x2(3)) or (sel3 and x3(3)) or (sel4 and x4(3)) or (sel5 and x5(3)) or (sel6 and x6(3)) or ( sel7 and x7(3)) or (sel8 and x8(3)) or (sel9 and x9(3)) or (sel10 and x10(3)) or (sel11 and x11(3)) or (sel12 and x12(3)) or (sel13 and x13(3)) or (sel14 and x14(3)) or ( sel15 and x15(3)); 

y(4) <= (sel0 and x0(4)) or (sel1 and x1(4)) or (sel2 and x2(4)) or (sel3 and x3(4)) or (sel4 and x4(4)) or (sel5 and x5(4)) or (sel6 and x6(4)) or ( sel7 and x7(4)) or ( sel8 and x8(4)) or ( sel9 and x9(4)) or ( sel10 and x10(4)) or ( sel11 and x11(4)) or ( sel12 and x12(4)) or ( sel13 and x13(4)) or ( sel14 and x14(4)) or ( sel15 and x15(4)); 

y(5) <= (sel0 and x0(5)) or (sel1 and x1(5)) or (sel2 and x2(5)) or (sel3 and x3(5)) or (sel4 and x4(5)) or (sel5 and x5(5)) or (sel6 and x6(5)) or ( sel7 and x7(5)) or (sel8 and x8(5)) or (sel9 and x9(5)) or (sel10 and x10(5)) or (sel11 and x11(5)) or (sel12 and x12(5)) or (sel13 and x13(5)) or (sel14 and x14(5)) or ( sel15 and x15(5)); 

y(6) <= (sel0 and x0(6)) or (sel1 and x1(6)) or (sel2 and x2(6)) or (sel3 and x3(6)) or (sel4 and x4(6)) or (sel5 and x5(6)) or (sel6 and x6(6)) or ( sel7 and x7(6)) or (sel8 and x8(6)) or (sel9 and x9(6)) or (sel10 and x10(6)) or (sel11 and x11(6)) or (sel12 and x12(6)) or (sel13 and x13(6)) or (sel14 and x14(6)) or ( sel15 and x15(6)); 

y(7) <= (sel0 and x0(7)) or (sel1 and x1(7)) or (sel2 and x2(7)) or (sel3 and x3(7)) or (sel4 and x4(7)) or (sel5 and x5(7)) or (sel6 and x6(7)) or ( sel7 and x7(7)) or (sel8 and x8(7)) or (sel9 and x9(7)) or (sel10 and x10(7)) or (sel11 and x11(7)) or (sel12 and x12(7)) or (sel13 and x13(7)) or (sel14 and x14(7)) or ( sel15 and x15(7)); 


end architecture; 