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
    SIGNAL inExternal_req_TB,  inExternal_ack_TB  :  STD_LOGIC;
    SIGNAL inExternal_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outExternal_req_TB, outExternal_ack_TB  :  STD_LOGIC;
    SIGNAL outExternal_dat_TB  :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outDiag_req_TB,      outDIag_ack_TB  :  STD_LOGIC;
    SIGNAL outDiag_dat_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outYDir_req_TB,      outYDir_ack_TB  :  STD_LOGIC;
    SIGNAL outYDir_dat_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outXDir_req_TB,      outXDir_ack_TB  :  STD_LOGIC;
    SIGNAL outXDir_dat_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL outLocal_req_TB,     outLocal_ack_TB  :  STD_LOGIC;
    SIGNAL outLocal_dat_TB      :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL inInternal_Arbiter_A_req_TB,  inInternal_Arbiter_A_ack_TB :  STD_LOGIC;
    SIGNAL inInternal_Arbiter_A_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inInternal_Arbiter_B_req_TB,  inInternal_Arbiter_B_ack_TB :  STD_LOGIC;
    SIGNAL inInternal_Arbiter_B_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF inExternal_req_TB, inExternal_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outDiag_req_TB, outDiag_ack_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outYDir_req_TB, outYDir_ack_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outXDir_req_TB, outXDir_ack_TB   :  SIGNAL IS "true";
    ATTRIBUTE dont_touch OF outLocal_req_TB, outLocal_ack_TB :  SIGNAL IS "true";

    ATTRIBUTE dont_touch of inInternal_Arbiter_A_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_A_ack_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_B_req_TB    :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of inInternal_Arbiter_B_ack_TB    :  SIGNAL IS "true";

BEGIN

    outExternal_ack_TB <= outExternal_req_TB AFTER 10 ns;
    outDiag_ack_TB <= outDiag_req_TB AFTER 10 ns;
    outYDir_ack_TB <= outYDir_req_TB AFTER 10 ns;
    outXDir_ack_TB <= outXDir_req_TB AFTER 10 ns;
    outLocal_ack_TB <= outLocal_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inExternal_req_TB <= '0';
        inExternal_dat_TB <= (others => '0');
        inInternal_Arbiter_A_req_TB <= '0';
        inInternal_Arbiter_B_req_TB <= '0';
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0000" & x"123"; -- both are not equal to the location of the router

        WAIT UNTIL outDiag_ack_TB = '1'; -- it should therefore come out of the diagonal port

        inExternal_req_TB <= '0';
        
        WAIT UNTIL outDiag_ack_TB = '0'; 

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0101" & x"567"; -- both are equal to the location of the router

        WAIT UNTIL outLocal_ack_TB = '1'; -- it should therefore come out of the local port

        inExternal_req_TB <= '0';

        WAIT UNTIL outLocal_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0001" & x"9AB"; -- x is unequal, y is equal to the location of the router

        WAIT UNTIL outXDir_ack_TB = '1'; -- it should therefore come out of the x-direction port

        inExternal_req_TB <= '0';

        WAIT UNTIL outXDir_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0100" & x"DEF"; -- x is equal, y is unequal to the location of the port

        WAIT UNTIL outYDir_ack_TB = '1'; -- it should therefore come out of the y-direction port

        inExternal_req_TB <= '0';

        WAIT UNTIL outYDir_ack_TB = '0';

        inInternal_Arbiter_A_req_TB <= '1';
        inInternal_Arbiter_A_dat_TB <= x"dead";
        inInternal_Arbiter_B_req_TB <= '1';
        inInternal_Arbiter_B_dat_TB <= x"beef";

        WAIT UNTIL inInternal_Arbiter_A_ack_TB = '1';

        inInternal_Arbiter_A_req_TB <= '0';
        inInternal_Arbiter_A_dat_TB <= x"0000";

        WAIT UNTIL inInternal_Arbiter_B_ack_TB = '1';

        inInternal_Arbiter_B_req_TB <= '0';
        inInternal_Arbiter_B_dat_TB <= x"0000";
        
        WAIT UNTIL inInternal_Arbiter_B_ack_TB = '0';

        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    diagonal_DUT : entity work.async_noc_io_port_diagonal
        GENERIC MAP (
            LOCATION_X            =>  1,
            LOCATION_Y            =>  1,
            ADDR_WIDTH            =>  2
        )
        PORT MAP (
            -- control
            reset                      =>  rst,
            -- from local
            rx_local_req_in            =>  inInternal_Arbiter_A_req_TB,
            rx_local_ack_out           =>  inInternal_Arbiter_A_ack_TB,
            rx_local_dat_in            =>  inInternal_Arbiter_A_dat_TB,
            -- from internal
            rx_internal_req_in         =>  inInternal_Arbiter_B_req_TB,
            rx_internal_ack_out        =>  inInternal_Arbiter_B_ack_TB,
            rx_internal_dat_in         =>  inInternal_Arbiter_B_dat_TB,
            -- from external
            rx_external_req_in         =>  inExternal_req_TB,
            rx_external_ack_out        =>  inExternal_ack_TB,
            rx_external_dat_in         =>  inExternal_dat_TB,
            -- to external
            tx_external_req_in         =>  outExternal_req_TB,
            tx_external_ack_out        =>  outExternal_ack_TB,
            tx_external_dat_in         =>  outExternal_dat_TB,
            -- to internal diagonal port
            tx_internal_diag_req_in    =>  outDiag_req_TB,
            tx_internal_diag_ack_out   =>  outDiag_ack_TB,
            tx_internal_diag_dat_in    =>  outDiag_dat_TB,
            -- to internal y-direction port
            tx_internal_ydir_req_in    =>  outYDir_req_TB,
            tx_internal_ydir_ack_out   =>  outYDir_ack_TB,
            tx_internal_ydir_dat_in    =>  outYDir_dat_TB,
            -- to internal x-direction port
            tx_internal_xdir_req_in    =>  outXDir_req_TB,
            tx_internal_xdir_ack_out   =>  outXDir_ack_TB,
            tx_internal_xdir_dat_in    =>  outXDir_dat_TB,
            -- to internal local
            tx_internal_local_req_in   =>  outLocal_req_TB,
            tx_internal_local_ack_out  =>  outLocal_ack_TB,
            tx_internal_local_dat_in   =>  outLocal_dat_TB
        );

END STRUCTURE;