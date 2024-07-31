/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.autocleanups;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import glib.main;
import glib.refstring;

mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GAsyncQueue", "g_async_queue_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GBytes", "g_bytes_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GChecksum", "g_checksum_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GDir", "g_dir_close"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GError", "g_error_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GHashTable", "g_hash_table_unref"));
static if(glibVersion >= Version(2,30,0))
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GHmac", "g_hmac_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GIOChannel", "g_io_channel_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GKeyFile", "g_key_file_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GList", "g_list_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GArray", "g_array_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GPtrArray", "g_ptr_array_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GByteArray", "g_byte_array_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GMainContext", "g_main_context_unref"));
static if(glibVersion >= Version(2,64,0))
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GMainContextPusher", "g_main_context_pusher_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GMainLoop", "g_main_loop_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GSource", "g_source_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GMappedFile", "g_mapped_file_unref"));
static if(glibVersion >= Version(2,36,0))
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GMarkupParseContext", "g_markup_parse_context_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GNode", "g_node_destroy"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GOptionContext", "g_option_context_free"));
static if(glibVersion >= Version(2,44,0))
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GOptionGroup", "g_option_group_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GPatternSpec", "g_pattern_spec_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GQueue", "g_queue_free"));
mixin(G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC("GQueue", "g_queue_clear"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GRand", "g_rand_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GRegex", "g_regex_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GMatchInfo", "g_match_info_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GScanner", "g_scanner_destroy"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GSequence", "g_sequence_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GSList", "g_slist_free"));
//mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GString", "g_autoptr_cleanup_gstring_free"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GTree", "g_tree_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GVariant", "g_variant_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GVariantBuilder", "g_variant_builder_unref"));
mixin(G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC("GVariantBuilder", "g_variant_builder_clear"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GVariantIter", "g_variant_iter_free"));
static if(glibVersion >= Version(2,40,0)){
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GVariantDict", "g_variant_dict_unref"));
mixin(G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC("GVariantDict", "g_variant_dict_clear"));
}
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GVariantType", "g_variant_type_free"));
static if(glibVersion >= Version(2,16,0))
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GRefString", "g_ref_string_release"));
