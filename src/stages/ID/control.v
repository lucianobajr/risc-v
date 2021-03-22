module control (
    opcode,
    ex,
    m,
    wb
);

    input wire [5:0] opcode;
    output reg [3:0] ex;
    output reg [2:0] m;
    output reg [1:0] wb;

    parameter rtype = 6'b000000;
    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter beq = 6'b000100;
    parameter nop = 6'b100000;

    initial begin
        ex <= 0;
        m <= 0;
        wb <= 0;
    end
    
    always@* begin
		case (opcode)
			rtype: begin
				ex <= 4'b1100; /* Note use of non-blocking  operator ( <= ) versus blocking  operator( = ) */
				m  <= 3'b000; 
				wb <= 2'b10;
			end
			/* Assign remaining values according to chart in Lab Manuel.
		     Either paramterize it, or hardcode at as is done for RTYPE.
		  */
			lw: begin
				ex <= 4'b0001; 
				m  <= 3'b010; 
				wb <= 2'b11;
			end
			sw: begin
				ex <= 4'b0001;  //why not 4'bZ001
				m  <= 3'b001;
				wb <= 2'b0Z;	
			end
			beq: begin
				ex <= 4'b0010;	// why not 4'bZ010
				m  <= 3'b100;
				wb <= 2'b0Z;	
			end
			
			nop: begin   //Not in Lab Manual, but needed to make life easier for final implementation
				ex <={4{1'b0}};  //replicating operator 
				m  <={3{1'b0}}; 
				wb <={2{1'b0}};
			end
			default:	$display ("Opcode nao reconhecido.");
		endcase
	end
    
endmodule