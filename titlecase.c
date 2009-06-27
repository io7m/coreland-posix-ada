#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>

int
main (int argc, char *argv[])
{
  const int ch_space = (int) ' ';
  const int ch_score = (int) '_';
  int ch_prev        = 0;
  int ch_current     = 0;
  char *text;

  if (argc >= 2) {
    text  = argv[1];
    *text = toupper ((int) *text);

    for (;;) {
      if (*text == (char) 0) break;
      ch_current = (int) *text;

      if (ch_prev == ch_space || ch_prev == ch_score)
        if (islower (ch_current))
          ch_current = (int) toupper (ch_current);

      (void) printf ("%c", ch_current);
      ch_prev = ch_current;
      ++text;
    }
  }

  return EXIT_SUCCESS;
}
