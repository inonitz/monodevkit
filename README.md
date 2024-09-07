# Collection of libraries in a 'mono' development kit
* Forked ***[ImGui v1.90.5](https://github.com/ocornut/imgui/releases/tag/v1.90.5)***
* Forked ***[glbinding v3.3.0](https://github.com/cginternals/glbinding/releases/tag/v3.3.0)***
* Forked ***[stb_image v2.30](https://github.com/nothings/stb/blob/master/stb_image.h)*** 
* No License Whatsoever
* Project-Specific Options **(C++17)**
    - *ImGui* - impl_opengl3 impl_opengl3_loader impl_glfw
    - *glbinding* - glbinding glbinding-aux static
    - *stb_image* - None
* ### **[Note]:**
    * **If *ANY* directory 'setup' recipe is missing, call 'make setup'**
    * **COMPILER_BASE_FOLDER** environment variable (Name's pretty self explanatory) **MUST BE DEFINED** 
    * Check Library Dependencies inside **makefile.mf** ( Specifically, **LIB_FILES**, **LIB_PATHS**, **LIB_INC_PATHS** )
        - *Currently, GLFW expected to exist at **$(COMPILER_BASE_FOLDER)/ext/***
#### **Clean Object Files**
    * [Debug]   make cleandbg
    * [Release] make cleanrel
#### **Clean Binaries**
    * [Debug]   make cleanbindbg
    * [Release] make cleanbinrel
#### **Clean Install Folder**
    * [Debug]   make cleaninstalldbg
    * [Release] make cleaninstallrel
#### **Clean Everything**
    * make cleanall
#### **Build Library**
    * [Debug]   make debug   - [Static & Shared Libraries]
    * [Release] make release - [Static & Shared Libraries]
    * [Debug]   make [static/shared]dbg
    * [Release] make [static/shared]rel
#### **Build Library + Clangd Metadata (Don't forget to restart clangd in vscode)**
    * [Debug]   make rec[static/shared]dbg
    * [Release] make rec[static/shared]rel
#### **Install Library**
    * [Debug]   make installdbg - [Static & Shared Libraries]
    * [Release] make installrel - [Static & Shared Libraries]
    * [Debug]   make install_[static/shared]dbg
    * [Release] make install_[static/shared]rel