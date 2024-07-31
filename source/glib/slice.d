/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.slice;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;
//#include <string.h>

pragma(inline,true) nothrow @nogc{
	T* g_slice_new(T)() =>
		cast(T*)g_slice_alloc(T.sizeof);
	T* g_slice_new0(T)(){
		version(D_Optimized){
			void* p = g_slice_alloc(T.sizeof);
			memset(p, 0, T.sizeof);
			return cast(T*)p;
		}else{
			return cast(T*)g_slice_alloc0(T.sizeof);
		}
	}
	
	T* g_slice_dup(T)(T* memBlock) =>
		cast(T*)g_slice_copy(T.sizeof, memBlock);
	void g_slice_free(T)(T* memBlock){
		g_slice_free1(T.sizeof, memBlock);
	}
	void g_slice_free_chain(T)(T* memChain, size_t nextOffset){
		g_slice_free_chain_with_offset(T.sizeof, memChain, nextOffset);
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void*}, q{g_slice_alloc}, q{size_t blockSize}},
		{q{void*}, q{g_slice_alloc0}, q{size_t blockSize}},
		{q{void*}, q{g_slice_copy}, q{size_t blockSize, const(void)* memBlock}},
		{q{void}, q{g_slice_free1}, q{size_t blockSize, void* memBlock}},
		{q{void}, q{g_slice_free_chain_with_offset}, q{size_t blockSize, void* memChain, size_t nextOffset}},
	];
	return ret;
}()));
