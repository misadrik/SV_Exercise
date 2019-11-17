//`include "uvm_macros.svh"
//import uvm_pkg::*;

class ring_model extends uvm_component;

    uvm_blocking_get_port #(ring_transaction) port;//用于接收一个uvm_analysis_port发送的信息
    uvm_analysis_port #(ring_transaction) ap;//用来发送信息给scoreboard，使用这种方式来实现transaction级别的通信

    extern function new(string name,uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(ring_model)
endclass

function ring_model::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void ring_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new ("port",this);
    ap = new("ap",this);
endfunction

task ring_model::main_phase(uvm_phase phase);
    ring_transaction tr;
    super.main_phase(phase);
    while(1) begin
        port.get(tr);//接收到一个transaction
        //$display("reference_model_send_socreboard pkt is:");
        //tr.print();
        ap.write(tr);//发送这个transaction
    end
endtask

