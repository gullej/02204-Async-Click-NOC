--
-- Test bench for DEMUX_four circuit
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY DEMUX_four_TB IS
END DEMUX_four_TB;

ARCHITECTURE STRUCTURE OF DEMUX_four_TB IS
    COMPONENT DEMUX_four IS
        GENERIC (
            PHASE_INIT_A : STD_LOGIC := '0';
            PHASE_INIT_B : STD_LOGIC := '0';
            PHASE_INIT_C : STD_LOGIC := '0';
            PHASE_INIT_D : STD_LOGIC := '0';
            PHASE_INIT_E : STD_LOGIC := '0'
        );
        PORT (
            rst : IN STD_LOGIC;
            -- Input port
            rx_req_in_A  : IN  STD_LOGIC;
            rx_data_in_A : IN  STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            rx_ack_out_A : OUT STD_LOGIC;
    
            -- Select port 
            ctrl_req_in_sel  : IN  STD_LOGIC;
            ctrl_data_in_sel : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            ctrl_ack_out_sel : OUT STD_LOGIC;
    
            -- Output channel 1
            tx_req_out_B  : OUT STD_LOGIC;
            tx_data_out_B : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            tx_ack_in_B   : IN  STD_LOGIC;
    
            -- Output channel 2
            tx_req_out_C  : OUT STD_LOGIC;
            tx_data_out_C : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            tx_ack_in_C   : IN  STD_LOGIC;
    
            -- Output channel 3
            tx_req_out_D  : OUT STD_LOGIC;
            tx_data_out_D : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            tx_ack_in_D   : IN  STD_LOGIC;
    
            -- Output channel 4
            tx_req_out_E  : OUT STD_LOGIC;
            tx_data_out_E : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
            tx_ack_in_E   : IN  STD_LOGIC
        );
    END COMPONENT;

    SIGNAL start, rst : STD_LOGIC;
    SIGNAL sel_req, sel_ack : STD_LOGIC;
    SIGNAL selector_TB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL inA_req_TB, inA_ack_TB : STD_LOGIC;
    SIGNAL inB_req_TB, inB_ack_TB : STD_LOGIC;
    SIGNAL inC_req_TB, inC_ack_TB : STD_LOGIC;
    SIGNAL inD_req_TB, inD_ack_TB : STD_LOGIC;
    SIGNAL inE_req_TB, inE_ack_TB : STD_LOGIC;
    SIGNAL data_in_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL data_b_TB, data_c_TB, data_d_TB, data_e_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF sel_req, sel_ack : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inA_req_TB, inA_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inB_req_TB, inB_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inC_req_TB, inC_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inD_req_TB, inD_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inE_req_TB, inE_ack_TB : SIGNAL IS "true";

BEGIN

    inB_ack_TB <= inB_req_TB AFTER 10 ns;
    inC_ack_TB <= inC_req_TB AFTER 10 ns;
    inD_ack_TB <= inD_req_TB AFTER 10 ns;
    inE_ack_TB <= inE_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inA_req_TB <= '0';
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;
        start <= '1';
        WAIT FOR 100 ns;

        inA_req_TB <= '1';
        selector_TB <= "1000";
        sel_req <= '1';
        data_in_TB <= x"1234";

        WAIT UNTIL inE_ack_TB = '1';
        inA_req_TB <= '0';
        sel_req <= '0';
        
        WAIT FOR 50 ns;
        inA_req_TB <= '1';
        selector_TB <= "0100";
        sel_req <= '1';
        data_in_TB <= x"5678";

        WAIT UNTIL inD_ack_TB = '1';
        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;
        inA_req_TB <= '1';
        selector_TB <= "0010";
        sel_req <= '1';
        data_in_TB <= x"9ABC";

        WAIT UNTIL inC_ack_TB = '1';
        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;
        inA_req_TB <= '1';
        selector_TB <= "0001";
        sel_req <= '1';
        data_in_TB <= x"DEF0";

        WAIT UNTIL inB_ack_TB = '1';
        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    DEMUX_four_moduele : COMPONENT DEMUX_four
        PORT MAP(
        rst => rst,
        -- Input port
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
        tx_ack_in_E   => inE_ack_TB
        );

    END STRUCTURE;