module RFile #(dataWidth = 32, AddressWidth = $clog2(dataWidth))
             (
             input logic Clk ,
             input logic RFwrite,
             input logic reset,
             input logic [AddressWidth-1:0] RegA,
             input logic [AddressWidth-1:0] RegB,
             input logic [AddressWidth-1:0] RegW,
             input logic [dataWidth-1:0] dataW,
             
             output logic [dataWidth-1:0] dataA,
             output logic [dataWidth-1:0] dataB, )


endmodule