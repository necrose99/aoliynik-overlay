CFLAGS+=-g -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wredundant-decls
LDFLAGS+=-lX11 -lXext -lXrender

PROGS=xwinwrap

xwinwrap: xwinwrap.o

all: $(PROGS)

clean:
	rm -f $(PROGS) *.o


