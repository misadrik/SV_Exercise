//`include "uvm_macros.svh"
import uvm_pkg::*;

class ring_driver extends uvm_driver #(ring_transaction);
    virtual ring_if vif;
    uvm_analysis_port #(ring_transaction) ap;

    `uvm_component_utils(ring_driver)

    extern function new(string name ,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern task drive_one_pkt(ring_transaction req);
    extern task drive_one_byte(bit [7:0] data);

endclass

function ring_driver::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void ring_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ring_if)::get(this,"","ring_if",vif))
        `uvm_fatal("gold_ring_driver","Error in Geting interface");
    ap = new ("ap",this);
endfunction

task ring_driver::main_phase(uvm_phase phase);
    ring_transaction req;
    super.main_phase(phase);//call super.main_phase,
    vif.drv_cb.node0_pedi <= 0;
    vif.drv_cb.node0_pesi <= 1'b0;//上两行初始化
    while(1) begin
        seq_item_port.get_next_item(req);//向req_item_port申请得到一个ring_transaction类型的item。
//seq_item_port,用于连接driver和sequencer的一个端口，driver想要发送数据要从该
//端口获得，sequencer如果有数据交给driver，也要通过该端口送给driver。
//从这个端口申请数据要调用这个端口的get_next_item方法，当数据驱动完毕时，要通过调用
//item_done来告知这个端口。
        drive_one_pkt(req);//调用drive_one_pkt将这个item发送出去
        //$display("driver pkt is:");
        //req.print();
        ap.write(req);//将发送出去的item放入ap，给reference model一份
        //$display("driver_send_reference_model pkt is:");
        //req.print();
        seq_item_port.item_done();//照应seq_item_port.get_item(req)
    end
endtask

task ring_driver::drive_one_pkt(ring_transaction req);
    byte unsigned data_q[];
    int data_size;
    data_size=req.pack_bytes(data_q)/8;
    repeat(3)@vif.drv_cb;
    for(int i=0;i<data_size;i++) begin
        drive_one_byte(data_q[i]);//drive data pattern
    end
    @vif.drv_cb;
    vif.drv_cb.node0_pesi <=1'b0;
endtask

task ring_driver::drive_one_byte(bit [7:0] data);
    @vif.drv_cb;
    vif.drv_cb.node0_pedi <= data;
    vif.drv_cb.node0_pesi <= 1'b1;
endtask


