----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 20:59:28
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

component top is
port (CLK : in std_logic;       
      RST :in std_logic;
      PDM:out std_logic;
      WAVE:out std_logic_vector
     );
end component;

signal CLK,RST,PDM : std_logic := '0';
signal WAVE : std_logic_vector(7 downto 0);

begin

uut : top port map(CLK,RST,PDM,WAVE);

CLK <= not CLK after 1 ps;

process begin
    RST <= '1';
    wait for 10ps;
    RST <= '0';
    wait;
end process;
end Behavioral;
