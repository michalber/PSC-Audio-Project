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
    port (
    CLK, CE, RES, LD : in std_logic;
    DATA : in std_logic_vector(7 downto 0);    
    PWM : out std_logic
);
end component;

signal CLK,CE,RES,LD,PWM : std_logic := '0';
signal DATA : std_logic_vector(7 downto 0);


begin

uut : audio_PWM port map(CLK,CE,RES,LD,DATA,PWM);

CLK <= not CLK after 10 ps;


RST_p : process
begin
RES <= '1';
wait for 100 ns;
RES <= '0';
wait;
end process;

CE_p : process
begin
    CE <= '0';
    wait for 150ns;
    CE <= '1';
    wait;
end process;
WAVE_IN_p : process
begin
wait for 20ns;

wait for 90 ns;
DATA <= x"ff";
wait for 20ps;
LD <= '1';
wait for 20ps;
LD <= '0';

wait for 90ns;
DATA <= x"00";
wait for 40ns;
LD <= '1';
wait for 20ps;
LD <= '0';
wait for 40ns;

wait for 90ns;
DATA <= x"a0";
wait for 20ps;
LD <= '1';
wait for 20ps;
LD <= '0';

wait for 90ns;
DATA <= x"0f";
wait for 20ps;
LD <= '1';
wait for 20ps;
LD <= '0';

wait for 90ns;
DATA <= x"01";
wait for 20ps;
LD <= '1';
wait for 20ps;
LD <= '0';
   
wait;
end process;

end Behavioral;
