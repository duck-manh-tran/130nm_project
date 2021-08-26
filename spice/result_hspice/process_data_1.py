import numpy as np

with open("phase_data.txt", "r") as txt_file:
        input_data = [list(map(str, line.split())) for line in txt_file];
txt_file.close()
index = np.array(input_data, dtype=np.float32)
output_data = np.round(index/1.6, 0 )

np.savetxt("data_2.txt", output_data, delimiter=" ", newline = "\n", fmt="%d")

