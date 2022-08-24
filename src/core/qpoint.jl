export QPoint, x, y, set_x!, set_y!, is_null,
       manhattan_length, transpose, transpose!

"""
    QPoint 

Type that defines a point in the plane using integer precision. It is the 
representation of `PySide.QtCore.QPoint`. A point is specified by its `x` and `y`
coordinates.

### Fields 
- `xpos` -- Object x-position 
- `ypos` -- Object y-position

"""
mutable struct QPoint 
    xpos::Int 
    ypos::Int

    QPoint(x::Number, y::Number) = new(round(Int, x), round(Int, y))

end

# Constructs a null point, i.e., with coordinates (0, 0)
QPoint() = QPoint(0, 0)

# Implements the conversion from the Julia QPoint object to the python type. 
PythonCall.Py(p::QPoint) = pyQtCore.QPoint(p.xpos, p.ypos)

# Implements the conversion from the Python QPoint object to the Julia type.
function pyc_qpoint(S, p::Py) 
    x = pyconvert(Int, p.x())
    y = pyconvert(Int, p.y())
    PythonCall.pyconvert_return(QPoint(x, y))
end


Base.:(==)(x::QPoint, y::QPoint) = (x.xpos == y.xpos && x.ypos == y.ypos)
Base.:(!=)(x::QPoint, y::QPoint) = (x.xpos != y.xpos || x.ypos != y.ypos)
Base.:(+)(x::QPoint, y::QPoint) = QPoint(x.xpos + y.xpos, x.ypos + y.ypos)
Base.:(-)(x::QPoint, y::QPoint) = QPoint(x.xpos - y.xpos, x.ypos - y.ypos)

Base.:(+)(q::QPoint, y::Number) = QPoint(q.xpos+y, q.ypos+y)
Base.:(+)(y::Number, q::QPoint) = q + y

Base.:(*)(q::QPoint, y::Number) = QPoint(q.xpos*y, q.ypos*y)
Base.:(*)(y::Number, q::QPoint) = q*y

# A number - or \ a QPoint does not have a meaning
Base.:(-)(q::QPoint, y::Number) = QPoint(q.xpos-y, q.ypos-y)
Base.:(/)(q::QPoint, y::Number) = QPoint(q.xpos/y, q.ypos/y)


# Allows the conversion of QPoint into a (x, y) tuple
Base.convert(::Type{<:Tuple}, qp::QPoint) = (qp.xpos, qp.ypos)

@inline x(qp::QPoint) = qp.xpos 
@inline y(qp::QPoint) = qp.ypos

@inline set_x!(qp::QPoint, x::Int) = qp.xpos = x 
@inline set_y!(qp::QPoint, y::Int) = qp.ypos = y 

@inline is_null(qp::QPoint) = (qp.xpos == 0 && qp.ypos == 0)

@inline manhattan_length(qp::QPoint) = abs(qp.xpos + qp.ypos)

@inline transpose(qp::QPoint) = QPoint(qp.ypos, qp.xpos)
@inline transpose!(qp::QPoint) = qp.xpos, qp.ypos = qp.ypos, qp.xpos

function Base.show(io::IO, ::MIME"text/plain", p::QPoint) 
    printstyled(io, "QPoint", bold=true)
    print(" at ($(p.xpos), $(p.ypos))")
end