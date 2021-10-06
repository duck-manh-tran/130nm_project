import numpy as np
# phase = np.genfromtxt(result.txt, dtype=<class 'double'>, delimiter=" ")
with open("result.txt", "r") as txt_file:
        input_data = [list(map(str, line.split())) for line in txt_file];
txt_file.close()
index = [row[0] for row in input_data]
index = list(map(int, index))
output_data = []
for i in range(2, len(index)):
	if index[i] > index[i-1]+3:
		output_data.append(input_data[i+3])

np.savetxt("data.txt", output_data, delimiter=" ", newline = "\n", fmt="%s")
