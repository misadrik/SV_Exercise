`include "hello_env.sv"

import uvm_pkg::*;
import hello_pkg::*;

class hello_test extends uvm_test;
    hello_env env;
    extern function new(string name = "hello_test",uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    `uvm_component_utils(hello_test)

endclass

function hello_test::new(string name = "hello_test",uvm_component parent = null);
    super.new(name,parent);
    env = new("env",this);
endfunction

function void hello_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction



class hello_case extends hello_test;
    extern function new(string name = "hello_case",uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    `uvm_component_utils(hello_case);
endclass

function hello_case::new(string name = "hello_case",uvm_component parent = null);
    super.new(name,parent);
endfunction//new

function void hello_case::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //֪ͨenv.i_agt.sqr,�������е�main_phaseʱ�Զ�����ǰ�涨���hello_sequence
    uvm_config_db#(uvm_object_wrapper)::set(this,"env.input_agt.sqr.main_phase","default_sequence",hello_sequence::type_id::get());
endfunction
