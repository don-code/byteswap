byteswap
========
Byteswaps the contents of a file.

Some limited configuration is offered over word and buffer size at compile time. The source as-is uses a buffer size of 128k and assumes that 32-bit words are being swapped.

This project was primarily motivated by needing to move N64 save states from [Nemu64](http://nemu.emuunlim.org/) (which stores save states in little-endian format) to [Project64](http://www.pj64-emu.com/) (which stores them in big-endian format).

Build instructions
------------------
This byteswapper is ANSI C-compliant.

For systems with GNU Make, a Makefile is included. Windows users with Visual Studio or the Windows Platform SDK can use NMake with the included NMakefile.mak.
