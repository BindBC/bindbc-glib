/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.value;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.type;

pragma(inline,true) nothrow @nogc{
	bool G_TYPE_IS_VALUE(GType type) =>
		g_type_check_is_value_type(type) != 0;
	
	bool G_IS_VALUE(T)(T* value) =>
		G_TYPE_CHECK_VALUE(value);
	
	GType G_VALUE_TYPE(GValue* value) =>
		value.gType;
	
	const(char)* G_VALUE_TYPE_NAME(GValue* value) =>
		g_type_name(G_VALUE_TYPE(value));
	
	bool G_VALUE_HOLDS(GValue* value, GType type) =>
		G_TYPE_CHECK_VALUE_TYPE(value, type);
}

extern(C) nothrow alias GValueTransform = void function(const(GValue)* srcValue, GValue* destValue);

struct GValue{
	GType gType;
	alias g_type = gType;
	
	union _Data{
		int vInt;
		uint vUInt;
		c_long vLong;
		c_ulong vULong;
		long vInt64;
		ulong vUInt64;
		float vFloat;
		double vDouble;
		void* vPointer;
		alias v_int = vInt;
		alias v_uint = vUInt;
		alias v_long = vLong;
		alias v_ulong = vULong;
		alias v_int64 = vInt64;
		alias v_uint64 = vUInt64;
		alias v_float = vFloat;
		alias v_double = vDouble;
		alias v_pointer = vPointer;
	}
	_Data[2] data;
}

enum G_VALUE_NOCOPY_CONTENTS = 1 << 27;

static if(glibVersion > Version(2,66,0))
enum G_VALUE_INTERNED_STRING = 1 << 28;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GValue*}, q{g_value_init}, q{GValue* value, GType gType}},
		{q{void}, q{g_value_copy}, q{const(GValue)* srcValue, GValue* destValue}},
		{q{GValue*}, q{g_value_reset}, q{GValue* value}},
		{q{void}, q{g_value_unset}, q{GValue* value}},
		{q{void}, q{g_value_set_instance}, q{GValue* value, void* instance}},
		{q{gboolean}, q{g_value_fits_pointer}, q{const(GValue)* value}},
		{q{void*}, q{g_value_peek_pointer}, q{const(GValue)* value}},
		{q{gboolean}, q{g_value_type_compatible}, q{GType srcType, GType destType}},
		{q{gboolean}, q{g_value_type_transformable}, q{GType srcType, GType destType}},
		{q{gboolean}, q{g_value_transform}, q{const(GValue)* srcValue, GValue* destValue}},
		{q{void}, q{g_value_register_transform_func}, q{GType srcType, GType destType, GValueTransform transformFunc}},
	];
	if(glibVersion >= Version(2,42,0)){
		FnBind[] add = [
			{q{void}, q{g_value_init_from_instance}, q{GValue* value, void* instance}},
		];
		ret ~= add;
	}
	return ret;
}()));
