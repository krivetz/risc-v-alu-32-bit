`include "s1.v"
module test1;

    reg [31:0] sayi1,sayi2;
    reg [2:0] select;

    wire cout_add,cout_sub;
    wire [31:0] out;
   
    alu5 a1(sayi1,sayi2,select,cout_add,cout_sub,out);

    initial begin
        // Test case 0
        sayi1 = 32'hFA0000A7;
        sayi2 = 32'hABC000C2;
        select = 3'b000;
        #10;
        // Test case 1
        sayi1 = 32'h000000A7;
        sayi2 = 32'h000000C2;
        select = 3'b000;
        #10;
        // Test case 2
        sayi1 = 32'h000000A7;
        sayi2 = 32'h000000C2;
        select = 3'b001;
        #10;
        // Test case 3
        sayi1 = 32'h000000C2;
        sayi2 = 32'h000000A7;
        select = 3'b001;
        #10;
        // Test case 4
        sayi1 = 32'h000000A7;
        sayi2 = 32'h000000C2;
        select = 3'b010;
        #10;
        // Test case 5;
        sayi1 = 32'h000000A7;
        sayi2 = 32'h000000C2;
        select = 3'b011;
        #10;
        // Test case 6
        sayi1 = 32'h000000A7;
        sayi2 = 32'h000000C2;
        select = 3'b101;
        #10;
        // Test case 7
        sayi1 = 32'h000000C2;
        sayi2 = 32'h000000A7;
        select = 3'b101;
        #10;
        $finish;
    end

    initial begin
            $dumpfile("s1_vcd.vcd");
            $dumpvars(0, test1);
    end

endmodule