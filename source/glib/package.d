/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib;

import bindbc.glib.config;
import bindbc.glib.codegen;

public import
	glib.alloca,        glib.array,       glib.asyncqueue,
	glib.autocleanups,  glib.backtrace,   glib.base64,
	glib.bytes,         glib.charset,     glib.checksum,
	glib.convert,       glib.dataset,     glib.dir,
	glib.environ,       glib.error,       glib.fileutils,
	glib.hash,          glib.hmac,        glib.hostutils,
	glib.iochannel,     glib.keyfile,     glib.list,
	glib.macros,        glib.main,        glib.mappedfile,
	glib.markup,        glib.mem,         glib.messages,
	glib.node,          glib.option,      glib.pattern,
	glib.poll,          glib.quark,       glib.queue,
	glib.rand,          glib.rcbox,       glib.refcount,
	glib.refstring,     glib.regex,       glib.scanner,
	glib.sequence,      glib.slice,       glib.slist,
	glib.spawn,         glib.string,      glib.thread,
	glib.tree,          glib.types,       glib.unicode,
	glib.utils,         glib.uuid,        glib.variant,
	glib.varianttype,   glib.version_;

static if(!staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("GLib", makeLibPaths(["glib-2.0"]), [
	"glib.array",      "glib.asyncqueue",   "glib.backtrace",
	"glib.base64",     "glib.bytes",        "glib.charset",
	"glib.checksum",   "glib.convert",      "glib.dataset",
	"glib.dir",        "glib.environ",      "glib.error",
	"glib.fileutils",  "glib.hash",         "glib.hmac",
	"glib.hostutils",  "glib.iochannel",    "glib.keyfile",
	"glib.list",       "glib.main",         "glib.mappedfile",
	"glib.markup",     "glib.mem",          "glib.messages",
	"glib.node",       "glib.option",       "glib.pattern",
	"glib.poll",       "glib.quark",        "glib.queue",
	"glib.rand",       "glib.rcbox",        "glib.refcount",
	"glib.refstring",  "glib.regex",        "glib.scanner",
	"glib.sequence",   "glib.slice",        "glib.slist",
	"glib.spawn",      "glib.string",       "glib.thread",
	"glib.tree",       "glib.unicode",      "glib.utils",
	"glib.uuid",       "glib.variant",      "glib.varianttype",
	"glib.version_",
]));
