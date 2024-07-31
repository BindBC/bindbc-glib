/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.bytes;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GBytes*}, q{g_bytes_new}, q{const(void)* data, size_t size}},
		{q{GBytes*}, q{g_bytes_new_take}, q{void* data, size_t size}},
		{q{GBytes*}, q{g_bytes_new_static}, q{const(void)* data, size_t size}},
		{q{GBytes*}, q{g_bytes_new_with_free_func}, q{const(void)* data, size_t size, GDestroyNotify freeFunc, void* userData}},
		{q{GBytes*}, q{g_bytes_new_from_bytes}, q{GBytes* bytes, size_t offset, size_t length}},
		{q{const(void)*}, q{g_bytes_get_data}, q{GBytes* bytes, size_t* size}},
		{q{size_t}, q{g_bytes_get_size}, q{GBytes* bytes}},
		{q{GBytes*}, q{g_bytes_ref}, q{GBytes* bytes}},
		{q{void}, q{g_bytes_unref}, q{GBytes* bytes}},
		{q{void*}, q{g_bytes_unref_to_data}, q{GBytes* bytes, size_t* size}},
		{q{GByteArray*}, q{g_bytes_unref_to_array}, q{GBytes* bytes}},
		{q{uint}, q{g_bytes_hash}, q{const(void)* bytes}},
		{q{gboolean}, q{g_bytes_equal}, q{const(void)* bytes1, const(void)* bytes2}},
		{q{int}, q{g_bytes_compare}, q{const(void)* bytes1, const(void)* bytes2}},
	];
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
		{q{const(void)*}, q{g_bytes_get_region}, q{GBytes* bytes, size_t elementSize, size_t offset, size_t nElements}},
		];
		ret ~= add;
	}
	return ret;
}()));
