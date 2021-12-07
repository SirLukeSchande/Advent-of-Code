# --------------------------------------------------------------------#
#                               Part 1                               #
# --------------------------------------------------------------------#

function most_common_bit(x::AbstractVector{Int})
    if sum(x) / length(x) >= .5
        return 1
    else
        return 0
    end
end

function read_matrix(path::AbstractString)
    lines = readlines(path)

    return [parse(Int, lines[i][j]) for i in eachindex(lines), j in eachindex(first(lines))]
end

function rates()
    diagnostic = read_matrix("input/input3.dat")
    gamma_rate_bin = [most_common_bit(col) for col in eachcol(diagnostic)]
    epsilon_rate_bin = -(gamma_rate_bin .- 1)

    gamma = parse(Int, join(string.(gamma_rate_bin)), base=2)
    epsilon = parse(Int, join(string.(epsilon_rate_bin)), base=2)

    return gamma, epsilon
end

gamma, epsilon = rates()
println("The gamma rate is $gamma and the epsilon rate is $epsilon.\nSo the answer is $(gamma * epsilon).")

# --------------------------------------------------------------------#
#                               Part 2                               #
# --------------------------------------------------------------------#

