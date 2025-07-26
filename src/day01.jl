module Day01

import ..DayInterface: parse_input, solve, testing, load_input


parse_row(row)::Int = parse(Int, row)
parse_input(input::String)::AbstractVector{Int} = input |> split .|> parse_row

compute_fuel1(mass::Number) = div(mass, 3) - 2
solve1(input::String) = (
    input
    |> parse_input
    .|> compute_fuel1
    |> sum
)

function compute_fuel2(mass::Number)::Int
    n = compute_fuel1(mass)
    if n > 0
        return n + compute_fuel2(n)
    else
        0
    end
end

function testing()
    @assert (compute_fuel1(1969) +
        compute_fuel1(654)+
        compute_fuel1(216)+
        compute_fuel1(70)+
        compute_fuel1(21) + 0) == compute_fuel2(1969)
end

solve2(input) = (
    input
    |> parse_input
    .|> compute_fuel2
    |> sum
)

function solve(input_path::String, day::Int)
    input = load_input(input_path, day)
    println(
        "Part 1: ", solve1(input), "\n",
        "Part 2: ", solve2(input), "\n"
    )
end



end