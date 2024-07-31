/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.mem;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.utils;
import glib.types;

enum G_MEM_ALIGN = (){
	static if((void*).sizeof > long.sizeof) return (void*).sizeof;
	else return c_long.sizeof;
}();

pragma(inline,true) nothrow @nogc{
	static if(glibVersion < Version(2,34,0))
	void g_clear_pointer(T)(T** pp, GDestroyNotify destroy){
		auto ptr = *pp;
		*pp = null;
		if(ptr){
			destroy(p);
		}
	}
	
	StructType* _G_NEW(StructType, string func)(size_t nStructs){
		version(D_Optimized){
			if(StructType.sizeof == 1)
				return cast(StructType*)mixin("g_"~func~"(nStructs)");
			else
				return cast(StructType*)mixin("g_"~func~"_n(nStructs, StructType.sizeof)");
		}else{
			return cast(StructType*)mixin("g_"~func~"_n(nStructs, StructType.sizeof)");
		}
	}
	StructType* _G_RENEW(StructType, string func)(StructType* mem, size_t nStructs){
		version(D_Optimized){
			if(StructType.sizeof == 1)
				return cast(StructType*) __p = mixin("g_"~func~" (cast(void*)mem, nStructs)");
			else
				return cast(StructType*) __p = mixin("g_"~func~"_n (cast(void*)mem, nStructs, StructType.sizeof)");
		}else{
			return cast(StructType*) __p = mixin("g_"~func~"_n (cast(void*)mem, nStructs, StructType.sizeof)");
		}
	}
	
	StructType* g_new(StructType)(size_t nStructs) => _G_NEW!(StructType, "malloc")(nStructs);
	StructType* g_new0(StructType)(size_t nStructs) => _G_NEW!(StructType, "malloc0")(nStructs);
	StructType* g_renew(StructType)(StructType* mem, size_t nStructs) => _G_RENEW!(StructType, "realloc")(mem, nStructs);
	
	StructType* g_try_new(StructType)(size_t nStructs) => _G_NEW!(StructType, "try_malloc")(nStructs);
	StructType* g_try_new0(StructType)(size_t nStructs) => _G_NEW!(StructType, "try_malloc0")(nStructs);
	StructType* g_try_renew(StructType)(StructType* mem, size_t nStructs) => _G_RENEW!(StructType, "try_realloc")(mem, nStructs);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{g_free}, q{void* mem}},
		{q{void*}, q{g_malloc}, q{size_t nBytes}},
		{q{void*}, q{g_malloc0}, q{size_t nBytes}},
		{q{void*}, q{g_realloc}, q{void* mem, size_t nBytes}},
		{q{void*}, q{g_try_malloc}, q{size_t nBytes}},
		{q{void*}, q{g_try_malloc0}, q{size_t nBytes}},
		{q{void*}, q{g_try_realloc}, q{void* mem, size_t nBytes}},
		{q{void*}, q{g_malloc_n}, q{size_t nBlocks, size_t nBlockBytes}},
		{q{void*}, q{g_malloc0_n}, q{size_t nBlocks, size_t nBlockBytes}},
		{q{void*}, q{g_realloc_n}, q{void* mem, size_t nBlocks, size_t nBlockBytes}},
		{q{void*}, q{g_try_malloc_n}, q{size_t nBlocks, size_t nBlockBytes}},
		{q{void*}, q{g_try_malloc0_n}, q{size_t nBlocks, size_t nBlockBytes}},
		{q{void*}, q{g_try_realloc_n}, q{void* mem, size_t nBlocks, size_t nBlockBytes}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{void}, q{g_clear_pointer}, q{void** pp, GDestroyNotify destroy}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{void*}, q{g_aligned_alloc}, q{size_t nBlocks, size_t nBlockBytes, size_t alignment}},
			{q{void*}, q{g_aligned_alloc0}, q{size_t nBlocks, size_t nBlockBytes, size_t alignment}},
			{q{void}, q{g_aligned_free}, q{void* mem}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,76,0)){
		FnBind[] add = [
			{q{void}, q{g_free_sized}, q{void* mem, size_t size}},
			{q{void}, q{g_aligned_free_sized}, q{void* mem, size_t alignment, size_t size}},
		];
		ret ~= add;
	}
	return ret;
}()));
