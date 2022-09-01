module QtGui 

import ..PyModules: pyQtGui
import ..QtCore: QRect, QSize, QPoint
import ..QtEnums: ScreenOrientation

using PythonCall: PythonCall, pyconvert_add_rule, pyconvert, Py


include("screen.jl")

function __init__()

    PPN  = PythonCall.PYCONVERT_PRIORITY_NORMAL
    pyconvert_add_rule("PySide2.QtGui:QScreen", QScreen, pyc_qscreen, PPN)

end

end