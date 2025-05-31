`timescale 1ns / 1ps
// `define PRETRAINED

module testbench ();

	parameter CLOCK_PERIOD = 10;

	logic CLOCK_50;
    logic [0:0] KEY;
    logic [6:0] HEX0;

	// RFile Test

    parameter dataWidth = 32;
    parameter AddressWidth = 5;

logic RFwrite;
logic reset;
logic [AddressWidth-1:0] regA;
logic [AddressWidth-1:0] regB;
logic [AddressWidth-1:0] regW;
logic [dataWidth-1:0] dataW;
             
logic [dataWidth-1:0] dataA;
logic [dataWidth-1:0] dataB; 

	initial begin
        CLOCK_50 <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) CLOCK_50 <= ~CLOCK_50;
	end


	initial begin
    #10
    reset <= 1;
    #20
    reset <= 0;
    RFwrite <= 1;
    regA <= 5'b00010;
    regB <= 5'b00000;
    dataW <= 32'h00000003;
    regW <= 5'b00000;
    #20
    reset <=0;
    RFwrite <= 1;
    regA <= 5'b00010;
    regB <= 5'b00000;
    dataW <= 32'h00000003;
    regW <= 5'b00010;


    end // initial
	
	RFile #(
        .dataWidth(dataWidth),
        .AddressWidth(AddressWidth)
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
