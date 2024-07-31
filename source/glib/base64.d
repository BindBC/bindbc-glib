/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.base64;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{size_t}, q{g_base64_encode_step}, q{const(ubyte)* in_, size_t len, gboolean breakLines, char* out_, int* state, int* save}},
		{q{size_t}, q{g_base64_encode_close}, q{gboolean breakLines, char* out_, int* state, int* save}},
		{q{char*}, q{g_base64_encode}, q{const(ubyte)* data, size_t len}},
		{q{size_t}, q{g_base64_decode_step}, q{const(char)* in_, size_t len, ubyte* out_, int* state, uint* save}},
		{q{ubyte*}, q{g_base64_decode}, q{const(char)* text, size_t* outLen}},
		{q{ubyte*}, q{g_base64_decode_inplace}, q{char* text, size_t* outLen}},
	];
	return ret;
}()));
