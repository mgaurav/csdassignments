#include "cachecontroller.h"

Cachecontroller::Cachecontroller (int associativity, blockSizeInBytes, 
				  int cacheSizeInBytes)
{
  C = new Cache(associativity, blockSizeInBytes, cacheSizeInBytes); 
}

bool CacheController::serveProcessorReadRequest (int address, 
						 Block& evictedBlock)
{
  
}

bool CacheController::serveProcessorWriteRequest (int address, 
						 Block& evictedBlock)
{
  
}

bool CacheController::readRequestFromBus (int address, int& data)
{
  
}

void writeRequestFromBus (int address, bool sharedSignal, int data)
{
  
}
