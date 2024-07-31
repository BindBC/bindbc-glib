/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.option;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.quark;
import glib.types;

struct GOptionContext;

struct GOptionGroup;

mixin(makeEnumBind(q{GOptionFlags}, aliases: [q{GOptionFlag}], members: (){
	EnumMember[] ret = [
		{{q{hidden},           q{G_OPTION_FLAG_HIDDEN}},        q{1 << 0}},
		{{q{inMain},           q{G_OPTION_FLAG_IN_MAIN}},       q{1 << 1}},
		{{q{reverse},          q{G_OPTION_FLAG_REVERSE}},       q{1 << 2}},
	];
	if(glibVersion >= Version(2,8,0)){
		EnumMember[] add = [
			{{q{noArg},        q{G_OPTION_FLAG_NO_ARG}},        q{1 << 3}},
			{{q{filename},     q{G_OPTION_FLAG_FILENAME}},      q{1 << 4}},
			{{q{optionalArg},  q{G_OPTION_FLAG_OPTIONAL_ARG}},  q{1 << 5}},
			{{q{noAlias},      q{G_OPTION_FLAG_NOALIAS}},       q{1 << 6}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,42,0)){
		EnumMember[] add = [
			{{q{none},         q{G_OPTION_FLAG_NONE}},          q{0}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{GOptionArg}, members: (){
	EnumMember[] ret = [
		{{q{none},           q{G_OPTION_ARG_NONE}}},
		{{q{string},         q{G_OPTION_ARG_STRING}}},
		{{q{int_},           q{G_OPTION_ARG_INT}}},
		{{q{callback},       q{G_OPTION_ARG_CALLBACK}}},
		{{q{filename},       q{G_OPTION_ARG_FILENAME}}},
		{{q{stringArray},    q{G_OPTION_ARG_STRING_ARRAY}}},
		{{q{filenameArray},  q{G_OPTION_ARG_FILENAME_ARRAY}}},
	];
	if(glibVersion >= Version(2,12,0)){
		EnumMember[] add = [
			{{q{double_},    q{G_OPTION_ARG_DOUBLE}}},
			{{q{int64},      q{G_OPTION_ARG_INT64}}},
		];
		ret ~= add;
	}
	return ret;
}()));

extern(C) nothrow{
	alias GOptionArgFunc = gboolean function(const(char)* optionName, const(char)* value, void* data, GError** error);
	alias GOptionParseFunc = gboolean function(GOptionContext* context, GOptionGroup* group, void* data, GError** error);
	alias GOptionErrorFunc = void function(GOptionContext* context, GOptionGroup* group, void* data, GError** error);
}

mixin(makeEnumBind(q{GOptionError}, members: (){
	EnumMember[] ret = [
		{{q{unknownOption},  q{G_OPTION_ERROR_UNKNOWN_OPTION}}},
		{{q{badValue},       q{G_OPTION_ERROR_BAD_VALUE}}},
		{{q{failed},         q{G_OPTION_ERROR_FAILED}}},
	];
	return ret;
}()));

struct GOptionEntry{
	const(char)* longName;
	char shortName;
	alias long_name = longName;
	alias short_name = shortName;
	int flags;

	GOptionArg arg;
	void* argData;
	alias arg_data = argData;
	
	const(char)* description;
	const(char)* argDescription;
	alias arg_description = argDescription;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GQuark}, q{g_option_error_quark}, q{}, aliases: [q{G_OPTION_ERROR}]},
			{q{GOptionContext*}, q{g_option_context_new}, q{const(char)* parameterString}},
			{q{void}, q{g_option_context_set_summary}, q{GOptionContext* context, const(char)* summary}},
			{q{const(char)*}, q{g_option_context_get_summary}, q{GOptionContext* context}},
			{q{void}, q{g_option_context_set_description}, q{GOptionContext* context, const(char)* description}},
			{q{const(char)*}, q{g_option_context_get_description}, q{GOptionContext* context}},
			{q{void}, q{g_option_context_free}, q{GOptionContext* context}},
			{q{void}, q{g_option_context_set_help_enabled}, q{GOptionContext* context, gboolean helpEnabled}},
			{q{gboolean}, q{g_option_context_get_help_enabled}, q{GOptionContext* context}},
			{q{void}, q{g_option_context_set_ignore_unknown_options}, q{GOptionContext* context, gboolean ignoreUnknown}},
			{q{gboolean}, q{g_option_context_get_ignore_unknown_options}, q{GOptionContext* context}},
			{q{void}, q{g_option_context_add_main_entries}, q{GOptionContext* context, const(GOptionEntry)* entries, const(char)* translationDomain}},
			{q{gboolean}, q{g_option_context_parse}, q{GOptionContext* context, int* argC, char*** argV, GError** error}},
			{q{void}, q{g_option_context_set_translate_func}, q{GOptionContext* context, GTranslateFunc func, void* data, GDestroyNotify destroyNotify}},
			{q{void}, q{g_option_context_set_translation_domain}, q{GOptionContext* context, const(char)* domain}},
			{q{void}, q{g_option_context_add_group}, q{GOptionContext* context, GOptionGroup* group}},
			{q{void}, q{g_option_context_set_main_group}, q{GOptionContext* context, GOptionGroup* group}},
			{q{GOptionGroup*}, q{g_option_context_get_main_group}, q{GOptionContext* context}},
			{q{char*}, q{g_option_context_get_help}, q{GOptionContext* context, gboolean mainHelp, GOptionGroup* group}},
			{q{GOptionGroup*}, q{g_option_group_new}, q{const(char)* name, const(char)* description, const(char)* helpDescription, void* userData, GDestroyNotify destroy}},
			{q{void}, q{g_option_group_set_parse_hooks}, q{GOptionGroup* group, GOptionParseFunc preParseFunc, GOptionParseFunc postParseFunc}},
			{q{void}, q{g_option_group_set_error_hook}, q{GOptionGroup* group, GOptionErrorFunc errorFunc}},
			{q{void}, q{g_option_group_add_entries}, q{GOptionGroup* group, const(GOptionEntry)* entries}},
			{q{void}, q{g_option_group_set_translate_func}, q{GOptionGroup* group, GTranslateFunc func, void* data, GDestroyNotify destroyNotify}},
			{q{void}, q{g_option_group_set_translation_domain}, q{GOptionGroup* group, const(char)* domain}},
	];
	if(glibVersion >= Version(2,40,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_option_context_parse_strv}, q{GOptionContext* context, char*** arguments, GError** error}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,44,0)){
		FnBind[] add = [
			{q{void}, q{g_option_context_set_strict_posix}, q{GOptionContext* context, gboolean strictPOSIX}},
			{q{gboolean}, q{g_option_context_get_strict_posix}, q{GOptionContext* context}},
			{q{GOptionGroup*}, q{g_option_group_ref}, q{GOptionGroup* group}},
			{q{void}, q{g_option_group_unref}, q{GOptionGroup* group}},
		];
		ret ~= add;
	}
	return ret;
}()));
