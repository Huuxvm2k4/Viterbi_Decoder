module TB (
    input clk,
    input rst_n,
    input [7:0] ACS00_selection_o,
    input [7:0] ACS01_selection_o,
    input [7:0] ACS10_selection_o,
    input [7:0] ACS11_selection_o,
    input [3:0] n_ACS00_path_cost,
    input [3:0] n_ACS01_path_cost,
    input [3:0] n_ACS10_path_cost,
    input [3:0] n_ACS11_path_cost,
    input te,
    input oe,
    output [3:0] tb_cnt,
    output d_out
);

    wire [1:0] min_state;

    min_state_select min_inst (
        .n_ACS00_path_cost(n_ACS00_path_cost),
        .n_ACS01_path_cost(n_ACS01_path_cost),
        .n_ACS10_path_cost(n_ACS10_path_cost),
        .n_ACS11_path_cost(n_ACS11_path_cost),
        .min_state(min_state)
    );

    tb_mapping tb_mapping_inst (
        .clk(clk),
        .rst_n(rst_n),
        .min_state(min_state),
        .ACS00_selection_o(ACS00_selection_o),
        .ACS01_selection_o(ACS01_selection_o),
        .ACS10_selection_o(ACS10_selection_o),
        .ACS11_selection_o(ACS11_selection_o),
        .te(te),
        .oe(oe),
        .tb_cnt(tb_cnt),
        .d_out(d_out)
    );

endmodule