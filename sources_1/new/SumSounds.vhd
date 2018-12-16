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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
           
           KICK_IN : in STD_LOGIC_VECTOR (7 downto 0);
           SNARE_IN : in STD_LOGIC_VECTOR (7 downto 0);
           HAT_IN : in STD_LOGIC_VECTOR (7 downto 0);
           CRASH_IN : in STD_LOGIC_VECTOR (7 downto 0);
           RIDE_IN : in STD_LOGIC_VECTOR (7 downto 0);
           TOM1_IN : in STD_LOGIC_VECTOR (7 downto 0);
           TOM2_IN : in STD_LOGIC_VECTOR (7 downto 0);
           
           SAMPLE_AV : out STD_LOGIC;
           SAMPLE_OUT : out STD_LOGIC_VECTOR (7 downto 0)
           );
end SumSounds;

architecture Behavioral of SumSounds is
-- ------------------------------------------------------------------------------------
signal sum: std_logic_vector(7 downto 0):="00000000";

signal kick_s: std_logic_vector(7 downto 0):="00000000";
signal snare_s: std_logic_vector(7 downto 0):="00000000";
signal hat_s: std_logic_vector(7 downto 0):="00000000";
signal crash_s: std_logic_vector(7 downto 0):="00000000";
signal ride_s: std_logic_vector(7 downto 0):="00000000";
signal tom1_s: std_logic_vector(7 downto 0):="00000000";
signal tom2_s: std_logic_vector(7 downto 0):="00000000";

begin
-- ------------------------------------------------------------------------------------
kick_s <= KICK_IN;
snare_s <= SNARE_IN;
hat_s <= HAT_IN;
crash_s <= CRASH_IN;
ride_s <= RIDE_IN;
tom1_s <= TOM1_IN;
tom2_s <= TOM2_IN;
-- ------------------------------------------------------------------------------------
-- generating SAMPLE_AV signal to tell that sample is available
sample_p : process(CLK,CE,RST)
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
sum_p : process(CLK,CE,RST)
begin
    if rising_edge(CLK) then
        if RST = '1' then                    
            sum <= (others => '0');
        elsif CE = '1' then
            sum <= kick_s + snare_s + hat_s + crash_s + ride_s + tom1_s + tom2_s;                               
        end if;
    end if;   
end process;
-- ------------------------------------------------------------------------------------
SAMPLE_OUT <= sum;

end Behavioral;
