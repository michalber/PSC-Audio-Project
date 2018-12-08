----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2018 15:59:55
-- Design Name: 
-- Module Name: Prescaler - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;


entity Prescaler is
	port(
		CLK : in STD_LOGIC;		
		CLR : in STD_LOGIC;
		CEO : out STD_LOGIC
		);	   
end Prescaler;



architecture Behavioral of Prescaler is

signal DIVIDER: std_logic_vector(3 downto 0);	-- internal divider register 
constant divide_factor: integer := 4;			-- divide factor user constant
												-- remember to adjust lenght of DIVIDER register when divide_factor is being changed

begin 
	process (CLK, CLR)
	begin
		if CLR = '1' then
			DIVIDER <= (others => '0');
		elsif CLK'event and CLK = '1' then			
			if DIVIDER = (divide_factor-1) then
				DIVIDER <= (others => '0');
			else
				DIVIDER <= DIVIDER + 1;
			end if;		
		end if;
	end process;

CEO <= '1' when DIVIDER = (divide_factor-1) else '0';
	
end Behavioral;
