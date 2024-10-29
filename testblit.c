#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int blit_plain(long * src, long * dst, long len, long * bound, long cur);
extern int blit_dmb(long * src, long * dst, long len, long * bound, long cur);
extern int blit_rel(long * src, long * dst, long len, long * bound, long cur);
extern int blit_dmb_2(long * src, long * dst, long len, long * bound, long cur);
extern int blit_dmb_4(long * src, long * dst, long len, long * bound, long cur);
extern int blit_dmb_5(long * src, long * dst, long len, long * bound, long cur);

#define LEN 100000
#define REPETITIONS 1000

int main(int argc, char ** argv)
{
  int (*fn)(long*, long*, long, long*, long);
  if (argc >= 2 && strcmp(argv[1], "plain") == 0)
    fn = blit_plain;
  else if (argc >= 2 && strcmp(argv[1], "dmb") == 0)
    fn = blit_dmb;
  else if (argc >= 2 && strcmp(argv[1], "dmb2") == 0)
    fn = blit_dmb_2;
  else if (argc >= 2 && strcmp(argv[1], "dmb4") == 0)
    fn = blit_dmb_4;
  else if (argc >= 2 && strcmp(argv[1], "dmb5") == 0)
    fn = blit_dmb_5;
  else if (argc >= 2 && strcmp(argv[1], "rel") == 0)
    fn = blit_rel;
  else {
    fprintf(stderr, "Unknown function.  Usage: testblit <function name>\n");
    return 2;
  }
  long bound = 0;
  long * src = calloc(LEN, sizeof(long));
  long * dst = calloc(LEN, sizeof(long));
  for (int i = 0; i < LEN; i++) src[i] = i;
  for (int i = 0; i < REPETITIONS; i++) {
    fn(src, dst, LEN, &bound, 1);
  }
  for (int i = 0; i < LEN; i++) {
    if (dst[i] != i) printf("BUG %d\n", i);
  }
  return 0;
}
