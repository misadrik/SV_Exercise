//`include "uvm_macros.svh"
//import uvm_pkg::*;

class hello_agent extends uvm_agent;
    hello_sequencer sqr;
    hello_driver drv;
    hello_monitor mon;

    extern function new (string name,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    uvm_analysis_port#(hello_transaction) ap;

    `uvm_component_utils_begin(hello_agent)
        `uvm_field_object(sqr,UVM_ALL_ON)
        `uvm_field_object(drv,UVM_ALL_ON)
        `uvm_field_object(mon,UVM_ALL_ON)
    `uvm_component_utils_end
endclass

function hello_agent::new(string name ,uvm_component parent);
    super.new(name,parent);
endfunction

function void hello_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        sqr = hello_sequencer::type_id::create("sqr",this);
        drv = hello_driver::type_id::create("drv",this);
    end
    else begin
        mon = hello_monitor::type_id::create("mon",this);
    end
endfunction

function void hello_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
        this.ap = drv.ap;
    end
    else begin
        this.ap = mon.ap;
    end
endfunction
