WORKING_DIR_ABS_PATH="$(shell pwd)"
SCRIPT_PATH=.vscode/clangd_cc
SCRIPT_NAME=gen_commands.sh
SCRIPT_FULL_ADDRESS=$(WORKING_DIR_ABS_PATH)/$(SCRIPT_PATH)/$(SCRIPT_NAME)




staticdbg:
	@ printf Building Static Library [Debug] ...
	-@ $(SCRIPT_FULL_ADDRESS) build_library static debug
	@ printf "Done!\n"

staticrel:
	@ printf Building Static Library [Release] ...
	-@ $(SCRIPT_FULL_ADDRESS) build_library static release
	@ printf "Done!\n"


shareddbg:
	@ printf Building Shared Library [Debug] ...
	-@ $(SCRIPT_FULL_ADDRESS) build_library shared debug
	@ printf "Done!\n"

sharedrel:
	@ printf Building Shared Library [Release] ...
	-@ $(SCRIPT_FULL_ADDRESS) build_library shared release
	@ printf "Done!\n"




recstaticdbg:
	@ printf Recording Compiler Output for clangd-compile_commands_debug.json generation...
	-@ $(SCRIPT_FULL_ADDRESS) record static debug
	@ printf "Done!\n"

recstaticrel:
	@ printf Recording Compiler Output for clangd-compile_commands_debug.json generation...
	-@ $(SCRIPT_FULL_ADDRESS) record static release
	@ printf "Done!\n"


recshareddbg:
	@ printf Recording Compiler Output for clangd-compile_commands_debug.json generation...
	-@ $(SCRIPT_FULL_ADDRESS) record shared debug
	@ printf "Done!\n"

recsharedrel:
	@ printf Recording Compiler Output for clangd-compile_commands_debug.json generation...
	-@ $(SCRIPT_FULL_ADDRESS) record shared release
	@ printf "Done!\n"




install_staticdbg: staticdbg
	@ printf "Installing Static Library [Debug] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) install static debug
	@ printf "Done!\n"


install_shareddbg: shareddbg
	@ printf "Installing Shared Library [Debug] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) install shared debug
	@ printf "Done!\n"


install_staticrel: staticrel
	@ printf "Installing Static Library [Release] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) install static release
	@ printf "Done!\n"


install_sharedrel: sharedrel
	@ printf "Installing Shared Library [Release] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) install shared release
	@ printf "Done!\n"



debug: staticdbg
debug: shareddbg
debug:
	@ printf "Building Libraries [Debug] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) build_library static debug
	-@ $(SCRIPT_FULL_ADDRESS) build_library shared debug
	@ printf "Done!\n"

release: staticrel
release: sharedrel
release:
	@ printf "Building Libraries [Release] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) build_library static release
	-@ $(SCRIPT_FULL_ADDRESS) build_library shared release
	@ printf "Done!\n"


installdbg:
	@ printf "Building Libraries [Debug] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) install static debug
	-@ $(SCRIPT_FULL_ADDRESS) install shared debug
	@ printf "Done!\n"

installrel:
	@ printf "Building Libraries [Release] ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) install static release
	-@ $(SCRIPT_FULL_ADDRESS) install shared release
	@ printf "Done!\n"


cleandbg:
# echo $(SCRIPT_FULL_ADDRESS)
	@ printf "Cleaning Debug Object Files ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) clean static debug
	-@ $(SCRIPT_FULL_ADDRESS) clean shared debug
	@ printf "Done!\n"

cleanrel:
	@ printf "Cleaning Release Object Files ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) clean static release
	-@ $(SCRIPT_FULL_ADDRESS) clean shared release
	@ printf "Done!\n"




cleanbindbg:
	@ printf "Deleting Debug Libraries ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) clean_binary static debug
	-@ $(SCRIPT_FULL_ADDRESS) clean_binary shared debug
	@ printf "Done!\n"

cleanbinrel:
	@ printf "Deleting Static-Debug Library ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) clean_binary static release
	-@ $(SCRIPT_FULL_ADDRESS) clean_binary shared release
	@ printf "Done!\n"




# static/shared doesn't matter as the internal rule deletes both
cleaninstalldbg:
	@ printf "Deleting Installed Debug Libraries ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) clean_install static debug
	@ printf "Done!\n"

# static/shared doesn't matter as the internal rule deletes both
cleaninstallrel:
	@ printf "Deleting Installed Release Libraries ...\n"
	-@ $(SCRIPT_FULL_ADDRESS) clean_install static release
	@ printf "Done!\n"




cleanall: cleandbg
cleanall: cleanbindbg
cleanall: cleanrel
cleanall: cleanbinrel
cleanall: cleaninstalldbg
cleanall: cleaninstallrel


cleanclangd:
	@ printf "Clearing clangd Cache ...\n"
	-@ rm $(WORKING_DIR_ABS_PATH)/.vscode/.cache/clangd/index/*
	@ printf "Done!\n"


setup:
	mkdir -p source
	mkdir -p include
	mkdir -p build
	mkdir -p build/install
	mkdir -p build/install/include
	mkdir -p build/install/lib
	mkdir -p build/debug
	mkdir -p build/debug/bin
	mkdir -p build/debug/obj
	mkdir -p build/release
	mkdir -p build/release/bin
	mkdir -p build/release/obj