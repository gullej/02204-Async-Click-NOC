--
-- Test bench for DEMUX_four circuit
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.defs.ALL;

ENTITY asyncoc_io_port_straight_tb IS
END asyncoc_io_port_straight_tb;

ARCHITECTURE STRUCTURE OF asyncoc_io_port_straight_tb IS

    SIGNAL rst : STD_LOGIC;

    SIGNAL inExternal_req_TB,  inExternal_ack_TB : STD_LOGIC;
    SIGNAL inExternal_dat_TB   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outExternal_req_TB, outExternal_ack_TB : STD_LOGIC;
    SIGNAL outExternal_dat_TB  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outLocal_req_TB,    outLocal_ack_TB : STD_LOGIC;
    SIGNAL outLocal_dat_TB     : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outAcross_req_TB,   outAcross_ack_TB : STD_LOGIC;
    SIGNAL outAcross_dat_TB    : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL inInternal_Arbiter_A_req_TB,  inInternal_Arbiter_A_ack_TB : STD_LOGIC;
    SIGNAL inInternal_Arbiter_A_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inInternal_Arbiter_B_req_TB,  inInternal_Arbiter_B_ack_TB : STD_LOGIC;
    SIGNAL inInternal_Arbiter_B_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inInternal_Arbiter_C_req_TB,  inInternal_Arbiter_C_ack_TB : STD_LOGIC;
    SIGNAL inInternal_Arbiter_C_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inInternal_Arbiter_D_req_TB,  inInternal_Arbiter_D_ack_TB : STD_LOGIC;
    SIGNAL inInternal_Arbiter_D_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF inExternal_req_TB, inExternal_ack_TB   : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outExternal_req_TB, outExternal_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outLocal_req_TB, outLocal_ack_TB       : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outAcross_req_TB, outAcross_ack_TB     : SIGNAL IS "true";

    ATTRIBUTE dont_touch of inInternal_Arbiter_A_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_A_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_B_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_B_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_C_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_C_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_D_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_D_ack_TB    :  SIGNAL IS "true";

BEGIN

    outExternal_ack_TB <= outExternal_req_TB AFTER 10 ns;
    outLocal_ack_TB <= outLocal_req_TB AFTER 10 ns;
    outAcross_ack_TB <= outAcross_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inExternal_req_TB <= '0';
        inExternal_dat_TB <= (others => '0');
        inInternal_Arbiter_A_req_TB <= '0';
        inInternal_Arbiter_B_req_TB <= '0';
        inInternal_Arbiter_C_req_TB <= '0';
        inInternal_Arbiter_D_req_TB <= '0';
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0000" & x"123"; -- the input is not equal to the location of the router

        WAIT UNTIL outAcross_ack_TB = '1'; -- so it will go to the only non-local port it can

        inExternal_req_TB <= '0';
        
        WAIT UNTIL outAcross_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0101" & x"567"; -- the input is equl to the location of the router

        WAIT UNTIL outLocal_ack_TB = '1'; -- so the message will come out of the local port

        inExternal_req_TB <= '0';

        WAIT UNTIL outLocal_ack_TB = '0';

        inInternal_Arbiter_A_req_TB <= '1';
        inInternal_Arbiter_A_dat_TB <= x"dead";
        inInternal_Arbiter_D_req_TB <= '1';
        inInternal_Arbiter_D_dat_TB <= x"beef";

        WAIT UNTIL inInternal_Arbiter_A_ack_TB = '1';

        inInternal_Arbiter_A_req_TB <= '0';
        inInternal_Arbiter_A_dat_TB <= x"0000";

        --WAIT UNTIL inInternal_Arbiter_D_ack_TB = '1';
--
        --inInternal_Arbiter_D_req_TB <= '0';
        --inInternal_Arbiter_D_dat_TB <= x"0000";
--
        --WAIT UNTIL inInternal_Arbiter_D_ack_TB = '0';

        WAIT FOR 500 ns;
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    diagonal_DUT : entity work.async_noc_io_port_straight
        GENERIC MAP (
            LOCATION_X             =>  1,
            LOCATION_Y             =>  1,
            ADDR_WIDTH             =>  2
        )
        PORT MAP(
            -- control
            reset                     =>  rst,
            -- from local   
            rx_local_req_in           =>  inInternal_Arbiter_A_req_TB ,
            rx_local_ack_out          =>  inInternal_Arbiter_A_ack_TB ,
            rx_local_dat_in           =>  inInternal_Arbiter_A_dat_TB,
            -- from internal a   
            rx_internal_a_req_in      =>  inInternal_Arbiter_B_req_TB ,
            rx_internal_a_ack_out     =>  inInternal_Arbiter_B_ack_TB ,
            rx_internal_a_dat_in      =>  inInternal_Arbiter_B_dat_TB,
            -- from internal b   
            rx_internal_b_req_in      =>  inInternal_Arbiter_C_req_TB ,
            rx_internal_b_ack_out     =>  inInternal_Arbiter_C_ack_TB ,
            rx_internal_b_dat_in      =>  inInternal_Arbiter_C_dat_TB,
            -- from internal c   
            rx_internal_c_req_in      =>  inInternal_Arbiter_D_req_TB ,
            rx_internal_c_ack_out     =>  inInternal_Arbiter_D_ack_TB ,
            rx_internal_c_dat_in      =>  inInternal_Arbiter_D_dat_TB,
            -- from external   
            rx_external_req_in        =>  inExternal_req_TB,
            rx_external_ack_out       =>  inExternal_ack_TB,
            rx_external_dat_in        =>  inExternal_dat_TB,
            -- to external   
            tx_external_req_in        =>  outExternal_req_TB,
            tx_external_ack_out       =>  outExternal_ack_TB,
            tx_external_dat_in        =>  outExternal_dat_TB,
            -- to internal local
            tx_internal_local_req_in  =>  outLocal_req_TB,
            tx_internal_local_ack_out =>  outLocal_ack_TB,
            tx_internal_local_dat_in  =>  outLocal_dat_TB,
            -- to internal straight
            tx_internal_across_req_in  =>  outAcross_req_TB,
            tx_internal_across_ack_out =>  outAcross_ack_TB,
            tx_internal_across_dat_in  =>  outAcross_dat_TB
        );

    END STRUCTURE;