/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.array;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

struct GBytes;

struct GArray{
	char* data;
	uint len;
}

struct GByteArray{
	ubyte* data;
	uint len;
}

struct GPtrArray{
	void** pData;
	alias pdata = pData;
	uint len;
}

pragma(inline,true) nothrow @nogc{
	GArray* g_array_append_val(GArray* a, const(void)* v) =>
		g_array_append_vals(a, &v, 1);
	GArray* g_array_prepend_val(GArray* a, const(void)* v) =>
		g_array_prepend_vals(a, &v, 1);
	GArray* g_array_insert_val(GArray* a, uint i, const(void)* v) =>
		g_array_insert_vals(a, i, &v, 1);
	T* g_array_index(T)(GArray* a, size_t i) pure =>
		(cast(T*)a.data)[i];
	
	auto g_ptr_array_index(GPtrArray* array, size_t index) pure =>
		array.pData[index];
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GArray*}, q{g_array_new}, q{gboolean zeroTerminated, gboolean clear, uint elementSize}},
		{q{GArray*}, q{g_array_sized_new}, q{gboolean zeroTerminated, gboolean clear, uint elementSize, uint reservedSize}},
		{q{char*}, q{g_array_free}, q{GArray* array, gboolean freeSegment}},
		{q{GArray*}, q{g_array_ref}, q{GArray* array}},
		{q{void}, q{g_array_unref}, q{GArray* array}},
		{q{uint}, q{g_array_get_element_size}, q{GArray* array}},
		{q{GArray*}, q{g_array_append_vals}, q{GArray* array, const(void)* data, uint len}},
		{q{GArray*}, q{g_array_prepend_vals}, q{GArray* array, const(void)* data, uint len}},
		{q{GArray*}, q{g_array_insert_vals}, q{GArray* array, uint index, const(void)* data, uint len}},
		{q{GArray*}, q{g_array_set_size}, q{GArray* array, uint length}},
		{q{GArray*}, q{g_array_remove_index}, q{GArray* array, uint index}},
		{q{GArray*}, q{g_array_remove_index_fast}, q{GArray* array, uint index}},
		{q{GArray*}, q{g_array_remove_range}, q{GArray* array, uint index, uint length}},
		{q{void}, q{g_array_sort}, q{GArray* array, GCompareFunc compareFunc}},
		{q{void}, q{g_array_sort_with_data}, q{GArray* array, GCompareDataFunc compareFunc, void* userData}},
		{q{void}, q{g_array_set_clear_func}, q{GArray* array, GDestroyNotify clearFunc}},
		{q{GPtrArray*}, q{g_ptr_array_new}, q{}},
		{q{GPtrArray*}, q{g_ptr_array_new_with_free_func}, q{GDestroyNotify elementFreeFunc}},
		{q{GPtrArray*}, q{g_ptr_array_sized_new}, q{uint reservedSize}},
		{q{GPtrArray*}, q{g_ptr_array_new_full}, q{uint reservedSize, GDestroyNotify elementFreeFunc}},
		{q{void**}, q{g_ptr_array_free}, q{GPtrArray* array, gboolean freeSeg}},
		{q{GPtrArray*}, q{g_ptr_array_ref}, q{GPtrArray* array}},
		{q{void}, q{g_ptr_array_unref}, q{GPtrArray* array}},
		{q{void}, q{g_ptr_array_set_free_func}, q{GPtrArray* array, GDestroyNotify elementFreeFunc}},
		{q{void}, q{g_ptr_array_set_size}, q{GPtrArray* array, int length}},
		{q{void*}, q{g_ptr_array_remove_index}, q{GPtrArray* array, uint index}},
		{q{void*}, q{g_ptr_array_remove_index_fast}, q{GPtrArray* array, uint index}},
		{q{gboolean}, q{g_ptr_array_remove}, q{GPtrArray* array, void* data}},
		{q{gboolean}, q{g_ptr_array_remove_fast}, q{GPtrArray* array, void* data}},
		{q{GPtrArray*}, q{g_ptr_array_remove_range}, q{GPtrArray* array, uint index, uint length}},
		{q{void}, q{g_ptr_array_add}, q{GPtrArray* array, void* data}},
		{q{void}, q{g_ptr_array_sort}, q{GPtrArray* array, GCompareFunc compareFunc}},
		{q{void}, q{g_ptr_array_sort_with_data}, q{GPtrArray* array, GCompareDataFunc compareFunc, void* userData}},
		{q{void}, q{g_ptr_array_foreach}, q{GPtrArray* array, GFunc func, void* userData}},
		{q{GByteArray*}, q{g_byte_array_new}, q{}},
		{q{GByteArray*}, q{g_byte_array_new_take}, q{ubyte* data, size_t len}},
		{q{GByteArray*}, q{g_byte_array_sized_new}, q{uint reservedSize}},
		{q{ubyte*}, q{g_byte_array_free}, q{GByteArray* array, gboolean freeSegment}},
		{q{GBytes*}, q{g_byte_array_free_to_bytes}, q{GByteArray* array}},
		{q{GByteArray*}, q{g_byte_array_ref}, q{GByteArray* array}},
		{q{void}, q{g_byte_array_unref}, q{GByteArray* array}},
		{q{GByteArray*}, q{g_byte_array_append}, q{GByteArray* array, const(ubyte)* data, uint len}},
		{q{GByteArray*}, q{g_byte_array_prepend}, q{GByteArray* array, const(ubyte)* data, uint len}},
		{q{GByteArray*}, q{g_byte_array_set_size}, q{GByteArray* array, uint length}},
		{q{GByteArray*}, q{g_byte_array_remove_index}, q{GByteArray* array, uint index}},
		{q{GByteArray*}, q{g_byte_array_remove_index_fast}, q{GByteArray* array, uint index}},
		{q{GByteArray*}, q{g_byte_array_remove_range}, q{GByteArray* array, uint index, uint length}},
		{q{void}, q{g_byte_array_sort}, q{GByteArray* array, GCompareFunc compareFunc}},
		{q{void}, q{g_byte_array_sort_with_data}, q{GByteArray* array, GCompareDataFunc compareFunc, void* userData}},
	];
	if(glibVersion >= Version(2,40,0)){
		FnBind[] add = [
			{q{void}, q{g_ptr_array_insert}, q{GPtrArray* array, int index, void* data}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,54,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_ptr_array_find}, q{GPtrArray* haystack, const(void)* needle, uint* index}},
			{q{gboolean}, q{g_ptr_array_find_with_equal_func}, q{GPtrArray* haystack, const(void)* needle, GEqualFunc equalFunc, uint* index}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{void*}, q{g_ptr_array_steal_index}, q{GPtrArray* array, uint index}},
			{q{void*}, q{g_ptr_array_steal_index_fast}, q{GPtrArray* array, uint index}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,62,0)){
		FnBind[] add = [
			{q{GArray*}, q{g_array_copy}, q{GArray* array}},
			{q{gboolean}, q{g_array_binary_search}, q{GArray* array, const(void)* target, GCompareFunc compareFunc, uint* outMatchIndex}},
			{q{GPtrArray*}, q{g_ptr_array_copy}, q{GPtrArray* array, GCopyFunc func, void* userData}},
			{q{void}, q{g_ptr_array_extend}, q{GPtrArray* array_to_extend, GPtrArray* array, GCopyFunc func, void* userData}},
			{q{void}, q{g_ptr_array_extend_and_steal}, q{GPtrArray* array_to_extend, GPtrArray* array}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,64,0)){
		FnBind[] add = [
			{q{void*}, q{g_array_steal}, q{GArray* array, size_t* len}},
			{q{void**}, q{g_ptr_array_steal}, q{GPtrArray* array, size_t* len}},
			{q{ubyte*}, q{g_byte_array_steal}, q{GByteArray* array, size_t* len}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		FnBind[] add = [
			{q{GPtrArray*}, q{g_ptr_array_new_null_terminated}, q{uint reservedSize, GDestroyNotify elementFreeFunc, gboolean nullTerminated}},
			{q{gboolean}, q{g_ptr_array_is_null_terminated}, q{GPtrArray* array}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,76,0)){
		FnBind[] add = [
			{q{void}, q{g_ptr_array_sort_values}, q{GPtrArray* array, GCompareFunc compareFunc}},
			{q{void}, q{g_ptr_array_sort_values_with_data}, q{GPtrArray* array, GCompareDataFunc compareFunc, void* userData}},
			{q{GArray*}, q{g_array_new_take}, q{void* data, size_t len, gboolean clear, size_t elementSize}},
			{q{GArray*}, q{g_array_new_take_zero_terminated}, q{void*  data, gboolean clear, size_t elementSize}},
			{q{GPtrArray*}, q{g_ptr_array_new_take}, q{void** data, size_t len, GDestroyNotify elementFreeFunc}},
			{q{GPtrArray*}, q{g_ptr_array_new_from_array}, q{void** data, size_t len, GCopyFunc copyFunc, void* copyFuncUserData, GDestroyNotify elementFreeFunc}},
			{q{GPtrArray*}, q{g_ptr_array_new_take_null_terminated}, q{void** data, GDestroyNotify elementFreeFunc}},
			{q{GPtrArray*}, q{g_ptr_array_new_from_null_terminated_array}, q{void** data, GCopyFunc copyFunc, void* copyFuncUserData, GDestroyNotify elementFreeFunc}},
		];
		ret ~= add;
	}
	return ret;
}()));
