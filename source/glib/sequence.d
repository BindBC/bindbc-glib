/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.sequence;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

struct GSequence;
struct GSequenceIter;

alias GSequenceIterCompareFunc = extern(C) int function(GSequenceIter* a, GSequenceIter* b, void* data) nothrow;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GSequence*}, q{g_sequence_new}, q{GDestroyNotify dataDestroy}},
		{q{void}, q{g_sequence_free}, q{GSequence* seq}},
		{q{int}, q{g_sequence_get_length}, q{GSequence* seq}},
		{q{void}, q{g_sequence_foreach}, q{GSequence* seq, GFunc func, void* userData}},
		{q{void}, q{g_sequence_foreach_range}, q{GSequenceIter* begin, GSequenceIter* end, GFunc func, void* userData}},
		{q{void}, q{g_sequence_sort}, q{GSequence* seq, GCompareDataFunc cmpFunc, void* cmpData}},
		{q{void}, q{g_sequence_sort_iter}, q{GSequence* seq, GSequenceIterCompareFunc cmpFunc, void* cmpData}},
		{q{GSequenceIter*}, q{g_sequence_get_begin_iter}, q{GSequence* seq}},
		{q{GSequenceIter*}, q{g_sequence_get_end_iter}, q{GSequence* seq}},
		{q{GSequenceIter*}, q{g_sequence_get_iter_at_pos}, q{GSequence* seq, int pos}},
		{q{GSequenceIter*}, q{g_sequence_append}, q{GSequence* seq, void* data}},
		{q{GSequenceIter*}, q{g_sequence_prepend}, q{GSequence* seq,void* data}},
		{q{GSequenceIter*}, q{g_sequence_insert_before}, q{GSequenceIter* iter, void* data}},
		{q{void}, q{g_sequence_move}, q{GSequenceIter* src, GSequenceIter* dest}},
		{q{void}, q{g_sequence_swap}, q{GSequenceIter* a, GSequenceIter* b}},
		{q{GSequenceIter*}, q{g_sequence_insert_sorted}, q{GSequence* seq, void* data, GCompareDataFunc cmpFunc, void* cmpData}},
		{q{GSequenceIter*}, q{g_sequence_insert_sorted_iter}, q{GSequence* seq, void* data, GSequenceIterCompareFunc iterCmp, void* cmpData}},
		{q{void}, q{g_sequence_sort_changed}, q{GSequenceIter* iter, GCompareDataFunc cmpFunc, void* cmpData}},
		{q{void}, q{g_sequence_sort_changed_iter}, q{GSequenceIter* iter, GSequenceIterCompareFunc iterCmp, void* cmpData}},
		{q{void}, q{g_sequence_remove}, q{GSequenceIter* iter}},
		{q{void}, q{g_sequence_remove_range}, q{GSequenceIter* begin, GSequenceIter* end}},
		{q{void}, q{g_sequence_move_range}, q{GSequenceIter* dest, GSequenceIter* begin, GSequenceIter* end}},
		{q{GSequenceIter*}, q{g_sequence_search}, q{GSequence* seq, void* data, GCompareDataFunc cmpFunc, void* cmpData}},
		{q{GSequenceIter*}, q{g_sequence_search_iter}, q{GSequence* seq,void* data, GSequenceIterCompareFunc iterCmp, void* cmpData}},
		{q{GSequenceIter*}, q{g_sequence_lookup}, q{GSequence* seq, void* data, GCompareDataFunc cmpFunc, void* cmpData}},
		{q{GSequenceIter*}, q{g_sequence_lookup_iter}, q{GSequence* seq, void* data, GSequenceIterCompareFunc iterCmp, void* cmpData}},
		{q{void*}, q{g_sequence_get}, q{GSequenceIter* iter}},
		{q{void}, q{g_sequence_set}, q{GSequenceIter* iter, void* data}},
		{q{gboolean}, q{g_sequence_iter_is_begin}, q{GSequenceIter* iter}},
		{q{gboolean}, q{g_sequence_iter_is_end}, q{GSequenceIter* iter}},
		{q{GSequenceIter*}, q{g_sequence_iter_next}, q{GSequenceIter* iter}},
		{q{GSequenceIter*}, q{g_sequence_iter_prev}, q{GSequenceIter* iter}},
		{q{int}, q{g_sequence_iter_get_position}, q{GSequenceIter* iter}},
		{q{GSequenceIter*}, q{g_sequence_iter_move}, q{GSequenceIter* iter, int delta}},
		{q{GSequence*}, q{g_sequence_iter_get_sequence}, q{GSequenceIter* iter}},
		{q{int}, q{g_sequence_iter_compare}, q{GSequenceIter* a, GSequenceIter* b}},
		{q{GSequenceIter*}, q{g_sequence_range_get_midpoint}, q{GSequenceIter* begin, GSequenceIter* end}},
	];
	if(glibVersion >= Version(2,48,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_sequence_is_empty}, q{GSequence* seq}},
		];
		ret ~= add;
	}
	return ret;
}()));
