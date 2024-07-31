/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.signalgroup;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.closure;
import gobject.object;
import gobject.signal;
import gobject.type;

pragma(inline,true) nothrow @nogc{
	GSignalGroup* G_SIGNAL_GROUP(T)(T* obj) =>
		G_TYPE_CHECK_INSTANCE_CAST!GSignalGroup(cast(GTypeInstance*)obj, G_TYPE_SIGNAL_GROUP);
	
	bool G_IS_SIGNAL_GROUP(T)(T* obj) =>
		G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)obj, G_TYPE_SIGNAL_GROUP);
}

struct GSignalGroup;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{GType}, q{g_signal_group_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_SIGNAL_GROUP}]},
			{q{GSignalGroup*}, q{g_signal_group_new}, q{GType targetType}},
			{q{void}, q{g_signal_group_set_target}, q{GSignalGroup* self, void* target}},
			{q{void*}, q{g_signal_group_dup_target}, q{GSignalGroup* self}},
			{q{void}, q{g_signal_group_block}, q{GSignalGroup* self}},
			{q{void}, q{g_signal_group_unblock}, q{GSignalGroup* self}},
			{q{void}, q{g_signal_group_connect_object}, q{GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* object, GConnectFlags flags}},
			{q{void}, q{g_signal_group_connect_data}, q{GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data, GClosureNotify notify, GConnectFlags flags}},
			{q{void}, q{g_signal_group_connect}, q{GSignalGroup* self, const(char)* detailed_signal, GCallback cHandler, void* data}},
			{q{void}, q{g_signal_group_connect_after}, q{GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data}},
			{q{void}, q{g_signal_group_connect_swapped}, q{GSignalGroup* self, const(char)* detailedSignal, GCallback cHandler, void* data}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		FnBind[] add = [
			{q{void}, q{g_signal_group_connect_closure}, q{GSignalGroup* self, const(char)* detailedSignal, GClosure* closure, gboolean after}},
		];
		ret ~= add;
	}
	return ret;
}()));

