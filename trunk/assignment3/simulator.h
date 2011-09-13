/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef SIMULATOR_H
#define SIMULATOR_H
#define NUMOFCACHES 4

#include "cachecontroller.h"
#include "bus.h"

//more or less all the complicationas have been pushed inside the simulator
// class to take care of the dependencies


using namespace std;

class Simulator
{
 private:
  
  CacheController caches [NUMOFCACHES];
  Bus B;

 public:
  Simulator(Bus B);

  int readData(int index, int address);

  int writeData(int index, int address, int data);
  
};

#endif
