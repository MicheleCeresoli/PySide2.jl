
module QtCore 

using PythonCall: PythonCall, pyconvert_add_rule, pyconvert, Py

import ..PyModules: pyQtCore
import ..QtEnums

include("qpoint.jl")
include("qsize.jl")
include("qline.jl")
include("qmargins.jl")
include("qrect.jl")
include("qurl.jl")

# include("qurl.jl")

function __init__()

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