/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.poll;

import bindbc.glib.config;
import bindbc.glib.codegen;

alias GPollFunc = extern(C) int function(GPollFD* uFDs, uint nFDs, int timeout) nothrow;

struct GPollFD{
	static if((){
		version(Windows)
			return (void*).sizeof == 8;
		else return false;
	}()){
		long fd;
	}else{
		int fd;
	}
	ushort events;
	ushort revents;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{int}, q{g_poll}, q{GPollFD* fds, uint nFDs, int timeout}},
	];
	return ret;
}()));
