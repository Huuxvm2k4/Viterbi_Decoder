module BMU (
   input  [1:0] d_in,
   output [1:0] bmc00_path_0,
   output [1:0] bmc00_path_1,
   output [1:0] bmc01_path_0,
   output [1:0] bmc01_path_1,
   output [1:0] bmc10_path_0,
   output [1:0] bmc10_path_1,
   output [1:0] bmc11_path_0,
   output [1:0] bmc11_path_1
);

bmc #(.out0(2'b00), .out1(2'b11)) bmc00 (.d_in(d_in), .path_0_bmc(bmc00_path_0), .path_1_bmc(bmc00_path_1));
bmc #(.out0(2'b10), .out1(2'b01)) bmc01 (.d_in(d_in), .path_0_bmc(bmc01_path_0), .path_1_bmc(bmc01_path_1));
bmc #(.out0(2'b11), .out1(2'b00)) bmc10 (.d_in(d_in), .path_0_bmc(bmc10_path_0), .path_1_bmc(bmc10_path_1));
bmc #(.out0(2'b01), .out1(2'b10)) bmc11 (.d_in(d_in), .path_0_bmc(bmc11_path_0), .path_1_bmc(bmc11_path_1));

endmodule
