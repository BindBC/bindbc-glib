/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.binding;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.closure;
import gobject.object;
import gobject.type;
import gobject.value;

pragma(inline,true) nothrow @nogc{
	GBinding* G_BINDING(T)(T* obj) =>
		G_TYPE_CHECK_INSTANCE_CAST!GBinding(cast(GTypeInstance*)obj, G_TYPE_BINDING);
	
	bool G_IS_BINDING(T)(T* obj) =>
		G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)obj, G_TYPE_BINDING);
}

struct GBinding;

alias GBindingTransformFunc = extern(C) gboolean function(GBinding* binding, const(GValue)* fromValue, GValue* toValue, void* userData) nothrow;

mixin(makeEnumBind(q{GBindingFlags}, aliases: [q{GBindingFlag}], members: (){
	EnumMember[] ret = [
		{{q{default_},       q{G_BINDING_DEFAULT}},         q{0}},
		
		{{q{bidirectional},  q{G_BINDING_BIDIRECTIONAL}},   q{1 << 0}},
		{{q{syncCreate},     q{G_BINDING_SYNC_CREATE}},     q{1 << 1}},
		{{q{invertBoolean},  q{G_BINDING_INVERT_BOOLEAN}},  q{1 << 2}},
	];
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{g_binding_flags_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_BINDING_FLAGS}]},
		{q{GType}, q{g_binding_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_BINDING}]},
		{q{GBindingFlags}, q{g_binding_get_flags}, q{GBinding* binding}},
		{q{const(char)*}, q{g_binding_get_source_property}, q{GBinding* binding}},
		{q{const(char)*}, q{g_binding_get_target_property}, q{GBinding* binding}},
		{q{GBinding*}, q{g_object_bind_property}, q{void* source, const(char)* sourceProperty, void* target, const(char)* targetProperty, GBindingFlags flags}},
		{q{GBinding*}, q{g_object_bind_property_full}, q{void* source, const(char)* sourceProperty, void* target, const(char)* targetProperty, GBindingFlags flags, GBindingTransformFunc transformTo, GBindingTransformFunc transformFrom, void* userData, GDestroyNotify notify}},
		{q{GBinding*}, q{g_object_bind_property_with_closures}, q{void* source, const(char)* sourceProperty, void* target, const(char)* targetProperty, GBindingFlags flags, GClosure* transformTo, GClosure* transformFrom}},
	];
	if(glibVersion >= Version(2,38,0)){
		FnBind[] add = [
			{q{void}, q{g_binding_unbind}, q{GBinding* binding}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{GObject*}, q{g_binding_dup_source}, q{GBinding* binding}},
			{q{GObject*}, q{g_binding_dup_target}, q{GBinding* binding}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{GObject*}, q{g_binding_get_source}, q{GBinding* binding}},
			{q{GObject*}, q{g_binding_get_target}, q{GBinding* binding}},
		];
		ret ~= add;
	}
	return ret;
}()));
