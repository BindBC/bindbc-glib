/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.charset;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{gboolean}, q{g_get_charset}, q{const(char)** charset}},
		{q{char*}, q{g_get_codeset}, q{}},
		{q{const(char*)*}, q{g_get_language_names}, q{}},
		{q{char**}, q{g_get_locale_variants}, q{const(char)* locale}},
	];
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{const(char*)*}, q{g_get_language_names_with_category}, q{const(char)* categoryName}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,62,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_get_console_charset}, q{const(char)** charset}},
		];
		ret ~= add;
	}
	return ret;
}()));
