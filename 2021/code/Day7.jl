# --------------------------------------------------------------------#
#                               part 1                               #
# --------------------------------------------------------------------#
cost(pos::Vector{Int64}, final::Int64) = sum(abs, pos .- final)

function min_cost(pos::Vector{Int64})
    res = Inf
    final = 0
    for possible in minimum(pos):maximum(pos)
        cur_cost = cost(pos, possible)
        if cur_cost < res
            res = cur_cost
            final = possible
        end
    end

    return final, res
end

positions = parse.(Int64, split(readline("input/input7.dat"), ','))
final_pos, minimum_cost = min_cost(positions)
println("With a minimum cost of $minimum_cost all crabs should go to $final_pos.")

# --------------------------------------------------------------------#
#                               part 2                               #
# --------------------------------------------------------------------#

function crab_cost(pos::Vector{Int64}, final::Int64)
    dists = abs.(pos .- final)
    return sum(x -> sum(1:x), dists)
end

function min_crab_cost(pos::Vector{Int64})
    res = Inf
    final = 0
    for possible in minimum(pos):maximum(pos)
        cur_cost = crab_cost(pos, possible)
        if cur_cost < res
            res = cur_cost
            final = possible
        end
    end

    return final, res
end

positions = parse.(Int64, split(readline("input/input7.dat"), ','))
final_pos, minimum_cost = min_crab_cost(positions)
println("Using the crabs formula, with a minimum cost of $minimum_cost all crabs should go to $final_pos.")
