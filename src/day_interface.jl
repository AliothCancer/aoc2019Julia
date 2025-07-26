module DayInterface

export load_input

function generate_day_string(day::Int)::String
    n = string(day)
    len = length(n)
    if len == 1
        "day0" * n * ".txt"
    else
        "day" * n * ".txt"
    end
        
end

function load_input(input_path::String, day::Int)::String
    file_name = generate_day_string(day)
    input_path = joinpath(input_path, file_name)
    read(input_path, String)
end

"""
    parse_input(input::String) -> Any

Funzione da implementare nei moduli DayXX.
Parsa la stringa `input` e restituisce una rappresentazione adatta al solve.
"""
function parse_input(::String)
    error("parse_input not implemented in this module")
end

function solve(::String, ::Int)
    error("solve not implemented in this module")
end

function testing()
    println("No test defined for this day.")
end

end
