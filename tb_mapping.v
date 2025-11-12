// Function: Lần ngược lại đường đi từ path memory sr00–sr11

module tb_mapping(
    input  wire        clock,
    input  wire        rst_n,
    input  wire        te,
    input  wire [1:0]  min_state,
    input  wire [7:0] sr00,
    input  wire [7:0] sr01,
    input  wire [7:0] sr10,
    input  wire [7:0] sr11,
    input  wire [2:0]   trace_ptr,
    input  wire [1:0]   NEXT_STATE,
    output reg  [1:0]   tb_reg 
);

localparam WRITE_METRICS = 2'b01;  // trạng thái FSM: vừa tính xong metric

always @(posedge clock or negedge rst_n)
begin
    if (!rst_n)
        tb_reg <= 2'b00;
    else begin
        // Khi bắt đầu giai đoạn traceback: gán tb_reg = min_state
        if (NEXT_STATE == WRITE_METRICS)
            tb_reg <= min_state;

        // Khi traceback enable, cập nhật tb_reg dựa theo path memory
        else if (te) begin
            case (tb_reg)
                2'b00: tb_reg <= {sr00[trace_ptr], tb_reg[1]};
                2'b01: tb_reg <= {sr01[trace_ptr], tb_reg[1]};
                2'b10: tb_reg <= {sr10[trace_ptr], tb_reg[1]};
                2'b11: tb_reg <= {sr11[trace_ptr], tb_reg[1]};
            endcase
        end
    end
end

endmodule
