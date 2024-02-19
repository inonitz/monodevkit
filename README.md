# imgui1896
* Forked ***[ImGui v1.89.6](https://github.com/ocornut/imgui/releases/tag/v1.89.6)*** for static library compilation
* Feel free to use this
* Edit Makefile to change compilation target ***[I assume you know how to do that lol]***
* Currently Targeting: x86-64-mingw-w64 **[C++17]**

## **[Note]:**
* **If *ANY* directory 'setup' recipe is missing, call 'make setup'**
* To build you must first export the 'DEBUG'=[0, 1] Variable in your console.
* To manage to build ***Anything***, First define **'MINGW_W64_COMPILER_BASE'** in your environment variables (Name is pretty self explanatory)
* Check Library Dependencies - LIB_FILES, LIB_PATHS, LIB_INC_PATHS
* ### ***<u>To Put it Simply:</u>***
    * To Clean The Build Directory:
        - [release] export DEBUG=0 && make clean_internal cleanbin_internal
        - [ debug ] export DEBUG=1 && make clean_internal cleanbin_internal
    * Release Build: 
        1. export DEBUG=0 && make -j X rel_internal
        2. export DEBUG=0 && make rel_internal
    *  Debug  Build: 
        1. export DEBUG=1 && make -j X debug_internal
        2. export DEBUG=1 && make debug_internal

    * X - Your Cpu Core Count * 1.5 (how many threads to use)
        - you can omit '-j X' if there's not alot of files.
    * Hope for the best ***>:)***