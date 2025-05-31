module RFile #(dataWidth = 32, AddressWidth = $clog2(dataWidth), numReg = 32)
             (
             input logic Clk ,
             input logic RFwrite,
             input logic reset,
             input logic [AddressWidth-1:0] RegA,
             input logic [AddressWidth-1:0] RegB,
             input logic [AddressWidth-1:0] RegW,
             input logic [dataWidth-1:0] dataW,
             
             output logic [dataWidth-1:0] dataA,
             output logic [dataWidth-1:0] dataB );

integer i;



logic [dataWidth-1:0] registers [numReg-1:0];
initial begin
for(i=0;i<numReg;i++) begin
    registers [i] <= 0;
end
end 

always @ (posedge Clk) begin 
    if(reset) begin
        for(i=0;i<numReg;i++)begin
        registers [i] <= 0;
        end
    end

    else if(RFwrite) begin 
        if(RegW == 0)begin
            registers[0] <= 0;
        end
        else begin
        registers[RegW] <= dataW;
        end
    end
end


always @(*) begin
    dataA = registers[RegA];
    dataB = registers[RegB];
end

endmodule