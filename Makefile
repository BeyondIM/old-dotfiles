MAKEFLAGS += -bw

SRC := $(shell find $(CURDIR) -mindepth 1 -maxdepth 1 | grep -v -e "\.git\>" -e "Makefile")
DEST := ~

all: $(SRC)

$(SRC): force
	if [[ ! -d $(DEST) ]]; then mkdir -p $(DEST); fi
	if [[ -e $(subst $(CURDIR),$(DEST),$@) ]]; then $(RM) -r $(subst $(CURDIR),$(DEST),$@); fi
    ifneq ($(findstring CYGWIN,$(shell uname -s)),)
		if [ -d $@ ]; then \
			cmd /C "mklink /J $(shell cygpath -w $(subst $(CURDIR),$(DEST),$@)) $(shell cygpath -w $@)"; \
		else \
			cmd /C "mklink /H $(shell cygpath -w $(subst $(CURDIR),$(DEST),$@)) $(shell cygpath -w $@)"; \
		fi
    endif
    ifeq ($(shell uname -s),Darwin)
		ln -s $@ $(subst $(CURDIR),$(DEST),$@)
    endif

clean: 
	$(RM) -r $(subst $(CURDIR),$(DEST),$(SRC))

.PHONY: all clean force
