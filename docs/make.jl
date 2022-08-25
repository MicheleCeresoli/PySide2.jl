
using Documenter
using PySide2

makedocs(;
    modules=[PySide2],
    authors="Michele Ceresoli <michele.ceresoli@mail.polimi.it>",
    sitename="PySide2.jl",
    repo="https://micheleceresoli.github.io/PySide2.jl/blob/{commit}{path}#{line}",
    format = Documenter.HTML(canonical="https://micheleceresoli.github.io/PySide2.jl/stable/"),

    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "git@github.com:MicheleCeresoli/PySide2.jl.git",
)
