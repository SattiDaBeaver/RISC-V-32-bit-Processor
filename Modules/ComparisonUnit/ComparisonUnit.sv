module ComparisonUnit #(
    parameter dataWidth = 32, selectWidth = 4
) (
    input   logic                           clk,
    input   logic                           reset,
    input   logic   [dataWidth-1:0]         inputA,
    input   logic   [dataWidth-1:0]         inputB,
    input   logic   [selectWidth-1:0]       comparisonSelect,
    
    output  logic   [dataWidth-1:0]         dataOut
);
    
    logic result;

    enum logic [selectWidth-1:0] {
        EQUAL, NOT_EQUAL, LESS_THAN, LESS_THAN_UNSIGNED, LESS_THAN_OR_EQUAL, LESS_THAN_OR_EQUAL_UNSIGNED,
        GREATER_THAN, GREATER_THAN_UNSIGNED, GREATER_THAN_OR_EQUAL, GREATER_THAN_OR_EQUAL_UNSIGNED
    } comparisonType;
    always_comb begin
        case (comparisonSelect)
            EQUAL:                          result = (inputA == inputB);
            NOT_EQUAL:                      result = (inputA != inputB);

            LESS_THAN:                      result = ($signed(inputA) < $signed(inputB));
            LESS_THAN_UNSIGNED:             result = (inputA < inputB);

            LESS_THAN_OR_EQUAL:             result = ($signed(inputA) <= $signed(inputB));
            LESS_THAN_OR_EQUAL_UNSIGNED:    result = (inputA <= inputB);
            
            GREATER_THAN:                   result = ($signed(inputA) > $signed(inputB));
            GREATER_THAN_UNSIGNED:          result = (inputA > inputB);

            GREATER_THAN_OR_EQUAL:          result = ($signed(inputA) >= $signed(inputB));
            GREATER_THAN_OR_EQUAL_UNSIGNED: result = (inputA >= inputB);

            default: result = 0; // Default case to handle unexpected values
        endcase

        dataOut = {31'b0, result};
    end
endmodule