----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2018 14:57:00
-- Design Name: 
-- Module Name: triangle_gen_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity triangle_gen_tb is
--  Port ( );
end triangle_gen_tb;

architecture Behavioral of triangle_gen_tb is

component triangle_gen is
port (CLK : in std_logic; 
      WAVE_OUT : out std_logic_vector(7 downto 0);
      RST :in std_logic;
      SAMPLE:out std_logic
     );
end component;

signal CLK,RST : std_logic := '0';
signal WAVE_OUT : std_logic_vector(7 downto 0);
signal SAMPLE : std_logic;

begin

uut : triangle_gen port map(CLK,WAVE_OUT,RST,SAMPLE);

CLK <= not CLK after 5 ns;

process
begin
RST <= '1';
wait for 100 ns;
RST <= '0';
wait;
end process;


end Behavioral;
