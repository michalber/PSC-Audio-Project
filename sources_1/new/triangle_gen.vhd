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


architecture Behavioral of triangle_gen is

signal count: std_logic_vector(7 downto 0):="00000000";
signal direction : std_logic := '0';    -- '0' up / '1' down

begin
-- -------------------------------------------------------------------------------
-- generating SAMPLE signal to get know that sample is ready to read 
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
-- -------------------------------------------------------------------------------
-- Up/Down single counter
-- direction - 0-upcounting, 1-downcounting 
process(CLK,CE,RST)
begin
    if rising_edge(CLK) then
        if RST = '1' then
            count <= (others => '0');   -- reset counter and direction
            direction <= '0';
        elsif CE = '1' then
            if direction='0' and count < x"ff" then
                count <= count + 1;         -- upcounting when direction is 0 and counter value is smaller than 0xff
            elsif direction='1' and count > x"00" then
                count <= count - 1;         -- downcounting when direction is 1 and counter value is grater than 0x00
            end if;
            if count > x"fe" then
                direction <= '1';       -- when counter value is 0xfe then change direction and decrease counter 
                count <= count - 1;
            elsif count = 0 then
                direction <= '0';       -- when counter value is 0x00 then change direction and increase counter 
                count <= count + 1;
            end if;
        end if;
    end if;

end process;
-- -------------------------------------------------------------------------------
-- assing counter value to WAVE_OUT output port
WAVE_OUT <= count;


end Behavioral;
