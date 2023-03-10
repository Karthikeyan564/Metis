module lfsr_oneur_stochround (
	// Inputs
	input wire        clk,
	input wire        rst,
	input wire        en,
	input wire [14:0] rst_val,
	input wire [14:0] seed,
	input wire        prog,

	// Output
	output wire [6:0] out
);

	// Nodes definitions
	wire x0, x0a, x0b;
	wire x1, x1a, x1b;
	wire x2, x2a, x2b;
	wire x3, x3a, x3b;
	wire x4, x4a, x4b;
	wire x5, x5a, x5b;
	wire x6, x6a, x6b;
	wire y0;
	wire y1;
	wire y2;
	wire y3;
	wire y4;
	wire y5;
	wire y6;
	reg d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14;

	// Combinational and sequential logic definitions
	assign x0 = x0a ^ x0b;
	assign x1 = x1a ^ x1b;
	assign x2 = x2a ^ x2b;
	assign x3 = x3a ^ x3b;
	assign x4 = x4a ^ x4b;
	assign x5 = x5a ^ x5b;
	assign x6 = x6a ^ x6b;
	assign y1 = x0;
	assign y2 = x1;
	assign y3 = x2;
	assign y4 = x3;
	assign y5 = x4;
	assign y6 = x5;
	always @(posedge clk)
		if (rst)
			d0 <= rst_val[0];
		else if (prog)
			d0 <= seed[0];
		else if (en)
			d0 <= x6;
	assign y0 = d0;
	assign x0a = y0;
	always @(posedge clk)
		if (rst)
			d1 <= rst_val[1];
		else if (prog)
			d1 <= seed[1];
		else if (en)
			d1 <= d2;
	assign x0b = d1;
	always @(posedge clk)
		if (rst)
			d2 <= rst_val[2];
		else if (prog)
			d2 <= seed[2];
		else if (en)
			d2 <= y0;
	assign x1a = y1;
	always @(posedge clk)
		if (rst)
			d3 <= rst_val[3];
		else if (prog)
			d3 <= seed[3];
		else if (en)
			d3 <= d4;
	assign x1b = d3;
	always @(posedge clk)
		if (rst)
			d4 <= rst_val[4];
		else if (prog)
			d4 <= seed[4];
		else if (en)
			d4 <= y1;
	assign x2a = y2;
	always @(posedge clk)
		if (rst)
			d5 <= rst_val[5];
		else if (prog)
			d5 <= seed[5];
		else if (en)
			d5 <= d6;
	assign x2b = d5;
	always @(posedge clk)
		if (rst)
			d6 <= rst_val[6];
		else if (prog)
			d6 <= seed[6];
		else if (en)
			d6 <= y2;
	assign x3a = y3;
	always @(posedge clk)
		if (rst)
			d7 <= rst_val[7];
		else if (prog)
			d7 <= seed[7];
		else if (en)
			d7 <= d8;
	assign x3b = d7;
	always @(posedge clk)
		if (rst)
			d8 <= rst_val[8];
		else if (prog)
			d8 <= seed[8];
		else if (en)
			d8 <= y3;
	assign x4a = y4;
	always @(posedge clk)
		if (rst)
			d9 <= rst_val[9];
		else if (prog)
			d9 <= seed[9];
		else if (en)
			d9 <= d10;
	assign x4b = d9;
	always @(posedge clk)
		if (rst)
			d10 <= rst_val[10];
		else if (prog)
			d10 <= seed[10];
		else if (en)
			d10 <= y4;
	assign x5a = y5;
	always @(posedge clk)
		if (rst)
			d11 <= rst_val[11];
		else if (prog)
			d11 <= seed[11];
		else if (en)
			d11 <= d12;
	assign x5b = d11;
	always @(posedge clk)
		if (rst)
			d12 <= rst_val[12];
		else if (prog)
			d12 <= seed[12];
		else if (en)
			d12 <= y5;
	assign x6a = y6;
	always @(posedge clk)
		if (rst)
			d13 <= rst_val[13];
		else if (prog)
			d13 <= seed[13];
		else if (en)
			d13 <= d14;
	assign x6b = d13;
	always @(posedge clk)
		if (rst)
			d14 <= rst_val[14];
		else if (prog)
			d14 <= seed[14];
		else if (en)
			d14 <= y6;

	// Output assignment
	assign out = {y6,y5,y4,y3,y2,y1,y0};

endmodule
