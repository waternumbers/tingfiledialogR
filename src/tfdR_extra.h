// Added this header file into tinyfiledialogs.c after the include for tinyfiledialogs.h for R compilation
#include <R_ext/Print.h>
#define printf Rprintf
#ifdef _WIN32
 #include <stddef.h> // added for Rtools4.3 - might not be the best place PJS
#endif
// trying to get mac to compile...
#define _DARWIN_C_SOURCE
#include <stdio.h>
