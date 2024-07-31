/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.valuetypes;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.value;
import gobject.type;

pragma(inline,true) nothrow @nogc{
	bool G_VALUE_HOLDS_CHAR(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_CHAR);
	
	bool G_VALUE_HOLDS_UCHAR(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_UCHAR);
	
	bool G_VALUE_HOLDS_BOOLEAN(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_BOOLEAN);
	
	bool G_VALUE_HOLDS_INT(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_INT);
	
	bool G_VALUE_HOLDS_UINT(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_UINT);
	
	bool G_VALUE_HOLDS_LONG(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_LONG);
	
	bool G_VALUE_HOLDS_ULONG(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_ULONG);
	
	bool G_VALUE_HOLDS_INT64(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_INT64);
	
	bool G_VALUE_HOLDS_UINT64(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_UINT64);
	
	bool G_VALUE_HOLDS_FLOAT(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_FLOAT);
	
	bool G_VALUE_HOLDS_DOUBLE(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_DOUBLE);
	
	bool G_VALUE_HOLDS_STRING(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_STRING);
	
	static if(glibVersion > Version(2,66,0))
	bool G_VALUE_IS_INTERNED_STRING(GValue* value) =>
		G_VALUE_HOLDS_STRING(value) && (value.data[1].vUInt & G_VALUE_INTERNED_STRING);

	bool G_VALUE_HOLDS_POINTER(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_POINTER);
	
	bool G_VALUE_HOLDS_GTYPE(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_GTYPE);
	
	static if(glibVersion >= Version(2,26,0))
	bool G_VALUE_HOLDS_VARIANT(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_VARIANT);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{g_value_set_schar}, q{GValue* value, byte vChar}},
		{q{byte}, q{g_value_get_schar}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_uchar}, q{GValue* value, ubyte vUChar}},
		{q{ubyte}, q{g_value_get_uchar}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_boolean}, q{GValue* value, gboolean vBoolean}},
		{q{gboolean}, q{g_value_get_boolean}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_int}, q{GValue* value, int vInt}},
		{q{int}, q{g_value_get_int}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_uint}, q{GValue* value, uint vUInt}},
		{q{uint}, q{g_value_get_uint}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_long}, q{GValue* value, c_long vLong}},
		{q{c_long}, q{g_value_get_long}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_ulong}, q{GValue* value, c_ulong vULong}},
		{q{c_ulong}, q{g_value_get_ulong}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_int64}, q{GValue* value, long vInt64}},
		{q{long}, q{g_value_get_int64}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_uint64}, q{GValue* value, ulong vUInt64}},
		{q{ulong}, q{g_value_get_uint64}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_float}, q{GValue* value, float vFloat}},
		{q{float}, q{g_value_get_float}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_double}, q{GValue* value, double vDouble}},
		{q{double}, q{g_value_get_double}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_string}, q{GValue* value, const(char)* vString}},
		{q{void}, q{g_value_set_static_string}, q{GValue* value, const(char)* vString}},
		{q{const(char)*}, q{g_value_get_string}, q{const(GValue)* value}},
		{q{char*}, q{g_value_dup_string}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_pointer}, q{GValue* value, void* vPointer}},
		{q{void*}, q{g_value_get_pointer}, q{const(GValue)* value}},
		{q{GType}, q{g_gtype_get_type}, q{}, aliases: [q{G_TYPE_GTYPE}]},
		{q{void}, q{g_value_set_gtype}, q{GValue* value, GType vGType}},
		{q{GType}, q{g_value_get_gtype}, q{const(GValue)* value}},
		{q{void}, q{g_value_set_variant}, q{GValue* value, GVariant* variant}},
		{q{void}, q{g_value_take_variant}, q{GValue* value, GVariant* variant}},
		{q{GVariant*}, q{g_value_get_variant}, q{const(GValue)* value}},
		{q{GVariant*}, q{g_value_dup_variant}, q{const(GValue)* value}},
		{q{GType}, q{g_pointer_type_register_static}, q{const(char)* name}},
		{q{char*}, q{g_strdup_value_contents}, q{const(GValue)* value}},
		{q{void}, q{g_value_take_string}, q{GValue* value, char* vString}},
	];
	if(glibVersion >= Version(2,66,0)){
		FnBind[] add = [
			{q{void}, q{g_value_set_interned_string}, q{GValue* value, const(char)* vString}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,80,0)){
		FnBind[] add = [
			{q{char*}, q{g_value_steal_string}, q{GValue* value}},
		];
		ret ~= add;
	}
	return ret;
}()));
