/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.dir;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;

struct GDir;

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GDir*}, q{g_dir_open}, q{const(char)* path, uint flags, GError** error}},
			{q{const(char)*}, q{g_dir_read_name}, q{GDir* dir}},
			{q{void}, q{g_dir_rewind}, q{GDir* dir}},
			{q{void}, q{g_dir_close}, q{GDir* dir}},
	];
	if(glibVersion >= Version(2,80,0)){
		FnBind[] add = [
			{q{GDir*}, q{g_dir_ref}, q{GDir* dir}},
			{q{void}, q{g_dir_unref}, q{GDir* dir}},
		];
		ret ~= add;
	}
	return ret;
}()));
