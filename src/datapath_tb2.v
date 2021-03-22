`include "main2.v"

module datapath_tb ();
    reg clock, reset;

    //main2 Datapath(.clock(clock),.reset(reset), );

	always begin
		clock = 1; #1;
		clock = 0; #1;
	end

	initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, main2);
        
        //$display("Exibindo os resultados:");
        //$monitor("Instruction: %b\nExit PC: %b\nExit ALU: %b\n", );
		reset<=1; #3;
		reset<=0; #1;
	end
endmodule