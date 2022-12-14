
module Qt 

using PythonCall: PythonCall, pyconvert_add_rule, 
                  PYCONVERT_PRIORITY_NORMAL, Py

import ..QtCore: pyQtCore

# Register the Qt Enumerable
macro qtenum(supertype, subtypes)

    spt = eval(supertype)
    sbt = eval(subtypes)

    # # Builds the expression for @enum
    enum = Expr(:macrocall, quote $(Symbol("@enum")) end, :_, spt)
    for typ in sbt
        push!(enum.args, typ)
    end

    # Registers the Julia-to-Python conversion
    conv = quote 
        function PythonCall.Py(y::$(spt))
            getproperty(pyQtCore.Qt.$spt, Symbol(y))
        end
    end

    expr = Expr(:block)
    push!(expr.args, enum)
    push!(expr.args, conv)
    push!(expr.args, Expr(:call, :push!, :qt_enums, spt))
    return quote $(esc(expr)) end 

end

# This function converts all the python enumerables to Julia
function pyc_enum(::Any, y::Py)
    str = string(y)
    name = str[findlast('.', str)+1:end]
    return PythonCall.pyconvert_return(eval(Symbol(name)))
end

const qt_enums = Vector{DataType}()

function __init__()

    for enum in map(string, qt_enums)
        str = enum[findlast('.', enum)+1:end]
        pyconvert_add_rule("PySide2.QtCore.Qt:"*str, Enum, pyc_enum, PYCONVERT_PRIORITY_NORMAL)
    end
end

@qtenum :ScreenOrientation [:PrimaryOrientation, :PortraitOrientation, :LandscapeOrientation, :InvertedPortraitOrientation, :InvertedLandscapeOrientation]
@qtenum :SizeHint [:MinimumSize, :PreferredSize, :MaximumSize, :MinimumDescent, :NSizeHints]
@qtenum :PenStyle [:NoPen, :SolidLine, :DashLine, :DotLine, :DashDotLine, :DashDotDotLine, :CustomDashLine, :MPenStyle]
@qtenum :FocusReason [:MouseFocusReason, :TabFocusReason, :BacktabFocusReason, :ActiveWindowFocusReason, :PopupFocusReason, :ShortcutFocusReason, :MenuBarFocusReason, :OtherFocusReason, :NoFocusReason]
@qtenum :ArrowType [:NoArrow, :UpArrow, :DownArrow, :LeftArrow, :RightArrow]
@qtenum :TextFlag [:TextSingleLine, :TextDontClip, :TextExpandTabs, :TextShowMnemonic, :TextWordWrap, :TextWrapAnywhere, :TextDontPrint, :TextIncludeTrailingSpaces, :TextHideMnemonic, :TextJustificationForced, :TextForceLeftToRight, :TextForceRightToLeft, :TextLongestVariant, :TextBypassShaping]
@qtenum :DayOfWeek [:Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday, :Sunday]
@qtenum :ConnectionType [:AutoConnection, :DirectConnection, :QueuedConnection, :BlockingQueuedConnection, :UniqueConnection]
@qtenum :Edge [:TopEdge, :LeftEdge, :RightEdge, :BottomEdge]
@qtenum :NavigationMode [:NavigationModeNone, :NavigationModeKeypadTabOrder, :NavigationModeKeypadDirectional, :NavigationModeCursorAuto, :NavigationModeCursorForceVisible]
@qtenum :InputMethodQuery [:ImEnabled, :ImCursorRectangle, :ImMicroFocus, :ImFont, :ImCursorPosition, :ImSurroundingText, :ImCurrentSelection, :ImMaximumTextLength, :ImAnchorPosition, :ImHints, :ImPreferredLanguage, :ImAbsolutePosition, :ImTextBeforeCursor, :ImTextAfterCursor, :ImEnterKeyType, :ImAnchorRectangle, :ImInputItemClipRectangle, :ImPlatformData, :ImQueryInput, :ImQueryAll]
@qtenum :SortOrder [:AscendingOrder, :DescendingOrder]
@qtenum :TextElideMode [:ElideLeft, :ElideRight, :ElideMiddle, :ElideNone]
@qtenum :HitTestAccuracy [:ExactHit, :FuzzyHit]
@qtenum :NativeGestureType [:BeginNativeGesture, :EndNativeGesture, :PanNativeGesture, :ZoomNativeGesture, :SmartZoomNativeGesture, :RotateNativeGesture, :SwipeNativeGesture]
@qtenum :GlobalColor [:color0, :color1, :black, :white, :darkGray, :gray, :lightGray, :red, :green, :blue, :cyan, :magenta, :yellow, :darkRed, :darkGreen, :darkBlue, :darkCyan, :darkMagenta, :darkYellow, :transparent]
@qtenum :MaskMode [:MaskInColor, :MaskOutColor]
@qtenum :FindChildOption [:FindDirectChildrenOnly, :FindChildrenRecursively]
@qtenum :LayoutDirection [:LeftToRight, :RightToLeft, :LayoutDirectionAuto]
@qtenum :TileRule [:StretchTile, :RepeatTile, :RoundTile]
@qtenum :TransformationMode [:FastTransformation, :SmoothTransformation]
@qtenum :CursorMoveStyle [:LogicalMoveStyle, :VisualMoveStyle]
@qtenum :FocusPolicy [:NoFocus, :TabFocus, :ClickFocus, :StrongFocus, :WheelFocus]
@qtenum :Key [:Key_Escape, :Key_Tab, :Key_Backtab, :Key_Backspace, :Key_Return, :Key_Enter, :Key_Insert, :Key_Delete, :Key_Pause, :Key_Print, :Key_SysReq, :Key_Clear, :Key_Home, :Key_End, :Key_Left, :Key_Up, :Key_Right, :Key_Down, :Key_PageUp, :Key_PageDown, :Key_Shift, :Key_Control, :Key_Meta, :Key_Alt, :Key_CapsLock, :Key_NumLock, :Key_ScrollLock, :Key_F1, :Key_F2, :Key_F3, :Key_F4, :Key_F5, :Key_F6, :Key_F7, :Key_F8, :Key_F9, :Key_F10, :Key_F11, :Key_F12, :Key_F13, :Key_F14, :Key_F15, :Key_F16, :Key_F17, :Key_F18, :Key_F19, :Key_F20, :Key_F21, :Key_F22, :Key_F23, :Key_F24, :Key_F25, :Key_F26, :Key_F27, :Key_F28, :Key_F29, :Key_F30, :Key_F31, :Key_F32, :Key_F33, :Key_F34, :Key_F35, :Key_Super_L, :Key_Super_R, :Key_Menu, :Key_Hyper_L, :Key_Hyper_R, :Key_Help, :Key_Direction_L, :Key_Direction_R, :Key_Space, :Key_Any, :Key_Exclam, :Key_QuoteDbl, :Key_NumberSign, :Key_Dollar, :Key_Percent, :Key_Ampersand, :Key_Apostrophe, :Key_ParenLeft, :Key_ParenRight, :Key_Asterisk, :Key_Plus, :Key_Comma, :Key_Minus, :Key_Period, :Key_Slash, :Key_0, :Key_1, :Key_2, :Key_3, :Key_4, :Key_5, :Key_6, :Key_7, :Key_8, :Key_9, :Key_Colon, :Key_Semicolon, :Key_Less, :Key_Equal, :Key_Greater, :Key_Question, :Key_At, :Key_A, :Key_B, :Key_C, :Key_D, :Key_E, :Key_F, :Key_G, :Key_H, :Key_I, :Key_J, :Key_K, :Key_L, :Key_M, :Key_N, :Key_O, :Key_P, :Key_Q, :Key_R, :Key_S, :Key_T, :Key_U, :Key_V, :Key_W, :Key_X, :Key_Y, :Key_Z, :Key_BracketLeft, :Key_Backslash, :Key_BracketRight, :Key_AsciiCircum, :Key_Underscore, :Key_QuoteLeft, :Key_BraceLeft, :Key_Bar, :Key_BraceRight, :Key_AsciiTilde, :Key_nobreakspace, :Key_exclamdown, :Key_cent, :Key_sterling, :Key_currency, :Key_yen, :Key_brokenbar, :Key_section, :Key_diaeresis, :Key_copyright, :Key_ordfeminine, :Key_guillemotleft, :Key_notsign, :Key_hyphen, :Key_registered, :Key_macron, :Key_degree, :Key_plusminus, :Key_twosuperior, :Key_threesuperior, :Key_acute, :Key_mu, :Key_paragraph, :Key_periodcentered, :Key_cedilla, :Key_onesuperior, :Key_masculine, :Key_guillemotright, :Key_onequarter, :Key_onehalf, :Key_threequarters, :Key_questiondown, :Key_Agrave, :Key_Aacute, :Key_Acircumflex, :Key_Atilde, :Key_Adiaeresis, :Key_Aring, :Key_AE, :Key_Ccedilla, :Key_Egrave, :Key_Eacute, :Key_Ecircumflex, :Key_Ediaeresis, :Key_Igrave, :Key_Iacute, :Key_Icircumflex, :Key_Idiaeresis, :Key_ETH, :Key_Ntilde, :Key_Ograve, :Key_Oacute, :Key_Ocircumflex, :Key_Otilde, :Key_Odiaeresis, :Key_multiply, :Key_Ooblique, :Key_Ugrave, :Key_Uacute, :Key_Ucircumflex, :Key_Udiaeresis, :Key_Yacute, :Key_THORN, :Key_ssharp, :Key_division, :Key_ydiaeresis, :Key_AltGr, :Key_Multi_key, :Key_Codeinput, :Key_SingleCandidate, :Key_MultipleCandidate, :Key_PreviousCandidate, :Key_Mode_switch, :Key_Kanji, :Key_Muhenkan, :Key_Henkan, :Key_Romaji, :Key_Hiragana, :Key_Katakana, :Key_Hiragana_Katakana, :Key_Zenkaku, :Key_Hankaku, :Key_Zenkaku_Hankaku, :Key_Touroku, :Key_Massyo, :Key_Kana_Lock, :Key_Kana_Shift, :Key_Eisu_Shift, :Key_Eisu_toggle, :Key_Hangul, :Key_Hangul_Start, :Key_Hangul_End, :Key_Hangul_Hanja, :Key_Hangul_Jamo, :Key_Hangul_Romaja, :Key_Hangul_Jeonja, :Key_Hangul_Banja, :Key_Hangul_PreHanja, :Key_Hangul_PostHanja, :Key_Hangul_Special, :Key_Dead_Grave, :Key_Dead_Acute, :Key_Dead_Circumflex, :Key_Dead_Tilde, :Key_Dead_Macron, :Key_Dead_Breve, :Key_Dead_Abovedot, :Key_Dead_Diaeresis, :Key_Dead_Abovering, :Key_Dead_Doubleacute, :Key_Dead_Caron, :Key_Dead_Cedilla, :Key_Dead_Ogonek, :Key_Dead_Iota, :Key_Dead_Voiced_Sound, :Key_Dead_Semivoiced_Sound, :Key_Dead_Belowdot, :Key_Dead_Hook, :Key_Dead_Horn, :Key_Dead_Stroke, :Key_Dead_Abovecomma, :Key_Dead_Abovereversedcomma, :Key_Dead_Doublegrave, :Key_Dead_Belowring, :Key_Dead_Belowmacron, :Key_Dead_Belowcircumflex, :Key_Dead_Belowtilde, :Key_Dead_Belowbreve, :Key_Dead_Belowdiaeresis, :Key_Dead_Invertedbreve, :Key_Dead_Belowcomma, :Key_Dead_Currency, :Key_Dead_a, :Key_Dead_A, :Key_Dead_e, :Key_Dead_E, :Key_Dead_i, :Key_Dead_I, :Key_Dead_o, :Key_Dead_O, :Key_Dead_u, :Key_Dead_U, :Key_Dead_Small_Schwa, :Key_Dead_Capital_Schwa, :Key_Dead_Greek, :Key_Dead_Lowline, :Key_Dead_Aboveverticalline, :Key_Dead_Belowverticalline, :Key_Dead_Longsolidusoverlay, :Key_Back, :Key_Forward, :Key_Stop, :Key_Refresh, :Key_VolumeDown, :Key_VolumeMute, :Key_VolumeUp, :Key_BassBoost, :Key_BassUp, :Key_BassDown, :Key_TrebleUp, :Key_TrebleDown, :Key_MediaPlay, :Key_MediaStop, :Key_MediaPrevious, :Key_MediaNext, :Key_MediaRecord, :Key_MediaPause, :Key_MediaTogglePlayPause, :Key_HomePage, :Key_Favorites, :Key_Search, :Key_Standby, :Key_OpenUrl, :Key_LaunchMail, :Key_LaunchMedia, :Key_Launch0, :Key_Launch1, :Key_Launch2, :Key_Launch3, :Key_Launch4, :Key_Launch5, :Key_Launch6, :Key_Launch7, :Key_Launch8, :Key_Launch9, :Key_LaunchA, :Key_LaunchB, :Key_LaunchC, :Key_LaunchD, :Key_LaunchE, :Key_LaunchF, :Key_MonBrightnessUp, :Key_MonBrightnessDown, :Key_KeyboardLightOnOff, :Key_KeyboardBrightnessUp, :Key_KeyboardBrightnessDown, :Key_PowerOff, :Key_WakeUp, :Key_Eject, :Key_ScreenSaver, :Key_WWW, :Key_Memo, :Key_LightBulb, :Key_Shop, :Key_History, :Key_AddFavorite, :Key_HotLinks, :Key_BrightnessAdjust, :Key_Finance, :Key_Community, :Key_AudioRewind, :Key_BackForward, :Key_ApplicationLeft, :Key_ApplicationRight, :Key_Book, :Key_CD, :Key_Calculator, :Key_ToDoList, :Key_ClearGrab, :Key_Close, :Key_Copy, :Key_Cut, :Key_Display, :Key_DOS, :Key_Documents, :Key_Excel, :Key_Explorer, :Key_Game, :Key_Go, :Key_iTouch, :Key_LogOff, :Key_Market, :Key_Meeting, :Key_MenuKB, :Key_MenuPB, :Key_MySites, :Key_News, :Key_OfficeHome, :Key_Option, :Key_Paste, :Key_Phone, :Key_Calendar, :Key_Reply, :Key_Reload, :Key_RotateWindows, :Key_RotationPB, :Key_RotationKB, :Key_Save, :Key_Send, :Key_Spell, :Key_SplitScreen, :Key_Support, :Key_TaskPane, :Key_Terminal, :Key_Tools, :Key_Travel, :Key_Video, :Key_Word, :Key_Xfer, :Key_ZoomIn, :Key_ZoomOut, :Key_Away, :Key_Messenger, :Key_WebCam, :Key_MailForward, :Key_Pictures, :Key_Music, :Key_Battery, :Key_Bluetooth, :Key_WLAN, :Key_UWB, :Key_AudioForward, :Key_AudioRepeat, :Key_AudioRandomPlay, :Key_Subtitle, :Key_AudioCycleTrack, :Key_Time, :Key_Hibernate, :Key_View, :Key_TopMenu, :Key_PowerDown, :Key_Suspend, :Key_ContrastAdjust, :Key_LaunchG, :Key_LaunchH, :Key_TouchpadToggle, :Key_TouchpadOn, :Key_TouchpadOff, :Key_MicMute, :Key_Red, :Key_Green, :Key_Yellow, :Key_Blue, :Key_ChannelUp, :Key_ChannelDown, :Key_Guide, :Key_Info, :Key_Settings, :Key_MicVolumeUp, :Key_MicVolumeDown, :Key_New, :Key_Open, :Key_Find, :Key_Undo, :Key_Redo, :Key_MediaLast, :Key_Select, :Key_Yes, :Key_No, :Key_Cancel, :Key_Printer, :Key_Execute, :Key_Sleep, :Key_Play, :Key_Zoom, :Key_Exit, :Key_Context1, :Key_Context2, :Key_Context3, :Key_Context4, :Key_Call, :Key_Hangup, :Key_Flip, :Key_ToggleCallHangup, :Key_VoiceDial, :Key_LastNumberRedial, :Key_Camera, :Key_CameraFocus, :Key_unknown]
@qtenum :WindowType [:Widget, :Window, :Dialog, :Sheet, :Drawer, :Popup, :Tool, :ToolTip, :SplashScreen, :Desktop, :SubWindow, :ForeignWindow, :CoverWindow, :WindowType_Mask, :MSWindowsFixedSizeDialogHint, :MSWindowsOwnDC, :BypassWindowManagerHint, :X11BypassWindowManagerHint, :FramelessWindowHint, :WindowTitleHint, :WindowSystemMenuHint, :WindowMinimizeButtonHint, :WindowMaximizeButtonHint, :WindowMinMaxButtonsHint, :WindowContextHelpButtonHint, :WindowShadeButtonHint, :WindowStaysOnTopHint, :WindowTransparentForInput, :WindowOverridesSystemGestures, :WindowDoesNotAcceptFocus, :MaximizeUsingFullscreenGeometryHint, :CustomizeWindowHint, :WindowStaysOnBottomHint, :WindowCloseButtonHint, :MacWindowToolBarButtonHint, :BypassGraphicsProxyWidget, :NoDropShadowWindowHint, :WindowFullscreenButtonHint]
@qtenum :MouseEventSource [:MouseEventNotSynthesized, :MouseEventSynthesizedBySystem, :MouseEventSynthesizedByQt, :MouseEventSynthesizedByApplication]
@qtenum :AspectRatioMode [:IgnoreAspectRatio, :KeepAspectRatio, :KeepAspectRatioByExpanding]
@qtenum :EnterKeyType [:EnterKeyDefault, :EnterKeyReturn, :EnterKeyDone, :EnterKeyGo, :EnterKeySend, :EnterKeySearch, :EnterKeyNext, :EnterKeyPrevious]
@qtenum :ChecksumType [:ChecksumIso3309, :ChecksumItuV41]
@qtenum :MouseButton [:NoButton, :LeftButton, :RightButton, :MidButton, :MiddleButton, :BackButton, :XButton1, :ExtraButton1, :ForwardButton, :XButton2, :ExtraButton2, :TaskButton, :ExtraButton3, :ExtraButton4, :ExtraButton5, :ExtraButton6, :ExtraButton7, :ExtraButton8, :ExtraButton9, :ExtraButton10, :ExtraButton11, :ExtraButton12, :ExtraButton13, :ExtraButton14, :ExtraButton15, :ExtraButton16, :ExtraButton17, :ExtraButton18, :ExtraButton19, :ExtraButton20, :ExtraButton21, :ExtraButton22, :ExtraButton23, :ExtraButton24, :AllButtons, :MaxMouseButton, :MouseButtonMask]
@qtenum :CheckState [:Unchecked, :PartiallyChecked, :Checked]
@qtenum :Orientation [:Horizontal, :Vertical]
@qtenum :DropAction [:CopyAction, :MoveAction, :LinkAction, :ActionMask, :TargetMoveAction, :IgnoreAction]
@qtenum :ItemDataRole [:DisplayRole, :DecorationRole, :EditRole, :ToolTipRole, :StatusTipRole, :WhatsThisRole, :FontRole, :TextAlignmentRole, :BackgroundColorRole, :BackgroundRole, :TextColorRole, :ForegroundRole, :CheckStateRole, :AccessibleTextRole, :AccessibleDescriptionRole, :SizeHintRole, :InitialSortOrderRole, :DisplayPropertyRole, :DecorationPropertyRole, :ToolTipPropertyRole, :StatusTipPropertyRole, :WhatsThisPropertyRole, :UserRole]
@qtenum :AlignmentFlag [:AlignLeft, :AlignLeading, :AlignRight, :AlignTrailing, :AlignHCenter, :AlignJustify, :AlignAbsolute, :AlignHorizontal_Mask, :AlignTop, :AlignBottom, :AlignVCenter, :AlignBaseline, :AlignVertical_Mask, :AlignCenter]
@qtenum :SizeMode [:AbsoluteSize, :RelativeSize]
@qtenum :PenJoinStyle [:MiterJoin, :BevelJoin, :RoundJoin, :SvgMiterJoin, :MPenJoinStyle]
@qtenum :WhiteSpaceMode [:WhiteSpaceNormal, :WhiteSpacePre, :WhiteSpaceNoWrap, :WhiteSpaceModeUndefined]
@qtenum :CursorShape [:ArrowCursor, :UpArrowCursor, :CrossCursor, :WaitCursor, :IBeamCursor, :SizeVerCursor, :SizeHorCursor, :SizeBDiagCursor, :SizeFDiagCursor, :SizeAllCursor, :BlankCursor, :SplitVCursor, :SplitHCursor, :PointingHandCursor, :ForbiddenCursor, :WhatsThisCursor, :BusyCursor, :OpenHandCursor, :ClosedHandCursor, :DragCopyCursor, :DragMoveCursor, :DragLinkCursor, :LastCursor, :BitmapCursor, :CustomCursor]
@qtenum :PenCapStyle [:FlatCap, :SquareCap, :RoundCap, :MPenCapStyle]
@qtenum :BGMode [:TransparentMode, :OpaqueMode]
@qtenum :ScrollBarPolicy [:ScrollBarAsNeeded, :ScrollBarAlwaysOff, :ScrollBarAlwaysOn]
@qtenum :ApplicationState [:ApplicationSuspended, :ApplicationHidden, :ApplicationInactive, :ApplicationActive]
@qtenum :Axis [:XAxis, :YAxis, :ZAxis]
@qtenum :EventPriority [:HighEventPriority, :NormalEventPriority, :LowEventPriority]
@qtenum :BrushStyle [:NoBrush, :SolidPattern, :Dense1Pattern, :Dense2Pattern, :Dense3Pattern, :Dense4Pattern, :Dense5Pattern, :Dense6Pattern, :Dense7Pattern, :HorPattern, :VerPattern, :CrossPattern, :BDiagPattern, :FDiagPattern, :DiagCrossPattern, :LinearGradientPattern, :RadialGradientPattern, :ConicalGradientPattern, :TexturePattern]
@qtenum :Modifier [:META, :SHIFT, :CTRL, :ALT, :MODIFIER_MASK, :UNICODE_ACCEL]
@qtenum :InputMethodHint [:ImhNone, :ImhHiddenText, :ImhSensitiveData, :ImhNoAutoUppercase, :ImhPreferNumbers, :ImhPreferUppercase, :ImhPreferLowercase, :ImhNoPredictiveText, :ImhDate, :ImhTime, :ImhPreferLatin, :ImhMultiLine, :ImhNoEditMenu, :ImhNoTextHandles, :ImhDigitsOnly, :ImhFormattedNumbersOnly, :ImhUppercaseOnly, :ImhLowercaseOnly, :ImhDialableCharactersOnly, :ImhEmailCharactersOnly, :ImhUrlCharactersOnly, :ImhLatinOnly, :ImhExclusiveInputMask]
@qtenum :DockWidgetAreaSizes [:NDockWidgetAreas]
@qtenum :DockWidgetArea [:LeftDockWidgetArea, :RightDockWidgetArea, :TopDockWidgetArea, :BottomDockWidgetArea, :DockWidgetArea_Mask, :AllDockWidgetAreas, :NoDockWidgetArea]
@qtenum :ContextMenuPolicy [:NoContextMenu, :DefaultContextMenu, :ActionsContextMenu, :CustomContextMenu, :PreventContextMenu]
@qtenum :WindowModality [:NonModal, :WindowModal, :ApplicationModal]
@qtenum :DateFormat [:TextDate, :ISODate, :SystemLocaleDate, :LocalDate, :LocaleDate, :SystemLocaleShortDate, :SystemLocaleLongDate, :DefaultLocaleShortDate, :DefaultLocaleLongDate, :RFC2822Date, :ISODateWithMs]
@qtenum :ApplicationAttribute [:AA_ImmediateWidgetCreation, :AA_MSWindowsUseDirect3DByDefault, :AA_DontShowIconsInMenus, :AA_NativeWindows, :AA_DontCreateNativeWidgetSiblings, :AA_PluginApplication, :AA_MacPluginApplication, :AA_DontUseNativeMenuBar, :AA_MacDontSwapCtrlAndMeta, :AA_Use96Dpi, :AA_X11InitThreads, :AA_SynthesizeTouchForUnhandledMouseEvents, :AA_SynthesizeMouseForUnhandledTouchEvents, :AA_UseHighDpiPixmaps, :AA_ForceRasterWidgets, :AA_UseDesktopOpenGL, :AA_UseOpenGLES, :AA_UseSoftwareOpenGL, :AA_ShareOpenGLContexts, :AA_SetPalette, :AA_EnableHighDpiScaling, :AA_DisableHighDpiScaling, :AA_UseStyleSheetPropagationInWidgetStyles, :AA_DontUseNativeDialogs, :AA_SynthesizeMouseForUnhandledTabletEvents, :AA_CompressHighFrequencyEvents, :AA_DontCheckOpenGLContextThreadAffinity, :AA_DisableShaderDiskCache, :AA_DontShowShortcutsInContextMenus, :AA_CompressTabletEvents, :AA_DisableWindowContextHelpButton, :AA_AttributeCount]
@qtenum :CaseSensitivity [:CaseInsensitive, :CaseSensitive]
@qtenum :CoordinateSystem [:DeviceCoordinates, :LogicalCoordinates]
@qtenum :ItemSelectionMode [:ContainsItemShape, :IntersectsItemShape, :ContainsItemBoundingRect, :IntersectsItemBoundingRect]
@qtenum :ItemFlag [:NoItemFlags, :ItemIsSelectable, :ItemIsEditable, :ItemIsDragEnabled, :ItemIsDropEnabled, :ItemIsUserCheckable, :ItemIsEnabled, :ItemIsAutoTristate, :ItemIsTristate, :ItemNeverHasChildren, :ItemIsUserTristate]
@qtenum :FillRule [:OddEvenFill, :WindingFill]
@qtenum :ImageConversionFlag [:ColorMode_Mask, :AutoColor, :ColorOnly, :MonoOnly, :AlphaDither_Mask, :ThresholdAlphaDither, :OrderedAlphaDither, :DiffuseAlphaDither, :NoAlpha, :Dither_Mask, :DiffuseDither, :OrderedDither, :ThresholdDither, :DitherMode_Mask, :AutoDither, :PreferDither, :AvoidDither, :NoOpaqueDetection, :NoFormatConversion]
@qtenum :GestureFlag [:DontStartGestureOnChildren, :ReceivePartialGestures, :IgnoredGesturesPropagateToParent]
@qtenum :WindowFrameSection [:NoSection, :LeftSection, :TopLeftSection, :TopSection, :TopRightSection, :RightSection, :BottomRightSection, :BottomSection, :BottomLeftSection, :TitleBarArea]
@qtenum :ToolButtonStyle [:ToolButtonIconOnly, :ToolButtonTextOnly, :ToolButtonTextBesideIcon, :ToolButtonTextUnderIcon, :ToolButtonFollowStyle]
@qtenum :TextFormat [:PlainText, :RichText, :AutoText]
@qtenum :TimeSpec [:LocalTime, :UTC, :OffsetFromUTC, :TimeZone]
@qtenum :ScrollPhase [:NoScrollPhase, :ScrollBegin, :ScrollUpdate, :ScrollEnd, :ScrollMomentum]
@qtenum :TimerType [:PreciseTimer, :CoarseTimer, :VeryCoarseTimer]
@qtenum :KeyboardModifier [:NoModifier, :ShiftModifier, :ControlModifier, :AltModifier, :MetaModifier, :KeypadModifier, :GroupSwitchModifier, :KeyboardModifierMask]
@qtenum :GestureState [:NoGesture, :GestureStarted, :GestureUpdated, :GestureFinished, :GestureCanceled]
@qtenum :Corner [:TopLeftCorner, :TopRightCorner, :BottomLeftCorner, :BottomRightCorner]
@qtenum :GestureType [:TapGesture, :TapAndHoldGesture, :PanGesture, :PinchGesture, :SwipeGesture, :CustomGesture, :LastGestureType]
@qtenum :TabFocusBehavior [:NoTabFocus, :TabFocusTextControls, :TabFocusListControls, :TabFocusAllControls]
@qtenum :TextInteractionFlag [:NoTextInteraction, :TextSelectableByMouse, :TextSelectableByKeyboard, :LinksAccessibleByMouse, :LinksAccessibleByKeyboard, :TextEditable, :TextEditorInteraction, :TextBrowserInteraction]
@qtenum :ToolBarAreaSizes [:NToolBarAreas]
@qtenum :UIEffect [:UI_General, :UI_AnimateMenu, :UI_FadeMenu, :UI_AnimateCombo, :UI_AnimateTooltip, :UI_FadeTooltip, :UI_AnimateToolBox]
@qtenum :WindowState [:WindowNoState, :WindowMinimized, :WindowMaximized, :WindowFullScreen, :WindowActive]
@qtenum :MatchFlag [:MatchExactly, :MatchContains, :MatchStartsWith, :MatchEndsWith, :MatchRegExp, :MatchWildcard, :MatchFixedString, :MatchCaseSensitive, :MatchWrap, :MatchRecursive]
@qtenum :ShortcutContext [:WidgetShortcut, :WindowShortcut, :ApplicationShortcut, :WidgetWithChildrenShortcut]
@qtenum :ItemSelectionOperation [:ReplaceSelection, :AddToSelection]
@qtenum :TouchPointState [:TouchPointPressed, :TouchPointMoved, :TouchPointStationary, :TouchPointReleased]
@qtenum :ClipOperation [:NoClip, :ReplaceClip, :IntersectClip]
@qtenum :WidgetAttribute [:WA_Disabled, :WA_UnderMouse, :WA_MouseTracking, :WA_ContentsPropagated, :WA_OpaquePaintEvent, :WA_NoBackground, :WA_StaticContents, :WA_LaidOut, :WA_PaintOnScreen, :WA_NoSystemBackground, :WA_UpdatesDisabled, :WA_Mapped, :WA_MacNoClickThrough, :WA_InputMethodEnabled, :WA_WState_Visible, :WA_WState_Hidden, :WA_ForceDisabled, :WA_KeyCompression, :WA_PendingMoveEvent, :WA_PendingResizeEvent, :WA_SetPalette, :WA_SetFont, :WA_SetCursor, :WA_NoChildEventsFromChildren, :WA_WindowModified, :WA_Resized, :WA_Moved, :WA_PendingUpdate, :WA_InvalidSize, :WA_MacBrushedMetal, :WA_MacMetalStyle, :WA_CustomWhatsThis, :WA_LayoutOnEntireRect, :WA_OutsideWSRange, :WA_GrabbedShortcut, :WA_TransparentForMouseEvents, :WA_PaintUnclipped, :WA_SetWindowIcon, :WA_NoMouseReplay, :WA_DeleteOnClose, :WA_RightToLeft, :WA_SetLayoutDirection, :WA_NoChildEventsForParent, :WA_ForceUpdatesDisabled, :WA_WState_Created, :WA_WState_CompressKeys, :WA_WState_InPaintEvent, :WA_WState_Reparented, :WA_WState_ConfigPending, :WA_WState_Polished, :WA_WState_DND, :WA_WState_OwnSizePolicy, :WA_WState_ExplicitShowHide, :WA_ShowModal, :WA_MouseNoMask, :WA_GroupLeader, :WA_NoMousePropagation, :WA_Hover, :WA_InputMethodTransparent, :WA_QuitOnClose, :WA_KeyboardFocusChange, :WA_AcceptDrops, :WA_DropSiteRegistered, :WA_ForceAcceptDrops, :WA_WindowPropagation, :WA_NoX11EventCompression, :WA_TintedBackground, :WA_X11OpenGLOverlay, :WA_AlwaysShowToolTips, :WA_MacOpaqueSizeGrip, :WA_SetStyle, :WA_SetLocale, :WA_MacShowFocusRect, :WA_MacNormalSize, :WA_MacSmallSize, :WA_MacMiniSize, :WA_LayoutUsesWidgetRect, :WA_StyledBackground, :WA_MSWindowsUseDirect3D, :WA_CanHostQMdiSubWindowTitleBar, :WA_MacAlwaysShowToolWindow, :WA_StyleSheet, :WA_ShowWithoutActivating, :WA_X11BypassTransientForHint, :WA_NativeWindow, :WA_DontCreateNativeAncestors, :WA_MacVariableSize, :WA_DontShowOnScreen, :WA_X11NetWmWindowTypeDesktop, :WA_X11NetWmWindowTypeDock, :WA_X11NetWmWindowTypeToolBar, :WA_X11NetWmWindowTypeMenu, :WA_X11NetWmWindowTypeUtility, :WA_X11NetWmWindowTypeSplash, :WA_X11NetWmWindowTypeDialog, :WA_X11NetWmWindowTypeDropDownMenu, :WA_X11NetWmWindowTypePopupMenu, :WA_X11NetWmWindowTypeToolTip, :WA_X11NetWmWindowTypeNotification, :WA_X11NetWmWindowTypeCombo, :WA_X11NetWmWindowTypeDND, :WA_MacFrameworkScaled, :WA_SetWindowModality, :WA_WState_WindowOpacitySet, :WA_TranslucentBackground, :WA_AcceptTouchEvents, :WA_WState_AcceptedTouchBeginEvent, :WA_TouchPadAcceptSingleTouchEvents, :WA_X11DoNotAcceptFocus, :WA_MacNoShadow, :WA_AlwaysStackOnTop, :WA_TabletTracking, :WA_ContentsMarginsRespectsSafeArea, :WA_StyleSheetTarget, :WA_AttributeCount]
@qtenum :ToolBarArea [:LeftToolBarArea, :RightToolBarArea, :TopToolBarArea, :BottomToolBarArea, :ToolBarArea_Mask, :AllToolBarAreas, :NoToolBarArea]
@qtenum :MouseEventFlag [:MouseEventCreatedDoubleClick, :MouseEventFlagMask]
@qtenum :AnchorPoint [:AnchorLeft, :AnchorHorizontalCenter, :AnchorRight, :AnchorTop, :AnchorVerticalCenter, :AnchorBottom]

end
