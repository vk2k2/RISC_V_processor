`timescale 1ns / 1ps
//imm_src 4 => imm = 12{instr[31]},instr[19:12],instr[20],instr[30:21],{1'b0} (J type)
//imm_src 3 => imm = instr[31:12],{12'b0}                                     (U type)
//imm_src 2 => imm = 20{instr[31]},instr[7],instr[30:25],instr[11:8],{1'b0}   (B type)
//imm_src 1 => imm = 20{instr[31]},instr[31:25],instr[11:7]                   (S type)
//imm_src 0 => imm = 20{instr[31]},instr[31:20]                               (I type)

module sign_extendor(
    input [31:7] in,
    output reg [31:0] out,
    input [2:0] imm_src
    );
    always @*
        case (imm_src)
            'd0: out = {{20{in[31]}},in[31:20]};
            'd1: out = {{20{in[31]}},in[31:25],in[11:7]};
            'd2: out = {{20{in[31]}},in[7],in[30:25],in[11:8],1'b0};
            'd3: out = {in[31:12],12'b0};
            'd4: out = {{12{in[31]}},in[19:12],in[20],in[30:21],1'b0};
            default: out = 32'bx;
        endcase
endmodule
