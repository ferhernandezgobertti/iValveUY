library IEEE;
use ieee . std_logic_1164. all;
 
entity mux4a1_8bits is 
	port ( 
		control : in std_logic_vector (1 downto 0); 
		x0  : in std_logic_vector (7 downto 0);
		x1  : in std_logic_vector (7 downto 0);
		x2  : in std_logic_vector (7 downto 0);
		x3  : in std_logic_vector (7 downto 0);
		y:out std_logic_vector(7 downto 0)
	); 
end entity; 

architecture mux of mux4a1_8bits is 

signal c1 , c0 : std_logic ; 
signal sel0, sel1, sel2, sel3: std_logic ; 

begin 

c1 <= control(1); 

c0 <= control(0); 

sel0 <= not (c1) and not (c0);

sel1 <= not (c1) and (c0);

sel2 <= (c1) and not (c0);

sel3 <= (c1) and (c0);

y(0) <= (sel0 and x0(0)) or (sel1 and x1(0)) or (sel2 and x2(0)) or (sel3 and x3(0)); 

y(1) <= (sel0 and x0(1)) or (sel1 and x1(1)) or (sel2 and x2(1)) or (sel3 and x3(1)); 

y(2) <= (sel0 and x0(2)) or (sel1 and x1(2)) or (sel2 and x2(2)) or (sel3 and x3(2)); 

y(3) <= (sel0 and x0(3)) or (sel1 and x1(3)) or (sel2 and x2(3)) or (sel3 and x3(3)); 

y(4) <= (sel0 and x0(4)) or (sel1 and x1(4)) or (sel2 and x2(4)) or (sel3 and x3(4)); 

y(5) <= (sel0 and x0(5)) or (sel1 and x1(5)) or (sel2 and x2(5)) or (sel3 and x3(5)); 

y(6) <= (sel0 and x0(6)) or (sel1 and x1(6)) or (sel2 and x2(6)) or (sel3 and x3(6)); 

y(7) <= (sel0 and x0(7)) or (sel1 and x1(7)) or (sel2 and x2(7)) or (sel3 and x3(7)); 


end architecture; 