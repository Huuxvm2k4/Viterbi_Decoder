module ACS (
    input  [3:0] path_cost_0,   // metric hiện tại của nhánh 0
    input  [3:0] path_cost_1,   // metric hiện tại của nhánh 1
    input  [1:0] bmc_path_0,    // branch metric cho nhánh 0 
    input  [1:0] bmc_path_1,    // branch metric cho nhánh 1 
    output [3:0] n_path_cost,   // metric mới sau ACS (min)
    output decision             // 0 -> chọn nhánh 0, 1 -> chọn nhánh 1
);
    localparam [3:0] INF = 4'b1111;

    wire [3:0] bm0_ext = {{{2'b00}}, bmc_path_0};
    wire [3:0] bm1_ext = {{{2'b00}}, bmc_path_1};

    // cộng rộng 1 bit để bắt tràn
    wire [4:0] sum0 = path_cost_0 + bm0_ext;
    wire [4:0] sum1 = path_cost_1 + bm1_ext;

    // Nếu input đã INF hoặc tràn thì ra INF
    wire [3:0] cost0_ovf = (path_cost_0 == INF) ? INF : (sum0[4] ? INF : sum0[3:0]);
    wire [3:0] cost1_ovf = (path_cost_1 == INF) ? INF : (sum1[4] ? INF : sum1[3:0]);

    // Chọn nhỏ hơn
    wire take0 = (cost0_ovf <= cost1_ovf);

    assign n_path_cost = take0 ? cost0_ovf : cost1_ovf;
    assign decision = take0 ? 1'b0 : 1'b1;   // 0: chọn path0, 1: path1
endmodule
