/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.error;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.quark;
import glib.types;

struct GError{
	GQuark domain;
	int code;
	char* message;
}

extern(C) nothrow{
	static if(glibVersion >= Version(2,68,0)){
		alias GErrorInitFunc = void function(GError* error);
		alias GErrorCopyFunc = void function(const(GError)* srcError, GError* destError);
		alias GErrorClearFunc = void function(GError* error);
	}
}

static if(glibVersion >= Version(2,68,0))
enum G_DEFINE_EXTENDED_ERROR = (string ErrorType, string error_type) => "
private pragma(inline,true) "~ErrorType~"Private* "~error_type~"_get_private(const(GError)* error){
	/+Copied from gtype.c (STRUCT_ALIGNMENT and ALIGN_STRUCT macros).+/
	const size_t sa = 2*  size_t.sizeof;
	const size_t as = ("~ErrorType~"Private.sizeof + (sa - 1)) & -sa;
	g_return_val_if_fail(error != null, null);
	g_return_val_if_fail(error->domain == "~error_type~"_quark (), null);
	return cast("~ErrorType~"Private*)((cast(ubyte*)error) - as);
}

private void g_error_with_"~error_type~"_private_init(GError* error){
	"~ErrorType~"Private* priv = "~error_type~"_get_private(error);
	"~error_type~"_private_init(priv);
}

private void g_error_with_"~error_type~"_private_copy(const(GError)* srcError, GError* destError){
	const("~ErrorType~"Private* srcPriv = "~error_type~"_get_private(srcError);
	"~ErrorType~"Private* destPriv = "~error_type~"_get_private(destError);
	"~error_type~"_private_copy(srcPriv, destPriv);
}

private void g_error_with_"~error_type~"_private_clear(GError* error){
	"~ErrorType~"Private* priv = "~error_type~"_get_private(error);
	"~error_type~"_private_clear(priv);
}

GQuark "~error_type~"_quark(){
	static GQuark q;
	static size_t initialised = 0;
	
	if(g_once_init_enter(&initialised)){
			q = g_error_domain_register_static(
				`"~ErrorType~"`,
				"~ErrorType~"Private.sizeof,
				g_error_with_"~error_type~"_private_init,
				g_error_with_"~error_type~"_private_copy,
				g_error_with_"~error_type~"_private_clear,
			);
			g_once_init_leave (&initialised, 1);
		}
	return q;
}";

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GError*}, q{g_error_new}, q{GQuark domain, int code, const(char)* format, ...}},
		{q{GError*}, q{g_error_new_literal}, q{GQuark domain, int code, const(char)* message}},
		{q{GError*}, q{g_error_new_valist}, q{GQuark domain, int code, const(char)* format, va_list args}},
		{q{void}, q{g_error_free}, q{GError* error}},
		{q{GError*}, q{g_error_copy}, q{const GError* error}},
		{q{gboolean}, q{g_error_matches}, q{const GError* error, GQuark domain, int code}},
		{q{void}, q{g_set_error}, q{GError** err, GQuark domain, int code, const(char)* format, ...}},
		{q{void}, q{g_set_error_literal}, q{GError** err, GQuark domain, int code, const(char)* message}},
		{q{void}, q{g_propagate_error}, q{GError** dest, GError* src}},
		{q{void}, q{g_clear_error}, q{GError** err}},
		{q{void}, q{g_prefix_error}, q{GError** err, const(char)* format, ...}},
		{q{void}, q{g_propagate_prefixed_error}, q{GError** dest, GError* src, const(char)* format, ...}},
	];
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{GQuark}, q{g_error_domain_register_static}, q{const(char)* errorTypeName, size_t errorTypePrivateSize, GErrorInitFunc errorTypeInit, GErrorCopyFunc errorTypeCopy, GErrorClearFunc errorTypeClear}},
			{q{GQuark}, q{g_error_domain_register}, q{const(char)* errorTypeName, size_t errorTypePrivateSize, GErrorInitFunc errorTypeInit, GErrorCopyFunc errorTypeCopy, GErrorClearFunc errorTypeClear}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{void}, q{g_prefix_error_literal}, q{GError** err, const(char)* prefix}},
		];
		ret ~= add;
	}
	return ret;
}()));
