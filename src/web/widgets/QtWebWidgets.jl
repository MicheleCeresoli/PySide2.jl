module QtWebEngineWidgets 

using PythonCall: PythonCall, Py, pyimport, pyconvert_add_rule,
                    pyconvert

import ..QtWidgets: QWidget, size, x, y
import ..QtCore: QUrl

include("view.jl")

const pyQtWebEngineWidgets = PythonCall.pynew()

function __init__()

    PPN = PythonCall.PYCONVERT_PRIORITY_NORMAL

    PythonCall.pycopy!(pyQtWebEngineWidgets, pyimport("PySide2.QtWebEngineWidgets"))
    pyconvert_add_rule("PySide2.QtWebEngineWidgets:QWebEngineView", QWebEngineView, pyc_qwew, PPN)

end

end