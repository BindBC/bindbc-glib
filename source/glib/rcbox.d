/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.rcbox;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.mem;
import glib.types;

static if(glibVersion >= Version(2,58,0)){
	pragma(inline,true) nothrow @nogc{
		T* g_rc_box_new(T)() =>
			cast(T*)g_rc_box_alloc(T.sizeof);
		T* g_rc_box_new0(T)() =>
			cast(T*)g_rc_box_alloc0(T.sizeof);
		T* g_atomic_rc_box_new(T)() =>
			cast(T*)g_atomic_rc_box_alloc(T.sizeof);
		T* g_atomic_rc_box_new0(T)() =>
			cast(T*)g_atomic_rc_box_alloc0(T.sizeof);
		
		T* g_rc_box_acquire(T)(T* memBlock)
		if(!is(T == void)) =>
			cast(T*)g_rc_box_acquire(cast(void*)memBlock);
		T* g_atomic_rc_box_acquire(T)(T* memBlock)
		if(!is(T == void)) =>
			cast(T*)g_atomic_rc_box_acquire(cast(void*)memBlock);
		
		T* g_rc_box_dup(T)(size_t blockSize, T* memBlock)
		if(!is(T == void)) =>
			cast(T*)g_rc_box_dup(blockSize, cast(void*)memBlock);
		T* g_atomic_rc_box_dup(T)(size_t blockSize, T* memBlock)
		if(!is(T == void)) =>
			cast(T*)g_atomic_rc_box_dup(blockSize, cast(void*)memBlock);
	}
}

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{void*}, q{g_rc_box_alloc}, q{size_t blockSize}},
			{q{void*}, q{g_rc_box_alloc0}, q{size_t blockSize}},
			{q{void*}, q{g_rc_box_dup}, q{size_t blockSize, const(void)* memBlock}},
			{q{void*}, q{g_rc_box_acquire}, q{void* memBlock}},
			{q{void}, q{g_rc_box_release}, q{void* memBlock}},
			{q{void}, q{g_rc_box_release_full}, q{void* memBlock, GDestroyNotify clearFunc}},
			{q{size_t}, q{g_rc_box_get_size}, q{void* memBlock}},
			{q{void*}, q{g_atomic_rc_box_alloc}, q{size_t blockSize}},
			{q{void*}, q{g_atomic_rc_box_alloc0}, q{size_t blockSize}},
			{q{void*}, q{g_atomic_rc_box_dup}, q{size_t blockSize, const(void)* memBlock}},
			{q{void*}, q{g_atomic_rc_box_acquire}, q{void* memBlock}},
			{q{void}, q{g_atomic_rc_box_release}, q{void* memBlock}},
			{q{void}, q{g_atomic_rc_box_release_full}, q{void* memBlock, GDestroyNotify clearFunc}},
			{q{size_t}, q{g_atomic_rc_box_get_size}, q{void* memBlock}},
		];
		ret ~= add;
	}
	return ret;
}()));

