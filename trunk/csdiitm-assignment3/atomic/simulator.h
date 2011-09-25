/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef SIMULATOR_H
#define SIMULATOR_H
#define NUMOFCACHES 4

#include "cachecontroller.h"
#include "busController.h"
#include <vector>
#include <fstream>
#include "address.h"

//more or less all the complicationas have been pushed inside the simulator
// class to take care of the dependencies


using namespace std;

class Simulator
{
 private:
  
  vector<CacheController *> cacheControllerVector;
  BusController* busController;

  //think about logic of params
  void serviceRequest (BusRequest * r);
  void convertAddress (char* addressStr, int& tag, int& set, int& block);

 public:
  Simulator (int associativity, int blockSizeInBytes, int cacheSizeInBytes);
  void simulate (string filename);
};

#endif
