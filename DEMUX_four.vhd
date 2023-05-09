----------------------------------------------------------------------------------
-- DEMUX_four
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.defs.ALL;

ENTITY DEMUX_four IS
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

        -- Output channel 1, chosen by ctrl_data_in_sel(0)
        tx_req_out_B  : OUT STD_LOGIC;
        tx_data_out_B : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_ack_in_B   : IN  STD_LOGIC;

        -- Output channel 2, chosen by ctrl_data_in_sel(1)
        tx_req_out_C  : OUT STD_LOGIC;
        tx_data_out_C : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_ack_in_C   : IN  STD_LOGIC;

        -- Output channel 3, chosen by ctrl_data_in_sel(2)
        tx_req_out_D  : OUT STD_LOGIC;
        tx_data_out_D : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_ack_in_D   : IN  STD_LOGIC;

        -- Output channel 4, chosen by ctrl_data_in_sel(3)
        tx_req_out_E  : OUT STD_LOGIC;
        tx_data_out_E : OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 DOWNTO 0);
        tx_ack_in_E   : IN  STD_LOGIC
    );
END DEMUX_four;

ARCHITECTURE Behavioral OF DEMUX_four IS

    SIGNAL phase_a : STD_LOGIC;
    SIGNAL click_req, click_ack : STD_LOGIC;

    SIGNAL phase_b : STD_LOGIC;
    SIGNAL phase_c : STD_LOGIC;
    SIGNAL phase_d : STD_LOGIC;
    SIGNAL phase_e : STD_LOGIC;

BEGIN

    -- Control Path   
    ctrl_ack_out_sel <= phase_a;
    rx_ack_out_A <= phase_a;
    tx_req_out_B <= phase_b;
    tx_data_out_B <= rx_data_in_A;
    tx_req_out_C <= phase_c;
    tx_data_out_C <= rx_data_in_A;
    tx_req_out_D <= phase_d;
    tx_data_out_D <= rx_data_in_A;
    tx_req_out_E <= phase_e;
    tx_data_out_E <= rx_data_in_A;

    -- Request FF clock function
    click_req <= (ctrl_req_in_sel AND NOT(phase_a) AND rx_req_in_A) OR (NOT(ctrl_req_in_sel) AND phase_a AND NOT(rx_req_in_A)) AFTER ANDOR3_DELAY + NOT1_DELAY;

    -- Acknowledge FF clock function
    click_ack <= (tx_ack_in_B XNOR phase_b) AND (tx_ack_in_C XNOR phase_c) AND (tx_ack_in_D XNOR phase_d) AND (tx_ack_in_E XNOR phase_e) AFTER AND2_DELAY + AND2_DELAY + XOR_DELAY + NOT1_DELAY;
    req : PROCESS (click_req, rst)
    BEGIN
        IF rst = '1' THEN
            phase_b <= PHASE_INIT_B;
            phase_c <= PHASE_INIT_C;
            phase_d <= PHASE_INIT_D;
            phase_e <= PHASE_INIT_E;
        ELSIF rising_edge(click_req) THEN
            phase_b <= phase_b XOR ctrl_data_in_sel(0) AFTER REG_CQ_DELAY;
            phase_c <= phase_c XOR ctrl_data_in_sel(1) AFTER REG_CQ_DELAY;
            phase_d <= phase_d XOR ctrl_data_in_sel(2) AFTER REG_CQ_DELAY;
            phase_e <= phase_e XOR ctrl_data_in_sel(3) AFTER REG_CQ_DELAY;
        END IF;
    END PROCESS req;

    ack : PROCESS (click_ack, rst)
    BEGIN
        IF rst = '1' THEN
            phase_a <= PHASE_INIT_A;
        ELSIF rising_edge(click_ack) THEN
            phase_a <= NOT phase_a AFTER REG_CQ_DELAY;
        END IF;
    END PROCESS ack;

END Behavioral;