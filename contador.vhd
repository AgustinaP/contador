------------------------------------------------
--            Electrónica Digital             --
--       Autor: Nadia Agustina Pizarro        --
--                  Contador                  --
------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
    generic(N: integer:=4);
    Port ( syn_clr : in STD_LOGIC;
           load : in STD_LOGIC;
           en : in STD_LOGIC;
           up : in STD_LOGIC;
           clk : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (N-1 downto 0);
           d : in STD_LOGIC_VECTOR (N-1 downto 0);
           max_tick : out STD_LOGIC;
           min_tick : out STD_LOGIC);
end contador;

architecture Behavioral of contador is
signal state_reg,state_next: std_logic_vector(N-1 downto 0);
signal un_state_reg: unsigned(N-1 downto 0);

signal s_salida: STD_LOGIC_VECTOR(N-1 downto 0);

begin


process(clk)
begin
    if(rising_edge(clk))then
        state_reg<=state_next;
    else
        state_reg<=state_reg;
    end if;
end process;


  -- output logic--
  
  q<=state_reg;

  max_tick <= '1' when un_state_reg = N-1 else
               '0';
  min_tick <= '1' when un_state_reg = 0 else
               '0';  
               
  -- next state logic--
  
  un_state_reg <=unsigned(state_reg);
  state_next <= (others=> '0')                   when syn_clr = '1'    else
                d                                when load = '1'       else
                std_logic_vector(un_state_reg+1) when en='1' and up='1'else
                std_logic_vector(un_state_reg-1) when en='1' and up='0'else
                state_reg;
                
               
               
end Behavioral;
