`timescale 1ns/1ps

module www;
    reg        Clk = 0;
    wire [7:0] counter;
    parameter CYC = 2;
    always #(CYC/2)
    begin
        Clk = ~Clk;
    end

    initial begin
        $dumpfile("www.vcd"); // vcd file name
        $dumpvars(0);     // dump targetは「全部」

        #(CYC*20)   $finish;
    end

    counter instance_counter
    (Clk, counter);
  
endmodule



module counter
(
    input wire clock,
    output wire [7:0] cnt
);
reg [7:0] in_cnt;



    initial begin
        in_cnt = 0;
    end

    always@(posedge clock)
    begin
        in_cnt <= in_cnt + 1;
    end


assign cnt = in_cnt;
endmodule