module PyModules 

using PythonCall: pynew, pycopy!, pyimport

const pyQtGui = pynew()
const pyQtCore = pynew()
const pyQtWidgets = pynew()
const pyQtWebEngineWidgets = pynew()

function __init__()

    pycopy!(pyQtGui, pyimport("PySide2.QtGui"))
    pycopy!(pyQtCore, pyimport("PySide2.QtCore"))
    pycopy!(pyQtWidgets, pyimport("PySide2.QtWidgets"))
    pycopy!(pyQtWebEngineWidgets, pyimport("PySide2.QtWebEngineWidgets"))

end

end