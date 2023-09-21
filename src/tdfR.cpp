#include "Rcpp.h"
#include "tinyfiledialogs.h"


const char* nullToEmpty( char const* s)
{
    return (s ? s : "");
}

// [[Rcpp::export]]
bool tfdR_beep(){
  tinyfd_beep();
  return(true);
}

// [[Rcpp::export]]
int tfdR_notifyPopup(std::string title, std::string message, std::string icon){
  int out = tinyfd_notifyPopup(title.c_str(),
			       message.c_str(),
			       icon.c_str());
  return(out);
}

// [[Rcpp::export]]
int tfdR_messageBox(std::string title, std::string message, std::string dialog, std::string icon, int button){
  int out = tinyfd_messageBox(title.c_str(),
			      message.c_str(),
			      dialog.c_str(),
			      icon.c_str(),
			      button);
  return(out);
}

// [[Rcpp::export]]
std::string tfdR_inputBox(std::string title, std::string message, std::string defaultInput){
  std::string out = nullToEmpty( tinyfd_inputBox(title.c_str(),
						 message.c_str(),
						 defaultInput.c_str())
				 );
  return(out);
}
			   

// [[Rcpp::export]]
std::string tfdR_saveFileDialog(std::string title, std::string defaultPathAndFile,
				int nFilterPatterns, std::vector<std::string> filterPatterns,
				std::string singleFilterDescription){
  std::vector<const char*> fP;
  for (long unsigned int i = 0; i < filterPatterns.size(); ++i)
    fP.push_back(filterPatterns[i].c_str());
  
  std::string out = nullToEmpty( tinyfd_saveFileDialog(title.c_str(),
						       defaultPathAndFile.c_str(),
						       nFilterPatterns,
						       fP.data(),
						       singleFilterDescription.c_str())
				 );
  return(out);
}

// [[Rcpp::export]]
std::string tfdR_openFileDialog(std::string title, std::string defaultPathAndFile,
				int nFilterPatterns, std::vector<std::string> filterPatterns,
				std::string singleFilterDescription, int allowMultipleSelects){
  
  std::vector<const char*> fP;
  for (long unsigned int i = 0; i < filterPatterns.size(); ++i)
    fP.push_back(filterPatterns[i].c_str());
  
  std::string out = nullToEmpty( tinyfd_openFileDialog(title.c_str(),
						       defaultPathAndFile.c_str(),
						       nFilterPatterns,
						       fP.data(),
						       singleFilterDescription.c_str(),
						       allowMultipleSelects)
				 );
  return(out);
}

// [[Rcpp::export]]
std::string tfdR_selectFolderDialog(std::string title, std::string defaultPath){
  std::string out = nullToEmpty( tinyfd_selectFolderDialog(title.c_str(),
							   defaultPath.c_str()) );
  return(out);
}

// [[Rcpp::export]]
std::string tfdR_colorChooser(std::string title, std::string defaultHexRGB){
  
  // these aren't used - I hope
  unsigned char const aDefaultRGB [ 3 ] = {128,128,128};
  unsigned char aoResultRGB [ 3 ] = {128,128,128};
  
  std::string out = nullToEmpty( tinyfd_colorChooser(title.c_str(),
						     defaultHexRGB.c_str(),
						     aDefaultRGB, aoResultRGB)
				 );
  return(out);
}

// [[Rcpp::export]]
std::string tfdR_version(){
  std::string out(nullToEmpty( tinyfd_version) );
  return(out);
}

// [[Rcpp::export]]
std::string tfdR_response(){
  int tmp = tfdR_messageBox("tinyfd_query","","ok","error",0); // returns an unsed variable warning
  std::string out( nullToEmpty(tinyfd_response) );
  return(out);
}
