/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.valuecollector;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;

enum{
	G_VALUE_COLLECT_INT      = 'i',
	G_VALUE_COLLECT_LONG     = 'l',
	G_VALUE_COLLECT_INT64    = 'q',
	G_VALUE_COLLECT_DOUBLE   = 'd',
	G_VALUE_COLLECT_POINTER  = 'p',
}

union GTypeCValue{
	int vInt;
	c_long vLong;
	long vInt64;
	double vDouble;
	void* vPointer;
	alias v_int = vInt;
	alias v_long = vLong;
	alias v_int64 = vInt64;
	alias v_double = vDouble;
	alias v_pointer = vPointer;
}

enum G_VALUE_COLLECT_FORMAT_MAX_LENGTH = 8;
