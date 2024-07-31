/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.boxed;

import bindbc.glib.config;
import bindbc.glib.codegen;

import gobject.glib_types;
import gobject.type;
import gobject.value;

pragma(inline,true) nothrow @nogc{
	bool G_TYPE_IS_BOXED(GType type) =>
		G_TYPE_FUNDAMENTAL(type) == G_TYPE_BOXED;
	
	bool G_VALUE_HOLDS_BOXED(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_BOXED);
}

extern(C) nothrow{
	alias GBoxedCopyFunc = void* function(void* boxed);
	alias GBoxedFreeFunc = void function(void* boxed);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void*}, q{g_boxed_copy}, q{GType boxedType, const(void)* srcBoxed}},
		{q{void}, q{g_boxed_free}, q{GType boxedType, void* boxed}},
		{q{void}, q{g_value_set_boxed}, q{GValue* value, const(void)* vBoxed}},
		{q{void}, q{g_value_set_static_boxed}, q{GValue* value, const(void)* vBoxed}},
		{q{void}, q{g_value_take_boxed}, q{GValue* value, const(void)* vBoxed}},
		{q{void*}, q{g_value_get_boxed}, q{const(GValue)* value}},
		{q{void*}, q{g_value_dup_boxed}, q{const(GValue)* value}},
		{q{GType}, q{g_boxed_type_register_static}, q{const(char)* name, GBoxedCopyFunc boxedCopy, GBoxedFreeFunc boxedFree}},
		{q{GType}, q{g_closure_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_CLOSURE}]},
		{q{GType}, q{g_value_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_VALUE}]},
	];
	return ret;
}()));
