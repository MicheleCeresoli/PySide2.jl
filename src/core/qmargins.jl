
export QMargins, left, right, bottom, top, is_null, 
        set_left!, set_right!, set_bottom!, set_top!

"""
QMargins

Type that defines the four margins of a rectangle. It is the representation of 
`PySide.QtCore.QMargins`. Thse margins describe the size of the borders 
surrounding a rectangle. 

### Fields 
- `left`   -- left margin
- `right`  -- right margin
- `top`    -- top margin
- `bottom` -- bottom margin
"""
mutable struct QMargins
    left::Int 
    top::Int 

    right::Int 
    bottom::Int 

    QMargins(l::T, t::T, r::T, b::T) where {T <: Number} = new(round(Int, l), 
                                                        round(Int, t), 
                                                        round(Int, r),
                                                        round(Int, b))
end

# Constructs with null margins
QMargins() = QMargins(0, 0, 0, 0)

# Implements the conversion from the Julia QMargins object to the python type. 
PythonCall.Py(m::QMargins) = pyQtCore.QMargins(m.left, m.top, m.right, m.bottom)

# Implements the conversion from the Python QMargins object to the Julia type.
function pyc_qmargins(S, p::Py) 
    l = pyconvert(Int, p.left())
    t = pyconvert(Int, p.top())
    r = pyconvert(Int, p.right())
    b = pyconvert(Int, p.bottom())

    PythonCall.pyconvert_return(QMargins(l, t, r, b))
end


Base.:(==)(x::QMargins, y::QMargins) = (x.left == y.left && x.right == y.right && 
                                 x.top == y.top && x.bottom == y.bottom)

Base.:(!=)(x::QMargins, y::QMargins) = (x.left != y.left || x.right != y.right || 
                                 x.top != y.top || x.bottom != y.bottom)

Base.:(+)(x::QMargins, y::QMargins) = QMargins(x.left + y.left, x.top + y.top, 
                                        x.right + y.right, x.bottom + y.bottom)

Base.:(-)(x::QMargins, y::QMargins) = QMargins(x.left - y.left, x.top - y.top, 
                                        x.right - y.right, x.bottom - y.bottom)

Base.:(+)(y::Number, x::QMargins) = x + y 
Base.:(+)(x::QMargins, y::Number) = QMargins(x.left + y, x.top + y, 
                                      x.right + y, x.bottom + y)

Base.:(-)(x::QMargins, y::Number) = QMargins(x.left - y, x.top - y, 
                                      x.right - y, x.bottom - y)
Base.:(*)(y::Number, x::QMargins) = x*y
Base.:(*)(x::QMargins, y::Number) = QMargins(x.left*y, x.top*y, 
                                      x.right*y, x.bottom*y)


Base.:(/)(x::QMargins, y::Number) = QMargins(x.left/y, x.top/y, 
                                      x.right/y, x.bottom/y)

@inline left(qm::QMargins) = qm.left 
@inline right(qm::QMargins) = qm.right 
@inline top(qm::QMargins) = qm.top 
@inline bottom(qm::QMargins) = qm.bottom

@inline is_null(qm::QMargins) = (qm.left == 0 && qm.right == 0 && 
                         qm.top == 0 && qm.bottom == 0)


@inline set_left!(qm::QMargins, l::Int) = qm.left = l 
@inline set_right!(qm::QMargins, r::Int) = qm.right = r
@inline set_bottom!(qm::QMargins, b::Int) = qm.bottom = b
@inline set_top!(qm::QMargins, t::Int) = qm.top = t

function Base.show(io::IO, ::MIME"text/plain", m::QMargins) 
    printstyled(io, "QMargins", bold=true)
    print(" (left: $(m.left), top: $(m.top), right: $(m.right), bottom: $(m.bottom))")
end