`timescale 1ns / 1ps
// `define PRETRAINED

module testbench ();

	parameter CLOCK_PERIOD = 10;

	logic CLOCK_50;
    logic [0:0] KEY;
    logic [6:0] HEX0;

	// RFile Test
   logic RFwrite,
   logic reset,
logic [AddressWidth-1:0] RegA,
logic [AddressWidth-1:0] RegB,
logic [AddressWidth-1:0] RegW,
logic [dataWidth-1:0] dataW,
             
logic [dataWidth-1:0] dataA,
logic [dataWidth-1:0] dataB, 

	initial begin
        CLOCK_50 <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) CLOCK_50 <= ~CLOCK_50;
	end

    parameter dataWidth = 32;
    parameter selectWidth = 4;

	initial begin
    #10
    RFwrite <= 1;
    regA <= 5'b00010;
    regB <= 5'b00000;
    dataW <= 32'h00000003;
    regW <= 5'b00000;
    #20


       
	end // initial
	
	RFile #(
        .dataWidth(dataWidth),
        .selectWidth(selectWidth)
    ) U1 (
        .Clk(CLOCK_50),
        .reset(reset),
        .RegA(regA), 
        .RegB(regB), 
        .RegW(regW),
        .dataW(dataW),
        
        .dataA(dataA),
        .dataB(dataB)
    );

endmodule
