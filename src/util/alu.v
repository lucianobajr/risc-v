module alu(alu_control,a,b,alu_out,zero);
    input [3:0] alu_control;
    input [31:0] a,b;
    output  reg [31:0] alu_out;
    output zero;
    assign zero = (alu_out == 0);

    always @(alu_control, a, b) begin
        case (alu_control)
            0: alu_out <= a & b;    // AND
            1: alu_out <= a | b;    // OR
            2: alu_out <= OUT(a, b);// ADD
            6: alu_out <= a - b;    // SUB
            7: alu_out <= (a < b) ? 1:0;
            12: alu_out <= ~( a | b );
            default: alu_out<=0;
        endcase
    end
        
    /* Function to signed operation*/
    function [31:0] OUT;
        input [31:0] a, b;
        begin
        case(b[31])
            1'b1:   begin
                b = ~b;
                b = b + 1'b1;
                OUT = a - b;
                end
            default: OUT = a + b;
        endcase
        end
    endfunction
endmodule