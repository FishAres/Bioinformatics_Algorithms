using DrWatson
@quickactivate "Bioinformatics_Algorithms"
using LinearAlgebra, Statistics
using Combinatorics
using Plots

data = "data/kmer_comp.txt"
k, str = readlines(data)

function generate_kmers(input_string, k)
    kmers = []
    for i in 1:length(input_string)-k+1
        push!(kmers, input_string[i:i+k-1])
    end
    kmers
end

out = generate_kmers(str, parse(Int, k)) |> x -> join(x, " ")
open("kmer_answers_0.txt", "w") do file
    write(file, out)
end

