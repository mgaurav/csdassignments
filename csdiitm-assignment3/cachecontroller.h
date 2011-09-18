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

  Cache* C;
  int coherenceMisses;
  vector< pair<char, char> > stateChanges;

 public:
  CacheController (int associativity, int blockSizeInBytes, int cacheSizeInBytes);

  //functions used by the simulator in accessing the controller.
  bool serveProcessorReadRequest (Address* address);
  bool serveProcessorWriteRequest (Address* address);
  bool readRequestFromBus (Address* address, int& data);
  void writeRequestFromBus (Address* address, bool sharedSignal, int data, Block& evictedBlock);
  void invalidateData (Address* address);
  bool isShared (Address* address); 
  int getCoherenceMissCount();
  void printStateChanges();
};

#endif
