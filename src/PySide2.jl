module PySide2

export QtEnums, QtCore, QtGui, QtWidgets, QtWebEngineWidgets, 
# export QtCore, QtWidgets, QtWebEngineWidgets, QtGui

include("py/modules.jl")
include("enums/Enums.jl")

include("core/Core.jl")
include("gui/Gui.jl")
include("widgets/Widgets.jl")
include("web/WebEngine.jl")

import .PyModules, .QtEnums
import .QtCore, .QtGui, .QtWidgets, .QtWebEngineWidgets


using PythonCall: PythonCall

const app = PythonCall.pynew()

# # in futuro questo va spostato da qui 
# function start_qapp(interval=0.01)
#     instnc = QtWidgets.pyQtWidgets.QApplication.instance()
#     if PythonCall.pytruth(instnc)
#         PythonCall.pycopy!(app, instnc)
#     else
#         sys = PythonCall.pyimport("sys")
#         PythonCall.pycopy!(app, QtWidgets.pyQtWidgets.QApplication(sys.argv))
#     end

#     PythonCall.event_loop_on(:pyside2; interval=interval, fix=false); 
#     nothing
# end


function __init__()
end

end