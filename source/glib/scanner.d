/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.scanner;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.dataset;
import glib.hash;
import glib.types;

alias GScannerMsgFunc = extern(C) void function(GScanner* scanner, char* message, gboolean error) nothrow;

/* Character sets */
enum G_CSET_A_2_Z	= "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
enum G_CSET_a_2_z	= "abcdefghijklmnopqrstuvwxyz";
enum G_CSET_DIGITS = "0123456789";
enum G_CSET_LATINC = "\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317\320\321\322\323\324\325\326\330\331\332\333\334\335\336";
enum G_CSET_LATINS = "\337\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357\360\361\362\363\364\365\366\370\371\372\373\374\375\376\377";

mixin(makeEnumBind(q{GErrorType}, members: (){
	EnumMember[] ret = [
		{{q{unknown},            q{G_ERR_UNKNOWN}}},
		{{q{unexpEOF},           q{G_ERR_UNEXP_EOF}}},
		{{q{unexpEOFInString},   q{G_ERR_UNEXP_EOF_IN_STRING}}},
		{{q{unexpEOFInComment},  q{G_ERR_UNEXP_EOF_IN_COMMENT}}},
		{{q{nonDigitInConst},    q{G_ERR_NON_DIGIT_IN_CONST}}},
		{{q{digitRadix},         q{G_ERR_DIGIT_RADIX}}},
		{{q{floatRadix},         q{G_ERR_FLOAT_RADIX}}},
		{{q{floatMalformed},     q{G_ERR_FLOAT_MALFORMED}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GTokenType}, aliases: [q{GToken}], members: (){
	EnumMember[] ret = [
		{{q{eof},             q{G_TOKEN_EOF}},          q{0}},
		
		{{q{leftParen},       q{G_TOKEN_LEFT_PAREN}},   q{'('}},
		{{q{rightParen},      q{G_TOKEN_RIGHT_PAREN}},  q{')'}},
		{{q{leftCurly},       q{G_TOKEN_LEFT_CURLY}},   q{'{'}},
		{{q{rightCurly},      q{G_TOKEN_RIGHT_CURLY}},  q{'}'}},
		{{q{leftBrace},       q{G_TOKEN_LEFT_BRACE}},   q{'['}},
		{{q{rightBrace},      q{G_TOKEN_RIGHT_BRACE}},  q{']'}},
		{{q{equalSign},       q{G_TOKEN_EQUAL_SIGN}},   q{'='}},
		{{q{comma},           q{G_TOKEN_COMMA}},        q{','}},
		
		{{q{none},            q{G_TOKEN_NONE}},         q{256}},
		
		{{q{error},           q{G_TOKEN_ERROR}}},
		
		{{q{char_},           q{G_TOKEN_CHAR}}},
		{{q{binary},          q{G_TOKEN_BINARY}}},
		{{q{octal},           q{G_TOKEN_OCTAL}}},
		{{q{int_},            q{G_TOKEN_INT}}},
		{{q{hex},             q{G_TOKEN_HEX}}},
		{{q{float_},          q{G_TOKEN_FLOAT}}},
		{{q{string},          q{G_TOKEN_STRING}}},
		
		{{q{symbol},          q{G_TOKEN_SYMBOL}}},
		{{q{identifier},      q{G_TOKEN_IDENTIFIER}}},
		{{q{identifierNull},  q{G_TOKEN_IDENTIFIER_NULL}}},
		
		{{q{commentSingle},   q{G_TOKEN_COMMENT_SINGLE}}},
		{{q{commentMulti},    q{G_TOKEN_COMMENT_MULTI}}},
		
		{{q{last},            q{G_TOKEN_LAST}}},
	];
	return ret;
}()));

union GTokenValue{
	void* vSymbol;
	char* vIdentifier;
	c_ulong vBinary;
	c_ulong vOctal;
	c_ulong vInt;
	ulong vInt64;
	double vFloat;
	c_ulong vHex;
	char* vString;
	char* vComment;
	ubyte vChar;
	uint vError;
	alias v_symbol = vSymbol;
	alias v_identifier = vIdentifier;
	alias v_binary = vBinary;
	alias v_octal = vOctal;
	alias v_int = vInt;
	alias v_int64 = vInt64;
	alias v_float = vFloat;
	alias v_hex = vHex;
	alias v_string = vString;
	alias v_comment = vComment;
	alias v_char = vChar;
	alias v_error = vError;
}

struct GScannerConfig{
	char* cSetSkipCharacters; //= "\t\n";
	char* cSetIdentifierFirst;
	char* cSetIdentifierNth;
	char* cPairCommentSingle; //= "#\n";
	alias cset_skip_characters = cSetSkipCharacters;
	alias cset_identifier_first = cSetIdentifierFirst;
	alias cset_identifier_nth = cSetIdentifierNth;
	alias cpair_comment_single = cPairCommentSingle;
	
	import std.bitmanip: bitfields;
	mixin(bitfields!(
		uint, q{caseSensitive},        1,
		uint, q{skipCommentMulti},     1,
		uint, q{skipCommentSingle},    1,
		uint, q{scanCommentMulti},     1,
		uint, q{scanIdentifier},       1,
		uint, q{scanIdentifier1Char},  1,
		uint, q{scanIdentifierNull},   1,
		uint, q{scanSymbols},          1,
		uint, q{scanBinary},           1,
		uint, q{scanOctal},            1,
		uint, q{scanFloat},            1,
		uint, q{scanHex},              1,
		uint, q{scanHexDollar},        1,
		uint, q{scanStringSq},         1,
		uint, q{scanStringDq},         1,
		uint, q{numbers2Int},          1,
		uint, q{int2Float},            1,
		uint, q{identifier2String},    1,
		uint, q{char2Token},           1,
		uint, q{symbol2Token},         1,
		uint, q{scope0Fallback},       1,
		uint, q{storeInt64},           1,
		uint, q{reserved},             10,
	));
	alias case_sensitive = caseSensitive;
	alias skip_comment_multi = skipCommentMulti;
	alias skip_comment_single = skipCommentSingle;
	alias scan_comment_multi = scanCommentMulti;
	alias scan_identifier = scanIdentifier;
	alias scan_identifier_1char = scanIdentifier1Char;
	alias scan_identifier_NULL = scanIdentifierNull;
	alias scan_symbols = scanSymbols;
	alias scan_binary = scanBinary;
	alias scan_octal = scanOctal;
	alias scan_float = scanFloat;
	alias scan_hex = scanHex;
	alias scan_hex_dollar = scanHexDollar;
	alias scan_string_sq = scanStringSq;
	alias scan_string_dq = scanStringDq;
	alias numbers_2_int = numbers2Int;
	alias int_2_float = int2Float;
	alias identifier_2_string = identifier2String;
	alias char_2_token = char2Token;
	alias symbol_2_token = symbol2Token;
	alias scope_0_fallback = scope0Fallback;
	alias store_int64 = storeInt64;
	
	uint paddingDummy;
}

struct GScanner{
	void* userData;
	uint maxParseErrors;
	alias user_data = userData;
	alias max_parse_errors = maxParseErrors;
	
	uint parseErrors;
	alias parse_errors = parseErrors;
	
	const(char)* inputName;
	alias input_name = inputName;
	
	GData* qData;
	alias qdata = qData;
	
	GScannerConfig* config;
	
	GTokenType token;
	GTokenValue value;
	uint line;
	uint position;
	
	GTokenType nextToken;
	GTokenValue nextValue;
	uint nextLine;
	uint nextPosition;
	alias next_token = nextToken;
	alias next_value = nextValue;
	alias next_line = nextLine;
	alias next_position = nextPosition;
	
	GHashTable* symbolTable;
	int inputFD;
	alias symbol_table = symbolTable;
	alias input_fd = inputFD;
	const(char)* text;
	const(char)* textEnd;
	alias text_end = textEnd;
	char* buffer;
	uint scopeID;
	alias scope_id = scopeID;
	
	GScannerMsgFunc msgHandler;
	alias msg_handler = msgHandler;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GScanner*}, q{g_scanner_new}, q{const(GScannerConfig)* configTempl}},
		{q{void}, q{g_scanner_destroy}, q{GScanner* scanner}},
		{q{void}, q{g_scanner_input_file}, q{GScanner* scanner, int inputFD}},
		{q{void}, q{g_scanner_sync_file_offset}, q{GScanner* scanner}},
		{q{void}, q{g_scanner_input_text}, q{GScanner* scanner, const(char)* text, uint textLen}},
		{q{GTokenType}, q{g_scanner_get_next_token}, q{GScanner* scanner}},
		{q{GTokenType}, q{g_scanner_peek_next_token}, q{GScanner* scanner}},
		{q{GTokenType}, q{g_scanner_cur_token}, q{GScanner* scanner}},
		{q{GTokenValue}, q{g_scanner_cur_value}, q{GScanner* scanner}},
		{q{uint}, q{g_scanner_cur_line}, q{GScanner* scanner}},
		{q{uint}, q{g_scanner_cur_position}, q{GScanner* scanner}},
		{q{gboolean}, q{g_scanner_eof}, q{GScanner* scanner}},
		{q{uint}, q{g_scanner_set_scope}, q{GScanner* scanner, uint scopeID}},
		{q{void}, q{g_scanner_scope_add_symbol}, q{GScanner* scanner, uint scopeID, const(char)* symbol, void* value}},
		{q{void}, q{g_scanner_scope_remove_symbol}, q{GScanner* scanner, uint scopeID, const(char)* symbol}},
		{q{void*}, q{g_scanner_scope_lookup_symbol}, q{GScanner* scanner, uint scopeID, const(char)* symbol}},
		{q{void}, q{g_scanner_scope_foreach_symbol}, q{GScanner* scanner, uint scopeID, GHFunc func, void* userData}},
		{q{void*}, q{g_scanner_lookup_symbol}, q{GScanner* scanner, const(char)* symbol}},
		{q{void}, q{g_scanner_unexp_token}, q{GScanner* scanner, GTokenType expectedToken, const(char)* identifierSpec, const(char)* symbolSpec, const(char)* symbolName, const(char)* message, int isError}},
		{q{void}, q{g_scanner_error}, q{GScanner* scanner, const(char)* format, ...}},
		{q{void}, q{g_scanner_warn}, q{GScanner* scanner, const(char)* format, ...}},
	];
	return ret;
}()));
