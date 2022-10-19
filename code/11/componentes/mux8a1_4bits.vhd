library IEEE;
use ieee.std_logic_1164. all;
 
entity mux8a1_4bits is 
	port ( 
		control : in std_logic_vector (2 downto 0) ; 
		x0: in std_logic_vector (7 downto 0);
		x1: in std_logic_vector (7 downto 0);
		x2: in std_logic_vector (7 downto 0);
		x3: in std_logic_vector (7 downto 0);
		x4: in std_logic_vector (7 downto 0);
		x5: in std_logic_vector (7 downto 0);
		x6: in std_logic_vector (7 downto 0);
		x7: in std_logic_vector (7 downto 0); 
		y:out std_logic_vector(3 downto 0)
	); 
end entity; 

architecture mux of mux8a1_4bits is 

signal c2 , c1 , c0 : std_logic ; 
signal sel0, sel1, sel2, sel3, sel4, sel5, sel6, sel7: std_logic ; 

begin 

c2 <= control(2); 

c1 <= control(1); 

c0 <= control(0); 

sel0 <= not(c2) and not(c1) and not(c0); 

sel1 <= not(c2) and not(c1) and c0;

sel2 <= not(c2) and c1 and not(c0); 

sel3 <= not(c2) and c1 and c0;

sel4 <= c2 and not(c1) and not(c0); 

sel5 <= c2 and not(c1) and c0;

sel6 <= c2 and c1 and not(c0);

sel7 <= c2 and c1 and c0; 

y(0) <= (sel0 and x0(0)) or (sel1 and x1(0)) or (sel2 and x2(0)) or (sel3 and x3(0)) or (sel4 and x4(0)) or (sel5 and x5(0)) or (sel6 and x6(0)) or ( sel7 and x7(0)); 

y(1) <= (sel0 and x0(1)) or (sel1 and x1(1)) or (sel2 and x2(1)) or (sel3 and x3(1)) or (sel4 and x4(1)) or (sel5 and x5(1)) or (sel6 and x6(1)) or ( sel7 and x7(1)); 

y(2) <= (sel0 and x0(2)) or (sel1 and x1(2)) or (sel2 and x2(2)) or (sel3 and x3(2)) or (sel4 and x4(2)) or (sel5 and x5(2)) or (sel6 and x6(2)) or ( sel7 and x7(2)); 

y(3) <= (sel0 and x0(3)) or (sel1 and x1(3)) or (sel2 and x2(3)) or (sel3 and x3(3)) or (sel4 and x4(3)) or (sel5 and x5(3)) or (sel6 and x6(3)) or ( sel7 and x7(3)); 

end architecture; 