/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.pattern;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.types;

struct GPatternSpec;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GPatternSpec*}, q{g_pattern_spec_new}, q{const(char)* pattern}},
		{q{void}, q{g_pattern_spec_free}, q{GPatternSpec* pSpec}},
		{q{gboolean}, q{g_pattern_spec_equal}, q{GPatternSpec* pSpec1, GPatternSpec* pSpec2}},
		{q{gboolean}, q{g_pattern_match_simple}, q{const(char)* pattern, const(char)* string}},
	];
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{GPatternSpec*}, q{g_pattern_spec_copy}, q{GPatternSpec* pSpec}},
			{q{gboolean}, q{g_pattern_spec_match}, q{GPatternSpec* pSpec, size_t stringLength, const(char)* string, const(char)* stringReversed}},
			{q{gboolean}, q{g_pattern_spec_match_string}, q{GPatternSpec* pSpec, const(char)* string}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{gboolean}, q{g_pattern_match}, q{GPatternSpec* pSpec, uint stringLength, const(char)* string, const(char)* stringReversed}},
			{q{gboolean}, q{g_pattern_match_string}, q{GPatternSpec* pSpec, const(char)* string}},
		];
		ret ~= add;
	}
	return ret;
}()));
