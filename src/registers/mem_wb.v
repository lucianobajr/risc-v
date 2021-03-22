module mem_wb(
        input wire clock, reset,    
        input	wire	[1:0]	control_wb_in,
        input	wire	[31:0]	read_data_in, alu_result_in,
        input	wire	[4:0]	write_reg_in,
        output	reg		regwrite, memtoreg, //1 bit wire
        output	reg	[31:0]	read_data, mem_alu_result,
        output	reg	[4:0]	mem_write_reg
    );

    initial begin
        regwrite <= 0;
        memtoreg <= 0;
        
        read_data <= 0;
        mem_alu_result <= 0;
        mem_write_reg <= 0;
        
        //finish this thread
    end

    always@(posedge clock) begin
        #1
        regwrite <= control_wb_in[1]; // refer to Lab 2-2 Figure 2.2
        memtoreg <= control_wb_in[0];
        
        read_data <= read_data_in;
        mem_alu_result <= alu_result_in;
        mem_write_reg <= write_reg_in;
    end

endmodule // mem_wb