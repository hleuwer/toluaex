include ../config

OBJS := ltoluaex.o

T = $(MODNAME).$X

all: $T

$T: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
	mkdir -p ../$(MODNAME)
	cp $T ../$(MODNAME)/core.$X

clean:
	rm -f $(OBJS) 
	rm -rf ../$(MODNAME)
	rm -f $T
	rm -rf makefile.deps

depend: makefile.deps

makefile.deps: $(OBJS:.o=.c)
	rm -f makefile.deps
	test -z "$(OBJS)" || $(CC) -MM $(CFLAGS) $(OBJS:.o=.c) >> makefile.deps

-include makefile.deps