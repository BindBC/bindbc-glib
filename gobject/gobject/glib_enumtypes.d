/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.glib_enumtypes;

import bindbc.glib.config;
import bindbc.glib.codegen;

import gobject.type;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,60,0)){
		FnBind[] add = [
			{q{GType}, q{g_unicode_type_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_UNICODE_TYPE}]},
			{q{GType}, q{g_unicode_break_type_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_UNICODE_BREAK_TYPE}]},
			{q{GType}, q{g_unicode_script_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_UNICODE_SCRIPT}]},
			{q{GType}, q{g_normalize_mode_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_NORMALIZE_MODE}]},
		];
		ret ~= add;
	}
	return ret;
}()));
