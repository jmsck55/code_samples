REM Copyright (c) 2020 James J. Cook
echo clean
pause
del *.dll *.exe *.obj *.lib *.exp
echo make dll
pause
cl -LD mydll.c
echo make exe
pause
cl /EHsc main.cpp /link mydll.lib
echo run exe
pause
main
echo done
pause
