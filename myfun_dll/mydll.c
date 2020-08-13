
#include "mydll.h"

//extern "C" {
void mydllfunc(int * a)
{
	*a *= 2;
}
//}