/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 */

#include "address.h"

Address::Address (int set, int tag, int byte) {
  this->set = set;
  this->tag = tag;
  this->byte = byte;
}

int Address::getSet () {
  return this->set;
}

int Address::getTag () {
  return this->tag;
}

int Address::getByte () {
  return this->byte;
}
