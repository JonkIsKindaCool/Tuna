#ifndef TUNA_CFFI_CFFI_H
#define TUNA_CFFI_CFFI_H

#include <hl.h>

#undef DEFINE_PRIM
#define DEFINE_HL_PRIM(t, name, args) DEFINE_PRIM_WITH_NAME(t, name, args, name)

#include <hx/CFFIPrime.h>

#endif