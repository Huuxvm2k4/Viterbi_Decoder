module tb_mapping(
    input clk,
    input rst_n,
    input [1:0] min_state,         
    input [7:0] ACS00_selection_o,
    input [7:0] ACS01_selection_o,
    input [7:0] ACS10_selection_o,
    input [7:0] ACS11_selection_o,
    input te,
    input oe,
    output reg [3:0] tb_cnt,
    output d_out
);
    reg [1:0] tb_reg;  
    wire decision_bit;  

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tb_reg <= 2'b00;
            tb_cnt <= 4'd8;
        end else begin
            if (te) begin
                tb_reg <= {tb_reg[0], decision_bit};
                tb_cnt <= tb_cnt - 1;
            end else begin
                tb_reg <= min_state;
                tb_cnt <= 4'd8;
            end
        end
    end

    assign decision_bit = (tb_reg == 2'b00) ? ACS00_selection_o[tb_cnt - 1] :
                          (tb_reg == 2'b01) ? ACS01_selection_o[tb_cnt - 1] :
                          (tb_reg == 2'b10) ? ACS10_selection_o[tb_cnt - 1] :
                                              ACS11_selection_o[tb_cnt - 1];

    assign d_out = (oe) ? tb_reg[1] : 1'bz;

endmodule