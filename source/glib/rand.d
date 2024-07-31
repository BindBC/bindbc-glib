/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.rand;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

struct GRand;

pragma(inline,true) bool g_rand_boolean(GRand* rand) nothrow @nogc =>
	(g_rand_int(rand) & (1 << 15)) != 0;

pragma(inline,true) bool g_random_boolean() nothrow @nogc =>
	(g_random_int() & (1 << 15)) != 0;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GRand*}, q{g_rand_new_with_seed}, q{uint seed}},
		{q{GRand*}, q{g_rand_new_with_seed_array}, q{const(uint)* seed, uint seedLength}},
		{q{GRand*}, q{g_rand_new}, q{}},
		{q{void}, q{g_rand_free}, q{GRand* rand}},
		{q{GRand*}, q{g_rand_copy}, q{GRand* rand}},
		{q{void}, q{g_rand_set_seed}, q{GRand* rand, uint seed}},
		{q{void}, q{g_rand_set_seed_array}, q{GRand* rand, const(uint)* seed, uint seedLength}},
		{q{uint}, q{g_rand_int}, q{GRand* rand}},
		{q{int}, q{g_rand_int_range}, q{GRand* rand, int begin, int end}},
		{q{double}, q{g_rand_double}, q{GRand* rand}},
		{q{double}, q{g_rand_double_range}, q{GRand* rand, double begin, double end}},
		{q{void}, q{g_random_set_seed}, q{uint seed}},
		{q{uint}, q{g_random_int}, q{}},
		{q{int}, q{g_random_int_range}, q{int begin, int end}},
		{q{double}, q{g_random_double}, q{}},
		{q{double}, q{g_random_double_range}, q{double begin, double end}},
	];
	return ret;
}()));
