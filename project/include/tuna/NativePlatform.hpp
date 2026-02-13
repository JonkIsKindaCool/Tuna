#ifndef TUNA_NATIVE_PLATFORM_HPP
#define TUNA_NATIVE_PLATFORM_HPP
#include "tuna/cffi/CFFI.hpp"         
namespace tuna
{
    void test_ndll();

    HL_PRIM void HL_NAME(test_ndll)(); 
}

#endif