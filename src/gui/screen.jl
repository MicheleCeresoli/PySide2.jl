
export QScreen

"""
    QScreen

The `QScreen` widget is used to query screen properties. It is the Julia interface 
to Python `PySide2.QtGui.QScreen`.
"""
struct QScreen 
    obj::Py
end

# Implements the conversion from any Julia QScreen object to the python type. 
PythonCall.Py(s::QScreen) = s.obj
ispy(::QScreen) = true

# Implements the conversion from the Python QScreen object to the Julia type.
@inline pyc_qscreen(S, d::Py) = PythonCall.pyconvert_return(QScreen(d))

@inline angle_between(s::QScreen, a::ScreenOrientation, b::ScreenOrientation) = 
    pyconvert(Int, s.obj.angleBetween(a, b))

@inline available_geometry(s::QScreen) = pyconvert(QRect, s.obj.availableGeometry())

@inline function available_geometry_changed!(s::QScreen, r::QRect)
    s.obj.availableGeometryChanged(r)
    nothing 
end

@inline available_size(s::QScreen) = pyconvert(QSize, s.obj.availableSize())

@inline available_virtual_geometry(s::QScreen) = 
    pyconvert(QRect, s.obj.availableVirtualGeometry())

@inline available_virtual_size(s::QScreen) = 
    pyconvert(QSize, s.obj.avialableVirtualSize())

@inline depth(s::QScreen) = pyconvert(Int, s.obj.depth())

@inline device_pixel_ratio(s::QScreen) = pyconvert(Float64, s.obj.devicePixelRatio())
@inline geometry(s::QScreen) = pyconvert(QRect, s.obj.geometry())

@inline function geometry_changed!(s::QScreen, r::QRect)
    s.obj.geometryChanged(r)
    nothing 
end



@inline is_landscape(s::QScreen, o::ScreenOrientation) = 
    pyconvert(Bool, s.obj.isLandscape(o))

@inline is_portrait(s::QScreen, o::ScreenOrientation) = 
    pyconvert(Bool, s.obj.isPortrait(o))

@inline logical_dots_per_inch(s::QScreen) = 
    pyconvert(Float64, s.obj.logicalDotsPerInch())

@inline function logical_dots_per_inch_changed!(s::QScreen, dpi::Float64)
    s.obj.logicalDotsPerInchChanged(dpi)
    nothing 
end

@inline logical_dots_per_inch_x(s::QScreen) = 
    pyconvert(Float64, s.obj.logicalDotsPerInchX())

@inline logical_dots_per_inch_y(s::QScreen) = 
    pyconvert(Float64, s.obj.logicalDotsPerInchY())

@inline manufacturer(s::QScreen) = pyconvert(String, s.obj.manufacturer())

@inline map_between(s::QScreen, a::ScreenOrientation, b::ScreenOrientation, r::QRect) = 
    pyconvert(QRect, s.obj.mapBetween(a, b, r))
    
@inline model(s::QScreen) = pyconvert(String, s.obj.model())

@inline name(s::QScreen) = pyconvert(String, s.obj.name())
@inline native_orientation(s::QScreen) = 
    pyconvert(ScreenOrientation, s.obj.nativeOrientation())

@inline orientation(s::QScreen) = pyconvert(ScreenOrientation, s.obj.orientation())

@inline function orientation_changed!(s::QScreen, o::ScreenOrientation)
    s.obj.orientationChanged(o)
    nothing 
end

# Serve un vettore forse qua di screen orientations 
# @inline orientation_update_mask(s::QScreen) = pyconvert()

@inline physical_dots_per_inch(s::QScreen) = 
    pyconvert(Float64, s.obj.physicalDotsPerInch())

@inline function physical_dots_per_inch_changed(s::QScreen, dpi::Float64) 
    s.obj.physicalDotsPerInchChanged(dpi)
    nothing 
end

@inline physical_dots_per_inch_x(s::QScreen) = 
    pyconvert(Float64, s.obj.physicalDotsPerInchX())

@inline physical_dots_per_inch_y(s::QScreen) = 
    pyconvert(Float64, s.obj.physicalDotsPerInchY())

# per questo serve versione di QPointF 
# @inline physical_size(
    
# @inline physical_size_changed()
@inline primary_orientation(s::QScreen) = 
    pyconvert(ScreenOrientation, s.obj.primaryOrientation())

@inline function primary_orientation_changed!(s::QScreen, o::ScreenOrientation)
    s.obj.primaryOrientationChanged(o)
    nothing 
end

@inline refresh_rate(s::QScreen) = pyconvert(Float64, s.refreshRate())
@inline function refresh_rate_changed!(s::QScreen, rate::Float64)
    s.refreshRateChanged(rate)
    nothing 
end

@inline serial_number(s::QScreen) = pyconvert(String, s.obj.serialNumber())

# @inline set_orientation_update_mask

@inline size(s::QScreen) = pyconvert(QSize, s.obj.size())
# @inline transform_between() #manca QTranform

@inline virtual_geometry(s::QScreen) = pyconvert(QRect, s.obj.virtualGeometry())
@inline function virtual_geometry_changed!(s::QScreen, r::QRect)
    s.obj.virtualGeometryChanged(r)
    nothing 
end

@inline virtual_sibling_at(s::QScreen, p::QPoint) = 
            pyconvert(QScreen, s.obj.virtualSiblingAt(p))

@inline virtual_size(s::QScreen) = pyconvert(QSize, s.obj.virtualSize())
