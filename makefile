include config

all clean depend:
	cd src; $(MAKE) $@

uclean: clean
	rm -f `find . -name "*~"`

install: all
	cd src; mkdir -p $(INSTALL_SHARE)
	if test -e $(MODNAME).lua; then cp $(MODNAME).lua $(INSTALL_SHARE); fi
	cd src; mkdir -p $(INSTALL_LIB)/$(MODNAME)
	cd src; cp $(MODNAME).$X $(INSTALL_LIB)/$(MODNAME)/core.$X

uninstall:
	rm -rf $(INSTALL_SHARE)/$(MODNAME).lua
	rm -rf $(INSTALL_LIB)/$(MODNAME)

test testd:
	@echo "See module 'objtest'!"

doc:
	mkdir -p doc
	luadoc -d doc toluaex.lua

dist::
	svn export $(REPOSITORY)/$(SVNMODULE) $(EXPORTDIR)/$(DISTNAME)
	cd $(EXPORTDIR); tar -cvzf $(DISTARCH) $(DISTNAME)/*
	rm -rf $(EXPORTDIR)/$(DISTNAME)

.PHONY: all dist test testd depend clean uclean install uninstall dist
