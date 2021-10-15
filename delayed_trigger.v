`timescale 1ns/1ps

module www;
    parameter CYC = 2;
    parameter counter_width =32;

    reg Clk = 0;
    wire trigger;
    wire [counter_width-1:0] delay = 10;
    reg in_trigger = 0;
    always #(CYC/2)
    begin
        Clk = ~Clk;
    end

    initial begin
        $dumpfile("www.vcd"); // vcd file name
        $dumpvars(0);     // dump targetは「全部」
        
        #(CYC*10) in_trigger <= ~in_trigger;
        #(CYC*1) in_trigger <= ~in_trigger;
        #(CYC*30) in_trigger <= ~in_trigger;
        #(CYC*1) in_trigger <= ~in_trigger;

        #(CYC*100)   $finish;
    end

    counter #(
        .counter_width(counter_width)
    )instance_counter
    (
        .clock(Clk),
        .trigger(trigger),
        .delay(delay)
    );

    assign trigger = in_trigger;
  
endmodule



module counter
#(
    parameter counter_width = 32
)
(
    input wire clock,
    input wire trigger,
    input wire [counter_width-1:0] delay,
    output wire delayed_trigger
);
reg [counter_width-1:0] in_cnt;



    initial begin
        in_cnt <= 0;
    end

    always@(posedge clock)
    begin
        if(in_cnt != 32'b1111111) in_cnt <= in_cnt + 1;
    end

    always@(posedge trigger)
    begin
        in_cnt <= 0;
    end
    
assign delayed_trigger = in_cnt > delay;
endmodule