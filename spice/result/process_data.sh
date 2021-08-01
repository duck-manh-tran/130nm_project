#!/bin/bash
paste phase_vco_w6_r100_1.txt phase_vco_w6_r100_2.txt phase_vco_w6_r100_3.txt phase_vco_w6_r100_4.txt > tmp
sed -i '1,6d' tmp  
sed -i -e '/---/d' -e '/Index/d' tmp
sed -i '/^[[:space:]]*$/d' tmp
sed -i '1,256d' tmp
awk '{$6=$7=$11=$12=$16=$17=""; print $0}' tmp > result.txt
