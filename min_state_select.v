module min_state_select (
    input  [3:0] n_ACS00_path_cost,
    input  [3:0] n_ACS01_path_cost,
    input  [3:0] n_ACS10_path_cost,
    input  [3:0] n_ACS11_path_cost,
    output reg [1:0] min_state
);
    // Biến tạm để lưu kết quả của cấp 1
    reg [3:0] min_01_val;   // Giá trị min của (00, 01)
    reg [1:0] min_01_state; // Trạng thái min của (00, 01)
    reg [3:0] min_23_val;   // Giá trị min của (10, 11)
    reg [1:0] min_23_state; // Trạng thái min của (10, 11)

    always @(*) begin
        // ----- Cấp 1: So sánh các cặp -----
        if (n_ACS00_path_cost <= n_ACS01_path_cost) begin
            min_01_val   = n_ACS00_path_cost;
            min_01_state = 2'b00;
        end else begin
            min_01_val   = n_ACS01_path_cost;
            min_01_state = 2'b01;
        end

        if (n_ACS10_path_cost <= n_ACS11_path_cost) begin
            min_23_val   = n_ACS10_path_cost;
            min_23_state = 2'b10;
        end else begin
            min_23_val   = n_ACS11_path_cost;
            min_23_state = 2'b11;
        end
        
        // ----- Cấp 2: So sánh 2 kết quả -----
        // Tìm trạng thái min cuối cùng
        if (min_01_val <= min_23_val) begin
            min_state = min_01_state;
        end else begin
            min_state = min_23_state;
        end
    end
 
endmodule