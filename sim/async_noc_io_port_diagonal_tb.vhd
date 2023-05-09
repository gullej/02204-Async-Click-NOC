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
    SIGNAL inA_req_TB, inA_ack_TB : STD_LOGIC;
    SIGNAL inDiag_req_TB, inDIag_ack_TB : STD_LOGIC;
    SIGNAL inYDir_req_TB, inYDir_ack_TB : STD_LOGIC;
    SIGNAL inXDir_req_TB, inXDir_ack_TB : STD_LOGIC;
    SIGNAL inLocal_req_TB, inLocal_ack_TB : STD_LOGIC;
    SIGNAL data_in_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL data_Diag_TB, data_YDir_TB, data_XDir_TB, data_Local_TB : STD_LOGIC_VECTOR(15 DOWNTO 0);

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
    ATTRIBUTE dont_touch OF inA_req_TB, inA_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inDiag_req_TB, inDiag_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inYDir_req_TB, inYDir_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inXDir_req_TB, inXDir_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inLocal_req_TB, inLocal_ack_TB : SIGNAL IS "true";

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

    inDiag_ack_TB <= inDiag_req_TB AFTER 10 ns;
    inYDir_ack_TB <= inYDir_req_TB AFTER 10 ns;
    inXDir_ack_TB <= inXDir_req_TB AFTER 10 ns;
    inLocal_ack_TB <= inLocal_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inA_req_TB <= '0';
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        inA_req_TB <= '1';
        data_in_TB <= "0000" & x"123"; -- both are not equal to the location of the router

        WAIT UNTIL inDiag_ack_TB = '1'; -- it should therefore come out of the diagonal port

        inA_req_TB <= '0';
        
        WAIT UNTIL inDiag_ack_TB = '0'; 

        inA_req_TB <= '1';
        data_in_TB <= "0101" & x"567"; -- both are equal to the location of the router

        WAIT UNTIL inLocal_ack_TB = '1'; -- it should therefore come out of the local port

        inA_req_TB <= '0';

        WAIT UNTIL inLocal_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "0001" & x"9AB"; -- x is unequal, y is equal to the location of the router

        WAIT UNTIL inXDir_ack_TB = '1'; -- it should therefore come out of the x-direction port

        inA_req_TB <= '0';

        WAIT UNTIL inXDir_ack_TB = '0';

        inA_req_TB <= '1';
        data_in_TB <= "0100" & x"DEF"; -- x is equal, y is unequal to the location of the port

        WAIT UNTIL inYDir_ack_TB = '1'; -- it should therefore come out of the y-direction port

        inA_req_TB <= '0';

        WAIT UNTIL inYDir_ack_TB = '0';
        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    diagonal_DUT : entity work.asyncoc_io_port_diagonal
        GENERIC MAP (
            LOCATION_X            =>  1,
            LOCATION_Y            =>  1,
            ADDR_WIDTH            =>  2
        )
        PORT MAP (
            -- control
            reset                 =>  rst,
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
            -- to internal diagonal port
            tx_internal_diag_req_in         =>  inDiag_req_TB,
            tx_internal_diag_ack_out        =>  inDiag_ack_TB,
            tx_internal_diag_dat_in         =>  data_Diag_TB,
            -- to internal y-direction port
            tx_internal_ydir_req_in         =>  inYDir_req_TB,
            tx_internal_ydir_ack_out        =>  inYDIR_ack_TB,
            tx_internal_ydir_dat_in         =>  data_YDIR_TB,
            -- to internal x-direction port
            tx_internal_xdir_req_in         =>  inXDir_req_TB,
            tx_internal_xdir_ack_out        =>  inXDir_ack_TB,
            tx_internal_xdir_dat_in         =>  data_Xdir_TB,
            -- to internal local
            tx_internal_local_req_in        =>  inLocal_req_TB,
            tx_internal_local_ack_out       =>  inLocal_ack_TB,
            tx_internal_local_dat_in        =>  data_Local_TB
        );

    END STRUCTURE;