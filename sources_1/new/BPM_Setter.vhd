----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2019 20:50:44
-- Design Name: 
-- Module Name: BPM_Setter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BPM_Setter is
Port ( CLK : in STD_LOGIC; 
--       CE : in STD_LOGIC;       
       RST : in STD_LOGIC;
       BPM_UP : in STD_LOGIC;
       BPM_DOWN : in STD_LOGIC;
       BPM_OUT_LCD : out STD_LOGIC_VECTOR(7 downto 0);
       BPM_OUT : out STD_LOGIC_VECTOR(25 downto 0)
       );
end BPM_Setter;

architecture Behavioral of BPM_Setter is

signal BPM : integer := 140;
signal CE : bit := '1';

begin

process(CLK)
variable sigDel_U : std_logic;
variable sigDel_D : std_logic;                 
begin
    if(rising_edge(CLK)) then
        if(RST = '1') then
            BPM <= 120;
        elsif(CE = '1') then
            if(sigDel_U = '0' and BPM_UP = '1') then
                BPM <= BPM + 1;
            elsif(sigDel_D = '0' and BPM_DOWN = '1') then
                BPM <= BPM - 1;
            end if;
        end if;    
        sigDel_U := BPM_UP;  
        sigDel_D := BPM_DOWN;    
    end if;
end process;

-- Set up CLK prescaler (BPM_CLK_div)   100MHz * 60 / BPM / 8
BPM_OUT <= std_logic_vector(to_unsigned(750000000/BPM/2,BPM_OUT'length));
-- Set up LED driver
BPM_OUT_LCD <= std_logic_vector(to_unsigned(BPM,BPM_OUT_LCD'length));
       
end Behavioral;
