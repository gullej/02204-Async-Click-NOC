--
-- Test bench for DEMUX_eight circuit
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY DEMUX_eight_TB IS
END DEMUX_eight_TB;

ARCHITECTURE STRUCTURE OF DEMUX_eight_TB IS

    SIGNAL rst : STD_LOGIC;
    SIGNAL sel_req, sel_ack : STD_LOGIC;
    SIGNAL selector_TB : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL inA_req_TB, inA_ack_TB : STD_LOGIC;
    SIGNAL inB_req_TB, inB_ack_TB : STD_LOGIC;
    SIGNAL inC_req_TB, inC_ack_TB : STD_LOGIC;
    SIGNAL inD_req_TB, inD_ack_TB : STD_LOGIC;
    SIGNAL inE_req_TB, inE_ack_TB : STD_LOGIC;
    SIGNAL inF_req_TB, inF_ack_TB : STD_LOGIC;
    SIGNAL inG_req_TB, inG_ack_TB : STD_LOGIC;
    SIGNAL inH_req_TB, inH_ack_TB : STD_LOGIC;
    SIGNAL inI_req_TB, inI_ack_TB : STD_LOGIC;
    SIGNAL data_in_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL data_b_TB, data_c_TB, data_d_TB, data_e_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL data_f_TB, data_g_TB, data_h_TB, data_i_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF sel_req, sel_ack : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inA_req_TB, inA_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inB_req_TB, inB_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inC_req_TB, inC_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inD_req_TB, inD_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inE_req_TB, inE_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inF_req_TB, inF_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inG_req_TB, inG_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inH_req_TB, inH_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inI_req_TB, inI_ack_TB : SIGNAL IS "true";

BEGIN

    inB_ack_TB <= inB_req_TB AFTER 10 ns;
    inC_ack_TB <= inC_req_TB AFTER 10 ns;
    inD_ack_TB <= inD_req_TB AFTER 10 ns;
    inE_ack_TB <= inE_req_TB AFTER 10 ns;
    inF_ack_TB <= inF_req_TB AFTER 10 ns;
    inG_ack_TB <= inG_req_TB AFTER 10 ns;
    inH_ack_TB <= inH_req_TB AFTER 10 ns;
    inI_ack_TB <= inI_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inA_req_TB <= '0';
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        inA_req_TB <= '1';
        selector_TB <= "10000000";
        sel_req <= '1';
        data_in_TB <= x"1234";

        WAIT UNTIL inI_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';
        
        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "01000000";
        sel_req <= '1';
        data_in_TB <= x"5678";

        WAIT UNTIL inH_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "00100000";
        sel_req <= '1';
        data_in_TB <= x"9ABC";

        WAIT UNTIL inG_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "00010000";
        sel_req <= '1';
        data_in_TB <= x"DEF0";

        WAIT UNTIL inF_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "00001000";
        sel_req <= '1';
        data_in_TB <= x"FEED";

        WAIT UNTIL inE_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "00000100";
        sel_req <= '1';
        data_in_TB <= x"DEAD";

        WAIT UNTIL inD_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "00000010";
        sel_req <= '1';
        data_in_TB <= x"BEEF";

        WAIT UNTIL inC_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        selector_TB <= "00000001";
        sel_req <= '1';
        data_in_TB <= x"0DAD";

        WAIT UNTIL inB_ack_TB = '1';
        
        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    DEMUX_eight_module : ENTITY work.DEMUX_eight
        PORT MAP(
        rst => rst,
        -- Input port       -- Input port
        rx_req_in_A  => inA_req_TB,
        rx_data_in_A => data_in_TB,
        rx_ack_out_A => inA_ack_TB,
        -- Select port 
        ctrl_req_in_sel  => sel_req,
        ctrl_data_in_sel => selector_TB,
        ctrl_ack_out_sel => sel_ack,
        -- Output channel 1
        tx_req_out_B  => inB_req_TB,
        tx_data_out_B => data_b_TB,
        tx_ack_in_B   => inB_ack_TB,

        -- Output channel 2
        tx_req_out_C  => inC_req_TB,
        tx_data_out_C => data_c_TB,
        tx_ack_in_C   => inC_ack_TB,

        -- Output channel 3
        tx_req_out_D  => inD_req_TB,
        tx_data_out_D => data_d_TB,
        tx_ack_in_D   => inD_ack_TB,

        -- Output channel 4
        tx_req_out_E  => inE_req_TB,
        tx_data_out_E => data_e_TB,
        tx_ack_in_E   => inE_ack_TB,

        -- Output channel 5
        tx_req_out_F  => inF_req_TB,
        tx_data_out_F => data_f_TB,
        tx_ack_in_F   => inF_ack_TB,

        -- Output channel 6
        tx_req_out_G  => inG_req_TB,
        tx_data_out_G => data_g_TB,
        tx_ack_in_G   => inG_ack_TB,

        -- Output channel 7
        tx_req_out_H  => inH_req_TB,
        tx_data_out_H => data_h_TB,
        tx_ack_in_H   => inH_ack_TB,

        -- Output channel 8
        tx_req_out_I  => inI_req_TB,
        tx_data_out_I => data_i_TB,
        tx_ack_in_I   => inI_ack_TB
        );

    END STRUCTURE;