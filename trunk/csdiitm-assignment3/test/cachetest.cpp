// Compile : g++ cachetest.cpp ../cache.cpp ../lruqueue.cpp ../block.cpp ../address.cpp

#include "../cache.h"

#include <assert.h>
#include <iomanip>
#include <iostream>

using namespace std;

void isColdMissTest () {
  Cache cache(4, 32000, 65536000);
  Block block(0, 'N', 0);
  assert(cache.getNumColdMiss() == 0);
  cache.updateCache(Address(1, 1, 0), block);
  assert(cache.getNumColdMiss() == 1);
  cache.updateCache(Address(1, 1, 0), block);
  assert(cache.getNumColdMiss() == 1);

  cache.updateCache(Address(1, 2, 0), block);
  assert(cache.getNumColdMiss() == 2);
  cache.updateCache(Address(2, 1, 1), block);
  assert(cache.getNumColdMiss() == 3);
  cache.updateCache(Address(1, 3, 0), block);
  assert(cache.getNumColdMiss() == 4);

  cache.updateCache(Address(2, 1, 0), block);
  assert(cache.getNumColdMiss() == 4);
  cache.updateCache(Address(1, 3, 1), block);
  assert(cache.getNumColdMiss() == 4);
}


void testUpdateCache() {
  Cache cache(4, 32000, 65536000);
  Block block(-1, 'E', -1);
  assert(cache.getNumHits() == 0);
  assert(cache.getNumMisses() == 0);

  // First data element is added, always a miss, no eviction
  assert(cache.updateCache(Address(0, 0, 0), block) == false);
  assert(cache.getNumHits() == 0);
  assert(cache.getNumMisses() == 1);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  // Accessing same element that is present in cache, hit
  cache.updateCache(Address(0, 0, 0), block);
  assert(cache.getNumHits() == 1);
  assert(cache.getNumMisses() == 1);

  // Accessing a "nearby" element, hit
  cache.updateCache(Address(0, 0, 2), block);
  assert(cache.getNumHits() == 2);
  assert(cache.getNumMisses() == 1);

  // New element, miss
  cache.updateCache(Address(1, 0, 0), block);
  assert(cache.getNumHits() == 2);
  assert(cache.getNumMisses() == 2);

  // misses with no eviction
  cache.updateCache(Address(1, 1, 0), block);
  cache.updateCache(Address(1, 2, 0), block);
  cache.updateCache(Address(1, 3, 0), block);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  // miss with eviction
  cache.updateCache(Address(1, 4, 0), block);
  assert(block.getTag() == 0);
  assert(block.getState() == 'N');
  assert(block.getData() == 0); 
}

void testUpdateBlockState () {
  Cache cache(4, 32000, 65536000);
  Block block(-1, 'E', -1);

  cache.updateCache(Address(1, 1, 0), block);
  cache.updateCache(Address(2, 1, 0), block);
  cache.updateCache(Address(1, 2, 0), block);

  int data = -1;
  // block is present in the cache
  cache.updateBlockState(Address(1, 1, 0), 'M', 5);
  assert(cache.lookupAddress(Address(1, 1, 0), data) == true);
  assert(data == 5);

  // block is not present in the cache
  cache.updateBlockState(Address(1, 3, 0), 'M', 10);
  assert(cache.lookupAddress(Address(1, 3, 0), data) == false);
}

void testLookupAddress () {
  Cache cache(4, 32000, 65536000);
  Block block(-1, 'E', -1);

  cache.updateCache(Address(1, 1, 0), block);
  cache.updateCache(Address(2, 1, 0), block);
  cache.updateCache(Address(1, 2, 0), block);

  int data = -1;
  // present address
  assert(cache.lookupAddress(Address(2, 1, 0), data) == true);
  assert(data == 0);

  data = -1;
  assert(cache.lookupAddress(Address(1, 3, 0), data) == false);
  assert(data == -1);

  assert(cache.lookupAddress(Address(5, 1, 0), data) == false);
  assert(data == -1);
}

int main () {
  isColdMissTest();
  testUpdateCache();
  testUpdateBlockState();
  testLookupAddress();
  return 0;
}
