----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2018 20:56:10
-- Design Name: 
-- Module Name: top - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
  port(
       CLK : in STD_LOGIC;
       RES : in STD_LOGIC;
       PWM_OUT : out STD_LOGIC
  );
end top;

architecture Behavioral of top is

component audio_PWM
  port (
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       SAMPLE : in STD_LOGIC;
       WAVE_IN : in STD_LOGIC_VECTOR(7 downto 0);
       PWM_OUT : out STD_LOGIC
  );
end component;
component Prescaler
  port (
       CLK : in STD_LOGIC;
       CLR : in STD_LOGIC;
       CEO : out STD_LOGIC
  );
end component;
component triangle_gen
  port (
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       SAMPLE : out STD_LOGIC;
       WAVE_OUT : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal NET43 : STD_LOGIC;
signal NET83 : STD_LOGIC;
signal BUS39 : STD_LOGIC_VECTOR(7 downto 0);

begin

----  Component instantiations  ----

U1 : audio_PWM
  port map(
       CLK => NET83,
       PWM_OUT => PWM_OUT,
       RST => RES,
       SAMPLE => NET43,
       WAVE_IN => BUS39
  );

U2 : Prescaler
  port map(
       CEO => NET83,
       CLK => CLK,
       CLR => RES
  );

U3 : triangle_gen
  port map(
       CLK => CLK,
       RST => RES,
       SAMPLE => NET43,
       WAVE_OUT => BUS39
  );

end Behavioral;
