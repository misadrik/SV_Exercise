//`include "uvm_macros.svh"
import uvm_pkg::*;
import hello_pkg::*;
//`include "hello_pkg.sv"

class hello_scoreboard extends uvm_scoreboard;
    hello_transaction expect_queue [$];
    uvm_blocking_get_port #(hello_transaction) exp_port;//用于从reference model获取数据
    uvm_blocking_get_port #(hello_transaction) act_port;//用于从monitor的ap获取数据
    `uvm_component_utils(hello_scoreboard)

    extern function new (string name,uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
endclass

function hello_scoreboard::new(string name,uvm_component parent);
    super.new(name,parent);
endfunction

function void hello_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port",this);
    act_port = new("act_port",this);
endfunction

task hello_scoreboard::main_phase(uvm_phase phase);
    hello_transaction get_export,get_actual,tmp_tran;
    bit result;

    super.main_phase(phase);
    fork 
        while(1) begin//从reference model获取数据
            exp_port.get(get_export);
            expect_queue.push_back(get_export);
        end
        while(1) begin//从monitor获取数据
            act_port.get(get_actual);
            if(expect_queue.size()>0) begin
                tmp_tran = expect_queue.pop_front(); 
                result = get_actual.compare(tmp_tran);
                if(result) begin
                    $display("Compare SUCCESSFULLY");
                end
                else begin
                    $display("Compare FAILED");
                    $display("the expect pkt is");
                    tmp_tran.print();
                    $display("the actual pkt is");
                    get_actual.print();
                end
            end
            else begin
                $display("ERROR::Received from DUT,while Expect Queue is empty");
                get_actual.print();
            end
        end
    join 
endtask

