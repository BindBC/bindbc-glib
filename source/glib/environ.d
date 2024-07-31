/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.environ;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{const(char)*}, q{g_getenv}, q{const(char)* variable}},
		{q{gboolean}, q{g_setenv}, q{const(char)* variable, const(char)* value, gboolean overwrite}},
		{q{void}, q{g_unsetenv}, q{const(char)* variable}},
		{q{char**}, q{g_listenv}, q{}},
		{q{char**}, q{g_get_environ}, q{}},
		{q{const(char)*}, q{g_environ_getenv}, q{char** envP, const(char)* variable}},
		{q{char**}, q{g_environ_setenv}, q{char** envP, const(char)* variable, const(char)* value, gboolean overwrite}},
		{q{char**}, q{g_environ_unsetenv}, q{char** envP, const(char)* variable}},
	];
	return ret;
}()));
