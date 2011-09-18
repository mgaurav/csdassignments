/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 */

#include "lruqueue.h"
#include "stdio.h"
#include "block.h"
LRUQueue::LRUQueue (unsigned int ways) {
  this->ways = ways;
}

/**
 * Updates queue of blocks appropriately according to
 * LRU Replacement policy.
 *
 * Return true if a Hit occurs, otherwise returns false.
 * Also populates _evictedBlock with the block being evicted.
 */
bool LRUQueue::updateLRUQueue (int tag, Block& evictedBlock) {
  // if queue is empty, create a new block with specified tag,
  // and insert it in queue.
  if (lruQueue.size() == 0) {
    lruQueue.push_back(Block(tag, 'N', 0));
    return false;
  }

  list<Block>::iterator iterator;
  for (iterator = lruQueue.begin(); iterator != lruQueue.end();
       iterator++) {
    if (iterator->getTag() == tag) {
      lruQueue.push_back(Block(tag, iterator->getState(),
				   iterator->getData()));
      lruQueue.erase(iterator);
      return true;
    }
  }

  // Full queue, a block needs to be evicted
  if (lruQueue.size() == ways) {
    evictedBlock = lruQueue.front();
    lruQueue.pop_front();
  }
  lruQueue.push_back(Block(tag, 'N', 0));
  return false;
}

/**
 * Updates block state if the block corresponding to _tag is
 * present in the Queue.
 *
 * Returns true if block was present in the queue, else returns false.
 */
bool LRUQueue::updateBlockStateinQueue (int tag, char newState, int data) {
  list<Block>::iterator iterator;
  for (iterator = lruQueue.begin(); iterator != lruQueue.end();
       iterator++) {
    if (iterator->getTag() == tag) {
      iterator->changeState(newState, data);
      return true;
    }
  }
  return false;
}


/**
 * Returns true if _tag is present, otherwise false.
 * Updates _block with the block corresponding to _tag if present
 */
bool LRUQueue::getBlock (int tag, Block& block) {
  list<Block>::iterator iterator;
  for (iterator = lruQueue.begin(); iterator != lruQueue.end();
       iterator++) {
    if (iterator->getTag() == tag) {
      block = *iterator;
      return true;
    }
  }
  return false;
}

list<Block> LRUQueue::getLruQueue () {
  return this->lruQueue;
}
