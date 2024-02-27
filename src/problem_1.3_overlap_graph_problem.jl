using DrWatson
@quickactivate "Bioinformatics_Algorithms"

datafile = "data/dataset_30182_10.txt"
kmers = split(readlines(datafile)[1], " ")

function prefix_suffix(kmer)
    k = length(kmer)
    return kmer[1:k-1], kmer[end-k+2:end]
end

@inline function find_overlaps(kmers)
    n = length(kmers)
    overlaps = zeros(Int, n, n)
    for i in eachindex(kmers)
        _, suf_i = prefix_suffix(kmers[i])
        for j in eachindex(kmers)
            pre_j, _ = prefix_suffix(kmers[j])
            # if prefix j is equal to suffix i, kmer[i] points to kmer[j]
            pre_j == suf_i && (overlaps[i, j] = 1)
        end
    end
    return overlaps
end

function write_adjacency_list!(kmers, filename)
    overlaps = find_overlaps(kmers)
    open(filename, "w") do file
        for (i, kmer) in enumerate(kmers)
            if sum(overlaps[i, :]) > 0
                write(file, (kmer * ": " * join(kmers[overlaps[i, :].==1], " ") * "\n"))
            end
        end
    end
end

@time write_adjacency_list!(kmers, "solutions/overlap_graph.txt")