include ../config

TOP = ..
TARGET = $(TOP)/$(BUILD)/$(MODULE).$(SOEXT)
OBJS = $(addprefix $(TOP)/$(BUILD)/, $(OBJECTS))

all: $(TOP)/$(BUILD) $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $< $(LIBS)
	$(MKDIR) $(TOP)/$(MODULE)
	$(INSTALL_EXEC) $(TARGET) $(TOP)/$(MODULE)/core.$(SOEXT)

$(TOP)/$(BUILD)/%.o: $(TOP)/src/%.c
	$(CC) -MMD -MF $(@:.o=.d) -c $(CFLAGS) -o$@ $<

$(TOP)/$(BUILD):
	$(MKDIR) $(TOP)/$(BUILD)

.PHONY: clean uclean
clean:
	$(RM) $(OBJS) $(TOP)/$(MODULE) $(TARGET) 

uclean: clean
	$(RM) $(TOP)/$(BUILD)

-include $(OBJS:.o=.d)