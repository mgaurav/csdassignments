/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef LRU_QUEUE_H
#define LRU_QUEUE_H

#include <list>
#include "block.h"

using namespace std;

class LRUQueue
{
  list<Block> lruQueue;
  unsigned int ways;

 public:
  LRUQueue (unsigned int ways);

  bool updateBlockStateinQueue (int tag, char newState, int data);
  bool updateLRUQueue (int tag, Block& evictedBlock);
  bool getBlock (int tag, Block& block);

  // only used for testing
  list<Block> getLruQueue ();
};

#endif
