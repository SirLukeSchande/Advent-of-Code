# --------------------------------------------------------------------#
#                               Part 1                               #
# --------------------------------------------------------------------#

function larger_measurements()
    sonar_input = map(l -> parse(Int, l), readlines("input/input1.dat"))

    return count(diff(sonar_input) .> 0)
end

println("$(larger_measurements()) measurements are larger than the one before.")


# --------------------------------------------------------------------#
#                               Part 2                               #
# --------------------------------------------------------------------#

function walking_window(func::Function, x::AbstractVector, n::Int)
    res = Vector{Number}(undef, length(x) - n + 1)

    for i in eachindex(res)
        res[i] = func(x[i:(i + n - 1)])
    end

    return res
end

function larger_sum_measurements()
    sonar_input = map(l -> parse(Int, l), readlines("input/input1.dat"))

    sonar_sum3 = walking_window(sum, sonar_input, 3)

    return count(diff(sonar_sum3) .> 0)
end

println("$(larger_sum_measurements()) sums of measurements are larger than the sum before.")
