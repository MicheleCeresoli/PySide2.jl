export QUrl, clear, has_fragment, has_query, file_name

"""
    QUrl 

This type provides a convenient interface for working with URLs. It is the julia 
representation of `PySide.QtCore.QUrl`.
"""

mutable struct QUrl 
    url::String 
end

# Constructs an empty QUrl object
QUrl() = QUrl("")

# Implements the conversion from the Julia QUrl object to the python type. 
PythonCall.Py(s::QUrl) = pyQtCore.QUrl(s.url)

# Implements the conversion from the Python QUrl object to the Julia type.
function pyc_qurl(S, p::Py) 
    url = pyconvert(String, p.url())
    PythonCall.pyconvert_return(QUrl(url))
end

Base.:(==)(x::QUrl, y::QUrl) = cmp(x.url, y.url) == 0
Base.:(!=)(x::QUrl, y::QUrl) = cmp(x.url, y.url) != 0

@inline clear(qu::QUrl) = qu.url = "" 

@inline has_fragment(qu::QUrl) = occursin('#', qu.url)
@inline has_query(qu::QUrl) = occursin('?', qu.url)

Base.isempty(qu::QUrl) = Base.isempty(qu.url)

function file_name(qu::QUrl)
    # da sistemare con decodeoptions!
    idx = findlast('/', qu.url)

    if idx === nothing
        return qu 
    elseif idx == length(idx)
        return ""
    else 
        return qu.url[idx+1:end]
    end
end