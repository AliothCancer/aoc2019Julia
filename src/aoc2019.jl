module aoc2019

include("day_interface.jl")
include("day01.jl")
include("day02.jl")

using .Day01
using .Day02


input_dir = joinpath(@__DIR__, "..", "input")

#Day01.solve(input_dir,1)
Day02.testing()
#Day02.solve(input_dir, 2)




end # module aoc2019
