#!/bin/bash
paste clk.txt  ro_vco_w6_1.txt ro_vco_w6_2.txt ro_vco_w6_3.txt ro_vco_w6_4.txt > tmp
#	sed -i '1,6d' tmp 
#	sed -i -e '/---/d' -e '/Index/d' tmp
#	sed -i -e '/---/d' -e '/Index/d' tmp
#	sed -i '/^[[:space:]]*$/d' tmp
#	sed -i '1,6d' tmp
awk '{$5=$6=$10=$11=$15=$16=$20=$21=""; print $0}' tmp > tmp1
awk '{
	if($4=="1.800000e+00"){
		print $0

	}	

}' tmp1 > result.txt
rm tmp1 tmp
