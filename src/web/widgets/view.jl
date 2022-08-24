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

@inline back!(we::QWebEngineView) = we.obj.back()
@inline forward!(we::QWebEngineView) = we.obj.forward()

@inline has_selection(we::QWebEngineView) = pyconvert(Bool, we.obj.hasSelection())
@inline icon_url(we::QWebEngineView) = pyconvert(QUrl, we.obj.iconUrl())

@inline load!(we::QWebEngineView, url::QUrl) = we.obj.load(url)
@inline load_started!(we::QWebEngineView) = we.obj.loadStarted()
@inline reload!(we::QWebEngineView) = we.obj.reload()

@inline selected_text(we::QWebEngineView) = pyconvert(String, we.obj.selectedText())
@inline set_html!(we::QWebEngineView, html::String) = we.obj.setHtml(html)
@inline set_url!(we::QWebEngineView, url::QUrl) = we.obj.setUrl(url)
@inline set_zoom_factor!(we::QWebEngineView, f::AbstractFloat) = we.obj.setZoomFactor(f)

@inline stop!(we::QWebEngineView) = we.obj.stop()
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