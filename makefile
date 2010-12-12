include config

TOP=.

all clean:
	cd src && $(MAKE) $@

uclean: clean 
	cd src && $(MAKE) $@
	$(RMTEMP)

install: all doc
	$(MKDIR) $(INSTALL_SHARE) $(INSTALL_LIB)/$(MODULE) $(INSTALL_DOC)/$(MODULE)
	$(INSTALL_DATA) $(LUAS) $(INSTALL_SHARE)
	$(INSTALL_EXEC) $(TOP)/$(BUILD)/$(MODULE).$(SOEXT) $(INSTALL_LIB)/$(MODULE)/core.$(SOEXT)
	cp -rf $(DOCUMENTS) $(INSTALL_DOC)/$(MODULE)

uninstall: 
	cd $(INSTALL_SHARE) && $(RM) $(LUAS)
	cd $(INSTALL_LIB) && $(RM) $(MODULE)
	cd $(INSTALL_DOC) && $(RM) $(MODULE)

test testd:
	@echo "See module 'objtest'!"

doc::
	$(MKDIR) doc
	$(LUADOC) -d doc $(MODULE).lua

clean-doc:
	$(RM) doc

dist::
	$(MKDIR) $(EXPORTDIR)
ifeq (, $(findstring Msys, $(SYSTEM)))
	$(GIT) archive --format=tar --prefix=$(DISTNAME)/ HEAD | $(GZIP) >$(EXPORTDIR)/$(DISTARCH)	
else
	$(GIT) archive --format=zip --prefix=$(DISTNAME)/ HEAD > $(EXPORTDIR)/$(DISTARCH)	
endif

sys:
	@echo "system is: $(SYSTEM)"

.PHONY: all dist test testd clean uclean install uninstall dist sys
