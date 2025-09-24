`timescale 1ns / 1ps

module Memory#( parameter MEM_FILE = "",
                parameter SIZE = 1024)(
    input clk,
    input [15:0] instaddr,  //the address we want to read its content as instruction
    input [15:0] dataaddr,  //(sometimes reduntant) as first 2 bits are the read and write flags and the rest is the address we want to read its content as data . 
    //13 bits for adresses means we can call 8192 words , each word as 2 bytes. (way over our memory size anyway)
    input [15:0] datawrite, // the data we want to write in memory (sometimes reduntant)
    output reg [15:0] instdata, // the instruction we get from memory
    output reg [15:0] dataread  // the data we get from memory (sometimes reduntant)
    );
    reg [15:0] MEM [0:SIZE-1]; // 1024 2-bytes words = 2 KB of RAM in total
    //initialiye the givn size with 0s
    integer i;
    initial begin
    for (i=0; i<SIZE; i=i+1) begin
        MEM[i] = 'h0;
    end
    //if the memory file is found , store its content.
    if (MEM_FILE!=0) begin
        $readmemb(MEM_FILE,MEM);
    end 

    end
    
    always @(*) begin
    //the memory outputs the instruction at the requested instruction address all the times continously and is always updated
    instdata = MEM[instaddr];
    //once the read flag is raised the memory sends the data at the requested location to dataread register
    //if not raised then the dataread contains the last read data (redundant)
    if(dataaddr[15])
    dataread= MEM[dataaddr[13:0]];
    end
    //once the write flag is raised the memory sends the data in datawrite to the meant location
    //if not raised then the datawrite contains the last written data (redundant) and the address wont be changed
    //if(dataaddr[14]) 
    always @(posedge clk) begin 
    if(dataaddr[14])
    MEM[dataaddr[13:0]] = datawrite;
    end
endmodule
