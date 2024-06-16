# Collection of libraries in a 'static library blob'
* Forked ***[ImGui v1.89.6](https://github.com/ocornut/imgui/releases/tag/v1.89.6)***
* Forked ***[Box2D v2.4.1](https://github.com/erincatto/box2d/releases/tag/v2.4.1)***
* Forked ***[glad2](https://github.com/Dav1dde/glad)***
* Forked ***[stb_image v2.30](https://github.com/nothings/stb/blob/master/stb_image.h)*** 
* No License Whatsoever
* Project-Specific Options **(C++17)**
    - *ImGui* - impl_opengl3 impl_opengl3_loader impl_glfw
    - *Box2D* - None
    - *glad2* - ALIAS MX
    - *stb_image* - None
* ### **[Note]:**
    * **If *ANY* directory 'setup' recipe is missing, call 'make setup'**
    * **COMPILER_BASE_FOLDER** environment variable (Name's pretty self explanatory) **MUST BE DEFINED** 
    * Check Library Dependencies inside **makefile.mf** ( Specifically, **LIB_FILES**, **LIB_PATHS**, **LIB_INC_PATHS** )
        - *Currently, GLFW expected to exist at **$(COMPILER_BASE_FOLDER)/ext/***
#### **Clean Build**
    * [Debug]   make cleandbg
    * [Release] make cleanrel
#### **Build Library**
    * [Debug]   make debug
    * [Release] make release