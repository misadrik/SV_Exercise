`include "ring_env.sv"

import uvm_pkg::*;
import ring_pkg::*;

class ring_test extends uvm_test;
    ring_env env;
    extern function new(string name = "ring_test",uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    `uvm_component_utils(ring_test)

endclass

function ring_test::new(string name = "ring_test",uvm_component parent = null);
    super.new(name,parent);
    env = new("env",this);
endfunction

function void ring_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction



class ring_case extends ring_test;
    extern function new(string name = "ring_case",uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    `uvm_component_utils(ring_case);
endclass

function ring_case::new(string name = "ring_case",uvm_component parent = null);
    super.new(name,parent);
endfunction//new

function void ring_case::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //通知env.i_agt.sqr,让其运行到main_phase时自动启动前面定义的ring_sequence
    uvm_config_db#(uvm_object_wrapper)::set(this,"env.input_agt.sqr.main_phase","default_sequence",ring_sequence::type_id::get());
endfunction
