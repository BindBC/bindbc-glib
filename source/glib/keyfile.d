/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.keyfile;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.error;
import glib.quark;
import glib.types;

mixin(makeEnumBind(q{GKeyFileError}, members: (){
	EnumMember[] ret = [
		{{q{unknownEncoding},  q{G_KEY_FILE_ERROR_UNKNOWN_ENCODING}}},
		{{q{parse},            q{G_KEY_FILE_ERROR_PARSE}}},
		{{q{notFound},         q{G_KEY_FILE_ERROR_NOT_FOUND}}},
		{{q{keyNotFound},      q{G_KEY_FILE_ERROR_KEY_NOT_FOUND}}},
		{{q{groupNotFound},    q{G_KEY_FILE_ERROR_GROUP_NOT_FOUND}}},
		{{q{invalidValue},     q{G_KEY_FILE_ERROR_INVALID_VALUE}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GKeyFileFlags}, aliases: [q{GKeyFileFlag}], members: (){
	EnumMember[] ret = [
		{{q{none},              q{G_KEY_FILE_NONE}},               q{0}},
		{{q{keepComments},      q{G_KEY_FILE_KEEP_COMMENTS}},      q{1 << 0}},
		{{q{keepTranslations},  q{G_KEY_FILE_KEEP_TRANSLATIONS}},  q{1 << 1}},
	];
	return ret;
}()));

struct GKeyFile;

enum{
	G_KEY_FILE_DESKTOP_GROUP                 = "Desktop Entry",
	
	G_KEY_FILE_DESKTOP_KEY_TYPE              = "Type",
	G_KEY_FILE_DESKTOP_KEY_VERSION           = "Version",
	G_KEY_FILE_DESKTOP_KEY_NAME              = "Name",
	G_KEY_FILE_DESKTOP_KEY_GENERIC_NAME      = "GenericName",
	G_KEY_FILE_DESKTOP_KEY_NO_DISPLAY        = "NoDisplay",
	G_KEY_FILE_DESKTOP_KEY_COMMENT           = "Comment",
	G_KEY_FILE_DESKTOP_KEY_ICON              = "Icon",
	G_KEY_FILE_DESKTOP_KEY_HIDDEN            = "Hidden",
	G_KEY_FILE_DESKTOP_KEY_ONLY_SHOW_IN      = "OnlyShowIn",
	G_KEY_FILE_DESKTOP_KEY_NOT_SHOW_IN       = "NotShowIn",
	G_KEY_FILE_DESKTOP_KEY_TRY_EXEC          = "TryExec",
	G_KEY_FILE_DESKTOP_KEY_EXEC              = "Exec",
	G_KEY_FILE_DESKTOP_KEY_PATH              = "Path",
	G_KEY_FILE_DESKTOP_KEY_TERMINAL          = "Terminal",
	G_KEY_FILE_DESKTOP_KEY_MIME_TYPE         = "MimeType",
	G_KEY_FILE_DESKTOP_KEY_CATEGORIES        = "Categories",
	G_KEY_FILE_DESKTOP_KEY_STARTUP_NOTIFY    = "StartupNotify",
	G_KEY_FILE_DESKTOP_KEY_STARTUP_WM_CLASS  = "StartupWMClass",
	G_KEY_FILE_DESKTOP_KEY_URL               = "URL",
	G_KEY_FILE_DESKTOP_KEY_DBUS_ACTIVATABLE  = "DBusActivatable",
	G_KEY_FILE_DESKTOP_KEY_ACTIONS           = "Actions",
	
	G_KEY_FILE_DESKTOP_TYPE_APPLICATION      = "Application",
	G_KEY_FILE_DESKTOP_TYPE_LINK             = "Link",
	G_KEY_FILE_DESKTOP_TYPE_DIRECTORY        = "Directory",
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_key_file_error_quark}, q{}, aliases: [q{G_KEY_FILE_ERROR}]},
		{q{GKeyFile*}, q{g_key_file_new}, q{}},
		{q{GKeyFile*}, q{g_key_file_ref}, q{GKeyFile* keyFile}},
		{q{void}, q{g_key_file_unref}, q{GKeyFile* keyFile}},
		{q{void}, q{g_key_file_free}, q{GKeyFile* keyFile}},
		{q{void}, q{g_key_file_set_list_separator}, q{GKeyFile* keyFile, char separator}},
		{q{gboolean}, q{g_key_file_load_from_file}, q{GKeyFile* keyFile, const(char)* file, GKeyFileFlags flags, GError** error}},
		{q{gboolean}, q{g_key_file_load_from_data}, q{GKeyFile* keyFile, const(char)* data, size_t length, GKeyFileFlags flags, GError** error}},
		{q{gboolean}, q{g_key_file_load_from_dirs}, q{GKeyFile* keyFile, const(char)* file, const(char)** searchDirs, char** fullPath, GKeyFileFlags flags, GError** error}},
		{q{gboolean}, q{g_key_file_load_from_data_dirs}, q{GKeyFile* keyFile, const(char)* file, char** fullPath, GKeyFileFlags flags, GError** error}},
		{q{char*}, q{g_key_file_to_data}, q{GKeyFile* keyFile, size_t* length, GError** error}},
		{q{char*}, q{g_key_file_get_start_group}, q{GKeyFile* keyFile}},
		{q{char**}, q{g_key_file_get_groups}, q{GKeyFile* keyFile, size_t* length}},
		{q{char**}, q{g_key_file_get_keys}, q{GKeyFile* keyFile, const(char)* groupName, size_t* length, GError** error}},
		{q{gboolean}, q{g_key_file_has_group}, q{GKeyFile* keyFile, const(char)* groupName}},
		{q{gboolean}, q{g_key_file_has_key}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{char*}, q{g_key_file_get_value}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_value}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* value}},
		{q{char*}, q{g_key_file_get_string}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_string}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* string}},
		{q{char*}, q{g_key_file_get_locale_string}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* locale, GError** error}},
		{q{void}, q{g_key_file_set_locale_string}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* locale, const(char)* string}},
		{q{gboolean}, q{g_key_file_get_boolean}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_boolean}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, gboolean value}},
		{q{int}, q{g_key_file_get_integer}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_integer}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, int value}},
		{q{long}, q{g_key_file_get_int64}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_int64}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, long value}},
		{q{ulong}, q{g_key_file_get_uint64}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_uint64}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, ulong value}},
		{q{double}, q{g_key_file_get_double}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{void}, q{g_key_file_set_double}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, double value}},
		{q{char**}, q{g_key_file_get_string_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, size_t* length, GError** error}},
		{q{void}, q{g_key_file_set_string_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char*)* list, size_t length}},
		{q{char**}, q{g_key_file_get_locale_string_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* locale, size_t* length, GError** error}},
		{q{void}, q{g_key_file_set_locale_string_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* locale, const(char*)* list, size_t length}},
		{q{gboolean*}, q{g_key_file_get_boolean_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, size_t* length, GError** error}},
		{q{void}, q{g_key_file_set_boolean_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, gboolean* list, size_t length}},
		{q{int*}, q{g_key_file_get_integer_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, size_t* length, GError** error}},
		{q{void}, q{g_key_file_set_double_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, double* list, size_t length}},
		{q{double*}, q{g_key_file_get_double_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, size_t* length, GError** error}},
		{q{void}, q{g_key_file_set_integer_list}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, int* list, size_t length}},
		{q{gboolean}, q{g_key_file_set_comment}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* comment, GError** error}},
		{q{char*}, q{g_key_file_get_comment}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{gboolean}, q{g_key_file_remove_comment}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{gboolean}, q{g_key_file_remove_key}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, GError** error}},
		{q{gboolean}, q{g_key_file_remove_group}, q{GKeyFile* keyFile, const(char)* groupName, GError** error}},
	];
	if(glibVersion >= Version(2,40,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_key_file_save_to_file}, q{GKeyFile* keyFile, const(char)* filename, GError** error}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,50,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_key_file_load_from_bytes}, q{GKeyFile* keyFile, GBytes* bytes, GKeyFileFlags flags, GError** error}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,56,0)){
		FnBind[] add = [
			{q{char*}, q{g_key_file_get_locale_for_key}, q{GKeyFile* keyFile, const(char)* groupName, const(char)* key, const(char)* locale}},
		];
		ret ~= add;
	}
	return ret;
}()));
