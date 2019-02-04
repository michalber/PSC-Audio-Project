----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2019 23:58:22
-- Design Name: 
-- Module Name: led_driver - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity led_driver is
    Port ( CLK : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           RST : in STD_LOGIC; -- reset
           Number : in STD_LOGIC_VECTOR(7 downto 0);
           Anode_Activate : out STD_LOGIC_VECTOR (7 downto 0);-- 4 Anode signals
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end led_driver;

architecture Behavioral of led_driver is

signal first_dig, sec_dig, thr_dig : STD_LOGIC_VECTOR(3 downto 0);
signal displayed_number: STD_LOGIC_VECTOR (15 downto 0);
-- counting decimal number to be displayed on 4-digit 7-segment display
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
signal refresh_counter: STD_LOGIC_VECTOR (20 downto 0);
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(1 downto 0);
-- the other 2-bit for creating 4 LED-activating signals
-- count         0    ->  1  ->  2  ->  3
-- activates    LED1    LED2   LED3   LED4
-- and repeat
begin

-- VHDL code for BCD to 7-segment decoder
-- Cathode patterns of the 7-segment LED display 
process(LED_BCD)
begin
    case LED_BCD is         -- gfedcba                                    
    when "0000" => LED_out <= "1000000"; -- "0"                                     
    when "0001" => LED_out <= "1111001"; -- "1"     
    when "0010" => LED_out <= "0100100"; -- "2"     
    when "0011" => LED_out <= "0110000"; -- "3"     
    when "0100" => LED_out <= "0011001"; -- "4"                                 
    when "0101" => LED_out <= "0010010"; -- "5" 
    when "0110" => LED_out <= "0000010"; -- "6"     
    when "0111" => LED_out <= "1111000"; -- "7"     
    when "1000" => LED_out <= "0000000"; -- "8"         
    when "1001" => LED_out <= "0010000"; -- "9"     
    when "1010" => LED_out <= "0100000"; -- a    
    when "1011" => LED_out <= "0000011"; -- b                                
    when "1100" => LED_out <= "1000110"; -- C    
    when "1101" => LED_out <= "0100001"; -- d    
    when "1110" => LED_out <= "0000110"; -- E    
    when "1111" => LED_out <= "0001110"; -- F    
    when others => LED_out <= "1111111";
    end case;
end process;

-- 7-segment display controller
-- generate refresh period of 10.5ms
process(CLK,RST)
begin 
    if(RST='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(CLK)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
 LED_activating_counter <= refresh_counter(20 downto 19);
 
 
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter,displayed_number)
begin
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= b"1111_0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= x"0";
        -- the first hex digit of the 16-bit number
    when "01" =>
        Anode_Activate <= b"1111_1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= displayed_number(11 downto 8);
        -- the second hex digit of the 16-bit number
    when "10" =>
        Anode_Activate <= b"1111_1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= displayed_number(7 downto 4);
        -- the third hex digit of the 16-bit number
    when "11" =>
        Anode_Activate <= b"1111_1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= displayed_number(3 downto 0);
        -- the fourth hex digit of the 16-bit number    
    when others => 
        Anode_Activate <= b"1111_1111";
        LED_BCD <= x"0";        
    end case;
end process;

process(CLK, RST)
begin
    if(RST='1') then
        displayed_number <= (others => '0');
    elsif(rising_edge(CLK)) then             
        displayed_number <= x"00" & Number;                    
    end if;
end process;


end Behavioral;