module control_unit (
    input        clk,
    input        rst_n, 
    input        en,  
    input  [3:0] wr_cnt,
    input  [3:0] tb_cnt,
    output       we,   
    output       te,     
    output       oe     
);

    localparam [2:0]
        IDLE   = 3'd0,
        STORE  = 3'd1,
        MIN    = 3'd2,
        TB     = 3'd3;

    reg [2:0] state, n_state;
    reg [2:0] ctrl;   
    assign {we, te, oe} = ctrl;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else begin
            state <= n_state;
        end
    end

    always @(*) begin
        n_state = state;
        ctrl    = 3'b000;
        case (state)
            IDLE: begin
                ctrl = 3'b000;
                if (en)
                    n_state = STORE;
            end

            STORE: begin
                ctrl = 3'b100; 
                if (wr_cnt >= 4'd7)
                    n_state = MIN;
                else
                    n_state = STORE;
            end

            MIN: begin
                ctrl    = 3'b000;
                n_state = TB;
            end

            TB: begin
                if (tb_cnt > 4'd0) begin
                    ctrl    = 3'b011; 
                    n_state = TB; 
                end else begin
                    ctrl    = 3'b000;
                    n_state = IDLE;   
                end
            end

            default: begin
                ctrl    = 3'b000;
                n_state = IDLE;
            end
        endcase
    end

endmodule
