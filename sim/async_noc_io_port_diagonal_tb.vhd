--
-- Test bench for DEMUX_four circuit
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY async_noc_io_port_diagonal_tb IS
END async_noc_io_port_diagonal_tb;

ARCHITECTURE STRUCTURE OF async_noc_io_port_diagonal_tb IS

    SIGNAL rst : STD_LOGIC;
    SIGNAL sel_req, sel_ack : STD_LOGIC;
    SIGNAL selector_TB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL inA_req_TB, inA_ack_TB : STD_LOGIC;
    SIGNAL inB_req_TB, inB_ack_TB : STD_LOGIC;
    SIGNAL inC_req_TB, inC_ack_TB : STD_LOGIC;
    SIGNAL inD_req_TB, inD_ack_TB : STD_LOGIC;
    SIGNAL inE_req_TB, inE_ack_TB : STD_LOGIC;
    SIGNAL data_in_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL data_b_TB, data_c_TB, data_d_TB, data_e_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inA_req_TB    :  STD_LOGIC;
    SIGNAL arbiter_inA_ack_TB    :  STD_LOGIC;
    SIGNAL arbiter_inA_data_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL arbiter_inB_req_TB    :  STD_LOGIC;
    SIGNAL arbiter_inB_ack_TB    :  STD_LOGIC;
    SIGNAL arbiter_inB_data_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL arbiter_outA_req_TB   :  STD_LOGIC;
    SIGNAL arbiter_outA_ack_TB   :  STD_LOGIC;
    SIGNAL arbiter_outA_data_TB  :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF sel_req, sel_ack : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inA_req_TB, inA_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inB_req_TB, inB_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inC_req_TB, inC_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inD_req_TB, inD_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inE_req_TB, inE_ack_TB : SIGNAL IS "true";

    ATTRIBUTE dont_touch of arbiter_inA_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inA_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inA_data_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_data_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_req_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_ack_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_data_TB  :  SIGNAL IS "true";

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

        inA_req_TB <= '1';
        data_in_TB <= "0000" & x"123";

        WAIT UNTIL inE_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';
        
        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        data_in_TB <= "0101" & x"567";

        WAIT UNTIL inD_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        data_in_TB <= "0001" & x"9AB";

        WAIT UNTIL inC_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        data_in_TB <= "0100" & x"DEF";

        WAIT UNTIL inB_ack_TB = '1';

        inA_req_TB <= '0';
        sel_req <= '0';

        WAIT FOR 50 ns;
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    diagonal_DUT : entity work.asyncoc_io_port_diagonal
        GENERIC (
            LOCATION_X            =>  1,
            LOCATION_Y            =>  1,
            ADDR_WIDTH            =>  2,
        );
        PORT (
            -- control
            reset                 =>  rst,
            start                 =>  '0',
            -- from local
            rx_local_req_in       =>  arbiter_inA_req_TB ,
            rx_local_ack_out      =>  arbiter_inA_ack_TB ,
            rx_local_dat_in       =>  arbiter_inA_data_TB,
            -- from internal
            rx_internal_req_in    => arbiter_inB_req_TB ,
            rx_internal_ack_out   => arbiter_inB_ack_TB ,
            rx_internal_dat_in    => arbiter_inB_data_TB,
            -- from external
            rx_external_req_in    =>  inA_req_TB,
            rx_external_ack_out   =>  inA_ack_TB,
            rx_external_dat_in    =>  data_in_TB,
            -- to external
            tx_external_req_in    =>  arbiter_outA_req_TB ,
            tx_external_ack_out   =>  arbiter_outA_ack_TB ,
            tx_external_dat_in    =>  arbiter_outA_data_TB,
            -- to local
            tx_local_req_in       =>  inB_req_TB,
            tx_local_ack_out      =>  data_b_TB,
            tx_local_dat_in       =>  inB_ack_TB,
            -- to internal 1
            tx_internal_0_req_in  =>  inC_req_TB,
            tx_internal_0_ack_out =>  data_c_TB,
            tx_internal_0_dat_in  =>  inC_ack_TB,
            -- to internal 1
            tx_internal_1_req_in  =>  inD_req_TB,
            tx_internal_1_ack_out =>  data_d_TB,
            tx_internal_1_dat_in  =>  inD_ack_TB,
            -- to internal 1
            tx_internal_2_req_in  =>  inE_req_TB,
            tx_internal_2_ack_out =>  data_e_TB,
            tx_internal_2_dat_in  =>  inE_ack_TB
        );

    END STRUCTURE;