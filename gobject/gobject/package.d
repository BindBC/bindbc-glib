/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject;

import bindbc.glib.config;
import bindbc.glib.codegen;

public import
	gobject.autocleanups,    gobject.binding,      gobject.bindinggroup,
	gobject.boxed,           gobject.closure,      gobject.enums,
	gobject.glib_enumtypes,  gobject.glib_types,   gobject.marshal,
	gobject.object,          gobject.param,        gobject.paramspecs,
	gobject.signal,          gobject.signalgroup,  gobject.type,
	gobject.typemodule,      gobject.typeplugin,   gobject.value,
	gobject.valuecollector,  gobject.valuetypes;

static if(!staticBinding):
import bindbc.loader;

mixin(makeDynloadFns("GObject", makeLibPaths(["gobject-2.0"]), [
	"gobject.binding",      "gobject.bindinggroup",  "gobject.boxed",
	"gobject.closure",      "gobject.enums",         "gobject.glib_enumtypes",
	"gobject.glib_types",   "gobject.marshal",       "gobject.object",
	"gobject.param",        "gobject.paramspecs",    "gobject.signal",
	"gobject.signalgroup",  "gobject.type",          "gobject.typemodule",
	"gobject.typeplugin",   "gobject.value",         "gobject.valuetypes",
]));
