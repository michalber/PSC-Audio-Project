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
generic (
PWM_RES : positive:= 8);

port (
    CLK, CE, RES, LD : in std_logic;    
    DATA : in std_logic_vector(PWM_RES-1 downto 0);
    
    PWM : out std_logic
);
end audio_PWM;

architecture Behavioral of audio_PWM is

-- -------------------------------------------------------------------------------------------------------
signal DATA_int_cmp : std_logic_vector(PWM_RES-1 downto 0);
signal DATA_int, cnt_out : std_logic_vector(PWM_RES-1 downto 0);
signal RES_PWM_o, q, cnt_max : std_logic;
constant zero: std_logic_vector(PWM_RES-1 downto 0):= (others => '0');
constant ff: std_logic_vector(PWM_RES-1 downto 0):= (others => '1');

-- -------------------------------------------------------------------------------------------------------
begin
-- -------------------------------------------------------------------------------------------------------
-- rejestr wejsciowy pierwszego stopnia
process (LD, RES)
begin
    if RES = '1' then
        DATA_int <= (others => '0');
    elsif LD = '1' then
        DATA_int <= DATA;       -- wczytywanie DATA do bufora
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- rejestr wejsciowy drugiego stopnia
process (cnt_max, RES)
begin
    if RES = '1' then
        DATA_int_cmp <= (others => '0');
    elsif rising_edge(cnt_max) then          -- 
        DATA_int_cmp <= DATA_int;       -- wpisanie bufora danych do bufora komparacji gdy licznik siê przepe³ni 
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- licznik
process (CLK, CE, RES)
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
-- generowanie sygnalu przeniesienia z licznika
process (CLK, CE, RES)
begin
    if RES = '1' or cnt_out < ff then
        cnt_max <= '0';
    elsif rising_edge(CLK) and cnt_out = ff then
        if CE='1' then
            cnt_max <= '1';          -- ustawienie 1 gdy licznik siê przepe³ni
        end if;
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- komparator
process (DATA_int_cmp, cnt_out)
begin
    if cnt_out = zero then
        RES_PWM_o <= '0';
    elsif DATA_int_cmp >= cnt_out then      -- porównywanie bufora komparacji z waroœci¹ licznika aby wygenerowaæ sygna³ steruj¹cy przerzutnikiem PWM
        RES_PWM_o <= '1';
    else
        RES_PWM_o <= '0';
    end if;
end process;
-- -------------------------------------------------------------------------------------------------------
-- przerzutnik PWM
process (CLK, CE, RES, RES_PWM_o)
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
PWM <= q;

end Behavioral;
