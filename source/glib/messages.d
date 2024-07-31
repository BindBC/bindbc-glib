/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.messages;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.macros;
import glib.variant;
import glib.types;

mixin(makeEnumBind(q{GLogLevelFlags}, aliases: [q{GLogLevel}, q{GLogLevelFlag}], members: (){
	EnumMember[] ret = [
		{{q{recursion},  q{G_LOG_FLAG_RECURSION}},    q{1 << 0}},
		{{q{fatal},      q{G_LOG_FLAG_FATAL}},        q{1 << 1}},
		
		{{q{error},      q{G_LOG_LEVEL_ERROR}},       q{1 << 2}},
		{{q{critical},   q{G_LOG_LEVEL_CRITICAL}},    q{1 << 3}},
		{{q{warning},    q{G_LOG_LEVEL_WARNING}},     q{1 << 4}},
		{{q{message},    q{G_LOG_LEVEL_MESSAGE}},     q{1 << 5}},
		{{q{info},       q{G_LOG_LEVEL_INFO}},        q{1 << 6}},
		{{q{debug_},     q{G_LOG_LEVEL_DEBUG}},       q{1 << 7}},
		
		{{q{mask},       q{G_LOG_LEVEL_MASK}},        q{~(GLogLevel.recursion | GLogLevel.fatal)}},
		{{q{userShift},  q{G_LOG_LEVEL_USER_SHIFT}},  q{8}},
	];
	return ret;
}()));

enum G_LOG_FATAL_MASK = (GLogLevelFlag.recursion | GLogLevelFlag.error);

alias GLogFunc = extern(C) void function(const(char)* logDomain, GLogLevelFlags logLevel, const(char)* message, void* userData) nothrow;

static if(glibVersion >= Version(2,50,0)){
	mixin(makeEnumBind(q{GLogWriterOutput}, aliases: [q{GLogWriter}], members: (){
		EnumMember[] ret = [
			{{q{handled},    q{G_LOG_WRITER_HANDLED}},    q{1}},
			{{q{unhandled},  q{G_LOG_WRITER_UNHANDLED}},  q{0}},
		];
		return ret;
	}()));
	
	struct GLogField{
		const(char)* key;
		const(void)* value;
		ptrdiff_t length;
	}
	
	alias GLogWriterFunc = extern(C) GLogWriterOutput function(GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, void* userData) nothrow;
	
	enum G_DEBUG_HERE = `
g_log_structured(
	G_LOG_DOMAIN, GLogLevel.debug_,
	"CODE_FILE", __FILE__,
	"CODE_LINE", __LINE__.stringof,
	"CODE_FUNC", __FUNCTION__,
	"MESSAGE", "%li: %s",
	g_get_monotonic_time(), G_STRLOC(),
);`;
}

enum G_LOG_DOMAIN = cast(char*)null;

alias GPrintFunc = extern(C) void function(const(char)* string) nothrow;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{size_t}, q{g_printf_string_upper_bound}, q{const(char)* format, va_list args}},
		{q{uint}, q{g_log_set_handler}, q{const(char)* logDomain, GLogLevelFlags logLevels, GLogFunc logFunc, void* userData}},
		{q{void}, q{g_log_remove_handler}, q{const(char)* logDomain, uint handlerID}},
		{q{void}, q{g_log_default_handler}, q{const(char)* logDomain, GLogLevelFlags logLevel, const(char)* message, void* unusedData}},
		{q{GLogFunc}, q{g_log_set_default_handler}, q{GLogFunc logFunc, void* userData}},
		{q{void}, q{g_log}, q{const(char)* logDomain, GLogLevelFlags logLevel, const(char)* format, ...}},
		{q{void}, q{g_logv}, q{const(char)* logDomain, GLogLevelFlags logLevel, const(char)* format, va_list args}},
		{q{GLogLevelFlags}, q{g_log_set_fatal_mask}, q{const(char)* logDomain, GLogLevelFlags fatalMask}},
		{q{GLogLevelFlags}, q{g_log_set_always_fatal}, q{GLogLevelFlags fatalMask}},
		{q{void}, q{g_return_if_fail_warning}, q{const(char)* logDomain, const(char)* prettyFunction, const(char)* expression}},
		{q{void}, q{g_warn_message}, q{const(char)* domain, const(char)* file, int line, const(char)* func, const(char)* warnExpr}},
		{q{void}, q{g_print}, q{const(char)* format, ...}},
		{q{GPrintFunc}, q{g_set_print_handler}, q{GPrintFunc func}},
		{q{void}, q{g_printerr}, q{const(char)* format, ...}},
		{q{GPrintFunc}, q{g_set_printerr_handler}, q{GPrintFunc func}},
	];
	if(glibVersion >= Version(2,46,0)){
		FnBind[] add = [
			{q{uint}, q{g_log_set_handler_full}, q{const(char)* logDomain, GLogLevelFlags logLevels, GLogFunc logFunc, void* userData, GDestroyNotify  destroy}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,50,0)){
		FnBind[] add = [
			{q{void}, q{g_log_structured}, q{const(char)* logDomain, GLogLevelFlags logLevel, ...}},
			{q{void}, q{g_log_structured_array}, q{GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields}},
			{q{void}, q{g_log_variant}, q{const(char)* logDomain, GLogLevelFlags logLevel, GVariant* fields}},
			{q{void}, q{g_log_set_writer_func}, q{GLogWriterFunc func, void* userData, GDestroyNotify userDataFree}},
			{q{gboolean}, q{g_log_writer_supports_color}, q{int outputFD}},
			{q{gboolean}, q{g_log_writer_is_journald}, q{int outputFD}},
			{q{char*}, q{g_log_writer_format_fields}, q{GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, gboolean useColour}},
			{q{GLogWriterOutput}, q{g_log_writer_journald}, q{GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, void* userData}},
			{q{GLogWriterOutput}, q{g_log_writer_standard_streams}, q{GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, void* userData}},
			{q{GLogWriterOutput}, q{g_log_writer_default}, q{GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, void* userData}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,56,0)){
		FnBind[] add = [
			{q{void}, q{g_log_structured_standard}, q{const(char)* logDomain, GLogLevelFlags logLevel, const(char)* file, const(char)* line, const(char)* func, const(char)* messageFormat, ...}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{void}, q{g_log_writer_default_set_use_stderr}, q{gboolean useStderr}},
			{q{gboolean}, q{g_log_writer_default_would_drop}, q{GLogLevelFlags logLevel, const(char)* logDomain}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_log_get_debug_enabled}, q{}},
			{q{void}, q{g_log_set_debug_enabled}, q{gboolean enabled}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,80,0)){
		FnBind[] add = [
			{q{GLogWriterOutput}, q{g_log_writer_syslog}, q{GLogLevelFlags logLevel, const(GLogField)* fields, size_t nFields, void* userData}},
			{q{void}, q{g_log_writer_default_set_debug_domains}, q{const(char*)* domains}},
		];
		ret ~= add;
	}
	return ret;
}()));
