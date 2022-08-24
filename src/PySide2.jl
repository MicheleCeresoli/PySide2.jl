module PySide2

export QtCore, QtWidgets

include("core/QtCore.jl")
include("widgets/QtWidgets.jl")
include("web/QWebEngine.jl")

import .QtCore, .QtWidgets, .QtWebEngineWidgets
using PythonCall: PythonCall

const app = PythonCall.pynew()

# in futuro questo va spostato da qui 
function start_qapp(interval=0.01)
    instnc = QtWidgets.pyQtWidgets.QApplication.instance()
    if PythonCall.pytruth(instnc)
        PythonCall.pycopy!(app, instnc)
    else
        sys = PythonCall.pyimport("sys")
        PythonCall.pycopy!(app, QtWidgets.pyQtWidgets.QApplication(sys.argv))
    end

    PythonCall.event_loop_on(:pyside2; interval=interval, fix=false); 
end


function __init__()
end

end
