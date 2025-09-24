`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2024 02:08:27 AM
// Design Name: 
// Module Name: processor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module processor_tb;
reg clk=0;
   // wire [15:0] count;
Processor uut(
.clk(clk)
//.instruction(count)
);
 initial begin 
  clk = 0;
  forever #10 clk = ~clk;
 end
endmodule
