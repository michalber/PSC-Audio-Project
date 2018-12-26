----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2018 13:36:06
-- Design Name: 
-- Module Name: SumSounds - Behavioral
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

entity SumSounds is
    Port ( CLK : in STD_LOGIC;      -- 100MHz clock
           CE : in STD_LOGIC;       -- CE to step down CLK to 100kHz
           RST : in STD_LOGIC;
           
           KICK_IN : in signed (7 downto 0);
           SNARE_IN : in signed (7 downto 0);
           HAT_IN : in signed (7 downto 0);
           CRASH_IN : in signed (7 downto 0);
           RIDE_IN : in signed (7 downto 0);
           TOM1_IN : in signed (7 downto 0);
           TOM2_IN : in signed (7 downto 0);
           
           SAMPLE_AV : out STD_LOGIC;
           SAMPLE_OUT : out std_logic_vector (7 downto 0)
           );
end SumSounds;

architecture Behavioral of SumSounds is
-- ------------------------------------------------------------------------------------
signal sum_s: signed(8 downto 0):= (others => '0');
signal sum_us: unsigned(8 downto 0):= (others => '0');

signal kick_s: signed(8 downto 0):= (others => '0');
signal snare_s: signed(8 downto 0):= (others => '0');
signal hat_s: signed(8 downto 0):= (others => '0');
signal crash_s: signed(8 downto 0):= (others => '0');
signal ride_s: signed(8 downto 0):= (others => '0');
signal tom1_s: signed(8 downto 0):= (others => '0');
signal tom2_s: signed(8 downto 0):= (others => '0');

begin
-- ------------------------------------------------------------------------------------
kick_s <= resize(KICK_IN, kick_s'length);
snare_s <= resize(SNARE_IN, kick_s'length);
hat_s <= resize(HAT_IN, kick_s'length);
crash_s <= resize(CRASH_IN, kick_s'length);
ride_s <= resize(RIDE_IN, kick_s'length);
tom1_s <= resize(TOM1_IN, kick_s'length);
tom2_s <= resize(TOM2_IN, kick_s'length);
-- ------------------------------------------------------------------------------------
-- generating SAMPLE_AV signal to tell that sample is available
sample_p : process(CLK)
begin
    if rising_edge(CLK) then
        if RST = '1' then                    
            SAMPLE_AV <= '0';
        elsif CE = '1' then
            SAMPLE_AV <= '1';
        else 
            SAMPLE_AV <= '0';
        end if;
    end if;   
end process;
-- ------------------------------------------------------------------------------------
-- addition of all signals to make one sample to send to PDM generator
sum_p : process(CLK)
begin
    if rising_edge(CLK) then
        if RST = '1' then                    
            sum_s <= (others => '0');
        elsif CE = '1' then
            sum_s <= kick_s + snare_s + hat_s + crash_s + ride_s + tom1_s + tom2_s ;                                                                                                                  
        end if;
    end if;   
end process;
-- ------------------------------------------------------------------------------------
sum_us_p : process(CLK)
begin 
    if rising_edge(CLK) then
        if RST = '1' then
            sum_us <= (others => '0');
        elsif CE = '1' then
            if sum_s < b"1_1000_0000" then  -- casting to signed number
                sum_us <= (others => '0');
            elsif sum_s > b"0_0111_1111" then
                sum_us <= (others => '1');                                            
            else
                sum_us <= unsigned(sum_s) + 128;
            end if;
        end if;
    end if;                 
end process;
-- ------------------------------------------------------------------------------------
SAMPLE_OUT <= std_logic_vector(unsigned'(resize(sum_us, SAMPLE_OUT'length)));

end Behavioral;
