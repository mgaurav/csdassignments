// generates a new file duplicating trace file, and writing
// address in tag, set, byte notation.
// Used for verifying whether simulator is running correctly.

#include <iostream>
#include <fstream>
#include <string>
#include <string.h>

using namespace std;

void convertAddress(char* addressString, int& tag, int& set, int& block) {
  unsigned int  addressInt;
  
  //converting from the hex string to int first
  if (addressString != NULL)
    sscanf(addressString, "%x",  &addressInt);
  else
    printf("empty string is passed as input to convert address\n");
  
  //extracting tag, set, block
  tag = (addressInt & (1048575 << 12)) >> 12;
  set = (addressInt & (63 << 6)) >> 6;
  block = (addressInt & 63);
}

// int main (int argc, char* argv[]) {
//   char address[8];
//   strcpy(address, argv[1]);
//   int tag, set, block;
//   convertAddress(address, tag, set, block);
//   cout << tag << ' ' << set << ' ' << block << '\n';
//   return 0;
// }
int main () {
  ifstream fin("new_trace1.txt");
  ofstream fout("trace_simplified_1.txt");

  int timeStamp;
  int coreId;
  int write;
  char address[8];  // address is at most 32 byte = 8 hex digit long

  int tag, set, byte;

  while (!fin.eof()) {
    fin >> timeStamp;
    fin >> coreId;
    fin >> write;
    fin >> address;

    if (!fin.eof()) {
      convertAddress(address, tag, set, byte);
      fout << timeStamp << ' ' << coreId << ' ' << write << ' ' 
	 << tag << ' ' << set << ' ' << byte << '\n';
    }
  }
  fin.close();
  fout.close();
}
