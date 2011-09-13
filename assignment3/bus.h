/**
 * Authors : Bharat Singh, CS08B025 (bharatsingh430@gmail.com)
 *          Gaurav Maheshwari, CS08B005 (gaurav.m.iitm@gmail.com)
 *          Mrinal Kumar, CS08B011 (mrinalkumar08@gmail.com)
 */

#ifndef BUS_H
#define BUS_H

//right now, not being used as integers are used for the address and data lines
#define ADDRESS_BUS_WIDTH 32
#define DATA_BUS_WIDTH 64


using namespace std;

/*Basic assumptions regarding bus widths which need to be settled, 
  also whether they should be integers or arrays needs to be settled..local changes nevertheless*/
/*Data line may not be needed for the sake of  simulation*/

class Bus
{
 private:

  int addressLine;
  int dataLine;
  bool sharedSignal;
  bool readWrite;
  int invalid;

 public:
  Bus (){
    this->invalid = 1; 
  }

  void write (int address, int data, bool read) {
    this->addressLine = address;
    this->dataLine = data;
    this->readWrite = read;
  } 

  void setInvalid () {
    this->invalid = 1;
  }

  int readAddress () {
    return this->addressLine;
  }

  int readData () {
    return this->dataLine;
  }

  bool readReadWrite () {
    return this->readWrite;
  }

  bool readSharedSignal () {
    return this->sharedSignal;
  }

  int isInvalid() {
    return this->invalid;
  }
};

#endif
