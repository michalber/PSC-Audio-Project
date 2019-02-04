----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2018 23:56:44
-- Design Name: 
-- Module Name: Kick_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Kick_tb is
end Kick_tb;

architecture Behavioral of Kick_tb is

component Kick is
port (CLK : in std_logic; 
      CE : in std_logic;     
      RST :in std_logic;
      PLAY :in std_logic;
      KICK_SAMP_O:out signed(7 downto 0)
     );
end component;

signal CLK,CE,RST,PLAY : std_logic := '0';
signal KICK_SAMP_O : signed(7 downto 0);

begin

uut : Kick port map(
    CLK => CLK,
    CE => CE,
    RST => RST,
    PLAY => PLAY,
    KICK_SAMP_O => KICK_SAMP_O
    );

CLK <= not CLK after 5 ps;

RST_p : process
begin
RST <= '1';
wait for 100 ps;
RST <= '0';
wait;
end process;

CE_p : process
begin
    CE <= '0';
    wait for 10ps;
    CE <= '1';
    wait;
end process;

PLAY_p : process
begin
    wait for 200ps;
    PLAY <= '1';
    wait for 20ps;
    PLAY <= '0';
    wait;
end process;



end Behavioral;
