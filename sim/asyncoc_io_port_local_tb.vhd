--
-- Test bench for async noc router local port circuit
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_local_tb IS
END asyncoc_io_port_local_tb;

ARCHITECTURE STRUCTURE OF asyncoc_io_port_local_tb IS

    SIGNAL rst : STD_LOGIC;
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
    SIGNAL data_b_TB, data_c_TB, data_d_TB, data_e_TB, data_f_TB, data_g_TB, data_h_TB, data_i_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inLocal_req_TB    :  STD_LOGIC;
    SIGNAL arbiter_inLocal_ack_TB    :  STD_LOGIC;
    SIGNAL arbiter_inLocal_data_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inA_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inA_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inA_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inB_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inB_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inB_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    
    SIGNAL arbiter_inC_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inC_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inC_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inD_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inD_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inD_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inE_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inE_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inE_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inF_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inF_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inF_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_inG_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inG_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inG_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_outA_req_TB       :  STD_LOGIC;
    SIGNAL arbiter_outA_ack_TB       :  STD_LOGIC;
    SIGNAL arbiter_outA_data_TB      :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF inA_req_TB, inA_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inB_req_TB, inB_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inC_req_TB, inC_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inD_req_TB, inD_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inE_req_TB, inE_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inF_req_TB, inF_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inG_req_TB, inG_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inH_req_TB, inH_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inI_req_TB, inI_ack_TB : SIGNAL IS "true";

    ATTRIBUTE dont_touch of arbiter_inLocal_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inLocal_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inLocal_data_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inA_req_TB        :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inA_ack_TB        :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inA_data_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_req_TB        :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_ack_TB        :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_data_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_data_TB      :  SIGNAL IS "true";

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
        inA_req_TB<= '0';
        arbiter_inA_req_TB <= '0';
        arbiter_inB_req_TB <= '0';
        arbiter_inC_req_TB <= '0';
        arbiter_inD_req_TB <= '0';
        arbiter_inE_req_TB <= '0';
        arbiter_inF_req_TB <= '0';
        arbiter_inG_req_TB <= '0';
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        inA_req_TB <= '1';
        data_in_TB <= "0000" & x"123"; -- down down, should go 

        WAIT UNTIL inH_ack_TB = '1';

        inA_req_TB <= '0';
        
        WAIT UNTIL inH_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "0001" & x"567"; -- down equal, should go 

        WAIT UNTIL inC_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT UNTIL inC_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "0100" & x"9AB"; -- equal down, should go

        WAIT UNTIL inI_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT UNTIL inI_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "0010" & x"DEF"; -- down up, should go 

        WAIT UNTIL inE_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT UNTIL inE_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "1000" & x"9AB"; -- up down, should go 

        WAIT UNTIL inG_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT FOR 50 ns;

        inA_req_TB <= '1';
        data_in_TB <= "1010" & x"9AB"; -- up up, should go

        WAIT UNTIL inD_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT UNTIL inD_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "1001" & x"9AB"; -- up equal, should go

        WAIT UNTIL inB_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT UNTIL inB_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "0110" & x"9AB"; -- equal up, should go

        WAIT UNTIL inF_ack_TB = '1';

        inA_req_TB <= '0';

        WAIT UNTIL inF_ack_TB = '0';
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    local_DUT : entity work.asyncoc_io_port_local
    GENERIC MAP (
        LOCATION_X               =>  1,
        LOCATION_Y               =>  1,
        ADDR_WIDTH               =>  2
    )
    PORT MAP (
        -- control
        reset                    =>  rst,
        start                    =>  '0',
        -- from local
        rx_local_req_in          =>  arbiter_inLocal_req_TB ,
        rx_local_ack_out         =>  arbiter_inLocal_ack_TB ,
        rx_local_dat_in          =>  arbiter_inLocal_data_TB,
        -- from internal a
        rx_internal_a_req_in     =>  arbiter_inA_req_TB ,
        rx_internal_a_ack_out    =>  arbiter_inA_ack_TB ,
        rx_internal_a_dat_in     =>  arbiter_inA_data_TB,
        -- from internal b
        rx_internal_b_req_in     =>  arbiter_inB_req_TB ,
        rx_internal_b_ack_out    =>  arbiter_inB_ack_TB ,
        rx_internal_b_dat_in     =>  arbiter_inB_data_TB,
        -- from internal c
        rx_internal_c_req_in     =>  arbiter_inC_req_TB ,
        rx_internal_c_dat_in     =>   arbiter_inC_data_TB,
        rx_internal_c_ack_out    =>  arbiter_inC_ack_TB,
        -- from internal d
        rx_internal_d_req_in     =>  arbiter_inD_req_TB ,
        rx_internal_d_dat_in     =>  arbiter_inD_data_TB ,
        rx_internal_d_ack_out    =>  arbiter_inD_ack_TB,

        rx_internal_e_req_in     =>  arbiter_inE_req_TB ,
        rx_internal_e_dat_in     =>  arbiter_inE_data_TB ,
        rx_internal_e_ack_out    =>  arbiter_inE_ack_TB,

        rx_internal_f_req_in     =>  arbiter_inF_req_TB ,
        rx_internal_f_dat_in     =>  arbiter_inF_data_TB ,
        rx_internal_f_ack_out    =>  arbiter_inF_ack_TB,

        rx_internal_g_req_in     =>  arbiter_inG_req_TB ,
        rx_internal_g_dat_in     =>  arbiter_inG_data_TB ,
        rx_internal_g_ack_out    =>  arbiter_inG_ack_TB,

        -- from external
        rx_external_req_in       =>  inA_req_TB,
        rx_external_ack_out      =>  inA_ack_TB,
        rx_external_dat_in       =>  data_in_TB,
        -- to external
        tx_external_req_in       =>  arbiter_outA_req_TB ,
        tx_external_ack_out      =>  arbiter_outA_ack_TB ,
        tx_external_dat_in       =>  arbiter_outA_data_TB,
        -- to internal 0
        tx_internal_0_req_in     =>  inB_req_TB,
        tx_internal_0_ack_out    =>  inB_ack_TB,
        tx_internal_0_dat_in     =>  data_b_TB,
        -- to internal 1
        tx_internal_1_req_in     =>  inC_req_TB,
        tx_internal_1_ack_out    =>  inC_ack_TB,
        tx_internal_1_dat_in     =>  data_c_TB,
        -- to internal 2
        tx_internal_2_req_in     =>  inD_req_TB,
        tx_internal_2_ack_out    =>  inD_ack_TB,
        tx_internal_2_dat_in     =>  data_d_TB,
        -- to internal 3
        tx_internal_3_req_in     =>  inE_req_TB,
        tx_internal_3_ack_out    =>  inE_ack_TB,
        tx_internal_3_dat_in     =>  data_e_TB,
        -- to internal 4
        tx_internal_4_req_in     =>  inF_req_TB,
        tx_internal_4_ack_out    =>  inF_ack_TB,
        tx_internal_4_dat_in     =>  data_f_TB,
        -- to internal 5
        tx_internal_5_req_in     =>  inG_req_TB,
        tx_internal_5_ack_out    =>  inG_ack_TB,
        tx_internal_5_dat_in     =>  data_g_TB,
        -- to internal 6
        tx_internal_6_req_in     =>  inH_req_TB,
        tx_internal_6_ack_out    =>  inH_ack_TB,
        tx_internal_6_dat_in     =>  data_h_TB,
        -- to internal 7
        tx_internal_7_req_in     =>  inI_req_TB,
        tx_internal_7_ack_out    =>  inI_ack_TB,
        tx_internal_7_dat_in     =>  data_i_TB
    );

    END STRUCTURE;