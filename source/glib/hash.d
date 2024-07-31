/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.hash;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.list;
import glib.types;

struct GHashTable;

alias GHRFunc = extern(C) gboolean function(void* key, void* value, void* userData) nothrow;

struct GHashTableIter{
	void* dummy1;
	void* dummy2;
	void* dummy3;
	int dummy4;
	gboolean dummy5;
	void* dummy6;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GHashTable*}, q{g_hash_table_new}, q{GHashFunc hashFunc, GEqualFunc keyEqualFunc}},
			{q{GHashTable*}, q{g_hash_table_new_full}, q{GHashFunc hashFunc, GEqualFunc keyEqualFunc, GDestroyNotify keyDestroyFunc, GDestroyNotify valueDestroyFunc}},
			{q{void}, q{g_hash_table_destroy}, q{GHashTable* hashTable}},
			{q{gboolean}, q{g_hash_table_insert}, q{GHashTable* hashTable, void* key, void* value}},
			{q{gboolean}, q{g_hash_table_replace}, q{GHashTable* hashTable, void* key, void* value}},
			{q{gboolean}, q{g_hash_table_add}, q{GHashTable* hashTable, void* key}},
			{q{gboolean}, q{g_hash_table_remove}, q{GHashTable* hashTable, const(void)* key}},
			{q{void}, q{g_hash_table_remove_all}, q{GHashTable* hashTable}},
			{q{gboolean}, q{g_hash_table_steal}, q{GHashTable* hashTable, const(void)* key}},
			{q{void}, q{g_hash_table_steal_all}, q{GHashTable* hashTable}},
			{q{void*}, q{g_hash_table_lookup}, q{GHashTable* hashTable, const(void)* key}},
			{q{gboolean}, q{g_hash_table_contains}, q{GHashTable* hashTable, const(void)* key}},
			{q{gboolean}, q{g_hash_table_lookup_extended}, q{GHashTable* hashTable, const(void)* lookupKey, void** origKey, void** value}},
			{q{void}, q{g_hash_table_foreach}, q{GHashTable* hashTable, GHFunc func, void* userData}},
			{q{void*}, q{g_hash_table_find}, q{GHashTable* hashTable, GHRFunc predicate, void* userData}},
			{q{uint}, q{g_hash_table_foreach_remove}, q{GHashTable* hashTable, GHRFunc func, void* userData}},
			{q{uint}, q{g_hash_table_foreach_steal}, q{GHashTable* hashTable, GHRFunc func, void* userData}},
			{q{uint}, q{g_hash_table_size}, q{GHashTable* hashTable}},
			{q{GList*}, q{g_hash_table_get_keys}, q{GHashTable* hashTable}},
			{q{GList*}, q{g_hash_table_get_values}, q{GHashTable* hashTable}},
			{q{void}, q{g_hash_table_iter_init}, q{GHashTableIter* iter, GHashTable* hashTable}},
			{q{gboolean}, q{g_hash_table_iter_next}, q{GHashTableIter* iter, void** key, void** value}},
			{q{GHashTable*}, q{g_hash_table_iter_get_hash_table}, q{GHashTableIter* iter}},
			{q{void}, q{g_hash_table_iter_remove}, q{GHashTableIter* iter}},
			{q{void}, q{g_hash_table_iter_steal}, q{GHashTableIter* iter}},
			{q{GHashTable*}, q{g_hash_table_ref}, q{GHashTable* hashTable}},
			{q{void}, q{g_hash_table_unref}, q{GHashTable* hashTable}},
			{q{gboolean}, q{g_str_equal}, q{const(void)* v1, const(void)* v2}},
			{q{uint}, q{g_str_hash}, q{const(void)* v}},
			{q{gboolean}, q{g_int_equal}, q{const(void)* v1, const(void)* v2}},
			{q{uint}, q{g_int_hash}, q{const(void)* v}},
			{q{gboolean}, q{g_int64_equal}, q{const(void)* v1, const(void)* v2}},
			{q{uint}, q{g_int64_hash}, q{const(void)* v}},
			{q{gboolean}, q{g_double_equal}, q{const(void)* v1, const(void)* v2}},
			{q{uint}, q{g_double_hash}, q{const(void)* v}},
			{q{uint}, q{g_direct_hash}, q{const(void)* v}, attr: q{pure}},
			{q{gboolean}, q{g_direct_equal}, q{const(void)* v1, const(void)* v2}, attr: q{pure}},
	];
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{void}, q{g_hash_table_iter_replace}, q{GHashTableIter* iter, void* value}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,40,0)){
		FnBind[] add = [
			{q{void**}, q{g_hash_table_get_keys_as_array}, q{GHashTable* hashTable, uint* length}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_hash_table_steal_extended}, q{GHashTable* hashTable, const(void)* lookupKey, void** stolenKey, void** stolenValue}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{GHashTable*}, q{g_hash_table_new_similar}, q{GHashTable* otherHashTable}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,76,0)){
		FnBind[] add = [
			{q{GPtrArray*}, q{g_hash_table_steal_all_keys}, q{GHashTable* hashTable}},
			{q{GPtrArray*}, q{g_hash_table_steal_all_values}, q{GHashTable* hashTable}},
			{q{GPtrArray*}, q{g_hash_table_get_keys_as_ptr_array}, q{GHashTable* hashTable}},
			{q{GPtrArray*}, q{g_hash_table_get_values_as_ptr_array}, q{GHashTable* hashTable}},
		];
		ret ~= add;
	}
	return ret;
}()));
