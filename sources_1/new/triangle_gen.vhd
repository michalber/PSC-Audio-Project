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
      CE : in std_logic; 
      WAVE_OUT : out std_logic_vector(bitWidth-1 downto 0);
      RST :in std_logic;
      SAMPLE:out std_logic
     );
end triangle_gen;

--entity triangularwave is
-- port( clk:in std_logic;
--       dacout:out std_logic_vector(7 downto 0));
--end triangularwave;

architecture Behavioral of triangle_gen is

signal count: std_logic_vector(7 downto 0):="00000000";
signal direction : std_logic := '0';    -- '0' up / '1' down

begin

process(CLK,CE,RST)
begin
    if rising_edge(CLK) then
        if RST = '1' then                    
            SAMPLE <= '0';
        elsif CE = '1' then
            SAMPLE <= '1';
        else 
            SAMPLE <= '0';
        end if;
    end if;   
end process; 

process(CLK,CE,RST)
begin
    if rising_edge(CLK) then
        if RST = '1' then
            count <= (others => '0');
            direction <= '0';
        elsif CE = '1' then
            if direction='0' and count < x"ff" then
                count <= count + 1;        
            elsif direction='1' and count > x"00" then
                count <= count - 1;
            end if;
            if count > x"fe" then
                direction <= '1';
                count <= count - 1;
            elsif count = 0 then
                direction <= '0';
                count <= count + 1;
            end if;
        end if;
    end if;
end process;

WAVE_OUT <= count;


end Behavioral;
