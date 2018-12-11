----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2018 15:12:20
-- Design Name: 
-- Module Name: audio_PWM - Behavioral
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

entity audio_PWM is
    generic (bitWidth : integer := 8);
    Port ( CLK : in STD_LOGIC;
           WAVE_IN : in STD_LOGIC_VECTOR (bitWidth-1 downto 0);
           SAMPLE : in STD_LOGIC;
           RST:in std_logic;
           PWM_OUT:out std_logic     
           );
end audio_PWM;

architecture Behavioral of audio_PWM is

--signal MAX : integer := 2*bitWidth-1;
--signal din_reg : std_logic_vector(bitWidth-1 downto 0);
--signal error : std_logic_vector(bitWidth-1 downto 0);
--signal error_0 : std_logic_vector(bitWidth-1 downto 0);
--signal error_1 : std_logic_vector(bitWidth-1 downto 0);

--begin

--process (CLK) begin
--if(rising_edge(CLK)) then
--    din_reg <= WAVE_IN;
--    error_1 <= error + MAX - din_reg;
--    error_0 <= error - din_reg;
-- end if;
-- end process;
 
-- process (CLK) begin
--       if (RST = '1') then
--         PWM_OUT <= '0';
--       elsif (din_reg >= error) then
--         PWM_OUT <= '1';
--       else 
--         PWM_OUT <= '0';
--       end if;
--  end process;
    
signal sample_max : std_logic_vector (bitWidth-1 downto 0);
signal count : std_logic_vector (bitWidth-1 downto 0) := x"00";

begin

sample_max <= WAVE_IN;

load_p : process(CLK, RST) begin
if(RST = '1') then
    count <= (others=>'0');   
elsif(rising_edge(CLK)) then
    if(SAMPLE = '1') then
       count <= x"00";       
    else 
        count <= count + 1;
    end if;
    if count <= sample_max then
        PWM_OUT<= '1';
    else 
        PWM_OUT<='0';
    end if;
end if;
end process;

end Behavioral;
