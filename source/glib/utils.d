/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.utils;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

static if(glibVersion >= Version(2,64,0))
enum{
	G_OS_INFO_KEY_NAME                = "NAME",
	G_OS_INFO_KEY_PRETTY_NAME         = "PRETTY_NAME",
	G_OS_INFO_KEY_VERSION             = "VERSION",
	G_OS_INFO_KEY_VERSION_CODENAME    = "VERSION_CODENAME",
	G_OS_INFO_KEY_VERSION_ID          = "VERSION_ID",
	G_OS_INFO_KEY_ID                  = "ID",
	G_OS_INFO_KEY_HOME_URL            = "HOME_URL",
	G_OS_INFO_KEY_DOCUMENTATION_URL   = "DOCUMENTATION_URL",
	G_OS_INFO_KEY_SUPPORT_URL         = "SUPPORT_URL",
	G_OS_INFO_KEY_BUG_REPORT_URL      = "BUG_REPORT_URL",
	G_OS_INFO_KEY_PRIVACY_POLICY_URL  = "PRIVACY_POLICY_URL",
}

mixin(makeEnumBind(q{GUserDirectory}, members: (){
	EnumMember[] ret = [
		{{q{desktop},       q{G_USER_DIRECTORY_DESKTOP}}},
		{{q{documents},     q{G_USER_DIRECTORY_DOCUMENTS}}},
		{{q{download},      q{G_USER_DIRECTORY_DOWNLOAD}}},
		{{q{music},         q{G_USER_DIRECTORY_MUSIC}}},
		{{q{pictures},      q{G_USER_DIRECTORY_PICTURES}}},
		{{q{publicShare},   q{G_USER_DIRECTORY_PUBLIC_SHARE}}},
		{{q{templates},     q{G_USER_DIRECTORY_TEMPLATES}}},
		{{q{videos},        q{G_USER_DIRECTORY_VIDEOS}}},
		
		{{q{nDirectories},  q{G_USER_N_DIRECTORIES}}},
	];
	return ret;
}()));

struct GDebugKey{
	const(char)* key;
	uint value;
}

mixin(makeEnumBind(q{GFormatSizeFlags}, aliases: [q{GFormatSize}, q{GFormatSizeFlag}], members: (){
	EnumMember[] ret = [
		{{q{default_},       q{G_FORMAT_SIZE_DEFAULT}},      q{0}},
		{{q{longFormat},     q{G_FORMAT_SIZE_LONG_FORMAT}},  q{1 << 0}},
		{{q{iecUnits},       q{G_FORMAT_SIZE_IEC_UNITS}},    q{1 << 1}},
		{{q{bits},           q{G_FORMAT_SIZE_BITS}},         q{1 << 2}},
	];
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{onlyValue},  q{G_FORMAT_SIZE_ONLY_VALUE}},   q{1 << 3}},
			{{q{onlyUnit},   q{G_FORMAT_SIZE_ONLY_UNIT}},    q{1 << 4}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{const(char)*}, q{g_get_user_name}, q{}},
		{q{const(char)*}, q{g_get_real_name}, q{}},
		{q{const(char)*}, q{g_get_home_dir}, q{}},
		{q{const(char)*}, q{g_get_tmp_dir}, q{}},
		{q{const(char)*}, q{g_get_host_name}, q{}},
		{q{const(char)*}, q{g_get_prgname}, q{}},
		{q{void}, q{g_set_prgname}, q{const(char)* prgName}},
		{q{const(char)*}, q{g_get_application_name}, q{}},
		{q{void}, q{g_set_application_name}, q{const(char)* applicationName}},
		{q{void}, q{g_reload_user_special_dirs_cache}, q{}},
		{q{const(char)*}, q{g_get_user_data_dir}, q{}},
		{q{const(char)*}, q{g_get_user_config_dir}, q{}},
		{q{const(char)*}, q{g_get_user_cache_dir}, q{}},
		{q{const(char*)*}, q{g_get_system_data_dirs}, q{}},
		{q{const(char*)*}, q{g_get_system_config_dirs}, q{}},
		{q{const(char)*}, q{g_get_user_runtime_dir}, q{}},
		{q{const(char)*}, q{g_get_user_special_dir}, q{GUserDirectory directory}},
		{q{uint}, q{g_parse_debug_string}, q{const(char)* string, const(GDebugKey)* keys, uint nKeys}},
		{q{int}, q{g_snprintf}, q{char* string, c_ulong n, const(char)* format, ...}},
		{q{int}, q{g_vsnprintf}, q{char* string, c_ulong n, const(char)* format, va_list args}},
		{q{void}, q{g_nullify_pointer}, q{void** nullifyLocation}},
	];
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{char*}, q{g_format_size_full}, q{ulong size, GFormatSizeFlags flags}},
			{q{char*}, q{g_format_size}, q{ulong size}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{char*}, q{g_format_size_for_display}, q{goffset size}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,64,0)){
		FnBind[] add = [
			{q{char*}, q{g_get_os_info}, q{const(char)* keyName}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{const(char)*}, q{g_get_user_state_dir}, q{}},
		];
		ret ~= add;
	}
	return ret;
}()));
