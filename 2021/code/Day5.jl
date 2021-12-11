# --------------------------------------------------------------------#
#                               part 1                               #
# --------------------------------------------------------------------#

struct Line
    x1::Int64
    y1::Int64
    x2::Int64
    y2::Int64
end

function Line(rep::String) 
    p1_s, p2_s = split(rep, " -> ")
    x1, y1 = parse.(Int64, split(p1_s, ','))
    x2, y2 = parse.(Int64, split(p2_s, ','))

    return Line(x1, y1, x2, y2)
end

function covered(l::Line, diagonal=false)
    if l.x1 == l.x2
        if l.y1 <= l.y2
            return [(l.x1, y) for y in l.y1:l.y2]
        else
            return [(l.x1, y) for y in l.y2:l.y1]
        end
    elseif l.y1 == l.y2
        if l.x1 <= l.x2
            return [(x, l.y1) for x in l.x1:l.x2]
        else
            return [(x, l.y1) for x in l.x2:l.x1]
        end
    else
        if diagonal
            if l.x1 < l.x2
                if l.y1 < l.y2
                    return map((x, y) -> (x, y), l.x1:l.x2, l.y1:l.y2)
                else
                    return map((x, y) -> (x, y), l.x1:l.x2, l.y1:-1:l.y2)
                end
            else
                if l.y1 < l.y2
                    return map((x, y) -> (x, y), l.x1:-1:l.x2, l.y1:l.y2)
                else
                    return map((x, y) -> (x, y), l.x1:-1:l.x2, l.y1:-1:l.y2)
                end
            end
        else
            return Tuple{Int64,Inf64}[]
        end
    end
end

function max_pos(lines::Vector{Line})
    xmax = maximum(map(l -> max(l.x1, l.x2), lines))
    ymax = maximum(map(l -> max(l.y1, l.y2), lines))

    return (xmax, ymax) .+ (1, 1)
end

struct Diagram
    lines::Vector{Line}
    grid::Matrix{Int64}
end

function Diagram(lines::Vector{Line}, diagonal=false)
    grid = zeros(Int64, max_pos(lines)...)

    for l in lines
        for pos in covered(l, diagonal)
            pos = pos .+ (1, 1)
            grid[pos...] += 1
        end
    end
    
    return Diagram(lines, grid)
end

function read_diagram(path::String, diagonal=false)
    lines = map(s -> Line(s), readlines(path))
    
    return Diagram(lines, diagonal)
end

function Base.show(io::Core.IO, d::Diagram)
    if size(d.grid, 1) > 20 || size(d.grid, 2) > 80
        println("to large to show!")
        println("$(length(d.lines)) Lines on a $(size(d.grid)) sized grid.")
    else
        for r in eachrow(d.grid')
            str = replace(foldl(*, string.(r)), '0' => '.')
            println(str)
        end
    end
    nothing
end

least_covered(d::Diagram, num=2) = count(>=(num), d.grid)

d = read_diagram("input/input5.dat")
println("Considering only horizontal and vertical lines, the answer is $(least_covered(d)).")
# --------------------------------------------------------------------#
#                               part 2                               #
# --------------------------------------------------------------------#

d2 = read_diagram("input/input5.dat", true)
println("Considering also diagonal lines, the answer is $(least_covered(d2)).")
