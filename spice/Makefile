
run_spice:
	ngspice ring_osc_tb.spice
result:
	sed -e '1,5d;61,63d' ./result/vco.txt > ./result/vco_mlab.txt
	sed -e '1,5d;61,63d' ./result/vco_r100.txt > ./result/vco_r100_mlab.txt
	sed -e '1,5d;61,63d' ./result/vco_w6_r100.txt > ./result/vco_w6_mlab.txt
	sed -i '1 i index,Vin,Vcrt,freq,clc' ./result/vco_mlab.txt
	sed -i '1 i index,Vin,Vcrt,freq,clc' ./result/vco_r100_mlab.txt
	sed -i '1 i index,Vin,Vcrt,freq,clc' ./result/vco_w6_mlab.txt
	sed -i 's/\t/,/g' ./result/vco_mlab.txt
	sed -i 's/\t/,/g' ./result/vco_r100_mlab.txt
	sed -i 's/\t/,/g' ./result/vco_w6_mlab.txt
	sed -i 's/,\n/\n/g' ./result/vco_mlab.txt
	sed -i 's/,\n/\n/g' ./result/vco_r100_mlab.txt
	sed -i 's/,\n/\n/g' ./result/vco_w6_mlab.txt
#	matlab -batch mode
#
	matlab -batch VCO = readtable('vco_mlab.txt') \
	VCO(:, all(ismissing(VCO),1)) = [] \
	VCO = readtable('vco_mlab.txt')
.PHONY:	run_spice result
