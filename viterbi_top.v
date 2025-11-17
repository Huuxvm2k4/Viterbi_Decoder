module viterbi_decoder_top (
    // --- Cổng Global ---
    input             clk,
    input             rst_n,
    input             en,       
    input       [1:0] d_in,    
    output            d_out,    // Dữ liệu đã giải mã 
    output            d_valid
);

    wire              we;       // Cho phép ghi (cho PMSM và TBPM)
    wire              te;       // Cho phép TB
    wire              oe;       // Cho phép xuất output

    wire        [3:0] wr_cnt;   
    wire        [3:0] tb_cnt;   

    wire        [1:0] bmc00_path_0;
    wire        [1:0] bmc00_path_1;
    wire        [1:0] bmc01_path_0;
    wire        [1:0] bmc01_path_1;
    wire        [1:0] bmc10_path_0;
    wire        [1:0] bmc10_path_1;
    wire        [1:0] bmc11_path_0;
    wire        [1:0] bmc11_path_1;

    wire        [3:0] ACS00_path_cost;
    wire        [3:0] ACS01_path_cost;
    wire        [3:0] ACS10_path_cost;
    wire        [3:0] ACS11_path_cost;

    wire        [3:0] n_ACS00_path_cost;
    wire        [3:0] n_ACS01_path_cost;
    wire        [3:0] n_ACS10_path_cost;
    wire        [3:0] n_ACS11_path_cost;

    wire        ACS00_selection;
    wire        ACS01_selection;
    wire        ACS10_selection;
    wire        ACS11_selection;

    wire        [7:0] ACS00_selection_o;
    wire        [7:0] ACS01_selection_o;
    wire        [7:0] ACS10_selection_o;
    wire        [7:0] ACS11_selection_o;

 
    control_unit u_control (
        .clk        (clk),
        .rst_n      (rst_n),    
        .en         (en),  
        .wr_cnt     (wr_cnt),   
        .tb_cnt     (tb_cnt),     
        .we         (we),       
        .te         (te),        
        .oe         (oe)         
    );

    BMU u_bmu (
       .d_in          (d_in),         
       .bmc00_path_0  (bmc00_path_0),     
       .bmc00_path_1  (bmc00_path_1),     
       .bmc01_path_0  (bmc01_path_0),     
       .bmc01_path_1  (bmc01_path_1),     
       .bmc10_path_0  (bmc10_path_0),     
       .bmc10_path_1  (bmc10_path_1),     
       .bmc11_path_0  (bmc11_path_0),     
       .bmc11_path_1  (bmc11_path_1)      
    );

    ACSU u_acsu (
        .bmc00_path_0     (bmc00_path_0),
        .bmc00_path_1     (bmc00_path_1),
        .bmc01_path_0     (bmc01_path_0),
        .bmc01_path_1     (bmc01_path_1),
        .bmc10_path_0     (bmc10_path_0),
        .bmc10_path_1     (bmc10_path_1),
        .bmc11_path_0     (bmc11_path_0),
        .bmc11_path_1     (bmc11_path_1),
        .n_ACS00_path_cost(n_ACS00_path_cost),
        .n_ACS01_path_cost(n_ACS01_path_cost),
        .n_ACS10_path_cost(n_ACS10_path_cost),
        .n_ACS11_path_cost(n_ACS11_path_cost),
        .ACS00_path_cost  (ACS00_path_cost),
        .ACS01_path_cost  (ACS01_path_cost),
        .ACS10_path_cost  (ACS10_path_cost),
        .ACS11_path_cost  (ACS11_path_cost),
        .ACS00_selection  (ACS00_selection),
        .ACS01_selection  (ACS01_selection),
        .ACS10_selection  (ACS10_selection),
        .ACS11_selection  (ACS11_selection)
    );

    PMSM u_pmsm (
        .clk              (clk),
        .rst_n            (rst_n),         
        .we               (we),            
        .ACS00_path_cost  (ACS00_path_cost),
        .ACS01_path_cost  (ACS01_path_cost),
        .ACS10_path_cost  (ACS10_path_cost),
        .ACS11_path_cost  (ACS11_path_cost),
        .n_ACS00_path_cost(n_ACS00_path_cost),
        .n_ACS01_path_cost(n_ACS01_path_cost),
        .n_ACS10_path_cost(n_ACS10_path_cost),
        .n_ACS11_path_cost(n_ACS11_path_cost)
    );

    TBPM u_tbpm (
        .clk              (clk),
        .rst_n            (rst_n),
        .we               (we),     
        .ACS00_selection  (ACS00_selection),
        .ACS01_selection  (ACS01_selection),
        .ACS10_selection  (ACS10_selection),
        .ACS11_selection  (ACS11_selection),
        .ACS00_selection_o(ACS00_selection_o),
        .ACS01_selection_o(ACS01_selection_o),
        .ACS10_selection_o(ACS10_selection_o),
        .ACS11_selection_o(ACS11_selection_o),
        .wr_cnt           (wr_cnt)
    );

    TB u_tb (
        .clk(clk),
        .rst_n(rst_n),
        .ACS00_selection_o(ACS00_selection_o),
        .ACS01_selection_o(ACS01_selection_o),
        .ACS10_selection_o(ACS10_selection_o),
        .ACS11_selection_o(ACS11_selection_o),
        .n_ACS00_path_cost(n_ACS00_path_cost),
        .n_ACS01_path_cost(n_ACS01_path_cost),
        .n_ACS10_path_cost(n_ACS10_path_cost),
        .n_ACS11_path_cost(n_ACS11_path_cost),
        .te               (te),
        .oe               (oe),
        .tb_cnt           (tb_cnt),
        .d_out            (d_out)                
    );

    assign d_valid = oe;
endmodule