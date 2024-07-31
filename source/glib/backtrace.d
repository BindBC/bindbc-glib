/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.backtrace;

import bindbc.glib.config;
import bindbc.glib.codegen;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{g_on_error_query}, q{const(char)* prgName}},
		{q{void}, q{g_on_error_stack_trace}, q{const(char)* prgName}},
	];
	return ret;
}()));
