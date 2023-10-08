## helper function for converting R objects into a single or multiple UTF-8 encoded character string
toSingleStr <- function(x){ enc2utf8( paste( x, collapse=" " ) ) }
toMultiStr <- function(x){ enc2utf8( paste( x ) ) }


#' Functions for creating tinyfiledialogs
#'
#' These function open different types of dialogs generated based on the tinyfiledialogs C package. See details for the types available.
#'
#' Describe them all....
#'
#' @param title The dialog title
#' @param message The message displayed in the dialog
#' @param icon The type of icon to use in the dialog
#' @param type The options for returning from the dialog
#' @param defaultInput text string determining the default input
#' @param defaultPathAndFile The default file and path to select from
#' @param filterPatterns Pattern for filetering file selection
#' @param filterDescription Textual description of the filter patterns
#' @param allowMultiple Should multiple selections be allowed
#' @param defaultHex Default color as a Hex string
#' @param button The default button selected
#' @param defaultPath The default selected path
#'
#' @return `tinyfd_beep` and `tinyfd_notifyPopup` return the value `1` when called.
#'
#' The output of `tinydf_messageBox` depends on the `type` used. In all cases clsoing the dialog returns `0`
#' \describe{
#' \item{ok}{`ok=1`}
#' \item{okcancel}{`ok=1`, `cancel=0`}
#' \item{yesno}{`yes=1`, `no=0`}
#' \item{yesnocancel}{`yes=1`, `no=2`, `cancel=0`}
#' }
#'
#' `tinyfd_inputBox` returns the text string entered.
#'
#' `tinyfd_saveFileDialog` and `tinyfd_openFileDialog` return the full path (or paths if the `allowMultiple` option is used) to the files selected.
#'
#' `tinyfd_selectFolderDialog` returns the full path to the folder selected
#' 
#' `tinyfd_colorChooser` returns the string representing the Hex code chosen is closed by pressing the OK button; otherwise a zero length string is returned.
#'
#' `tinyfd_details` returns a list containing whether a GUI is available (`isGUI`), the tinyfiledialogs verions (`version`) and the type of GUI available (`response`) the latter is one of :
#'  windows_wchar windows applescript kdialog zenity zenity3 yad matedialog
#'  shellementary qarma python2-tkinter python3-tkinter python-dbus
#'  perl-dbus gxmessage gmessage xmessage xdialog gdialog dunst
#' if a graphics mode is available. Other values such as
#' dialog whiptail basicinput no_solution
#' indicate a console mode which is not currently supported
#' 
#' @export
tinyfd_beep <- function(){
    .C("tfd_beep")
    return(1)
}

#' @describeIn tinyfd_beep Notification Popup
#' @export
tinyfd_notifyPopup <- function(title,message,icon=c("info","warning","error")){
    icon <- match.arg(icon)
    result <- .C("tfd_notifyPopup",
                 aTitle = toSingleStr(title),
                 aMessage = toSingleStr(message),
                 aIconType = enc2utf8(icon),
                 out = integer(1))
    return(result$out)
}

#' @describeIn tinyfd_beep Various types of message box
#' @export
tinyfd_messageBox <- function(title,message,type=c("ok","okcancel","yesno","yesnocancel"),
                              icon=c("info","warning","error","question"),
                              button=0){
    type <- match.arg(type)
    icon <- match.arg(icon)
    if( !(button %in% 0:2) ){ stop("Invalid button option") }
    result <- .C("tfd_messageBox",
                 aTitle = toSingleStr(title),
                 aMessage = toSingleStr(message),
                 aDialogType = enc2utf8(type),
                 aIconType = enc2utf8(icon),
                 aiDefaultButton = as.integer(button))
    return(result$aiDefaultButton)
}

#' @describeIn tinyfd_beep collect text input
#' @export
tinyfd_inputBox <- function(title,message,defaultInput=""){
    result <- .Call("tfd_inputBox",
                 aTitle = toSingleStr(title),
                 aMessage = toSingleStr(message),
                 aiDefaultInput = toSingleStr(defaultInput))
    return( result )
}

#' @describeIn tinyfd_beep select file to save in
#' @export
tinyfd_saveFileDialog <- function(title, defaultPathAndFile=".",filterPatterns="*.*",filterDescription="All Files"){
    result <- .Call("tfd_saveFileDialog",
                    aTitle = toSingleStr(title),
                    aiDefaultPathAndFile = toSingleStr(defaultPathAndFile),
                    aNumOfFilterPatterns = as.integer(length(filterPatterns)),
                    aFilterPatterns = toMultiStr(filterPatterns),
                    aSingleFilterDescription = toSingleStr(filterDescription))
    return( result )
}

#' @describeIn tinyfd_beep select file(s) to open
#' @export
tinyfd_openFileDialog <- function(title, defaultPathAndFile=".",
                                  filterPatterns="*.*",filterDescription="All files", allowMultiple=FALSE){
    allowMultiple <- as.logical(allowMultiple)
    result <- .Call("tfd_openFileDialog",
                    aTitle = title, ##toSingleStr(title),
                    aiDefaultPathAndFile = defaultPathAndFile, ##toSingleStr(defaultPathAndFile),
                    aNumOfFilterPatterns = as.integer(length(filterPatterns)),
                    aFilterPatterns = toMultiStr(filterPatterns),
                    aSingleFilterDescription = filterDescription, ##toSingleStr(filterDescription),
                    aAllowMultipleSelects = as.integer(allowMultiple))
    if(allowMultiple){
        result <- strsplit(result,"[|]")[[1]]
    }
    return( result )
}

#' @describeIn tinyfd_beep select folder
#' @export
tinyfd_selectFolderDialog <- function(title, defaultPath="."){
    result <- .Call("tfd_selectFolderDialog",
                    aTitle = toSingleStr(title),
                    aiDefaultPath = toSingleStr(defaultPath))
    return( result )
}

#' @describeIn tinyfd_beep select a color
#' @export
tinyfd_colorChooser <- function(title, defaultHex="#FF0000"){
    result <- .Call("tfd_colorChooser",
                    aTitle = toSingleStr(title),
                    aiDefaultHexRGB = toSingleStr(defaultHex))
    return( result )
}

#' @describeIn tinyfd_beep provide details of the tinyfiledialogs installation
#' @export
tinyfd_details <- function(){
    result <- .C("tfd_details",
                 isGUI = integer(1),
                 response = character(1),
                 version = character(1))
    result$isGUI <- as.logical(result$isGUI)
    return(result)
}
