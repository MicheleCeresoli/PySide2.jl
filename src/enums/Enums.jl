module QtEnums 

import ..PyModules

import JSON3 
using PythonCall: PythonCall, pyconvert_add_rule, Py

artifact = read("src/enums/enums.json", String)
enum_data = JSON3.read(artifact)

const qt_enums_path = Vector{String}()

# Converts a string path into a submodules expression
function get_enum_path_expr(str::String, expr::Expr) 

    idx = findfirst('.', str)
    if idx === nothing
        push!(expr.args, QuoteNode(Symbol(str)))
        return expr
    else 
        @inbounds push!(expr.args, QuoteNode(Symbol(str[1:idx-1])))
        @inbounds str = str[idx+1:end]

        new_expr = Expr(:., expr)
        return get_enum_path_expr(str, new_expr)
    end

end

for en in enum_data

    super_type = Symbol(en[:name])
    mod = en[:path]

    # Populates a dictionary with the enum type and Python path
    push!(qt_enums_path, string(mod, ":", en[:name]))

    # Builds the @enum expression
    enum = Expr(:macrocall, Symbol("@enum"), :_, super_type)
    for sub_type in en[:types]
        push!(enum.args, Symbol(sub_type))
    end

    @eval $enum
     
    mod_path = string("py", mod[findfirst('.', mod)+1:end])
    conv = get_enum_path_expr(mod_path, Expr(:., :PyModules))

    # Registers the Julia-to-Python conversion 
    @eval begin  
            function PythonCall.Py(y::$super_type)
                getproperty($conv.$super_type, Symbol(y))
            end
    end

end

# This function converts all the python enumerables to Julia
function pyc_enum(::Any, y::Py)
    str = string(y)
    name = str[findlast('.', str)+1:end]
    return PythonCall.pyconvert_return(eval(Symbol(name)))
end

function __init__()

    # Registers all the Python-to-Julia conversions
    PPN = PythonCall.PYCONVERT_PRIORITY_NORMAL
    for enum in qt_enums_path
        pyconvert_add_rule(enum, Enum, pyc_enum, PPN)
    end

end

end