---- --------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 08.12.2018 15:12:20
---- Design Name: 
---- Module Name: audio_PWM - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
---- --------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity audio_PWM is
generic (PWM_RES : positive := 8);

port (
    CLK, CE, RES, LD : in std_logic;    
    DATA : in std_logic_vector(PWM_RES-1 downto 0);
    
    PWM : out std_logic
);
end audio_PWM;

architecture Behavioral of audio_PWM is

-- -------------------------------------------------------------------------------------------------------
signal DATA_int_cmp : std_logic_vector(PWM_RES-1 downto 0):= (others => '0');   -- DATA to compare to
signal DATA_int, cnt_out : std_logic_vector(PWM_RES-1 downto 0):= (others => '0');  -- DATA buffer, counter signal 
signal RES_PWM_o, q, cnt_max : std_logic := '0';    -- buffer to control PWM D-latch, counter-max value 
constant zero: std_logic_vector(PWM_RES-1 downto 0):= (others => '0'); -- value represents 0 in vector
constant ff: std_logic_vector(PWM_RES-1 downto 0):= (others => '1');    -- value represents 1 in vector

-- -------------------------------------------------------------------------------------------------------
begin
-- -------------------------------------------------------------------------------------------------------
-- first step input register 
process (LD, RES)
begin
    if RES = '1' then
        DATA_int <= (others => '0');
    elsif LD = '1' then
        DATA_int <= DATA;       -- load DATA to data buffer
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- second step input register 
process (cnt_max)
begin
    if rising_edge(cnt_max) then           
        if RES = '1' then
            DATA_int_cmp <= (others => '0');
        else            
            DATA_int_cmp <= DATA_int;       -- load data buffet to comparation buffer when counter if full 
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- 8bit counter
process (CLK)
begin     
    if rising_edge(CLK) then
        if RES = '1' then
            cnt_out <= (others => '0');
        elsif CE = '1' then
            cnt_out <= cnt_out + 1;
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- generate overflow signal from counter
process (CLK, CE, RES)
begin    
    if rising_edge(CLK) and cnt_out = ff then
        if RES = '1' or cnt_out < ff then
            cnt_max <= '0';
        elsif CE='1' then
            cnt_max <= '1';          -- set 1 when overflow
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- comparator
process (DATA_int_cmp, cnt_out)
begin
    if cnt_out = zero then
        RES_PWM_o <= '0';
    elsif DATA_int_cmp >= cnt_out then      -- compare comparation buffer with counter to generate signal controlling PWM D-latch
        RES_PWM_o <= '1';
    else
        RES_PWM_o <= '0';
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- PWM D-latch
process (CLK)
begin    
    if rising_edge(CLK) then
        if RES = '1' then
            q <= '0';
        elsif CE='1' then
            q <= RES_PWM_o;
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- assign D-latch q output to PWM output port
PWM <= q;

end Behavioral;
