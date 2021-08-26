#!/bin/bash
awk '{
	if($2=="1.8000"){
		print $0
	}else{
		print("000")
	}	
	
}' hspice_vco_tb.tr0.printtr0 > data_hspice.txt
