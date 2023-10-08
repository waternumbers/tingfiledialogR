#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
   Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void tfd_messageBox(void *, void *, void *, void *, void *);
extern void tfd_beep(void);
extern void tfd_notifyPopup(void *, void *, void *, void *);
extern void tfd_details(void *, void *, void *);

static const R_CMethodDef CEntries[] = {
  {"tfd_messageBox",         (DL_FUNC) &tfd_messageBox,         5},
  {"tfd_beep",               (DL_FUNC) &tfd_beep,               0},
  {"tfd_notifyPopup",        (DL_FUNC) &tfd_notifyPopup,        4},
  {"tfd_details",            (DL_FUNC) &tfd_details,            3},
  {NULL, NULL, 0}
};


/* .Call calls */
extern SEXP tfd_openFileDialog(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP tfd_saveFileDialog(SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP tfd_colorChooser(SEXP, SEXP);
extern SEXP tfd_inputBox(SEXP, SEXP, SEXP);
extern SEXP tfd_selectFolderDialog(SEXP, SEXP);


static const R_CallMethodDef CallEntries[] = {
    {"tfd_openFileDialog", (DL_FUNC) &tfd_openFileDialog, 6},
    {"tfd_saveFileDialog", (DL_FUNC) &tfd_saveFileDialog, 5},
    {"tfd_colorChooser",       (DL_FUNC) &tfd_colorChooser,       2},
    {"tfd_inputBox",           (DL_FUNC) &tfd_inputBox,           3},
    {"tfd_selectFolderDialog", (DL_FUNC) &tfd_selectFolderDialog, 2},
    {NULL, NULL, 0}
};



void R_init_tinyfiledialogsR(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
