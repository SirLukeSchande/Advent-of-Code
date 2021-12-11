# --------------------------------------------------------------------#
#                               part 1                               #
# --------------------------------------------------------------------#

mutable struct Lanternfish
    timer::Int64
end

mutable struct School
    fish::Vector{Lanternfish}
    day::Int64
end

School(list::String) = School(map(t -> Lanternfish(parse(Int64, t)), split(list, ',')), 0)

function Base.show(io::Core.IO, s::School)
    day_str = if s.day == 0 
        "Initial state: " 
    elseif s.day  == 1 
        "After  1 day:  " 
    elseif s.day < 9
        "After  $(s.day) days: "
    else
        "After $(s.day) days: "
    end

    fish_str = join(map(f -> string(f.timer), s.fish), ',')

    println(day_str * fish_str) 

    nothing
end

read_school(path::String) = School(readline(path))

function step!(s::School)
    new_fish = Lanternfish[]
    for f in s.fish
        if f.timer > 0
            f.timer -= 1
        else
            f.timer = 6 
            push!(new_fish, Lanternfish(8))
        end
    end
    append!(s.fish, new_fish)
    s.day += 1

    
    nothing
end

function simulate!(s::School, days::Int64, verbose=false)
    for _ in 1:days
        step!(s)
        verbose && println(s)
    end

    nothing
end

function fish_after_days!(s::School, days::Int64)
    simulate!(s, days)

    return length(s.fish)
end

s = read_school("input/input6.dat")
days = 80
num_fish = fish_after_days!(s, days)

println("The school has $num_fish fish after $days days.")

# --------------------------------------------------------------------#
#                               part 2                               #
# --------------------------------------------------------------------#

