# --------------------------------------------------------------------#
#                               Part 1                               #
# --------------------------------------------------------------------#
function final_pos()
    pos = [0,0]
    commands = readlines("input/input2.dat")

    for cmd in commands
        direction, unit_str = split(cmd, ' ')
        unit = parse(Int, unit_str)

        if direction == "forward"
            pos[1] += unit
        elseif direction == "down"
            pos[2] += unit
        elseif direction == "up"
            pos[2] -= unit
        else
            error("Unknown direction")
        end
    end

    return pos
end

x, y = final_pos()
println("In the end, the submarine is at ($x,$y). So the answer is $(x * y).")

# --------------------------------------------------------------------#
#                               Part 2                               #
# --------------------------------------------------------------------#

function correct_final_pos()
    pos = [0,0]
    aim = 0
    commands = readlines("input/input2.dat")

    for cmd in commands
        direction, unit_str = split(cmd, ' ')
        unit = parse(Int, unit_str)

        if direction == "forward"
            pos[1] += unit
            pos[2] += unit * aim
        elseif direction == "down"
            aim += unit
        elseif direction == "up"
            aim -= unit
        else
            error("Unknown direction")
        end
    end

    return pos
end

x, y = correct_final_pos()
println("Actually, the submarine ends up at ($x,$y). So the answer is $(x * y).")
