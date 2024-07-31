/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.variant;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.array;
import glib.error;
import glib.quark;
import glib.string;
import glib.types;
import glib.varianttype;

struct GVariant;

mixin(makeEnumBind(q{GVariantClass}, members: (){
	EnumMember[] ret = [
		{{q{boolean},     q{G_VARIANT_CLASS_BOOLEAN}},      q{'b'}},
		{{q{byte_},       q{G_VARIANT_CLASS_BYTE}},         q{'y'}},
		{{q{int16},       q{G_VARIANT_CLASS_INT16}},        q{'n'}},
		{{q{uint16},      q{G_VARIANT_CLASS_UINT16}},       q{'q'}},
		{{q{int32},       q{G_VARIANT_CLASS_INT32}},        q{'i'}},
		{{q{uint32},      q{G_VARIANT_CLASS_UINT32}},       q{'u'}},
		{{q{int64},       q{G_VARIANT_CLASS_INT64}},        q{'x'}},
		{{q{uint64},      q{G_VARIANT_CLASS_UINT64}},       q{'t'}},
		{{q{handle},      q{G_VARIANT_CLASS_HANDLE}},       q{'h'}},
		{{q{double_},     q{G_VARIANT_CLASS_DOUBLE}},       q{'d'}},
		{{q{string},      q{G_VARIANT_CLASS_STRING}},       q{'s'}},
		{{q{objectPath},  q{G_VARIANT_CLASS_OBJECT_PATH}},  q{'o'}},
		{{q{signature},   q{G_VARIANT_CLASS_SIGNATURE}},    q{'g'}},
		{{q{variant},     q{G_VARIANT_CLASS_VARIANT}},      q{'v'}},
		{{q{maybe},       q{G_VARIANT_CLASS_MAYBE}},        q{'m'}},
		{{q{array},       q{G_VARIANT_CLASS_ARRAY}},        q{'a'}},
		{{q{tuple},       q{G_VARIANT_CLASS_TUPLE}},        q{'('}},
		{{q{dictEntry},   q{G_VARIANT_CLASS_DICT_ENTRY}},   q{'{'}},
	];
	return ret;
}()));

struct GVariantIter{
	size_t[16] x;
}

struct GVariantBuilder{
	union{
		struct{
			size_t partialMagic;
			alias partial_magic = partialMagic;
			const(GVariantType)* type;
			size_t[14] y;
		}
		size_t[16] x;
	}
}

mixin(makeEnumBind(q{GVariantParseError}, members: (){
	EnumMember[] ret = [
		{{q{failed},                      q{G_VARIANT_PARSE_ERROR_FAILED}}},
		{{q{basicTypeExpected},           q{G_VARIANT_PARSE_ERROR_BASIC_TYPE_EXPECTED}}},
		{{q{cannotInferType},             q{G_VARIANT_PARSE_ERROR_CANNOT_INFER_TYPE}}},
		{{q{definiteTypeExpected},        q{G_VARIANT_PARSE_ERROR_DEFINITE_TYPE_EXPECTED}}},
		{{q{inputNotAtEnd},               q{G_VARIANT_PARSE_ERROR_INPUT_NOT_AT_END}}},
		{{q{invalidCharacter},            q{G_VARIANT_PARSE_ERROR_INVALID_CHARACTER}}},
		{{q{invalidFormatString},         q{G_VARIANT_PARSE_ERROR_INVALID_FORMAT_STRING}}},
		{{q{invalidObjectPath},           q{G_VARIANT_PARSE_ERROR_INVALID_OBJECT_PATH}}},
		{{q{invalidSignature},            q{G_VARIANT_PARSE_ERROR_INVALID_SIGNATURE}}},
		{{q{invalidTypeString},           q{G_VARIANT_PARSE_ERROR_INVALID_TYPE_STRING}}},
		{{q{noCommonType},                q{G_VARIANT_PARSE_ERROR_NO_COMMON_TYPE}}},
		{{q{numberOutOfRange},            q{G_VARIANT_PARSE_ERROR_NUMBER_OUT_OF_RANGE}}},
		{{q{numberTooBig},                q{G_VARIANT_PARSE_ERROR_NUMBER_TOO_BIG}}},
		{{q{typeError},                   q{G_VARIANT_PARSE_ERROR_TYPE_ERROR}}},
		{{q{unexpectedToken},             q{G_VARIANT_PARSE_ERROR_UNEXPECTED_TOKEN}}},
		{{q{unknownKeyword},              q{G_VARIANT_PARSE_ERROR_UNKNOWN_KEYWORD}}},
		{{q{unTerminatedStringConstant},  q{G_VARIANT_PARSE_ERROR_UNTERMINATED_STRING_CONSTANT}}},
		{{q{valueExpected},               q{G_VARIANT_PARSE_ERROR_VALUE_EXPECTED}}},
		{{q{recursion},                   q{G_VARIANT_PARSE_ERROR_RECURSION}}},
	];
	return ret;
}()));

struct GVariantDict{
	union{
		struct{
			GVariant* asv;
			size_t partialMagic;
			alias partial_magic = partialMagic;
			size_t[14] y;
		}
		size_t[16] x;
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{void}, q{g_variant_unref}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_ref}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_ref_sink}, q{GVariant* value}},
			{q{gboolean}, q{g_variant_is_floating}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_take_ref}, q{GVariant* value}},
			{q{const(GVariantType)*}, q{g_variant_get_type}, q{GVariant* value}},
			{q{const(char)*}, q{g_variant_get_type_string}, q{GVariant* value}},
			{q{gboolean}, q{g_variant_is_of_type}, q{GVariant* value, const(GVariantType)* type}},
			{q{gboolean}, q{g_variant_is_container}, q{GVariant* value}},
			{q{GVariantClass}, q{g_variant_classify}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_new_boolean}, q{gboolean value}},
			{q{GVariant*}, q{g_variant_new_byte}, q{ubyte value}},
			{q{GVariant*}, q{g_variant_new_int16}, q{short value}},
			{q{GVariant*}, q{g_variant_new_uint16}, q{ushort value}},
			{q{GVariant*}, q{g_variant_new_int32}, q{int value}},
			{q{GVariant*}, q{g_variant_new_uint32}, q{uint value}},
			{q{GVariant*}, q{g_variant_new_int64}, q{long value}},
			{q{GVariant*}, q{g_variant_new_uint64}, q{ulong value}},
			{q{GVariant*}, q{g_variant_new_handle}, q{int value}},
			{q{GVariant*}, q{g_variant_new_double}, q{double value}},
			{q{GVariant*}, q{g_variant_new_string}, q{const(char)* string}},
			{q{GVariant*}, q{g_variant_new_object_path}, q{const(char)* objectPath}},
			{q{gboolean}, q{g_variant_is_object_path}, q{const(char)* string}},
			{q{GVariant*}, q{g_variant_new_signature}, q{const(char)* signature}},
			{q{gboolean}, q{g_variant_is_signature}, q{const(char)* string}},
			{q{GVariant*}, q{g_variant_new_variant}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_new_strv}, q{const(char*)* strv, ptrdiff_t length}},
			{q{GVariant*}, q{g_variant_new_bytestring}, q{const(char)* string}},
			{q{GVariant*}, q{g_variant_new_bytestring_array}, q{const(char*)* strv, ptrdiff_t length}},
			{q{GVariant*}, q{g_variant_new_fixed_array}, q{const(GVariantType)* elementType, const(void)* elements, size_t nElements, size_t elementSize}},
			{q{gboolean}, q{g_variant_get_boolean}, q{GVariant* value}},
			{q{ubyte}, q{g_variant_get_byte}, q{GVariant* value}},
			{q{short}, q{g_variant_get_int16}, q{GVariant* value}},
			{q{ushort}, q{g_variant_get_uint16}, q{GVariant* value}},
			{q{int}, q{g_variant_get_int32}, q{GVariant* value}},
			{q{uint}, q{g_variant_get_uint32}, q{GVariant* value}},
			{q{long}, q{g_variant_get_int64}, q{GVariant* value}},
			{q{ulong}, q{g_variant_get_uint64}, q{GVariant* value}},
			{q{int}, q{g_variant_get_handle}, q{GVariant* value}},
			{q{double}, q{g_variant_get_double}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_get_variant}, q{GVariant* value}},
			{q{const(char)*}, q{g_variant_get_string}, q{GVariant* value, size_t* length}},
			{q{char*}, q{g_variant_dup_string}, q{GVariant* value, size_t* length}},
			{q{const(char)**}, q{g_variant_get_strv}, q{GVariant* value, size_t* length}},
			{q{char**}, q{g_variant_dup_strv}, q{GVariant* value, size_t* length}},
			{q{char**}, q{g_variant_dup_objv}, q{GVariant* value, size_t* length}},
			{q{const(char)*}, q{g_variant_get_bytestring}, q{GVariant* value}},
			{q{char*}, q{g_variant_dup_bytestring}, q{GVariant* value, size_t* length}},
			{q{const(char)**}, q{g_variant_get_bytestring_array}, q{GVariant* value, size_t* length}},
			{q{char**}, q{g_variant_dup_bytestring_array}, q{GVariant* value, size_t* length}},
			{q{GVariant*}, q{g_variant_new_maybe}, q{const(GVariantType)* childType, GVariant* child}},
			{q{GVariant*}, q{g_variant_new_array}, q{const(GVariantType)* childType, const(GVariant*)* children, size_t nChildren}},
			{q{GVariant*}, q{g_variant_new_tuple}, q{const(GVariant*)* children, size_t nChildren}},
			{q{GVariant*}, q{g_variant_new_dict_entry}, q{GVariant* key, GVariant* value}},
			{q{GVariant*}, q{g_variant_get_maybe}, q{GVariant* value}},
			{q{size_t}, q{g_variant_n_children}, q{GVariant* value}},
			{q{void}, q{g_variant_get_child}, q{GVariant* value, size_t index, const(char)* formatString, ...}},
			{q{GVariant*}, q{g_variant_get_child_value}, q{GVariant* value, size_t index}},
			{q{gboolean}, q{g_variant_lookup}, q{GVariant* dictionary, const(char)* key, const(char)* formatString, ...}},
			{q{GVariant*}, q{g_variant_lookup_value}, q{GVariant* dictionary, const(char)* key, const(GVariantType)* expectedType}},
			{q{const(void)*}, q{g_variant_get_fixed_array}, q{GVariant* value, size_t* nElements, size_t elementSize}},
			{q{size_t}, q{g_variant_get_size}, q{GVariant* value}},
			{q{const(void)*}, q{g_variant_get_data}, q{GVariant* value}},
			{q{void}, q{g_variant_store}, q{GVariant* value, void* data}},
			{q{char*}, q{g_variant_print}, q{GVariant* value, gboolean typeAnnotate}},
			{q{GString*}, q{g_variant_print_string}, q{GVariant* value, GString* string, gboolean typeAnnotate}},
			{q{uint}, q{g_variant_hash}, q{const(void)* value}},
			{q{gboolean}, q{g_variant_equal}, q{const(void)* one, const(void)* two}},
			{q{GVariant*}, q{g_variant_get_normal_form}, q{GVariant* value}},
			{q{gboolean}, q{g_variant_is_normal_form}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_byteswap}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_new_from_data}, q{const(GVariantType)* type, const(void)* data, size_t size, gboolean trusted, GDestroyNotify notify, void* userData}},
			{q{GVariantIter*}, q{g_variant_iter_new}, q{GVariant* value}},
			{q{size_t}, q{g_variant_iter_init}, q{GVariantIter* iter, GVariant* value}},
			{q{GVariantIter*}, q{g_variant_iter_copy}, q{GVariantIter* iter}},
			{q{size_t}, q{g_variant_iter_n_children}, q{GVariantIter* iter}},
			{q{void}, q{g_variant_iter_free}, q{GVariantIter* iter}},
			{q{GVariant*}, q{g_variant_iter_next_value}, q{GVariantIter* iter}},
			{q{gboolean}, q{g_variant_iter_next}, q{GVariantIter* iter, const(char)* formatString, ...}},
			{q{gboolean}, q{g_variant_iter_loop}, q{GVariantIter* iter, const(char)* formatString, ...}},
			{q{GQuark}, q{g_variant_parse_error_quark}, q{}, aliases: [q{G_VARIANT_PARSE_ERROR}]},
			{q{GVariantBuilder*}, q{g_variant_builder_new}, q{const(GVariantType)* type}},
			{q{void}, q{g_variant_builder_unref}, q{GVariantBuilder* builder}},
			{q{GVariantBuilder*}, q{g_variant_builder_ref}, q{GVariantBuilder* builder}},
			{q{void}, q{g_variant_builder_init}, q{GVariantBuilder* builder, const(GVariantType)* type}},
			{q{GVariant*}, q{g_variant_builder_end}, q{GVariantBuilder* builder}},
			{q{void}, q{g_variant_builder_clear}, q{GVariantBuilder* builder}},
			{q{void}, q{g_variant_builder_open}, q{GVariantBuilder* builder, const(GVariantType)* type}},
			{q{void}, q{g_variant_builder_close}, q{GVariantBuilder* builder}},
			{q{void}, q{g_variant_builder_add_value}, q{GVariantBuilder* builder, GVariant* value}},
			{q{void}, q{g_variant_builder_add}, q{GVariantBuilder* builder, const(char)* formatString, ...}},
			{q{void}, q{g_variant_builder_add_parsed}, q{GVariantBuilder* builder, const(char)* format, ...}},
			{q{GVariant*}, q{g_variant_new}, q{const(char)* formatString, ...}},
			{q{void}, q{g_variant_get}, q{GVariant* value, const(char)* formatString, ...}},
			{q{GVariant*}, q{g_variant_new_va}, q{const(char)* formatString, const(char)** endPtr, va_list* app}},
			{q{void}, q{g_variant_get_va}, q{GVariant* value, const(char)* formatString, const(char)** endPtr, va_list* app}},
			{q{GVariant*}, q{g_variant_parse}, q{const(GVariantType)* type, const(char)* text, const(char)* limit, const(char)** endPtr, GError** error}},
			{q{GVariant*}, q{g_variant_new_parsed}, q{const(char)* format, ...}},
			{q{GVariant*}, q{g_variant_new_parsed_va}, q{const(char)* format, va_list* app}},
			{q{int}, q{g_variant_compare}, q{const(void)* one, const(void)* two}},
	];
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{GVariant*}, q{g_variant_new_objv}, q{const(char*)* strv, ptrdiff_t length}},
			{q{const(char)**}, q{g_variant_get_objv}, q{GVariant* value, size_t* length}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_variant_check_format_string}, q{GVariant* value, const(char)* formatString, gboolean copyOnly}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,36,0)){
		FnBind[] add = [
			{q{GBytes*}, q{g_variant_get_data_as_bytes}, q{GVariant* value}},
			{q{GVariant*}, q{g_variant_new_from_bytes}, q{const(GVariantType)* type, GBytes* bytes, gboolean trusted}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,38,0)){
		FnBind[] add = [
			{q{GVariant*}, q{g_variant_new_take_string}, q{char* string}},
			{q{GVariant*}, q{g_variant_new_printf}, q{const(char)* formatString, ...}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,40,0)){
		FnBind[] add = [
			{q{char*}, q{g_variant_parse_error_print_context}, q{GError* error, const(char)* sourceStr}},
			{q{GVariantDict*}, q{g_variant_dict_new}, q{GVariant* fromASV}},
			{q{void}, q{g_variant_dict_init}, q{GVariantDict* dict, GVariant* fromASV}},
			{q{gboolean}, q{g_variant_dict_lookup}, q{GVariantDict* dict, const(char)* key, const(char)* formatString, ...}},
			{q{GVariant*}, q{g_variant_dict_lookup_value}, q{GVariantDict* dict, const(char)* key, const(GVariantType)* expectedType}},
			{q{gboolean}, q{g_variant_dict_contains}, q{GVariantDict* dict, const(char)* key}},
			{q{void}, q{g_variant_dict_insert}, q{GVariantDict* dict, const(char)* key, const(char)* formatString, ...}},
			{q{void}, q{g_variant_dict_insert_value}, q{GVariantDict* dict, const(char)* key, GVariant* value}},
			{q{gboolean}, q{g_variant_dict_remove}, q{GVariantDict* dict, const(char)* key}},
			{q{void}, q{g_variant_dict_clear}, q{GVariantDict* dict}},
			{q{GVariant*}, q{g_variant_dict_end}, q{GVariantDict* dict}},
			{q{GVariantDict*}, q{g_variant_dict_ref}, q{GVariantDict* dict}},
			{q{void}, q{g_variant_dict_unref}, q{GVariantDict* dict}},
		];
		ret ~= add;
	}
	return ret;
}()));
