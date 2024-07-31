/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.typemodule;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.enums;
import gobject.object;
import gobject.type;

pragma(inline,true) nothrow @nogc{
	GTypeModule* G_TYPE_MODULE(T)(T* module_) =>
		G_TYPE_CHECK_INSTANCE_CAST!GTypeModule(cast(GTypeInstance*)module_, G_TYPE_TYPE_MODULE);
	
	GTypeModuleClass* G_TYPE_MODULE_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_CAST!GTypeModuleClass(cast(GTypeClass*)class_, G_TYPE_TYPE_MODULE);
	
	bool G_IS_TYPE_MODULE(T)(T* module_) =>
		G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)module_, G_TYPE_TYPE_MODULE);
	
	bool G_IS_TYPE_MODULE_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)class_, G_TYPE_TYPE_MODULE);
	
	GTypeModuleClass* G_TYPE_MODULE_GET_CLASS(GTypeModule* module_) =>
		G_TYPE_INSTANCE_GET_CLASS!GTypeModuleClass(cast(GTypeInstance*)module_, G_TYPE_TYPE_MODULE);
}

mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC(q{GTypeModule}, q{g_object_unref}));

struct GTypeModule{
	GObject parentInstance;
	alias parent_instance = parentInstance;
	
	uint useCount;
	GSList* typeInfos;
	GSList* interfaceInfos;
	alias use_count = useCount;
	alias type_infos = typeInfos;
	alias interface_infos = interfaceInfos;
	
	char* name;
}

struct GTypeModuleClass{
	GObjectClass parentClass;
	alias parent_class = parentClass;
	
	extern(C) nothrow{
		alias LoadFn = gboolean function(GTypeModule* module_);
		alias UnLoadFn = void function(GTypeModule* module_);
		alias ReservedFn = void function();
	}
	LoadFn load;
	UnLoadFn unload;
	
	ReservedFn reserved1;
	ReservedFn reserved2;
	ReservedFn reserved3;
	ReservedFn reserved4;
}

//Since: 2.14
enum G_DEFINE_DYNAMIC_TYPE = (string TN, string t_n, string T_P) =>
	G_DEFINE_DYNAMIC_TYPE_EXTENDED(TN, t_n, T_P, q{0}, q{});

//Since: 2.14
enum G_DEFINE_DYNAMIC_TYPE_EXTENDED = (string TypeName, string type_name, string TYPE_PARENT, string flags, string CODE) => "
private{
	static void* "~type_name~"_parent_class = null;
	static GType "~type_name~"_type_id = 0;
	static int "~TypeName~"_private_offset;
}
"~_G_DEFINE_TYPE_EXTENDED_CLASS_INIT(TypeName, type_name)~"

private(inline,true) private extern(C) void* "~type_name~"_get_instance_private(TypeName* self){
	return G_STRUCT_MEMBER_P(self, "~TypeName~"_private_offset);
}

extern(C) GType "~type_name~"_get_type(){
	return "~type_name~"_type_id;
}
private extern(C) void "~type_name~"_register_type(GTypeModule* type_module){
	GType g_define_type_id;
	const g_define_type_info = GTypeInfo(
		"~TypeName~"Class.sizeof),
		cast(GBaseInitFunc)null,
		cast(GBaseFinaliseFunc)null,
		cast(GClassInitFunc)&"~type_name~"_class_intern_init,
		cast(GClassFinalizeFunc)&"~type_name~"_class_finalize,
		null, "~TypeName~".sizeof, 0, cast(GInstanceInitFunc)&"~type_name~"_init, null,
	);
	"~type_name~"_type_id = g_type_module_register_type(
		type_module, `"~TYPE_PARENT~"`, `"~TypeName~"`,
		&g_define_type_info, cast(GTypeFlags)flags,
	);
	g_define_type_id = "~type_name~"_type_id;
	{"~CODE~"
	}
}";

//Since: 2.24
enum G_IMPLEMENT_INTERFACE_DYNAMIC = (string TYPE_IFACE, string iface_init) => "
		const g_implement_interface_info = GInterfaceInfo(
			cast(GInterfaceInitFunc)&"~iface_init~", null, null,
		};
		g_type_module_add_interface(type_module, g_define_type_id, "~TYPE_IFACE~", &g_implement_interface_info);";

//Since: 2.38
enum G_ADD_PRIVATE_DYNAMIC = (string TypeName) => "
		"~TypeName~"_private_offset = "~TypeName~"Private.sizeof;";

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{g_type_module_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_TYPE_MODULE}]},
		{q{gboolean}, q{g_type_module_use}, q{GTypeModule* module_}},
		{q{void}, q{g_type_module_unuse}, q{GTypeModule* module_}},
		{q{void}, q{g_type_module_set_name}, q{GTypeModule* module_, const(char)* name}},
		{q{GType}, q{g_type_module_register_type}, q{GTypeModule* module_, GType parentType, const(char)* typeName, const(GTypeInfo)* typeInfo, GTypeFlags flags}},
		{q{void}, q{g_type_module_add_interface}, q{GTypeModule* module_, GType instanceType, GType interfaceType, const(GInterfaceInfo)* interfaceInfo}},
		{q{GType}, q{g_type_module_register_enum}, q{GTypeModule* module_, const(char)* name, const(GEnumValue)* constStaticValues}},
		{q{GType}, q{g_type_module_register_flags}, q{GTypeModule* module_, const(char)* name, const(GFlagsValue)* constStaticValues}},
	];
	return ret;
}()));
