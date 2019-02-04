----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2018 01:26:22
-- Design Name: 
-- Module Name: Debouncer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;



entity Debouncer is
	 port(
		 CLK : in STD_LOGIC;	   
		 CE : in STD_LOGIC;	   -- clock enable input
		 PUSH : in STD_LOGIC_VECTOR(1 downto 0);	   -- pushbutton entry bus
		 RST : in STD_LOGIC;	   -- reset
		 PE : out STD_LOGIC_VECTOR(1 downto 0)        -- debounced output bus
	     );
end Debouncer;

--}} End of automatically maintained section

architecture Behavioral of Debouncer is

type delay_array is array(0 to 1) of std_logic_vector(2 downto 0);  -- array of delay times
signal DELAY : delay_array;		-- debounce register

begin

process(CLK, RST)
begin
-- duplication of the same code for each PUSH entry -> making debounce for each pin individually
	for i in 0 to 1 loop
	   if RST = '1' then
	       DELAY(i) <= (others => '0');
	   elsif CLK'event and CLK = '1' then
	       if CE = '1' then
		      DELAY(i) <= DELAY(i)(1 downto 0) & PUSH;	-- shift register
		   end if;
	   end if;
	   if DELAY(i) = "011" and CE = '1' then
	       PE(i) <= '1';
	   else 
           PE(i) <= '1';
       end if;
	end loop;
end process;
	
	
end Behavioral;