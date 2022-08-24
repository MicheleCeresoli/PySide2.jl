
module QtCore 

using PythonCall: PythonCall, pynew, pyimport, pycopy!, 
                  pyconvert_add_rule, pyconvert, Py

const pyQtCore = pynew() # initially NULL


include("qt.jl")

include("qpoint.jl")
include("qsize.jl")
include("qline.jl")
include("qmargins.jl")
include("qrect.jl")
include("qurl.jl")

# include("qurl.jl")

function __init__()

    pycopy!(pyQtCore, pyimport("PySide2.QtCore"))

    # Registers new custom rules for Python to Julia conversion
    PPN = PythonCall.PYCONVERT_PRIORITY_NORMAL

    objs = (:QSize, :QPoint, :QLine, :QMargins, :QRect, :QUrl)
    for obj in objs
        typ = string(obj) 
        pyconvert_add_rule("PySide2.QtCore:"*typ, eval(obj), 
            eval(Symbol("pyc_", lowercase(typ))), PPN)
    end

end

end