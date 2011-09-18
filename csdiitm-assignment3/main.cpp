#include "simulator.h"
#include <stdio.h>

int main() {
  Simulator S(4,64,16384);
  string s = "trace.txt";
  S.simulate(s);
  return 1;
}
