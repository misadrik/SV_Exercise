//`include "uvm_macros.svh"
//import uvm_pkg::*;

class hello_sequencer extends uvm_sequencer #(hello_transaction);
    //Component
    extern function new (string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    //extern task hello_sequencer::main_phase(uvm_phase phase);

    //Register
    `uvm_component_utils(hello_sequencer)
endclass

function hello_sequencer::new(string name , uvm_component parent);
    super.new(name,parent);
endfunction
/*task hello_sequencer::main_phase(uvm_phase phase);//sequence通过如下方式启动
    hello_sequence my_seq;//实例化一个sequence
    super.main_phase(phase);
    my_seq = new("my_seq");//调用my_seq的start参数，传入的参数是input_agt.sqr,
    //需要指明这个sequence会向那个sequencer发送数据，
    my_seq.starting_phase = phase;
    my_seq.start(this);//my_seq的body开始执行
endtask*/
function void hello_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction
//hello_sequencer是一个参数化的类，其参数是hello_transaction,用于表明这个
//sequencer只能产生hello_transaction类型的数据
