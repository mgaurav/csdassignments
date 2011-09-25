#include "block.h"

Block::Block (int tag, char state, int data) {
  this->tag = tag;
  this->state = state;
  this->data = data;
}

void Block::changeState (char newState, int data) {
  this->state = newState;
  this->data = data;
}

int Block::getTag () {
  return this->tag;
}

char Block::getState() {
  return this->state;
}

int Block::getData () {
  return this->data;
}

void Block::writeData (int data) {
  this->data = data;
}
