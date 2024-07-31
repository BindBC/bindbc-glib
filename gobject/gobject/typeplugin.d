/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.typeplugin;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.type;

pragma(inline,true) nothrow @nogc{
	GTypePlugin* G_TYPE_PLUGIN(T)(T* inst) =>
		G_TYPE_CHECK_INSTANCE_CAST!GTypePlugin(cast(GTypeInstance*)inst, G_TYPE_TYPE_PLUGIN);
	GTypePluginClass* G_TYPE_PLUGIN_CLASS(T)(T* vTable) =>
		G_TYPE_CHECK_CLASS_CAST!GTypePluginClass(cast(GTypeClass*)vTable, G_TYPE_TYPE_PLUGIN);
	bool G_IS_TYPE_PLUGIN(T)(T* inst) =>
		G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)inst, G_TYPE_TYPE_PLUGIN);
	bool G_IS_TYPE_PLUGIN_CLASS(T)(T* vTable) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)vTable, G_TYPE_TYPE_PLUGIN);
	GTypePluginClass* G_TYPE_PLUGIN_GET_CLASS(GTypePlugin* inst) =>
		G_TYPE_INSTANCE_GET_INTERFACE!GTypePluginClass(cast(GTypeInstance*)inst, G_TYPE_TYPE_PLUGIN);
}

struct GTypePlugin;

extern(C) nothrow{
	alias GTypePluginUse = void function(GTypePlugin* plugin);
	alias GTypePluginUnuse = void function(GTypePlugin* plugin);
	alias GTypePluginCompleteTypeInfo = void function(GTypePlugin* plugin, GType gType, GTypeInfo* info, GTypeValueTable* valueTable);
	alias GTypePluginCompleteInterfaceInfo = void function(GTypePlugin* plugin, GType instanceType, GType interfaceType, GInterfaceInfo* info);
}

struct GTypePluginClass{
	GTypeInterface baseIFace;
	alias base_iface = baseIFace;
	
	GTypePluginUse usePlugin;
	GTypePluginUnuse unusePlugin;
	GTypePluginCompleteTypeInfo completeTypeInfo;
	GTypePluginCompleteInterfaceInfo completeInterfaceInfo;
	alias use_plugin = usePlugin;
	alias unuse_plugin = unusePlugin;
	alias complete_type_info = completeTypeInfo;
	alias complete_interface_info = completeInterfaceInfo;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{g_type_plugin_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_TYPE_PLUGIN}]},
		{q{void}, q{g_type_plugin_use}, q{GTypePlugin* plugin}},
		{q{void}, q{g_type_plugin_unuse}, q{GTypePlugin* plugin}},
		{q{void}, q{g_type_plugin_complete_type_info}, q{GTypePlugin* plugin, GType gType, GTypeInfo* info, GTypeValueTable* valueTable}},
		{q{void}, q{g_type_plugin_complete_interface_info}, q{GTypePlugin* plugin, GType instanceType, GType interfaceType, GInterfaceInfo* info}},
	];
	return ret;
}()));
