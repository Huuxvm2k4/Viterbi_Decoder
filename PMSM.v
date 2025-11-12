// PMSM: Path Metric Store Memory
module PMSM (
    input clk,
    input rst_n,         
    input we, // 1: ghi ACSXX_path_cost vào bộ nhớ
    input  [3:0] ACS00_path_cost,
    input  [3:0] ACS01_path_cost,
    input  [3:0] ACS10_path_cost,
    input  [3:0] ACS11_path_cost,
    output [3:0] n_ACS00_path_cost,
    output [3:0] n_ACS01_path_cost,
    output [3:0] n_ACS10_path_cost,
    output [3:0] n_ACS11_path_cost
);
    localparam [3:0] INF = 4'b1111;

    reg [3:0] mem00, mem01, mem10, mem11;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mem00 <= 0;
            mem01 <= INF;
            mem10 <= INF;
            mem11 <= INF;
        end else if (we) begin
            mem00 <= ACS00_path_cost;
            mem01 <= ACS01_path_cost;
            mem10 <= ACS10_path_cost;
            mem11 <= ACS11_path_cost;
        end
    end

    assign n_ACS00_path_cost = mem00;
    assign n_ACS01_path_cost = mem01;
    assign n_ACS10_path_cost = mem10;
    assign n_ACS11_path_cost = mem11;
endmodule
