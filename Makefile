
#
# `Normal' configuration.
#
CC	      = gcc -ansi -Wall -pedantic

.SUFFIXES: .c .o .s .E

#
# Need to include from the current directory because "quickthreads.h"
# will include <qtmd.h>.
#
CFLAGS	      = -I. -g

#
# Fix this to be something meaningful for your system.
#
DEST	      = /dev/null

DOC	      =	users.tout

EXTHDRS	      = /usr/include/stdio.h

HDRS	      = quickthreads.h \
		quickthreadsmd.h \
		stp.h

QT_DOT_A      =	libquickthreads.a

LDFLAGS	      = $(CFLAGS)

EXTLIBS       =

LIBS	      = libstp.a libquickthreads.a

LINKER	      = $(CC)

MAKEFILE      = Makefile

M	      =	Makefile configuration

OBJS	      = qtmdb.o \
		meas.o

QTOBJS	      =	qt.o qtmds.o qtmdc.o

STPOBJS	      =	stp.o

PR	      =	-Pps

PRINT	      = pr

PROGRAM	      = run

SRCS	      = meas.c \
		qt.c \
		qtmdc.c \
		qtmds.s \
		qtmdb.s

TMP_INIT      =	tmp.init
TMP_SWAP      =	tmp.swap

.DEFAULT:
		co -q $@

.c.E:		force
		$(CC) $(CFLAGS) -E $*.c > $*.E

all:		libquickthreads.a libstp.a $(PROGRAM) $(M)

$(QT_DOT_A):	$(QTOBJS) $(M)
		ar crv $(QT_DOT_A) $(QTOBJS)
		ranlib $(QT_DOT_A)

libstp.a:	$(STPOBJS) $(M)
		ar crv libstp.a $(STPOBJS)
		ranlib libstp.a

$(PROGRAM):     $(OBJS) $(LIBS) $(M)
		@echo "Loading $(PROGRAM) ... "
#		ld -o $(PROGRAM) /lib/crt0.o $(OBJS) -lc
		$(LINKER) $(LDFLAGS) $(OBJS) $(LIBS) $(EXTLIBS) -o $(PROGRAM)
		@echo "done"

clean:
		rm -f $(OBJS) $(PROGRAM) $(TMP_INIT) $(TMP_SWAP) $(DOC)
		rm -f $(QT_DOT_A) libstp.a
		rm -f $(QTOBJS) $(STPOBJS)

depend:;	@mkmf -f $(MAKEFILE) PROGRAM=$(PROGRAM) DEST=$(DEST)

doc:		users.ms raw
		time/assim < raw | grep "^init" | sed 's/^init //' > $(TMP_INIT)
		time/assim < raw | grep "^swap" | sed 's/^swap //' > $(TMP_SWAP)
		soelim users.ms | tbl $(PR) | troff -t $(PR) -ms > $(DOC)

index:;		@ctags -wx $(HDRS) $(SRCS)

print:;		@$(PRINT) $(HDRS) $(SRCS)

program:        $(PROGRAM)

tags:           $(HDRS) $(SRCS); @ctags $(HDRS) $(SRCS)

update:		$(DEST)/$(PROGRAM)

$(DEST)/$(PROGRAM): $(SRCS) $(LIBS) $(HDRS) $(EXTHDRS)
		@make -f $(MAKEFILE) DEST=$(DEST) install

QT_H =		quickthreads.h $(QTMD_H)
QTMD_H =	quickthreadsmd.h

###
qtmdb.o: $(M) qtmdb.s b.h
meas.o: $(M) meas.c /usr/include/stdio.h $(QT_H) b.h stp.h
qt.o: $(M) qt.c $(QT_H)
stp.o: $(M) stp.c stp.h $(QT_H)
qtmds.o: $(M) qtmds.s
qtmdc.o: $(M) qtmdc.c $(QT_H)
