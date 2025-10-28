# Electronic_voting_machine_basic

This project implements a digital Electronic Voting Machine (EVM) using Verilog HDL.

The design allows five candidates (P1–P5) and one NOTA (None Of The Above) option.

Each button press represents a vote, and the system counts and stores the total votes for every candidate.

The module can be reset at any time using a CLEAR signal, resetting all vote counts to zero.

=====================================================================================================================

Working Principle:

On each rising edge of the clock, if a candidate button is pressed, their corresponding vote counter increments by 1.

When the CLEAR signal is high, all counters reset to zero.

The design ensures that only one input is active at a time, preventing double-counting

=====================================================================================================================

Expandability:

This design is modular and can be easily extended:

Add more candidates by extending input/output ports and modifying the always block.

Integrate display units (e.g., 7-segment or LCD) to show vote counts.

Add debouncing or security features for FPGA/ASIC implementation.
