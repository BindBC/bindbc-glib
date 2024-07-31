/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.asyncqueue;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

struct GAsyncQueue;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GAsyncQueue*}, q{g_async_queue_new}, q{}},
		{q{GAsyncQueue*}, q{g_async_queue_new_full}, q{GDestroyNotify itemFreeFunc}},
		{q{void}, q{g_async_queue_lock}, q{GAsyncQueue* queue}},
		{q{void}, q{g_async_queue_unlock}, q{GAsyncQueue* queue}},
		{q{GAsyncQueue*}, q{g_async_queue_ref}, q{GAsyncQueue* queue}},
		{q{void}, q{g_async_queue_unref}, q{GAsyncQueue* queue}},
		{q{void}, q{g_async_queue_push}, q{GAsyncQueue* queue, void* data}},
		{q{void}, q{g_async_queue_push_unlocked}, q{GAsyncQueue* queue, void* data}},
		{q{void}, q{g_async_queue_push_sorted}, q{GAsyncQueue* queue, void* data, GCompareDataFunc func, void* userData}},
		{q{void}, q{g_async_queue_push_sorted_unlocked}, q{GAsyncQueue* queue, void* data, GCompareDataFunc func, void* userData}},
		{q{void*}, q{g_async_queue_pop}, q{GAsyncQueue* queue}},
		{q{void*}, q{g_async_queue_pop_unlocked}, q{GAsyncQueue* queue}},
		{q{void*}, q{g_async_queue_try_pop}, q{GAsyncQueue* queue}},
		{q{void*}, q{g_async_queue_try_pop_unlocked}, q{GAsyncQueue* queue}},
		{q{void*}, q{g_async_queue_timeout_pop}, q{GAsyncQueue* queue, ulong timeout}},
		{q{void*}, q{g_async_queue_timeout_pop_unlocked}, q{GAsyncQueue* queue, ulong timeout}},
		{q{int}, q{g_async_queue_length}, q{GAsyncQueue* queue}},
		{q{int}, q{g_async_queue_length_unlocked}, q{GAsyncQueue* queue}},
		{q{void}, q{g_async_queue_sort}, q{GAsyncQueue* queue, GCompareDataFunc func, void* userData}},
		{q{void}, q{g_async_queue_sort_unlocked}, q{GAsyncQueue* queue, GCompareDataFunc func, void* userData}},
	];
	if(glibVersion >= Version(2,46,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_async_queue_remove}, q{GAsyncQueue* queue, void* item}},
			{q{gboolean}, q{g_async_queue_remove_unlocked}, q{GAsyncQueue* queue, void* item}},
			{q{void}, q{g_async_queue_push_front}, q{GAsyncQueue* queue, void* item}},
			{q{void}, q{g_async_queue_push_front_unlocked}, q{GAsyncQueue* queue, void* item}},
		];
		ret ~= add;
	}
	return ret;
}()));
