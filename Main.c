// Sean Javiya     ||     Section: 240-07     ||     seanjaviya@csu.fullerton.edu
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern double Control();

int main(int argc, char* argv[]) {
  double resultFromControl = -1.0;
  printf("This is the 240-07 Spring Programming Final by Sean Javiya. \n");
  printf("Version: 1.0\nReleased: May 20, 2021\n");

  resultFromControl = Control();
  printf("The Main driver received %6.8lf and will keep it.", resultFromControl);
  printf("\nThank you for an amazing semester.\nFor support contact: Sean Javiya\n");
  printf("                     seanjaviya@csu.fullerton.edu");
  printf("\nA zero will be returned to the operating system.\n");
  return 0;
}
