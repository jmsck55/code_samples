// Copyright (c) 2020 James J. Cook

#ifndef __MYDLL_H__
#define __MYDLL_H__

extern "C" {

__declspec(dllimport) void mydllfunc(int * a);

}

#endif // __MYDLL_H__
