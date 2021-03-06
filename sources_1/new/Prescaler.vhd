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
use IEEE.NUMERIC_STD.ALL;


entity Prescaler is
	port(
		CLK : in STD_LOGIC;		
		RST : in STD_LOGIC;
		CLK_25M : out STD_LOGIC;      -- 25MHz CLK output port
		CLK_100k : out STD_LOGIC;     -- 100kHz CLK output port
		CLK_1k : out STD_LOGIC        -- 1kHz CLK output port
		);	   
end Prescaler;



architecture Behavioral of Prescaler is
-- -----------------------------------------------------------
signal DIVIDER_25M: std_logic_vector(3 downto 0);	 
constant divide_25M: integer := 4;	
-- -----------------------------------------------------------		
signal DIVIDER_100k: std_logic_vector(14 downto 0);	 -- zmniejszenie do 50kHz
constant divide_100k: integer := 2000;
-- -----------------------------------------------------------
signal DIVIDER_1k: std_logic_vector(18 downto 0);	 
constant divide_1k: integer := 500000 ;
-- -----------------------------------------------------------											

begin 
-- -----------------------------------------------------------
-- 25MHz CLK prescaler
	process (CLK, RST)
	begin		
		if CLK'event and CLK = '1' then
		    if RST = '1' then
                DIVIDER_25M <= (others => '0');
            else			
			     if DIVIDER_25M = (divide_25M-1) then
    				DIVIDER_25M <= (others => '0');
	       		else
			 	   DIVIDER_25M <= DIVIDER_25M + 1;
			 	end if;
			end if;		
		end if;
	end process;
-- -----------------------------------------------------------	
-- 100kHz CLK prescaler
	process (CLK, RST)
        begin            
            if CLK'event and CLK = '1' then           
                if RST = '1' then
                   DIVIDER_100k <= (others => '0');
                else     
                    if DIVIDER_100k = (divide_100k-1) then
                        DIVIDER_100k <= (others => '0');
                    else
                        DIVIDER_100k <= DIVIDER_100k + 1;
                    end if;
                end if;        
            end if;
        end process;
-- -----------------------------------------------------------
-- 1kHz CLK prescaler
    process (CLK, RST)
        begin            
            if CLK'event and CLK = '1' then
                if RST = '1' then
                   DIVIDER_1k <= (others => '0');            
                else
                    if DIVIDER_1k = (divide_1k-1) then
                        DIVIDER_1k <= (others => '0');
                    else
                        DIVIDER_1k <= DIVIDER_1k + 1;
                    end if;
                end if;        
            end if;
        end process;        
-- -----------------------------------------------------------        

CLK_25M <= '1' when DIVIDER_25M = (divide_25M-1) else '0';
CLK_100k <= '1' when DIVIDER_100k = (divide_100k-1) else '0';	
CLK_1k <= '1' when DIVIDER_1k = (divide_1k-1) else '0';

end Behavioral;
