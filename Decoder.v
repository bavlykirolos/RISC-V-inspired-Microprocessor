`timescale 1ns / 1ps

    module Decoder(
    input [15:0] instruction,
    input [15:0] reg0in,
    input [15:0] reg1in,
    input [15:0] reg2in,
    input [15:0] reg3in,
    input [15:0] reg4in,
    input [15:0] reg5in,
    input [15:0] reg6in,
    input [15:0] reg7in,
    output reg [15:0] ra,
    output reg [15:0] rb,
    output reg [15:0] rc,
    output reg [6:0] imm7,
    output reg [9:0] imm10
    );
    always @(*) begin
    casez(instruction[12:10])
    3'b000 : ra = reg0in;
    3'b001 : ra = reg1in;
    3'b010 : ra = reg2in;
    3'b011 : ra = reg3in;
    3'b100 : ra = reg4in;
    3'b101 : ra = reg5in;
    3'b110 : ra = reg6in;
    3'b111 : ra = reg7in;
    endcase
    casez(instruction[9:7])
    3'b000 : rb = reg0in;
    3'b001 : rb = reg1in;
    3'b010 : rb = reg2in;
    3'b011 : rb = reg3in;
    3'b100 : rb = reg4in;
    3'b101 : rb = reg5in;
    3'b110 : rb = reg6in;
    3'b111 : rb = reg7in;
    endcase
    casez(instruction[2:0])
    3'b000 : rc = reg0in;
    3'b001 : rc = reg1in;
    3'b010 : rc = reg2in;
    3'b011 : rc = reg3in;
    3'b100 : rc = reg4in;
    3'b101 : rc = reg5in;
    3'b110 : rc = reg6in;
    3'b111 : rc = reg7in;
    endcase
    imm7 = instruction[6:0];
    imm10 = instruction[9:0];
    end
endmodule
