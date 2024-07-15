THREAD_COUNT_TOTAL = $(shell nproc)
THREAD_COUNT := $(shell echo $$(($(THREAD_COUNT_TOTAL) - 2)))


cleandbg:
	@ export DEBUG=1 && make -f makefile.mf clean_internal cleanbin_internal

cleanrel:
	@ export DEBUG=0 && make -f makefile.mf clean_internal cleanbin_internal


release:
	export DEBUG=0 && make -f makefile.mf -j $(THREAD_COUNT) rel_internal ; make -f makefile.mf rel_internal

debug:
	export DEBUG=1 && make -f makefile.mf -j $(THREAD_COUNT) debug_internal ; make -f makefile.mf debug_internal


setup:
	@ export DEBUG=0
	@ mkdir -p assets
	@ mkdir -p src
	@ mkdir -p build
	@ mkdir -p build/debug
	@ mkdir -p build/debug/bin
	@ mkdir -p build/debug/obj
	@ mkdir -p build/release
	@ mkdir -p build/release/bin
	@ mkdir -p build/release/obj


.PHONY: cleandbg cleanrel debug release setup