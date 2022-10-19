library IEEE;
use ieee.std_logic_1164.all;
 
entity mux4a1_1bit is 
	port ( 
		control : in std_logic_vector (1 downto 0) ; 
		x0: in std_logic;
		x1: in std_logic;
		x2: in std_logic;
		x3: in std_logic;
		y:out std_logic
	); 
end entity; 

architecture mux of mux4a1_1bit is 

signal c1 , c0 : std_logic ; 
signal sel0, sel1, sel2, sel3: std_logic ; 

begin 

c1 <= control(1); 

c0 <= control(0); 

sel0 <= not(c1) and not(c0); 

sel1 <= not(c1) and c0;

sel2 <= c1 and not(c0); 

sel3 <= c1 and c0;

y <= (sel0 and x0) or (sel1 and x1) or (sel2 and x2) or (sel3 and x3); 

end architecture; 