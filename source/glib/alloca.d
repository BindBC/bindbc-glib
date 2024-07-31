/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.alloca;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

import core.stdc.string;
import core.stdc.stdlib: alloca;

alias g_alloca = alloca;

pragma(inline,true) nothrow @nogc pure{
	void* g_alloca0(size_t size)  =>
		size == 0 ? null : memset(g_alloca(size), 0, size);
	
	StructType* g_newa(StructType)(size_t nStructs) =>
		cast(StructType*)g_alloca(StructType.sizeof * nStructs);
	
	StructType* g_newa0(StructType)(size_t nStructs) =>
		cast(StructType*)g_alloca0(StructType.sizeof * nStructs);
}
