## this roughly replicate hello.c

tinyfd_beep()


details <- tinyfd_details()

if(!details$isGUI) { stop("We can't run interactively and there is no console mode yet!!") }

lBuffer <- paste0("tinyfiledialogs\nv",details$version,"\ngraphic mode: ",details$response)
tinyfd_messageBox("hello", lBuffer, "ok", "info", 0);


tinyfd_notifyPopup("the title", "the message\n\tfrom outer-space", "info");

## yes = 1, no = 2, cancel = 0
lIntValue <- tinyfd_messageBox("Hello World", "graphic dialogs [Yes]\n console mode [No]\n quit [Cancel]",
                               "yesnocancel", "question", 1)

if( lIntValue == 2 ){ stop("No handled the console case yet...") }
if( lIntValue == 0 ){ stop("Goodbye - you've chosen to cancel") }

lPassword = tinyfd_inputBox("a password box", "your password will be revealed later", "hidden_input");

if (nchar(lPassword) == 0 ){ stop("You need to give a password") }

tinyfd_messageBox("your password as read", lPassword, "ok", "info", 1);

lTheSaveFileName = tinyfd_saveFileDialog(
    "let us save this password",
    "../../passwordFile.txt",
    c("*.txt", "*.text"),
    "")

if(nchar(lTheSaveFileName) == 0 ){ 
    tinyfd_messageBox(
        "Error",
        "Save file name is NULL",
        "ok",
        "error",
        1);
    stop()
}

writeLines(lPassword,lTheSaveFileName)

lTheOpenFileName = tinyfd_openFileDialog(
    "let us read the password back",
    "",
    c("*.txt", "*.text"),
    "text files",
    FALSE)

if( nchar(lTheOpenFileName)==0 ){
    tinyfd_messageBox(
        "Error",
        "Open file name is NULL",
        "ok",
        "error",
        0)
    stop()
}

lBuffer = readLines(lTheOpenFileName)

tinyfd_messageBox("your password as it was saved", lBuffer, "ok", "info", 1)

lTheSelectFolderName = tinyfd_selectFolderDialog("let us just select a directory", "")

if( nchar(lTheSelectFolderName)==0 ){
    tinyfd_messageBox(
        "Error",
        "Select folder name is NULL",
        "ok",
        "error",
        1)
    stop()
}

tinyfd_messageBox("The selected folder is", lTheSelectFolderName, "ok", "info", 1)

lTheHexColor = tinyfd_colorChooser("choose a nice color","#FF0077")
if (nchar(lTheHexColor) == 0) {
    tinyfd_messageBox(
        "Error",
        "hexcolor is NULL",
        "ok",
        "error",
        1)
    stop()
}

tinyfd_messageBox("The selected hexcolor is", lTheHexColor, "ok", "info", 1);

tinyfd_messageBox("your read password was", lPassword, "ok", "info", 1);
