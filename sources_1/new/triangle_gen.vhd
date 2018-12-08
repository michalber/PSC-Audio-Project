----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2018 14:53:16
-- Design Name: 
-- Module Name: triangle_gen - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity triangle_gen is
generic (bitWidth : integer := 8);
port (CLK : in std_logic; 
      WAVE_OUT : out std_logic_vector(bitWidth-1 downto 0);
      RST :in std_logic;
      SAMPLE:out std_logic
     );
end triangle_gen;

architecture Behavioral of triangle_gen is
signal count,count2 : integer := 0;
signal direction : std_logic := '0';

begin

process(CLK,RST)
begin
if(RST = '1') then
    count <= 0;
    count2 <= 0;
elsif(rising_edge(CLK)) then
    --"direction" signal determines the direction of counting - up or down
    if(count = 253) then
        count <= 0;
        if(direction = '0') then
            direction <= '1';
            count2 <= 126;
        else
            direction <= '0';
            count2 <= 129;
        end if; 
    else
        count <= count + 1;
    end if;
    if(direction = '0') then
        if(count2 = 255) then
            count2 <= 0;
        else
            count2 <= count2 + 1; --up counts from 129 to 255 and then 0 to 127
        end if;
    else
        if(count2 = 255) then
            count2 <= 0;
        else
            count2 <= count2 - 1; --down counts from 126 to 0 and then 255 to 128
        end if;
    end if;    
end if;
end process;

WAVE_OUT <= conv_std_logic_vector(count2,8);  

end Behavioral;
