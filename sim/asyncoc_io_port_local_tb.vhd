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
    SIGNAL inExternal_req_TB,  inExternal_ack_TB  :  STD_LOGIC;
    SIGNAL inExternal_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inNW_req_TB,  inNW_ack_TB  :  STD_LOGIC;
    SIGNAL inNW_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inW_req_TB,   inW_ack_TB   :  STD_LOGIC;
    SIGNAL inW_dat_TB    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inSW_req_TB,  inSW_ack_TB  :  STD_LOGIC;
    SIGNAL inSW_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inS_req_TB,   inS_ack_TB   : STD_LOGIC;
    SIGNAL inS_dat_TB    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inSE_req_TB,  inSE_ack_TB  : STD_LOGIC;
    SIGNAL inSE_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inE_req_TB,   inE_ack_TB   : STD_LOGIC;
    SIGNAL inE_dat_TB    :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inNE_req_TB,  inNE_ack_TB  : STD_LOGIC;
    SIGNAL inNE_dat_TB   :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inN_req_TB,   inN_ack_TB   : STD_LOGIC;
    SIGNAL inN_dat_TB    : STD_LOGIC_VECTOR(15 DOWNTO 0);

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
    
    SIGNAL arbiter_inH_req_TB        :  STD_LOGIC;
    SIGNAL arbiter_inH_ack_TB        :  STD_LOGIC;
    SIGNAL arbiter_inH_data_TB       :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL arbiter_outA_req_TB       :  STD_LOGIC;
    SIGNAL arbiter_outA_ack_TB       :  STD_LOGIC;
    SIGNAL arbiter_outA_data_TB      :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    
    ATTRIBUTE dont_touch : STRING;
    ATTRIBUTE dont_touch OF inExternal_req_TB, inExternal_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inNW_req_TB, inNW_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inW_req_TB,  inW_ack_TB  : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inSW_req_TB, inSW_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inS_req_TB,  inS_ack_TB  : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inSE_req_TB, inSE_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inE_req_TB,  inE_ack_TB  : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inNE_req_TB, inNE_ack_TB : SIGNAL IS "true";
    ATTRIBUTE dont_touch OF inN_req_TB,  inN_ack_TB  : SIGNAL IS "true";

    ATTRIBUTE dont_touch of arbiter_inA_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inA_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inB_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inC_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inC_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inD_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inD_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inE_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inE_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inF_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inF_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inG_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inG_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inH_req_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_inH_ack_TB       :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_req_TB      :  SIGNAL IS "true";
    ATTRIBUTE dont_touch of arbiter_outA_ack_TB      :  SIGNAL IS "true";

BEGIN
 
    inN_ack_TB  <= inN_req_TB  AFTER 10 ns;
    inNE_ack_TB <= inNE_req_TB AFTER 10 ns;
    inE_ack_TB  <= inE_req_TB  AFTER 10 ns;
    inSE_ack_TB <= inSE_req_TB AFTER 10 ns;
    inS_ack_TB  <= inS_req_TB  AFTER 10 ns;
    inSW_ack_TB <= inSW_req_TB AFTER 10 ns;
    inW_ack_TB  <= inW_req_TB  AFTER 10 ns;
    inNW_ack_TB <= inNW_req_TB AFTER 10 ns;

    stim : PROCESS
    BEGIN
        inExternal_req_TB <= '0';
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

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0110" & x"9AB"; -- equal more, should go north

        WAIT UNTIL inN_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inN_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "1010" & x"9AB"; -- more more, should go north east

        WAIT UNTIL inNE_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inNE_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "1001" & x"9AB"; -- more equal, should go east

        WAIT UNTIL inE_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inE_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "1000" & x"9AB"; -- more less, should go south east

        WAIT UNTIL inSE_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inSE_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0100" & x"9AB"; -- equal less, should go south

        WAIT UNTIL inS_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inS_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0000" & x"123"; -- less less, should go south west

        WAIT UNTIL inSW_ack_TB = '1';

        inExternal_req_TB <= '0';
        
        WAIT UNTIL inSW_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0001" & x"567"; -- less equal, should go west 

        WAIT UNTIL inW_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inW_ack_TB = '0';

        inExternal_req_TB <= '1';
        inExternal_dat_TB <= "0010" & x"DEF"; -- less more, should go north west

        WAIT UNTIL inNW_ack_TB = '1';

        inExternal_req_TB <= '0';

        WAIT UNTIL inNW_ack_TB = '0';

        ASSERT 0 = 1 REPORT "Bye" SEVERITY failure;
    END PROCESS;

    local_DUT : entity work.async_noc_io_port_local
    GENERIC MAP (
        LOCATION_X               =>  1,
        LOCATION_Y               =>  1,
        ADDR_WIDTH               =>  2
    )
    PORT MAP (
        -- control
        reset                            =>  rst,
        -- from internal a        
        rx_internal_a_req_in             =>  arbiter_inA_req_TB ,
        rx_internal_a_ack_out            =>  arbiter_inA_ack_TB ,
        rx_internal_a_dat_in             =>  arbiter_inA_data_TB,
        -- from internal b        
        rx_internal_b_req_in             =>  arbiter_inB_req_TB ,
        rx_internal_b_ack_out            =>  arbiter_inB_ack_TB ,
        rx_internal_b_dat_in             =>  arbiter_inB_data_TB,
        -- from internal c        
        rx_internal_c_req_in             =>  arbiter_inC_req_TB ,
        rx_internal_c_dat_in             =>  arbiter_inC_data_TB,
        rx_internal_c_ack_out            =>  arbiter_inC_ack_TB,
        -- from internal d        
        rx_internal_d_req_in             =>  arbiter_inD_req_TB ,
        rx_internal_d_dat_in             =>  arbiter_inD_data_TB ,
        rx_internal_d_ack_out            =>  arbiter_inD_ack_TB,
        -- from internal e        
        rx_internal_e_req_in             =>  arbiter_inE_req_TB ,
        rx_internal_e_dat_in             =>  arbiter_inE_data_TB ,
        rx_internal_e_ack_out            =>  arbiter_inE_ack_TB,
        -- from internal f        
        rx_internal_f_req_in             =>  arbiter_inF_req_TB ,
        rx_internal_f_dat_in             =>  arbiter_inF_data_TB ,
        rx_internal_f_ack_out            =>  arbiter_inF_ack_TB,
        -- from internal h        
        rx_internal_g_req_in             =>  arbiter_inG_req_TB ,
        rx_internal_g_dat_in             =>  arbiter_inG_data_TB ,
        rx_internal_g_ack_out            =>  arbiter_inG_ack_TB,
        -- from internal g        
        rx_internal_h_req_in             =>  arbiter_inH_req_TB ,
        rx_internal_h_dat_in             =>  arbiter_inH_data_TB ,
        rx_internal_h_ack_out            =>  arbiter_inH_ack_TB,
        -- from external        
        rx_external_req_in               =>  inExternal_req_TB,
        rx_external_ack_out              =>  inExternal_ack_TB,
        rx_external_dat_in               =>  inExternal_dat_TB,
        -- to external        
        tx_external_req_in               =>  arbiter_outA_req_TB ,
        tx_external_ack_out              =>  arbiter_outA_ack_TB ,
        tx_external_dat_in               =>  arbiter_outA_data_TB,
        -- to internal north west
        tx_internal_north_west_req_in    =>  inNW_req_TB,
        tx_internal_north_west_dat_in    =>  inNW_dat_TB,
        tx_internal_north_west_ack_out   =>  inNW_ack_TB,
        -- to internal west  
        tx_internal_west_req_in          =>  inW_req_TB,
        tx_internal_west_dat_in          =>  inW_dat_TB,
        tx_internal_west_ack_out         =>  inW_ack_TB,
        -- to internal south west
        tx_internal_south_west_req_in    =>  inSW_req_TB,
        tx_internal_south_west_dat_in    =>  inSW_dat_TB,
        tx_internal_south_west_ack_out   =>  inSW_ack_TB,
        -- to internal south
        tx_internal_south_req_in         =>  inS_req_TB,
        tx_internal_south_dat_in         =>  inS_dat_TB,
        tx_internal_south_ack_out        =>  inS_ack_TB,
        -- to internal south east
        tx_internal_south_east_req_in    =>  inSE_req_TB,
        tx_internal_south_east_dat_in    =>  inSE_dat_TB,
        tx_internal_south_east_ack_out   =>  inSE_ack_TB,
        -- to internal east
        tx_internal_east_req_in          =>  inE_req_TB,
        tx_internal_east_dat_in          =>  inE_dat_TB,
        tx_internal_east_ack_out         =>  inE_ack_TB,
        -- to internal north east 
        tx_internal_north_east_req_in    =>  inNE_req_TB,
        tx_internal_north_east_dat_in    =>  inNE_dat_TB,
        tx_internal_north_east_ack_out   =>  inNE_ack_TB,
        -- to internal north
        tx_internal_north_req_in         =>  inN_req_TB,
        tx_internal_north_dat_in         =>  inN_dat_TB,
        tx_internal_north_ack_out        =>  inN_ack_TB
    );

    END STRUCTURE;