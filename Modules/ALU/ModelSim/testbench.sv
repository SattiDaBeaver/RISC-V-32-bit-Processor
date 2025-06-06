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
    logic [3:0]  ALUSelect;
    logic [31:0] dataOut;
    logic [31:0] dataOutHigh;
    logic [31:0] dataOutExpected;
    logic [31:0] dataOutHighExpected;

    // Parameters
    parameter dataWidth = 32;
    parameter selectWidth = 4;

    typedef enum logic [selectWidth-1:0] {
        ADD, SUB, MUL, AND, OR, 
        XOR, NOT, SLL, SRL
    } ALUOp;

    ALUOp compSelect;

    initial begin
        CLOCK_50 = 1'b0;
    end

    always begin
        #(CLOCK_PERIOD / 2) CLOCK_50 = ~CLOCK_50;
    end

    initial begin
        reset = 0;
        ALUSelect = compSelect;

        #10
        compSelect          = ADD;
        ALUSelect           = compSelect;
        inputA              = 32'h00000008;
        inputB              = 32'h00000008;
        dataOutExpected     = 32'h00000010;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h00000008;
        inputB              = 32'h00000007;
        dataOutExpected     = 32'h0000000F;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = SUB;
        ALUSelect           = compSelect;
        inputA              = 32'h00000003;
        inputB              = 32'h00000007;
        dataOutExpected     = 32'hFFFFFFFC;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h00000007;
        inputB              = 32'h00000007;
        dataOutExpected     = 32'h00000000;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = MUL;
        ALUSelect           = compSelect;
        inputA              = 32'h00000003;
        inputB              = 32'h00000007;
        dataOutExpected     = 32'h00000015;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h00000007;
        inputB              = 32'h00000007;
        dataOutExpected     = 32'h00000031;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = AND;
        ALUSelect           = compSelect;
        inputA              = 32'hF0F0F0F0;
        inputB              = 32'h0F0F0F0F;
        dataOutExpected     = 32'h00000000;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'hFFFFFFFF;
        inputB              = 32'h12345678;
        dataOutExpected     = 32'h12345678;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = OR;
        ALUSelect           = compSelect;
        inputA              = 32'hF0F0F0F0;
        inputB              = 32'h0F0F0F0F;
        dataOutExpected     = 32'hFFFFFFFF;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h00000000;
        inputB              = 32'h12345678;
        dataOutExpected     = 32'h12345678;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = XOR;
        ALUSelect           = compSelect;
        inputA              = 32'hFFFF0000;
        inputB              = 32'h00FFFF00;
        dataOutExpected     = 32'hFF00FF00;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'hAAAAAAAA;
        inputB              = 32'h55555555;
        dataOutExpected     = 32'hFFFFFFFF;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = NOT;
        ALUSelect           = compSelect;
        inputA              = 32'h00000000;
        inputB              = 32'h0;
        dataOutExpected     = 32'hFFFFFFFF;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h12345678;
        inputB              = 32'h0;
        dataOutExpected     = 32'hEDCBA987;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = SLL;
        ALUSelect           = compSelect;
        inputA              = 32'h00000001;
        inputB              = 32'd32;
        dataOutExpected     = 32'h00000000;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h00000001;
        inputB              = 32'd1;
        dataOutExpected     = 32'h00000002;
        dataOutHighExpected = 32'h0;

        #20
        compSelect          = SRL;
        ALUSelect           = compSelect;
        inputA              = 32'h80000000;
        inputB              = 32'd31;
        dataOutExpected     = 32'h00000001;
        dataOutHighExpected = 32'h0;

        #10
        inputA              = 32'h00000002;
        inputB              = 32'd1;
        dataOutExpected     = 32'h00000001;
        dataOutHighExpected = 32'h0;

        #20
        $finish;
    end

    ALU #(
        .dataWidth(dataWidth),
        .selectWidth(selectWidth)
    ) comp_unit (
        .clk(CLOCK_50),
        .reset(reset),
        .inputA(inputA), 
        .inputB(inputB), 
        .ALUSelect(ALUSelect),
        .dataOut(dataOut),
        .dataOutHigh(dataOutHigh)
    );

endmodule
