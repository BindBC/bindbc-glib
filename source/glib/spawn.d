/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.spawn;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.main;
import glib.quark;
import glib.types;

mixin(makeEnumBind(q{GSpawnError}, members: (){
	EnumMember[] ret = [
		{{q{fork},         q{G_SPAWN_ERROR_FORK}}},
		{{q{read},         q{G_SPAWN_ERROR_READ}}},
		{{q{chDir},        q{G_SPAWN_ERROR_CHDIR}}},
		{{q{acces},        q{G_SPAWN_ERROR_ACCES}}},
		{{q{perm},         q{G_SPAWN_ERROR_PERM}}},
		{{q{tooBig},       q{G_SPAWN_ERROR_TOO_BIG}}, aliases: [{q{_2Big}, q{G_SPAWN_ERROR_2BIG}}]},
		{{q{noExec},       q{G_SPAWN_ERROR_NOEXEC}}},
		{{q{nameTooLong},  q{G_SPAWN_ERROR_NAMETOOLONG}}},
		{{q{noEnt},        q{G_SPAWN_ERROR_NOENT}}},
		{{q{noMem},        q{G_SPAWN_ERROR_NOMEM}}},
		{{q{notDir},       q{G_SPAWN_ERROR_NOTDIR}}},
		{{q{loop},         q{G_SPAWN_ERROR_LOOP}}},
		{{q{txtBusy},      q{G_SPAWN_ERROR_TXTBUSY}}},
		{{q{io},           q{G_SPAWN_ERROR_IO}}},
		{{q{nFile},        q{G_SPAWN_ERROR_NFILE}}},
		{{q{mFile},        q{G_SPAWN_ERROR_MFILE}}},
		{{q{inval},        q{G_SPAWN_ERROR_INVAL}}},
		{{q{isDir},        q{G_SPAWN_ERROR_ISDIR}}},
		{{q{libBad},       q{G_SPAWN_ERROR_LIBBAD}}},
		{{q{failed},       q{G_SPAWN_ERROR_FAILED}}},
	];
	return ret;
}()));

alias GSpawnChildSetupFunc = extern(C) void function(void* data) nothrow;

/**
 * GSpawnFlags:
 * @G_SPAWN_SEARCH_PATH_FROM_ENVP: if `argV[0]` is not an absolute path,
 *     it will be looked for in the `PATH` from the passed child environment.
 *     Since: 2.34
 * @G_SPAWN_CLOEXEC_PIPES: create all pipes with the `O_CLOEXEC` flag set.
 *     Since: 2.40
 * @G_SPAWN_CHILD_INHERITS_STDOUT: the child will inherit the parent's standard output.
 *     Since: 2.74
 * @G_SPAWN_CHILD_INHERITS_STDERR: the child will inherit the parent's standard error.
 *     Since: 2.74
 * @G_SPAWN_STDIN_FROM_DEV_NULL: the child's standard input is attached to `/dev/null`.
 *     Since: 2.74
 *
 * Flags passed to g_spawn_sync(), g_spawn_async() and g_spawn_async_with_pipes().
 */
mixin(makeEnumBind(q{GSpawnFlags}, aliases: [q{GSpawn}], members: (){
	EnumMember[] ret = [
		{{q{default_},              q{G_SPAWN_DEFAULT}},                 q{0}},
		{{q{leaveDescriptorsOpen},  q{G_SPAWN_LEAVE_DESCRIPTORS_OPEN}},  q{1 << 0}},
		{{q{doNotReapChild},        q{G_SPAWN_DO_NOT_REAP_CHILD}},       q{1 << 1}},
		{{q{searchPath},            q{G_SPAWN_SEARCH_PATH}},             q{1 << 2}},
		{{q{stdOutToDevNull},       q{G_SPAWN_STDOUT_TO_DEV_NULL}},      q{1 << 3}},
		{{q{stdErrToDevNull},       q{G_SPAWN_STDERR_TO_DEV_NULL}},      q{1 << 4}},
		{{q{childInheritsStdIn},    q{G_SPAWN_CHILD_INHERITS_STDIN}},    q{1 << 5}},
		{{q{fileAndArgVZero},       q{G_SPAWN_FILE_AND_ARGV_ZERO}},      q{1 << 6}},
	];
	if(glibVersion >= Version(2,34,0)){
		EnumMember[] add = [
			{{q{searchPathFromEnvP},    q{G_SPAWN_SEARCH_PATH_FROM_ENVP}},   q{1 << 7}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,40,0)){
		EnumMember[] add = [
			{{q{cloExecPipes},          q{G_SPAWN_CLOEXEC_PIPES}},           q{1 << 8}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{childInheritsStdOut},   q{G_SPAWN_CHILD_INHERITS_STDOUT}},   q{1 << 9}},
			{{q{childInheritsStdErr},   q{G_SPAWN_CHILD_INHERITS_STDERR}},   q{1 << 10}},
			{{q{stdinFromDevNull},      q{G_SPAWN_STDIN_FROM_DEV_NULL}},     q{1 << 11}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_spawn_error_quark}, q{}, aliases: [q{G_SPAWN_ERROR}]},
		{q{GQuark}, q{g_spawn_exit_error_quark}, q{}, aliases: [q{G_SPAWN_EXIT_ERROR}]},
		{q{gboolean}, q{g_spawn_async}, q{const(char)* workingDirectory, char** argV, char** envP, GSpawnFlags flags, GSpawnChildSetupFunc childSetup, void* userData, GPID* childPID, GError** error}},
		{q{gboolean}, q{g_spawn_async_with_pipes}, q{const(char)* workingDirectory, char** argV, char** envP, GSpawnFlags flags, GSpawnChildSetupFunc childSetup, void* userData, GPID* childPID, int* standardInput, int* standardOutput, int* standardError, GError** error}},
		{q{gboolean}, q{g_spawn_sync}, q{const(char)* workingDirectory, char** argV, char** envP, GSpawnFlags flags, GSpawnChildSetupFunc childSetup, void* userData, char** standardOutput, char** standardError, int* waitStatus, GError** error}},
		{q{gboolean}, q{g_spawn_command_line_sync}, q{const(char)* command_line, char** standardOutput, char** standardError, int* waitStatus, GError** error}},
		{q{gboolean}, q{g_spawn_command_line_async}, q{const(char)* commandLine, GError** error}},
		{q{void}, q{g_spawn_close_pid}, q{GPID pid}},
	];
	if(glibVersion >= Version(2,58,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_spawn_async_with_fds}, q{const(char)* workingDirectory, char** argV, char** envP, GSpawnFlags flags, GSpawnChildSetupFunc childSetup, void* userData, GPID* childPID, int stdInFD, int stdOutFD, int stdErrFD, GError** error}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_spawn_async_with_pipes_and_fds}, q{const(char)* workingDirectory, const(char*)* argV, const(char*)* envP, GSpawnFlags flags, GSpawnChildSetupFunc childSetup, void* userData, int stdInFD, int stdOutFD, int stdErrFD, const(int)* sourceFDs, const(int)* targetFDs, size_t nFDs, GPID* childPIDOut, int* stdInPipeOut, int* stdOutPipeOut, int* stdErrPipeOut, GError** error}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_spawn_check_wait_status}, q{int waitStatus, GError** error}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{gboolean}, q{g_spawn_check_exit_status}, q{int waitStatus, GError** error}},
		];
		ret ~= add;
	}
	return ret;
}()));
