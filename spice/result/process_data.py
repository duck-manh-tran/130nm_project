import numpy as np
# phase = np.genfromtxt(result.txt, dtype=<class 'double'>, delimiter=" ")
with open("result.txt", "r") as txt_file:
        input_data = [list(map(str, line.split())) for line in txt_file];
txt_file.close()
np.savetxt("data.txt", input_data, delimiter=" ", newline = "\n", fmt="%s")
