
#include <iostream>

#include "mydll.hpp"

void main(int argc, char* argv[])
{
   int a = 10;
   int b = a;
   mydllfunc(&b);

   std::cout << a << " * 2 is " << b << " ! \n";
}