/**
 * Author : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef BLOCK_H
#define BLOCK_H

/**
 * State is M, E, S, I, N
 */
class Block {
  int tag;
  int data;
  char state; 
 public:
  Block(int tag, int data, char state);
  void changeState(char newState, int data);
  bool getTag(int tag);
  int getState();

  //not being used
  int getData();
  void writeData(int data);
};

#endif
