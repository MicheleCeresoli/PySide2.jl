module QtWebEngineWidgets 

using PythonCall: PythonCall, Py, pyconvert_add_rule, pyconvert

import ..PyModules: pyQtWebEngineWidgets
import ..QtWidgets: QWidget, size, x, y
import ..QtCore: QUrl

include("view.jl")


function __init__()

    PPN = PythonCall.PYCONVERT_PRIORITY_NORMAL
    pyconvert_add_rule("PySide2.QtWebEngineWidgets:QWebEngineView", QWebEngineView, pyc_qwew, PPN)

end

end