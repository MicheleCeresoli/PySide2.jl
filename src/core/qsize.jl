
export QSize, width, height, set_width!, set_height!, resize!, 
        is_null, is_empty, transpose, transpose!, scale!

"""
QSize 

Type that defines the size of a two-dimensional object using integer 
point precision. It is the representation of `PySide2.QtCore.QSize`.
`QSize` types can be summed, subtracted or tested for equality. 

### Fields 
- `width`  -- Object width 
- `height` -- Object height 

"""
mutable struct QSize 
    width::Int
    height::Int 

    QSize(w::Number, h::Number) = new(round(Int, w), round(Int, h))
end

# Constructs a default size 
QSize() = QSize(0, 0)

# Implements the conversion from the Julia QSize object to the python type. 
PythonCall.Py(s::QSize) = pyQtCore.QSize(s.width, s.height)

# Implements the conversion from the Python QSize object to the Julia type.
function pyc_qsize(S, p::Py) 
    w = pyconvert(Int, p.width())
    h = pyconvert(Int, p.height())
    PythonCall.pyconvert_return(QSize(w, h))
end

Base.:(==)(x::QSize, y::QSize) = (x.width == y.width && x.height == y.height)
Base.:(!=)(x::QSize, y::QSize) = (x.width != y.width || x.height != y.height)
Base.:(+)(x::QSize, y::QSize) = QSize(x.width + y.width, x.height + y.height)
Base.:(-)(x::QSize, y::QSize) = QSize(x.width - y.width, x.height - y.height)

# Allows the conversion of QSize into a (width, height) tuple
Base.convert(::Type{<:Tuple}, qs::QSize) = (qs.width, qs.height)

@inline width(qs::QSize) = qs.width
@inline height(qs::QSize) = qs.height 

@inline set_width!(qs::QSize, w::Int) = qs.width = w 
@inline set_height!(qs::QSize, h::Int) = qs.height = h 

function resize!(qs::QSize, w::Int, h::Int)
    set_width!(qs, w)
    set_height!(qs, h)
end 

@inline is_null(qs::QSize) = (qs.width == 0 && qs.height == 0)
@inline is_empty(qs::QSize) = (qs.width <= 0 || qs.height <= 0)

@inline transpose(qs::QSize) = QSize(qs.height, qs.width)
@inline transpose!(qs::QSize) = qs.width, qs.height = qs.height, qs.width

function scale!(qs::QSize, scale::Number) 
    w = floor(Int, width(qs)*scale)
    h = floor(Int, height(qs)*scale)

    set_width!(qs, w)
    set_height!(qs, h)
end

function scale!(qs::QSize, w::Int, h::Int, mode::Symbol)

if mode == :IgnoreAspectRatio 
    set_width!(qs, w)
    set_height!(qs, h)

    else
        vs = h/height(qs)
        hs = w/width(qs)

        if mode == :KeepAspectRatio 
            fct = min(hs, vs)
        elseif mode == :KeepAspectRatioByExpanding 
            fct = max(hs, vs)
        else 
            error("Invalid scaling mode selected.")
        end 

        scale!(qs, fct)
    end

    nothing
end

function Base.show(io::IO, ::MIME"text/plain", s::QSize) 
    printstyled(io, "QSize", bold=true)
    print(" ($(s.width), $(s.height))")
end