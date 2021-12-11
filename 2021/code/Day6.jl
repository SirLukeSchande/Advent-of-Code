# --------------------------------------------------------------------#
#                               part 1                               #
# --------------------------------------------------------------------#

mutable struct Lanternfish
    timer::Int64
end

mutable struct ExplicitSchool
    fish::Vector{Lanternfish}
    day::Int64
end

ExplicitSchool(list::String) = ExplicitSchool(map(t -> Lanternfish(parse(Int64, t)), split(list, ',')), 0)

function Base.show(io::Core.IO, s::ExplicitSchool)
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

read_explicit_school(path::String) = ExplicitSchool(readline(path))

function step!(s::ExplicitSchool)
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

function simulate!(s::ExplicitSchool, days::Int64, verbose=false)
    for _ in 1:days
        step!(s)
        verbose && println(s)
    end

    nothing
end

function fish_after_days!(s::ExplicitSchool, days::Int64)
    simulate!(s, days)

    return length(s.fish)
end

s = read_explicit_school("input/input6.dat")
days = 80
num_fish = fish_after_days!(s, days)

println("The school has $num_fish fish after $days days.")

# --------------------------------------------------------------------#
#                               part 2                               #
# --------------------------------------------------------------------#

mutable struct School
    timers::Vector{Int64}
end

function School(list::String)
    timers = zeros(Int64, 9)
    for t in parse.(Int64, split(list, ','))
        timers[t + 1] += 1
    end

    return School(timers)
end

read_school(path::String) = School(readline(path))

function step!(s::School)
    new_timers = Vector{Int64}(undef, 9)

    new_timers[1:8] = s.timers[2:9]
    new_timers[7] += s.timers[1] 
    new_timers[9] = s.timers[1]

    s.timers = new_timers
    nothing
end

function simulate!(s::School, days::Int64)
    for _ in 1:days
        step!(s)
    end
    
    nothing
end


function fish_after_days!(s::School, days::Int64)
    simulate!(s, days)

    return sum(s.timers)
end


s = read_school("input/input6.dat")
days = 256
num_fish = fish_after_days!(s, days)

println("The school has $num_fish fish after $days days.")
