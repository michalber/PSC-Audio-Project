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

entity top is
  port(
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       PDM : out STD_LOGIC;
       WAVE : out STD_LOGIC_VECTOR(7 downto 0)
  );
end top;

architecture Behavioral of top is

---- Component declarations -----

component audio_PWM
  generic(
       PWM_RES : POSITIVE := 8
  );
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       DATA : in STD_LOGIC_VECTOR(PWM_RES-1 downto 0);
       LD : in STD_LOGIC;
       RES : in STD_LOGIC;
       PWM : out STD_LOGIC
  );
end component;
component Prescaler
  port (
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK_100k : out STD_LOGIC;
       CLK_25M : out STD_LOGIC
  );
end component;
component triangle_gen
  generic(
       bitWidth : POSITIVE := 8
  );
  port (
       CE : in STD_LOGIC;
       CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       SAMPLE : out STD_LOGIC;
       WAVE_OUT : out STD_LOGIC_VECTOR(bitWidth-1 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal NET101 : STD_LOGIC;
signal NET41 : STD_LOGIC;
signal NET80 : STD_LOGIC;
signal BUS158 : STD_LOGIC_VECTOR(7 downto 0);

begin

----  Component instantiations  ----

U1 : audio_PWM
  port map(
       CE => NET80,
       CLK => CLK,
       DATA => BUS158(7 downto 0),
       LD => NET101,
       PWM => PDM,
       RES => RST
  );

U2 : Prescaler
  port map(
       CLK => CLK,
       CLK_100k => NET41,
       CLK_25M => NET80,
       RST => RST
  );

U3 : triangle_gen
  port map(
       CE => NET41,
       CLK => CLK,
       RST => RST,
       SAMPLE => NET101,
       WAVE_OUT => BUS158(7 downto 0)
  );


---- Terminal assignment ----

    -- Output\buffer terminals
	WAVE <= BUS158;


end Behavioral;

