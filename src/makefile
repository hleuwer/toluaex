include ../config


T = $(MODNAME).$X

all: $T

$T: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
	$(MKDIR) ../$(MODNAME)
	$(INSTALL_DATA) $T ../$(MODNAME)/core.$X

SUFFIXES: .c .o .d
.c.o:
	$(CC) -MMD -c $(CFLAGS) -o $@ $<

.PHONY: clean uclean
clean:
	$(RM) $(OBJS) ../$(MODNAME) $T makefile.deps ../$(MODNAME)

uclean:
	$(RM) $(OBJS:.o=.d)

-include $(OBJS:.o=.d)