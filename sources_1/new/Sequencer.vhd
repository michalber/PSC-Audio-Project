----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2019 19:26:00
-- Design Name: 
-- Module Name: Sequencer - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--      SOUNDS_IN / SOUND_OUT pinout
--      7-KICK
--      6-SNARE
--      5-HHAT
--      4-CRASH
--      3-RIDE
--      2-TOM1
--      1-TOM2
--      0-TOM3

entity Sequencer is
Port ( CLK : in STD_LOGIC;
       CE : in STD_LOGIC;   -- BPM In
       RST : in STD_LOGIC;
       MODE : in STD_LOGIC;
       CLEAR : in STD_LOGIC;
       SOUNDS_IN : in STD_LOGIC_VECTOR(7 downto 0);
       SOUNDS_OUT : out STD_LOGIC_VECTOR(7 downto 0)
       );
end Sequencer;

architecture Behavioral of Sequencer is

type mem is array (0 to 127) of STD_LOGIC_VECTOR(7 downto 0);

constant music_samples: mem := (
    --  1           2           3               4           5           6               7           8
    --  1
    b"1010_0000",b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    --  2
    b"1110_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    --  3
    b"1010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    --  4
    b"1110_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    -- 5
    b"1010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    --  6
    b"1110_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    --  7
    b"1010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"0010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    --  8
    b"1110_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",
    b"1010_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000",b"0000_0000"
   );
   
--signal recorded_samples: mem := (others => x"00");
signal cnt_out: integer := 0;	
constant cnt_max: integer := 127;
--signal out_signal: STD_LOGIC_VECTOR(7 downto 0) := x"00";

begin

-- 7bit counter
process (CLK)
begin     
    if rising_edge(CLK) then
        if RST = '1' then
            cnt_out <= 0;
        elsif CE = '1' then
            cnt_out <= cnt_out + 1;       
        end if;
--        if cnt_out = cnt_max then
--            cnt_out <= 0;            
--        end if;        
    end if;
end process;

-- playing sounds from ROM
process (CLK,RST) 
begin
    if rising_edge(CLK) then        
        if RST = '1' then
            SOUNDS_OUT <= x"00";
        elsif CE='1' then 
            if MODE = '0' then                                             -- manual playing
                SOUNDS_OUT <= SOUNDS_IN;
            elsif MODE = '1' then                                          -- playing custom sound from ROM                                             
                SOUNDS_OUT <= music_samples(cnt_out);                                     
            end if;
        else 
            SOUNDS_OUT <= (others => '0');
        end if;            
    end if;    
end process;

end Behavioral;
