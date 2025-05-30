`timescale 1ns / 1ps
// `define PRETRAINED

module testbench ();

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
    logic        compBit;
    logic        compOutExpected;

	initial begin
        CLOCK_50 <= 1'b0;
	end // initial
	always @ (*)
	begin : Clock_Generator
		#((CLOCK_PERIOD) / 2) CLOCK_50 <= ~CLOCK_50;
	end

    parameter dataWidth = 32;
    parameter selectWidth = 4;

    enum logic [selectWidth-1:0] {
        EQUAL, NOT_EQUAL, LESS_THAN, LESS_THAN_UNSIGNED, LESS_THAN_OR_EQUAL, LESS_THAN_OR_EQUAL_UNSIGNED,
        GREATER_THAN, GREATER_THAN_UNSIGNED, GREATER_THAN_OR_EQUAL, GREATER_THAN_OR_EQUAL_UNSIGNED
    } comparisonType;
	
	initial begin
        #10
        compSelect <= EQUAL; // EQUAL
		inputA <= 32'h00000008; // 
        inputB <= 32'h00000008; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000008; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
		#20

        compSelect <= NOT_EQUAL; // NOT EQUAL
		inputA <= 32'h00000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
        #20

        compSelect <= LESS_THAN; // LESS THAN
		inputA <= 32'h00000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
        #10
        inputA <= 32'h80000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
        #20

        compSelect <= LESS_THAN_UNSIGNED; // LESS THAN UNSIGNED
		inputA <= 32'h00000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
        #10
        inputA <= 32'h80000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 1
        #20

        compSelect <= LESS_THAN_OR_EQUAL; // LESS THAN OR EQUAL
		inputA <= 32'h00000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
        #10
        inputA <= 32'h80000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 0

        #20
        compSelect <= LESS_THAN_OR_EQUAL_UNSIGNED; // LESS THAN OR EQUAL UNSIGNED
		inputA <= 32'h00000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 0
        #10
        inputA <= 32'h80000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 1

        #20
        compSelect <= GREATER_THAN; // GREATER THAN
		inputA <= 32'h80000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
        #10
        inputA <= 32'h00000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1

        #20
        compSelect <= GREATER_THAN_UNSIGNED; // GREATER THAN UNSIGNED
		inputA <= 32'h80000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
        #10
        inputA <= 32'h00000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1

        #20
        compSelect <= GREATER_THAN_OR_EQUAL; // GREATER THAN OR EQUAL
		inputA <= 32'h80000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b0; // Expecting output to be 0
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
        #10
        inputA <= 32'h00000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1

        #20
        compSelect <= GREATER_THAN_OR_EQUAL_UNSIGNED; // GREATER THAN OR EQUAL UNSIGNED
		inputA <= 32'h80000003; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 0
		#10
        inputA <= 32'h00000007; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
        #10
        inputA <= 32'h00000009; // 
        inputB <= 32'h00000007; // 
        compOutExpected <= 1'b1; // Expecting output to be 1
	end // initial
	
	ComparisonUnit #(
        .dataWidth(dataWidth),
        .selectWidth(selectWidth)
    ) comp_unit (
        .clk(CLOCK_50),
        .reset(reset),
        .inputA(inputA), 
        .inputB(inputB), 
        .comparisonSelect(compSelect),
        
        .dataOut(compOut)
    );

    assign compBit = compOut[0];
endmodule
