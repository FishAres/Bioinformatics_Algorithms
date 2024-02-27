using DrWatson
@quickactivate "Bioinformatics_Algorithms"

data = "data/dataset_30182_3.txt"
ovr = split(readlines(data)[1], " ")

overlap_to_seq(data) = string(data[1], join([k[end] for k in data[2:end]]))
out = overlap_to_seq(ovr)

open("overlap_answers_0.txt", "w") do file
    write(file, out)
end
