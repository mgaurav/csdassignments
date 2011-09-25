/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */
#include "address.h"
#ifndef BUS_REQUEST_H
#define BUS_REQUEST_H

/**
 * timeStamp at which request was generated
 * cacheControllerId - Id (0/1/2/3) of the cache controller
 *                     that generated this request
 * write - false for a read request, true for a write request
 */
class BusRequest {
 public:
  //  int timeStamp;
  int cacheControllerId;
  bool write;
  Address * address;  
  bool invalidationRequest;

  BusRequest(int c, bool write, Address* address, bool invalidationRequest){
    //     this->timeStamp =t;
     this->cacheControllerId = c;
     this->write = write;
     this->address = address;
     this->invalidationRequest = invalidationRequest;
 }	

};

#endif
