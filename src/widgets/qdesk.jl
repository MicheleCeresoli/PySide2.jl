export QDesktopWidget


"""
    QDesktopWidget

The `QDesktopWidget` widget provides access to screen information on multi-head 
systems. 
"""
struct QDesktopWidget <: QWidget 
    obj::Py 
end

QDesktopWidget() = QDesktopWidget(pyQtWidgets.QDesktopWidget())

# Implements the conversion from the Python QRect object to the Julia type.
@inline pyc_qdesk(S, d::Py) = PythonCall.pyconvert_return(QDesktopWidget(d))

@inline available_geometry(d::QDesktopWidget, w::QWidget) = 
    pyconvert(QRect, d.obj.availableGeometry(w))

@inline screen(d::QDesktopWidget, s::Int=-1) = pyconvert(QWidget, d.obj.screen(s))

@inline screen_geometry(d::QDesktopWidget, w::QWidget) = 
    pyconvert(QRect, d.obj.screenGeometry(w))

@inline screen_number(d::QDesktopWidget, w::QWidget) = 
    pyconvert(Int, d.obj.screenNumber(w))

@inline screen_number(d::QDesktopWidget) = pyconvert(Int, d.obj.screenNumber())
