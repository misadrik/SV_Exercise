//`include "uvm_macros.svh"
//import uvm_pkg::*;

class ring_sequencer extends uvm_sequencer #(ring_transaction);
    //Component
    extern function new (string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    //extern task ring_sequencer::main_phase(uvm_phase phase);

    //Register
    `uvm_component_utils(ring_sequencer)
endclass

function ring_sequencer::new(string name , uvm_component parent);
    super.new(name,parent);
endfunction
/*task ring_sequencer::main_phase(uvm_phase phase);//sequence通过如下方式启动
    ring_sequence my_seq;//实例化一个sequence
    super.main_phase(phase);
    my_seq = new("my_seq");//调用my_seq的start参数，传入的参数是input_agt.sqr,
    //需要指明这个sequence会向那个sequencer发送数据，
    my_seq.starting_phase = phase;
    my_seq.start(this);//my_seq的body开始执行
endtask*/
function void ring_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
//ring_sequencer是一个参数化的类，其参数是ring_transaction,用于表明这个
//sequencer只能产生ring_transaction类型的数据
