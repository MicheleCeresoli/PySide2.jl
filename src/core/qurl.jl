export QUrl, clear_url!, error_string, from_local_file, from_user_input, 
       has_fragment, has_query, is_local_file, is_parent_of, is_relative, 
       is_valid, port, resolved, scheme, set_port!, set_scheme!, set_url!, 
       swap!, to_local_file


"""
    QUrl 

This type provides a convenient interface for working with URLs. It is the julia 
representation of `PySide.QtCore.QUrl`.
"""

struct QUrl 
    url::Py 
end

# Implements the conversion from a Julia QUrl object to the python type. 
PythonCall.Py(u::QUrl) = u.url
ispy(::QUrl) = true

# Constructs an empty QUrl object
QUrl() = QUrl(pyQtCore.QUrl(""))


# Implements the conversion from the Python QUrl object to the Julia type.
function pyc_qurl(S, p::Py) 
    PythonCall.pyconvert_return(QUrl(p))
end

Base.:(==)(x::QUrl, y::QUrl) = cmp(x.url, y.url) == 0
Base.:(!=)(x::QUrl, y::QUrl) = cmp(x.url, y.url) != 0

#missing authority 

@inline function clear_url!(qu::QUrl)
    qu.url.clear()
    nothing 
end

@inline error_string(qu::QUrl) = pyconvert(String, qu.url.errorString())

# missing fileName()
# missing fragment 
# missing fromace, fromencoded 

@inline function from_local_file(filepath::String)
    pyconvert(QUrl, pyQtCore.QUrl.fromLocalFile(filepath))
end

@inline function from_user_input(input::String)
    pyconvert(QUrl, pyQtCore.QUrl.fromUserInput(input))
end

#missing from user input 2 

@inline has_fragment(qu::QUrl) = pyconvert(Bool, qu.url.hasFragment())
@inline has_query(qu::QUrl) = pyconvert(Bool, qu.url.hasQuery())

# missing host 

Base.isempty(qu::QUrl) = pyconvert(Bool, qu.url.isEmpty())
@inline is_local_file(qu::QUrl) = pyconvert(Bool, qu.url.isLocalFile())
@inline is_parent_of(q1::QUrl, q2::QUrl) = pyconvert(Bool, q1.url.isParentOf(q2))
@inline is_relative(qu::QUrl) = pyconvert(Bool, qu.url.isRelative())
@inline is_valid(qu::QUrl) = pyconvert(Bool, qu.url.isValid())

# missing matches, password, path

@inline port(qu::QUrl, default::Int=-1) = pyconvert(Int, qu.url.port(default))
#missing query 

@inline resolved(base::QUrl, rel::QUrl) = pyconvert(QUrl, base.url.resolved(rel))
@inline scheme(qu::QUrl) = pyconvert(String, qu.url.scheme())
# missing authority, setfragment , sethost, stIdnWhitelist, setpasword, setpath

@inline function set_port!(qu::QUrl, port::Int)
    qu.url.setPort(port)
    nothing 
end

#missing set query 

@inline function set_scheme!(qu::QUrl, scheme::String)
    qu.url.setScheme(scheme)
    nothing 
end

# da completare
@inline function set_url!(qu::QUrl, url::String) 
    qu.url.setUrl(url)
    nothing 
end

#missing setUserInfo, set user name

@inline function swap!(qu::QUrl, other::QUrl)
    qu.url.swap(other)
    nothing 
end 

@inline to_local_file(qu::QUrl) = pyconvert(String, qu.url.toLocalFile())

