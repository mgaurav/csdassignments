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
  if (flag) {
    Changes c = {state, state, *address};
    stateChanges.push_back(c);
  }
  return flag;
}

bool CacheController::serveProcessorWriteRequest (Address* address)
{
  char state = 'N';
  int data = 0;
  bool flag;
  flag = C->lookupAddress(*address, data, state);
  if (state == 'I') {
    coherenceMisses++;
  }
  if (flag) {
    Changes c = {state, 'M', *address};
    stateChanges.push_back(c);
    C->updateBlockState(*address, 'M', 0);
  }
  return flag;
}

bool CacheController::readRequestFromBus (Address* address, int& data, bool write)
{
  char state = 'N';
  bool flag;
  flag = C->lookupAddress(*address, data, state);
  if (!write && flag) {
    Changes c = {state, 'S', *address};
    stateChanges.push_back(c);
    C->updateBlockState(*address, 'S', 0);
  }
  return flag;
}

void CacheController::writeRequestFromBus (Address* address, bool sharedSignal, 
    int data, Block& evictedBlock, bool write)
{
  char state = 'N';

  C->lookupAddress(*address, data, state);
  C->updateCache(*address, evictedBlock);
  if (write) {
    Changes c = {state, 'M', *address};
    stateChanges.push_back(c);
    C->updateBlockState(*address, 'M', 0);
  } else {
    if (sharedSignal) {
      Changes c = {state, 'S', *address};
      stateChanges.push_back(c);
      C->updateBlockState(*address, 'S', 0);
    } else {
      Changes c = {state, 'E', *address};
      stateChanges.push_back(c);
      C->updateBlockState(*address, 'E', 0);
    }
  }
}

void CacheController::invalidateData (Address* address)
{
  char state = 'N';
  int data = 0;
  int flag = C->lookupAddress(*address, data, state);
  if (flag) {
    Changes c = {state, 'I', *address};
    stateChanges.push_back(c);
    C->updateBlockState(*address, 'I', 0);
  }
}

bool CacheController::isShared (Address* address)
{
  int flag, data = 0;
  char state = 'N';
  flag = C->lookupAddress(*address, data, state);
  if (flag && state == 'S')
    return true;
  else
    return false;
}

void CacheController::printStateChanges ()
{
  int len = stateChanges.size();
  for (int i = 0; i < len; i++) {
    cout << stateChanges[i].initial << " " << stateChanges[i].final << " " << stateChanges[i].address.getTag() << 
      " " << stateChanges[i].address.getSet() << " " << stateChanges[i].address.getByte() << "\n";
  }
}

int CacheController::getCoherenceMissCount()
{
  return coherenceMisses;
}
