/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.types;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.macros;

//#include <time.h>

alias gboolean = int;
alias goffset = long;

extern(C) nothrow{
	alias GCompareFunc = int function(const(void)* a, const(void)* b);
	alias GCompareDataFunc = int function(const(void)* a, const(void)* b, void* userData);
	alias GEqualFunc = gboolean function(const(void)* a, const(void)* b);
	static if(glibVersion >= Version(2,74,0))
	alias GEqualFuncFull = gboolean function(const(void)* a, const(void)* b, void* userData);
	alias GDestroyNotify = void function(void* data);
	alias GFunc = void function(void* data, void* userData);
	alias GHashFunc = uint function(const(void)* key);
	alias GHFunc = void function(void* key, void* value, void* userData);
	alias GCopyFunc = void* function(const(void)* src, void* data);
	alias GFreeFunc = void function(void* data);
	alias GTranslateFunc = const(char)* function(const(char)* str, void* data);
}

enum{
	G_E      = 2.7182818284590452353602874713526624977572470937000,
	G_LN2    = 0.69314718055994530941723212145817656807550013436026,
	G_LN10   = 2.3025850929940456840179914546843642076011014886288,
	G_PI     = 3.1415926535897932384626433832795028841971693993751,
	G_PI_2   = 1.5707963267948966192313216916397514420985846996876,
	G_PI_4   = 0.78539816339744830961566084581987572104929234984378,
	G_SQRT2  = 1.4142135623730950488016887242096980785696718753769,
}

enum{
	G_LITTLE_ENDIAN  = 1234,
	G_BIG_ENDIAN     = 4321,
	G_PDP_ENDIAN     = 3412,
}

pragma(inline,true) nothrow @nogc pure @safe{
	ushort GUINT16_SWAP_LE_BE_CONSTANT(ushort val) => cast(ushort)(
		cast(ushort)(cast(ushort)val >> 8) |
		cast(ushort)(cast(ushort)val << 8)
	);
	uint GUINT32_SWAP_LE_BE_CONSTANT(uint val) => cast(uint)(
		((cast(uint)val & 0x0000_00FFU) << 24) |
		((cast(uint)val & 0x0000_FF00U) <<  8) |
		((cast(uint)val & 0x00FF_0000U) >>  8) |
		((cast(uint)val & 0xFF00_0000U) >> 24)
	);
	ulong GUINT64_SWAP_LE_BE_CONSTANT(ulong val) => cast(ulong)(
		((cast(ulong)val & 0x0000_0000_0000_00FFUL) << 56) |
		((cast(ulong)val & 0x0000_0000_0000_FF00UL) << 40) |
		((cast(ulong)val & 0x0000_0000_00FF_0000UL) << 24) |
		((cast(ulong)val & 0x0000_0000_FF00_0000UL) <<  8) |
		((cast(ulong)val & 0x0000_00FF_0000_0000UL) >>  8) |
		((cast(ulong)val & 0x0000_FF00_0000_0000UL) >> 24) |
		((cast(ulong)val & 0x00FF_0000_0000_0000UL) >> 40) |
		((cast(ulong)val & 0xFF00_0000_0000_0000UL) >> 56)
	);
	alias GUINT16_SWAP_LE_BE = GUINT16_SWAP_LE_BE_CONSTANT;
	alias GUINT32_SWAP_LE_BE = GUINT32_SWAP_LE_BE_CONSTANT;
	alias GUINT64_SWAP_LE_BE = GUINT64_SWAP_LE_BE_CONSTANT;
	
	ushort GUINT16_SWAP_LE_PDP(ushort val) => cast(ushort)val;
	alias GUINT16_SWAP_BE_PDP = GUINT16_SWAP_LE_BE;
	uint GUINT32_SWAP_LE_PDP(uint val) => cast(uint)(
		((cast(uint)val & cast(uint)0x0000_FFFFU) << 16) |
		((cast(uint)val & cast(uint)0xFFFF_0000U) >> 16)
	);
	uint GUINT32_SWAP_BE_PDP(uint val) => cast(uint)(
		((cast(uint)val & cast(uint)0x00FF_00FFU) << 8) |
		((cast(uint)val & cast(uint)0xFF00_FF00U) >> 8)
	);
}

enum G_IEEE754_FLOAT_BIAS = 127;
enum G_IEEE754_DOUBLE_BIAS = 1023;

enum G_LOG_2_BASE_10 = 0.30102999566398119521;

import std.bitmanip: bitfields;
union GFloatIEEE754{
	float vFloat;
	struct{
		version(LittleEndian){
			mixin(bitfields!(
				uint, q{mantissa}, 23,
				uint, q{biasedExponent}, 8,
				uint, q{sign}, 1,
			));
		}else version(BigEndian){
			mixin(bitfields!(
				uint, q{sign}, 1,
				uint, q{biasedExponent}, 8,
				uint, q{mantissa}, 23,
			));
		}else static assert(0, "Unknown endian type");
		alias biased_exponent = biasedExponent;
	}
}
union GDoubleIEEE754{
	double vDouble;
	struct{
		version(LittleEndian){
			mixin(bitfields!(
				uint, q{mantissaLow}, 32,
				uint, q{mantissaHigh}, 20,
				uint, q{biasedExponent}, 11,
				uint, q{sign}, 1,
			));
		}else version(BigEndian){
			mixin(bitfields!(
				uint, q{sign}, 1,
				uint, q{biasedExponent}, 11,
				uint, q{mantissaHigh}, 20,
				uint, q{mantissaLow}, 32,
			));
		}else static assert(0, "Unknown endian type");
		alias biased_exponent = biasedExponent;
		alias mantissa_high = mantissaHigh;
		alias mantissa_low = mantissaLow;
	}
}

alias grefcount = int;
alias gatomicrefcount = int;
