module halfadder (
 input x,y,
 output c,s
 );
 assign s = x ^ y;
 assign c = x & y;
 endmodule

module fulladder(
 input x,y, cin,
 output s, cout
 );
 wire c1,s1,c2;
 halfadder HA0 (
 .x(x),
 .y(y),
 .c(c1),
 .s(s1)
 );
 halfadder HA1 (
 .x(cin),
 .y(s1),
 .c(c2),
 .s(s)
 );
 assign cout = c1 | c2;
endmodule

module ADD (
 input [15:0] rb,rc,
 output [15:0] ra
 );
 wire [15:1] c;
 fulladder FA0 (
 .x(rb[0]),
 .y(rc[0]),
 .cin(1'b0),
 .s(ra[0]),
 .cout(c[1])
 );
 fulladder FA1 (
 .x(rb[1]),
 .y(rc[1]),
 .cin(c[1]),
 .s(ra[1]),
 .cout(c[2])
 );
 fulladder FA2 (
 .x(rb[2]),
 .y(rc[2]),
 .cin(c[2]),
 .s(ra[2]),
 .cout(c[3])
 );
 fulladder FA3 (
 .x(rb[3]),
 .y(rc[3]),
 .cin(c[3]),
 .s(ra[3]),
 .cout(c[4])
 );
 fulladder FA4 (
 .x(rb[4]),
 .y(rc[4]),
 .cin(c[4]),
 .s(ra[4]),
 .cout(c[5])
 );
 fulladder FA5 (
 .x(rb[5]),
 .y(rc[5]),
 .cin(c[5]),
 .s(ra[5]),
 .cout(c[6])
 );
 fulladder FA6 (
 .x(rb[6]),
 .y(rc[6]),
 .cin(c[6]),
 .s(ra[6]),
 .cout(c[7])
 );
 fulladder FA7 (
 .x(rb[7]),
 .y(rc[7]),
 .cin(c[7]),
 .s(ra[7]),
 .cout(c[8])
 );
 fulladder FA8 (
 .x(rb[8]),
 .y(rc[8]),
 .cin(c[8]),
 .s(ra[8]),
 .cout(c[9])
 );
 fulladder FA9 (
 .x(rb[9]),
 .y(rc[9]),
 .cin(c[9]),
 .s(ra[9]),
 .cout(c[10])
 );
 fulladder FA10 (
 .x(rb[10]),
 .y(rc[10]),
 .cin(c[10]),
 .s(ra[10]),
 .cout(c[11])
 );
 fulladder FA11 (
 .x(rb[11]),
 .y(rc[11]),
 .cin(c[11]),
 .s(ra[11]),
 .cout(c[12])
 );
 fulladder FA12 (
 .x(rb[12]),
 .y(rc[12]),
 .cin(c[12]),
 .s(ra[12]),
 .cout(c[13])
 );
 fulladder FA13 (
 .x(rb[13]),
 .y(rc[13]),
 .cin(c[13]),
 .s(ra[13]),
 .cout(c[14])
 );
 fulladder FA14 (
 .x(rb[14]),
 .y(rc[14]),
 .cin(c[14]),
 .s(ra[14]),
 .cout(c[15])
 );
 fulladder FA15 (
 .x(rb[15]),
 .y(rc[15]),
 .cin(c[15]),
 .s(ra[15]),
 .cout()
 );
 endmodule