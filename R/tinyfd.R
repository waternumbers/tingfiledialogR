
char2Raw <- function(x){ charToRaw( enc2utf8 (x) ) }

#' @export
tinyfd_beep <- function(){
    .C("tfd_beep")
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
    result <- .C("tfd_notifyPopup",
                 char2Raw(title),
                 char2Raw(message),
                 char2Raw(icon),
                 integer(1))
    return(result[[4]])
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
    title <- enc2utf8(paste(title))
    message <- enc2utf8(paste(message))
    result <- .C("tfd_messageBox",
                 char2Raw(title),
                 char2Raw(message),
                 char2Raw(type),
                 char2Raw(icon),
                 as.integer(button))
    return(result[[5]])
}

#' @export
tinyfd_inputBox <- function(title,message,defaultInput){
    title <- paste(title)
    message <- paste(message)
    defaultInput <- paste(defaultInput)
    result <- .C("tfd_inputBox",
                 char2Raw(title),
                 char2Raw(message),
                 char2Raw(defaultInput))
    return( result[[3]] )
    ##tfdR_inputBox(title,message,defaultInput)
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
    result <- .C("tfd_saveFileDialog",
                 char2Raw(title),
                 defaultFileAndPath,
                 nFilterPatterns,
                 filterPatterns,
                 char2Raw(filterDescription))
    return( result[[2]] )
    ## tfdR_saveFileDialog(title, defaultFileAndPath,
    ##                     nFilterPatterns, filterPatterns,
    ##                     filterDescription)
}

#' @export
tinyfd_openFileDialog <- function(title, defaultFileAndPath=".",filterPatterns,filterDescription, allowMultiple=c(TRUE,FALSE)){
    title <- paste(title)
    defaultFileAndPath <- paste(defaultFileAndPath)
    filterPatterns <- as.character(filterPatterns)
    nFilterPatterns <- length(filterPatterns)
    filterDescripton <- paste(filterDescription)
    allowMultiple <- as.integer(as.logical(allowMultiple))
    result <- .C("tfd_openFileDialog",
                 char2Raw(title),
                 char2Raw(defaultFileAndPath),
                 nFilterPatterns,
                 char2Raw(filterPatterns),
                 char2Raw(filterDescription),
                 allowMultiple)
    return( result[[2]] )
    
    ## tfdR_openFileDialog(title, defaultFileAndPath,
    ##                     nFilterPatterns, filterPatterns,
    ##                     filterDescription,allowMultiple)
}

#' @export
tinyfd_selectFolderDialog <- function(title, defaultPath="."){
    title <- paste(title)
    defaultPath <- paste(defaultPath)
    result <- .C("tfd_selectFolderDialog",
                 char2Raw(title),
                 defaultPath)
    return( result[[2]] )
    ##tfdR_selectFolderDialog(title, defaultPath)
}

#' @export
tinyfd_colorChooser <- function(title, defaultHex="#FF0000"){
    title <- paste(title)
    defaultHex <- paste(defaultHex)
    result <- .C("tfd_colorChooser",
                 char2Raw(title),
                 defaultHex)
    return( result[[2]] )
    ##tfdR_colorChooser(title, defaultHex)
}

#' @export
tinyfd_details <- function(){
    out <- list(response = character(0),
                isGUI = integer(1))
    result <- .C("tfd_details",
                 integer(1),
                 character(1),
                 character(1))
    result[[1]] <- as.logical(result[[1]])
    names(result) <- c("isGUI","response","version")
    return(result)
}
