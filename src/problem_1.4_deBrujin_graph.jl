using DrWatson
@quickactivate "Bioinformatics_Algorithms"
using LinearAlgebra
# using LinearAlgebra: triu, tril

data = "data/dataset_30183_6.txt"
kstring, seq_string = readlines(data)
k = parse(Int, kstring)

function get_kmers(seq, k; offs=2)
    [seq[i:i+k-offs] for i in 1:length(seq)-k+offs]
end

function get_deBruijn(data_string, k)
    kmers = get_kmers(data_string, k)
    dic = Dict(k => String[] for k in kmers)
    for kmer in kmers
        prefix = kmer[1:k-1]
        suffix = kmer[2:end]
        push!(dic[prefix], suffix)
    end
    return dic
end

open("solutions/deBruijn.txt", "w") do file
    dic = get_deBruijn(seq_string, k)
    for (key, value) in dic
        write(file, key * ": " * join(value, " ") * "\n")
    end
end

# some junk



# function get_overlaps(kmers; remove_diag=true)
#     k = length(kmers[1]) + 1
#     overlaps = zeros(Int, length(kmers), length(kmers))
#     for (i, kmer_i) in enumerate(kmers)
#         for (j, kmer_j) in enumerate(kmers)
#             if i != j
#                 has_overlap(kmer_i, kmer_j, k) && (overlaps[i, j] = 1)
#             end
#         end
#     end
#     return overlaps
# end

# function has_overlap(a, b, k)
#     offs = k - 2
#     a[end-offs+1:end] == b[1:offs]
# end

