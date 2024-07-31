/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.hmac;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.checksum;
import glib.types;

struct GHmac;

mixin(joinFnBinds((){
	FnBind[] ret;
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{GHmac*}, q{g_hmac_new}, q{GChecksumType  digestType, const(ubyte)* key, size_t keyLen}},
			{q{GHmac*}, q{g_hmac_copy}, q{const(GHmac)* hmac}},
			{q{GHmac*}, q{g_hmac_ref}, q{GHmac* hmac}},
			{q{void}, q{g_hmac_unref}, q{GHmac* hmac}},
			{q{void}, q{g_hmac_update}, q{GHmac* hmac, const(ubyte)* data, ptrdiff_t length}},
			{q{const(char)*}, q{g_hmac_get_string}, q{GHmac* hmac}},
			{q{void}, q{g_hmac_get_digest}, q{GHmac* hmac, ubyte* buffer, size_t* digestLen}},
			{q{char*}, q{g_compute_hmac_for_data}, q{GChecksumType digestType, const(ubyte)* key, size_t keyLen, const(ubyte)* data, size_t length}},
			{q{char*}, q{g_compute_hmac_for_string}, q{GChecksumType digestType, const(ubyte)* key, size_t keyLen, const(char)* str, ptrdiff_t length}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,50,0)){
		FnBind[] add = [
			{q{char*}, q{g_compute_hmac_for_bytes}, q{GChecksumType digestType, GBytes* key, GBytes* data}},
		];
		ret ~= add;
	}
	return ret;
}()));
