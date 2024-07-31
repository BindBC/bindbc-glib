/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.refstring;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.macros;
import glib.mem;

static if(glibVersion >= Version(2,16,0))
alias GRefString = char;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{char*}, q{g_ref_string_new}, q{const(char)* str}},
			{q{char*}, q{g_ref_string_new_len}, q{const(char)* str, ptrdiff_t len}},
			{q{char*}, q{g_ref_string_new_intern}, q{const(char)* str}},
			{q{char*}, q{g_ref_string_acquire}, q{char* str}},
			{q{void}, q{g_ref_string_release}, q{char* str}},
			{q{size_t}, q{g_ref_string_length}, q{char* str}},
		];
		ret ~= add;
	}
	return ret;
}()));
