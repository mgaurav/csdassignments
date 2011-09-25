// g++ main.cpp simulator.cpp cachecontroller.cpp cache.cpp lruqueue.cpp address.cpp block.cpp

#include "simulator.h"
#include <stdio.h>
#include <string>

int main() {
  Simulator S(4, 64, 16384);
  string s = "new_trace1.txt";
  S.simulate(s);
  return 1;
}
