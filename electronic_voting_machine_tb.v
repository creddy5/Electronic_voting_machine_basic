`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 21:25:56
// Design Name: 
// Module Name: electronic_voting_machine_tb
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


module electronic_voting_machine_tb;
// Inputs
    reg CLEAR;
    reg CLK;
    reg P1, P2, P3, P4, P5, NOTA;

    // Outputs
    wire [9:0] P1_VOTES, P2_VOTES, P3_VOTES, P4_VOTES, P5_VOTES, NOTA_VOTES;

    // Instantiate the Unit Under Test (UUT)
    electronic_voting_machine uut (
        .CLEAR(CLEAR),
        .CLK(CLK),
        .P1(P1),
        .P2(P2),
        .P3(P3),
        .P4(P4),
        .P5(P5),
        .NOTA(NOTA),
        .P1_VOTES(P1_VOTES),
        .P2_VOTES(P2_VOTES),
        .P3_VOTES(P3_VOTES),
        .P4_VOTES(P4_VOTES),
        .P5_VOTES(P5_VOTES),
        .NOTA_VOTES(NOTA_VOTES)
    );

    // Clock generation: 10ns period
    initial CLK = 0;
    always #5 CLK = ~CLK;

    // Task for simulating a button press
    task press_button;
        input integer btn;
        begin
            // Reset all buttons
            {P1,P2,P3,P4,P5,NOTA} = 6'b000000;
            // Press selected button
            case (btn)
                0: P1 = 1;
                1: P2 = 1;
                2: P3 = 1;
                3: P4 = 1;
                4: P5 = 1;
                5: NOTA = 1;
            endcase
            #10; // Hold for one clock cycle
            {P1,P2,P3,P4,P5,NOTA} = 6'b000000; // Release
            #10;
        end
    endtask

    // Main Test Sequence
    initial begin
        $display("===========================================");
        $display("        ELECTRONIC VOTING MACHINE TEST      ");
        $display("===========================================");

        // Initialize signals
        CLEAR = 1;
        {P1,P2,P3,P4,P5,NOTA} = 6'b000000;
        #10;
        CLEAR = 0;

        $display("\n---- Test 1: Individual Votes ----");
        press_button(0); // P1
        press_button(1); // P2
        press_button(2); // P3
        press_button(3); // P4
        press_button(4); // P5
        press_button(5); // NOTA

        #20;
        $display("After one vote each:");
        $display("P1=%d, P2=%d, P3=%d, P4=%d, P5=%d, NOTA=%d", 
                 P1_VOTES, P2_VOTES, P3_VOTES, P4_VOTES, P5_VOTES, NOTA_VOTES);

        $display("\n---- Test 2: Multiple Votes for Some ----");
        press_button(0); press_button(0); // P1 x2
        press_button(2); press_button(2); press_button(2); // P3 x3
        press_button(4); // P5 x1
        #20;

        $display("After multiple votes:");
        $display("P1=%d, P2=%d, P3=%d, P4=%d, P5=%d, NOTA=%d", 
                 P1_VOTES, P2_VOTES, P3_VOTES, P4_VOTES, P5_VOTES, NOTA_VOTES);

        $display("\n---- Test 3: Mixed Voting Pattern ----");
        press_button(1); press_button(3);
        press_button(5); press_button(0);
        press_button(1); press_button(4);
        #20;

        $display("After mixed pattern:");
        $display("P1=%d, P2=%d, P3=%d, P4=%d, P5=%d, NOTA=%d", 
                 P1_VOTES, P2_VOTES, P3_VOTES, P4_VOTES, P5_VOTES, NOTA_VOTES);

        $display("\n---- Test 4: CLEAR Reset Check ----");
        CLEAR = 1; #10; CLEAR = 0; #10;

        $display("After CLEAR:");
        $display("P1=%d, P2=%d, P3=%d, P4=%d, P5=%d, NOTA=%d", 
                 P1_VOTES, P2_VOTES, P3_VOTES, P4_VOTES, P5_VOTES, NOTA_VOTES);

        $display("\n---- Test 5: Voting After Reset ----");
        press_button(2);
        press_button(3);
        press_button(5);
        #20;

        $display("After new votes:");
        $display("P1=%d, P2=%d, P3=%d, P4=%d, P5=%d, NOTA=%d", 
                 P1_VOTES, P2_VOTES, P3_VOTES, P4_VOTES, P5_VOTES, NOTA_VOTES);

        $display("\n===========================================");
        $display("           TEST COMPLETED SUCCESSFULLY      ");
        $display("===========================================");

        #20;
        $stop;
    end
endmodule
