module half_adder(a,b,sum,carry);
    input a,b;
    output sum,carry;

    xor x1(sum,a,b);
    and a1(carry,a,b);
endmodule

module full_adder(a,b,inc,sum,cout);
    input a,b,inc;
    output sum,cout;
    wire sum_half,carry_half,carry_half_2;

    half_adder h1(a,b,sum_half,carry_half);
    half_adder h2(sum_half,inc,sum,carry_half_2);
    or o1(cout,carry_half,carry_half_2);
endmodule

module full_adder_4(a,b,inc,sum,cout);
    input [3:0] a; 
    input [3:0] b;
    input inc;
    output [3:0] sum;
    output cout;
    wire [2:0] c;

    full_adder add1 (a[0],b[0],inc,sum[0],c[0]);
    full_adder add2 (a[1],b[1],c[0],sum[1],c[1]);
    full_adder add3 (a[2],b[2],c[1],sum[2],c[2]);
    full_adder add4 (a[3],b[3],c[2],sum[3],cout);
endmodule

module full_adder_32(a,b,inc,sum,cout);
    input [31:0] a; 
    input [31:0] b;
    input inc;
    output [31:0] sum;
    output cout;
    wire [7:0] c;

    full_adder_4 add1 (a[3:0],b[3:0],inc,sum[3:0],c[0]);
    full_adder_4 add2 (a[7:4],b[7:4],c[0],sum[7:4],c[1]);
    full_adder_4 add3 (a[11:8],b[11:8],c[1],sum[11:8],c[2]);
    full_adder_4 add4 (a[15:12],b[15:12],c[2],sum[15:12],c[3]);
    full_adder_4 add5 (a[19:16],b[19:16],c[3],sum[19:16],c[4]);
    full_adder_4 add6 (a[23:20],b[23:20],c[4],sum[23:20],c[5]);
    full_adder_4 add7 (a[27:24],b[27:24],c[5],sum[27:24],c[6]);
    full_adder_4 add8 (a[31:28],b[31:28],c[6],sum[31:28],cout);
endmodule

module mux_2_1(a,b,select,out);
    input a,b;
    input select;
    wire select_not,and_1,and_2;
    output out;

    not(select_not,select);
    and(and_1,a,select_not);
    and(and_2,b,select);
    or(out,and_1,and_2);
endmodule

module mux_2_4(a,b,select,out);
    input [3:0] a,b;
    input select;
    wire [3:0] select_not,and_1,and_2;
    output [3:0] out;

    mux_2_1 mux1(a[0],b[0],select,out[0]);
    mux_2_1 mux2(a[1],b[1],select,out[1]);
    mux_2_1 mux3(a[2],b[2],select,out[2]);
    mux_2_1 mux4(a[3],b[3],select,out[3]);
endmodule

module mux_2_32(a,b,select,out);
    input [31:0] a,b;
    input select;
    wire [31:0] select_not,and_1,and_2;
    output [31:0] out;

    mux_2_4 mux1(a[3:0],b[3:0],select,out[3:0]);
    mux_2_4 mux2(a[7:4],b[7:4],select,out[7:4]);
    mux_2_4 mux3(a[11:8],b[11:8],select,out[11:8]);
    mux_2_4 mux4(a[15:12],b[15:12],select,out[15:12]);

    mux_2_4 mux5(a[19:16],b[19:16],select,out[19:16]);
    mux_2_4 mux6(a[23:20],b[23:20],select,out[23:20]);
    mux_2_4 mux7(a[27:24],b[27:24],select,out[27:24]);
    mux_2_4 mux8(a[31:28],b[31:28],select,out[31:28]);
endmodule

module mux_4_1(a,b,c,d,select,out);
    input [31:0] a,b,c,d;
    input [1:0] select;
    wire [31:0] out1,out2;
    output [31:0] out;

    mux_2_32 mux1(a,b,select[0],out1); 
    mux_2_32 mux2(c,d,select[0],out2);
    mux_2_32 mux3(out1,out2,select[1],out);
endmodule


module not_4(b,out);
    input [3:0] b;
    output [3:0] out;

    not(out[0],b[0]);
    not(out[1],b[1]);
    not(out[2],b[2]);
    not(out[3],b[3]);
endmodule

module not_32(b,out);
    input [31:0] b;
    output [31:0] out;

    not_4 n1(b[3:0],out[3:0]);
    not_4 n2(b[7:4],out[7:4]);
    not_4 n3(b[11:8],out[11:8]);
    not_4 n4(b[15:12],out[15:12]);
    not_4 n5(b[19:16],out[19:16]);
    not_4 n6(b[23:20],out[23:20]);
    not_4 n7(b[27:24],out[27:24]);
    not_4 n8(b[31:28],out[31:28]);

endmodule

module and_4(a,b,out);
    input [3:0] a,b;
    output [3:0] out;

    and(out[0],a[0],b[0]);
    and(out[1],a[1],b[1]);
    and(out[2],a[2],b[2]);
    and(out[3],a[3],b[3]);
endmodule

module and_32(out,a,b);
    input [31:0] a,b;
    output [31:0] out;
    
    and_4 a1(a[3:0],b[3:0],out[3:0]);
    and_4 a2(a[7:4], b[7:4], out[7:4]);
    and_4 a3(a[11:8], b[11:8], out[11:8]);
    and_4 a4(a[15:12], b[15:12], out[15:12]);
    and_4 a5(a[19:16], b[19:16], out[19:16]);
    and_4 a6(a[23:20], b[23:20], out[23:20]);
    and_4 a7(a[27:24], b[27:24], out[27:24]);
    and_4 a8(a[31:28], b[31:28], out[31:28]);

endmodule

module or_4(a,b,out);
    input [3:0] a,b;
    output [3:0] out;

    or(out[0],a[0],b[0]);
    or(out[1],a[1],b[1]);
    or(out[2],a[2],b[2]);
    or(out[3],a[3],b[3]);
endmodule

module or_32(out,a,b);
    input [31:0] a,b;
    output [31:0] out;
    
    or_4 o1(a[3:0], b[3:0], out[3:0]);
    or_4 o2(a[7:4], b[7:4], out[7:4]);
    or_4 o3(a[11:8], b[11:8], out[11:8]);
    or_4 o4(a[15:12], b[15:12], out[15:12]);
    or_4 o5(a[19:16], b[19:16], out[19:16]);
    or_4 o6(a[23:20], b[23:20], out[23:20]);
    or_4 o7(a[27:24], b[27:24], out[27:24]);
    or_4 o8(a[31:28], b[31:28], out[31:28]);

endmodule

module xor_4(a,b,out);
    input [3:0] a,b;
    output [3:0] out;

    xor(out[0],a[0],b[0]);
    xor(out[1],a[1],b[1]);
    xor(out[2],a[2],b[2]);
    xor(out[3],a[3],b[3]);
endmodule

module xor_32(out,a,b);
    input [31:0] a,b;
    output [31:0] out;
    
    xor_4 x1(a[3:0], b[3:0], out[3:0]);
    xor_4 x2(a[7:4], b[7:4], out[7:4]);
    xor_4 x3(a[11:8], b[11:8], out[11:8]);
    xor_4 x4(a[15:12], b[15:12], out[15:12]);
    xor_4 x5(a[19:16], b[19:16], out[19:16]);
    xor_4 x6(a[23:20], b[23:20], out[23:20]);
    xor_4 x7(a[27:24], b[27:24], out[27:24]);
    xor_4 x8(a[31:28], b[31:28], out[31:28]);

endmodule

module xnor_4(a,b,out);
    input [3:0] a,b;
    output [3:0] out;

    xnor(out[0],a[0],b[0]);
    xnor(out[1],a[1],b[1]);
    xnor(out[2],a[2],b[2]);
    xnor(out[3],a[3],b[3]);
endmodule

module xnor_32(out,a,b);
    input [31:0] a,b;
    output [31:0] out;
    
    xnor_4 x1(a[3:0], b[3:0], out[3:0]);
    xnor_4 x2(a[7:4], b[7:4], out[7:4]);
    xnor_4 x3(a[11:8], b[11:8], out[11:8]);
    xnor_4 x4(a[15:12], b[15:12], out[15:12]);
    xnor_4 x5(a[19:16], b[19:16], out[19:16]);
    xnor_4 x6(a[23:20], b[23:20], out[23:20]);
    xnor_4 x7(a[27:24], b[27:24], out[27:24]);
    xnor_4 x8(a[31:28], b[31:28], out[31:28]);

endmodule

module alu5(sayi1,sayi2,select,cout_add,cout_sub,out);
    input [31:0] sayi1,sayi2,not_sayi2,or_sonuc,and_sonuc;
    input [2:0] select;
    wire slt;
    wire [31:0] a,b,c,d,e,f,g,h;
    wire [31:0] out1,out2;
    output [31:0] out;
    output cout_add,cout_sub;
    
    full_adder_32 add(sayi1,sayi2,select[0],a,cout_add);

    not_32 n1(sayi2,not_sayi2);
    full_adder_32 sub(sayi1,not_sayi2,select[0],e,cout_sub);

    and_32 and1(b,sayi1,sayi2);
    xor_32 xor1(f,sayi1,sayi2);

    not(slt,cout_sub);
    assign g = {31'b0,slt};

    mux_4_1 mux1(a,b,c,d,select[2:1],out1);
    mux_4_1 mux2(e,f,g,h,select[2:1],out2);
    mux_2_32 mux3(out1,out2,select[0],out);
endmodule