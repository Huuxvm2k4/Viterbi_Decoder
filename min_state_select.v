// Function: Tìm min_state tương ứng với đường có 
//           path_cost nhỏ nhất trong 4 giá trị ACS.


module min_state_select (
    input  [3:0] n_ACS00_path_cost,
    input  [3:0] n_ACS01_path_cost,
    input  [3:0] n_ACS10_path_cost,
    input  [3:0] n_ACS11_path_cost,
    output reg [1:0] min_state
);
    reg [3:0] min_01; // min_01: giá trị nhỏ nhất giữa ACS00 và ACS01
    reg [3:0] min_23; // min_23: giá trị nhỏ nhất giữa ACS10 và ACS11
    reg [3:0] min_metric; // min_metric: giá trị nhỏ nhất trong 4 đường
  
    // Tìm giá trị min giữa các cặp
  
    always @(n_ACS00_path_cost,n_ACS01_path_cost,n_ACS10_path_cost,n_ACS11_path_cost) begin
        if (n_ACS00_path_cost <= n_ACS01_path_cost) begin
            min_01 = n_ACS00_path_cost;
        end else begin 
            min_01 = n_ACS01_path_cost;
        end

        if (n_ACS10_path_cost <= n_ACS11_path_cost) begin
            min_23 = n_ACS10_path_cost;
        end else begin
            min_23 = n_ACS11_path_cost;
        end
         
        if  (min_01 <= min_23) begin
            min_metric = min_01;
        end else begin
            min_metric = min_23;
        end
    end
  
    // Xác định nhánh tương ứng với giá trị min
    always @(n_ACS00_path_cost,n_ACS01_path_cost,n_ACS10_path_cost,n_ACS11_path_cost,min_metric) begin
        if(n_ACS00_path_cost == min_metric) begin
            min_state = 2'b00;
        end else if(n_ACS01_path_cost == min_metric) begin
            min_state = 2'b01;
        end else if(n_ACS10_path_cost == min_metric) begin
            min_state = 2'b10;
        end else if(n_ACS11_path_cost == min_metric) begin
            min_state = 2'b11;
        end else min_state = 2'bxx;
    end
  
endmodule