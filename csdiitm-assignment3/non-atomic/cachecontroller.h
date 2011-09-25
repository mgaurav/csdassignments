/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef CACHECONTROLLER_H
#define CACHECONTROLLER_H

#include "cache.h"
#include "block.h"
#include "busRequest.h"
#include <queue>

using namespace std;

struct Changes {
  char initial;
  char final;
  Address address;
};

class CacheController
{
 private:
  int cacheId;
  Cache* C;
  queue<BusRequest*> requestQueue;
  int coherenceMisses;
  vector<Changes> stateChanges;

 public:
  CacheController (int cacheId, int associativity, int blockSizeInBytes, int cacheSizeInBytes);

  // Processor side interface
  bool serveProcessorReadRequest (Address* address);
  bool serveProcessorWriteRequest (Address* address);

  // Bus side interface
  bool readRequestFromBus (Address* address, int& data, bool write);
  void writeRequestFromBus (Address* address, bool sharedSignal, int data, Block& evictedBlock, bool write);
  void invalidateData (Address* address);

  bool isShared (Address* address); 

  bool needsBus ();
  BusRequest* requestToBeServed ();

  // Statistics
  int getCoherenceMissCount();  
  void printStateChanges();
};

#endif
