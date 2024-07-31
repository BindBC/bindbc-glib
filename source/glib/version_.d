/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.version_;

import bindbc.glib.config;
import bindbc.glib.codegen;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{const(char)*}, q{glib_check_version}, q{uint requiredMajor, uint requiredMinor, uint requiredMicro}},
	];
	return ret;
}()));
