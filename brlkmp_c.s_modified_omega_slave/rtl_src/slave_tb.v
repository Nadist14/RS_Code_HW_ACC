`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2023 08:37:56 PM
// Design Name: 
// Module Name: BM_lamda_tb
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


module slave_tb(

    );
    parameter integer C_S_AXI_DATA_WIDTH	= 32;
    reg  clk,reset;
    reg[32:0] axi_araddr, axi_wdata;
    reg axi_arvalid;
    reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16_tst;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29;
	
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21_out;
   
   
    wire  L_ready;  // active high flag for one clock to indicate that lamda polynomial is ready
    wire [7:0] L1,L2,L3,L4,L5,L6,L7,L8;   ///  lamda coeff values in decimal format 
    
    wire [7:0] pow1_BM_lamda,pow2_BM_lamda;    
    wire [7:0] dec1_BM_lamda;        
    
    wire  [7:0] add_pow1_BM_lamda,add_pow2_BM_lamda;  
    wire  [7:0] add_dec1_BM_lamda;  
    integer i;
    initial
begin
	clk=0;
	forever #5 clk=~clk;
end 
/*
axi_arvalid <= '1';
axi_araddr <= "0000"; -- as I would like to read reg0.
input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
		assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;
		*/
   myip_slave_full_v1_0 slave_inst (.s00_axi_aclk(clk),.s00_axi_aresetn(reset),
                            .slv_reg0_tst(slv_reg0_tst),.slv_reg1_tst(slv_reg1_tst),.slv_reg2_tst(slv_reg2_tst),.slv_reg3_tst(slv_reg3_tst),.slv_reg4_tst(slv_reg4_tst),.slv_reg5_tst(slv_reg5_tst),.slv_reg6_tst(slv_reg6_tst),
                            .slv_reg7_tst(slv_reg7_tst),.slv_reg8_tst(slv_reg8_tst),.slv_reg9_tst(slv_reg9_tst),.slv_reg10_tst(slv_reg10_tst),.slv_reg11_tst(slv_reg11_tst),.slv_reg12_tst(slv_reg12_tst),.slv_reg13_tst(slv_reg13_tst),
                            .slv_reg14_tst(slv_reg14_tst),.slv_reg15_tst(slv_reg15_tst),.slv_reg16_tst(slv_reg16_tst)  );
                        
                        
                        
     ////// instant of GF_matrix_ascending_binary Rom////////////////////////////////////
  
         // {255,255,126,255,106,115,138,255,179,230,99,84,4,19,251,255}              
     initial begin
    //clk = 0;
    reset = 0;
    
    #20
    reset = 1;
    slv_reg0_tst = 255;
    slv_reg1_tst = 255;
    slv_reg2_tst = 126;
    slv_reg3_tst = 255;
    slv_reg4_tst= 106;
    slv_reg5_tst= 115;
    slv_reg6_tst=138;
    slv_reg7_tst=255;
    slv_reg8_tst= 179;
    slv_reg9_tst=230;
    slv_reg10_tst=99;
    slv_reg11_tst=84;
    slv_reg12_tst=4;
    slv_reg13_tst=19;
    slv_reg14_tst=251;
    slv_reg15_tst=255;
    
    #10
    slv_reg16_tst = 1;
    #20
    slv_reg16_tst = 0;
    
    #100000
    slv_reg0_tst = 110;
    slv_reg1_tst = 141;
    slv_reg2_tst = 81;
    slv_reg3_tst = 86;
    slv_reg4_tst= 244;
    slv_reg5_tst= 88;
    slv_reg6_tst=173;
    slv_reg7_tst=29;
    slv_reg8_tst= 90;
    slv_reg9_tst=96;
    slv_reg10_tst=212;
    slv_reg11_tst=20;
    slv_reg12_tst=161;
    slv_reg13_tst=137;
    slv_reg14_tst=214;
    slv_reg15_tst=217;
    #10
    slv_reg16_tst = 1;
    #20
    slv_reg16_tst = 0;
    
     #100000
    slv_reg0_tst = 2;
    slv_reg1_tst =99;
    slv_reg2_tst =91;
    slv_reg3_tst =247;
    slv_reg4_tst= 0;
    slv_reg5_tst= 223;
    slv_reg6_tst=34;
    slv_reg7_tst=124;
    slv_reg8_tst= 121;
    slv_reg9_tst=0;
    slv_reg10_tst=37;
    slv_reg11_tst=177;
    slv_reg12_tst=195;
    slv_reg13_tst=208;
    slv_reg14_tst=0;
    slv_reg15_tst=79;
    #10
    slv_reg16_tst = 1;
    #20
    slv_reg16_tst = 0;
    
    
    #10000000
     $finish();
    end
    
    
                        
                        endmodule
