LIBRARY IEEE;
  USE IEEE.STD_LOGIC_1164.ALL;
  USE IEEE.NUMERIC_STD.ALL;
  USE IEEE.STD_LOGIC_UNSIGNED.ALL;
  use work.defs.all;

LIBRARY OSVVM;
  USE OSVVM.RANDOMPKG.ALL;
  USE OSVVM.COVERAGEPKG.ALL;

ENTITY async_noc_router_tb IS
    generic (
        DATA_WIDTH : integer := 8
    );
END async_noc_router_tb;

ARCHITECTURE testbench OF async_noc_router_tb IS

SHARED VARIABLE rnd : RandomPType;

SIGNAL rst  :  STD_LOGIC;

SIGNAL src_ack_in   :  STD_LOGIC;
SIGNAL src_req_out  :  STD_LOGIC;
SIGNAL src_data     :  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);

SIGNAL snk_ack_out  :  STD_LOGIC;
SIGNAL snk_req_in   :  STD_LOGIC;
SIGNAL snk_data     :  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)

SIGNAL    phase_src   :  STD_LOGIC;
ATTRIBUTE DONT_TOUCH  :  STRING;
ATTRIBUTE DONT_TOUCH OF  phase_src  : SIGNAL IS "TRUE";   
ATTRIBUTE DONT_TOUCH OF  src_data   : SIGNAL IS "TRUE";  
ATTRIBUTE DONT_TOUCH OF  phase_src  : SIGNAL IS "TRUE";

SIGNAL phase_snk      :  STD_LOGIC;
ATTRIBUTE DONT_TOUCH  :  STRING;
ATTRIBUTE DONT_TOUCH OF  phase_snk  : SIGNAL IS "TRUE";
ATTRIBUTE DONT_TOUCH OF  snk_data   : SIGNAL IS "TRUE";
ATTRIBUTE DONT_TOUCH OF  phase_snk  : SIGNAL IS "TRUE";

BEGIN

    rst  <= '1','0' after 100 ns;

    --phase_src    <=  (out_ack XNOR phase_src) AFTER XOR_DELAY;
    --src_req_out  <= phase_src;
--
    --SOURCE : PROCESS(click_src,rst) IS
    --    BEGIN
    --        IF rst = '1' THEN
    --            phase_src  <=  '0';
    --            src_data   <=  (OTHERS => '0');
    --        ELSIF RISING_EDGE(phase_src) THEN
    --            phase_src  <=  rnd.RandSlv(1)(1) AFTER REG_CQ_DELAY;
    --            src_data   <=  rnd.RandSlv(DATA_WIDTH) AFTER REG_CQ_DELAY; 
    --        END IF;
    --END PROCESS;
--
    --SINK : PROCESS(click_snk,rst) IS
    --    BEGIN
    --        IF rst = '1' THEN
    --            phase_snk  <=  '0';
    --            snk_data   <=  (OTHERS => '0');
    --        ELSIF RISING_EDGE(click_snk) THEN
    --            phase_snk  <=  rnd.RandSlv(1)(1) AFTER REG_CQ_DELAY;
    --            snk_data   <=  rnd.RandSlv(DATA_WIDTH) AFTER REG_CQ_DELAY; 
    --        END IF;
    --END PROCESS;

    --ROUTER_UT : ENTITY work.async_noc_router
    --    generic map (
    --        DATA_WIDTH => 8
    --    )
    --    port map (
    --            -- control
    --        reset            => ,
    --        start            => ,
    --        -- north direction
    --        rx_req_in_dem_N  => ,
    --        rx_ack_out_dem_N => ,
    --        rx_dat_in_N      => ,
    --        tx_ack_in_arb_N  => ,
    --        tx_req_out_arb_N => ,
    --        tx_dat_out_N     => ,
    --        -- north east direction
    --        rx_req_in_dem_NE => ,
    --        rx_ack_out_dem_NE=> ,
    --        rx_dat_in_NE     => ,
    --        tx_ack_in_arb_NE => ,
    --        tx_req_out_arb_NE=> ,
    --        tx_dat_out_NE    => ,
    --        -- east direction
    --        rx_req_in_dem_E  => ,
    --        rx_ack_out_dem_E => ,
    --        rx_dat_in_E      => ,
    --        tx_ack_in_arb_E  => ,
    --        tx_req_out_arb_E => ,
    --        tx_dat_out_E     => ,
    --        -- south east direction
    --        rx_req_in_dem_SE => ,
    --        rx_ack_out_dem_SE=> ,
    --        rx_dat_in_SE     => ,
    --        tx_ack_in_arb_SE => ,
    --        tx_req_out_arb_SE=> ,
    --        tx_dat_out_SE    => ,
    --        -- south direction
    --        rx_req_in_dem_S  => ,
    --        rx_ack_out_dem_S => ,
    --        rx_dat_in_S      => ,
    --        tx_ack_in_arb_S :=> ,
    --        tx_req_out_arb_S => ,
    --        tx_dat_out_S : OU=> ,
    --        -- south west direction
    --        rx_req_in_dem_SW => ,
    --        rx_ack_out_dem_SW=> ,
    --        rx_dat_in_SW     => ,
    --        tx_ack_in_arb_SW => ,
    --        tx_req_out_arb_SW=> ,
    --        tx_dat_out_SW    => ,
    --        -- west direction
    --        rx_req_in_dem_W  => ,
    --        rx_ack_out_dem_W => ,
    --        rx_dat_in_W      => ,
    --        tx_ack_in_arb_W  => ,
    --        tx_req_out_arb_W => ,
    --        tx_dat_out_W     => ,
    --        -- north west direction
    --        rx_req_in_dem_NW => ,
    --        rx_ack_out_dem_NW=> ,
    --        rx_dat_in_NW     => ,
    --        tx_ack_in_arb_NW => ,
    --        tx_req_out_arb_NW=> ,
    --        tx_dat_out_NW    => ,
    --        -- local direction
    --        tx_req_in_dem_L  => ,
    --        tx_ack_out_dem_L => ,
    --        tx_dat_in_L      => ,
    --        rx_ack_in_arb_L  => ,
    --        rx_req_out_arb_L => ,
    --        rx_dat_out_L     => 
    --    );

END ARCHITECTURE;