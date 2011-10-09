# Generic NewGRF Makefile

# Necessary defines unique to this NewGRF
-include Makefile.local
include Makefile.config

# Necessary defines common to all NewGRFs
include scripts/Makefile.def

# most important build targets for users
all:
	$(_V) $(MAKE) $(MAKE_FLAGS) Makefile.dep
	$(_V) $(MAKE) $(MAKE_FLAGS) depend
	$(_V) $(MAKE) $(MAKE_FLAGS) $(TARGET_FILES) $(DOC_FILES)

docs: $(DOC_FILES)

grf: $(GRF_FILES)

bundle:
	$(_V) $(MAKE) $(MAKE_FLAGS) all
	$(_V) $(MAKE) $(DIR_NAME)

clean::
	$(_E) "[CLEAN]"

remake:
	$(_V) $(MAKE) $(MAKE_FLAGS) clean
	$(_V) $(MAKE) $(MAKE_FLAGS) all

distclean:: clean
	$(_E) "[DISTCLEAN]"

# Include custom rules
-include scripts/Makefile.in

# Do not include the dependencies when we're cleaning
#    or going to call make recursively again
ifeq "$(MAKECMDGOALS)" ""
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "clean"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "distclean"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "remake"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "mrproper"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "maintainer-clean"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "all"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "Makefile.dep"
NODEP = 1
endif
ifeq "$(MAKECMDGOALS)" "depend"
NODEP = 1
endif
ifeq "$(MAKECMDGOALS)" "test"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "bundle_src"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "bundle_gsrc"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "bundle_bsrc"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "bundle_xsrc"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "bundle_zsrc"
NODEP = 1
PREDEP = 1
endif
ifeq "$(MAKECMDGOALS)" "bundle"
NODEP = 1
PREDEP = 1
endif


ifndef PREDEP
-include Makefile.dep
endif

ifndef NODEP
-include $(patsubst %.grf,%.src.dep,$(GRF_FILES))
-include $(patsubst %.grf,%.gfx.dep,$(GRF_FILES))
endif

# Stuff common to all NewGRFs
include scripts/Makefile.common

# Include the language - specific makefile
-include scripts/Makefile.nml
-include scripts/Makefile.nfo

# Include bundles etc
include scripts/Makefile.bundles

