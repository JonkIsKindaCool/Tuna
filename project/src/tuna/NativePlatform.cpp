#include "tuna/NativePlatform.hpp"
#include <iostream>

#include <hl.h>  

namespace tuna
{
    void test_ndll() {
        std::cout << "Hello from tuna dynamic lib" << std::endl;
    }

    HL_PRIM void HL_NAME(hl_test_ndll)() {
        test_ndll();   
    }

    DEFINE_PRIM(test_ndll, 0);
    DEFINE_HL_PRIM(_VOID, hl_test_ndll, _NO_ARG);
}