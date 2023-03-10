module lfsr_noise_neur (
	// Inputs
	input wire        clk,
	input wire        rst,
	input wire        en,
	input wire [16:0] rst_val,
	input wire [16:0] seed,
	input wire        prog,

	// Output
	output wire [31:0] out
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
	wire x15, x15a, x15b;
	wire x16, x16a, x16b;
	wire x17, x17a, x17b;
	wire x18, x18a, x18b;
	wire x19, x19a, x19b;
	wire x20, x20a, x20b;
	wire x21, x21a, x21b;
	wire x22, x22a, x22b;
	wire x23, x23a, x23b;
	wire x24, x24a, x24b;
	wire x25, x25a, x25b;
	wire x26, x26a, x26b;
	wire x27, x27a, x27b;
	wire x28, x28a, x28b;
	wire x29, x29a, x29b;
	wire x30, x30a, x30b;
	wire x31, x31a, x31b;
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
	wire y15;
	wire y16;
	wire y17;
	wire y18;
	wire y19;
	wire y20;
	wire y21;
	wire y22;
	wire y23;
	wire y24;
	wire y25;
	wire y26;
	wire y27;
	wire y28;
	wire y29;
	wire y30;
	wire y31;
	reg d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16;

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
	assign x15 = x15a ^ x15b;
	assign x16 = x16a ^ x16b;
	assign x17 = x17a ^ x17b;
	assign x18 = x18a ^ x18b;
	assign x19 = x19a ^ x19b;
	assign x20 = x20a ^ x20b;
	assign x21 = x21a ^ x21b;
	assign x22 = x22a ^ x22b;
	assign x23 = x23a ^ x23b;
	assign x24 = x24a ^ x24b;
	assign x25 = x25a ^ x25b;
	assign x26 = x26a ^ x26b;
	assign x27 = x27a ^ x27b;
	assign x28 = x28a ^ x28b;
	assign x29 = x29a ^ x29b;
	assign x30 = x30a ^ x30b;
	assign x31 = x31a ^ x31b;
	assign y3 = x0;
	assign y4 = x1;
	assign y5 = x2;
	assign y6 = x3;
	assign y7 = x4;
	assign y8 = x5;
	assign y9 = x6;
	assign y10 = x7;
	assign y11 = x8;
	assign y12 = x9;
	assign y13 = x10;
	assign y14 = x11;
	assign y15 = x12;
	assign y16 = x13;
	assign y17 = x14;
	assign y18 = x15;
	assign y19 = x16;
	assign y20 = x17;
	assign y21 = x18;
	assign y22 = x19;
	assign y23 = x20;
	assign y24 = x21;
	assign y25 = x22;
	assign y26 = x23;
	assign y27 = x24;
	assign y28 = x25;
	assign y29 = x26;
	assign y30 = x27;
	assign y31 = x28;
	always @(posedge clk)
		if (rst)
			d0 <= rst_val[0];
		else if (prog)
			d0 <= seed[0];
		else if (en)
			d0 <= x29;
	assign y0 = d0;
	always @(posedge clk)
		if (rst)
			d1 <= rst_val[1];
		else if (prog)
			d1 <= seed[1];
		else if (en)
			d1 <= x30;
	assign y1 = d1;
	always @(posedge clk)
		if (rst)
			d2 <= rst_val[2];
		else if (prog)
			d2 <= seed[2];
		else if (en)
			d2 <= x31;
	assign y2 = d2;
	assign x0a = y0;
	assign x14a = y0;
	assign x1a = y1;
	assign x15a = y1;
	assign x2a = y2;
	assign x16a = y2;
	assign x3a = y3;
	assign x17a = y3;
	assign x4a = y4;
	assign x18a = y4;
	assign x5a = y5;
	assign x19a = y5;
	assign x6a = y6;
	assign x20a = y6;
	assign x7a = y7;
	assign x21a = y7;
	assign x8a = y8;
	assign x22a = y8;
	assign x9a = y9;
	assign x23a = y9;
	assign x10a = y10;
	assign x24a = y10;
	assign x11a = y11;
	assign x25a = y11;
	assign x12a = y12;
	assign x26a = y12;
	assign x13a = y13;
	assign x27a = y13;
	assign x14b = y14;
	assign x28a = y14;
	assign x15b = y15;
	assign x29a = y15;
	assign x16b = y16;
	assign x30a = y16;
	assign x17b = y17;
	assign x31a = y17;
	assign x18b = y18;
	always @(posedge clk)
		if (rst)
			d3 <= rst_val[3];
		else if (prog)
			d3 <= seed[3];
		else if (en)
			d3 <= y18;
	assign x0b = d3;
	assign x19b = y19;
	always @(posedge clk)
		if (rst)
			d4 <= rst_val[4];
		else if (prog)
			d4 <= seed[4];
		else if (en)
			d4 <= y19;
	assign x1b = d4;
	assign x20b = y20;
	always @(posedge clk)
		if (rst)
			d5 <= rst_val[5];
		else if (prog)
			d5 <= seed[5];
		else if (en)
			d5 <= y20;
	assign x2b = d5;
	assign x21b = y21;
	always @(posedge clk)
		if (rst)
			d6 <= rst_val[6];
		else if (prog)
			d6 <= seed[6];
		else if (en)
			d6 <= y21;
	assign x3b = d6;
	assign x22b = y22;
	always @(posedge clk)
		if (rst)
			d7 <= rst_val[7];
		else if (prog)
			d7 <= seed[7];
		else if (en)
			d7 <= y22;
	assign x4b = d7;
	assign x23b = y23;
	always @(posedge clk)
		if (rst)
			d8 <= rst_val[8];
		else if (prog)
			d8 <= seed[8];
		else if (en)
			d8 <= y23;
	assign x5b = d8;
	assign x24b = y24;
	always @(posedge clk)
		if (rst)
			d9 <= rst_val[9];
		else if (prog)
			d9 <= seed[9];
		else if (en)
			d9 <= y24;
	assign x6b = d9;
	assign x25b = y25;
	always @(posedge clk)
		if (rst)
			d10 <= rst_val[10];
		else if (prog)
			d10 <= seed[10];
		else if (en)
			d10 <= y25;
	assign x7b = d10;
	assign x26b = y26;
	always @(posedge clk)
		if (rst)
			d11 <= rst_val[11];
		else if (prog)
			d11 <= seed[11];
		else if (en)
			d11 <= y26;
	assign x8b = d11;
	assign x27b = y27;
	always @(posedge clk)
		if (rst)
			d12 <= rst_val[12];
		else if (prog)
			d12 <= seed[12];
		else if (en)
			d12 <= y27;
	assign x9b = d12;
	assign x28b = y28;
	always @(posedge clk)
		if (rst)
			d13 <= rst_val[13];
		else if (prog)
			d13 <= seed[13];
		else if (en)
			d13 <= y28;
	assign x10b = d13;
	assign x29b = y29;
	always @(posedge clk)
		if (rst)
			d14 <= rst_val[14];
		else if (prog)
			d14 <= seed[14];
		else if (en)
			d14 <= y29;
	assign x11b = d14;
	assign x30b = y30;
	always @(posedge clk)
		if (rst)
			d15 <= rst_val[15];
		else if (prog)
			d15 <= seed[15];
		else if (en)
			d15 <= y30;
	assign x12b = d15;
	assign x31b = y31;
	always @(posedge clk)
		if (rst)
			d16 <= rst_val[16];
		else if (prog)
			d16 <= seed[16];
		else if (en)
			d16 <= y31;
	assign x13b = d16;

	// Output assignment
	assign out = {y31,y30,y29,y28,y27,y26,y25,y24,y23,y22,y21,y20,y19,y18,y17,y16,y15,y14,y13,y12,y11,y10,y9,y8,y7,y6,y5,y4,y3,y2,y1,y0};

endmodule
