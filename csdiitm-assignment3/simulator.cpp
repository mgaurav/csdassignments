#include "Simulator.h"
#include <queue>
#include "busRequest.h"
Simulator::Simulator(int associativity, int blockSizeInBytes, int cacheSizeInBytes) {
  int  i = 0;
  while (i < 4) {
    (this->cacheControllerVector).pushback(new cacheController(associativity, blockSizeInBytes, cacheSizeInBytes));
    i++;
  }
  busController = new BusController();
}


void Simulator:: convertAddress(char * addressString, int& tag, int& set, int& block) {
  unsigned int  addressInt;
  
  //converting from the hex string to int first
  sscanf(addressString, "%x",  addressInt);
  
  //extracting tag, set, block
  tag = (addressInt&(1048575<<12))>>12;
  set = (addressInt&(63<<6))>>6;
  block = (addressInt&63);
}

void Simulator:: simulate(string filename) {
  
  string line;
  queue<BusRequest *> reqQueue;
  char * str;
  ifstream inputfile;
  int t= 0;
  int i = 0;
  int tFlag = 0;
  int timeStamp;
  int tag;
  int set_1;
  int byte;
  int cacheId;
  bool readWrite;
  string hexAddr;
  BusRequest b;

  inputfile.open(filename.c_str());
  if (inputfile.is_open()) {
    while (inputfile.good()) {
      
      tFlag = 0;

      /*set tFlag when the requests start arriving with higher time stamp than t
       */
      while (tFlag == 0){
	
        /*reading a line from the file and fragmenting it into relevant field 
	  based upon the delimiter blank space..the requests are to be pushed 
	  on a queue
	*/
	i = 1;
	getline(inputfile, line);
	// cout << line << endl;
	if (line.size() > 1) {
	  char delims[] = " ";
	  char *p;
	  p = new char [line.size()+1];
	  strcpy (p, line.c_str());
	  char *field = NULL;
	  field = strtok(p, delims );
	  sscanf(p, "%d", &timeStamp);
	  if (timeStamp>t)
	    tFlag = 0;
	  while( field != NULL ) {
	    //printf( "result is \"%s\"\n", result );
	    field = strtok( NULL, delims );
	    if (i == 1){
	      sscanf(field, "%d",&readWrite);
	    }
	    else if(i == 2)  {
	      sscanf(field, "%d", &cacheId);
	    }
	    else {
	      sscanf(field, "%s", &hexAddr);
	      this->convertAddress(hexAddr, tag, set_1, byte);
	    }
	    i = i + 1;
	  }
	  /* push the new request on the request queue*/
	  reqQueue.push(new BusRequest(timeStamp, cacheId, readWrite, set_1, tag, byte));
	}
      }
      t = timeStamp;
      
      /*servicing the top most request on the request queue*/
      if (reqQueue.size() > 0){
	this->serviceRequest(request);
	reqQueue.pop();
      }
            
    }
  }

    while (reqQueue.size() > 0){
      this->serviceRequest(reqQueue.front());
      reqQueue.pop();
    }
  
}
 

void Simulator::serviceRequest(BusRequest * r){
  
  int cacheId = r->cacheControllerId;
  bool status;
  Block block;
  int data;
  int  i = 0;
  int cacheFlag;
  int sharedStatus;

  //branching on the basis of whether it is a write request or a read request
  if (r->rW == 0){
    //service read request
    status = this->cacheControllerVector[cacheId].serveProcessorReadRequest(r->address);
    //there has been a miss...push the rquest to the bus controller list
    if (status != 1)
      //service the miss...first check in all other caches in priority based on id 
      for (i=0;i<4;i++) {
	if (i != cacheId)
	  if (this->cacheControllerVector[i].readRequestFromBus(r->address, data)){
	    cacheFlag = 1;
	    this->cacheControllerVector[cacheId].writeRequestFromBus(r->address, 1, data);
	  }
	if (cacheFlag == 1)
	  break;
      }
    //miss in all the caches...service from memory
    if (cacheFlag == 0){
      this->cacheControllerVector[cacheId].writeRequestFromBus(r->address, 0, data);
    }
  }

  else {
    //service write request
    sharedStatus = this->cacheControllerVector[cacheId].isShared(r->address);
    status = this->cacheControllerVector[cacheId].serveProcessorWriteRequest(r->address, block);
    if (status == 1 && sharedStatus == 1){
      //the blok was there in the cache and the contents havve been modified..now invalidate if shared
      for (i=0;i<4;i++) {
	if (i != cacheId)
	  this->cacheControllerVector[i].invalidate(r->address);
      }
    }
    else if (status == 0){
      //check in other caches
     for (i=0;i<4;i++) {
	if (i != cacheId)
	  if (this->cacheControllerVector[i].readRequestFromBus(r->address, data)){
	    cacheFlag = 1;
	    this->cacheControllerVector[cacheId].writeRequestFromBus(r->address, 1, data);
	  }
	if (cacheFlag == 1)
	  break;
      }
     if (cacheFlag == 1){
       this->cacheControllerVector[cacheId].serveProcessorWriteRequest(r->address, block);
       for (i=0;i<4;i++) {
	 if (i != cacheId)
	   this->cacheControllerVector[i].invalidate(r->address);
       }
     }
     
     else{
        this->cacheControllerVector[cacheId].writeRequestFromBus(r->address, 0, data);
	this->cacheControllerVector[cacheId].serveProcessorWriteRequest(r->address, block);
     }
    }
}
