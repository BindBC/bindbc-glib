/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.queue;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.list;
import glib.types;

struct GQueue{
	GList* head;
	GList* tail;
	uint length;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GQueue*}, q{g_queue_new}, q{}},
			{q{void}, q{g_queue_free}, q{GQueue* queue}},
			{q{void}, q{g_queue_free_full}, q{GQueue* queue, GDestroyNotify freeFunc}},
			{q{void}, q{g_queue_init}, q{GQueue* queue}},
			{q{void}, q{g_queue_clear}, q{GQueue* queue}},
			{q{gboolean}, q{g_queue_is_empty}, q{GQueue* queue}},
			{q{uint}, q{g_queue_get_length}, q{GQueue* queue}},
			{q{void}, q{g_queue_reverse}, q{GQueue* queue}},
			{q{GQueue*}, q{g_queue_copy}, q{GQueue* queue}},
			{q{void}, q{g_queue_foreach}, q{GQueue* queue, GFunc func, void* userData}},
			{q{GList*}, q{g_queue_find}, q{GQueue* queue, const(void)* data}},
			{q{GList*}, q{g_queue_find_custom}, q{GQueue* queue, const(void)* data, GCompareFunc func}},
			{q{void}, q{g_queue_sort}, q{GQueue* queue, GCompareDataFunc compareFunc, void* userData}},
			{q{void}, q{g_queue_push_head}, q{GQueue* queue, void* data}},
			{q{void}, q{g_queue_push_tail}, q{GQueue* queue, void* data}},
			{q{void}, q{g_queue_push_nth}, q{GQueue* queue, void* data, int n}},
			{q{void*}, q{g_queue_pop_head}, q{GQueue* queue}},
			{q{void*}, q{g_queue_pop_tail}, q{GQueue* queue}},
			{q{void*}, q{g_queue_pop_nth}, q{GQueue* queue, uint n}},
			{q{void*}, q{g_queue_peek_head}, q{GQueue* queue}},
			{q{void*}, q{g_queue_peek_tail}, q{GQueue* queue}},
			{q{void*}, q{g_queue_peek_nth}, q{GQueue* queue, uint n}},
			{q{int}, q{g_queue_index}, q{GQueue* queue, const(void)* data}},
			{q{gboolean}, q{g_queue_remove}, q{GQueue* queue, const(void)* data}},
			{q{uint}, q{g_queue_remove_all}, q{GQueue* queue, const(void)* data}},
			{q{void}, q{g_queue_insert_before}, q{GQueue* queue, GList* sibling, void* data}},
			{q{void}, q{g_queue_insert_after}, q{GQueue* queue, GList* sibling, void* data}},
			{q{void}, q{g_queue_insert_sorted}, q{GQueue* queue, void* data, GCompareDataFunc func, void* userData}},
			{q{void}, q{g_queue_push_head_link}, q{GQueue* queue, GList* link}},
			{q{void}, q{g_queue_push_tail_link}, q{GQueue* queue, GList* link}},
			{q{void}, q{g_queue_push_nth_link}, q{GQueue* queue, int n, GList* link}},
			{q{GList*}, q{g_queue_pop_head_link}, q{GQueue* queue}},
			{q{GList*}, q{g_queue_pop_tail_link}, q{GQueue* queue}},
			{q{GList*}, q{g_queue_pop_nth_link}, q{GQueue* queue, uint n}},
			{q{GList*}, q{g_queue_peek_head_link}, q{GQueue* queue}},
			{q{GList*}, q{g_queue_peek_tail_link}, q{GQueue* queue}},
			{q{GList*}, q{g_queue_peek_nth_link}, q{GQueue* queue, uint n}},
			{q{int}, q{g_queue_link_index}, q{GQueue* queue, GList* link}},
			{q{void}, q{g_queue_unlink}, q{GQueue* queue, GList* link}},
			{q{void}, q{g_queue_delete_link}, q{GQueue* queue, GList* link}},
	];
	if(glibVersion >= Version(2,60,0)){
		FnBind[] add = [
			{q{void}, q{g_queue_clear_full}, q{GQueue* queue, GDestroyNotify freeFunc}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,62,0)){
		FnBind[] add = [
			{q{void}, q{g_queue_insert_before_link}, q{GQueue* queue, GList* sibling, GList* link}},
			{q{void}, q{g_queue_insert_after_link}, q{GQueue* queue, GList* sibling, GList* link}},
		];
		ret ~= add;
	}
	return ret;
}()));
