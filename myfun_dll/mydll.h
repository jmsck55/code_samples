
#ifndef __MYDLL_H__
#define __MYDLL_H__

//extern "C" {
__declspec(dllexport) void mydllfunc(int * a);
//}

#endif // __MYDLL_H__