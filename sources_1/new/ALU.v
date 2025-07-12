`timescale 1ns / 1ps


module ALU(
    input [31:0] in1,
    input [31:0] in2,
    input [3:0] ALU_ctrl,
    output reg [31:0] ALU_out,
    output reg greater,
    output reg lesser,
    output reg equal,
    output reg greater_u,
    output reg lesser_u);
    
    
    
    always @*
    begin
    greater_u = in1>in2;
    lesser_u = in1<in2;
    equal = in1==in2;
    case({in1[31],in2[31]})
        'b00: lesser = in1<in2;
        'b01: lesser = 1'b0;
        'b10: lesser = 1'b1;
        'b11: lesser = in1<in2; 
    endcase 
    greater = ~(lesser|equal);
    
        case(ALU_ctrl)
            'h0: 
                ALU_out = in1+in2;
            'h1: 
                ALU_out = in1-in2;
            'h2: 
                ALU_out = in1<<in2[4:0];
            'h3:// signed comparision
                ALU_out = lesser;
//            case({in1[31],in2[31]})
//                'b00: ALU_out = in1<in2;
//                'b01: ALU_out = 1'b0;
//                'b10: ALU_out = 1'b1;
//                'b11: ALU_out = in1<in2; 
//            endcase  
            'h4: 
                ALU_out = lesser_u;  // unsign comparision
            'h5: 
                ALU_out = in1^in2;
            'h6: 
                ALU_out = in1>>in2[4:0];
            'h7: 
                ALU_out = $signed(in1)>>>in2[4:0];
            'h8: 
                ALU_out = in1|in2;
            'h9: 
                ALU_out = in1&in2;
            default:
                ALU_out = 'bx;
            endcase
        end
 endmodule
