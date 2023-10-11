#include <R.h>
#include <Rdefines.h>
#include "tinyfiledialogs.h"
#include <string.h>

// Define strict headers
#define STRICT_R_HEADERS

void tfd_details(
		 int * isGUI,
		 char * * response,
		 char * * version
		 )
{
  * isGUI = tinyfd_messageBox("tinyfd_query","","ok","error",0);
  strcpy ( * response , tinyfd_response );
  strcpy ( * version , tinyfd_version );
}

void tfd_beep(void){
  tinyfd_beep();
}

void tfd_messageBox(
		    //char const * aTitle ,
		    char * * aTitle,
		    char * * aMessage ,
		    char * * aDialogType ,
		    char * * aIconType ,
		    int * aiDefaultButton )
{
	* aiDefaultButton = tinyfd_messageBox( *aTitle , *aMessage , *aDialogType , *aIconType , * aiDefaultButton ) ;
}

void tfd_notifyPopup(
	char * * aTitle ,
	char * * aMessage ,
	char * * aIconType ,
	int * out)
{
	* out = tinyfd_notifyPopup( *aTitle , *aMessage , *aIconType ) ;
}

SEXP tfd_inputBox(
		  SEXP aTitle ,
		  SEXP aMessage ,
		  SEXP aiDefaultInput )
{
  PROTECT(aTitle = Rf_asChar(aTitle));
  PROTECT(aMessage = Rf_asChar(aMessage));
  PROTECT(aiDefaultInput = Rf_asChar(aiDefaultInput));
  SEXP result;
  PROTECT(result = R_BlankScalarString);
  
  char * lReturnedInput ;
  if ( ! strcmp( Rf_translateCharUTF8(aiDefaultInput) , "hidden_input") ){
    lReturnedInput = tinyfd_inputBox( Rf_translateCharUTF8(aTitle) , Rf_translateCharUTF8(aMessage) , NULL ) ;
  }else{
    lReturnedInput = tinyfd_inputBox( Rf_translateCharUTF8(aTitle) , Rf_translateCharUTF8(aMessage) ,
				      Rf_translateCharUTF8(aiDefaultInput) ) ;
  }
  if ( lReturnedInput ) result = Rf_mkString(lReturnedInput);
  return(result);
}

SEXP tfd_saveFileDialog(
	SEXP aTitle ,
	SEXP aiDefaultPathAndFile ,
	SEXP aNumOfFilterPatterns ,
	SEXP aFilterPatterns ,
	SEXP aSingleFilterDescription)
{
  PROTECT(aTitle = Rf_asChar(aTitle));
  PROTECT(aiDefaultPathAndFile = Rf_asChar(aiDefaultPathAndFile));
  PROTECT(aNumOfFilterPatterns = AS_INTEGER(aNumOfFilterPatterns));
  PROTECT(aFilterPatterns = Rf_asChar(aFilterPatterns));
  PROTECT(aSingleFilterDescription = Rf_asChar(aSingleFilterDescription));

  char * lOpenfile;
  const char * fp = Rf_translateCharUTF8(aFilterPatterns);
  SEXP result;
  PROTECT(result = R_BlankScalarString);
  
  lOpenfile = tinyfd_saveFileDialog( Rf_translateCharUTF8(aTitle) , Rf_translateCharUTF8(aiDefaultPathAndFile) ,
   				     *INTEGER(aNumOfFilterPatterns) , &fp, //tmp,
  				     Rf_translateCharUTF8(aSingleFilterDescription));
  if( lOpenfile ) result = Rf_mkString(lOpenfile);
  
  UNPROTECT(6);
  return(result);
}

SEXP tfd_openFileDialog(
	SEXP aTitle ,
	SEXP aiDefaultPathAndFile ,
	SEXP aNumOfFilterPatterns ,
	SEXP aFilterPatterns ,
	SEXP aSingleFilterDescription ,
	SEXP aAllowMultipleSelects )
{
  PROTECT(aTitle = Rf_asChar(aTitle));
  PROTECT(aiDefaultPathAndFile = Rf_asChar(aiDefaultPathAndFile));
  PROTECT(aNumOfFilterPatterns = AS_INTEGER(aNumOfFilterPatterns));
  PROTECT(aFilterPatterns = Rf_asChar(aFilterPatterns));
  PROTECT(aSingleFilterDescription = Rf_asChar(aSingleFilterDescription));
  PROTECT(aAllowMultipleSelects = AS_INTEGER(aAllowMultipleSelects));

  char * lOpenfile;
  const char * fp = Rf_translateCharUTF8(aFilterPatterns);
  //  const char * const * tmp = &Rf_translateCharUTF8(aFilterPatterns); //ttmp;
  SEXP result;
  PROTECT(result = R_BlankScalarString);
  
  lOpenfile = tinyfd_openFileDialog( Rf_translateCharUTF8(aTitle) , Rf_translateCharUTF8(aiDefaultPathAndFile) ,
   				     *INTEGER(aNumOfFilterPatterns) , &fp, //tmp,
  				     Rf_translateCharUTF8(aSingleFilterDescription), *INTEGER(aAllowMultipleSelects)
				     );
  if( lOpenfile ) result = Rf_mkString(lOpenfile);
  
  UNPROTECT(7);
  return(result);
}

SEXP tfd_selectFolderDialog(
	SEXP aTitle ,
	SEXP aiDefaultPath)
{
  PROTECT(aTitle = Rf_asChar(aTitle));
  PROTECT(aiDefaultPath = Rf_asChar(aiDefaultPath));
  SEXP result;
  PROTECT(result = R_BlankScalarString);

  char * lSelectedfolder ;
  lSelectedfolder = tinyfd_selectFolderDialog( Rf_translateCharUTF8(aTitle), Rf_translateCharUTF8(aiDefaultPath) ) ;
  if ( lSelectedfolder ) result = Rf_mkString( lSelectedfolder ) ;
  
  UNPROTECT(3);
  return(result);
}

SEXP tfd_colorChooser(
	SEXP aTitle ,
	SEXP aiDefaultHexRGB )
{
  PROTECT(aTitle = Rf_asChar(aTitle));
  PROTECT(aiDefaultHexRGB = Rf_asChar(aiDefaultHexRGB));
  SEXP result;
  PROTECT(result = R_BlankScalarString);
  
  unsigned char const aDefaultRGB [ 3 ] = {128,128,128};
  unsigned char aoResultRGB [ 3 ] = {128,128,128};
  char * lChosenColor ;
  lChosenColor = tinyfd_colorChooser( Rf_translateCharUTF8(aTitle), Rf_translateCharUTF8(aiDefaultHexRGB),
				      aDefaultRGB, aoResultRGB ) ;
  if ( lChosenColor ) result = Rf_mkString( lChosenColor ) ;
  
  UNPROTECT(3);
  return(result);
}

