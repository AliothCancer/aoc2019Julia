module Day02


using Pipe;
using Base.Iterators;
import ..DayInterface: load_input

function parse_input(input::String)
    input
end

function solve(input_dir, day)
    input = load_input(input_dir, day)
    println(input, day)

end


abstract type Token end
inner(token::Token)::UInt = token.value
function Base.show(io::IO, t::Token)
    print(io,
        "Token($(t.value))"
    )
end

struct Add <: Token
    value::Int
end
struct Mul <: Token
    value::Int
end
struct Index <: Token
    value::Int
end
struct Stop <: Token
    value::Int
end

function Base.show(io::IO, t::Add)
    print(io, "Add(", t.value, ")")
end

function Base.show(io::IO, t::Mul)
    print(io, "Mul(", t.value, ")")
end

function Base.show(io::IO, t::Index)
    print(io, "Index(", t.value, ")")
end

function Base.show(io::IO, t::Stop)
    print(io, "Stop(", t.value, ")")
end
TOKEN_MAPPER = Dict(
    "1" => Add(1),
    "2" => Mul(2),
    "99" => Stop(99)
)
function tokenizer(num::AbstractString)::Token
    @pipe TOKEN_MAPPER |> get(_, num, Index(parse(Int, num)))
end

struct Program
    raw::Vector{Int}
    tokenized::Vector{Token}
end

read_raw(prog::Program, tok::Token) = prog.raw[inner(tok)+1]

function write_raw!(prog::Program, position::UInt, value::Int)
    prog.raw[position+1] = value
end
mutable struct Executor
    zeroth::Union{Add,Mul,Stop} # specify op: + or * or Halt 
    first::Token # specify pos of first term
    second::Token # specify pos of second term
    third::Token # specify where to assign result
end
function Base.show(io::IO, e::Executor)
    println(io, "Executor(
    zeroth: $(e.zeroth)
    first: $(e.first)
    second: $(e.second)
    third: $(e.third)
    )")
end

"""
Return true if encountered a Stop token
"""
function execute(prog::Program,ex::Executor)::Bool
    if ex.zeroth isa Stop
        return true
    elseif ex.zeroth isa Mul
        op = *
    elseif ex.zeroth isa Add
        op = +
    end
    first_val = read_raw(prog, ex.first)
    second_val = read_raw(prog, ex.second)
    result = op(
        first_val,
        second_val
        )
    println("Read: $(first_val) $(op) $(second_val) = $(result)")
    write_raw!(
        prog, 
        inner(ex.third),
        result
    )
    false
end
function testing()
    examples = Dict(
        #    input               =>  output
        "1,0,0,0,99" => "2,0,0,0,99",
        "2,3,0,3,99" => "2,3,0,6,99",
        "2,4,4,5,99,0" => "2,4,4,5,99,9801",
        "1,1,1,4,99,5,6,0,99" => "30,1,1,4,2,5,6,0,99"
    )

    input = "1,9,10,3,2,3,11,0,99,30,40,50"
    input = split(input, ',')
    prog = Program(
        parse.(Int, input), 
        tokenizer.(input)
    )
    stop = false
    
    for instructions in partition(prog.tokenized, 4) 
        println("\n\n",instructions)
        ex = Executor(instructions...)
        execute(
            prog,
            ex
        )
    end
    
    println("\n$(prog.raw)\n")
end


end