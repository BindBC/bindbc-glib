/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.regex;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.quark;
import glib.string;
import glib.types;

mixin(makeEnumBind(q{GRegexError}, members: (){
	EnumMember[] ret = [
				{{q{compile},                                   q{G_REGEX_ERROR_COMPILE}}},
				{{q{optimise},                                  q{G_REGEX_ERROR_OPTIMISE}}, aliases: [{q{optimize}, q{G_REGEX_ERROR_OPTIMIZE}}]},
				{{q{replace},                                   q{G_REGEX_ERROR_REPLACE}}},
				{{q{match},                                     q{G_REGEX_ERROR_MATCH}}},
	];
	if(glibVersion >= Version(2,16,0)){
		EnumMember[] add = [
				{{q{internal},                                  q{G_REGEX_ERROR_INTERNAL}}},
				{{q{strayBackslash},                            q{G_REGEX_ERROR_STRAY_BACKSLASH}},                               q{101}},
				{{q{missingControlChar},                        q{G_REGEX_ERROR_MISSING_CONTROL_CHAR}},                          q{102}},
				{{q{unrecognisedEscape},                        q{G_REGEX_ERROR_UNRECOGNISED_ESCAPE}},                           q{103}, aliases: [{q{unrecognizedEscape},q{G_REGEX_ERROR_UNRECOGNIZED_ESCAPE}}]},
				{{q{quantifiersOutOfOrder},                     q{G_REGEX_ERROR_QUANTIFIERS_OUT_OF_ORDER}},                      q{104}},
				{{q{quantifierTooBig},                          q{G_REGEX_ERROR_QUANTIFIER_TOO_BIG}},                            q{105}},
				{{q{unterminatedCharacterClass},                q{G_REGEX_ERROR_UNTERMINATED_CHARACTER_CLASS}},                  q{106}},
				{{q{invalidEscapeInCharacterClass},             q{G_REGEX_ERROR_INVALID_ESCAPE_IN_CHARACTER_CLASS}},             q{107}},
				{{q{rangeOutOfOrder},                           q{G_REGEX_ERROR_RANGE_OUT_OF_ORDER}},                            q{108}},
				{{q{nothingToRepeat},                           q{G_REGEX_ERROR_NOTHING_TO_REPEAT}},                             q{109}},
				{{q{unrecognisedCharacter},                     q{G_REGEX_ERROR_UNRECOGNISED_CHARACTER}},                        q{112}, aliases: [{q{unrecognizedCharacter}, q{G_REGEX_ERROR_UNRECOGNIZED_CHARACTER}}]},
				{{q{posixNamedClassOutsideClass},               q{G_REGEX_ERROR_POSIX_NAMED_CLASS_OUTSIDE_CLASS}},               q{113}},
				{{q{unmatchedParenthesis},                      q{G_REGEX_ERROR_UNMATCHED_PARENTHESIS}},                         q{114}},
				{{q{inexistentSubPatternReference},             q{G_REGEX_ERROR_INEXISTENT_SUBPATTERN_REFERENCE}},               q{115}},
				{{q{unterminatedComment},                       q{G_REGEX_ERROR_UNTERMINATED_COMMENT}},                          q{118}},
				{{q{expressionTooLarge},                        q{G_REGEX_ERROR_EXPRESSION_TOO_LARGE}},                          q{120}},
				{{q{memoryError},                               q{G_REGEX_ERROR_MEMORY_ERROR}},                                  q{121}},
				{{q{variableLengthLookBehind},                  q{G_REGEX_ERROR_VARIABLE_LENGTH_LOOKBEHIND}},                    q{125}},
				{{q{malformedCondition},                        q{G_REGEX_ERROR_MALFORMED_CONDITION}},                           q{126}},
				{{q{tooManyConditionalBranches},                q{G_REGEX_ERROR_TOO_MANY_CONDITIONAL_BRANCHES}},                 q{127}},
				{{q{assertionExpected},                         q{G_REGEX_ERROR_ASSERTION_EXPECTED}},                            q{128}},
				{{q{unknownPosixClassName},                     q{G_REGEX_ERROR_UNKNOWN_POSIX_CLASS_NAME}},                      q{130}},
				{{q{posixCollatingElementsNotSupported},        q{G_REGEX_ERROR_POSIX_COLLATING_ELEMENTS_NOT_SUPPORTED}},        q{131}},
				{{q{hexCodeTooLarge},                           q{G_REGEX_ERROR_HEX_CODE_TOO_LARGE}},                            q{134}},
				{{q{invalidCondition},                          q{G_REGEX_ERROR_INVALID_CONDITION}},                             q{135}},
				{{q{singleByteMatchInLookBehind},               q{G_REGEX_ERROR_SINGLE_BYTE_MATCH_IN_LOOKBEHIND}},               q{136}},
				{{q{infiniteLoop},                              q{G_REGEX_ERROR_INFINITE_LOOP}},                                 q{140}},
				{{q{missingSubPatternNameTerminator},           q{G_REGEX_ERROR_MISSING_SUBPATTERN_NAME_TERMINATOR}},            q{142}},
				{{q{duplicateSubPatternName},                   q{G_REGEX_ERROR_DUPLICATE_SUBPATTERN_NAME}},                     q{143}},
				{{q{malformedProperty},                         q{G_REGEX_ERROR_MALFORMED_PROPERTY}},                            q{146}},
				{{q{unknownProperty},                           q{G_REGEX_ERROR_UNKNOWN_PROPERTY}},                              q{147}},
				{{q{subPatternNameTooLong},                     q{G_REGEX_ERROR_SUBPATTERN_NAME_TOO_LONG}},                      q{148}},
				{{q{tooManySubPatterns},                        q{G_REGEX_ERROR_TOO_MANY_SUBPATTERNS}},                          q{149}},
				{{q{invalidOctalValue},                         q{G_REGEX_ERROR_INVALID_OCTAL_VALUE}},                           q{151}},
				{{q{tooManyBranchesInDefine},                   q{G_REGEX_ERROR_TOO_MANY_BRANCHES_IN_DEFINE}},                   q{154}},
				{{q{defineRepetion},                            q{G_REGEX_ERROR_DEFINE_REPETION}},                               q{155}},
				{{q{inconsistentNewlineOptions},                q{G_REGEX_ERROR_INCONSISTENT_NEWLINE_OPTIONS}},                  q{156}},
				{{q{missingBackReference},                      q{G_REGEX_ERROR_MISSING_BACK_REFERENCE}},                        q{157}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,34,0)){
		EnumMember[] add = [
				{{q{invalidRelativeReference},                  q{G_REGEX_ERROR_INVALID_RELATIVE_REFERENCE}},                    q{158}},
				{{q{backtrackingControlVerbArgumentForbidden},  q{G_REGEX_ERROR_BACKTRACKING_CONTROL_VERB_ARGUMENT_FORBIDDEN}},  q{159}},
				{{q{unknownBacktrackingControlVerb},            q{G_REGEX_ERROR_UNKNOWN_BACKTRACKING_CONTROL_VERB}},             q{160}},
				{{q{numberTooBig},                              q{G_REGEX_ERROR_NUMBER_TOO_BIG}},                                q{161}},
				{{q{missingSubPatternName},                     q{G_REGEX_ERROR_MISSING_SUBPATTERN_NAME}},                       q{162}},
				{{q{missingDigit},                              q{G_REGEX_ERROR_MISSING_DIGIT}},                                 q{163}},
				{{q{invalidDataCharacter},                      q{G_REGEX_ERROR_INVALID_DATA_CHARACTER}},                        q{164}},
				{{q{extraSubPatternName},                       q{G_REGEX_ERROR_EXTRA_SUBPATTERN_NAME}},                         q{165}},
				{{q{backtrackingControlVerbArgumentRequired},   q{G_REGEX_ERROR_BACKTRACKING_CONTROL_VERB_ARGUMENT_REQUIRED}},   q{166}},
				{{q{invalidControlChar},                        q{G_REGEX_ERROR_INVALID_CONTROL_CHAR}},                          q{168}},
				{{q{missingName},                               q{G_REGEX_ERROR_MISSING_NAME}},                                  q{169}},
				{{q{notSupportedInClass},                       q{G_REGEX_ERROR_NOT_SUPPORTED_IN_CLASS}},                        q{171}},
				{{q{tooManyForwardReferences},                  q{G_REGEX_ERROR_TOO_MANY_FORWARD_REFERENCES}},                   q{172}},
				{{q{nameTooLong},                               q{G_REGEX_ERROR_NAME_TOO_LONG}},                                 q{175}},
				{{q{characterValueTooLarge},                    q{G_REGEX_ERROR_CHARACTER_VALUE_TOO_LARGE}},                     q{176}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{GRegexCompileFlags}, aliases: [q{GRegexCompileFlag}], members: (){
	EnumMember[] ret = [
		{{q{caseless},              q{G_REGEX_CASELESS}},           q{1 << 0}},
		{{q{multiLine},             q{G_REGEX_MULTILINE}},          q{1 << 1}},
		{{q{dotAll},                q{G_REGEX_DOTALL}},             q{1 << 2}},
		{{q{extended},              q{G_REGEX_EXTENDED}},           q{1 << 3}},
		{{q{anchored},              q{G_REGEX_ANCHORED}},           q{1 << 4}},
		{{q{dollarEndOnly},         q{G_REGEX_DOLLAR_ENDONLY}},     q{1 << 5}},
		{{q{unGreedy},              q{G_REGEX_UNGREEDY}},           q{1 << 9}},
		{{q{raw},                   q{G_REGEX_RAW}},                q{1 << 11}},
		{{q{noAutoCapture},         q{G_REGEX_NO_AUTO_CAPTURE}},    q{1 << 12}},
		{{q{dupNames},              q{G_REGEX_DUPNAMES}},           q{1 << 19}},
		{{q{newLineCR},             q{G_REGEX_NEWLINE_CR}},         q{1 << 20}},
		{{q{newLineLF},             q{G_REGEX_NEWLINE_LF}},         q{1 << 21}},
		{{q{newLineCRLF},           q{G_REGEX_NEWLINE_CRLF}},       q{GRegexCompileFlag.newLineCR | GRegexCompileFlag.newLineLF}},
	];
	if(glibVersion >= Version(2,34,0)){
		EnumMember[] add = [
			{{q{firstLine},         q{G_REGEX_FIRSTLINE}},          q{1 << 18}},
			{{q{newLineAnyCRLF},    q{G_REGEX_NEWLINE_ANYCRLF}},    q{GRegexCompileFlag.newLineCR | 1 << 22}},
			{{q{bsrAnyCRLF},        q{G_REGEX_BSR_ANYCRLF}},        q{1 << 23}},
			{{q{javaScriptCompat},  q{G_REGEX_JAVASCRIPT_COMPAT}},  q{1 << 25}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{default_},          q{G_REGEX_DEFAULT}},            q{0}},
			{{q{optimise},          q{G_REGEX_OPTIMISE}},           q{1 << 13}, aliases: [{q{optimize}, q{G_REGEX_OPTIMIZE}}]},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{GRegexMatchFlags}, aliases: [q{GRegexMatchFlag}, q{GRegexMatch}], members: (){
	EnumMember[] ret = [
		{{q{anchored},             q{G_REGEX_MATCH_ANCHORED}},          q{1 << 4}},
		{{q{notBOL},               q{G_REGEX_MATCH_NOTBOL}},            q{1 << 7}},
		{{q{notEOL},               q{G_REGEX_MATCH_NOTEOL}},            q{1 << 8}},
		{{q{notEmpty},             q{G_REGEX_MATCH_NOTEMPTY}},          q{1 << 10}},
		{{q{partial},              q{G_REGEX_MATCH_PARTIAL}},           q{1 << 15}, aliases: [{q{partialSoft}, q{G_REGEX_MATCH_PARTIAL_SOFT}}]},
		{{q{newLineCR},            q{G_REGEX_MATCH_NEWLINE_CR}},        q{1 << 20}},
		{{q{newLineLF},            q{G_REGEX_MATCH_NEWLINE_LF}},        q{1 << 21}},
		{{q{newLineCRLF},          q{G_REGEX_MATCH_NEWLINE_CRLF}},      q{GRegexMatch.newLineCR | GRegexMatch.newLineLF}},
		{{q{newLineAny},           q{G_REGEX_MATCH_NEWLINE_ANY}},       q{1 << 22}},
	];
	if(glibVersion >= Version(2,34,0)){
		EnumMember[] add = [
			{{q{newLineAnyCRLF},   q{G_REGEX_MATCH_NEWLINE_ANYCRLF}},   q{GRegexMatch.newLineCR | GRegexMatch.newLineAny}},
			{{q{bsrAnyCRLF},       q{G_REGEX_MATCH_BSR_ANYCRLF}},       q{1 << 23}},
			{{q{bsrAny},           q{G_REGEX_MATCH_BSR_ANY}},           q{1 << 24}},
			{{q{partialHard},      q{G_REGEX_MATCH_PARTIAL_HARD}},      q{1 << 27}},
			{{q{notEmptyAtStart},  q{G_REGEX_MATCH_NOTEMPTY_ATSTART}},  q{1 << 28}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{default_},         q{G_REGEX_MATCH_DEFAULT}},           q{0}},
		];
		ret ~= add;
	}
	return ret;
}()));

alias GRegexEvalCallback = extern(C) gboolean function(const(GMatchInfo)* matchInfo, GString* result, void* userData) nothrow;

struct GRegex;

struct GMatchInfo;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_regex_error_quark}, q{}, aliases: [q{G_REGEX_ERROR}]},
		{q{GRegex*}, q{g_regex_new}, q{const(char)* pattern, GRegexCompileFlags compileOptions, GRegexMatchFlags matchOptions, GError** error}},
		{q{GRegex*}, q{g_regex_ref}, q{GRegex* regex}},
		{q{void}, q{g_regex_unref}, q{GRegex* regex}},
		{q{const(char)*}, q{g_regex_get_pattern}, q{const(GRegex)* regex}},
		{q{int}, q{g_regex_get_max_backref}, q{const(GRegex)* regex}},
		{q{int}, q{g_regex_get_capture_count}, q{const(GRegex)* regex}},
		{q{gboolean}, q{g_regex_get_has_cr_or_lf}, q{const(GRegex)* regex}},
		{q{int}, q{g_regex_get_string_number}, q{const(GRegex)* regex, const(char)* name}},
		{q{char*}, q{g_regex_escape_string}, q{const(char)* string, int length}},
		{q{char*}, q{g_regex_escape_nul}, q{const(char)* string, int length}},
		{q{GRegexCompileFlags}, q{g_regex_get_compile_flags}, q{const(GRegex)* regex}},
		{q{GRegexMatchFlags}, q{g_regex_get_match_flags}, q{const(GRegex)* regex}},
		{q{gboolean}, q{g_regex_match_simple}, q{const(char)* pattern, const(char)* string, GRegexCompileFlags compileOptions, GRegexMatchFlags matchOptions}},
		{q{gboolean}, q{g_regex_match}, q{const(GRegex)* regex, const(char)* string, GRegexMatchFlags matchOptions, GMatchInfo** matchInfo}},
		{q{gboolean}, q{g_regex_match_full}, q{const(GRegex)* regex, const(char)* string, ptrdiff_t stringLen, int startPosition, GRegexMatchFlags matchOptions, GMatchInfo** matchInfo, GError** error}},
		{q{gboolean}, q{g_regex_match_all}, q{const(GRegex)* regex, const(char)* string, GRegexMatchFlags matchOptions, GMatchInfo** matchInfo}},
		{q{gboolean}, q{g_regex_match_all_full}, q{const(GRegex)* regex, const(char)* string, ptrdiff_t stringLen, int startPosition, GRegexMatchFlags matchOptions, GMatchInfo** matchInfo, GError** error}},
		{q{char**}, q{g_regex_split_simple}, q{const(char)* pattern, const(char)* string, GRegexCompileFlags compileOptions, GRegexMatchFlags matchOptions}},
		{q{char**}, q{g_regex_split}, q{const(GRegex)* regex, const(char)* string, GRegexMatchFlags matchOptions}},
		{q{char**}, q{g_regex_split_full}, q{const(GRegex)* regex, const(char)* string, ptrdiff_t stringLen, int startPosition, GRegexMatchFlags matchOptions, int maxTokens, GError** error}},
		{q{char*}, q{g_regex_replace}, q{const(GRegex)* regex, const(char)* string, ptrdiff_t stringLen, int startPosition, const(char)* replacement, GRegexMatchFlags matchOptions, GError** error}},
		{q{char*}, q{g_regex_replace_literal}, q{const(GRegex)* regex, const(char)* string, ptrdiff_t stringLen, int startPosition, const(char)* replacement, GRegexMatchFlags matchOptions, GError** error}},
		{q{char*}, q{g_regex_replace_eval}, q{const(GRegex)* regex, const(char)* string, ptrdiff_t stringLen, int startPosition, GRegexMatchFlags matchOptions, GRegexEvalCallback eval, void* userData, GError** error}},
		{q{gboolean}, q{g_regex_check_replacement}, q{const(char)* replacement, gboolean* hasReferences, GError** error}},
		{q{GRegex*}, q{g_match_info_get_regex}, q{const(GMatchInfo)* matchInfo}},
		{q{const(char)*}, q{g_match_info_get_string}, q{const(GMatchInfo)* matchInfo}},
		{q{GMatchInfo*}, q{g_match_info_ref}, q{GMatchInfo* matchInfo}},
		{q{void}, q{g_match_info_unref}, q{GMatchInfo* matchInfo}},
		{q{void}, q{g_match_info_free}, q{GMatchInfo* matchInfo}},
		{q{gboolean}, q{g_match_info_next}, q{GMatchInfo* matchInfo, GError** error}},
		{q{gboolean}, q{g_match_info_matches}, q{const(GMatchInfo)* matchInfo}},
		{q{int}, q{g_match_info_get_match_count}, q{const(GMatchInfo)* matchInfo}},
		{q{gboolean}, q{g_match_info_is_partial_match}, q{const(GMatchInfo)* matchInfo}},
		{q{char*}, q{g_match_info_expand_references}, q{const(GMatchInfo)* matchInfo, const(char)* stringToExpand, GError** error}},
		{q{char*}, q{g_match_info_fetch}, q{const(GMatchInfo)* matchInfo, int matchNum}},
		{q{gboolean}, q{g_match_info_fetch_pos}, q{const(GMatchInfo)* matchInfo, int matchNum, int* startPos, int* endPos}},
		{q{char*}, q{g_match_info_fetch_named}, q{const(GMatchInfo)* matchInfo, const(char)* name}},
		{q{gboolean}, q{g_match_info_fetch_named_pos}, q{const(GMatchInfo)* matchInfo, const(char)* name, int* startPos, int* endPos}},
		{q{char**}, q{g_match_info_fetch_all}, q{const(GMatchInfo)* matchInfo}},
	];
	if(glibVersion >= Version(2,38,0)){
		FnBind[] add = [
			{q{int}, q{g_regex_get_max_lookbehind}, q{const(GRegex)* regex}},
		];
		ret ~= add;
	}
	return ret;
}()));
