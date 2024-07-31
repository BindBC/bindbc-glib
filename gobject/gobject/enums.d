/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.enums;

import bindbc.glib.config;
import bindbc.glib.codegen;

import gobject.type;
import gobject.value;

pragma(inline,true) nothrow @nogc{
	bool G_TYPE_IS_ENUM(GType type) =>
		G_TYPE_FUNDAMENTAL(type) == G_TYPE_ENUM;
	
	GEnumClass* G_ENUM_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_CAST!GEnumClass(cast(GTypeClass*)class_, G_TYPE_ENUM);
	
	bool G_IS_ENUM_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)class_, G_TYPE_ENUM);
	
	GType G_ENUM_CLASS_TYPE(GEnumClass* class_) pure @trusted =>
		G_TYPE_FROM_CLASS(cast(GTypeClass*)class_);
	
	const(char)* G_ENUM_CLASS_TYPE_NAME(GEnumClass* class_) =>
		g_type_name(G_ENUM_CLASS_TYPE(class_));
	
	bool G_TYPE_IS_FLAGS(GType type) =>
		G_TYPE_FUNDAMENTAL(type) == G_TYPE_FLAGS;
	
	GFlagsClass* G_FLAGS_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_CAST!GFlagsClass(cast(GTypeClass*)class_, G_TYPE_FLAGS);
	
	bool G_IS_FLAGS_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)class_, G_TYPE_FLAGS);
	
	GType G_FLAGS_CLASS_TYPE(GFlagsClass* class_) pure @trusted =>
		G_TYPE_FROM_CLASS(cast(GTypeClass*)class_);
	
	const(void)* G_FLAGS_CLASS_TYPE_NAME(GFlagsClass* class_) =>
		g_type_name(G_FLAGS_CLASS_TYPE(class_));
		
	bool G_VALUE_HOLDS_ENUM(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_ENUM);
	
	bool G_VALUE_HOLDS_FLAGS(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_FLAGS);
}

struct GEnumClass{
	GTypeClass gTypeClass;
	alias g_type_class = gTypeClass;
	
	int minimum;
	int maximum;
	uint nValues;
	alias n_values = nValues;
	GEnumValue* values;
}

struct GFlagsClass{
	GTypeClass gTypeClass;
	alias g_type_class = gTypeClass;
	
	uint mask;
	uint nValues;
	alias n_values = nValues;
	GFlagsValue* values;
}

struct GEnumValue{
	int value;
	const(char)* valueName;
	const(char)* valueNick;
	alias value_name = valueName;
	alias value_nick = valueNick;
}

struct GFlagsValue{
	uint value;
	const(char)* valueName;
	const(char)* valueNick;
	alias value_name = valueName;
	alias value_nick = valueNick;
}

static if(glibVersion >= Version(2,74,0)){
	enum G_DEFINE_ENUM_VALUE = (string EnumValue, string EnumNick) => "
			{ "~EnumValue~", `"~EnumValue~"`, `"~EnumNick~"` },";
	
	enum G_DEFINE_ENUM_TYPE = (string TypeName, string type_name, string values...){
		string ret = "
extern(C) GType "~type_name~"_get_type() nothrow @nogc{
	static _g_type_once_init_type g_define_type__static = 0;
	if(_g_type_once_init_enter(&g_define_type__static)){
		static const(GEnumValue)* enum_values = [";
		foreach(value; values){
			ret ~= value;
		}
		ret ~= "
			{0, null, null},
		];
		GType g_define_type = g_enum_register_static(g_intern_static_string(`"~TypeName~"`), enum_values);
		_g_type_once_init_leave(&g_define_type__static, g_define_type);
	}
	return g_define_type__static;
}";
		return ret;
	};
	
	enum G_DEFINE_FLAGS_TYPE = (string TypeName, string type_name, string values...){
		string ret = "
GType "~type_name~"_get_type(){
	static _g_type_once_init_type g_define_type__static = 0;
	if (_g_type_once_init_enter (&g_define_type__static)) {
		static const(GFlagsValue_* flags_values = [";
		foreach(value; values){
			ret ~= value;
		}
		ret ~= "
			{0, null, null},
		];
		GType g_define_type = g_flags_register_static(g_intern_static_string(`"~TypeName~"`), flags_values);
		_g_type_once_init_leave (&g_define_type__static, g_define_type);
	}
	return g_define_type__static;
}";
		return ret;
	};
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GEnumValue*}, q{g_enum_get_value}, q{GEnumClass* enumClass, int value}},
		{q{GEnumValue*}, q{g_enum_get_value_by_name}, q{GEnumClass* enumClass, const(char)* name}},
		{q{GEnumValue*}, q{g_enum_get_value_by_nick}, q{GEnumClass* enumClass, const(char)* nick}},
		{q{GFlagsValue*}, q{g_flags_get_first_value}, q{GFlagsClass* flagsClass, uint value}},
		{q{GFlagsValue*}, q{g_flags_get_value_by_name}, q{GFlagsClass* flagsClass, const(char)* name}},
		{q{GFlagsValue*}, q{g_flags_get_value_by_nick}, q{GFlagsClass* flagsClass, const(char)* nick}},
		{q{void}, q{g_value_set_enum}, q{GValue* value, int vEnum}},
		{q{int}, q{g_value_get_enum}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_flags}, q{GValue* value, uint vFlags}},
		{q{uint}, q{g_value_get_flags}, q{const(GValue)* value}},
		{q{GType}, q{g_enum_register_static}, q{const(char)* name, const(GEnumValue)* constStaticValues}},
		{q{GType}, q{g_flags_register_static}, q{const(char)* name, const(GFlagsValue)* constStaticValues}},
		{q{void}, q{g_enum_complete_type_info}, q{GType gEnumType, GTypeInfo* info, const(GEnumValue)* constValues}},
		{q{void}, q{g_flags_complete_type_info}, q{GType gFlagsType, GTypeInfo* info, const(GFlagsValue)* constValues}},
	];
	if(glibVersion >= Version(2,54,0)){
		FnBind[] add = [
			{q{char*}, q{g_enum_to_string}, q{GType gEnumType, int value}},
			{q{char*}, q{g_flags_to_string}, q{GType flagsType, uint value}},
		];
		ret ~= add;
	}
	return ret;
}()));
