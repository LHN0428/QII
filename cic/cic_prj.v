module cic_prj(
           clk       ,
           rst_n     ,
           dac_mode ,
           dac_sleep ,
           dac_clka  ,
           dac_da   ,
           dac_wra  ,
           dac_clkb  ,
           dac_db   ,
           dac_wrb               
           );


input             clk        ;
input             rst_n      ;
output            dac_mode ;
output            dac_clka  ;
output [ 8-1:0]    dac_da    ;
output            dac_wra   ;
output            dac_sleep ;
output            dac_clkb  ;
output [ 8-1:0]    dac_db    ;
output            dac_wrb   ;


reg [ 6:0]  cnt0     ;
wire        add_cnt0 ;
wire        end_cnt0 ;
reg [ 4:0]  cnt1     ;
wire        add_cnt1 ;
wire        end_cnt1 ;

reg [ 2:0]  addr     ;
wire        add_addr ;
wire        end_addr ;
reg   [7:0]    sin_data    ;
wire    [7:0]    cic_din    ;
wire    [7:0]    cic_dout    ;
wire    [7:0]    cic_dout2   ;

reg   [7:0]    dac_da    ;
wire          dac_sleep  ;
wire          dac_wra   ;
wire          dac_clka   ;
wire          dac_mode ;

reg   [7:0]    dac_db    ;
wire          dac_wrb   ;
wire          dac_clkb   ;


always @(posedge clk or negedge rst_n) begin 
    if (rst_n==0) begin
        cnt0 <= 0; 
    end
    else if(add_cnt0) begin
        if(end_cnt0)
            cnt0 <= 0; 
        else
            cnt0 <= cnt0+1 ;
   end
end
assign add_cnt0 = 1;
assign end_cnt0 = add_cnt0  && cnt0 == 100 -1 ;

always @(posedge clk or negedge rst_n) begin 
    if (rst_n==0) begin
        addr <= 0; 
    end
    else if(add_addr) begin
        if(end_addr)
            addr <= 0; 
        else
            addr <= addr+1 ;
   end
end
assign add_addr = end_cnt0;
assign end_addr = add_addr  && addr == 8 -1 ;


assign cic_din = sin_data - 128;

my_cic u_my_cic( 
		.in_error  (0           ),  
        .in_valid  (end_cnt0    ),  
		.in_ready  (            ),  
		.in_data   (cic_din     ),  
		.out_data  (cic_dout    ),  
		.out_error (            ), 
		.out_valid (cic_dout_vld), 
		.out_ready (end_cnt1    ), 
		.clk       (clk         ),  
		.reset_n   (rst_n       )   
	); 



always @(posedge clk or negedge rst_n) begin 
    if (rst_n==0) begin
        cnt1 <= 0; 
    end
    else if(add_cnt1) begin
        if(end_cnt1)
            cnt1 <= 0; 
        else
            cnt1 <= cnt1+1 ;
   end
end
assign add_cnt1 = 1;
assign end_cnt1 = add_cnt1  && cnt1 == 25-1 ;

endmodule
