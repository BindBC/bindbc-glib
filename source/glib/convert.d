/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.convert;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.quark;
import glib.types;

mixin(makeEnumBind(q{GConvertError}, members: (){
	EnumMember[] ret = [
		{{q{noConversion},     q{G_CONVERT_ERROR_NO_CONVERSION}}},
		{{q{illegalSequence},  q{G_CONVERT_ERROR_ILLEGAL_SEQUENCE}}},
		{{q{failed},           q{G_CONVERT_ERROR_FAILED}}},
		{{q{partialInput},     q{G_CONVERT_ERROR_PARTIAL_INPUT}}},
		{{q{badURI},           q{G_CONVERT_ERROR_BAD_URI}}},
		{{q{notAbsolutePath},  q{G_CONVERT_ERROR_NOT_ABSOLUTE_PATH}}},
	];
	if(glibVersion >= Version(2,40,0)){
		EnumMember[] add = [
			{{q{noMemory},     q{G_CONVERT_ERROR_NO_MEMORY}}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,56,0)){
		EnumMember[] add = [
			{{q{embeddedNul},  q{G_CONVERT_ERROR_EMBEDDED_NUL}}},
		];
		ret ~= add;
	}
	return ret;
}()));

struct _GIConv;
alias GIConv = _GIConv*;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_convert_error_quark}, q{}, aliases: [q{G_CONVERT_ERROR}]},
		{q{GIConv}, q{g_iconv_open}, q{const(char)* toCodeset, const(char)* fromCodeset}},
		{q{size_t}, q{g_iconv}, q{GIConv converter, char** inBuf, size_t* inBytesLeft, char** outBuf, size_t* outBytesLeft}},
		{q{int}, q{g_iconv_close}, q{GIConv converter}},
		{q{char*}, q{g_convert}, q{const(char)* str, ptrdiff_t len, const(char)* toCodeset, const(char)* fromCodeset, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_convert_with_iconv}, q{const(char)* str, ptrdiff_t len, GIConv converter, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_convert_with_fallback}, q{const(char)* str, ptrdiff_t len, const(char)* toCodeset, const(char)* fromCodeset, const(char)* fallback, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_locale_to_utf8}, q{const(char)* opSysString, ptrdiff_t len, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_locale_from_utf8}, q{const(char)* utf8string, ptrdiff_t len, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_filename_to_utf8}, q{const(char)* opSysString, ptrdiff_t len, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_filename_from_utf8}, q{const(char)* utf8String, ptrdiff_t len, size_t* bytesRead, size_t* bytesWritten, GError** error}},
		{q{char*}, q{g_filename_from_uri}, q{const(char)* uri, char** hostName, GError** error}},
		{q{char*}, q{g_filename_to_uri}, q{const(char)* filename, const(char)* hostname, GError** error}},
		{q{char*}, q{g_filename_display_name}, q{const(char)* filename}},
		{q{gboolean}, q{g_get_filename_charsets}, q{const(char)*** filenameCharsets}},
		{q{char*}, q{g_filename_display_basename}, q{const(char)* filename}},
		{q{char**}, q{g_uri_list_extract_uris}, q{const(char)* uriList}},
	];
	return ret;
}()));
