
--
-- Test bench for ARBITER circuit
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY ARBITER_TB IS
END ARBITER_TB;

ARCHITECTURE STRUCTURE OF ARBITER_TB IS

    SIGNAL rst : STD_LOGIC;
    SIGNAL inA_req_TB, inA_ack_TB : STD_LOGIC;
    SIGNAL inB_req_TB, inB_ack_TB : STD_LOGIC;
    SIGNAL inC_req_TB, inC_ack_TB : STD_LOGIC;
    SIGNAL data_a_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL data_b_TB, data_c_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF inA_req_TB, inA_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inB_req_TB, inB_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inC_req_TB, inC_ack_TB : SIGNAL IS "true";

BEGIN

    inC_ack_TB <= inC_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inA_req_TB <= '0';
        inB_req_TB <= '0';
        rst <= '1';
        WAIT FOR 50 ns;
        rst <= '0';
        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        data_a_TB <= x"1234";
        --
        WAIT UNTIL inA_ack_TB = '1';
        --
        inA_req_TB <= '0';
        data_a_TB <= x"0000";
        --
        WAIT UNTIL inA_ack_TB = '0';
        --
        inB_req_TB <= '1';
        data_b_TB <= x"5678";    
        --
        WAIT UNTIL inB_ack_TB = '1';
        --
        inB_req_TB <= '0';
        data_b_TB <= x"0000";
        --
        WAIT UNTIL inB_ack_TB = '0';

        inB_req_TB <= '1';
        data_b_TB <= x"bbbb";
        WAIT FOR 1 ns;
        inA_req_TB <= '1';
        data_a_TB <= x"aaaa";

        WAIT UNTIL inB_ack_TB = '1';
        inB_req_TB <= '0';

        WAIT UNTIL inA_ack_TB = '1';
        inA_req_TB <= '0';

        WAIT FOR 50 ns;
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    arbiter : ENTITY work.ARBITER 
    PORT MAP(
        rst           => rst,
        -- Input channel 1
        inA_req       => inA_req_TB,
        inA_data      => data_a_TB,
        inA_ack       => inA_ack_TB,
        -- Input channel 2
        inB_req       => inB_req_TB,
        inB_data      => data_b_TB,
        inB_ack       => inB_ack_TB,
        -- Output channnel
        outC_req      => inC_req_TB,
        outC_data     => data_c_TB,
        outC_ack      => inC_ack_TB
    );
    
END STRUCTURE;