module PySide2

export QtCore, QtWidgets

include("core/QtCore.jl")
include("widgets/QtWidgets.jl")
include("web/QWebEngine.jl")

import .QtCore, .QtWidgets
using PythonCall: PythonCall

const app = PythonCall.pynew()

function __init__()
    # sta riga da modificare in futuro!
    PythonCall.event_loop_on(:pyside2; interval=0.01, fix=false); 

    # Check whether an instance of QApplication is already running.
    instnc = QtWidgets.pyQtWidgets.QApplication.instance()
    if PythonCall.pytruth(instnc)
        PythonCall.pycopy!(app, instnc)
        # println("Using existing QApplication.")
    else
        sys = PythonCall.pyimport("sys")
        PythonCall.pycopy!(app, QtWidgets.pyQtWidgets.QApplication(sys.argv))
        # println("Created new QApplication.")
    end
end

end
