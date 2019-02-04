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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity audio_PWM is
generic (PWM_RES : positive := 8);

port (
    CLK : in std_logic;   
    CE : in std_logic; 
    RES : in std_logic; 
    LD : in std_logic; 
    DATA : in std_logic_vector(PWM_RES-1 downto 0);    
    PWM : out std_logic
);
end audio_PWM;

architecture Behavioral of audio_PWM is

-- -------------------------------------------------------------------------------------------------------
signal DATA_int_cmp : std_logic_vector(PWM_RES-1 downto 0):= (others => '0');   -- DATA to compare to
signal DATA_int : std_logic_vector(PWM_RES-1 downto 0):= (others => '0');  -- DATA buffer 
signal cnt_out : std_logic_vector(PWM_RES-1 downto 0):= (others => '0');  -- counter signal 
signal RES_PWM_o : std_logic := '0';    -- buffer to control PWM D-latch, counter-max value 
signal q : std_logic := '0';    -- PWM D-latch out
signal cnt_max : std_logic := '0';    -- counter-max flag 
-- -----------------------------------------------------------------------------------------------------
constant zero: std_logic_vector(PWM_RES-1 downto 0):= (others => '0'); -- value represents 0 in vector
constant ff: std_logic_vector(PWM_RES-1 downto 0):= (others => '1');    -- value represents 1 in vector

-- -------------------------------------------------------------------------------------------------------
begin
-- -------------------------------------------------------------------------------------------------------
-- first step input register 
process(RES,LD,DATA)
begin    
    if RES = '1' then
        DATA_int <= (others => '0');
    elsif LD = '1' then
        DATA_int <= DATA;       -- load DATA to data buffer
    end if;    
end process;
-- -------------------------------------------------------------------------------------------------------
-- second step input register 
process (RES, cnt_max)
begin
    if RES = '1' then
        DATA_int_cmp <= (others => '0');
    elsif(cnt_max'event and cnt_max = '1') then           
        DATA_int_cmp <= DATA_int;       -- load data buffet to comparation buffer when counter if full 
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- 8bit counter
process (CLK, RES)
begin
    if RES = '1' then
        cnt_out <= (others => '0'); 
    elsif rising_edge(CLK) then
        if CE = '1' then
            cnt_out <= cnt_out + 1;
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- generate overflow signal from counter
process (CLK, RES, cnt_out)
begin
    if RES = '1' or cnt_out < ff then
        cnt_max <= '0';
    elsif rising_edge(CLK) and cnt_out = ff then
        if CE='1' then
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
process (CLK, RES)
begin
    if RES = '1' then
        q <= '0';
    elsif rising_edge(CLK) then
        if CE='1' then
            q <= RES_PWM_o;
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- assign D-latch q output to PWM output port
PWM <= '0' when q = '0' else 'Z';

end Behavioral;
