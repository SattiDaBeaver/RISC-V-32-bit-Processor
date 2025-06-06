module ALU #(
    parameter dataWidth = 32, selectWidth = 4
) (
    input   logic                           clk,
    input   logic                           reset,
    input   logic   [dataWidth-1:0]         inputA,
    input   logic   [dataWidth-1:0]         inputB,
    input   logic   [selectWidth-1:0]       ALUSelect,
    
    output  logic   [dataWidth-1:0]         dataOut,
    output  logic   [dataWidth-1:0]         dataOutHigh
);
    
    enum logic [selectWidth-1:0] {
        ADD, SUB, MUL, AND, OR, 
        XOR, NOT, SLL, SRL
    } ALUop;
    
    always_comb begin
        dataOutHigh = 0;
        case (ALUSelect)
            ADD:        dataOut = (inputA + inputB);
            SUB:        dataOut = (inputA - inputB);

            MUL:        {dataOutHigh, dataOut} = ($signed(inputA) * $signed(inputB));

            AND:        dataOut = (inputA & inputB);
            OR :        dataOut = (inputA | inputB);
            XOR:        dataOut = (inputA ^ inputB);
            NOT:        dataOut = (~inputA);

            SLL:        dataOut = (inputA << inputB);
            SRL:        dataOut = (inputA >> inputB);

            default:    {dataOutHigh, dataOut} = 0;         // Default case to handle unexpected values
        endcase
    end
endmodule