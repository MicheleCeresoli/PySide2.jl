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

@inline function authority(
    qu::QUrl, 
    options::QtEnums.ComponentFormattingOption=QtEnums.PrettyDecoded)

    pyconvert(String, qu.url.authority(options))
end

@inline function clear_url!(qu::QUrl)
    qu.url.clear()
    nothing 
end

@inline error_string(qu::QUrl) = pyconvert(String, qu.url.errorString())

@inline function file_name(
    qu::QUrl, 
    options::QtEnums.ComponentFormattingOption=QtEnums.FullyDecoded)
    pyconvert(String, qu.url.fileName(options))
end

@inline function fragment(
    qu::QUrl, 
    options::QtEnums.ComponentFormattingOption=QtEnums.PrettyDecoded)
    pyconvert(String, qu.url.fragment(options))
end

# missing fromace, fromencoded, frompercentencoding, from string list

# @inline function from_string_list(uris, )

@inline function from_local_file(filepath::String)
    pyconvert(QUrl, pyQtCore.QUrl.fromLocalFile(filepath))
end

@inline function from_user_input(input::String)
    pyconvert(QUrl, pyQtCore.QUrl.fromUserInput(input))
end

@inline function from_user_input(input::String, dir::String, 
    options::QtEnums.UserInputResolutionOption=QtEnums.DefaultResolution)
    pyconvert(QUrl, pyQtCore.QUrl.fromUserInput(input, dir, options))
end


@inline has_fragment(qu::QUrl) = pyconvert(Bool, qu.url.hasFragment())
@inline has_query(qu::QUrl) = pyconvert(Bool, qu.url.hasQuery())

@inline function host(
    qu::QUrl, 
    arg::QtEnums.ComponentFormattingOption=QtEnums.FullyDecoded)
    pyconvert(String, qu.url.host(arg))
end

# missing idnwhitelist

Base.isempty(qu::QUrl) = pyconvert(Bool, qu.url.isEmpty())
@inline is_local_file(qu::QUrl) = pyconvert(Bool, qu.url.isLocalFile())
@inline is_parent_of(q1::QUrl, q2::QUrl) = pyconvert(Bool, q1.url.isParentOf(q2))
@inline is_relative(qu::QUrl) = pyconvert(Bool, qu.url.isRelative())
@inline is_valid(qu::QUrl) = pyconvert(Bool, qu.url.isValid())

# @inline function matches(q1::QUrl, q2::QUrl, opts::QtEnums.FormattingOptions)
# missing matches, password, path, operator

@inline function password(
    qu::QUrl, 
    opts::QtEnums.ComponentFormattingOption=QtEnums.FullyDecoded)
    pyconvert(String, qu.url.password(opts))
end

@inline function path(
    qu::QUrl, 
    opts::QtEnums.ComponentFormattingOption=QtEnums.FullyDecoded)
    pyconvert(String, qu.url.path(opts))
end

@inline port(qu::QUrl, default::Int=-1) = pyconvert(Int, qu.url.port(default))
@inline function query(
    qu::QUrl, 
    opts::QtEnums.ComponentFormattingOption=QtEnums.PrettyDecoded)
    pyconvert(String, qu.url.query(opts))
end

@inline resolved(base::QUrl, rel::QUrl) = pyconvert(QUrl, base.url.resolved(rel))
@inline scheme(qu::QUrl) = pyconvert(String, qu.url.scheme())
# missing authority, setfragment , sethost, stIdnWhitelist, setpasword, setpath

@inline function set_authority!(
    qu::QUrl, 
    authority::String,
    mode::QtEnums.ParsingMode=QtEnums.TolerantMode)
    qu.url.setAuthority(authority, mode)
    nothing 
end

@inline function set_fragment!(
    qu::QUrl, 
    fragment::String,
    mode::QtEnums.ParsingMode=QtEnums.TolerantMode)
    qu.url.setFragment(fragment, mode)
    nothing 
end

@inline function set_host!(
    qu::QUrl, 
    host::String,
    mode::QtEnums.ParsingMode=QtEnums.DecodedMode)
    qu.url.setHost(host, mode)
    nothing 
end

@inline function set_password!(
    qu::QUrl, 
    password::String,
    mode::QtEnums.ParsingMode=QtEnums.DecodedMode)
    qu.url.setPassword(password, mode)
    nothing 
end

@inline function set_path!(
    qu::QUrl, 
    path::String,
    mode::QtEnums.ParsingMode=QtEnums.DecodedMode)
    qu.url.setPath(path, mode)
    nothing 
end

@inline function set_port!(qu::QUrl, port::Int)
    qu.url.setPort(port)
    nothing 
end

#missing set query 

@inline function set_query!(
    qu::QUrl, 
    query::String,
    mode::QtEnums.ParsingMode=QtEnums.TolerantMode)
    qu.url.setQuery(query, mode)
    nothing 
end

@inline function set_scheme!(qu::QUrl, scheme::String)
    qu.url.setScheme(scheme)
    nothing 
end

# da completare
@inline function set_url!(qu::QUrl, url::String) 
    qu.url.setUrl(url)
    nothing 
end

@inline function set_user_info!(
    qu::QUrl, 
    info::String,
    mode::QtEnums.ParsingMode=QtEnums.TolerantMode)
    qu.url.setUserInfo(info, mode)
    nothing 
end

@inline function set_user_name!(
    qu::QUrl, 
    name::String,
    mode::QtEnums.ParsingMode=QtEnums.DecodedMode)
    qu.url.setUserName(name, mode)
    nothing 
end

@inline function swap!(qu::QUrl, other::QUrl)
    qu.url.swap(other)
    nothing 
end 

# CHECK ENUM TYPE
@inline function to_display_string(
    qu::QUrl, 
    opts::QtEnums.ComponentFormattingOption=QtEnums.PrettyDecoded)
    pyconvert(String, qu.url.toDisplayString(opts))
end

@inline to_local_file(qu::QUrl) = pyconvert(String, qu.url.toLocalFile())

# altre