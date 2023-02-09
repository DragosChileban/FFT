module fft(
  input clk,
  input signed [7:0] a_re, b_re, c_re, d_re, e_re, f_re, g_re, h_re,
  input signed [7:0] a_im, b_im, c_im, d_im, e_im, f_im, g_im, h_im,
  output reg signed [7:0] fft_b_re, fft_c_re, fft_d_re, fft_e_re, fft_f_re, fft_g_re, fft_h_re, fft_a_re,
  output reg signed [7:0] fft_a_im, fft_b_im, fft_c_im, fft_d_im, fft_e_im, fft_f_im, fft_g_im, fft_h_im
);
 
  reg signed [7:0] re[0:7], im[7:0];
  reg [3:0] i,j,k;
  reg signed [7:0] temp_real, temp_imag, temp_real2, temp_imag2;
 
  always @(posedge clk) begin
 
 
    re[0] = a_re; re[1] = b_re; re[2] = c_re; re[3] = d_re; re[4] = e_re; re[5] = f_re; re[6] = g_re; re[7] = h_re; 
    im[0] = a_im; im[1] = b_im; im[2] = c_im; im[3] = d_im; im[4] = e_im; im[5] = f_im; im[6] = g_im; im[7] = h_im;  
    // Stage 1 
    for(i = 0; i < 4; i = i + 1) begin
        temp_real = re[i] + re[i+4];
        temp_imag = im[i] + im[i+4];
        temp_real2 = re[i] - re[i+4];
        temp_imag2= im[i] - im[i+4];
        re[i] = temp_real;
        im[i] = temp_imag;
        re[i+4] = temp_real2;
        im[i+4] = temp_imag2;
    end
 
    // Stage 2
    for(i = 0; i < 2; i = i + 1) begin
        temp_real = re[i] + re[i+2];
        temp_imag = im[i] + im[i+2];
        temp_real2 = re[i] - re[i+2];
        temp_imag2 = im[i] - im[i+2];
        re[i] = temp_real;
        im[i] = temp_imag;
        re[i+2] = temp_real2;
        im[i+2] = temp_imag2;
    end
 
    for(i = 4; i < 6; i = i + 1) begin
        temp_real = re[i] + im[i+2];
        temp_imag = im[i] - re[i+2];
        temp_real2 = re[i] - im[i+2];
        temp_imag2 = im[i] + re[i+2];
        re[i] = temp_real;
        im[i] = temp_imag;
        re[i+2] = temp_real2;
        im[i+2] = temp_imag2;
    end
 
    // Stage 3
    temp_real = re[0] + re[1];
    temp_imag = im[0] + im[1];
    temp_real2 = re[0] - re[1];
    temp_imag2 = im[0] - im[1];
    re[0] = temp_real;
    im[0] = temp_imag;
    re[1] = temp_real2;
    im[1] = temp_imag2;
 
    temp_real = re[2] + im[3];
    temp_imag = im[2] - re[3];
    temp_real2 = re[2] - im[3];
    temp_imag2 = im[2] + re[3];
    re[2] = temp_real;
    im[2] = temp_imag;
    re[3] = temp_real2;
    im[3] = temp_imag2;
 
    temp_real = re[4] + 0.707*re[5] + 0.707*im[5];
    temp_imag = im[4] + 0.707*im[5] - 0.707*re[5];
    temp_real2 = re[4] - 0.707*re[5] - 0.707*im[5];
    temp_imag2 = im[4] - 0.707*im[5] + 0.707*re[5];
    re[4] = temp_real;
    im[4] = temp_imag;
    re[5] = temp_real2;
    im[5] = temp_imag2;
 
    temp_real = re[6] - 0.707*re[7] + 0.707*im[7];
    temp_imag = im[6] - 0.707*im[7] - 0.707*re[7];
    temp_real2 = re[6] + 0.707*re[7] - 0.707*im[7];
    temp_imag2 = im[6] + 0.707*im[7] + 0.707*re[7];
    re[6] = temp_real;
    im[6] = temp_imag;
    re[7] = temp_real2;
    im[7] = temp_imag2;
 
    fft_a_re = re[0]; fft_b_re = re[4]; fft_c_re = re[2]; fft_d_re = re[6]; fft_e_re = re[1]; fft_f_re = re[5]; fft_g_re = re[3]; fft_h_re = re[7]; 
    fft_a_im = im[0]; fft_b_im = im[4]; fft_c_im = im[2]; fft_d_im = im[6]; fft_e_im = im[1]; fft_f_im = im[5]; fft_g_im = im[3]; fft_h_im = im[7];
end
endmodule
 
module fft_tb;
	reg clk;
	reg signed [7:0] a_re, b_re, c_re, d_re, e_re, f_re, g_re, h_re, a_im, b_im, c_im, d_im, e_im, f_im, g_im, h_im;
	wire signed [7:0] fft_a_re, fft_b_re, fft_c_re, fft_d_re, fft_e_re, fft_f_re, fft_g_re, fft_h_re, fft_a_im, fft_b_im, fft_c_im, fft_d_im, fft_e_im, fft_f_im, fft_g_im, fft_h_im;
 
	fft fft_i (.clk(clk), .a_re(a_re), .b_re(b_re), .c_re(c_re), .d_re(d_re), .e_re(e_re), .f_re(f_re), .g_re(g_re), .h_re(h_re), .a_im(a_im), .b_im(b_im), .c_im(c_im), .d_im(d_im), .e_im(e_im), .f_im(f_im), .g_im(g_im), .h_im(h_im), .fft_a_re(fft_a_re), .fft_b_re(fft_b_re), .fft_c_re(fft_c_re), .fft_d_re(fft_d_re), .fft_e_re(fft_e_re), .fft_f_re(fft_f_re), .fft_g_re(fft_g_re), .fft_h_re(fft_h_re), .fft_a_im(fft_a_im), .fft_b_im(fft_b_im), .fft_c_im(fft_c_im), .fft_d_im(fft_d_im), .fft_e_im(fft_e_im), .fft_f_im(fft_f_im), .fft_g_im(fft_g_im), .fft_h_im(fft_h_im));
	integer k;
	initial begin
 
		clk = 0;
		a_re = 5; b_re = 4; c_re = -3; d_re = 19; e_re = 9; f_re = 12; g_re = 11; h_re = -12;
		a_im = 2; b_im = 7; c_im = -20; d_im = 7; e_im = -1; f_im = 40; g_im = 1; h_im = 0; 
		#10 clk = 1;
		#10
		$display("%d + i * %d", fft_a_re, fft_a_im);
		$display("%d + i * %d", fft_b_re, fft_b_im);
		$display("%d + i * %d", fft_c_re, fft_c_im);
		$display("%d + i * %d", fft_d_re, fft_d_im);
		$display("%d + i * %d", fft_e_re, fft_e_im);
		$display("%d + i * %d", fft_f_re, fft_f_im);
		$display("%d + i * %d", fft_g_re, fft_g_im);
		$display("%d + i * %d", fft_h_re, fft_h_im);
	end
endmodule
