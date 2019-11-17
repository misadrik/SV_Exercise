interface ring_if(input logic txc,input logic rxc);

    logic                   node0_pesi;         //input
    logic  [63:0]           node0_pedi;         //input
    logic                   node0_peri;        //output
    logic                   node0_pero;         //input
    logic                   node0_peso;        //output
    logic [63:0]            node0_pedo;        //output
    logic                   node0_polarity;        //output

    logic                   node1_pesi;         //input
    logic  [63:0]           node1_pedi;         //input
    logic                   node1_peri;        //output
    logic                   node1_pero;         //input
    logic                   node1_peso;        //output
    logic [63:0]            node1_pedo;        //output
    logic                   node1_polarity;        //output

    logic                   node2_pesi;         //input
    logic  [63:0]           node2_pedi;         //input
    logic                   node2_peri;        //output
    logic                   node2_pero;         //input
    logic                   node2_peso;        //output
    logic [63:0]            node2_pedo;        //output
    logic                   node2_polarity;        //output

    logic                   node3_pesi;         //input
    logic  [63:0]           node3_pedi;         //input
    logic                   node3_peri;        //output
    logic                   node3_pero;         //input
    logic                   node3_peso;        //output
    logic [63:0]            node3_pedo;        //output
    logic                   node3_polarity;     //output


    //from model to DUT
    clocking drv_cb @(posedge rxc);
        output #1 node0_pesi, node0_pedi, node0_pero;
        output #1 node1_pesi, node1_pedi, node1_pero;
        output #1 node2_pesi, node2_pedi, node2_pero;
        output #1 node3_pesi, node3_pedi, node3_pero;
    endclocking
    
    clocking mon_cb @(posedge txc);
        input #1 node0_peri, node0_peso, node0_pedo, node0_polarity;
        input #1 node1_peri, node1_peso, node1_pedo, node1_polarity;
        input #1 node2_peri, node2_peso, node2_pedo, node2_polarity;
        input #1 node3_peri, node3_peso, node3_pedo, node3_polarity;
    endclocking

endinterface
