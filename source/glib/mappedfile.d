/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.mappedfile;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.error;
import glib.types;

struct GMappedFile;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GMappedFile*}, q{g_mapped_file_new}, q{const(char)* filename, gboolean writable, GError** error}},
		{q{GMappedFile*}, q{g_mapped_file_new_from_fd}, q{int fd, gboolean writable, GError** error}},
		{q{size_t}, q{g_mapped_file_get_length}, q{GMappedFile* file}},
		{q{char*}, q{g_mapped_file_get_contents}, q{GMappedFile* file}},
		{q{GMappedFile*}, q{g_mapped_file_ref}, q{GMappedFile* file}},
		{q{void}, q{g_mapped_file_unref}, q{GMappedFile* file}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{GBytes*}, q{g_mapped_file_get_bytes}, q{GMappedFile* file}},
		];
		ret ~= add;
	}
	return ret;
}()));

