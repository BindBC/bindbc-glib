/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.paramspecs;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.boxed;
import gobject.enums;
import gobject.object;
import gobject.param;
import gobject.type;
import gobject.value;

struct GParamSpecChar{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	byte minimum;
	byte maximum;
	byte defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecUChar{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	ubyte minimum;
	ubyte maximum;
	ubyte defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecBoolean{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	gboolean defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecInt{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	int minimum;
	int maximum;
	int defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecUInt{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	uint minimum;
	uint maximum;
	uint defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecLong{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	c_long minimum;
	c_long maximum;
	c_long defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecULong{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	c_ulong minimum;
	c_ulong maximum;
	c_ulong defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecInt64{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	long minimum;
	long maximum;
	long defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecUInt64{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	ulong minimum;
	ulong maximum;
	ulong defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecUnichar{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	dchar defaultValue;
	alias default_value = defaultValue;
}

struct GParamSpecEnum{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	GEnumClass* enumClass;
	int defaultValue;
	alias enum_class = enumClass;
	alias default_value = defaultValue;
}

struct GParamSpecFlags{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	GFlagsClass* flagsClass;
	uint defaultValue;
	alias flags_class = flagsClass;
	alias default_value = defaultValue;
}

struct GParamSpecFloat{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	float minimum;
	float maximum;
	float defaultValue;
	alias default_value = defaultValue;
	float epsilon;
}

struct GParamSpecDouble{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	double minimum;
	double maximum;
	double defaultValue;
	alias default_value = defaultValue;
	double epsilon;
}

struct GParamSpecString{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	
	char* defaultValue;
	char* csetFirst;
	char* csetNth;
	alias default_value = defaultValue;
	alias cset_first = csetFirst;
	alias cset_nth = csetNth;
	char substitutor;
	
	import std.bitmanip;
	mixin(bitfields!(
		uint,  q{nullFoldIfEmpty},  1,
		uint,  q{ensureNonNull},    1,
		uint,  q{reserved},         6,
	));
	alias null_fold_if_empty = nullFoldIfEmpty;
	alias ensure_non_null = ensureNonNull;
}

struct GParamSpecParam{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
}

struct GParamSpecBoxed{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
}

struct GParamSpecPointer{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
}

struct GParamSpecValueArray{
	GParamSpec parentInstance;
	GParamSpec* elementSpec;
	uint fixedNElements;
	alias parent_instance = parentInstance;
	alias element_spec = elementSpec;
	alias fixed_n_elements = fixedNElements;
}

struct GParamSpecObject{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
}

struct GParamSpecOverride{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	GParamSpec* overridden;
}

struct GParamSpecGType{
	GParamSpec parentInstance;
	GType isAType;
	alias parent_instance = parentInstance;
	alias is_a_type = isAType;
}

struct GParamSpecVariant{
	GParamSpec parentInstance;
	alias parent_instance = parentInstance;
	GVariantType* type;
	GVariant* defaultValue;
	alias default_value = defaultValue;
	
	void*[4] padding;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GParamSpec*}, q{g_param_spec_char}, q{const(char)* name, const(char)* nick, const(char)* blurb, byte minimum, byte maximum, byte defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_uchar}, q{const(char)* name, const(char)* nick, const(char)* blurb, ubyte minimum, ubyte maximum, ubyte defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_boolean}, q{const(char)* name, const(char)* nick, const(char)* blurb, gboolean defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_int}, q{const(char)* name, const(char)* nick, const(char)* blurb, int minimum, int maximum, int defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_uint}, q{const(char)* name, const(char)* nick, const(char)* blurb, uint minimum, uint maximum, uint defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_long}, q{const(char)* name, const(char)* nick, const(char)* blurb, c_long minimum, c_long maximum, c_long defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_ulong}, q{const(char)* name, const(char)* nick, const(char)* blurb, c_ulong minimum, c_ulong maximum, c_ulong defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_int64}, q{const(char)* name, const(char)* nick, const(char)* blurb, long minimum, long maximum, long defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_uint64}, q{const(char)* name, const(char)* nick, const(char)* blurb, ulong minimum, ulong maximum, ulong defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_unichar}, q{const(char)* name, const(char)* nick, const(char)* blurb, dchar defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_enum}, q{const(char)* name, const(char)* nick, const(char)* blurb, GType enumType, int defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_flags}, q{const(char)* name, const(char)* nick, const(char)* blurb, GType flagsType, uint defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_float}, q{const(char)* name, const(char)* nick, const(char)* blurb, float minimum, float maximum, float defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_double}, q{const(char)* name, const(char)* nick, const(char)* blurb, double minimum, double maximum, double defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_string}, q{const(char)* name, const(char)* nick, const(char)* blurb, const(char)* defaultValue, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_param}, q{const(char)* name, const(char)* nick, const(char)* blurb, GType paramType, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_boxed}, q{const(char)* name, const(char)* nick, const(char)* blurb, GType boxedType, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_pointer}, q{const(char)* name, const(char)* nick, const(char)* blurb, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_value_array}, q{const(char)* name, const(char)* nick, const(char)* blurb, GParamSpec* elementSpec, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_object}, q{const(char)* name, const(char)* nick, const(char)* blurb, GType objectType, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_override}, q{const(char)* name, GParamSpec* overridden}},
		{q{GParamSpec*}, q{g_param_spec_gtype}, q{const(char)* name, const(char)* nick, const(char)* blurb, GType isAType, GParamFlags flags}},
		{q{GParamSpec*}, q{g_param_spec_variant}, q{const(char)* name, const(char)* nick, const(char)* blurb, const(GVariantType)* type, GVariant* defaultValue, GParamFlags flags}},
	];
	return ret;
}()));
