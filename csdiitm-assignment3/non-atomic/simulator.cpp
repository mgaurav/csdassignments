
#include "simulator.h"
#include "busRequest.h"

#include <queue>
#include <string.h>
#include <iostream>
#include <iomanip>

using namespace std;

Simulator::Simulator (int associativity, int blockSizeInBytes, int cacheSizeInBytes) {
  int  i = 0;
  while (i < 4) {
    (this->cacheControllerVector).push_back(new CacheController(i, associativity, blockSizeInBytes, cacheSizeInBytes));
    i++;
  }
  busController = new BusController();
}


/**
 * Converts a given address in Hexadecimal notation to (tag, set, byte) representation
 * ---------------------------
 * |Tag-20  | Set-6  | Byte-6|  <<-- Address
 * ---------------------------
 */
void Simulator::convertAddress (char * addressString, int& tag, int& set, int& block) {
  unsigned int  addressInt;
  
  //converting from the hex string to int first
  if (addressString != NULL)
    sscanf(addressString, "%x",  &addressInt);
  else
    printf("empty string is passed as input to convert address\n");

  //extracting tag, set, block
  tag = (addressInt & (1048575 << 12)) >> 12;
  set = (addressInt & (63 << 6)) >> 6;
  block = (addressInt & 63);
}


/**
 * Simulates the instructions given in file _filename
 */
void Simulator::simulate (string filename) {
  ifstream inputfile;
  int filePosition;

  string line;
  int t = 0;
  int i = 0;
  int tFlag = 0;

  int timeStamp;
  int cacheId;
  bool readWrite;
  char hexAddr[8];   // 32 bit address, 8 hex digits
  int tag;
  int set_1;
  int byte;

  // Bus State codes
  // 0 - free
  // 1 - bus to be assigned to some cache
  // 2 - fetch request from cache queue, query other caches for data
  //   - if invalidation request, invalidates all other cache
  // 3 - provide data to parent cache
  //   - no operation for invalidation request
  int busState;
  BusRequest* currentBusRequestBeingServed = NULL;
  int lastCacheServed, cacheToBeServed;
  bool sharedSignal;
  int busData;

  Block evictedBlock;
  bool noMoreRequests;

  inputfile.open(filename.c_str());
  if (!inputfile.is_open()) {
    cout << "File " << filename << " could not be opened. Aborting\n";
    return;
  }

  busState = 0; // initially bus if free
  lastCacheServed = -1; // initially no cache is served from bus side
  cacheToBeServed = -1;
  sharedSignal = false;
  busData = 0;
  noMoreRequests = true;

  while (inputfile.good() || !noMoreRequests) {      
    // serve request for current timestamp
    
    tFlag = 0;
    
    /*set tFlag when the requests start arriving with higher time stamp than t
     */
    // peek the next processor request and check if timestamp is more than current timestamp
    // update timestamp by 1 unit in every loop, instead of jumping to next timestamp
    if (inputfile.good()) {
      // read available requests
      while (tFlag == 0){
	/* reading a line from the file and fragmenting it into relevant field 
	   based upon the delimiter blank space..the requests are to be pushed 
	   on a queue
	*/
	filePosition = inputfile.tellg();
	if (filePosition == -1) {
	  break;
	}
	inputfile >> timeStamp;
	if (inputfile.eof()) {
	  break;
	}
	if (timeStamp > t) {
	  tFlag = 1;
	  inputfile.seekg(filePosition, ios::beg);
	  break;
	} else {
	  inputfile >> cacheId;
	  inputfile >> readWrite;
	  inputfile >> hexAddr;

	  convertAddress(hexAddr, tag, set_1, byte);
	
	  // Processor side interface called
	  if (readWrite == 0) {
	    this->cacheControllerVector[cacheId]->serveProcessorReadRequest(new Address(set_1, tag, byte));
	  } else {
	    this->cacheControllerVector[cacheId]->serveProcessorWriteRequest(new Address(set_1, tag, byte));
	  }
	}
      } // all request from the processor for current timestamp are served
    }

    // Bus side interface
    if (busState == 0) {
      // bus is free
      // check if there is any pending request from any cache in round robin fashion
      int cache = lastCacheServed + 1;
      if (cache == 4) {
	cache = 0;
      }
      int count = 0;
      while (count < 4) {
	if ((this->cacheControllerVector[cache])->needsBus()) {
	  break;
	}
	cache++;
	if (cache == 4) {
	  cache = 0;
	}
	count++;
      }
      if (count < 4) {
	// some cache needs bus
	cacheToBeServed = cache;
	busState += 1;
	noMoreRequests = false;
      } else {
	// no cache needs bus, bus remains free
	busState = 0;
	noMoreRequests = true;
      }
    } else if (busState == 1){
      // allot bus to _cacheToBeServed to service its request
      busState += 1;
    } else if (busState == 2) {
      // fetch request from _cacheToBeServed, queries other caches for data
      currentBusRequestBeingServed = (this->cacheControllerVector[cacheToBeServed])->requestToBeServed();
      if (currentBusRequestBeingServed->invalidationRequest) {
	// invalidation Request, invalidate all other caches
	for (i = 0; i < 4; i++) {
	  if (i != currentBusRequestBeingServed->cacheControllerId) {
	    // invalidate the cache
	    (this->cacheControllerVector[i])->invalidateData(currentBusRequestBeingServed->address);
	  }
	}
	
	(this->cacheControllerVector[currentBusRequestBeingServed->cacheControllerId])->
	  writeRequestFromBus(currentBusRequestBeingServed->address, 0, 0, evictedBlock, true);

	lastCacheServed = currentBusRequestBeingServed->cacheControllerId;
	busState = 0; // whole request is served
      } else {
	// other than invalidation request
	sharedSignal = false;
	for (i = 0; i < 4; i++) {
	  if (i != currentBusRequestBeingServed->cacheControllerId) {
	    if ((this->cacheControllerVector[i])->
		// this method also invalidates the data present in other caches if write = true
		readRequestFromBus(currentBusRequestBeingServed->address, busData,
				   currentBusRequestBeingServed->write)) {
	      // present in some other cache
	      sharedSignal = true;
	    }
	  }
	}
	busState += 1; // one more state is remaining
      }
  
    } else {
      // state = 3
      // serve data to cache whose request is served
      // request is popped inside writeRequestFromBus method only
      (this->cacheControllerVector[currentBusRequestBeingServed->cacheControllerId])->
	writeRequestFromBus(currentBusRequestBeingServed->address, sharedSignal, busData,
			    evictedBlock, currentBusRequestBeingServed->write);

      lastCacheServed = currentBusRequestBeingServed->cacheControllerId;
      busState = 0;
    }

    t++;  // increase the simulator's timestamp
  }
  inputfile.close();

  cout << "Final timestamp: " << t << '\n';
  // Output the cache coherence statistics
  for (i = 0; i < 4; i++){   
    cout << i << ' ' << this->cacheControllerVector[i]->getCoherenceMissCount() << '\n';
    this->cacheControllerVector[i]->printStateChanges();
    cout << "\n\n";
  }
}
 

/**
 * Service a Bus Request generated by some cache controller
 * to complete Processor Read/Write Request.
 */
// void Simulator::serviceRequest(BusRequest* r){
//   int cacheId = r->cacheControllerId;
//   Block block;
//   int data;
//   int  i = 0;
//   int cacheFlag = 0;

//   // branching on the basis of whether it is a write request or a read request
//   if (r->rW == 0){
//     // service read request
//     // service the miss...first check in all other caches in priority based on id 
//     for (i=0; i < 4; i++) {
//       // State transition to S in all other caches in which data is present
//       if (i != cacheId) {
// 	if ((this->cacheControllerVector[i])->readRequestFromBus(r->address, data, false)){
// 	  cacheFlag = 1;
// 	}
//       }
//     }

//     if (cacheFlag == 1) {
//       (this->cacheControllerVector[cacheId])->writeRequestFromBus(r->address, true, data, block, false);
//     } else if (cacheFlag == 0){
//       // miss in all the caches...service from memory
//       (this->cacheControllerVector[cacheId])->writeRequestFromBus(r->address, false, data, block, false);
//     }
//   } else {
//     // service write request
//     // check in other caches if data is present
//     for (i=0; i < 4; i++) {
//       if (i != cacheId) {
// 	if ((this->cacheControllerVector[i])->readRequestFromBus(r->address, data, true)){
// 	  cacheFlag = 1;
// 	  (this->cacheControllerVector[cacheId])->writeRequestFromBus(r->address, true, data, block, true);
// 	  break;
// 	}
//       }
//     }

//     if (cacheFlag == 1){
//       // invalidate other caches data
//       for (i=0; i < 4; i++) {
// 	if (i != cacheId)
// 	  (this->cacheControllerVector[i])->invalidateData(r->address);
//       }
//     } else{
//       // miss in all other caches also
//       // get data from memory and write in _cacheId
//       (this->cacheControllerVector[cacheId])->writeRequestFromBus(r->address, 0, data, block, true);
//     }
//   }
// }
