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
 * rW - 0 for a read request, 1 for a write request
 */
class BusRequest {
 public:
  int timeStamp;
  int cacheControllerId;
  bool rW;
  Address * address;  
  BusRequest(int  t,int c, bool r, int set, int tag, int byte){
     this->timeStamp =t;
     this->cacheControllerId = c;
     this->rW = r;
     address =  new Address(set, tag, byte);
 }	

};

#endif
