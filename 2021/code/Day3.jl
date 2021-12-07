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


function reduced_diagnostic(most_common::Bool)
    col = 1
    res = read_matrix("input/input3.dat")

    while size(res, 1) > 1
        if most_common
            res = res[res[:,col] .== most_common_bit(res[:,col]),:]
        else
            res = res[res[:,col] .!= most_common_bit(res[:,col]),:]
        end
        col = mod(col, size(res, 2)) + 1
    end
    
    return res
end


function ratings()
    oxygen_generator_bin = reduced_diagnostic(true)
    co2_scrubber_bin = reduced_diagnostic(false)

    oxygen_generator_rating = parse(Int, join(string.(oxygen_generator_bin)), base=2)
    co2_scrubber_rating = parse(Int, join(string.(co2_scrubber_bin)), base=2)

    return oxygen_generator_rating, co2_scrubber_rating
end

oxygen_generator_rating, co2_scrubber_rating = ratings()
println("The oxygen generator rating and the co2 scrubber rating are $oxygen_generator_rating and $co2_scrubber_rating, respectively.")
println("The answer to part two is $(oxygen_generator_rating * co2_scrubber_rating)")
