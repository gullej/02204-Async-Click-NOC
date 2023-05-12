LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.ALL;
  USE IEEE.STD_LOGIC_UNSIGNED.ALL;
  use work.defs.all;

ENTITY async_noc_router_tb IS
END async_noc_router_tb;

ARCHITECTURE testbench OF async_noc_router_tb IS

SIGNAL rst  :  STD_LOGIC;

SIGNAL rx_req_in_dem_N_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_N_TB   : STD_LOGIC;
SIGNAL rx_dat_in_N_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_N_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_N_TB   : STD_LOGIC;
SIGNAL tx_dat_out_N_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_NE_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_NE_TB  : STD_LOGIC;
SIGNAL rx_dat_in_NE_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_NE_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_NE_TB  : STD_LOGIC;
SIGNAL tx_dat_out_NE_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_E_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_E_TB   : STD_LOGIC;
SIGNAL rx_dat_in_E_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_E_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_E_TB   : STD_LOGIC;
SIGNAL tx_dat_out_E_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_SE_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_SE_TB  : STD_LOGIC;
SIGNAL rx_dat_in_SE_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_SE_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_SE_TB  : STD_LOGIC;
SIGNAL tx_dat_out_SE_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_S_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_S_TB   : STD_LOGIC;
SIGNAL rx_dat_in_S_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_S_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_S_TB   : STD_LOGIC;
SIGNAL tx_dat_out_S_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_SW_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_SW_TB  : STD_LOGIC;
SIGNAL rx_dat_in_SW_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_SW_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_SW_TB  : STD_LOGIC;
SIGNAL tx_dat_out_SW_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_W_TB    : STD_LOGIC;
SIGNAL rx_ack_out_dem_W_TB   : STD_LOGIC;
SIGNAL rx_dat_in_W_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_W_TB    : STD_LOGIC;
SIGNAL tx_req_out_arb_W_TB   : STD_LOGIC;
SIGNAL tx_dat_out_W_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_req_in_dem_NW_TB   : STD_LOGIC;
SIGNAL rx_ack_out_dem_NW_TB  : STD_LOGIC;
SIGNAL rx_dat_in_NW_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_ack_in_arb_NW_TB   : STD_LOGIC;
SIGNAL tx_req_out_arb_NW_TB  : STD_LOGIC;
SIGNAL tx_dat_out_NW_TB      : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL tx_req_in_dem_L_TB    : STD_LOGIC;
SIGNAL tx_ack_out_dem_L_TB   : STD_LOGIC;
SIGNAL tx_dat_in_L_TB        : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
SIGNAL rx_ack_in_arb_L_TB    : STD_LOGIC;
SIGNAL rx_req_out_arb_L_TB   : STD_LOGIC;
SIGNAL rx_dat_out_L_TB       : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);

ATTRIBUTE dont_touch  :  STRING;
ATTRIBUTE dont_touch of rx_req_in_dem_N_TB  , rx_ack_out_dem_N_TB  : SIGNAL IS "true";   
ATTRIBUTE dont_touch of tx_ack_in_arb_N_TB  , tx_req_out_arb_N_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_NE_TB , rx_ack_out_dem_NE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_NE_TB , tx_req_out_arb_NE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_E_TB  , rx_ack_out_dem_E_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_E_TB  , tx_req_out_arb_E_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_SE_TB , rx_ack_out_dem_SE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_SE_TB , tx_req_out_arb_SE_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_S_TB  , rx_ack_out_dem_S_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_S_TB  , tx_req_out_arb_S_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_SW_TB , rx_ack_out_dem_SW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_SW_TB , tx_req_out_arb_SW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_W_TB  , rx_ack_out_dem_W_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_W_TB  , tx_req_out_arb_W_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_req_in_dem_NW_TB , rx_ack_out_dem_NW_TB : SIGNAL IS "true";  
ATTRIBUTE dont_touch of tx_ack_in_arb_NW_TB , tx_req_out_arb_NW_TB : SIGNAL IS "true"; 

ATTRIBUTE dont_touch of tx_req_in_dem_L_TB  , tx_ack_out_dem_L_TB  : SIGNAL IS "true";  
ATTRIBUTE dont_touch of rx_ack_in_arb_L_TB  , rx_req_out_arb_L_TB  : SIGNAL IS "true";   

BEGIN

    tx_ack_in_arb_N_TB  <= tx_req_out_arb_N_TB  after 10 ns;
    tx_ack_in_arb_NE_TB <= tx_req_out_arb_NE_TB after 10 ns;
    tx_ack_in_arb_E_TB  <= tx_req_out_arb_E_TB  after 10 ns;
    tx_ack_in_arb_SE_TB <= tx_req_out_arb_SE_TB after 10 ns;
    tx_ack_in_arb_S_TB  <= tx_req_out_arb_S_TB  after 10 ns;
    tx_ack_in_arb_SW_TB <= tx_req_out_arb_SW_TB after 10 ns;
    tx_ack_in_arb_W_TB  <= tx_req_out_arb_W_TB  after 10 ns;
    tx_ack_in_arb_NW_TB <= tx_req_out_arb_NW_TB after 10 ns;
    rx_ack_in_arb_L_TB  <= rx_req_out_arb_L_TB  after 10 ns;
     
    stim : PROCESS
    BEGIN
    rx_req_in_dem_N_TB  <= '0';
    rx_req_in_dem_NE_TB <= '0';
    rx_req_in_dem_E_TB  <= '0';
    rx_req_in_dem_SE_TB <= '0';
    rx_req_in_dem_S_TB  <= '0';
    rx_req_in_dem_SW_TB <= '0';
    rx_req_in_dem_W_TB  <= '0';
    rx_req_in_dem_NW_TB <= '0';
    tx_req_in_dem_L_TB  <= '0';
    rx_dat_in_N_TB      <= (others => '0');  
    rx_dat_in_NE_TB     <= (others => '0');  
    rx_dat_in_E_TB      <= (others => '0');  
    rx_dat_in_SE_TB     <= (others => '0');  
    rx_dat_in_S_TB      <= (others => '0');  
    rx_dat_in_SW_TB     <= (others => '0');  
    rx_dat_in_W_TB      <= (others => '0');  
    rx_dat_in_NW_TB     <= (others => '0');  
    tx_dat_in_L_TB      <= (others => '0');  
    rst <= '1';
    WAIT FOR 100 ns;
    rst <= '0';
    WAIT FOR 100 ns;

    -- from north

    rx_req_in_dem_N_TB  <= '1';
    rx_dat_in_N_TB      <= "01" & "00" & x"123"; -- to south

    WAIT UNTIL rx_ack_out_dem_N_TB = '1';

    rx_req_in_dem_N_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_N_TB = '0';

    rx_req_in_dem_N_TB  <= '1';
    rx_dat_in_N_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_N_TB = '1';

    rx_req_in_dem_N_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_N_TB = '0';

    -- from east

    rx_req_in_dem_E_TB  <= '1';
    rx_dat_in_E_TB      <= "01" & "00" & x"123"; -- to west

    WAIT UNTIL rx_ack_out_dem_E_TB = '1';

    rx_req_in_dem_E_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_E_TB = '0';

    rx_req_in_dem_E_TB  <= '1';
    rx_dat_in_E_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_E_TB = '1';

    rx_req_in_dem_E_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_E_TB = '0';

    -- from south

    rx_req_in_dem_S_TB  <= '1';
    rx_dat_in_S_TB      <= "10" & "01" & x"123"; -- to north

    WAIT UNTIL rx_ack_out_dem_S_TB = '1';

    rx_req_in_dem_S_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_S_TB = '0';

    rx_req_in_dem_S_TB  <= '1';
    rx_dat_in_S_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_S_TB = '1';

    rx_req_in_dem_S_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_S_TB = '0';

    -- from west

    rx_req_in_dem_W_TB  <= '1';
    rx_dat_in_W_TB      <= "10" & "01" & x"123"; -- to east

    WAIT UNTIL rx_ack_out_dem_W_TB = '1';

    rx_req_in_dem_W_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_W_TB = '0';

    rx_req_in_dem_W_TB  <= '1';
    rx_dat_in_W_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_W_TB = '1';

    rx_req_in_dem_W_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_W_TB = '0';

    -- from north east

    rx_req_in_dem_NE_TB  <= '1';
    rx_dat_in_NE_TB      <= "01" & "00" & x"123"; -- to south

    WAIT UNTIL rx_ack_out_dem_NE_TB = '1';

    rx_req_in_dem_NE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NE_TB = '0';

    rx_req_in_dem_NE_TB  <= '1';
    rx_dat_in_NE_TB      <= "00" & "00" & x"123"; -- to south west

    WAIT UNTIL rx_ack_out_dem_NE_TB = '1';

    rx_req_in_dem_NE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NE_TB = '0';

    rx_req_in_dem_NE_TB  <= '1';
    rx_dat_in_NE_TB      <= "00" & "01" & x"123"; -- to west

    WAIT UNTIL rx_ack_out_dem_NE_TB = '1';

    rx_req_in_dem_NE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NE_TB = '0';

    rx_req_in_dem_NE_TB  <= '1';
    rx_dat_in_NE_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_NE_TB = '1';

    rx_req_in_dem_NE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NE_TB = '0';

    -- from south east

    rx_req_in_dem_SE_TB  <= '1';
    rx_dat_in_SE_TB      <= "00" & "01" & x"123"; -- to west

    WAIT UNTIL rx_ack_out_dem_SE_TB = '1';

    rx_req_in_dem_SE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SE_TB = '0';

    rx_req_in_dem_SE_TB  <= '1';
    rx_dat_in_SE_TB      <= "00" & "10" & x"123"; -- to north west

    WAIT UNTIL rx_ack_out_dem_SE_TB = '1';

    rx_req_in_dem_SE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SE_TB = '0';

    rx_req_in_dem_SE_TB  <= '1';
    rx_dat_in_SE_TB      <= "01" & "10" & x"123"; -- to north

    WAIT UNTIL rx_ack_out_dem_SE_TB = '1';

    rx_req_in_dem_SE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SE_TB = '0';

    rx_req_in_dem_SE_TB  <= '1';
    rx_dat_in_SE_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_SE_TB = '1';

    rx_req_in_dem_SE_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SE_TB = '0';

    -- from south west

    rx_req_in_dem_SW_TB  <= '1';
    rx_dat_in_SW_TB      <= "01" & "10" & x"123"; -- to north

    WAIT UNTIL rx_ack_out_dem_SW_TB = '1';

    rx_req_in_dem_SW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SW_TB = '0';

    rx_req_in_dem_SW_TB  <= '1';
    rx_dat_in_SW_TB      <= "10" & "10" & x"123"; -- to north east

    WAIT UNTIL rx_ack_out_dem_SW_TB = '1';

    rx_req_in_dem_SW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SW_TB = '0';

    rx_req_in_dem_SW_TB  <= '1';
    rx_dat_in_SW_TB      <= "10" & "01" & x"123"; -- to east

    WAIT UNTIL rx_ack_out_dem_SW_TB = '1';

    rx_req_in_dem_SW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SW_TB = '0';

    rx_req_in_dem_SW_TB  <= '1';
    rx_dat_in_SW_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_SW_TB = '1';

    rx_req_in_dem_SW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_SW_TB = '0';

    -- from north west

    rx_req_in_dem_NW_TB  <= '1';
    rx_dat_in_NW_TB      <= "10" & "01" & x"123"; -- to east

    WAIT UNTIL rx_ack_out_dem_NW_TB = '1';

    rx_req_in_dem_NW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NW_TB = '0';

    rx_req_in_dem_NW_TB  <= '1';
    rx_dat_in_NW_TB      <= "10" & "00" & x"123"; -- to south east

    WAIT UNTIL rx_ack_out_dem_NW_TB = '1';

    rx_req_in_dem_NW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NW_TB = '0';

    rx_req_in_dem_NW_TB  <= '1';
    rx_dat_in_NW_TB      <= "01" & "00" & x"123"; -- to south

    WAIT UNTIL rx_ack_out_dem_NW_TB = '1';

    rx_req_in_dem_NW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NW_TB = '0';

    rx_req_in_dem_NW_TB  <= '1';
    rx_dat_in_NW_TB      <= "01" & "01" & x"123"; -- to local

    WAIT UNTIL rx_ack_out_dem_NW_TB = '1';

    rx_req_in_dem_NW_TB  <= '0';

    WAIT UNTIL rx_ack_out_dem_NW_TB = '0';

    -- from local
    
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "01" & "10" & x"123"; -- to north

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "10" & "10" & x"123"; -- to north east

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "10" & "01" & x"123"; -- to east

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "10" & "00" & x"123"; -- to south east

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "01" & "00" & x"123"; -- to south

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "00" & "00" & x"123"; -- to south west

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "00" & "01" & x"123"; -- to west

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';
        
    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "00" & "10" & x"123"; -- to north west

    WAIT UNTIL tx_ack_out_dem_L_TB = '1';

    tx_req_in_dem_L_TB   <= '0';

    WAIT UNTIL tx_ack_out_dem_L_TB = '0';

    -- from all at once

    rx_req_in_dem_N_TB  <= '1';
    rx_dat_in_N_TB      <= "01" & "00" & x"111"; -- north to south

    rx_req_in_dem_NE_TB  <= '1';
    rx_dat_in_NE_TB      <= "01" & "01" & x"222"; -- north east to local

    rx_req_in_dem_E_TB  <= '1';
    rx_dat_in_E_TB      <= "01" & "01" & x"333"; -- east to local

    rx_req_in_dem_SE_TB  <= '1';
    rx_dat_in_SE_TB      <= "00" & "01" & x"444"; -- south east to west

    rx_req_in_dem_S_TB  <= '1';
    rx_dat_in_S_TB      <= "01" & "01" & x"555"; -- south to local

    rx_req_in_dem_SW_TB  <= '1';
    rx_dat_in_SW_TB      <= "10" & "01" & x"666"; -- south west to east

    rx_req_in_dem_W_TB  <= '1';
    rx_dat_in_W_TB      <= "10" & "01" & x"777"; -- west to east

    rx_req_in_dem_NW_TB  <= '1';
    rx_dat_in_NW_TB      <= "10" & "00" & x"888"; -- north west to south east

    tx_req_in_dem_L_TB   <= '1';
    tx_dat_in_L_TB       <= "00" & "01" & x"999"; -- local to west

    WAIT FOR 100 ns;

    rx_req_in_dem_N_TB   <= '0';
    rx_req_in_dem_NE_TB  <= '0';
    rx_req_in_dem_SE_TB  <= '0';
    rx_req_in_dem_W_TB   <= '0';
    rx_req_in_dem_NW_TB  <= '0';

    WAIT FOR 100 ns;


    rx_req_in_dem_S_TB   <= '0';
    rx_req_in_dem_SW_TB  <= '0';
    tx_req_in_dem_L_TB   <= '0';

    WAIT FOR 100 ns;

    rx_req_in_dem_E_TB   <= '0';

    WAIT FOR 50 ns;
    ASSERT 0 = 1 REPORT "Test ended" SEVERITY failure;
    END PROCESS;

    router_DUT : entity work.async_noc_router
    GENERIC MAP (
        LOCATION_X               =>  1,
        LOCATION_Y               =>  1,
        ADDR_WIDTH               =>  2
    )
    PORT MAP (
        -- control
        reset => rst,
        -- north direction
        rx_req_in_dem_N   => rx_req_in_dem_N_TB,
        rx_ack_out_dem_N  => rx_ack_out_dem_N_TB,
        rx_dat_in_N       => rx_dat_in_N_TB,
        tx_ack_in_arb_N   => tx_ack_in_arb_N_TB,
        tx_req_out_arb_N  => tx_req_out_arb_N_TB,
        tx_dat_out_N      => tx_dat_out_N_TB,
        -- north east direction
        rx_req_in_dem_NE  => rx_req_in_dem_NE_TB,
        rx_ack_out_dem_NE => rx_ack_out_dem_NE_TB,
        rx_dat_in_NE      => rx_dat_in_NE_TB,
        tx_ack_in_arb_NE  => tx_ack_in_arb_NE_TB,
        tx_req_out_arb_NE => tx_req_out_arb_NE_TB,
        tx_dat_out_NE     => tx_dat_out_NE_TB,
        -- east direction
        rx_req_in_dem_E   => rx_req_in_dem_E_TB,
        rx_ack_out_dem_E  => rx_ack_out_dem_E_TB,
        rx_dat_in_E       => rx_dat_in_E_TB,
        tx_ack_in_arb_E   => tx_ack_in_arb_E_TB,
        tx_req_out_arb_E  => tx_req_out_arb_E_TB,
        tx_dat_out_E      => tx_dat_out_E_TB,
        -- south east direction
        rx_req_in_dem_SE  => rx_req_in_dem_SE_TB,
        rx_ack_out_dem_SE => rx_ack_out_dem_SE_TB,
        rx_dat_in_SE      => rx_dat_in_SE_TB,
        tx_ack_in_arb_SE  => tx_ack_in_arb_SE_TB,
        tx_req_out_arb_SE => tx_req_out_arb_SE_TB,
        tx_dat_out_SE     => tx_dat_out_SE_TB,
        -- south direction
        rx_req_in_dem_S   => rx_req_in_dem_S_TB,
        rx_ack_out_dem_S  => rx_ack_out_dem_S_TB,
        rx_dat_in_S       => rx_dat_in_S_TB,
        tx_ack_in_arb_S   => tx_ack_in_arb_S_TB,
        tx_req_out_arb_S  => tx_req_out_arb_S_TB,
        tx_dat_out_S      => tx_dat_out_S_TB,
        -- south west direction
        rx_req_in_dem_SW  => rx_req_in_dem_SW_TB,
        rx_ack_out_dem_SW => rx_ack_out_dem_SW_TB,
        rx_dat_in_SW      => rx_dat_in_SW_TB,
        tx_ack_in_arb_SW  => tx_ack_in_arb_SW_TB,
        tx_req_out_arb_SW => tx_req_out_arb_SW_TB,
        tx_dat_out_SW     => tx_dat_out_SW_TB,
        -- west direction
        rx_req_in_dem_W   => rx_req_in_dem_W_TB,
        rx_ack_out_dem_W  => rx_ack_out_dem_W_TB,
        rx_dat_in_W       => rx_dat_in_W_TB,
        tx_ack_in_arb_W   => tx_ack_in_arb_W_TB,
        tx_req_out_arb_W  => tx_req_out_arb_W_TB,
        tx_dat_out_W      => tx_dat_out_W_TB,
        -- north west direction
        rx_req_in_dem_NW  => rx_req_in_dem_NW_TB,
        rx_ack_out_dem_NW => rx_ack_out_dem_NW_TB,
        rx_dat_in_NW      => rx_dat_in_NW_TB,
        tx_ack_in_arb_NW  => tx_ack_in_arb_NW_TB,
        tx_req_out_arb_NW => tx_req_out_arb_NW_TB,
        tx_dat_out_NW     => tx_dat_out_NW_TB,
        -- local direction
        tx_req_in_dem_L   => tx_req_in_dem_L_TB,
        tx_ack_out_dem_L  => tx_ack_out_dem_L_TB,
        tx_dat_in_L       => tx_dat_in_L_TB,
        rx_ack_in_arb_L   => rx_ack_in_arb_L_TB,
        rx_req_out_arb_L  => rx_req_out_arb_L_TB,
        rx_dat_out_L      => rx_dat_out_L_TB       
    );

END ARCHITECTURE;