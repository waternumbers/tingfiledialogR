#include "tinyfiledialogs.h"
#include <string.h>
/* Modified prototypes for R */

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

void tfd_beep(){
  tinyfd_beep();
}

void tfd_messageBox(
	char const * aTitle ,
	char const * aMessage ,
	char const * aDialogType ,
	char const * aIconType ,
	int * aiDefaultButton )
{
	* aiDefaultButton = tinyfd_messageBox( aTitle , aMessage , aDialogType , aIconType , * aiDefaultButton ) ;
}

void tfd_notifyPopup(
	char const * aTitle ,
	char const * aMessage ,
	char const * aIconType ,
	int * out)
{
	* out = tinyfd_notifyPopup( aTitle , aMessage , aIconType ) ;
}

void tfd_inputBox(
	char const * aTitle ,
	char const * aMessage ,
	char * * aiDefaultInput )
{
	char * lReturnedInput ;
	if ( ! strcmp( * aiDefaultInput , "NULL") )  lReturnedInput = tinyfd_inputBox( aTitle , aMessage , NULL ) ;
	else lReturnedInput = tinyfd_inputBox( aTitle , aMessage , * aiDefaultInput ) ;

	if ( lReturnedInput ) strcpy ( * aiDefaultInput , lReturnedInput ) ;
	else strcpy ( * aiDefaultInput , "" ) ;
}


void tfd_saveFileDialog(
	char const * aTitle ,
	char * * aiDefaultPathAndFile ,
	int const * aNumOfFilterPatterns ,
	char const * const * aFilterPatterns ,
	char const * aSingleFilterDescription )
{
	char * lSavefile ;

	/* printf( "aFilterPatterns %s\n" , aFilterPatterns [0]); */

	lSavefile = tinyfd_saveFileDialog( aTitle , * aiDefaultPathAndFile , * aNumOfFilterPatterns ,
										aFilterPatterns, aSingleFilterDescription ) ;
	if ( lSavefile ) strcpy ( * aiDefaultPathAndFile , lSavefile ) ;
	else strcpy ( * aiDefaultPathAndFile , "" ) ;
}


void tfd_openFileDialog(
	char const * aTitle ,
	char * * aiDefaultPathAndFile ,
	int const * aNumOfFilterPatterns ,
	char const * const * aFilterPatterns ,
	char const * aSingleFilterDescription ,
	int const * aAllowMultipleSelects )
{
	char * lOpenfile ;

	/* printf( "aFilterPatterns %s\n" , aFilterPatterns [0]); */

	lOpenfile = tinyfd_openFileDialog( aTitle , * aiDefaultPathAndFile , * aNumOfFilterPatterns ,
									aFilterPatterns , aSingleFilterDescription , * aAllowMultipleSelects ) ;

	if ( lOpenfile ) strcpy ( * aiDefaultPathAndFile , lOpenfile ) ;
	else strcpy ( * aiDefaultPathAndFile , "" ) ;
}


void tfd_selectFolderDialog(
	char const * aTitle ,
	char * * aiDefaultPath )
{
	char * lSelectedfolder ;
	lSelectedfolder = tinyfd_selectFolderDialog( aTitle, * aiDefaultPath ) ;
	if ( lSelectedfolder ) strcpy ( * aiDefaultPath , lSelectedfolder ) ;
	else strcpy ( * aiDefaultPath , "" ) ;
}


void tfd_colorChooser(
	char const * aTitle ,
	char * * aiDefaultHexRGB )
{
	unsigned char const aDefaultRGB [ 3 ] = {128,128,128};
	unsigned char aoResultRGB [ 3 ] = {128,128,128};
	char * lChosenColor ;
	lChosenColor = tinyfd_colorChooser( aTitle, * aiDefaultHexRGB, aDefaultRGB, aoResultRGB ) ;
	if ( lChosenColor ) strcpy ( * aiDefaultHexRGB , lChosenColor ) ;
	else strcpy ( * aiDefaultHexRGB , "" ) ;
}

/* end of Modified prototypes for R */

