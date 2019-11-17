//`include "uvm_macros.svh"
//import uvm_pkg::*;

class hello_monitor extends uvm_monitor;
    virtual hello_if vif;
    uvm_analysis_port #(hello_transaction) ap;
    extern function new (string name,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern task receive_one_pkt(ref hello_transaction get_pkt);
    extern task get_one_byte(ref logic valid,ref logic [7:0] data);
    `uvm_component_utils(hello_monitor)
endclass

function hello_monitor::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void hello_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual hello_if)::get(this,"","hello_if",vif))
        uvm_report_fatal("hello_monitor","Error in Geting Interface");
    ap = new("ap",this);
endfunction

task hello_monitor::main_phase(uvm_phase phase);
    logic valid;
    logic [7:0] data;
    hello_transaction tr;
    super.main_phase(phase);
    while(1) begin
        tr = new();
        receive_one_pkt(tr);
        //$display("monitor_send_scoreboard pkt is:");
        //tr.print();
        //$display("\n");
        ap.write(tr);
    end
endtask

task hello_monitor::get_one_byte(ref logic valid ,ref logic [7:0] data );
    @vif.mon_cb;
    data = vif.mon_cb.txd;
    valid = vif.mon_cb.tx_en;
endtask

task hello_monitor::receive_one_pkt(ref hello_transaction get_pkt);
    byte unsigned data_q[$];//一个字节队列
    byte unsigned data_array[];
    logic [7:0] data;
    logic valid =0;
    int data_size;

    while(valid !== 1) begin//检查一个合法的data，当读到的valid为1时，不再执行该指令
        get_one_byte(valid,data);
    end

    while(valid) begin//当valid为1时，
        data_q.push_back(data);//在队列的尾部插入data
        get_one_byte(valid,data);//得到data
    end

    data_size = data_q.size();//返回队列的长度
    data_array = new[data_size];
    for(int i=0;i<data_size;i++) begin
        data_array[i]=data_q[i];
    end
    get_pkt.pload = new[data_size -18];//da sa ,e_type,crc
    data_size = get_pkt.unpack_bytes(data_array)/8;

endtask
