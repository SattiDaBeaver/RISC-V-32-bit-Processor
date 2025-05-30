`timescale 1ns / 1ps
// `define PRETRAINED

module testbench ( );

	parameter CLOCK_PERIOD = 10;

	logic CLOCK_50;
    logic [0:0] KEY;
    logic [6:0] HEX0;

	// Comparison Unit Test
    logic reset;
    logic [31:0] inputA;
    logic [31:0] inputB;
    logic [3:0]  compSelect;
    logic [31:0] compOut;

	initial begin
        CLOCK_50 <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) CLOCK_50 <= ~CLOCK_50;
	end

    enum logic [selectWidth-1:0] {
        EQUAL, NOT_EQUAL, LESS_THAN, LESS_THAN_OR_EQUAL, GREATER_THAN, GREATER_THAN_OR_EQUAL
    } comparisonType;
	
	initial begin
        #10
        compSelect <= EQUAL; // EQUAL
		inputA <= 32'h0000008; // 
        inputB <= 32'h0000008; // 
		#10
        inputA <= 32'h0000008; // 
        inputB <= 32'h0000007; // 
		#20

        compSelect <= NOT_EQUAL; // NOT EQUAL
		inputA <= 32'h0000003; // 
        inputB <= 32'h0000007; // 
		#10
        inputA <= 32'h0000007; // 
        inputB <= 32'h0000007; // 
        #20

        compSelect <= LESS_THAN; // LESS THAN
		inputA <= 32'h0000003; // 
        inputB <= 32'h0000007; // 
		#10
        inputA <= 32'h0000007; // 
        inputB <= 32'h0000007; // 
        #10
        inputA <= 32'h0000007; // 
        inputB <= 32'h0000007; // 




        
	end // initial
	
	ComparisonUnit #(
        .dataWidth(32),
        .selectWidth(4)
    ) comp_unit (
        .clk(CLOCK_50),
        .reset(reset),
        .inputA(compIn),
        .inputB(8'h80), // Test with a negative input
        .comparisonSelect(compSelect),
        
        .output(compOut)
    );

endmodule
