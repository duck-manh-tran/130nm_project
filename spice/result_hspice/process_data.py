import numpy as np
# phase = np.genfromtxt(result.txt, dtype=<class 'double'>, delimiter=" ")
with open("data_hspice.txt", "r") as txt_file:
        input_data = [list(map(str, line.split())) for line in txt_file];
txt_file.close()
index = [row[0] for row in input_data]
output_data = []
for i in range(1, len(index)-1):
	if index[i]=="000" and index[i+1]!="000":
		output_data.append(input_data[i+2])

np.savetxt("data.txt", output_data, delimiter=" ", newline = "\n", fmt="%s")
