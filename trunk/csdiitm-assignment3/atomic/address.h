/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef ADDRESS_H
#define ADDRESS_H

#include <iostream>

using namespace std;

/**
 * An address looks like 
 * ------------------------
 * |Tag  | Set  | Byte|
 * ------------------------
 *
 * Set  -> row in the cache.
 * Tag  -> identifier of main memory block present in cache block.
 * Byte -> byte no. in the cache block.
 */
class Address
{
  int set;
  int tag;
  int byte;

 public:
  Address (int set, int tag, int byte);

  int getSet ();
  int getTag ();
  int getByte ();

  void print ();
};

#endif
