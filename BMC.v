module bmc #(
    parameter [1:0] out0 = 2'b00, 
    parameter [1:0] out1 = 2'b11  
)(
    input  [1:0] d_in,
    output [1:0] path_0_bmc, // Hamming distance d_in vs out0, chú ý 0 với 1 sau tên module chỉ thứ tự nhánh từ trên xuống ko liên quan đến đâu vào
    output [1:0] path_1_bmc  // Hamming distance d_in vs out1
);
    wire [1:0] diff0 = d_in ^ out0;
    wire [1:0] diff1 = d_in ^ out1;

    // {bit2,bit1} = {AND, XOR} 
    assign path_0_bmc = {(diff0[0] & diff0[1]), (diff0[0] ^ diff0[1])};
    assign path_1_bmc = {(diff1[0] & diff1[1]), (diff1[0] ^ diff1[1])};
endmodule
