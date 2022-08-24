
export QLine, x1, x2, y1, y2, dx, dy, p1, p2, 
         center, set_p1!, set_p2!, set_points!, 
         translate!, translate

"""
QLine

Type that provides a two-dimensional vector using integer precision. It is the 
representation of `PySide.QtCore.QLine`. It describes a finite length line on a 
two-dimensional surface. The start and end points of the line are specified 
using integer point accuracy for coordinates. Use the `QlineF` constructor to 
retrieve a floating point copy.

### Fields 
- `x1` -- initial point `x`-coordinate
- `y1` -- initial point `y`-coordinate
- `x2` -- final point `x`-coordinate
- `y2` -- final point `y`-coordinate
"""
mutable struct QLine
   x1::Int 
   y1::Int

   x2::Int     
   y2::Int

   QLine(x1::Number, y1::Number, 
         x2::Number, y2::Number) = new(round(Int, x1), round(Int, y1), 
                                 round(Int, x2), round(Int, y2))

end

QLine() = QLine(0, 0, 0, 0)
QLine(p1::QPoint, p2::QPoint) = QLine(x(p1), y(p1), x(p2), y(p2))

# Implements the conversion from the Julia QLine object to the python type. 
PythonCall.Py(l::QLine) = pyQtCore.QLine(l.x1, l.y1, l.x2, l.y2)

# Implements the conversion from the Python QLine object to the Julia type.
function pyc_qline(S, p::Py) 
   x1 = pyconvert(Int, p.x1())
   y1 = pyconvert(Int, p.y1())
   x2 = pyconvert(Int, p.x2())
   y2 = pyconvert(Int, p.y2())

   PythonCall.pyconvert_return(QLine(x1, y1, x2, y2))
end

Base.:(==)(x::QLine, y::QLine) = (x.x1 == y.x1 && x.x2 == y.x2 &&
                           x.y1 == y.y1 && x.y2 == y.y2)
Base.:(!=)(x::QLine, y::QLine) = (x.x1 != y.x1 || x.x2 != y.x2 ||
                           x.y1 != y.y1 || x.y2 != y.y2)

# Allows the conversion of QLine into a (x1, y1, x2, y2) tuple
Base.convert(::Type{<:Tuple}, ql::QLine) = (ql.x1, ql.y1, ql.x2, ql.y2)

@inline x1(ql::QLine) = ql.x1 
@inline y1(ql::QLine) = ql.y1 
@inline x2(ql::QLine) = ql.x2 
@inline y2(ql::QLine) = ql.y2

@inline dx(ql::QLine) = ql.x2 - ql.x1
@inline dy(ql::QLine) = ql.y2 - ql.y1

@inline p1(ql::QLine) = QPoint(ql.x1, ql.y1)
@inline p2(ql::QLine) = QPoint(ql.x2, ql.y2)

@inline center(ql::QLine) = 0.5*QPoint(ql.x1+ql.x2, ql.y1+ql.y2)

@inline set_p1!(ql::QLine, p::QPoint) = ql.x1, ql.y1 = x(p), y(p) 
@inline set_p2!(ql::QLine, p::QPoint) = ql.x2, ql.y2 = x(p), y(p) 

@inline function set_points!(ql::QLine, p1::QPoint, p2::QPoint) 
   ql.x1, ql.y1, ql.x2, ql.y2 = x(p1), y(p1), x(p2), y(p2)
end

function translate!(ql::QLine, δx::Int, δy::Int)
   ql.x1 += δx 
   ql.x2 += δx 

   ql.y1 += δy
   ql.y2 += δy
end

function translate!(ql::QLine, qp::QPoint)
   ql.x1 += x(qp)
   ql.x2 += x(qp)

   ql.y1 += y(qp)
   ql.y2 += y(qp)
end

@inline function translate(ql::QLine, δx::Int, δy::Int)
   QLine(ql.x1 + δx, ql.y1 + δy, ql.x2 + δx, ql.y2 + δy)
end

@inline function translate(ql::QLine, qp::QPoint)
   QLine(ql.x1 + x(qp), ql.y1 + y(qp), ql.x2 + x(qp), ql.y2 + y(qp))
end

function Base.show(io::IO, ::MIME"text/plain", l::QLine) 
   printstyled(io, "QLine", bold=true)
   print(" from ($(l.x1), $(l.y1)) to ($(l.x2), $(l.y2))")
end