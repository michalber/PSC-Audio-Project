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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;

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

component top_v1 is
port (
      CLK : in STD_LOGIC;
      RST : in STD_LOGIC;
      PDM : out STD_LOGIC;
      AUD_SD : out STD_LOGIC;
      playKick : in STD_LOGIC;
      playSnare : in STD_LOGIC;
      WAVE : out std_logic_vector(7 downto 0)
     );
end component;

signal CLK,RST,PDM,playKick,playSnare,AUD_SD : std_logic := '0';
signal WAVE : std_logic_vector(7 downto 0);

begin

uut : top_v1 port map(CLK,RST,PDM,AUD_SD,playKick,playSnare,WAVE);

CLK <= not CLK after 1 ps;

RST_p : process 
begin
    RST <= '1';
    wait for 10ps;
    RST <= '0';
    wait;
end process;

kick_in_p : process
begin
    wait for 100ps;
    playKick <= '1';
    wait for 2ps;
    playKick <= '0';
    wait for 6000ns;
    playKick <= '1';
    wait for 2ps;
    playKick <= '0';
    wait;
end process;

snare_in_p : process
begin
    wait for 1500ns;
    playSnare <= '1';
    wait for 2ps;
    playSnare <= '0';
    wait;
end process;


end Behavioral;
