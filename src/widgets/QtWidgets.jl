module QtWidgets

export QWidget, children_rect, close, contents_margins, contents_rect,
       frame_geometry, frame_size, geometry, has_focus, has_height_for_width, 
       has_mouse_tracking, has_tablet_tracking, height_for_width, hide, 
       is_active_window, is_enabled, is_fullscreen, is_hidden, is_left_to_right, 
       is_maximised, is_minimised, is_modal, is_right_to_left, is_toplevel,
       is_visible, is_window, is_window_modified, maximum_height, maximum_size,
       maximum_width, minimum_height, minimum_size, minimum_width, normal_geometry, 
       pos, raise, rect, release_keyboard, release_mouse, repaint!, resize!, 
       scroll, set_accept_drops!, set_accessible_description!, 
       set_accessible_name!, set_autofill_background!, set_base_size!,
       set_contents_margins!, set_disabled!, set_enabled!, set_fixed_height!, 
       set_fixed_width!, set_fixed_size!, set_geometry!, set_hidden!, 
       set_maximum_height!, set_maximum_size!, set_maximum_width!,
       set_minimum_height!, set_minimum_size!, set_minimum_width!,  
       set_mouse_tracking!, set_tooltip_duration!, set_updates_enabled!, 
       set_visible!, set_window_icon_text!, set_window_opacity!, set_window_title!, 
       show_widget, show_fullscreen, show_maximised, show_minimised, show_normal, 
       size, size_hint, size_increment, status_tip, tooltip, tooltip_duration, 
       under_mouse, update!, update_geometry!, updates_enabled, window_title, x, y

using PythonCall
import PythonCall: pyconvert_add_rule

import ..QtCore: QRect, QLine, QMargins, 
                 QPoint, QSize, QUrl

"""
    QWidget 

Abstract type interface for the `QWidget` base class. `QWidget` is the atom of 
the user interface: it receives mouse, keyboard and other events from the window 
system, and paints a representation of itself on the screen. Every widget is 
rectangular, and they are sorted in a Z-order. A widget is clipped by its parent 
and by the widget in front of it.
    
### Notes 
For a compact Julia interface, each concrete subtype of `QWidget` has to inherit 
the Python class object in a field named `obj`. 
"""
abstract type QWidget end 

# Implements the conversion from any Julia QWidget object to the python type. 
PythonCall.Py(qw::QWidget) = qw.obj
ispy(::QWidget) = true


"""
    window_title(qw::QWidget)

Return the window title (caption). 

### Input 

- `qw` -- Concrete subtype of `QWidget`.

### Output 

String containing the title. If no caption has been set, the title is an empty 
string.  

### Notes 
The title property and so this function only make sense for top-level widgets, 
such as windows and dialogs. 
"""

@inline children_rect(qw::QWidget) = pyconvert(QRect, qw.obj.childrenWidget())
@inline close(qw::QWidget) = pyconvert(Bool, qw.obj.close())

@inline contents_margins(qw::QWidget) = pyconvert(QMargins, qw.obj.contentsMargins())
@inline contents_rect(qw::QWidget) = pyconvert(QRect, qw.obj.contentsRect())

@inline frame_geometry(qw::QWidget) = pyconvert(QRect, qw.obj.frameGeometry())
@inline frame_size(qw::QWidget) = pyconvert(QSize, qw.obj.frameSize())
@inline geometry(qw::QWidget) = pyconvert(QRect, qw.obj.geometry())

@inline has_focus(qw::QWidget) = pyconvert(Bool, qw.obj.hasFocus())
@inline has_height_for_width(qw::QWidget) = pyconvert(Bool, qw.obj.hasHeightForWidth())
@inline has_mouse_tracking(qw::QWidget) = pyconvert(Bool, qw.obj.hasMouseTracking())
@inline has_tablet_tracking(qw::QWidget) = pyconvert(Bool, qw.obj.hasTabletTracking())

@inline height_for_width(qw::QWidget) = pyconvert(Int, qw.obj.heightForWidth())

@inline function hide(qw::QWidget) 
    qw.obj.hide()
    nothing 
end

@inline is_active_window(qw::QWidget) = pyconvert(Bool, qw.obj.isActiveWindow())
@inline is_enabled(qw::QWidget) = pyconvert(Bool, qw.obj.isEnabled())
@inline is_fullscreen(qw::QWidget) = pyconvert(Bool, qw.obj.isFullScreen())
@inline is_hidden(qw::QWidget) = pyconvert(Bool, qw.obj.isHidden())
@inline is_left_to_right(qw::QWidget) = pyconvert(Bool, qw.obj.isLeftToRight())
@inline is_maximised(qw::QWidget) = pyconvert(Bool, qw.obj.isMaximized())
@inline is_minimised(qw::QWidget) = pyconvert(Bool, qw.obj.isMinimized())
@inline is_modal(qw::QWidget) = pyconvert(Bool, qw.obj.isModal())
@inline is_right_to_left(qw::QWidget) = pyconvert(Bool, qw.obj.isRightToLeft())
@inline is_toplevel(qw::QWidget) = pyconvert(Bool, qw.obj.isTopLevel())
@inline is_visible(qw::QWidget) = pyconvert(Bool, qw.obj.isVisible())
@inline is_window(qw::QWidget) = pyconvert(Bool, qw.obj.isWindow())
@inline is_window_modified(qw::QWidget) = pyconvert(Bool, qw.obj.isWindowModified())

@inline maximum_height(qw::QWidget) = pyconvert(Int, qw.obj.maximumHeight())
@inline maximum_size(qw::QWidget) = pyconvert(QSize, qw.obj.maximumSize())
@inline maximum_width(qw::QWidget) = pyconvert(Int, qw.obj.maximumWidth())
@inline minimum_height(qw::QWidget) = pyconvert(Int, qw.obj.minimumHeight())
@inline minimum_size(qw::QWidget) = pyconvert(QSize, qw.obj.minimumSize())
@inline minimum_size_hint(qw::QWidget) = pyconvert(QSize, qw.obj.minimumSizeHint())
@inline minimum_width(qw::QWidget) = pyconvert(Int, qw.obj.minimumWidth())

@inline normal_geometry(qw::QWidget) = pyconvert(QRect, qw.obj.normalGeometry())

@inline pos(qw::QWidget) = pyconvert(QPoint, qw.obj.pos())
function pos(qw::QWidget, val::Symbol) 
    if val == :x 
        return pyconvert(Int, qw.obj.x())
    elseif val == :y 
        return pyconvert(Int, qw.obj.y())
    else 
        error("Wrong position type.")
    end
end

@inline function raise(qw::QWidget)
    qw.obj.raise_()
    nothing 
end

@inline rect(qw::QWidget) = pyconvert(QRect, qw.obj.rect())

@inline function release_keyboard(qw::QWidget)
    qw.obj.releaseKeyboard()
    nothing 
end

@inline function release_mouse(qw::QWidget)
    qw.obj.releaseMouse()
    nothing 
end

@inline function repaint!(qw::QWidget, x::Int, y::Int, w::Int, h::Int)
    qw.obj.repaint(x, y, w, h)    
    nothing 
end

@inline function repaint!(qw::QWidget, qr::QRect)
    qw.obj.repaint(qr)
    nothing 
end

@inline function resize!(qw::QWidget, qs::QSize)
    qw.obj.resize(qs)
    nothing 
end

@inline function resize!(qw::QWidget, w::Int, h::Int)
    qw.obj.resize(w, h)    
    nothing 
end

@inline function scroll(qw::QWidget, dx::Int, dy::Int)
    qw.obj.scroll(dx, dy)
    nothing 
end

@inline function set_accept_drops!(qw::QWidget, on::Bool)
    qw.obj.setAcceptDrops(on)
    nothing 
end

@inline function set_accessible_description!(qw::QWidget, ds::String)
    qw.obj.setAccessibleDescription(ds)
    nothing 
end

@inline function set_accessible_name!(qw::QWidget, n::String)
    qw.obj.setAccessibleName(n)
    nothing 
end

@inline function set_autofill_background!(qw::QWidget, e::Bool)
    qw.obj.setAutoFillBackground(e)
    nothing 
end

@inline function set_base_size!(qw::QWidget, qs::QSize)
    qw.obj.setBaseSize(qs)
    nothing 
end

@inline function set_base_size!(qw::QWidget, w::Int, h::Int)
    qw.obj.setBaseSize(w, h)
    nothing 
end

@inline function set_contents_margins!(qw::QWidget, qm::QMargins)
    qw.obj.setContentsMargins(qm)
    nothing 
end

@inline function set_contents_margins!(qw::QWidget, l::Int, t::Int, r::Int, b::Int)
    qw.obj.setContentsMargins(l, t, r, b)
    nothing 
end

@inline function set_disabled!(qw::QWidget, d::Bool)
    qw.obj.setDisabled(d)
    nothing 
end

@inline function set_enabled!(qw::QWidget, e::Bool)
    qw.obj.setEnabled(e)
    nothing 
end

@inline function set_fixed_height!(qw::QWidget, h::Int)
    qw.obj.setFixedHeight(h)
    nothing 
end

@inline function set_fixed_size!(qw::QWidget, qs::QSize)
    qw.obj.setFixedSize(qs)
    nothing 
end

@inline function set_fixed_size!(qw::QWidget, w::Int, h::Int)
    qw.obj.setFixedSize(w, h)
    nothing 
end

@inline function set_fixed_width!(qw::QWidget, w::Int)
    qw.obj.setFixedWidth(w)
    nothing 
end

@inline function set_geometry!(qw::QWidget, qr::QRect)
    qw.obj.setGeometry(qr)
    nothing 
end

@inline function set_geometry!(qw::QWidget, x::Int, y::Int, w::Int, h::Int) 
    qw.obj.setGeometry(x, y, w, h)
    nothing 
end

@inline function set_hidden!(qw::QWidget, h::Bool)
    qw.obj.setHidden(h)
    nothing 
end

@inline function set_maximum_height!(qw::QWidget, h::Int)
    qw.obj.setMaximumHeight(h)
    nothing 
end

@inline function set_maximum_size!(qw::QWidget, qs::QSize)
    qw.obj.setMaximumSize(qs)
    nothing 
end

@inline function set_maximum_size!(qw::QWidget, w::Int, h::Int)
    qw.obj.setMaximumSize(w, h)
    nothing 
end

@inline function set_maximum_width!(qw::QWidget, w::Int)
    qw.obj.setMaximumWidth(w)
    nothing 
end

@inline function set_minimum_height!(qw::QWidget, h::Int)
    qw.obj.setMinimumHeight(h)
    nothing 
end

@inline function set_minimum_size!(qw::QWidget, qs::QSize)
    qw.obj.setMinimumSize(qs)
    nothing 
end

@inline function set_minimum_size!(qw::QWidget, w::Int, h::Int)
    qw.obj.setMinimumSize(w, h)
    nothing 
end

@inline function set_minimum_width!(qw::QWidget, w::Int)
    qw.obj.setMinimumWidth(w)
    nothing 
end

@inline function set_mouse_tracking!(qw::QWidget, e::Bool)
    qw.obj.setMouseTracking(e)
    nothing 
end

@inline function set_size_increment!(qw::QWidget, qs::QSize)
    qw.obj.setSizeIncrement(qs)
    nothing 
end

@inline function set_size_increment!(qw::QWidget, w::Int, h::Int)
    qw.obj.setSizeIncrement(w, h)
    nothing 
end

@inline function set_status_tip!(qw::QWidget, tip::String)
    qw.obj.setStatusTip(tip)
    nothing 
end

@inline function set_tablet_tracking!(qw::QWidget, e::Bool)
    qw.obj.setTabletTracking(e)
    nothing 
end

@inline function set_tooltip_duration!(qw::QWidget, msec::Int)
    qw.obj.setToolTipDuration(msec)
    nothing 
end

@inline function set_updates_enabled!(qw::QWidget, e::Bool)
    qw.obj.setUpdatesEnabled(e)
    nothing 
end

@inline function set_visible!(qw::QWidget, v::Bool)
    qw.obj.setVisible(v)
    nothing 
end

@inline function set_window_icon_text!(qw::QWidget, txt::String)
    qw.obj.setWindowIconText(txt)
    nothing 
end

@inline function set_window_opacity!(qw::QWidget, op::AbstractFloat)
    qw.obj.setWindowOpacity(op)
    nothing 
end


"""
    set_window_title!(qw::QWidget, title::String)

Update the window title (caption). 

### Input 

- `qw`    -- Concrete subtype of `QWidget` that is to be updated. 
- `title` -- New title string. 

### Notes 

The title property and so this function only make sense for top-level widgets, 
such as windows and dialogs. 
"""
@inline function set_window_title!(qw::QWidget, title::String)
    qw.obj.setWindowTitle(pystr(title))
    nothing 
end

@inline function show_widget(qw::QWidget)
    qw.obj.show()
    nothing 
end

@inline function show_fullscreen(qw::QWidget)
    qw.obj.showFullScreen()
    nothing 
end

@inline function show_maximised(qw::QWidget)
    qw.obj.showMaximised()
    nothing 
end

@inline function show_minimised(qw::QWidget)
    qw.obj.showMinimised()
    nothing 
end

@inline function show_normal(qw::QWidget)
    qw.obj.showNormal()
    nothing 
end

@inline size(qw::QWidget) = pyconvert(QSize, qw.obj.size())
@inline size_hint(qw::QWidget) = pyconvert(QSize, qw.obj.sizeHint())
@inline size_increment(qw::QWidget) = pyconvert(QSize, qw.obj.sizeIncrement())

@inline status_tip(qw::QWidget) = pyconvert(String, qw.obj.statusTip())
@inline tooltip(qw::QWidget) = pyconvert(String, qw.obj.toolTip())
@inline tooltip_duration(qw::QWidget) = pyconvert(Int, qw.obj.toolTipDuration())

@inline under_mouse(qw::QWidget) = pyconvert(Bool, qw.obj.underMouse())

@inline function update!(qw::QWidget)
    qw.obj.update()
    nothing 
end

@inline function update!(qw::QWidget, qr::QRect)
    qw.obj.update(qr)
    nothing 
end

@inline function update!(qw::QWidget, x::Int, y::Int, w::Int, h::Int) 
    qw.obj.update(x, y, w, h)
    nothing 
end
    
@inline function update_geometry!(qw::QWidget)
    qw.obj.updateGeometry()
    nothing 
end

@inline updates_enabled(qw::QWidget) = pyconvert(Bool, qw.obj.updatesEnabled())
@inline window_title(qw::QWidget) = pyconvert(String, qw.obj.windowTitle())

@inline x(qw::QWidget) = pyconvert(Int, qw.obj.x())
@inline y(qw::QWidget) = pyconvert(Int, qw.obj.y())

# @inline width(qw::QWidget) = pyconvert(Int, qw.obj.width())
# @inline height(qw::QWidget) = pyconvert(Int, qw.obj.height())

@inline parent_widget(qw::QWidget) = qw.obj.parentWidget() # DA MODIFICARE CON PY CONVERT IN FUTURO

include("qwindow.jl")
include("qlabel.jl")
include("qdesk.jl")
include("qapp.jl")

const pyQtWidgets = PythonCall.pynew() 

function __init__()

    PythonCall.pycopy!(pyQtWidgets, pyimport("PySide2.QtWidgets"))
    
    # Registers new custom rules for Python to Julia conversion
    PPN = PythonCall.PYCONVERT_PRIORITY_NORMAL
    pyconvert_add_rule("PySide2.QtWidgets:QMainWindow", QMainWindow, pyc_qmainwindow, PPN)
    pyconvert_add_rule("PySide2.QtWidgets:QLabel", QLabel, pyc_qlabel, PPN)
    pyconvert_add_rule("PySide2.QtWidgets:QDesktopWidget", QDesktopWidget, pyc_qdesk, PPN)
end

end