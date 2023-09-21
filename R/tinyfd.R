
#' @export
tinyfd_beep <- function(){
    tfdR_beep()
    ##.Call("tfdR_beep")
}

## * return has only meaning for tinyfd_query */
## int tinyfd_notifyPopup(
## 		char const * aTitle, /* NULL or "" */
## 		char const * aMessage , /* NULL or "" may contain \n \t */
## 		char const * aIconType ) /* "info" "warning" "error" */
#' @export
tinyfd_notifyPopup <- function(title,message,icon=c("info","warning","error")){
    icon <- match.arg(icon)
    title <- paste(title)
    message <- paste(message)
    tfdR_notifyPopup(title,message,icon)
}

## int tinyfd_messageBox(
## 		char const * aTitle, /* NULL or "" */
## 		char const * aMessage, /* NULL or ""  may contain \n and \t */
## 		char const * aDialogType, /* "ok" "okcancel" "yesno" "yesnocancel" */
## 		char const * aIconType, /* "info" "warning" "error" "question" */
##         int aDefaultButton) /* 0 for cancel/no , 1 for ok/yes , 2 for no in yesnocancel */

#' @export
tinyfd_messageBox <- function(title,message,type=c("ok","okcancel","yesno","yesnocancel"),
                              icon=c("info","warning","error","question"),
                              button=0){
    type <- match.arg(type)
    icon <- match.arg(icon)
    button <- as.integer(button)
    if( !(button %in% 0:2) ){ stop("Invalid button option") }
    title <- paste(title)
    message <- paste(message)
    tfdR_messageBox(title,message,type,icon,button)
}

#' @export
tinyfd_inputBox <- function(title,message,defaultInput){
    title <- paste(title)
    message <- paste(message)
    defaultInput <- paste(defaultInput)
    tfdR_inputBox(title,message,defaultInput)
}

## char const * aTitle , /* NULL or "" */
## char const * aDefaultPathAndFile , /* NULL or "" */
## int aNumOfFilterPatterns , /* 0 */
## char const * const * aFilterPatterns , /* NULL or {"*.jpg","*.png"} */
## char const * aSingleFilterDescription ) /* NULL or "image files" */                  
#' @export
tinyfd_saveFileDialog <- function(title, defaultFileAndPath=".",filterPatterns,filterDescription){
    title <- paste(title)
    defaultFileAndPath <- paste(defaultFileAndPath)
    filterPatterns <- as.character(filterPatterns)
    nFilterPatterns <- length(filterPatterns)
    filterDescripton <- paste(filterDescription)
    tfdR_saveFileDialog(title, defaultFileAndPath,
                        nFilterPatterns, filterPatterns,
                        filterDescription)
}

#' @export
tinyfd_openFileDialog <- function(title, defaultFileAndPath=".",filterPatterns,filterDescription, allowMultiple=c(TRUE,FALSE)){
    title <- paste(title)
    defaultFileAndPath <- paste(defaultFileAndPath)
    filterPatterns <- as.character(filterPatterns)
    nFilterPatterns <- length(filterPatterns)
    filterDescripton <- paste(filterDescription)
    allowMultiple <- as.integer(as.logical(allowMultiple))
    tfdR_openFileDialog(title, defaultFileAndPath,
                        nFilterPatterns, filterPatterns,
                        filterDescription,allowMultiple)
}

#' @export
tinyfd_selectFolderDialog <- function(title, defaultPath="."){
    title <- paste(title)
    defaultPath <- paste(defaultPath)
    tfdR_selectFolderDialog(title, defaultPath)
}

#' @export
tinyfd_colorChooser <- function(title, defaultHex="#FF0000"){
    title <- paste(title)
    defaultHex <- paste(defaultHex)
    tfdR_colorChooser(title, defaultHex)
}

#' @export
tinyfd_version <- function(){ tfdR_version() }
#' @export
tinyfd_response <- function(){ tfdR_response() }
