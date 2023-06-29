`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2023 07:34:34 PM
// Design Name: 
// Module Name: slave_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module slave_top(

            //inputs
            input S_ready,
            input [7:0] s0 ,
            input [7:0] s1 ,
            input [7:0] s2 ,
            input [7:0] s3 ,
            input [7:0] s4 ,
            input [7:0] s5 ,
            input [7:0] s6 ,
            input [7:0] s7 ,
            input [7:0] s8 ,
            input [7:0] s9,
            input [7:0] s10,
            input [7:0] s11,
            input [7:0] s12,
            input [7:0] s13,
            input [7:0] s14,
            input [7:0] s15,
            
            input clk,
            input reset,
            
            //outputs
            output  [7:0]    L1, 
            output  [7:0]    L2,
            output  [7:0]    L3,
            output  [7:0]    L4,
            output  [7:0]    L5,
            output  [7:0]    L6,
            output  [7:0]    L7,
            output  [7:0]    L8,
                    
            output  [7:0]    r1,
            output  [7:0]    r2,  
            output  [7:0]    r3,
            output  [7:0]    r4,
            output  [7:0]    r5,
            output  [7:0]    r6,
            output  [7:0]    r7,
            output  [7:0]    r8,
            
            output [7:0]     O1, 
            output [7:0]     O2, 
            output [7:0]     O3, 
            output [7:0]     O4, 
            output [7:0]     O5, 
            output [7:0]     O6, 
            output [7:0]     O7, 
            output [7:0]     O8, 
            output [7:0]     O9, 
            output [7:0]     O10,
            output [7:0]     O11,
            output [7:0]     O12,
            output [7:0]     O13,
            output [7:0]     O14,
            output [7:0]     O15,
            output [7:0]     O16,
            
            output          roots_ready,
            output          poly_ready,
            output          L_ready 
           );
    
    
   wire [7:0] r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out; // output roots of lamda polynomial (decimal) up to 8 roots
   wire [7:0] L1_out,L2_out,L3_out,L4_out,L5_out,L6_out,L7_out,L8_out; // output roots of lamda polynomial (decimal) up to 8 roots
   wire [7:0] O1_out,O2_out,O3_out,O4_out,O5_out,O6_out,O7_out,O8_out,O9_out,O10_out,O11_out,O12_out,O13_out,O14_out,O15_out,O16_out;  /// power values of omega polynomial coeff from 2:16
   
   assign L1 =  L1_out ;
   assign L2 =  L2_out ;
   assign L3 =  L3_out ;
   assign L4 =  L4_out ;
   assign L5 =  L5_out ;
   assign L6 =  L6_out ;
   assign L7 =  L7_out ;
   assign L8 =  L8_out ;
   
   assign r1 =  r1_out ;
   assign r2 =  r2_out ;
   assign r3 =  r3_out ;
   assign r4 =  r4_out ;
   assign r5 =  r5_out ;
   assign r6 =  r6_out ;
   assign r7 =  r7_out ;
   assign r8 =  r8_out ;
   
   assign O1 = O1_out  ;
   assign O2 = O2_out  ;
   assign O3 = O3_out  ;
   assign O4 = O4_out  ;
   assign O5 = O5_out  ;
   assign O6 = O6_out  ;
   assign O7 = O7_out  ;
   assign O8 = O8_out  ;
   assign O9 = O9_out  ;
   assign O10 = O10_out;
   assign O11 = O11_out;
   assign O12 = O12_out;
   assign O13 = O13_out;
   assign O14 = O14_out;
   assign O15 = O15_out;
   assign O16 = O16_out;
   
 
   
    ////////BM_lamda//////////////////////////////////////////////////////////
wire  L_ready_wire;  // active high flag for one clock to indicate that lamda polynomial is ready
//wire [7:0] L1,L2,L3,L4,L5,L6,L7,L8;   ///  lamda coeff values in decimal format 

reg [7:0] pow1_BM_lamda,pow2_BM_lamda;    
reg [7:0] dec1_BM_lamda;        

wire  [7:0] add_pow1_BM_lamda,add_pow2_BM_lamda;  
wire  [7:0] add_dec1_BM_lamda;    

///////////////////////////////////////////////////////////////////////////////////////////////////
BM_lamda   BM_lamda_unit
(
.clk(clk), 
.reset(reset),

.erasure_ready(1'b0),
.erasure_cnt(4'b0),


.Sm_ready(S_ready),
.Sm1(s0),
.Sm2(s1),
.Sm3(s2),
.Sm4(s3),
.Sm5(s4),
.Sm6(s5),
.Sm7(s6),
.Sm8(s7), 
.Sm9(s8),
.Sm10(s9),
.Sm11(s10),
.Sm12(s11),
.Sm13(s12),
.Sm14(s13),
.Sm15(s14),
.Sm16(s15),




.add_pow1(add_pow1_BM_lamda),  
.add_pow2(add_pow2_BM_lamda),  

.add_dec1(add_dec1_BM_lamda),



.pow1(pow1_BM_lamda),  
.pow2(pow2_BM_lamda),  

.dec1(dec1_BM_lamda),




.L_ready(L_ready_wire),
.L1(L1_out),
.L2(L2_out),
.L3(L3_out),
.L4(L4_out),
.L5(L5_out),
.L6(L6_out),
.L7(L7_out),
.L8(L8_out) 
 
);

////////////lamda_roots////////////////////////////////////////////////////////////////
wire roots_ready_wire;
wire [3:0] root_cnt;  //from 0 to 8
//wire [7:0] r1,r2,r3,r4,r5,r6,r7,r8; // output roots of lamda polynomial (decimal) up to 8 roots

reg [7:0] pow1_lamda_roots;    
reg [7:0] dec1_lamda_roots,dec2_lamda_roots,dec3_lamda_roots;        

wire  [7:0] add_pow1_lamda_roots;  
wire  [7:0] add_dec1_lamda_roots,add_dec2_lamda_roots,add_dec3_lamda_roots;    

////////////////////////////////////////////////////////////////////////////////////////
lamda_roots lamda_roots_unit
(
.CE(L_ready_wire), 
.clk(clk), 
.reset(reset), 

.Lc0(8'h01),   // always equals one 
.Lc1(L1_out),
.Lc2(L2_out),
.Lc3(L3_out),
.Lc4(L4_out),
.Lc5(L5_out),
.Lc6(L6_out),
.Lc7(L7_out),
.Lc8(L8_out), 

.add_GF_ascending(add_pow1_lamda_roots),   
.add_GF_dec0(add_dec1_lamda_roots),
.add_GF_dec1(add_dec2_lamda_roots),
.add_GF_dec2(add_dec3_lamda_roots),         

.power(pow1_lamda_roots),  
.decimal0(dec1_lamda_roots),
.decimal1(dec2_lamda_roots),
.decimal2(dec3_lamda_roots),

.CEO(roots_ready_wire), 
.root_cnt(root_cnt), ///  up to 8
.r1(r1_out),
.r2(r2_out),
.r3(r3_out),
.r4(r4_out),
.r5(r5_out),
.r6(r6_out),
.r7(r7_out),
.r8(r8_out)
);

///////////Omega_Phy//////////////////////////////////////////////////////////////////////
wire  poly_ready_wire ;  // active high flag for one clock to indicate that Phy and Omega polynomials are ready

//wire   [7:0] O1;    // decimal value of first coeff of Omega polynomial
//wire   [7:0] O2,O3,O4,O5,O6,O7,O8,O9,O10,O11,O12,O13,O14,O15,O16;  /// power values of omega polynomial coeff from 2:16

wire   [7:0] P1;    // decimal value of first coeff of Phy polynomial
wire   [7:0] P3,P5,P7;  /// power values of Phy polynomial coeff 

reg [7:0] dec1_Omega_Phy;    
reg [7:0] pow1_Omega_Phy,pow2_Omega_Phy,pow3_Omega_Phy;        

wire  [7:0] add_dec1_Omega_Phy;  
wire  [7:0] add_pow1_Omega_Phy,add_pow2_Omega_Phy,add_pow3_Omega_Phy;    


////////////////////////////////////////////////////////////////////////////////////
Omega_Phy   Omega_Phy_unit
(
.clk(clk), 
.reset(reset), 


.Sm_ready(S_ready),
.Sm1(s0),
.Sm2(s1),
.Sm3(s2),
.Sm4(s3),
.Sm5(s4),
.Sm6(s5),
.Sm7(s6),
.Sm8(s7), 
.Sm9(s8),
.Sm10(s9),
.Sm11(s10),
.Sm12(s11),
.Sm13(s12),
.Sm14(s13),
.Sm15(s14),
.Sm16(s15),





.add_pow1(add_pow1_Omega_Phy),  
.add_pow2(add_pow2_Omega_Phy),  
.add_pow3(add_pow3_Omega_Phy),  

.add_dec1(add_dec1_Omega_Phy),



.pow1(pow1_Omega_Phy),  
.pow2(pow2_Omega_Phy),  
.pow3(pow3_Omega_Phy),  

.dec1(dec1_Omega_Phy),




.L_ready(L_ready_wire),
.L1(L1_out),
.L2(L2_out),
.L3(L3_out),
.L4(L4_out),
.L5(L5_out),
.L6(L6_out),
.L7(L7_out),
.L8(L8_out) ,



.poly_ready(poly_ready_wire),
.O1(O1_out), 
.O2(O2_out), 
.O3(O3_out), 
.O4(O4_out), 
.O5(O5_out), 
.O6(O6_out), 
.O7(O7_out), 
.O8(O8_out), 
.O9(O9_out), 
.O10(O10_out), 
.O11(O11_out), 
.O12(O12_out), 
.O13(O13_out), 
.O14(O14_out), 
.O15(O15_out), 
.O16(O16_out), 

.P1(P1), 
.P3(P3), 
.P5(P5), 
.P7(P7)

);




///////////////////////////////////////////////////////////////////////////////////
/////// GF Roms////////////////////////////////////////////////////////////////////

wire [7:0] pow1,pow2,pow3,pow4;    /// output of power memories
wire [7:0] dec1,dec2,dec3,dec4;        /// output of decimal memories

reg  [7:0] add_pow1,add_pow2,add_pow3,add_pow4;  /// address to power memories
reg  [7:0] add_dec1,add_dec2,add_dec3,add_dec4;    /// address to decimal memories

////// instant of GF_matrix_ascending_binary Rom////////////////////////////////////
GF_matrix_ascending_binary   power_rom_instant1
(
.clk(clk),
.re(1'b1),
.address_read(add_pow1),
.data_out(pow1)
);
/////// instant of GF_matrix_ascending_binary Rom////////////////////////////////////
GF_matrix_ascending_binary   power_rom_instant2
(
.clk(clk),
.re(1'b1),
.address_read(add_pow2),
.data_out(pow2)
);
///////// instant of GF_matrix_ascending_binary Rom////////////////////////////////////
GF_matrix_ascending_binary   power_rom_instant3
(
.clk(clk),
.re(1'b1),
.address_read(add_pow3),
.data_out(pow3)
);
////// instant of GF_matrix_ascending_binary Rom////////////////////////////////////
GF_matrix_ascending_binary   power_rom_instant4
(
.clk(clk),
.re(1'b1),
.address_read(add_pow4),
.data_out(pow4)
);
//////////GF_matrix_dec Rom //////////////////////////
GF_matrix_dec rom_instant_1 
(
.clk(clk),
.re(1'b1),
.address_read(add_dec1),
.data_out(dec1)
);
//////////GF_matrix_dec Rom //////////////////////////
GF_matrix_dec rom_instant_2 
(
.clk(clk),
.re(1'b1),
.address_read(add_dec2),
.data_out(dec2)
);

//////////GF_matrix_dec Rom //////////////////////////
GF_matrix_dec rom_instant_3 
(
.clk(clk),
.re(1'b1),
.address_read(add_dec3),
.data_out(dec3)
);

//////////GF_matrix_dec Rom //////////////////////////
GF_matrix_dec rom_instant_4 
(
.clk(clk),
.re(1'b1),
.address_read(add_dec4),
.data_out(dec4)
);

/////////////////////////////////////////////////////////////

reg L_flag, S_flag;
always@(posedge clk or posedge reset) begin
    if(reset)begin
    L_flag <=0;
    S_flag <= 0;
    end
    else if(S_ready) begin
     S_flag <= 1;
     L_flag <=0;
    end
    else if(L_ready ) begin
     S_flag <= 0;
     L_flag <=1;
    end
 end

wire [2:0] control;

assign control ={L_flag,S_flag};


////////////////    GF memories switching ////////////////////
always@(*)
begin

	////////////////////////////////////////////////////////////////////////////
	add_pow1<=0;
	add_pow2<=0;
	add_pow3<=0;
	add_pow4<=0;
	add_dec1<=0;
	add_dec2<=0;
	add_dec3<=0;
	add_dec4<=0;
	pow1_BM_lamda<=0;
	pow2_BM_lamda<=0;
	dec1_BM_lamda<=0;
	pow1_lamda_roots<=0;
	pow1_Omega_Phy<=0;
	pow2_Omega_Phy<=0;
	pow3_Omega_Phy<=0;
	dec1_lamda_roots<=0;
	dec2_lamda_roots<=0;
	dec3_lamda_roots<=0;
	dec1_Omega_Phy<=0;

	////////////////////////////////////////////////////////////////////////////
	case (control)
	///////////////////////////////////////////////////////////////////////////
		2'b01:begin
			add_pow1<=add_pow1_BM_lamda;
			add_pow2<=add_pow2_BM_lamda;
			
			add_dec1<=add_dec1_BM_lamda;
			
			pow1_BM_lamda<=pow1;
			pow2_BM_lamda<=pow2;
			
			dec1_BM_lamda<=dec1;
		end	
	/////////////////////////////////////////////////////////////////////////
		2'b10:begin
			add_pow1<=add_pow1_lamda_roots;
			add_pow2<=add_pow1_Omega_Phy;
			add_pow3<=add_pow2_Omega_Phy;
			add_pow4<=add_pow3_Omega_Phy;
			
			add_dec1<=add_dec1_lamda_roots;
			add_dec2<=add_dec2_lamda_roots;
			add_dec3<=add_dec3_lamda_roots;
			add_dec4<=add_dec1_Omega_Phy;
			
			pow1_lamda_roots<=pow1;
			pow1_Omega_Phy<=pow2;
			pow2_Omega_Phy<=pow3;
			pow3_Omega_Phy<=pow4;
			
			dec1_lamda_roots<=dec1;
			dec2_lamda_roots<=dec2;
			dec3_lamda_roots<=dec3;
			dec1_Omega_Phy<=dec4;
		end
	//////////////////////////////////////////////////////////////////////////////////////		

	endcase
end

  
   assign L_ready = L_ready_wire;
   assign poly_ready = poly_ready_wire;
   assign roots_ready = roots_ready_wire;
///////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
