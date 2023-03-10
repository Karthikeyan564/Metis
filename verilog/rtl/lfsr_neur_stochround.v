module lfsr_neur_stochround (
	// Inputs
	input wire        clk,
	input wire        rst,
	input wire        en,
	input wire [14:0] rst_val,
	input wire [14:0] seed,
	input wire        prog,

	// Output
	output wire [14:0] out
);

	// Nodes definitions
	wire x0, x0a, x0b;
	wire x1, x1a, x1b;
	wire x2, x2a, x2b;
	wire x3, x3a, x3b;
	wire x4, x4a, x4b;
	wire x5, x5a, x5b;
	wire x6, x6a, x6b;
	wire x7, x7a, x7b;
	wire x8, x8a, x8b;
	wire x9, x9a, x9b;
	wire x10, x10a, x10b;
	wire x11, x11a, x11b;
	wire x12, x12a, x12b;
	wire x13, x13a, x13b;
	wire x14, x14a, x14b;
	wire y0;
	wire y1;
	wire y2;
	wire y3;
	wire y4;
	wire y5;
	wire y6;
	wire y7;
	wire y8;
	wire y9;
	wire y10;
	wire y11;
	wire y12;
	wire y13;
	wire y14;
	reg d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14;

	// Combinational and sequential logic definitions
	assign x0 = x0a ^ x0b;
	assign x1 = x1a ^ x1b;
	assign x2 = x2a ^ x2b;
	assign x3 = x3a ^ x3b;
	assign x4 = x4a ^ x4b;
	assign x5 = x5a ^ x5b;
	assign x6 = x6a ^ x6b;
	assign x7 = x7a ^ x7b;
	assign x8 = x8a ^ x8b;
	assign x9 = x9a ^ x9b;
	assign x10 = x10a ^ x10b;
	assign x11 = x11a ^ x11b;
	assign x12 = x12a ^ x12b;
	assign x13 = x13a ^ x13b;
	assign x14 = x14a ^ x14b;
	assign y1 = x0;
	assign y2 = x1;
	assign y3 = x2;
	assign y4 = x3;
	assign y5 = x4;
	assign y6 = x5;
	assign y7 = x6;
	assign y8 = x7;
	assign y9 = x8;
	assign y10 = x9;
	assign y11 = x10;
	assign y12 = x11;
	assign y13 = x12;
	assign y14 = x13;
	always @(posedge clk)
		if (rst)
			d0 <= rst_val[0];
		else if (prog)
			d0 <= seed[0];
		else if (en)
			d0 <= x14;
	assign y0 = d0;
	assign x0a = y0;
	assign x14a = y0;
	assign x1a = y1;
	always @(posedge clk)
		if (rst)
			d1 <= rst_val[1];
		else if (prog)
			d1 <= seed[1];
		else if (en)
			d1 <= y1;
	assign x0b = d1;
	assign x2a = y2;
	always @(posedge clk)
		if (rst)
			d2 <= rst_val[2];
		else if (prog)
			d2 <= seed[2];
		else if (en)
			d2 <= y2;
	assign x1b = d2;
	assign x3a = y3;
	always @(posedge clk)
		if (rst)
			d3 <= rst_val[3];
		else if (prog)
			d3 <= seed[3];
		else if (en)
			d3 <= y3;
	assign x2b = d3;
	assign x4a = y4;
	always @(posedge clk)
		if (rst)
			d4 <= rst_val[4];
		else if (prog)
			d4 <= seed[4];
		else if (en)
			d4 <= y4;
	assign x3b = d4;
	assign x5a = y5;
	always @(posedge clk)
		if (rst)
			d5 <= rst_val[5];
		else if (prog)
			d5 <= seed[5];
		else if (en)
			d5 <= y5;
	assign x4b = d5;
	assign x6a = y6;
	always @(posedge clk)
		if (rst)
			d6 <= rst_val[6];
		else if (prog)
			d6 <= seed[6];
		else if (en)
			d6 <= y6;
	assign x5b = d6;
	assign x7a = y7;
	always @(posedge clk)
		if (rst)
			d7 <= rst_val[7];
		else if (prog)
			d7 <= seed[7];
		else if (en)
			d7 <= y7;
	assign x6b = d7;
	assign x8a = y8;
	always @(posedge clk)
		if (rst)
			d8 <= rst_val[8];
		else if (prog)
			d8 <= seed[8];
		else if (en)
			d8 <= y8;
	assign x7b = d8;
	assign x9a = y9;
	always @(posedge clk)
		if (rst)
			d9 <= rst_val[9];
		else if (prog)
			d9 <= seed[9];
		else if (en)
			d9 <= y9;
	assign x8b = d9;
	assign x10a = y10;
	always @(posedge clk)
		if (rst)
			d10 <= rst_val[10];
		else if (prog)
			d10 <= seed[10];
		else if (en)
			d10 <= y10;
	assign x9b = d10;
	assign x11a = y11;
	always @(posedge clk)
		if (rst)
			d11 <= rst_val[11];
		else if (prog)
			d11 <= seed[11];
		else if (en)
			d11 <= y11;
	assign x10b = d11;
	assign x12a = y12;
	always @(posedge clk)
		if (rst)
			d12 <= rst_val[12];
		else if (prog)
			d12 <= seed[12];
		else if (en)
			d12 <= y12;
	assign x11b = d12;
	assign x13a = y13;
	always @(posedge clk)
		if (rst)
			d13 <= rst_val[13];
		else if (prog)
			d13 <= seed[13];
		else if (en)
			d13 <= y13;
	assign x12b = d13;
	assign x14b = y14;
	always @(posedge clk)
		if (rst)
			d14 <= rst_val[14];
		else if (prog)
			d14 <= seed[14];
		else if (en)
			d14 <= y14;
	assign x13b = d14;

	// Output assignment
	assign out = {y14,y13,y12,y11,y10,y9,y8,y7,y6,y5,y4,y3,y2,y1,y0};

endmodule
