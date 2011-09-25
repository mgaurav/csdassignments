// Compile : g++ lruqueuetest.cpp ../lruqueue.cpp ../block.cpp

/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 */

#include "../lruqueue.h"

#include <assert.h>
#include <vector>
#include <iostream>
#include <iomanip>

using namespace std;

#define ASSOC 4

void testUpdateBlockStateinQueue () {
  LRUQueue q(ASSOC);
  Block block(0, 'N', 0);
  q.updateLRUQueue(1, block);
  q.updateLRUQueue(2, block);
  q.updateLRUQueue(3, block);
  q.updateLRUQueue(4, block);

  Block blocks[4];
  int i;
  for (i = 1; i <= 4; i++) {
    q.getBlock(i, blocks[i-1]);
  }

  list<Block>::iterator iterator;
  list<Block> lruQueue;

  // update a block not present in the queue
  assert(q.updateBlockStateinQueue(6, 'E', 10) == false);
  lruQueue = q.getLruQueue();
  i = 0;
  for (iterator = lruQueue.begin(); iterator != lruQueue.end();
       iterator++, i++) {
    assert(iterator->getTag() == blocks[i].getTag());
    assert(iterator->getData() == blocks[i].getData());
    assert(iterator->getState() == blocks[i].getState());
  }

  // update a block present in the queue
  assert(q.updateBlockStateinQueue(2, 'M', 5) == true);
  lruQueue = q.getLruQueue();
  i = 0;
  for (iterator = lruQueue.begin(); iterator != lruQueue.end();
       iterator++, i++) {
    if (iterator->getTag() == 2) {
      // checks for modified blocks
      assert(iterator->getData() == 5);
      assert(iterator->getState() == 'M');
    } else {
      // checks for all other blocks
      assert(iterator->getTag() == blocks[i].getTag());
      assert(iterator->getData() == blocks[i].getData());
      assert(iterator->getState() == blocks[i].getState());
    }
  }
}

void testUpdateLRUQueue () {
  LRUQueue q(ASSOC);
  Block block(-1, 'E', -1);
  assert(q.updateLRUQueue(1, block) == false);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  assert(q.updateLRUQueue(2, block) == false);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  assert(q.updateLRUQueue(3, block) == false);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  assert(q.updateLRUQueue(4, block) == false);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  // hit, so no evicted block
  assert(q.updateLRUQueue(2, block) == true);
  assert(block.getTag() == -1);
  assert(block.getState() == 'E');
  assert(block.getData() == -1);

  // miss with evicted block - (1, 'N', 0)
  assert(q.updateLRUQueue(5, block) == false);
  assert(block.getTag() == 1);
  assert(block.getState() == 'N');
  assert(block.getData() == 0);

  // miss with evicted block - (3, 'N', 0)
  assert(q.updateLRUQueue(6, block) == false);
  assert(block.getTag() == 3);
  assert(block.getState() == 'N');
  assert(block.getData() == 0);

  // hit for newly inserted blocks
  assert(q.updateLRUQueue(5, block) == true);
}

void testGetBlock () {
  LRUQueue q(ASSOC);
  Block block(-1, 'E', -1);
  q.updateLRUQueue(1, block);
  q.updateLRUQueue(2, block);
  q.updateLRUQueue(3, block);
  q.updateLRUQueue(4, block);

  // block present in queue
  assert(q.getBlock(3, block) == true);
  assert(block.getTag() == 3);
  assert(block.getState() == 'N');
  assert(block.getData() == 0);

  // block not present in queue
  assert(q.getBlock(5, block) == false);
}

int main()
{
  testUpdateBlockStateinQueue();
  testUpdateLRUQueue();
  testGetBlock();
  return 0;
}
