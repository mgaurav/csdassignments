#include "simulator.h"
#include <stdio.h>
#include <string>

int main() {
  Simulator S(4, 64, 16384);
  string s = "new_trace1.txt";
  S.simulate(s);
  return 1;
}
