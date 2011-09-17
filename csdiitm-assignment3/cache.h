/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef CACHE_H
#define CACHE_H

#include "address.h"
#include "lruqueue.h"
#include "block.h"

#include <set>
#include <vector>

using namespace std;

class Cache
{
  int cacheSizeInBytes;
  int associativity;
  int blockSizeInBytes;
  int numRowsInCache;
  
  vector<LRUQueue> cache;
  set<pair<int, int> > addressLog;

  int numColdMiss;
  int numMisses;
  int numHits;

 public:
  Cache (int associativity, int blockSizeInBytes, int cacheSizeInBytes);
  bool updateCache (Address address, Block& evictedBlock);
  void updateBlockState (Address address, char newState, int data);
  
  // returns the data present in the cache, used from bus side
  bool lookupAddress (Address address, int &data);

  int getAssociativity () {
    return associativity;
  }

  int getBlockSize () {
    return blockSizeInBytes;
  }

  int getCacheSize () {
    return cacheSizeInBytes;
  }

  int getNumColdMiss () {
    return numColdMiss;
  }
  int getNumMisses () {
    return numMisses;
  }
  int getNumHits () {
    return numHits;
  }
};

#endif
