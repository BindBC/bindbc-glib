/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.checksum;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.types;

mixin(makeEnumBind(q{GChecksumType}, members: (){
	EnumMember[] ret = [
		{{q{md5},     q{G_CHECKSUM_MD5}}},
		{{q{sha1},    q{G_CHECKSUM_SHA1}}},
		{{q{sha256},  q{G_CHECKSUM_SHA256}}},
		{{q{sha512},  q{G_CHECKSUM_SHA512}}},
		{{q{sha384},  q{G_CHECKSUM_SHA384}}},
	];
	return ret;
}()));

struct GChecksum;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{ptrdiff_t}, q{g_checksum_type_get_length}, q{GChecksumType checksumType}},
		{q{GChecksum*}, q{g_checksum_new}, q{GChecksumType checksumType}},
		{q{void}, q{g_checksum_reset}, q{GChecksum* checksum}},
		{q{GChecksum*}, q{g_checksum_copy}, q{const(GChecksum)* checksum}},
		{q{void}, q{g_checksum_free}, q{GChecksum* checksum}},
		{q{void}, q{g_checksum_update}, q{GChecksum* checksum, const(ubyte)* data, ptrdiff_t length}},
		{q{const(char)*}, q{g_checksum_get_string}, q{GChecksum* checksum}},
		{q{void}, q{g_checksum_get_digest}, q{GChecksum* checksum, ubyte* buffer, size_t* digestLen}},
		{q{char*}, q{g_compute_checksum_for_data}, q{GChecksumType checksumType, const(ubyte)* data, size_t length}},
		{q{char*}, q{g_compute_checksum_for_string}, q{GChecksumType checksumType, const(char)* str, ptrdiff_t length}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{char*}, q{g_compute_checksum_for_bytes}, q{GChecksumType checksumType, GBytes* data}},
		];
		ret ~= add;
	}
	return ret;
}()));
