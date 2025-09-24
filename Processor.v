`timescale 1ns / 1ps

module Processor(
    input clk
    );
    //PC register initialized to 0 to get the instruction at memory0
    reg [15:0] PC = 'b0;
    //our registers for programmers to use
    reg [15:0] reg0 = 'b0;
    reg [15:0] reg1 = 'b0;
    reg [15:0] reg2 = 'b0;
    reg [15:0] reg3 = 'b0;
    reg [15:0] reg4 = 'b0;
    reg [15:0] reg5 = 'b0;
    reg [15:0] reg6 = 'b0;
    reg [15:0] reg7 = 'b0;
    wire [15:0] instruction; //mem to decoder & ALU
    wire [15:0] targetaddr; // ALU to mem
    wire [15:0] datatobewritteninmem; //ALU to mem
    wire [15:0] datafrommem; //mem to ALU
    //ALU to registers
    wire [15:0] newreg0;
    wire [15:0] newreg1;
    wire [15:0] newreg2;
    wire [15:0] newreg3;
    wire [15:0] newreg4;
    wire [15:0] newreg5;
    wire [15:0] newreg6;
    wire [15:0] newreg7;
    wire [15:0] newPC;
    //decoder to ALU
    wire [15:0] radata;
    wire [15:0] rbdata;
    wire [15:0] rcdata;
    wire [6:0] imm7data;
    wire [9:0] imm10data;
    
    Memory #(
    .MEM_FILE("C:/Users/thiev/Desktop/final/finalbi.bin"),
    .SIZE(1024)
    ) mem(
    .clk(clk),
    .instaddr(PC),
    .instdata(instruction),
    .dataaddr(targetaddr),
    .dataread(datafrommem),
    .datawrite(datatobewritteninmem)
    );
    
    Decoder decoder(
    .instruction(instruction),
    .reg0in(reg0),
    .reg1in(reg1),
    .reg2in(reg2),
    .reg3in(reg3),
    .reg4in(reg4),
    .reg5in(reg5),
    .reg6in(reg6),
    .reg7in(reg7),
    .ra(radata),
    .rb(rbdata),
    .rc(rcdata),
    .imm7(imm7data),
    .imm10(imm10data)
    );
    
    ALU alu(
    .clk(clk),
    .ra(radata),
    .rb(rbdata),
    .rc(rcdata),
    .imm7(imm7data),
    .imm10(imm10data),
    .instr(instruction),
    .datainfrommem(datafrommem),
    .PCin(PC),
    .PCout(newPC),
    .targetaddrinmem(targetaddr),
    .dataouttomem(datatobewritteninmem),
    .reg0output(newreg0),
    .reg1output(newreg1),
    .reg2output(newreg2),
    .reg3output(newreg3),
    .reg4output(newreg4),
    .reg5output(newreg5),
    .reg6output(newreg6),
    .reg7output(newreg7)
    );
   
   //with each clk we update the registers using the output of the ALU
    always @(posedge clk) begin
    PC=newPC;
    reg0=newreg0;
    reg1=newreg1;
    reg2=newreg2;
    reg3=newreg3;
    reg4=newreg4;
    reg5=newreg5;
    reg6=newreg6;
    reg7=newreg7;
   end
   
endmodule
