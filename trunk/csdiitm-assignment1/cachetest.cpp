/**
 * Author : Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 */

#include "cache.h"
#include <assert.h>

using namespace std;

void isColdMissTest () {
  Cache cache(4, 32000, 65536000);
  assert(cache.getNumColdMiss() == 0);
  cache.updateCache(Address(1, 1, 0));
  assert(cache.getNumColdMiss() == 1);
  cache.updateCache(Address(1, 1, 0));
  assert(cache.getNumColdMiss() == 1);

  cache.updateCache(Address(1, 2, 0));
  assert(cache.getNumColdMiss() == 2);
  cache.updateCache(Address(2, 1, 0));
  assert(cache.getNumColdMiss() == 3);
  cache.updateCache(Address(1, 3, 0));
  assert(cache.getNumColdMiss() == 4);

  cache.updateCache(Address(2, 1, 0));
  assert(cache.getNumColdMiss() == 4);
  cache.updateCache(Address(1, 3, 0));
  assert(cache.getNumColdMiss() == 4);
}

void updateCacheTest() {
  Cache cache(4, 32000, 65536000);
  assert(cache.getNumHits() == 0);
  assert(cache.getNumMisses() == 0);

  // First data element is added, always a miss
  cache.updateCache(Address(0, 0, 0));
  assert(cache.getNumHits() == 0);
  assert(cache.getNumMisses() == 1);

  // Accessing same element that is prresent in cache, hit
  cache.updateCache(Address(0, 0, 0));
  assert(cache.getNumHits() == 1);
  assert(cache.getNumMisses() == 1);

  // Accessing a "nearby" element, hit
  cache.updateCache(Address(0, 0, 2));
  assert(cache.getNumHits() == 2);
  assert(cache.getNumMisses() == 1);

  // New element, miss
  cache.updateCache(Address(1, 0, 0));
  assert(cache.getNumHits() == 2);
  assert(cache.getNumMisses() == 2);
  
}

int main () {
  isColdMissTest();
  updateCacheTest();
  return 0;
}
