/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.markup;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.quark;
import glib.slist;
import glib.types;

mixin(makeEnumBind(q{GMarkupError}, members: (){
	EnumMember[] ret = [
		{{q{badUTF8},           q{G_MARKUP_ERROR_BAD_UTF8}}},
		{{q{empty},             q{G_MARKUP_ERROR_EMPTY}}},
		{{q{parse},             q{G_MARKUP_ERROR_PARSE}}},
		{{q{unknownElement},    q{G_MARKUP_ERROR_UNKNOWN_ELEMENT}}},
		{{q{unknownAttribute},  q{G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE}}},
		{{q{invalidContent},    q{G_MARKUP_ERROR_INVALID_CONTENT}}},
		{{q{missingAttribute},  q{G_MARKUP_ERROR_MISSING_ATTRIBUTE}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GMarkupParseFlags}, aliases: [q{GMarkup}], members: (){
	EnumMember[] ret = [
		{{q{treatCDataAsText},     q{G_MARKUP_TREAT_CDATA_AS_TEXT}},    q{1 << 1}},
		{{q{prefixErrorPosition},  q{G_MARKUP_PREFIX_ERROR_POSITION}},  q{1 << 2}},
	];
	if(glibVersion >= Version(2,40,0)){
		EnumMember[] add = [
			{{q{ignoreQualified},    q{G_MARKUP_IGNORE_QUALIFIED}},     q{1 << 3}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{defaultFlags},       q{G_MARKUP_DEFAULT_FLAGS}},        q{0}},
		];
		ret ~= add;
	}
	return ret;
}()));

struct GMarkupParseContext;

struct GMarkupParser{
	extern(C) nothrow{
		alias StartElementFn = void function(GMarkupParseContext* context, const(char)* elementName, const(char)** attributeNames, const(char)** attributeValues, void* userData, GError** error);
		alias EndElementFn = void function(GMarkupParseContext* context, const(char)* elementName, void* userData, GError** error);
		alias TextFn = void function(GMarkupParseContext* context, const(char)* text, size_t textLen, void* userData, GError** error);
		alias PassthroughFn = void function(GMarkupParseContext* context, const(char)* passthroughText, size_t textLen, void* userData, GError** error);
		alias ErrorFn = void function(GMarkupParseContext* context, GError* error, void* userData);
	}
	StartElementFn startElement;
	EndElementFn endElement;
	alias start_element = startElement;
	alias end_element = endElement;
	TextFn text;
	PassthroughFn passthrough;
	ErrorFn error;
}

mixin(makeEnumBind(q{GMarkupCollectType}, aliases: [q{GMarkupCollect}], members: (){
	EnumMember[] ret = [
		{{q{invalid},   q{G_MARKUP_COLLECT_INVALID}}},
		{{q{string},    q{G_MARKUP_COLLECT_STRING}}},
		{{q{strDup},    q{G_MARKUP_COLLECT_STRDUP}}},
		{{q{boolean},   q{G_MARKUP_COLLECT_BOOLEAN}}},
		{{q{triState},  q{G_MARKUP_COLLECT_TRISTATE}}},
		{{q{optional},  q{G_MARKUP_COLLECT_OPTIONAL}}, q{1 << 16}},
	];
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_markup_error_quark}, q{}, aliases: [q{G_MARKUP_ERROR}]},
		{q{GMarkupParseContext*}, q{g_markup_parse_context_new}, q{const(GMarkupParser)* parser, GMarkupParseFlags flags, void* userData, GDestroyNotify userDataDnotify}},
		{q{void}, q{g_markup_parse_context_free}, q{GMarkupParseContext* context}},
		{q{gboolean}, q{g_markup_parse_context_parse}, q{GMarkupParseContext* context, const(char)* text, ptrdiff_t textLen, GError** error}},
		{q{void}, q{g_markup_parse_context_push}, q{GMarkupParseContext* context, const(GMarkupParser)* parser, void* userData}},
		{q{void*}, q{g_markup_parse_context_pop}, q{GMarkupParseContext* context}},
		{q{gboolean}, q{g_markup_parse_context_end_parse}, q{GMarkupParseContext* context, GError** error}},
		{q{const(char)*}, q{g_markup_parse_context_get_element}, q{GMarkupParseContext* context}},
		{q{const(GSList)*}, q{g_markup_parse_context_get_element_stack}, q{GMarkupParseContext* context}},
		{q{void}, q{g_markup_parse_context_get_position}, q{GMarkupParseContext* context, int* lineNumber, int* charNumber}},
		{q{void*}, q{g_markup_parse_context_get_user_data}, q{GMarkupParseContext* context}},
		{q{char*}, q{g_markup_escape_text}, q{const(char)* text, ptrdiff_t length}},
		{q{char*}, q{g_markup_printf_escaped}, q{const(char)* format, ...}},
		{q{char*}, q{g_markup_vprintf_escaped}, q{const(char)* format, va_list args}},
		{q{gboolean}, q{g_markup_collect_attributes}, q{const(char)* elementName, const(char)** attributeNames, const(char)** attributeValues, GError** error, GMarkupCollectType firstType, const(char)* firstAttr, ...}},
	];
	if(glibVersion >= Version(2,36,0)){
		FnBind[] add = [
			{q{GMarkupParseContext*}, q{g_markup_parse_context_ref}, q{GMarkupParseContext* context}},
			{q{void}, q{g_markup_parse_context_unref}, q{GMarkupParseContext* context}},
		];
		ret ~= add;
	}
	return ret;
}()));
