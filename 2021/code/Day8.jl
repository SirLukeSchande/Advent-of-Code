# --------------------------------------------------------------------#
#                               part 1                               #
# --------------------------------------------------------------------#

inputs = map(l -> split(l, " | "), readlines("input/input8.dat"))
appearences = Dict(1 => 0, 4 => 0, 7 => 0, 8 => 0)

for inpt in inputs
    tests, code = map(s -> split(s), inpt)


    for segments in code
        num_segs = length(segments)
        if num_segs == 2
            # the numer is a 1
            # ciphers[segments] => "1"
            appearences[1] += 1
        elseif num_segs == 3
            # the number is a 7
            appearences[7] += 1
        elseif num_segs == 4
            # the number is a 4
            appearences[4] += 1
        elseif num_segs == 7
            # the number is an 8
            appearences[8] += 1
        end
    end

end

println("The numbers 1, 4, 7, 8 appeare $(sum(values(appearences))) in total.")



# --------------------------------------------------------------------#
#                               part 2                               #
# --------------------------------------------------------------------#

for inpt in inputs
    tests, code = map(s -> split(s), inpt)

    ciphers = Dict()
    positions = Dict()

    for segments in tests
        num_segs = length(segments)
        if num_segs == 2
            # the numer is a 1
            ciphers[segments] = 1

            # check if you know which segment is the top
            if 7 in values(ciphers)
                segments7 = collect(keys(ciphers))[findfirst(==(7), collect(values(ciphers)))]
                top = only(symdiff(segments7, segments))
            end
        elseif num_segs == 3
            # the number is a 7
            ciphers[segments] = 7

            # check if you know which segment is the top
            if 1 in values(ciphers)
                segments1 = collect(keys(ciphers))[findfirst(==(1), collect(values(ciphers)))]
                top = only(symdiff(segments1, segments))
                positions[:top] = top
            end
             
        elseif num_segs == 4
            # the number is a 4
            appearences[4] += 1
        elseif num_segs == 7
            # the number is an 8
            appearences[8] += 1
        end

    end
    println(ciphers)

end
