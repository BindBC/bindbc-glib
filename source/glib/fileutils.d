/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.fileutils;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.quark;
import glib.types;

mixin(makeEnumBind(q{GFileError}, members: (){
	EnumMember[] ret = [
		{{q{exist},        q{G_FILE_ERROR_EXIST}}},
		{{q{isDir},        q{G_FILE_ERROR_ISDIR}}},
		{{q{acces},        q{G_FILE_ERROR_ACCES}}},
		{{q{nameTooLong},  q{G_FILE_ERROR_NAMETOOLONG}}},
		{{q{noEnt},        q{G_FILE_ERROR_NOENT}}},
		{{q{notDir},       q{G_FILE_ERROR_NOTDIR}}},
		{{q{nxio},         q{G_FILE_ERROR_NXIO}}},
		{{q{noDev},        q{G_FILE_ERROR_NODEV}}},
		{{q{rofs},         q{G_FILE_ERROR_ROFS}}},
		{{q{txtBsy},       q{G_FILE_ERROR_TXTBSY}}},
		{{q{fault},        q{G_FILE_ERROR_FAULT}}},
		{{q{loop},         q{G_FILE_ERROR_LOOP}}},
		{{q{noSpc},        q{G_FILE_ERROR_NOSPC}}},
		{{q{noMem},        q{G_FILE_ERROR_NOMEM}}},
		{{q{mFile},        q{G_FILE_ERROR_MFILE}}},
		{{q{nFile},        q{G_FILE_ERROR_NFILE}}},
		{{q{badF},         q{G_FILE_ERROR_BADF}}},
		{{q{inval},        q{G_FILE_ERROR_INVAL}}},
		{{q{pipe},         q{G_FILE_ERROR_PIPE}}},
		{{q{again},        q{G_FILE_ERROR_AGAIN}}},
		{{q{intr},         q{G_FILE_ERROR_INTR}}},
		{{q{io},           q{G_FILE_ERROR_IO}}},
		{{q{perm},         q{G_FILE_ERROR_PERM}}},
		{{q{noSys},        q{G_FILE_ERROR_NOSYS}}},
		{{q{failed},       q{G_FILE_ERROR_FAILED}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GFileTest}, members: (){
	EnumMember[] ret = [
		{{q{isRegular},     q{G_FILE_TEST_IS_REGULAR}},     q{1 << 0}},
		{{q{isSymlink},     q{G_FILE_TEST_IS_SYMLINK}},     q{1 << 1}},
		{{q{isDir},         q{G_FILE_TEST_IS_DIR}},         q{1 << 2}},
		{{q{isExecutable},  q{G_FILE_TEST_IS_EXECUTABLE}},  q{1 << 3}},
		{{q{exists},        q{G_FILE_TEST_EXISTS}},         q{1 << 4}},
	];
	return ret;
}()));

static if(glibVersion >= Version(2,66,0))
mixin(makeEnumBind(q{GFileSetContentsFlags}, aliases: [q{GFileSetContents}], members: (){
	EnumMember[] ret = [
		{{q{none},          q{G_FILE_SET_CONTENTS_NONE}},           q{0}},
		{{q{consistent},    q{G_FILE_SET_CONTENTS_CONSISTENT}},     q{1 << 0}},
		{{q{durable},       q{G_FILE_SET_CONTENTS_DURABLE}},        q{1 << 1}},
		{{q{onlyExisting},  q{G_FILE_SET_CONTENTS_ONLY_EXISTING}},  q{1 << 2}},
	];
	return ret;
}()));

pragma(inline,true) nothrow @nogc pure @safe{
	version(Windows){
		bool G_IS_DIR_SEPARATOR(dchar c) => c == '\\' || c == '/';
	}else{
		bool G_IS_DIR_SEPARATOR(dchar c) => c == '/';
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_file_error_quark}, q{}, aliases: [q{G_FILE_ERROR}]},
		{q{GFileError}, q{g_file_error_from_errno}, q{int errNo}},
		{q{gboolean}, q{g_file_test}, q{const(char)* filename, GFileTest test}},
		{q{gboolean}, q{g_file_get_contents}, q{const(char)* filename, char** contents, size_t* length, GError** error}},
		{q{gboolean}, q{g_file_set_contents}, q{const(char)* filename, const(char)* contents, ptrdiff_t length, GError** error}},
		{q{char*}, q{g_file_read_link}, q{const(char)* filename, GError** error}},
		{q{int}, q{g_mkstemp}, q{char* tmpl}},
		{q{int}, q{g_mkstemp_full}, q{char* tmpl, int flags, int mode}},
		{q{int}, q{g_file_open_tmp}, q{const(char)* tmpl, char** nameUsed, GError** error}},
		{q{char*}, q{g_build_path}, q{const(char)* separator, const(char)* firstElement, ...}},
		{q{char*}, q{g_build_pathv}, q{const(char)* separator, char** args}},
		{q{char*}, q{g_build_filename}, q{const(char)* firstElement, ...}},
		{q{char*}, q{g_build_filenamev}, q{char** args}},
		{q{int}, q{g_mkdir_with_parents}, q{const(char)* pathname, int mode}},
		{q{gboolean}, q{g_path_is_absolute}, q{const(char)* fileName}},
		{q{const(char)*}, q{g_path_skip_root}, q{const(char)* fileName}},
		{q{char*}, q{g_get_current_dir}, q{}},
		{q{char*}, q{g_path_get_basename}, q{const(char)* fileName}},
		{q{char*}, q{g_path_get_dirname}, q{const(char)* fileName}},
	];
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{char*}, q{g_mkdtemp}, q{char* tmpl}},
			{q{char*}, q{g_mkdtemp_full}, q{char* tmpl, int mode}},
			{q{char*}, q{g_dir_make_tmp}, q{const(char)* tmpl, GError** error}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,56,0)){
		FnBind[] add = [
			{q{char*}, q{g_build_filename_valist}, q{const(char)* firstElement, va_list* args}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{char*}, q{g_canonicalize_filename}, q{const(char)* filename, const(char)* relativeTo}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,66,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_file_set_contents_full}, q{const(char)* filename, const(char)* contents, ptrdiff_t length, GFileSetContentsFlags flags, int mode, GError** error}},
		];
		ret ~= add;
	}
	return ret;
}()));
