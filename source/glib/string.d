/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.string;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.types;
import glib.unicode;
import glib.utils;

import std.algorithm.comparison: min;
import core.stdc.string;

struct GString{
	char* str;
	size_t len;
	size_t allocatedLen;
	alias allocated_len = allocatedLen;
}

pragma(inline,true) nothrow @nogc{
	GString* g_string_append_c_inline(GString* string, char c){
		if(string !is null && string.len + 1 < string.allocatedLen){
			string.str[string.len++] = c;
			string.str[string.len] = '\0';
		}else{
			g_string_insert_c(string, -1, c);
		}
		return string;
	}
	
	GString* g_string_append_len_inline(GString* string, const(char)* val, ptrdiff_t len){
		
		if(string is null)
			return g_string_append_len(string, val, len);
		
		if(val is null)
			return len != 0 ? g_string_append_len(string, val, len) : string;
		
		size_t lenUnsigned = len < 0 ? strlen(val) : cast(size_t)len;
		
		if(string.len + lenUnsigned < string.allocatedLen){
			char* end = string.str + string.len;
			if(val + lenUnsigned <= end || val > end + lenUnsigned)
				memcpy(end, val, lenUnsigned);
			else
				memmove(end, val, lenUnsigned);
			string.len += lenUnsigned;
			string.str[string.len] = 0;
			return string;
		}else{
			return g_string_insert_len(string, -1, val, len);
		}
	}
	
	GString* g_string_truncate_inline(GString* string, size_t len){
		string.len = min(len, string.len);
		string.str[string.len] = '\0';
		return string;
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GString*}, q{g_string_new}, q{const(char)* init}},
		{q{GString*}, q{g_string_new_len}, q{const(char)* init, ptrdiff_t len}},
		{q{GString*}, q{g_string_sized_new}, q{size_t dflSize}},
		{q{char*}, q{g_string_free}, q{GString* string, gboolean freeSegment}},
		{q{gboolean}, q{g_string_equal}, q{const(GString)* v, const(GString)* v2}},
		{q{uint}, q{g_string_hash}, q{const(GString)* string}},
		{q{GString*}, q{g_string_assign}, q{GString* string, const(char)* rVal}},
		{q{GString*}, q{g_string_truncate}, q{GString* string, size_t len}},
		{q{GString*}, q{g_string_set_size}, q{GString* string, size_t len}},
		{q{GString*}, q{g_string_insert_len}, q{GString* string, ptrdiff_t pos, const(char)* val, ptrdiff_t len}},
		{q{GString*}, q{g_string_append}, q{GString* string, const(char)* val}},
		{q{GString*}, q{g_string_append_len}, q{GString* string, const(char)* val, ptrdiff_t len}},
		{q{GString*}, q{g_string_append_c}, q{GString* string, char c}},
		{q{GString*}, q{g_string_append_unichar}, q{GString* string, dchar wc}},
		{q{GString*}, q{g_string_prepend}, q{GString* string, const(char)* val}},
		{q{GString*}, q{g_string_prepend_c}, q{GString* string, char c}},
		{q{GString*}, q{g_string_prepend_unichar}, q{GString* string, dchar wc}},
		{q{GString*}, q{g_string_prepend_len}, q{GString* string, const(char)* val, ptrdiff_t len}},
		{q{GString*}, q{g_string_insert}, q{GString* string, ptrdiff_t pos, const(char)* val}},
		{q{GString*}, q{g_string_insert_c}, q{GString* string, ptrdiff_t pos, char c}},
		{q{GString*}, q{g_string_insert_unichar}, q{GString* string, ptrdiff_t pos, dchar wc}},
		{q{GString*}, q{g_string_overwrite}, q{GString* string, size_t pos, const(char)* val}},
		{q{GString*}, q{g_string_overwrite_len}, q{GString* string, size_t pos, const(char)* val, ptrdiff_t len}},
		{q{GString*}, q{g_string_erase}, q{GString* string, ptrdiff_t pos, ptrdiff_t len}},
		{q{GString*}, q{g_string_ascii_down}, q{GString* string}},
		{q{GString*}, q{g_string_ascii_up}, q{GString* string}},
		{q{void}, q{g_string_vprintf}, q{GString* string, const(char)* format, va_list args}},
		{q{void}, q{g_string_printf}, q{GString* string, const(char)* format, ...}},
		{q{void}, q{g_string_append_vprintf}, q{GString* string, const(char)* format, va_list args}},
		{q{void}, q{g_string_append_printf}, q{GString* string, const(char)* format, ...}},
		{q{GString*}, q{g_string_append_uri_escaped}, q{GString* string, const(char)* unescaped, const(char)* reservedCharsAllowed, gboolean allowUTF8}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{GBytes*}, q{g_string_free_to_bytes}, q{GString* string}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{uint}, q{g_string_replace}, q{GString* string, const(char)* find, const(char)* replace, uint limit}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,76,0)){
		FnBind[] add = [
			{q{char*}, q{g_string_free_and_steal}, q{GString* string}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,78,0)){
		FnBind[] add = [
			{q{GString*}, q{g_string_new_take}, q{char* init}},
		];
		ret ~= add;
	}
	return ret;
}()));
