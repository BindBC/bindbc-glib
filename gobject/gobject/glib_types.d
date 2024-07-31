/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.glib_types;

import bindbc.glib.config;
import bindbc.glib.codegen;

import gobject.type;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{g_date_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_DATE}]},
		{q{GType}, q{g_strv_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_STRV}]},
		{q{GType}, q{g_gstring_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_GSTRING}]},
		{q{GType}, q{g_hash_table_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_HASH_TABLE}]},
		{q{GType}, q{g_array_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_ARRAY}]},
		{q{GType}, q{g_byte_array_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_BYTE_ARRAY}]},
		{q{GType}, q{g_ptr_array_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_PTR_ARRAY}]},
		{q{GType}, q{g_bytes_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_BYTES}]},
		{q{GType}, q{g_variant_type_get_gtype}, q{}, attr: q{pure}, aliases: [q{G_TYPE_VARIANT_TYPE}]},
		{q{GType}, q{g_regex_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_REGEX}]},
		{q{GType}, q{g_error_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_ERROR}]},
		{q{GType}, q{g_date_time_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_DATE_TIME}]},
		{q{GType}, q{g_time_zone_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_TIME_ZONE}]},
		{q{GType}, q{g_io_channel_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_IO_CHANNEL}]},
		{q{GType}, q{g_io_condition_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_IO_CONDITION}]},
		{q{GType}, q{g_variant_builder_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_VARIANT_BUILDER}]},
		{q{GType}, q{g_key_file_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_KEY_FILE}]},
	];
	if(glibVersion >= Version(2,30,0)){
		FnBind[] add = [
			{q{GType}, q{g_match_info_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_MATCH_INFO}]},
			{q{GType}, q{g_main_loop_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_MAIN_LOOP}]},
			{q{GType}, q{g_main_context_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_MAIN_CONTEXT}]},
			{q{GType}, q{g_source_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_SOURCE}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,36,0)){
		FnBind[] add = [
			{q{GType}, q{g_pollfd_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_POLLFD}]},
			{q{GType}, q{g_thread_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_THREAD}]},
			{q{GType}, q{g_checksum_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_CHECKSUM}]},
			{q{GType}, q{g_markup_parse_context_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_MARKUP_PARSE_CONTEXT}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,40,0)){
		FnBind[] add = [
			{q{GType}, q{g_variant_dict_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_VARIANT_DICT}]},
			{q{GType}, q{g_mapped_file_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_MAPPED_FILE}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,44,0)){
		FnBind[] add = [
			{q{GType}, q{g_option_group_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_OPTION_GROUP}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,66,0)){
		FnBind[] add = [
			{q{GType}, q{g_uri_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_URI}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{GType}, q{g_tree_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_TREE}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{GType}, q{g_pattern_spec_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_PATTERN_SPEC}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,76,0)){
		FnBind[] add = [
			{q{GType}, q{g_bookmark_file_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_BOOKMARK_FILE}]},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,80,0)){
		FnBind[] add = [
			{q{GType}, q{g_hmac_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_HMAC}]},
			{q{GType}, q{g_dir_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_DIR}]},
			{q{GType}, q{g_rand_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_RAND}]},
			{q{GType}, q{g_strv_builder_get_type}, q{}, attr: q{pure}, aliases: [q{G_TYPE_STRV_BUILDER}]},
		];
		ret ~= add;
	}
	return ret;
}()));
