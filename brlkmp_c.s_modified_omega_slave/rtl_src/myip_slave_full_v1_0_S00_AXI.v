
`timescale 1 ns / 1 ps

	module myip_slave_full_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here
		/*
            input wire [31:0] SLV_REG0_TST,SLV_REG1_TST,SLV_REG2_TST,SLV_REG3_TST,SLV_REG4_TST,SLV_REG5_TST,SLV_REG6_TST,
                            SLV_REG7_TST,SLV_REG8_TST,SLV_REG9_TST,SLV_REG10_TST,SLV_REG11_TST,SLV_REG12_TST,SLV_REG13_TST,
                            SLV_REG14_TST,SLV_REG15_TST,SLV_REG16_TST,
                         */
                            
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 4;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 30
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
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
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;



   // wires
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21_out;
   wire [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20_out;
	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	      slv_reg10 <= 0;
	      slv_reg11 <= 0;
	      slv_reg12 <= 0;
	      slv_reg13 <= 0;
	      slv_reg14 <= 0;
	      slv_reg15 <= 0;
	      slv_reg16 <= 0;
	      slv_reg17 <= 0;
	      slv_reg18 <= 0;
	      slv_reg19 <= 0;
	      slv_reg20 <= 0;
	      slv_reg21 <= 0;
	      slv_reg22 <= 0;
	      slv_reg23 <= 0;
	      slv_reg24 <= 0;
	      slv_reg25 <= 0;
	      slv_reg26 <= 0;
	      slv_reg27 <= 0;
	      slv_reg28 <= 0;
	      slv_reg29 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          5'h00:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h01:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h02:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h03:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h04:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h05:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h06:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h07:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h08:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h09:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 10
	                slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 11
	                slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 12
	                slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 13
	                slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 14
	                slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h0F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 15
	                slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h10:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 16
	                slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h11:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 17
	                slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h12:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 18
	                slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h13:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 19
	                slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h14:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 20
	                slv_reg20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h15:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 21
	                slv_reg21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h16:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 22
	                slv_reg22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h17:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 23
	                slv_reg23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h18:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 24
	                slv_reg24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h19:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 25
	                slv_reg25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h1A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 26
	                slv_reg26[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h1B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 27
	                slv_reg27[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h1C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 28
	                slv_reg28[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          5'h1D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 29
	                slv_reg29[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                      slv_reg10 <= slv_reg10;
	                      slv_reg11 <= slv_reg11;
	                      slv_reg12 <= slv_reg12;
	                      slv_reg13 <= slv_reg13;
	                      slv_reg14 <= slv_reg14;
	                      slv_reg15 <= slv_reg15;
	                      slv_reg16 <= slv_reg16;
	                      slv_reg17 <= slv_reg17;
	                      slv_reg18 <= slv_reg18;
	                      slv_reg19 <= slv_reg19;
	                      slv_reg20 <= slv_reg20;
	                      slv_reg21 <= slv_reg21;
	                      slv_reg22 <= slv_reg22;
	                      slv_reg23 <= slv_reg23;
	                      slv_reg24 <= slv_reg24;
	                      slv_reg25 <= slv_reg25;
	                      slv_reg26 <= slv_reg26;
	                      slv_reg27 <= slv_reg27;
	                      slv_reg28 <= slv_reg28;
	                      slv_reg29 <= slv_reg29;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        5'h00   : reg_data_out <= slv_reg0;
	        5'h01   : reg_data_out <= slv_reg1;
	        5'h02   : reg_data_out <= slv_reg2;
	        5'h03   : reg_data_out <= slv_reg3;
	        5'h04   : reg_data_out <= slv_reg4;
	        5'h05   : reg_data_out <= slv_reg5;
	        5'h06   : reg_data_out <= slv_reg6;
	        5'h07   : reg_data_out <= slv_reg7;
	        5'h08   : reg_data_out <= slv_reg8;
	        5'h09   : reg_data_out <= slv_reg9;
	        5'h0A   : reg_data_out <= slv_reg10;
	        5'h0B   : reg_data_out <= slv_reg11;
	        5'h0C   : reg_data_out <= slv_reg12;
	        5'h0D   : reg_data_out <= slv_reg13;
	        5'h0E   : reg_data_out <= slv_reg14;
	        5'h0F   : reg_data_out <= slv_reg15;
	        5'h10   : reg_data_out <= slv_reg16;
	        5'h11   : reg_data_out <= slv_reg17;
	        5'h12   : reg_data_out <= slv_reg18;
	        5'h13   : reg_data_out <= slv_reg19;
	        5'h14   : reg_data_out <= slv_reg20_out;
	        5'h15   : reg_data_out <= slv_reg21_out;
	        5'h16   : reg_data_out <= slv_reg22_out;
	        5'h17   : reg_data_out <= slv_reg23_out;
	        5'h18   : reg_data_out <= slv_reg24_out;
	        5'h19   : reg_data_out <= slv_reg25_out;
	        5'h1A   : reg_data_out <= slv_reg26_out;
	        5'h1B   : reg_data_out <= slv_reg27_out;
	        5'h1C   : reg_data_out <= slv_reg28_out;
	        5'h1D   : reg_data_out <= slv_reg29_out;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
	reg [7:0] Sm1_reg,Sm2_reg,Sm3_reg,Sm4_reg,Sm5_reg,Sm6_reg,Sm7_reg,Sm8_reg,
	            Sm9_reg,Sm10_reg,Sm11_reg,Sm12_reg,Sm13_reg,Sm14_reg,Sm15_reg,Sm16_reg;
	reg Sm_ready,roots_ready_reg, poly_ready_reg ;
	reg [7:0] L1_reg,L2_reg,L3_reg,L4_reg,L5_reg,L6_reg,L7_reg,L8_reg;   ///  lamda coeff values in decimal format
	reg [7:0] r1_reg,r2_reg,r3_reg,r4_reg,r5_reg,r6_reg,r7_reg,r8_reg;   ///  
	reg [7:0] O1_reg,O2_reg,O3_reg,O4_reg,O5_reg,O6_reg,O7_reg,O8_reg;
	reg [7:0] O9_reg,O10_reg,O11_reg,O12_reg,O13_reg,O14_reg,O15_reg,O16_reg;    //
	wire [7:0] L1, L2, L3, L4, L5, L6, L7, L8;
	wire [7:0] r1, r2, r3, r4, r5, r6, r7, r8;
	wire [7:0] O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, O11, O12, O13, O14, O15, O16; 
	wire roots_ready, poly_ready, L_ready;
    slave_top slave_top_inst(.clk(S_AXI_ACLK), .reset(~S_AXI_ARESETN),
                            .S_ready(Sm_ready), .s0(Sm1_reg), .s1(Sm2_reg), .s2(Sm3_reg), .s3(Sm4_reg), .s4(Sm5_reg), .s5(Sm6_reg),
                             .s6(Sm7_reg), .s7(Sm8_reg), .s8(Sm9_reg), .s9(Sm10_reg), .s10(Sm11_reg), .s11(Sm12_reg),
                              .s12(Sm13_reg), .s13(Sm14_reg), .s14(Sm15_reg), .s15(Sm16_reg),
                            .L1(L1), .L2(L2), .L3(L3), .L4(L4), .L5(L5), .L6(L6), .L7(L7), .L8(L8), 
                            .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), 
                            .O1(O1), .O2(O2), .O3(O3), .O4(O4), .O5(O5), .O6(O6), .O7(O7), .O8(O8),
                             .O9(O9), .O10(O10), .O11(O11), .O12(O12), .O13(O13), .O14(O14), .O15(O15), .O16(O16),
                                .roots_ready(roots_ready), .poly_ready(poly_ready), .L_ready(L_ready) );
                                        
                       
                
                
      always @(posedge S_AXI_ACLK  ) begin
        
            if ( S_AXI_ARESETN == 1'b0 ) begin
                Sm_ready <=0;
                Sm1_reg <= 0;
                Sm2_reg <= 0;
                Sm3_reg <= 0;
                Sm4_reg <= 0;
                Sm5_reg <= 0;
                Sm6_reg <= 0;
                Sm7_reg <= 0;
                Sm8_reg <= 0;
                Sm9_reg <= 0;
                Sm10_reg <= 0;
                Sm11_reg <= 0;
                Sm12_reg <= 0;
                Sm13_reg <= 0;
                Sm14_reg <= 0;
                Sm15_reg <= 0;
                Sm16_reg <= 0;
                end
            else   begin
                Sm_ready <=  slv_reg4;                 //   SLV_REG16_TST[0];
                Sm1_reg <=   slv_reg0[7:0];            //  SLV_REG0_TST ; 
                Sm2_reg <=   slv_reg0[15:8];           //  SLV_REG1_TST;
                Sm3_reg <=   slv_reg0[23:16];          //  SLV_REG2_TST;
                Sm4_reg <=   slv_reg0[31:24];          //  SLV_REG3_TST;
                Sm5_reg <=   slv_reg1[7:0];            //  SLV_REG4_TST;
                Sm6_reg <=   slv_reg1[15:8];           //  SLV_REG5_TST;
                Sm7_reg <=   slv_reg1[23:16];          //  SLV_REG6_TST;
                Sm8_reg <=   slv_reg1[31:24];          //  SLV_REG7_TST;
                Sm9_reg <=   slv_reg2[7:0];            //  SLV_REG8_TST; 
                Sm10_reg <=  slv_reg2[15:8];           //  SLV_REG9_TST;  
                Sm11_reg <=  slv_reg2[23:16];          //  SLV_REG10_TST; 
                Sm12_reg <=  slv_reg2[31:24];          //  SLV_REG11_TST; 
                Sm13_reg <=  slv_reg3[7:0];            //  SLV_REG12_TST;  
                Sm14_reg <=  slv_reg3[15:8];           //  SLV_REG13_TST ; 
                Sm15_reg <=  slv_reg3[23:16];          //  SLV_REG14_TST; 
                Sm16_reg <=  slv_reg3[31:24];          //  SLV_REG15_TST; 
                end
               if (Sm_ready) begin
               Sm_ready <= 0;
               end
           
            
        end                 
                       
      always @(posedge S_AXI_ACLK) begin
        
            if ( S_AXI_ARESETN == 1'b0 ) begin
       
                L1_reg <= 0;
                L2_reg <= 0;
                L3_reg <= 0;
                L4_reg <= 0;
                L5_reg <= 0;
                L6_reg <= 0;
                L7_reg <= 0;
                L8_reg <= 0;
                
                end
            else if (L_ready)   begin
                L1_reg <= L1;
                L2_reg <= L2;     
                L3_reg <= L3;
                L4_reg <= L4;
                L5_reg <= L5;
                L6_reg <= L6;
                L7_reg <= L7;
                L8_reg <= L8;
                end 
        end
        
        
        
        always @(posedge S_AXI_ACLK) begin
        
            if ( S_AXI_ARESETN == 1'b0 ) begin
       
                r1_reg <= 0;
                r2_reg <= 0;
                r3_reg <= 0;
                r4_reg <= 0;
                r5_reg <= 0;
                r6_reg <= 0;
                r7_reg <= 0;
                r8_reg <= 0;
                
                end
            else if (roots_ready)   begin
                r1_reg <= r1;
                r2_reg <= r2;     
                r3_reg <= r3;
                r4_reg <= r4;
                r5_reg <= r5;
                r6_reg <= r6;
                r7_reg <= r7;
                r8_reg <= r8;
                end 
        end 
         
       
      always @(posedge poly_ready or negedge  S_AXI_ARESETN ) begin
        
            if ( S_AXI_ARESETN == 1'b0 ) begin
                //poly_ready_reg <= 0;
                O1_reg <= 0;
                O2_reg <= 0;
                O3_reg <= 0;
                O4_reg <= 0;
                O5_reg <= 0;
                O6_reg <= 0;
                O7_reg <= 0;
                O8_reg <= 0;
                O9_reg <= 0;
                O10_reg <= 0;
                O11_reg <= 0;
                O12_reg <= 0;
                O13_reg <= 0;
                O14_reg <= 0;
                O15_reg <= 0;
                O16_reg <= 0;
                
                end
            else if (poly_ready)   begin
            
                O1_reg <= O1;
                O2_reg <= O2;
                O3_reg <= O3;
                O4_reg <= O4;
                O5_reg <= O5;
                O6_reg <= O6;
                O7_reg <= O7;
                O8_reg <= O8;
                O9_reg <= O9;
                O10_reg <=O10;
                O11_reg <=O11;
                O12_reg <=O12;
                O13_reg <=O13;
                O14_reg <=O14;
                O15_reg <=O15;
                O16_reg <=O16;
                end 
     
        end  
        
		assign slv_reg20_out[7:0] = (~S_AXI_ARESETN) ? 8'd0 : L1_reg;
        assign slv_reg20_out[15:8] = (~S_AXI_ARESETN) ? 8'd0 : L2_reg;
        assign slv_reg20_out[23:16]= (~S_AXI_ARESETN) ? 8'd0 : L3_reg;
        assign slv_reg20_out[31:24]= (~S_AXI_ARESETN) ? 8'd0 : L4_reg;
        assign slv_reg21_out[7:0] =(~S_AXI_ARESETN) ? 0 : L5_reg;
        assign slv_reg21_out[15:8] = (~S_AXI_ARESETN) ? 0 : L6_reg;
        assign slv_reg21_out[23:16]= (~S_AXI_ARESETN) ? 0 : L7_reg;
        assign slv_reg21_out [31:24] = (~S_AXI_ARESETN) ? 0 : L8_reg;
        
	    assign slv_reg22_out [7:0] = (~S_AXI_ARESETN) ? 0 :   r1_reg;
	    assign slv_reg22_out [15:8]  = (~S_AXI_ARESETN) ? 0 : r2_reg;
	    assign slv_reg22_out [23:16] = (~S_AXI_ARESETN) ? 0 : r3_reg;
	    assign slv_reg22_out [31:24] = (~S_AXI_ARESETN) ? 0 : r4_reg;
	    assign slv_reg23_out [7:0] = (~S_AXI_ARESETN)  ? 0   : r5_reg;
	    assign slv_reg23_out [15:8]  = (~S_AXI_ARESETN) ? 0 : r6_reg;
	    assign slv_reg23_out [23:16] = (~S_AXI_ARESETN) ? 0 : r7_reg;
	    assign slv_reg23_out [31:24] = (~S_AXI_ARESETN) ? 0 : r8_reg;
	    
	    assign slv_reg24_out [7:0] = (~S_AXI_ARESETN)  ? 0  : O1_reg;
	    assign slv_reg24_out [15:8]  = (~S_AXI_ARESETN) ? 0 : O2_reg;
	    assign slv_reg24_out [23:16] = (~S_AXI_ARESETN) ? 0 : O3_reg;
	    assign slv_reg24_out [31:24] = (~S_AXI_ARESETN) ? 0 : O4_reg;
	    assign slv_reg25_out [7:0] = (~S_AXI_ARESETN)  ? 0  : O5_reg;
	    assign slv_reg25_out [15:8]  = (~S_AXI_ARESETN) ? 0 : O6_reg;
	    assign slv_reg25_out [23:16] = (~S_AXI_ARESETN) ? 0 : O7_reg;
	    assign slv_reg25_out [31:24] = (~S_AXI_ARESETN) ? 0 : O8_reg;
	    assign slv_reg26_out [7:0] = (~S_AXI_ARESETN)  ? 0   : O9_reg;
	    assign slv_reg26_out [15:8]  = (~S_AXI_ARESETN) ? 0 : O10_reg;
	    assign slv_reg26_out [23:16] = (~S_AXI_ARESETN) ? 0 : O11_reg;
	    assign slv_reg26_out [31:24] = (~S_AXI_ARESETN) ? 0 : O12_reg;
	    assign slv_reg27_out [7:0] = (~S_AXI_ARESETN)  ? 0   : O13_reg;
	    assign slv_reg27_out [15:8]  = (~S_AXI_ARESETN) ? 0 : O14_reg;
	    assign slv_reg27_out [23:16] = (~S_AXI_ARESETN) ? 0 : O15_reg;
	    assign slv_reg27_out [31:24] = (~S_AXI_ARESETN) ? 0 : O16_reg;
	    
	    assign slv_reg28_out  = (~S_AXI_ARESETN) ? 0 :roots_ready;
	    assign slv_reg29_out  = (~S_AXI_ARESETN) ? 0 :poly_ready;
	    assign slv_reg19_out  = (~S_AXI_ARESETN) ? 0 :L_ready;
	    
	    
	    
	    
                           
	// User logic ends
       
                 
                    
	endmodule
