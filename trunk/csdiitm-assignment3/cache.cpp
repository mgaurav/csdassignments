/**
 * Author : Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 */

#include "cache.h"
#include "address.h"

Cache::Cache (int associativity, int blockSizeInBytes, int cacheSizeInBytes) {
  this->associativity = associativity;
  this->blockSizeInBytes = blockSizeInBytes;
  this->cacheSizeInBytes = cacheSizeInBytes;

  numRowsInCache = cacheSizeInBytes / (associativity * blockSizeInBytes);
  cache.reserve(sizeof(LRUQueue) * numRowsInCache);
  for (int i = 0; i < numRowsInCache; i++) {
    cache.push_back(LRUQueue(associativity));
  }

  numColdMiss = 0;
  numMisses = 0;
  numHits = 0;
}


/**
 * Updates cache appropriately when an access to 'address' occurs.
 *
 * Updates Hit count, Miss count, Cold Miss count appropriately.
 *
 * Returns true if Hit in cache happens,
 *         false if Miss in cache happens.
 * Updates _evictedBlock if any block is evicted from the cache.
 */
bool Cache::updateCache (Address address, Block& evictedBlock) {
  if (addressLog.find(make_pair(address.getSet(), address.getTag()))
      == addressLog.end()) {
    addressLog.insert(make_pair(address.getSet(), address.getTag()));
    numColdMiss++;
  }

  bool status = cache[address.getSet()].updateLRUQueue(address.getTag(),
						       evictedBlock);
  if (status)
    numHits++;
  else
    numMisses++;

  return status;
}


/**
 * Modifies state and data of the block specified by the address. 
 */
void Cache::updateBlockState(Address address, char newState, int data) {
  cache[address.getSet()].updateBlockStateinQueue(address.getTag(),
						  newState, data);
}

/**
 * Return true if _address is present in the cache, otherwise returns
 * false.
 * Updates _data with the data present in the cache block.
 */
bool Cache::lookupAddress (Address address, int& data, char& state) {
  Block block(0, 'N', 0);
  bool status = cache[address.getSet()].getBlock(address.getTag(), block);
  if (status) {
    data = block.getData();
    state = block.getState();
    return true;
  } else {
    return false;
  }
}
