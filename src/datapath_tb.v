`include "main.v"

module datapath_tb ();
    reg clock, reset;

    main Datapath(.clock(clock),.reset(reset));

	always begin
		clock = 1;#1;
		clock = 0;#1;
	end

	initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, datapath_tb);
        
        $display("Exibindo os resultados:");
       // $monitor("Instruction: %b\nExit PC: %b\nExit ALU: %b\n", );
		reset<=1; #3;
		reset<=0; #1;
	end
endmodule