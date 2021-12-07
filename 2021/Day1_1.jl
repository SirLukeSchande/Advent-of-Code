function larger_measurements()
    sonar_input = map(l -> parse(Int, l), readlines("input1.dat"))

    return count(diff(sonar_input) .> 0)
end

larger_measurements()
