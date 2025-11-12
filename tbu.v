// Function: Tìm min_state tương ứng với đường có 
//           path_cost nhỏ nhất trong 4 giá trị ACS.


module tbu (
    output reg [1:0] min_state,
    input  [3:0] n_ACS00_path_cost,
    input  [3:0] n_ACS01_path_cost,
    input  [3:0] n_ACS10_path_cost,
    input  [3:0] n_ACS11_path_cost
);
  reg [3:0]    min_01; // min_01: giá trị nhỏ nhất giữa ACS00 và ACS01
  reg [3:0]    min_23; // min_23: giá trị nhỏ nhất giữa ACS10 và ACS11
  reg [3:0]    min_metric; // min_metric: giá trị nhỏ nhất trong 4 đường
  
  // Tìm giá trị min giữa các cặp
  
 always @(n_ACS00_path_cost,n_ACS01_path_cost,n_ACS10_path_cost,n_ACS11_path_cost)
  begin
    if(n_ACS00_path_cost <= n_ACS01_path_cost)
     min_01 = n_ACS00_path_cost;
    else 
     min_01 = n_ACS01_path_cost;
    if(n_ACS10_path_cost <= n_ACS11_path_cost)
     min_23 = n_ACS10_path_cost;
    else 
     min_23 = n_ACS11_path_cost;
    if(min_01 <= min_23)
     min_metric = min_01;
    else 
     min_metric = min_23;
  end
  
  // Xác định nhánh tương ứng với giá trị min
  
 always @(n_ACS00_path_cost,n_ACS01_path_cost,n_ACS10_path_cost,n_ACS11_path_cost,min_metric)
  begin
   if(n_ACS00_path_cost == min_metric)
    min_state = 2'b00;
   else if(n_ACS01_path_cost == min_metric)
    min_state = 2'b01;
   else if(n_ACS10_path_cost == min_metric)
    min_state = 2'b10;
   else if(n_ACS11_path_cost == min_metric)
    min_state = 2'b11;
  end
  
endmodule