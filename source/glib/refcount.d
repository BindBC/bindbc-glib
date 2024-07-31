/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.refcount;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{void}, q{g_ref_count_init}, q{grefcount* rc}},
			{q{void}, q{g_ref_count_inc}, q{grefcount* rc}},
			{q{gboolean}, q{g_ref_count_dec}, q{grefcount* rc}},
			{q{gboolean}, q{g_ref_count_compare}, q{grefcount* rc, int val}},
			{q{void}, q{g_atomic_ref_count_init}, q{gatomicrefcount* arc}},
			{q{void}, q{g_atomic_ref_count_inc}, q{gatomicrefcount* arc}},
			{q{gboolean}, q{g_atomic_ref_count_dec}, q{gatomicrefcount* arc}},
			{q{gboolean}, q{g_atomic_ref_count_compare}, q{gatomicrefcount* arc, int val}},
		];
		ret ~= add;
	}
	return ret;
}()));

enum G_REF_COUNT_INIT = -1;

enum G_ATOMIC_REF_COUNT_INIT = 1;
