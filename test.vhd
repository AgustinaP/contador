------------------------------------------------
--            Electrónica Digital             --
--       Autor: Nadia Agustina Pizarro        --
--                   Test                     --
------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
--  Port ( );
end test;

architecture Behavioral of test is
    signal s_syn_clr,s_load,s_en,s_up,s_clk,s_max_tick,s_min_tick: STD_LOGIC:='0';
    signal enable: std_logic := '1';
    signal s_q,s_d: STD_LOGIC_VECTOR (3 downto 0);       
begin
    utt: entity work.contador(Behavioral)PORT MAP (
       syn_clr=>s_syn_clr,
       load=>s_load,
       en=>s_en,
       up=>s_up,
       clk=>s_clk,
       max_tick=>s_max_tick,
       min_tick=>s_min_tick,
       q=>s_q,
       d=>s_d   
    );
    reloj: process
    begin
     
        s_clk<='1'; wait for 10 ns;
        s_clk<='0'; wait for 10 ns;
        if enable = '0' then 
              wait;
        end if;
                
    end process;
    simulacion: process
    begin
    s_syn_clr <= '1'; wait for 20 ns;
    s_syn_clr <= '0';
    
    s_en<='1';
    s_up<='1';
    for i in 0 to 17 loop
        wait until rising_edge(s_clk);
    end loop;
    s_load<='1';
    s_d<="0011";
    wait until rising_edge(s_clk);
    s_load<='0';
    s_en<='1';
    s_up<='0';
    for i in 0 to 6 loop
        wait until rising_edge(s_clk);
    end loop;
    s_load<='1';
    s_d<="0110";
    wait until rising_edge(s_clk); 
    s_load<='0';
    s_en<='1';
    s_up<='1';
    for i in 0 to 6 loop
        wait until rising_edge(s_clk);
    end loop;
    s_en<='0';
    s_up<='1';
    for i in 0 to 6 loop
        wait until rising_edge(s_clk);
    end loop;
        
    assert false report "Hola! todo esta bien gg izi pizi" severity note;
    enable<='0';
    wait;
    end process; 


end Behavioral;
