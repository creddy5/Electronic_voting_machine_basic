`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 19:59:45
// Design Name: 
// Module Name: electronic_voting_machine
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


module electronic_voting_machine(
    input CLEAR,CLK,P1,P2,P3,P4,P5,NOTA,
    output reg [9:0] P1_VOTES,P2_VOTES,P3_VOTES,P4_VOTES,P5_VOTES,NOTA_VOTES
    );
    
    always @(posedge CLK or posedge CLEAR)
    begin
    if(CLEAR)
    begin
    P1_VOTES <=0;
    P2_VOTES <=0;
    P3_VOTES <=0;
    P4_VOTES <=0;
    P5_VOTES <=0;
    NOTA_VOTES =0;
    end
    else
    begin
    if(P1) P1_VOTES<=P1_VOTES+1;
    else if(P2) P2_VOTES<=P2_VOTES+1;
    else if(P3) P3_VOTES<=P3_VOTES+1;
    else if(P4) P4_VOTES<=P4_VOTES+1;
    else if(P5) P5_VOTES<=P5_VOTES+1;
    else if(NOTA) NOTA_VOTES<=NOTA_VOTES+1;  
    end
    end
    
endmodule
