/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.list;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.mem;
import glib.node;
import glib.types;

struct GList{
	void* data;
	GList* next;
	GList* prev;
}

pragma(inline,true) nothrow @nogc{
	static if(glibVersion < Version(2,64,0))
	void g_clear_list(GList** listPtr, GDestroyNotify destroy){
		GList* list = *listPtr;
		if(list){
			*listPtr = null;
			if(destroy !is null)
				g_list_free_full(list, destroy);
			else
				g_list_free(list);
		}
	}
	GList* g_list_previous(GList* list) pure @safe => list ? list.prev : null;
	GList* g_list_next(GList* list) pure @safe => list ? list.next : null;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GList*}, q{g_list_alloc}, q{}},
		{q{void}, q{g_list_free}, q{GList* list}},
		{q{void}, q{g_list_free_1}, q{GList* list}, aliases: [q{g_list_free1}]},
		{q{void}, q{g_list_free_full}, q{GList* list, GDestroyNotify freeFunc}},
		{q{GList*}, q{g_list_append}, q{GList* list, void* data}},
		{q{GList*}, q{g_list_prepend}, q{GList* list, void* data}},
		{q{GList*}, q{g_list_insert}, q{GList* list, void* data, int position}},
		{q{GList*}, q{g_list_insert_sorted}, q{GList* list, void* data, GCompareFunc func}},
		{q{GList*}, q{g_list_insert_sorted_with_data}, q{GList* list, void* data, GCompareDataFunc func, void* userData}},
		{q{GList*}, q{g_list_insert_before}, q{GList* list, GList* sibling, void* data}},
		{q{GList*}, q{g_list_concat}, q{GList* list1, GList* list2}},
		{q{GList*}, q{g_list_remove}, q{GList* list, const(void)* data}},
		{q{GList*}, q{g_list_remove_all}, q{GList* list, const(void)* data}},
		{q{GList*}, q{g_list_remove_link}, q{GList* list, GList* link}},
		{q{GList*}, q{g_list_delete_link}, q{GList* list, GList* link}},
		{q{GList*}, q{g_list_reverse}, q{GList* list}},
		{q{GList*}, q{g_list_copy}, q{GList* list}},
		{q{GList*}, q{g_list_nth}, q{GList* list, uint n}},
		{q{GList*}, q{g_list_nth_prev}, q{GList* list, uint n}},
		{q{GList*}, q{g_list_find}, q{GList* list, const(void)* data}},
		{q{GList*}, q{g_list_find_custom}, q{GList* list, const(void)* data, GCompareFunc func}},
		{q{int}, q{g_list_position}, q{GList* list, GList* link}},
		{q{int}, q{g_list_index}, q{GList* list, const(void)* data}},
		{q{GList*}, q{g_list_last}, q{GList* list}},
		{q{GList*}, q{g_list_first}, q{GList* list}},
		{q{uint}, q{g_list_length}, q{GList* list}},
		{q{void}, q{g_list_foreach}, q{GList* list, GFunc func, void* userData}},
		{q{GList*}, q{g_list_sort}, q{GList* list, GCompareFunc compareFunc}},
		{q{GList*}, q{g_list_sort_with_data}, q{GList* list, GCompareDataFunc compareFunc, void* userData}},
		{q{void*}, q{g_list_nth_data}, q{GList* list, uint n}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{GList*}, q{g_list_copy_deep}, q{GList* list, GCopyFunc func, void* userData}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,62,0)){
		FnBind[] add = [
			{q{GList*}, q{g_list_insert_before_link}, q{GList* list, GList* sibling, GList* link}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,64,0)){
		FnBind[] add = [
			{q{void}, q{g_clear_list}, q{GList** listPtr, GDestroyNotify destroy}},
		];
		ret ~= add;
	}
	return ret;
}()));
