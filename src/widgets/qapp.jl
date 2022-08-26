
export QApplication 

struct QApplication <: QWidget
    obj::Py 
end

QApplication() = QApplication(pyQtWidgets.QApplication())

@inline function about_qt(q::QApplication)
    q.obj.aboutQt()
    nothing 
end 

@inline active_modal_widget(q::QApplication) = 
    pyconvert(QtWidget, q.obj.activeModalWidget())

@inline active_popup_widget(q::QApplication) = 
    pyconvert(QtWidget, q.obj.activePopupWidget())

@inline active_window(q::QApplication) = pyconvert(QWidget, q.obj.activeWindow())

@inline function alert(q::QApplication, w::QWidget; duration::Int = 0)
    q.obj.alert(w, duration)
end

# verificare pyconvert su liste
# @inline all_widgets()

@inline auto_sip_enabled(q::QApplication) = pyconvert(Bool, q.obj.autoSipEnabled())

@inline function beep(q::QApplication)
    q.obj.beep()
    nothing 
end

@inline function close_all_windows(q::QApplication)
    q.obj.closeAllWindows()
    nothing 
end

@inline cursor_flash_time(q::QApplication) = 
    pyconvert(Int, q.obj.cursorFlashTime())

@inline desktop(q::QApplication) = pyconvert(QDesktopWidget, q.obj.desktop())
@inline double_click_interval(q::QApplication) = 
    pyconvert(Int, q.obj.doubleClickInterval())

@inline function focus_changed!(q::QApplication, old::QWidget, new::QWidget)
    q.obj.focusChanged(old, new)
    nothing 
end

@inline focus_widget(q::QApplication) = pyconvert(QWidget, q.obj.focusWidget())

# manca font, font metrics 

@inline global_strut(q::QApplication) = pyconvert(QSize, q.obj.globalStrut())

# manca iseffectenabled

@inline keyboard_input_interval(q::QApplication) = 
    pyconvert(Int, q.obj.keyboardInputInterval())

# manca palette 

@inline function set_active_window!(q::QApplication, w::QWidget)
    q.obj.setActiveWindow(w)
    nothing 
end

@inline function set_auto_sip_enabled!(q::QApplication, e::Bool)
    q.obj.setAutoSipEnabled(e)
    nothing 
end

@inline function set_cursor_flash_time!(q::QApplication, t::Int)
    q.obj.setCursorFlashTime(t)
    nothing
end

@inline function set_double_click_interval!(q::QApplication, t::Int)
    q.obj.setDoubleClickInterval(t)
    nothing
end

# manca seteffectenabled, setfont 

@inline function set_global_strut!(q::QApplication, s::QSize)
    q.obj.setGlobalStrut(s)
    nothing 
end

@inline function set_keyboard_input_interval!(q::QApplication, t::Int)
    q.obj.setKeyboardInputInterval(t)
    nothing 
end

# manca setPalette

@inline function set_start_drag_distance!(q::QApplication, l::Int)
    q.obj.setStartDragDistance(l)
    nothing 
end

@inline function set_start_drag_time!(q::QApplication, ms::Int)
    q.obj.setStartDragTime(ms)
    nothing 
end

# manca set style

@inline function set_style_sheet!(q::QApplication, sheet::String)
    q.obj.setStyleSheet(sheet)
    nothing 
end

@inline function set_wheel_scroll_lines!(q::QApplication, a::Int)
    q.obj.setWheelScrollLines(a)
    nothing 
end

@inline start_drag_distance(q::QApplication) = 
    pyconvert(Int, q.obj.startDragDistance())

@inline start_drag_time(q::QApplication) = 
    pyconvert(Int, q.obj.startDragTime())

# manca style 

@inline style(q::QApplication) = pyconvert(String, q.obj.style())

@inline top_level_at(q::QApplication, x::Int, y::Int) = 
    pyconvert(QWidget, q.obj.topLevelAt(x, y))

# manca top level widgets per lista 

@inline wheel_scroll_lines(q::QApplication) = 
    pyconvert(Int, q.obj.wheelScrollLines())

@inline widget_at(q::QApplication, p::QPoint) = 
    pyconvert(QWidget, q.obj.widgetAt(p))

@inline widget_at(q::QApplication, x::Int, y::Int) = widget_at(q, QPoint(x, y))
