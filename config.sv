class env extends uvm_env;
`uvm_component_utils(env)

function new(string path="env",uvm-component parent=null);
super.new(path,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase)

if(