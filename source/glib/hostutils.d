/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.hostutils;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{gboolean}, q{g_hostname_is_non_ascii}, q{const(char)* hostName}},
		{q{gboolean}, q{g_hostname_is_ascii_encoded}, q{const(char)* hostName}},
		{q{gboolean}, q{g_hostname_is_ip_address}, q{const(char)* hostName}},
		{q{char*}, q{g_hostname_to_ascii}, q{const(char)* hostName}},
		{q{char*}, q{g_hostname_to_unicode}, q{const(char)* hostName}},
	];
	return ret;
}()));
