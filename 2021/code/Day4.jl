# --------------------------------------------------------------------#
#                               Part 1                               #
# --------------------------------------------------------------------#

struct Bingo
    numbers::Matrix{Int64}
    marked::Matrix{Bool}

    Bingo(numbers::Matrix{Int64}) = new(numbers, fill(false, size(numbers)...))
end

function Bingo(raw::Vector{String})
    numbers = Matrix{Int64}(undef, length(raw), length(raw))

    for i in eachindex(raw)
        row = parse.(Int, split(raw[i]))
        for j in eachindex(row)
            numbers[i,j] = row[j]
        end
    end

    return Bingo(numbers)
end

function Base.show(io::Core.IO, b::Bingo)
    string_b = string.(b.numbers) .* map(m -> m ? "x" : " ", b.marked)
    for l in eachrow(string_b)
        println(join(l, " "))
    end
end

"Mark a number of the bingo board `b` at position `(i,j)`."
function mark!(b::Bingo, i::Int, j::Int)
    b.marked[i,j] = true

    nothing
end

"Mark a number of the bingo board `b` at position `ci`."
function mark!(b::Bingo, ci::CartesianIndex{2})
    b.marked[ci] = true

    nothing
end

"Mark a number of the bingo board `b` at all positions `vci`."
function mark!(b::Bingo, vci::Vector{CartesianIndex{2}})
    for ci in vci
        b.marked[ci] = true
    end

    nothing
    end

"Check if `num` is in `b`."
function check(b::Bingo, num::Int)
    pos = findall(==(num), b.numbers)

    if length(pos) == 1
        return only(pos)
    else
    return pos
    end
end
    
function mark!(b::Bingo, num::Int)
    pos = check(b, num)
    if !isnothing(pos) 
        mark!(b, pos)
    end

    nothing
end

    "Check if a row in `b` is completed."
function row_completed(b::Bingo)
    for r in eachrow(b.marked)
        all(r) && return true
    end
    return false
    end

"Check if a col in `b` is completed."
function col_completed(b::Bingo)
    for c in eachcol(b.marked)
        all(c) && return true
    end
    return false
end

    "Check if `b` is completed"
completed(b::Bingo) = row_completed(b) || col_completed(b)

Base.sum(b::Bingo) = sum(b.numbers[.!(b.marked)])

function read_file()
    lines = readlines("input/input4.dat")

    rand_numbers = lines[1]
    rest = lines[3:end]

    split_lines = findall(==(""), rest)

    bings = Bingo[]
    for i = 2:length(split_lines)
        m = rest[split_lines[i - 1] + 1:split_lines[i] - 1]
        push!(bings, Bingo(m))
    end

    return parse.(Int, split(rand_numbers, ',')), bings
end

function find_first_completed()
    rand_numbers, bs = read_file()

    for n in rand_numbers
        mark!.(bs, n)
        if any(completed.(bs))
            winner = only(bs[completed.(bs)])
            return n, winner, n * sum(winner)
        end
    end
end

n, winner, answer = find_first_completed()
println("The last number called was $n. The winning board is:\n")
println(winner)
println("The answer is $answer.")

# --------------------------------------------------------------------#
#                               Part 2                               #
# --------------------------------------------------------------------#


function find_last_completed()
    rand_numbers, bs = read_file()

    for n in rand_numbers
        mark!.(bs, n)
        if all(completed.(bs))
            winner = only(bs[completed.(bs)])
            return n, winner, n * sum(winner)
        end
    end
end
