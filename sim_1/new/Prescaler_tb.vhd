----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2018 22:48:21
-- Design Name: 
-- Module Name: Prescaler_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Prescaler_tb is
--  Port ( );
end Prescaler_tb;

architecture Behavioral of Prescaler_tb is


component Prescaler is
port(
		CLK : in STD_LOGIC;		
		RST : in STD_LOGIC;
		CLK_25M : out STD_LOGIC;
		CLK_100k : out STD_LOGIC
		);	
end component;

signal CLK,RST : std_logic := '0';
signal CLK_25M,CLK_100k : std_logic;

begin

uut : Prescaler port map(CLK,RST,CLK_25M,CLK_100k);

CLK <= not CLK after 1ps;

RST_p : process
begin
    RST <= '1';
    wait for 2ps;
    RST <= '0';
    wait;
end process;
end Behavioral;
