/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef LRU_QUEUE_H
#define LRU_QUEUE_H

#include <list>
#include "block.h"
#include "address.h"

using namespace std;

class LRUQueue
{
  list<Block> lruQueue;
  int ways;
 public:
  LRUQueue (int ways);
  bool updateLRUQueue (Address address, Block& evictedBlock);
};

#endif
