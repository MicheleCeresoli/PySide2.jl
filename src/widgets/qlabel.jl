export QLabel, alignment, buddy, clear!, has_scaled_contents, 
       has_selected_text, indent, margin, open_external_link, 
       selected_text, selection_start, set_indent!, set_margin!, 
       set_num!, set_text!, text, word_wrap

"""
    QLabel

The `QLabel` widget provides a text or image display. It is the julia interface 
to the `PySide2.QtWidgets.QLabel` class. No user interaction functionality is 
provided. The visual appearance of the label can be configured in various ways, and 
it can be used for specifying a focus mnemonic key for another widget. 
"""
struct QLabel <: QWidget 
    obj::Py 
end

QLabel() = QLabel(pyQtWidgets.QLabel())
QLabel(text::String) = QLabel(pyQtWidgets.QLabel(text))

# Implements the conversion from the Python QRect object to the Julia type.
@inline pyc_qlabel(S, l::Py) = PythonCall.pyconvert_return(QLabel(l))


@inline function alignment(ql::QLabel)
    ql.obj.alignment()
    nothing 
end

@inline function buddy(ql::QLabel)
    ql.obj.buddy()
    nothing 
end

@inline function clear!(ql::QLabel)
    ql.obj.clear()
    nothing 
end

@inline has_scaled_contents(ql::QLabel) = pyconvert(Bool, ql.obj.hasScaledContents())
@inline has_selected_text(ql::QLabel) = pyconvert(Bool, ql.obj.hasSelectedText())
@inline indent(ql::QLabel) = pyconvert(Int, ql.obj.indent())
@inline margin(ql::QLabel) = pyconvert(Int, ql.obj.margin())
@inline open_external_link(ql::QLabel) = pyconvert(Bool, ql.obj.openExternalLinks())

@inline selected_text(ql::QLabel) = pyconvert(String, ql.obj.selectedText())
@inline selection_start(ql::QLabel) = pyconvert(Int, ql.obj.selectionStart())

@inline function set_indent!(ql::QLabel, x::Int)
    ql.obj.setIndent(x)
    nothing 
end

@inline function set_margin!(ql::QLabel, x::Int)
    ql.obj.setMargin(x)
    nothing 
end

@inline function set_num!(ql::QLabel, num::Int)
    ql.obj.setNum(num)
    nothing 
end

@inline function set_text!(ql::QLabel, text::String)
    ql.obj.setText(text)
    nothing 
end

@inline text(ql::QLabel) = pyconvert(String, ql.obj.text())

@inline word_wrap(ql::QLabel) = pyconvert(Bool, ql.obj.wordWrap())

function Base.show(io::IO, ::MIME"text/plain", w::QLabel) 
    
    txt, sz = text(w), size(w)
    xi, yi, wi, he = x(w), y(w), sz.width, sz.height

    printstyled(io, "QLabel", bold=true)
    print(": \"$txt\" at ($xi, $yi) with size ($wi, $he)")

end