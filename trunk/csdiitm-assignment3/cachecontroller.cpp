#include "cachecontroller.h"
#include <iostream>

CacheController::CacheController (int associativity, int blockSizeInBytes, 
				  int cacheSizeInBytes)
{
  C = new Cache(associativity, blockSizeInBytes, cacheSizeInBytes); 
}

bool CacheController::serveProcessorReadRequest (Address* address)
{
  char state = 'N';
  int data = 0;
  bool flag;
  flag = C->lookupAddress(*address, data, state);
  if (state == 'I') {
    coherenceMisses++;
  }
  return flag;
}

bool CacheController::serveProcessorWriteRequest (Address* address)
{
  char state = 'N';
  int data = 0;
  bool flag;
  flag = C->lookupAddress(*address, data, state);
  if (flag) {
    C->updateBlockState(*address, 'M', 0);
    stateChanges.push_back(make_pair(state, 'M'));
  }
  return flag;
}

bool CacheController::readRequestFromBus (Address* address, int& data)
{
  char state = 'N';
  bool flag;
  flag = C->lookupAddress(*address, data, state);
  return flag;
}

void CacheController::writeRequestFromBus (Address* address, bool sharedSignal, 
					   int data, Block& evictedBlock)
{
  char state = 'N';
  bool flag;
  flag = C->lookupAddress(*address, data, state);
  C->updateCache(*address, evictedBlock);
  if (sharedSignal) {
    C->updateBlockState(*address, 'S', data);
    stateChanges.push_back(make_pair(state, 'S'));
  } else {
    C->updateBlockState(*address, 'E', data);
    stateChanges.push_back(make_pair(state, 'E'));
  }
}

void CacheController::invalidateData (Address* address)
{
  char state = 'N';
  int data = 0;
  int flag = C->lookupAddress(*address, data, state);
  stateChanges.push_back(make_pair(state, 'I'));
  C->updateBlockState(*address, 'I', 0);
}

bool CacheController::isShared (Address* address)
{
  int flag, data = 0;
  char state = 'N';
  flag = C->lookupAddress(*address, data, state);
  return state;
}

void CacheController::printStateChanges ()
{
  int len = stateChanges.size();
  for (int i = 0; i < len; i++) {
    cout << stateChanges[i].first << " " << stateChanges[i].second << "\n";
  } 
}

int CacheController::getCoherenceMissCount()
{
  return coherenceMisses;
}
