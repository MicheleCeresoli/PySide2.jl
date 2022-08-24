
export QMainWindow, document_mode, icon_size, is_animated, 
is_dock_nesting_enabled, is_separator, set_animated!, 
set_central_widget!, set_dock_nesting_enabled!, 
set_document_mode!, set_icon_size!, size,
unified_title_and_toolbar_on_mac!, show!

# Remember show! equals show_widget but is more clear only for QWindows

"""
QWindow <: QWidget 
"""
struct QMainWindow <: QWidget 
obj::Py
end

QMainWindow() = QMainWindow(pyQtWidgets.QMainWindow())

# Implements the conversion from the Python QRect object to the Julia type.
@inline pyc_qmainwindow(S, p::Py) = PythonCall.pyconvert_return(QMainWindow(p))

@inline document_mode(w::QMainWindow) = pyconvert(Bool, w.obj.documentMode())
@inline icon_size(w::QMainWindow) = pyconvert(QSize, w.obj.iconSize())

@inline is_animated(w::QMainWindow) = pyconvert(Bool, w.obj.isAnimated())
@inline is_dock_nesting_enabled(w::QMainWindow) = pyconvert(Bool, w.obj.isDockNestingEnabled())
@inline is_separator(w::QMainWindow, pos::QPoint) = pyconvert(Bool, w.obj.isSeparator(pos))

@inline set_animated!(w::QMainWindow, e::Bool) = w.obj.setAnimated(e)
@inline set_central_widget!(w::QMainWindow, wdg::QWidget) = w.obj.setCentralWidget(wdg)  

@inline set_dock_nesting_enabled!(w::QMainWindow, e::Bool) = w.obj.setDockNestingEnabled(e)
@inline set_document_mode!(w::QMainWindow, e::Bool) = w.obj.setDocumentMode(e)
@inline set_icon_size!(w::QMainWindow, qs::QSize) = w.obj.setIconSize(qs)

@inline show!(w::QMainWindow) = show_widget(w)

@inline unified_title_and_toolbar_on_mac!(w::QMainWindow) = 
 pyconvert(Bool, w.obj.unifiedTitleAndToolBarOnMac())

@inline size(q::QMainWindow) = pyconvert(QSize, q.obj.size())

function Base.show(io::IO, ::MIME"text/plain", w::QMainWindow) 

title, sz = window_title(w), size(w)
xi, yi, wi, he = x(w), y(w), sz.width, sz.height

printstyled(io, "QWindow", bold=true)
print(": \"$title\" at ($xi, $yi) with size ($wi, $he)")

end