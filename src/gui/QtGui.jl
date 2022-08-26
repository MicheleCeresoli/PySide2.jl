module QtGui 

import ..QtCore: QRect, QSize, QPoint
import ..QtCore.Qt: ScreenOrientation

using PythonCall: PythonCall, pynew, pyimport, pycopy!, 
                  pyconvert_add_rule, pyconvert, Py

const pyQtGui = pynew()

include("screen.jl")

function __init__()
    pycopy!(pyQtGui, pyimport("PySide2.QtGui"))

    PPN  = PythonCall.PYCONVERT_PRIORITY_NORMAL
    pyconvert_add_rule("PySide2.QtGui:QScreen", QScreen, pyc_qscreen, PPN)

end

end