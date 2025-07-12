`timescale 1ns / 1ps


module controller(
    input [6:0] opcode,
    input [2:0] func3,
    input [6:0] func7,
    input greater_flag,
    input lesser_flag,
    input equal_flag,
    input greater_u_flag,
    input lesser_u_flag,
    output reg pc_src,
    output reg if_jalr,
    output reg reg_wr_en,
    output reg [2:0] result_src, // 0 for alu, 1 for PC, 2 for mem, 3 for extendor, 4 for auipc
    output reg [2:0] immediate_src, 
    output reg alu_src, // reg (0) or immediate (1)
    output reg [3:0] alu_ctrl,
    output reg mem_rd_en,
    output reg mem_wr_en,
    output reg [2:0] mem_rd_type,
    output reg [1:0] mem_wr_type
    ); 
    
    always @*
    begin 
    case (opcode)
        'd51: begin
              pc_src = 'b0; 
              if_jalr = 'b0; 
              reg_wr_en = 'd1;
              result_src = 'd0;
              immediate_src = 'bx; 
              alu_src = 'd0; 
              mem_rd_en = 'd0; 
              mem_wr_en = 'd0; 
              mem_rd_type = 'bx; 
              mem_wr_type = 'bx;
              case (func3)
                'd0: case (func7)
                        'd0: alu_ctrl = 'd0;
                        'd32: alu_ctrl = 'd1;
                        default: alu_ctrl = 'bx;
                     endcase
                'd1: alu_ctrl = 'd2;
                'd2: alu_ctrl = 'd3;
                'd3: alu_ctrl = 'd4;
                'd4: alu_ctrl = 'd5;
                'd5: case (func7)
                        'd0: alu_ctrl = 'd6;
                        'd32: alu_ctrl = 'd7;
                        default: alu_ctrl = 'bx;
                     endcase
                'd6: alu_ctrl = 'd8;
                'd7: alu_ctrl = 'd9;
              endcase
              end
        'd19: begin
              pc_src = 'b0; 
              if_jalr = 'b0; 
              reg_wr_en = 'd1;
              result_src = 'd0;
              immediate_src = 'd0; 
              alu_src = 'b1; 
              mem_rd_en = 'd0; 
              mem_wr_en = 'd0; 
              mem_rd_type = 'bx; 
              mem_wr_type = 'bx;
            case (func3)
                'd0: alu_ctrl = 'd0;
                'd1: alu_ctrl = 'd2;
                'd2: alu_ctrl = 'd3;
                'd3: alu_ctrl = 'd4;
                'd4: alu_ctrl = 'd5;
                'd5: case (func7)
                        'd0: alu_ctrl = 'd6;
                        'd32: alu_ctrl = 'd7;
                        default: alu_ctrl = 'bx;
                     endcase
                'd6: alu_ctrl = 'd8;
                'd7: alu_ctrl = 'd9;
                endcase
              end
        'd03: begin
              pc_src = 'b0; 
              if_jalr = 'b0; 
              reg_wr_en = 'd1;
              result_src = 'd2;
              immediate_src = 'd0; 
              alu_src = 'd1; 
              alu_ctrl = 'd0;
              mem_rd_en = 'd1; 
              mem_wr_en = 'd0; 
              mem_wr_type = 'bx;
              case(func3)
                      'd0: mem_rd_type = 'd0;
                      'd1: mem_rd_type = 'd1;
                      'd2: mem_rd_type = 'd2;
                      'd4: mem_rd_type = 'd4;
                      'd5: mem_rd_type = 'd5;
                      default: mem_rd_type = 3'bx;
                  endcase              
              end
        'd35: begin
              pc_src = 'b0; 
              if_jalr = 'b0; 
              reg_wr_en = 'd0;
              result_src = 'bx;
              immediate_src = 'd1; 
              alu_src = 'd1; 
              alu_ctrl = 'd0;
              mem_rd_en = 'd0; 
              mem_wr_en = 'd1; 
              mem_rd_type = 'bx;
              case(func3)
                      'd0: mem_wr_type = 'd0;
                      'd1: mem_wr_type = 'd1;
                      'd2: mem_wr_type = 'd2;
                      default: mem_wr_type = 2'bx;
                  endcase              
              end
        'd99: begin
              case(func3)
                      'd0: if (equal_flag) 
                            pc_src = 'b1; //PC_add
                           else
                            pc_src = 'b0; //PC+4
                      'd1: if (~equal_flag) 
                            pc_src = 'b1; //PC_add
                           else
                            pc_src = 'b0; //PC+4
                      'd4: if (lesser_flag) 
                            pc_src = 'b1; //PC_add
                           else
                            pc_src = 'b0; //PC+4
                      'd5: if (greater_flag|equal_flag) 
                            pc_src = 'b1; //PC_add
                           else
                            pc_src = 'b0; //PC+4
                      'd6: if (lesser_u_flag) 
                            pc_src = 'b1; //PC_add
                           else
                            pc_src = 'b0; //PC+4
                      'd7: if (greater_u_flag|equal_flag) 
                            pc_src = 'b1; //PC_add
                           else
                            pc_src = 'b0; //PC+4
                      default: pc_src = 'bx; //PC+4
                  endcase 
              if_jalr = 'b0; 
              reg_wr_en = 'd0;
              result_src = 'bx;
              immediate_src = 'd2; 
              alu_src = 'd0; 
              alu_ctrl = 'bx;
              mem_rd_en = 'd0; 
              mem_wr_en = 'd0; 
              mem_rd_type = 'bx;
              mem_wr_type = 'bx;             
              end
        'd111: begin  //jal
        pc_src = 'b1; 
        if_jalr = 'b0; 
        reg_wr_en = 'b1;  
        result_src = 'd1; 
        immediate_src = 'd4; 
        alu_src = 'bx; 
        alu_ctrl = 'bx; 
        mem_rd_en = 'b0; 
        mem_wr_en = 'b0; 
        mem_rd_type = 'bx; 
        mem_wr_type = 'bx; 
        end
        'd103: begin  //jalr
        pc_src = 'b1; 
        if_jalr = 'b1; 
        reg_wr_en = 'b1;  
        result_src = 'd1; 
        immediate_src = 'b0; 
        alu_src = 'bx; 
        alu_ctrl = 'bx; 
        mem_rd_en = 'b0; 
        mem_wr_en = 'b0; 
        mem_rd_type = 'bx; 
        mem_wr_type = 'bx; 
        end
        'd55: begin  //lui
        pc_src = 'b0; 
        if_jalr = 'b0; 
        reg_wr_en = 'b1;  
        result_src = 'd3; 
        immediate_src = 'd3; 
        alu_src = 'bx; 
        alu_ctrl = 'bx; 
        mem_rd_en = 'b0; 
        mem_wr_en = 'b0; 
        mem_rd_type = 'bx; 
        mem_wr_type = 'bx; 
        end
        'd23: begin  //auipc
        pc_src = 'b0; 
        if_jalr = 'b0; 
        reg_wr_en = 'b1;  
        result_src = 'd4; 
        immediate_src = 'd3; 
        alu_src = 'bx; 
        alu_ctrl = 'bx; 
        mem_rd_en = 'b0; 
        mem_wr_en = 'b0; 
        mem_rd_type = 'bx; 
        mem_wr_type = 'bx; 
        end
        default: begin //all signals x 
        pc_src = 'bx; 
        if_jalr = 'bx; 
        reg_wr_en = 'b0;  
        result_src = 'bx; 
        immediate_src = 'bx; 
        alu_src = 'bx; 
        alu_ctrl = 'bx; 
        mem_rd_en = 'b0; 
        mem_wr_en = 'b0; 
        mem_rd_type = 'bx; 
        mem_wr_type = 'bx; 
        end
    endcase
    end    
endmodule
