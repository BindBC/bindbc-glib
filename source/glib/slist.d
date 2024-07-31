/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.slist;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.mem;
import glib.node;
import glib.types;

struct GSList{
	void* data;
	GSList* next;
}

pragma(inline,true) nothrow @nogc{
	static if(glibVersion >= Version(2,64,0))
	void g_clear_slist(GSList** listPtr, GDestroyNotify destroy){
		if(GSList* list = *listPtr){
			*listPtr = null;
			
			if(destroy !is null)
				g_slist_free_full(list, destroy);
			else
				g_slist_free(list);
		}
	}
	
	GSList* g_slist_next(GSList* list) pure @safe =>
		list ? list.next : null;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GSList*}, q{g_slist_alloc}, q{}},
		{q{void}, q{g_slist_free}, q{GSList* list}},
		{q{void}, q{g_slist_free_1}, q{GSList* list}, aliases: [q{g_slist_free1}]},
		{q{void}, q{g_slist_free_full}, q{GSList* list, GDestroyNotify freeFunc}},
		{q{GSList*}, q{g_slist_append}, q{GSList* list, void* data}},
		{q{GSList*}, q{g_slist_prepend}, q{GSList* list, void* data}},
		{q{GSList*}, q{g_slist_insert}, q{GSList* list, void* data, int position}},
		{q{GSList*}, q{g_slist_insert_sorted}, q{GSList* list, void* data, GCompareFunc func}},
		{q{GSList*}, q{g_slist_insert_sorted_with_data}, q{GSList* list, void* data, GCompareDataFunc func, void* userData}},
		{q{GSList*}, q{g_slist_insert_before}, q{GSList* list, GSList* sibling, void* data}},
		{q{GSList*}, q{g_slist_concat}, q{GSList* list1, GSList* list2}},
		{q{GSList*}, q{g_slist_remove}, q{GSList* list, const(void)* data}},
		{q{GSList*}, q{g_slist_remove_all}, q{GSList* list, const(void)* data}},
		{q{GSList*}, q{g_slist_remove_link}, q{GSList* list, GSList* link}},
		{q{GSList*}, q{g_slist_delete_link}, q{GSList* list, GSList* link}},
		{q{GSList*}, q{g_slist_reverse}, q{GSList* list}},
		{q{GSList*}, q{g_slist_copy}, q{GSList* list}},
		{q{GSList*}, q{g_slist_nth}, q{GSList* list, uint n}},
		{q{GSList*}, q{g_slist_find}, q{GSList* list, const(void)* data}},
		{q{GSList*}, q{g_slist_find_custom}, q{GSList* list, const(void)* data, GCompareFunc func}},
		{q{int}, q{g_slist_position}, q{GSList* list, GSList* llink}},
		{q{int}, q{g_slist_index}, q{GSList* list, const(void)* data}},
		{q{GSList*}, q{g_slist_last}, q{GSList* list}},
		{q{uint}, q{g_slist_length}, q{GSList* list}},
		{q{void}, q{g_slist_foreach}, q{GSList* list, GFunc func, void* userData}},
		{q{GSList*}, q{g_slist_sort}, q{GSList* list, GCompareFunc compareFunc}},
		{q{GSList*}, q{g_slist_sort_with_data}, q{GSList* list, GCompareDataFunc compareFunc, void* userData}},
		{q{void*}, q{g_slist_nth_data}, q{GSList* list, uint n}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{GSList*}, q{g_slist_copy_deep}, q{GSList* list, GCopyFunc func, void* userData}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,64,0)){
		FnBind[] add = [
			{q{void}, q{g_clear_slist}, q{GSList** listPtr, GDestroyNotify destroy}},
		];
		ret ~= add;
	}
	return ret;
}()));
