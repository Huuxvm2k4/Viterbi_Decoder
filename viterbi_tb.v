`timescale 1ns / 1ps
module tb_top;
    localparam CLK_PERIOD = 10; // 10 ns = 100 MHz

    reg clk;
    reg rst_n;
    reg en;
    reg [1:0] d_in;
    wire d_out;
    wire d_valid; 

    reg [15:0] encoded_data;
    reg [7:0] decoded_data; 
    integer i;
    
    reg [15:0] temp_encoded_data; // Dùng để dịch bit thay vì indexed part-select

    viterbi_decoder_top dut (
        .clk        (clk),
        .rst_n      (rst_n),
        .en         (en),
        .d_in       (d_in),
        .d_out      (d_out),
        .d_valid (d_valid)
    );

    always #((CLK_PERIOD) / 2) clk = ~clk;

    initial begin
        $display("Testbench: Bat dau khoi tao cac gia tri.");
        clk = 0;
        rst_n = 0; 
        en = 0;
        d_in = 2'bxx;
        
        encoded_data = 16'b0000_0101_1111_1011;
        //encoded_data = 16'b0000_0000_0000_0000;
        //encoded_data = 16'b1110_0010_0010_0010;
        //encoded_data = 16'b1110_0111_1111_0111;
        
        decoded_data = 8'b0;

        #20;
        rst_n = 1;
        @(posedge clk);

        $display("Testbench: Bat dau Giai doan 1 (STORE).");
        en <= 1; // Kích 'en' trong 1 chu kỳ
        
        temp_encoded_data = encoded_data; // Nạp dữ liệu vào thanh ghi tạm
        #10;
        for (i = 0; i < 9; i = i + 1) begin
            d_in <= temp_encoded_data[15:14];
            // Dịch 2 bit đã dùng ra ngoài
            temp_encoded_data <= temp_encoded_data << 2; 
            
            if (i == 0) begin
                @(posedge clk);
                en <= 0; 
            end else begin
                @(posedge clk);
            end
            
            $display("  [Time %0t] Ghi chu ky %0d: d_in = %b", $time, i, d_in);
        end
        d_in <= 2'bxx; 

        $display("Testbench: Doi 1 chu ky cho trang thai MIN.");
        @(posedge clk); // Đây là chu kỳ của trạng thái MIN

        $display("Testbench: Bat dau Giai doan 2 (TRACEBACK).");
        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk);
            if (d_valid) begin
                decoded_data <= {decoded_data[6:0], d_out}; 
                
                $display("  [Time %0t] Doc chu ky %0d: d_out = %b (d_valid=%b)", $time, i, d_out, d_valid);
            end else begin
                $display("  [Time %0t] Doc chu ky %0d: LOI! d_valid dang la LOW!", $time, i);
            end
        end

        @(posedge clk);
        $display("-------------------------------------------");
        $display("Testbench: Mo phong hoan tat.");
        $display("  Du lieu MA HOA   (16 bit): %b", encoded_data);
        $display("  Du lieu GIAI MA  (8 bit): %b", decoded_data);
        $display("  (Ket qua ky vong: 8'b00100110)");
        // $display("  (Ket qua ky vong: 8'b00000000)");
        // $display("  (Ket qua ky vong: 8'b10101010)");
        // $display("  (Ket qua ky vong: 8'b11001100)");
        $display("-------------------------------------------");
        $finish;
    end

endmodule

