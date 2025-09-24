`timescale 1ns / 1ps

module ALU(
    input clk,
    input [15:0] ra,
    input [15:0] rb,
    input [15:0] rc,
    input [6:0] imm7,
    input [9:0] imm10,
    input [15:0] instr,
    input [15:0] datainfrommem,
    input [15:0] PCin,
    output reg[15:0] PCout,
    output reg[15:0] targetaddrinmem,
    output reg[15:0] dataouttomem,
    output reg[15:0] reg0output =0,
    output reg[15:0] reg1output =0,
    output reg[15:0] reg2output =0,
    output reg[15:0] reg3output =0,
    output reg[15:0] reg4output =0,
    output reg[15:0] reg5output =0,
    output reg[15:0] reg6output =0,
    output reg[15:0] reg7output =0
    );
    // padding the imm7 so it is ready for arithmatic operations
    wire [15:0] imm7extended = {{9{imm7[6]}}, imm7};
    reg [15:0] operand1;
    reg [15:0] operand2;
    wire [15:0] sum;
    ADD fulladder(
    .rb(operand1),
    .rc(operand2),
    .ra(sum)
    );
    //calculate 2's compliment before addition (substraction)
    wire [15:0] immreadytosub = ~imm7extended+1;
    //this will store the content that need to be updated in one of the registers
    reg [15:0] racalculated = 'b0;
    always @(*) begin
    //standard case (deafult case unless changed by an instruction)
    PCout = PCin+1; //next instruction is the one following in mem  
    targetaddrinmem = 16'b0;
    casez (instr[15:13])
    3'b000 :begin //ADD
    operand1 = rb;
    operand2 = rc;
    racalculated = sum;
    end
    3'b001 :begin //ADDI
    operand1 = rb;
    operand2 = imm7extended;
    racalculated = sum;
    end
    3'b010 :begin //SUBI
    operand1 = rb;
    operand2 = immreadytosub;
    racalculated = sum;
    end
    3'b011 : begin // BEQ
    if (ra ==rb) begin
    operand1 = PCin+1;
    operand2 = imm7extended;
    PCout = sum;
    end
    end
    3'b100 : begin //JALR
    racalculated = PCin+1;
    PCout = rb;
    end
    3'b101 : begin //LUI
    racalculated = {imm10, 6'b000_000};
    end
    3'b110 : begin // SW
    operand1 =rb;
    operand2 = imm7extended;
    targetaddrinmem = {2'b01 , sum[13:0]};
    dataouttomem = ra;
    end
    3'b111 : begin //LW
    operand1 =rb;
    operand2 = imm7extended;
    targetaddrinmem = {2'b10 , sum[13:0]};
    racalculated = datainfrommem;
    end
    endcase
    end
    always @(posedge clk) begin
    //chose regs to store the results
    //BEQ and SW don't change any of the registers
    //The rest store the new data in raclculated
    if(instr[15:13] != 3'b011 && instr[15:13] != 3'b110 ) begin
    casez (instr[12:10])
    3'b000 :  reg0output = racalculated;
    3'b001 :  reg1output = racalculated;
    3'b010 :  reg2output = racalculated;
    3'b011 :  reg3output = racalculated;
    3'b100 :  reg4output = racalculated;
    3'b101 :  reg5output = racalculated;
    3'b110 :  reg6output = racalculated;
    3'b111 :  reg7output = racalculated;
    endcase
    end
    end
endmodule
