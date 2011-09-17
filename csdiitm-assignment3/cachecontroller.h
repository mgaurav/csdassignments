/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef CACHECONTROLLER_H
#define CACHECONTROLLER_H

#include "cache.h"
#include "block.h"

using namespace std;


class CacheController
{
 private:

  Cache C;
  
 public:
  CacheController (int associativity, int blockSizeInBytes, int cacheSizeInBytes);

  //functions used by the simulator in accessing the controller.
  bool serveProcessorReadRequest (int address, Block& evictedBlock);
  bool serveProcessorWriteRequest (int address, Block& evictedBlock);
  bool readRequestFromBus (int address, int& data);
  void writeRequestFromBus (int address, bool sharedSignal, int data);
};

#endif
