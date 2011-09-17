/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef BUS_CONTROLLER_H
#define BUS_CONTROLLER_H

#include "cache.h"
#include "block.h"
#include <queue>

using namespace std;


class BusController
{
  queue<BusRequest> requestQueue;
 public:
  BusController();
  void insertBusRequest(BusRequest request);
  BusRequest selectRequest();
};

#endif
