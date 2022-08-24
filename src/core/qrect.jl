export QRect, width, height, top, left, bottom, right,
       top_right, top_left, bottom_left, bottom_right, 
       center, is_empty, is_null, is_valid, size, x, y, 
       get_coords, get_rect, set_width!, set_height!, 
       set_size!, set_left!, set_top!, set_bottom!, set_right!, 
       set_top_left!, set_top_right!, set_bottom_left!, set_bottom_right!,
       set_coords!, move_to!, move_top!, move_bottom!, move_left!, move_right!, 
       move_bottom_left!, move_bottom_right!, move_top_left!, move_top_right!,
       move_center!, transpose, transpose!, set_x!, set_y!, adjust, adjust!,
       normalise!, united, translate, translate!, contains, 
       intersected, intersects, add_margins, add_margins!, 
       remove_margins, remove_margins!
       

"""
    QRect 

Type that defines a rectangle in the plane using integer precision. It is the 
representation of `PySide.QtCore.QRect`. A rectangle is normally expressed as a 
top-left corner and a size. The size (width and height) of a `QRect` is always 
equivalent to the mathematical rectangle that forms the basis for its rendering. 

A `QRect` can be constructed with a set of left, top, width and height integers, 
or from a `QPoint` and a `QSize`. 

### Fields 
- `top`    -- Object x-position 
- `left`   -- Object y-position
- `width`  -- Rectangle width
- `height` -- Rectangle height
"""
mutable struct QRect 
    left::Int 
    top::Int 

    width::Int 
    height::Int 

    function QRect(l::Number, t::Number, w::Number, h::Number) 
        new(round(Int, l), round(Int, t), round(Int, w), round(Int, h))
    end
end

QRect() = QRect(0, 0, 0, 0)

# Constructs a rectangle wth (x, y) as its top-left corner and the given width and height 
QRect(w::Number, h::Number) = QRect(0, 0, w, h)

# Constructs a QRect from the given QPoint and QSize 
QRect(p::QPoint, s::QSize) = QRect(p.xpos, p.ypos, s.width, s.height)

# Implements the conversion from the Julia QRect object to the python type. 
PythonCall.Py(r::QRect) = pyQtCore.QRect(r.left, r.top, r.width, r.height)

# Implements the conversion from the Python QRect object to the Julia type.
function pyc_qrect(S, p::Py) 
    l = pyconvert(Int, p.left())
    t = pyconvert(Int, p.top())
    w = pyconvert(Int, p.width())
    h = pyconvert(Int, p.height())
    PythonCall.pyconvert_return(QRect(l, t, w, h))
end


Base.:(==)(x::QRect, y::QRect) = (x.height == y.height && x.width == y.width && 
                                  x.top == y.top && x.left == y.left)
Base.:(!=)(x::QRect, y::QRect) = (x.height != y.height || x.width != y.width || 
                                  x.top != y.top || x.left != y.left)

Base.:(+)(r::QRect, m::QMargins) = add_margins(r, m)
Base.:(-)(r::QRect, m::QMargins) = remove_margins(r, m)


@inline width(qr::QRect) = qr.width
@inline height(qr::QRect) = qr.height 

@inline top(qr::QRect) = qr.top 
@inline left(qr::QRect) = qr.left
@inline bottom(qr::QRect) = top(qr) + height(qr) - 1
@inline right(qr::QRect) = left(qr) + width(qr) - 1 

@inline top_right(qr::QRect) = QPoint(right(qr), top(qr))
@inline top_left(qr::QRect) = QPoint(left(qr), top(qr))
@inline bottom_left(qr::QRect) = QPoint(left(qr), bottom(qr))
@inline bottom_right(qr::QRect) = QPoint(right(qr), bottom(qr))

@inline center(qr::QRect) = top_left(qr) + 0.5*(QPoint(width(qr), height(qr)) - 1)

@inline is_empty(qr::QRect) = (left(qr) > right(qr) || top(qr) > bottom(qr))
@inline is_valid(qr::QRect) = (left(qr) <= right(qr) && top(qr) <= bottom(qr))
@inline is_null(qr::QRect) = (height(qr) == 0 && width(qr) == 0)

@inline size(qr::QRect) = QSize(width(qr), height(qr))

@inline x(qr::QRect) = left(qr)
@inline y(qr::QRect) = top(qr)

@inline get_coords(qr::QRect) = (left(qr), top(qr), right(qr), bottom(qr))
@inline get_rect(qr::QRect) = (left(qr), top(qr), width(qr), height(qr))

@inline set_width!(qr::QRect, width::Int) = qr.width = width
@inline set_height!(qr::QRect, height::Int) = qr.height = height 

@inline function set_size!(qr::QRect, qs::QSize)
    set_width!(qr, width(qs))
    set_height!(qr, height(qs))
end

@inline function set_rect!(qr::QRect, x::Int, y::Int, w::Int, h::Int)
    qr.left, qr.top = x, y
    qr.width, qr.height = w, h
end

@inline function set_left!(qr::QRect, x::Int) 
    qr.width += qr.left - x 
    qr.left = x
end 

@inline function set_top!(qr::QRect, y::Int)
    qr.height += qr.top - y  
    qr.top = y 
end

@inline set_bottom!(qr::QRect, y::Int) = qr.height += y - bottom(qr) 
@inline set_right!(qr::QRect, x::Int) = qr.width += x - right(qr)

@inline set_top_left!(qr::QRect, qp::QPoint) = set_top_left!(qr, x(qp), y(qp))
@inline function set_top_left!(qr::QRect, x::Int, y::Int)
    set_left!(qr, x)
    set_top!(qr, y)
end

@inline set_top_right!(qr::QRect, qp::QPoint) = set_top_right!(qr, x(qp), y(qp))
@inline function set_top_right!(qr::QRect, x::Int, y::Int)
    set_right!(qr, x)
    set_top!(qr, y)
end

@inline set_bottom_left!(qr::QRect, qp::QPoint) = set_bottom_left!(qr, x(qp), y(qp))
@inline function set_bottom_left!(qr::QRect, x::Int, y::Int)
    set_left!(qr, x)
    set_bottom!(qr, y)
end

@inline set_bottom_right!(qr::QRect, qp::QPoint) = set_bottom_right!(qr, x(qp), y(qp))
@inline function set_bottom_right!(qr::QRect, x::Int, y::Int)
    set_right!(qr, x)
    set_bottom!(qr, y)
end

@inline function set_coords!(qr::QRect, x1::Int, y1::Int, x2::Int, y2::Int)
    set_top_left!(qr, x1, y1)
    set_bottom_right!(qr, x2, y2)
end

@inline move_to!(qr::QRect, x::Int, y::Int) = qr.left, qr.top = x, y
@inline move_to!(qr::QRect, qp::QPoint) = qr.left, qr.top = x(qp), y(qp)

@inline move_top!(qr::QRect, y::Int) = qr.top = y 
@inline move_bottom!(qr::QRect, y::Int) = qr.top += y - bottom(qr)
@inline move_left!(qr::QRect, x::Int) = qr.left = x
@inline move_right!(qr::QRect, x::Int) = qr.left += x - right(qr)

@inline function move_bottom_left!(qr::QRect, qp::QPoint)
    move_left!(qr, x(qp))
    move_bottom!(qr, y(qp))
end

@inline function move_bottom_right!(qr::QRect, qp::QPoint)
    move_right!(qr, x(qp))
    move_bottom!(qr, y(qp))
end

@inline function move_top_left!(qr::QRect, qp::QPoint)
    move_left!(qr, x(qp))
    move_top!(qr, y(qp))
end

@inline function move_top_right!(qr::QRect, qp::QPoint)
    move_right!(qr, x(qp))
    move_top!(qr, y(qp))
end

@inline move_center!(qr::QRect, qp::QPoint) = move_center!(qr, x(qp), y(qp))
function move_center!(qr::QRect, x::Int, y::Int)
    qr.left = floor(Int, x - 0.5*(width(qr)-1))
    qr.top = floor(Int, y - 0.5*(height(qr)-1))
end

@inline transpose(qr::QRect) = QRect(qr.top, qr.left, qr.height, qr.width)
@inline transpose!(qr::QRect) = qr.width, qr.height = qr.height, qr.width 

@inline set_x!(qr::QRect, x::Int) = set_left!(qr, x)
@inline set_y!(qr::QRect, y::Int) = set_top!(qr, y)

function adjust!(qr::QRect, x1::Int, y1::Int, x2::Int, y2::Int)

    qr.left += x1
    qr.top += y1

    dw, dh = x2 - x1, y2 - y1
    set_width!(qr, qr.width + dw)
    set_height!(qr, qr.height + dh)
    nothing
end

@inline function adjust(qr::QRect, x1::Int, y1::Int, x2::Int, y2::Int)
    QRect(left(qr) + x1, top(qr) + y1, width(qr) + x2 - x1, height(qr) + y2 - y1)
end

function normalise!(qr::QRect)

    if width(qr) < 0 
        l, r = left(qr), right(qr)
        set_left!(qr, r)
        set_right!(qr, l)
    end 

    if height(qr) < 0 
        t, b = top(qr), bottom(qr)
        set_top!(qr, b)
        set_bottom!(qr, t)
    end
    nothing
end

function united(q1::QRect, q2::QRect)
    t  = min(top(q1), top(q2))
    l = min(left(q1), left(q2))

    r  = max(right(q1), right(q2))
    b = max(bottom(q1), bottom(q2))

    QRect(l, t, r-l+1, b-t+1)
end

@inline translate!(qr::QRect, qp::QPoint) = translate!(qr, x(qp), y(qp))
@inline function translate!(qr::QRect, δx::Int, δy::Int)
    qr.left += δx
    qr.top += δy 
end

@inline translate(qr::QRect, qp::QPoint) = translate(qr, x(qp), y(qp))
@inline function translate(qr::QRect, δx::Int, δy::Int)
    QRect(qr.left + δx, qr.top + δy, width(qr), height(qr))
end

@inline contains(qr::QRect, qp::QPoint, proper::Bool = True) = contains(qr, x(qp), y(qp), proper)
function contains(qr::QRect, x::Int, y::Int, proper::Bool = True)

    l, r, t, b = left(qr), right(qr), top(qr), bottom(qr)
    if proper
        return x > l && x < r && y > t && y < b
    else
        return x >= l && x <= r && y >= t && y <= b 
    end

end

function intersected(q1::QRect, q2::QRect)
    if intersects(q1, q2)
        xc = max(left(q1), left(q2))
        yc = max(top(q1), top(q2))
        
        xd = min(right(q1), right(q2))
        yd = min(bottom(q1), bottom(q2))

        return QRect(xc, yc, xd-xc+1, yd-yc+1)
    else 
        return QRect()
    end
end

@inline function intersects(q1::QRect, q2::QRect)
    (bottom(q1) >= top(q2) && bottom(q2) >= top(q1) && 
     right(q1) >= left(q2) && right(q2) >= left(q1))
end

@inline function add_margins(qr::QRect, qm::QMargins)
    QRect(qr.left - qm.left, qr.top - qm.top, 
          qr.width + qm.right + qm.left, qr.height + qm.top + qm.bottom)
end

function add_margins!(qr::QRect, qm::QMargins)
    qr.left -= qm.left 
    qr.top -= qm.top 

    qr.width += qm.right + qm.left 
    qr.height += qm.top + qm.bottom

end

@inline function remove_margins(qr::QRect, qm::QMargins)
    QRect(qr.left + qm.left, qr.top + qm.top, 
          qr.width - qm.right - qm.left, qr.height - qm.top - qm.bottom)
end


function remove_margins!(qr::QRect, qm::QMargins)
    qr.left += qm.left 
    qr.top += qm.top 

    qr.width -= qm.right - qm.left 
    qr.height -= qm.top - qm.bottom
end

function Base.show(io::IO, ::MIME"text/plain", r::QRect) 
    printstyled(io, "QRect", bold=true)
    print(" at ($(r.left), $(r.top)) with size ($(r.width), $(r.height))")
end