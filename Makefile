#
# Created by gmakemake (Ubuntu Sep  7 2011) on Fri Jul 18 22:34:12 2014
#

#
# Definitions
#

.SUFFIXES:
.SUFFIXES:      .a .o .c .C .cpp .s .S
.c.o:
                $(COMPILE.c) $<
.C.o:
                $(COMPILE.cc) $<
.cpp.o:
                $(COMPILE.cc) $<
.S.s:
                $(CPP) -o $*.s $<
.s.o:
                $(COMPILE.cc) $<
.c.a:
                $(COMPILE.c) -o $% $<
                $(AR) $(ARFLAGS) $@ $%
                $(RM) $%
.C.a:
                $(COMPILE.cc) -o $% $<
                $(AR) $(ARFLAGS) $@ $%
                $(RM) $%
.cpp.a:
                $(COMPILE.cc) -o $% $<
                $(AR) $(ARFLAGS) $@ $%
                $(RM) $%

CC =            gcc
CXX =           g++

RM = rm -f
AR = ar
LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) -c
COMPILE.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) -c
CPP = $(CPP) $(CPPFLAGS)
########## Default flags (redefine these with a header.mak file if desired)
CXXFLAGS =      -ggdb
CFLAGS =        -ggdb
CLIBFLAGS =     -lm
CCLIBFLAGS =
########## End of default flags


CPP_FILES =
C_FILES =       byteswap.c
PS_FILES =
S_FILES =
H_FILES =
SOURCEFILES =   $(H_FILES) $(CPP_FILES) $(C_FILES) $(S_FILES)
.PRECIOUS:      $(SOURCEFILES)
OBJFILES =

#
# Main targets
#

all:    byteswap

byteswap:       byteswap.o $(OBJFILES)
        $(CC) $(CFLAGS) -o byteswap byteswap.o $(OBJFILES) $(CLIBFLAGS)

#
# Dependencies
#

byteswap.o:

#
# Housekeeping
#

Archive:        archive.tgz

archive.tgz:    $(SOURCEFILES) Makefile
        tar cf - $(SOURCEFILES) Makefile | gzip > archive.tgz

clean:
        -/bin/rm $(OBJFILES) byteswap.o core 2> /dev/null

realclean:        clean
        -/bin/rm -rf byteswap