----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2018 15:43:49
-- Design Name: 
-- Module Name: audio_PWM_tb - Behavioral
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

entity audio_PWM_tb is
--  Port ( );
end audio_PWM_tb;

architecture Behavioral of audio_PWM_tb is

component audio_PWM is
    Port ( CLK : in STD_LOGIC;
           WAVE_IN : in STD_LOGIC_VECTOR (7 downto 0);
           SAMPLE : in STD_LOGIC;
           RST:in std_logic;
           PWM_OUT:out std_logic
           );
end component;

signal CLK,RST,SAMPLE,PWM_OUT : std_logic := '0';
signal WAVE_IN : std_logic_vector(7 downto 0);


begin

uut : audio_PWM port map(CLK,WAVE_IN,RST,SAMPLE,PWM_OUT);

CLK <= not CLK after 10 ps;


RST_p : process
begin
RST <= '1';
wait for 100 ns;
RST <= '0';
wait;
end process;

WAVE_IN_p : process
begin
wait for 100 ns;
SAMPLE <= '1';
WAVE_IN <= "11111111";
wait for 10ns;
SAMPLE <= '0';

wait for 100ns;
SAMPLE <= '1';
WAVE_IN <= "11110000";
wait for 10ns;
SAMPLE <= '0';

wait for 100ns;
SAMPLE <= '1';
WAVE_IN <= "00001111";
wait for 10ns;
SAMPLE <= '0';

wait for 100ns;
SAMPLE <= '1';
WAVE_IN <= "00000001";
wait for 10ns;
SAMPLE <= '0';
   
wait;
end process;

end Behavioral;
