#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>

double rtclock() {
  struct timeval Tp;
  int stat = gettimeofday(&Tp, NULL);
  if (stat != 0)
    printf("Error return from gettimeofday: %d", stat);
  return (Tp.tv_sec + Tp.tv_usec * 1.0e-6);
}

void print_time(double start_time, // in seconds
                 double end_time   // in seconds
) {
  double duration = end_time - start_time;

  fprintf(stderr, "%lf\n", duration);
}