!include <win32.mak>

all: byteswap.exe

.c.obj:
  $(cc) $(cdebug) $(cflags) $(cvars) $*.c

simple.exe: simple.obj
  $(link) $(ldebug) $(conflags) -out:byteswap.exe simple.obj $(conlibs)