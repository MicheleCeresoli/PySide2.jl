export QWebEngineView, back!, forward!, has_selection, icon_url,
       load!, load_started!, reload!, selected_text, set_html!, 
       set_url!, set_zoom_factor!, stop!, title, url, zoom_factor

"""
    QWebEngineView 

This type is a julia interface for the `QWebEngineView` class, which provides a 
widget that is used to view and edit web documents. A web view is the main widget 
component of the Qt WebEngine web browsing module. It can be used in various 
applications to display web content live from the Internet.  
"""
struct QWebEngineView <: QWidget
    obj::Py
end

QWebEngineView() = QWebEngineView(pyQtWebEngineWidgets.QWebEngineView())

# Implements the conversion from the Python QRect object to the Julia type.
@inline pyc_qwew(S, p::Py) = PythonCall.pyconvert_return(QWebEngineView(p))

@inline function back!(we::QWebEngineView)
    we.obj.back()
    nothing 
end

@inline function forward!(we::QWebEngineView)
    we.obj.forward()
    nothing 
end

@inline has_selection(we::QWebEngineView) = pyconvert(Bool, we.obj.hasSelection())

@inline icon_url(we::QWebEngineView) = pyconvert(QUrl, we.obj.iconUrl())

@inline function load!(we::QWebEngineView, url::QUrl)
    we.obj.load(url)
    nothing 
end

@inline function load_started!(we::QWebEngineView)
    we.obj.loadStarted()    
    nothing 
end

@inline function reload!(we::QWebEngineView)
    we.obj.reload()
    nothing 
end

@inline selected_text(we::QWebEngineView) = pyconvert(String, we.obj.selectedText())

@inline function set_html!(we::QWebEngineView, html::String)
    we.obj.setHtml(html)
    nothing 
end

@inline function set_url!(we::QWebEngineView, url::QUrl)
    we.obj.setUrl(url)
    nothing 
end

@inline function set_zoom_factor!(we::QWebEngineView, f::AbstractFloat)
    we.obj.setZoomFactor(f)
    nothing 
end


@inline function stop!(we::QWebEngineView)
    we.obj.stop()
    nothing 
end

@inline title(we::QWebEngineView) = pyconvert(String, we.obj.title())

@inline url(we::QWebEngineView) = pyconvert(QUrl, we.obj.url())
@inline zoom_factor(we::QWebEngineView) = pyconvert(Float64, we.obj.zoomFactor())

function Base.show(io::IO, ::MIME"text/plain", w::QWebEngineView) 
    
    ul, sz = url(w).url, size(w)
    xi, yi, wi, he = x(w), y(w), sz.width, sz.height

    printstyled(io, "QWebEngineView", bold=true)
    print(": \"$ul\"\n")
    print(repeat(" ", 16), "at ($xi, $yi) with size ($wi, $he)")

end