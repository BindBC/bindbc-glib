/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.tree;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.node;
import glib.types;

struct GTree;

static if(glibVersion >= Version(2,68,0))
struct GTreeNode;

extern(C) nothrow{
	alias GTraverseFunc = gboolean function(void* key, void* value, void* data);
	static if(glibVersion >= Version(2,68,0))
	alias GTraverseNodeFunc = gboolean function(GTreeNode* node, void* data);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GTree*}, q{g_tree_new}, q{GCompareFunc keyCompareFunc}},
		{q{GTree*}, q{g_tree_new_with_data}, q{GCompareDataFunc keyCompareFunc, void* keyCompareData}},
		{q{GTree*}, q{g_tree_new_full}, q{GCompareDataFunc keyCompareFunc, void* keyCompareData, GDestroyNotify keyDestroyFunc, GDestroyNotify valueDestroyFunc}},
		{q{GTree*}, q{g_tree_ref}, q{GTree* tree}},
		{q{void}, q{g_tree_unref}, q{GTree* tree}},
		{q{void}, q{g_tree_destroy}, q{GTree* tree}},
		{q{void}, q{g_tree_insert}, q{GTree* tree, void* key, void* value}},
		{q{void}, q{g_tree_replace}, q{GTree* tree, void* key, void* value}},
		{q{gboolean}, q{g_tree_remove}, q{GTree* tree, const(void)* key}},
		{q{gboolean}, q{g_tree_steal}, q{GTree* tree, const(void)* key}},
		{q{void*}, q{g_tree_lookup}, q{GTree* tree, const(void)* key}},
		{q{gboolean}, q{g_tree_lookup_extended}, q{GTree* tree, const(void)* lookupKey, void** origKey, void** value}},
		{q{void}, q{g_tree_foreach}, q{GTree* tree, GTraverseFunc func, void* userData}},
		{q{void*}, q{g_tree_search}, q{GTree* tree, GCompareFunc searchFunc, const(void)* userData}},
		{q{int}, q{g_tree_height}, q{GTree* tree}},
		{q{int}, q{g_tree_nnodes}, q{GTree* tree}},
	];
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{GTreeNode*}, q{g_tree_node_first}, q{GTree* tree}},
			{q{GTreeNode*}, q{g_tree_node_last}, q{GTree* tree}},
			{q{GTreeNode*}, q{g_tree_node_previous}, q{GTreeNode* node}},
			{q{GTreeNode*}, q{g_tree_node_next}, q{GTreeNode* node}},
			{q{GTreeNode*}, q{g_tree_insert_node}, q{GTree* tree, void* key, void* value}},
			{q{GTreeNode*}, q{g_tree_replace_node}, q{GTree* tree, void* key, void* value}},
			{q{void*}, q{g_tree_node_key}, q{GTreeNode* node}},
			{q{void*}, q{g_tree_node_value}, q{GTreeNode* node}},
			{q{GTreeNode*}, q{g_tree_lookup_node}, q{GTree* tree, const(void)* key}},
			{q{void}, q{g_tree_foreach_node}, q{GTree* tree, GTraverseNodeFunc func, void* userData}},
			{q{GTreeNode*}, q{g_tree_search_node}, q{GTree* tree, GCompareFunc searchFunc, const(void)* userData}},
			{q{GTreeNode*}, q{g_tree_lower_bound}, q{GTree* tree, const(void)* key}},
			{q{GTreeNode*}, q{g_tree_upper_bound}, q{GTree* tree, const(void)* key}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{void}, q{g_tree_remove_all}, q{GTree* tree}},
		];
		ret ~= add;
	}
	return ret;
}()));
