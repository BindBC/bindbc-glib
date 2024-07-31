/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.uuid;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,52,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_uuid_string_is_valid}, q{const(char)* str}},
			{q{char*}, q{g_uuid_string_random}, q{}},
		];
		ret ~= add;
	}
	return ret;
}()));
