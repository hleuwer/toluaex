include config

all clean depend:
	cd src && $(MAKE) $@
	
uclean: clean
	cd src && $(MAKE) $@
	find . -name "*~" | xargs $(RM)

install: all
	$(MKDIR) $(INSTALL_SHARE) $(INSTALL_LIB)/$(MODNAME) $(INSTALL_DOC)/$(MODNAME)
	$(INSTALL_DATA) $(MODNAME).lua $(INSTALL_SHARE)
	$(INSTALL_DATA) src/$(MODNAME).$X $(INSTALL_LIB)/$(MODNAME)/core.$X
	cp -rf $(DOCS) $(INSTALL_DOC)/$(MODNAME)
	
uninstall: 
	$(RM) $(INSTALL_SHARE)/$(MODNAME).lua
	$(RM) $(INSTALL_LIB)/$(MODNAME)
	$(RM) $(INSTALL_DOC)
	
test testd:
	@echo "See module 'objtest'!"

doc:
	$(MKDIR) doc
	$(LUADOC) -d doc $(MODNAME).lua

dist::
	$(MKDIR) $(EXPORTDIR)
ifeq (, $(findstring Msys, $(SYSTEM)))
	$(GIT) archive --format=tar --prefix=$(DISTNAME)/ HEAD | $(GZIP) >$(EXPORTDIR)/$(DISTARCH)	
else
	$(GIT) archive --format=zip --prefix=$(DISTNAME)/ HEAD > $(EXPORTDIR)/$(DISTARCH)	
endif

sys:
	@echo "system is: $(SYSTEM)"
	
.PHONY: all dist test testd depend clean uclean install uninstall dist sys
