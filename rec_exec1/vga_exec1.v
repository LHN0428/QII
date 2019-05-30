

module vga_execl(

	clk ,
	rst ,
	lcd_hs ,
	lcd_vs ,
	lcd_rgb

	);




wire            clk_0 ;
wire           lcd_hs ;
wire           lcd_vs ;
wire [15:0]	  lcd_rgb ;


vga_pll module_1(

 		inclk0(clk),
 		c0  (clk_0)

	);


color module6(

	 .rst(clk_0),
	 .clk(rst_n),
	 .hys(lcd_hs),
	 .vys(lcd_vs),
	 lcd_rgb(lcd_rgb)

	);