/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.bindinggroup;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.binding;
import gobject.closure;
import gobject.object;
import gobject.type;

pragma(inline,true) nothrow @nogc{
	GBindingGroup* G_BINDING_GROUP(T)(T* obj) =>
		G_TYPE_CHECK_INSTANCE_CAST!GBindingGroup(cast(GTypeInstance*)obj, G_TYPE_BINDING_GROUP);
	
	bool G_IS_BINDING_GROUP(T)(T* obj) =>
		G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)obj, G_TYPE_BINDING_GROUP);
}

struct GBindingGroup;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{GType}, q{g_binding_group_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_BINDING_GROUP}]},
			{q{GBindingGroup*}, q{g_binding_group_new}, q{}},
			{q{void*}, q{g_binding_group_dup_source}, q{GBindingGroup* self}},
			{q{void}, q{g_binding_group_set_source}, q{GBindingGroup* self, void* source}},
			{q{void}, q{g_binding_group_bind}, q{GBindingGroup* self, const(char)* sourceProperty, void* target, const(char)* targetProperty, GBindingFlags flags}},
			{q{void}, q{g_binding_group_bind_full}, q{GBindingGroup* self, const(char)* sourceProperty, void* target, const(char)* targetProperty, GBindingFlags flags, GBindingTransformFunc transformTo, GBindingTransformFunc transformFrom, void* userData, GDestroyNotify userDataDestroy}},
			{q{void}, q{g_binding_group_bind_with_closures}, q{GBindingGroup* self, const(char)* sourceProperty, void* target, const(char)* targetProperty, GBindingFlags flags, GClosure* transformTo, GClosure* transformFrom}},
		];
		ret ~= add;
	}
	return ret;
}()));
