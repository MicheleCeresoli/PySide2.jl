
using Documenter
using PySide2

makedocs(;
    modules=[PySide2],
    authors="Michele Ceresoli <michele.ceresoli@mail.polimi.it>",
    sitename="PySide2.jl",
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "git@github.com:MicheleCeresoli/PySide2.jl.git",
)