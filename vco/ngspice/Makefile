all: osc_tb_b
osc_tb_i:
	ngspice -r ./result/ring_osc_tb.raw -b ring_osc_tb.spice

osc_tb_b:
	ngspice -o ./result/ring_osc.log -b ring_osc_tb.spice 
	
.PHONY: osc_tb_b

cci_tb_b:
	ngspice -o ./result/crs_cpl_inv.log -r ./result/crs_cpl_inv_test.raw -b ./crs_cpl_inv_tb.spice

.PHONY: cci_tb_b

inv_tb_b:
	ngspice -o ./result/inv_test.log -r ./result/inv_cell_tb.raw  -b ./inv_cell_tb.spice 

.PHONY: inv_tb_b

gui: 
	gaw &	
clean:

.PHONY: gui clean
