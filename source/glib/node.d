/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.node;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.mem;
import glib.types;

mixin(makeEnumBind(q{GTraverseFlags}, aliases: [q{GTraverseFlag}], members: (){
	EnumMember[] ret = [
		{{q{leaves},     q{G_TRAVERSE_LEAVES}},      q{1 << 0}},
		{{q{nonLeaves},  q{G_TRAVERSE_NON_LEAVES}},  q{1 << 1}},
		{{q{all},        q{G_TRAVERSE_ALL}},         q{GTraverseFlag.leaves | GTraverseFlag.nonLeaves}},
		{{q{mask},       q{G_TRAVERSE_MASK}},        q{0x03}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GTraverseType}, aliases: [q{GTraverse}], members: (){
	EnumMember[] ret = [
		{{q{inOrder},     q{G_IN_ORDER}}},
		{{q{preOrder},    q{G_PRE_ORDER}}},
		{{q{postOrder},   q{G_POST_ORDER}}},
		{{q{levelOrder},  q{G_LEVEL_ORDER}}},
	];
	return ret;
}()));

extern(C) nothrow{
	alias GNodeTraverseFunc = gboolean function(GNode* node, void* data);
	alias GNodeForEachFunc = void function(GNode* node, void* data);
	alias GNodeForeachFunc = GNodeForEachFunc;
}

struct GNode{
	void* data;
	GNode* next;
	GNode* prev;
	GNode* parent;
	GNode* children;
}

pragma(inline,true) nothrow @nogc{
	bool G_NODE_IS_ROOT(GNode* node) pure @safe =>
		node.parent is null &&
		node.prev   is null &&
		node.next   is null;
	bool G_NODE_IS_LEAF(GNode* node) pure @safe =>
		node.children is null;
	
	GNode* g_node_append(GNode* parent, GNode* node) =>
		 g_node_insert_before(parent, null, node);
	GNode* g_node_insert_data(GNode* parent, int position, void* data) =>
		g_node_insert(parent, position, g_node_new(data));
	GNode* g_node_insert_data_after(GNode* parent, GNode* sibling, void* data) =>
		g_node_insert_after(parent, sibling, g_node_new(data));
	GNode* g_node_insert_data_before(GNode* parent, GNode* sibling, void* data) =>
		g_node_insert_before(parent, sibling, g_node_new(data));
	GNode* g_node_prepend_data(GNode* parent, void* data) =>
		g_node_prepend(parent, g_node_new(data));
	GNode* g_node_append_data(GNode* parent, void* data) =>
		g_node_insert_before(parent, null, g_node_new(data));
	
	GNode* g_node_prev_sibling(GNode* node) pure @safe =>
		node ? node.prev : null;
	GNode* g_node_next_sibling(GNode* node) pure @safe =>
		node ? node.next : null;
	GNode* g_node_first_child(GNode* node) pure @safe =>
		node ? node.children : null;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GNode*}, q{g_node_new}, q{void* data}},
		{q{void}, q{g_node_destroy}, q{GNode* root}},
		{q{void}, q{g_node_unlink}, q{GNode* node}},
		{q{GNode*}, q{g_node_copy_deep}, q{GNode* node, GCopyFunc copyFunc, void* data}},
		{q{GNode*}, q{g_node_copy}, q{GNode* node}},
		{q{GNode*}, q{g_node_insert}, q{GNode* parent, int position, GNode* node}},
		{q{GNode*}, q{g_node_insert_before}, q{GNode* parent, GNode* sibling, GNode* node}},
		{q{GNode*}, q{g_node_insert_after}, q{GNode* parent, GNode* sibling, GNode* node}},
		{q{GNode*}, q{g_node_prepend}, q{GNode* parent, GNode* node}},
		{q{uint}, q{g_node_n_nodes}, q{GNode* root, GTraverseFlags flags}},
		{q{GNode*}, q{g_node_get_root}, q{GNode* node}},
		{q{gboolean}, q{g_node_is_ancestor}, q{GNode* node, GNode* descendant}},
		{q{uint}, q{g_node_depth}, q{GNode* node}},
		{q{GNode*}, q{g_node_find}, q{GNode* root, GTraverseType order, GTraverseFlags flags, void* data}},
		{q{void}, q{g_node_traverse}, q{GNode* root, GTraverseType order, GTraverseFlags flags, int maxDepth, GNodeTraverseFunc func, void* data}},
		{q{uint}, q{g_node_max_height}, q{GNode* root}},
		{q{void}, q{g_node_children_foreach}, q{GNode* node, GTraverseFlags flags, GNodeForeachFunc func, void* data}},
		{q{void}, q{g_node_reverse_children}, q{GNode* node}},
		{q{uint}, q{g_node_n_children}, q{GNode* node}},
		{q{GNode*}, q{g_node_nth_child}, q{GNode* node, uint n}},
		{q{GNode*}, q{g_node_last_child}, q{GNode* node}},
		{q{GNode*}, q{g_node_find_child}, q{GNode* node, GTraverseFlags flags, void* data}},
		{q{int}, q{g_node_child_position}, q{GNode* node, GNode* child}},
		{q{int}, q{g_node_child_index}, q{GNode* node, void* data}},
		{q{GNode*}, q{g_node_first_sibling}, q{GNode* node}},
		{q{GNode*}, q{g_node_last_sibling}, q{GNode* node}},
	];
	return ret;
}()));
