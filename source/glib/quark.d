/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.quark;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

alias GQuark = uint;

enum G_DEFINE_QUARK = (string QN, string q_n) => "
extern(C) GQuark "~q_n~"_quark() nothrow @nogc{
	static GQuark q = 0;
	if(q == 0){
		q = g_quark_from_static_string("~QN~");
	}
	return q;
}";

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_quark_try_string}, q{const(char)* string}},
		{q{GQuark}, q{g_quark_from_static_string}, q{const(char)* string}},
		{q{GQuark}, q{g_quark_from_string}, q{const(char)* string}},
		{q{const(char)*}, q{g_quark_to_string}, q{GQuark quark}, attr: q{pure}},
		{q{const(char)*}, q{g_intern_string}, q{const(char)* string}},
		{q{const(char)*}, q{g_intern_static_string}, q{const(char)* string}},
	];
	return ret;
}()));
