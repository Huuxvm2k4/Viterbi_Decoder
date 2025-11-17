// Traceback path memory (Lưu trữ decision bit)
module TBPM (
    input clk,
    input rst_n,
    input we,   // 1: ghi (forward), 0: đọc (traceback)
    input ACS00_selection,
    input ACS01_selection,
    input ACS10_selection,
    input ACS11_selection,
    output [7:0] ACS00_selection_o,
    output [7:0] ACS01_selection_o,
    output [7:0] ACS10_selection_o,
    output [7:0] ACS11_selection_o,
    output reg [3:0] wr_cnt
);
    reg [7:0] sr00, sr01, sr10, sr11;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sr00 <= 0;
            sr01 <= 0;  
            sr10 <= 0; 
            sr11 <= 0;
            wr_cnt <= 0;
        end else begin
            if (we) begin
                sr00 <= {ACS00_selection, sr00[7:1]};
                sr01 <= {ACS01_selection, sr01[7:1]};
                sr10 <= {ACS10_selection, sr10[7:1]};
                sr11 <= {ACS11_selection, sr11[7:1]};
                wr_cnt <= wr_cnt + 1;
            end
        end
    end

    assign ACS00_selection_o = sr00;
    assign ACS01_selection_o = sr01;
    assign ACS10_selection_o = sr10;
    assign ACS11_selection_o = sr11;

endmodule
