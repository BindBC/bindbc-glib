/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.autocleanups;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject;

mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GClosure", "g_closure_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GEnumClass", "g_type_class_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GFlagsClass", "g_type_class_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GObject", "g_object_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GInitiallyUnowned", "g_object_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GParamSpec", "g_param_spec_unref"));
mixin(G_DEFINE_AUTOPTR_CLEANUP_FUNC("GTypeClass", "g_type_class_unref"));
mixin(G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC("GValue", "g_value_unset"));
