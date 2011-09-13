/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef CACHECONTROLLER_H
#define CACHECONTROLLER_H

#include "bus.h"
#include "cache.h"

using namespace std;


class CacheController
{
 private:

  Cache C;
  Bus B;
  
 public:
  CacheController (Bus B, Cache C){
    this->C = C;
    this->B = B;
  }

  //functions used by the simulator in accessing the controller.
  int getDataForProcessor (int address) ;

  int writeDataForProcessor (int address, int data);

  int readDataFromBus ();

  int writeDataToBus (int address, int data, int read);

    
};

#endif
