/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.varianttype;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

struct GVariantType;

enum{
	G_VARIANT_TYPE_BOOLEAN            = "b",
	G_VARIANT_TYPE_BYTE               = "y",
	G_VARIANT_TYPE_INT16              = "n",
	G_VARIANT_TYPE_UINT16             = "q",
	G_VARIANT_TYPE_INT32              = "i",
	G_VARIANT_TYPE_UINT32             = "u",
	G_VARIANT_TYPE_INT64              = "x",
	G_VARIANT_TYPE_UINT64             = "t",
	G_VARIANT_TYPE_DOUBLE             = "d",
	G_VARIANT_TYPE_STRING             = "s",
	G_VARIANT_TYPE_OBJECT_PATH        = "o",
	G_VARIANT_TYPE_SIGNATURE          = "g",
	G_VARIANT_TYPE_VARIANT            = "v",
	G_VARIANT_TYPE_HANDLE             = "h",
	G_VARIANT_TYPE_UNIT               = "()",
	G_VARIANT_TYPE_ANY                = "*",
	G_VARIANT_TYPE_BASIC              = "?",
	G_VARIANT_TYPE_MAYBE              = "m*",
	G_VARIANT_TYPE_ARRAY              = "a*",
	G_VARIANT_TYPE_TUPLE              = "r",
	G_VARIANT_TYPE_DICT_ENTRY         = "{?*}",
	G_VARIANT_TYPE_DICTIONARY         = "a{?*}",
	G_VARIANT_TYPE_STRING_ARRAY       = "as",
	G_VARIANT_TYPE_OBJECT_PATH_ARRAY  = "ao",
	G_VARIANT_TYPE_BYTESTRING         = "ay",
	G_VARIANT_TYPE_BYTESTRING_ARRAY   = "aay",
}
static if(glibVersion >= Version(2,30,0))
enum{
	G_VARIANT_TYPE_VARDICT            = "a{sv}",
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{gboolean}, q{g_variant_type_string_is_valid}, q{const(char)* typeString}},
		{q{gboolean}, q{g_variant_type_string_scan}, q{const(char)* string, const(char)* limit, const(char)** endPtr}},
		{q{void}, q{g_variant_type_free}, q{GVariantType* type}},
		{q{GVariantType*}, q{g_variant_type_copy}, q{const(GVariantType)* type}},
		{q{GVariantType*}, q{g_variant_type_new}, q{const(char)* typeString}},
		{q{size_t}, q{g_variant_type_get_string_length}, q{const(GVariantType)* type}},
		{q{const(char)*}, q{g_variant_type_peek_string}, q{const(GVariantType)* type}},
		{q{char*}, q{g_variant_type_dup_string}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_definite}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_container}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_basic}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_maybe}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_array}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_tuple}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_dict_entry}, q{const(GVariantType)* type}},
		{q{gboolean}, q{g_variant_type_is_variant}, q{const(GVariantType)* type}},
		{q{uint}, q{g_variant_type_hash}, q{const(void)* type}},
		{q{gboolean}, q{g_variant_type_equal}, q{const(void)* type1, const(void)* type2}},
		{q{gboolean}, q{g_variant_type_is_subtype_of}, q{const(GVariantType)* type, const(GVariantType)* superType}},
		{q{const(GVariantType)*}, q{g_variant_type_element}, q{const(GVariantType)* type}},
		{q{const(GVariantType)*}, q{g_variant_type_first}, q{const(GVariantType)* type}},
		{q{const(GVariantType)*}, q{g_variant_type_next}, q{const(GVariantType)* type}},
		{q{size_t}, q{g_variant_type_n_items}, q{const(GVariantType)* type}},
		{q{const(GVariantType)*}, q{g_variant_type_key}, q{const(GVariantType)* type}},
		{q{const(GVariantType)*}, q{g_variant_type_value}, q{const(GVariantType)* type}},
		{q{GVariantType *}, q{g_variant_type_new_array}, q{const(GVariantType)* element}},
		{q{GVariantType *}, q{g_variant_type_new_maybe}, q{const(GVariantType)* element}},
		{q{GVariantType *}, q{g_variant_type_new_tuple}, q{const(GVariantType*)* items, int length}},
		{q{GVariantType *}, q{g_variant_type_new_dict_entry}, q{const(GVariantType)* key, const(GVariantType)* value}},
		{q{const(GVariantType)*}, q{g_variant_type_checked_}, q{const(char)* typeString}, aliases: [q{G_VARIANT_TYPE}]},
	];
	if(glibVersion >= Version(2,60,0)){
		FnBind[] add = [
			{q{size_t}, q{g_variant_type_string_get_depth_}, q{const(char)* typeString}},
		];
		ret ~= add;
	}
	return ret;
}()));
