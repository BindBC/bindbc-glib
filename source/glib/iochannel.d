/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.iochannel;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.convert;
import glib.error;
import glib.main;
import glib.quark;
import glib.string;
import glib.types;

mixin(makeEnumBind(q{GIOCondition}, members: (){
	EnumMember[] ret = [
		{{q{in_},   q{G_IO_IN}},    q{1}},
		{{q{out_},  q{G_IO_OUT}},   q{4}},
		{{q{pri},   q{G_IO_PRI}},   q{2}},
		{{q{err},   q{G_IO_ERR}},   q{8}},
		{{q{hUp},   q{G_IO_HUP}},   q{16}},
		{{q{nVal},  q{G_IO_NVAL}},  q{32}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GIOError}, members: (){
	EnumMember[] ret = [
		{{q{none},     q{G_IO_ERROR_NONE}}},
		{{q{again},    q{G_IO_ERROR_AGAIN}}},
		{{q{inval},    q{G_IO_ERROR_INVAL}}},
		{{q{unknown},  q{G_IO_ERROR_UNKNOWN}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GIOChannelError}, members: (){
	EnumMember[] ret = [
		{{q{fBig},      q{G_IO_CHANNEL_ERROR_FBIG}}},
		{{q{inval},     q{G_IO_CHANNEL_ERROR_INVAL}}},
		{{q{io},        q{G_IO_CHANNEL_ERROR_IO}}},
		{{q{isDir},     q{G_IO_CHANNEL_ERROR_ISDIR}}},
		{{q{noSpc},     q{G_IO_CHANNEL_ERROR_NOSPC}}},
		{{q{nxio},      q{G_IO_CHANNEL_ERROR_NXIO}}},
		{{q{overflow},  q{G_IO_CHANNEL_ERROR_OVERFLOW}}},
		{{q{pipe},      q{G_IO_CHANNEL_ERROR_PIPE}}},
		{{q{failed},    q{G_IO_CHANNEL_ERROR_FAILED}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GIOStatus}, members: (){
	EnumMember[] ret = [
		{{q{error},   q{G_IO_STATUS_ERROR}}},
		{{q{normal},  q{G_IO_STATUS_NORMAL}}},
		{{q{eof},     q{G_IO_STATUS_EOF}}},
		{{q{again},   q{G_IO_STATUS_AGAIN}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GSeekType}, members: (){
	EnumMember[] ret = [
		{{q{cur},  q{G_SEEK_CUR}}},
		{{q{set},  q{G_SEEK_SET}}},
		{{q{end},  q{G_SEEK_END}}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GIOFlags}, aliases: [q{GIOFlag}], members: (){
	EnumMember[] ret = [
		{{q{append},       q{G_IO_FLAG_APPEND}},        q{1 << 0}},
		{{q{nonBlock},     q{G_IO_FLAG_NONBLOCK}},      q{1 << 1}},
		{{q{isReadable},   q{G_IO_FLAG_IS_READABLE}},   q{1 << 2}},
		{{q{isWritable},   q{G_IO_FLAG_IS_WRITABLE}},   q{1 << 3}},
		{{q{isWriteable},  q{G_IO_FLAG_IS_WRITEABLE}},  q{1 << 3}},
		{{q{isSeekable},   q{G_IO_FLAG_IS_SEEKABLE}},   q{1 << 4}},
		{{q{mask},         q{G_IO_FLAG_MASK}},          q{(1 << 5) - 1}},
		{{q{getMask},      q{G_IO_FLAG_GET_MASK}},      q{GIOFlag.mask}},
		{{q{setMask},      q{G_IO_FLAG_SET_MASK}},      q{GIOFlag.append | GIOFlag.nonBlock}},
	];
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{none},     q{G_IO_FLAG_NONE}},          q{0}},
		];
		ret ~= add;
	}
	return ret;
}()));

struct GIOChannel{
	int refCount;
	alias ref_count = refCount;
	GIOFuncs* funcs;
	
	char* encoding;
	GIConv readCD;
	GIConv writeCD;
	char* lineTerm;
	uint lineTermLen;
	alias read_cd = readCD;
	alias write_cd = writeCD;
	alias line_term = lineTerm;
	alias line_term_len = lineTermLen;
	
	size_t bufSize;
	GString* readBuf;
	GString* encodedReadBuf;
	GString* writeBuf;
	char[6] partialWriteBuf;
	alias buf_size = bufSize;
	alias read_buf = readBuf;
	alias encoded_read_buf = encodedReadBuf;
	alias write_buf = writeBuf;
	alias partial_write_buf = partialWriteBuf;
	
	import std.bitmanip: bitfields;
	mixin(bitfields!(
		uint, q{useBuffer},     1,
		uint, q{doEncode},      1,
		uint, q{closeOnUnRef},  1,
		uint, q{isReadable},    1,
		uint, q{isWriteable},   1,
		uint, q{isSeekable},    1,
		uint, q{reserved},      2,
	));
	alias use_buffer = useBuffer;
	alias do_encode = doEncode;
	alias close_on_unref = closeOnUnRef;
	alias is_readable = isReadable;
	alias is_writeable = isWriteable;
	alias is_seekable = isSeekable;
	
	void* reserved1;
	void* reserved2;
}

alias GIOFunc = extern(C) gboolean function(GIOChannel* source, GIOCondition condition, void* data) nothrow;

struct GIOFuncs{
	extern(C) nothrow{
		alias IOReadFn = GIOStatus function(GIOChannel* channel, char* buf, size_t count, size_t* bytesRead, GError** err);
		alias IOWriteFn = GIOStatus function(GIOChannel* channel, const(char)* buf, size_t count, size_t* bytesWritten, GError** err);
		alias IOSeekFn = GIOStatus function(GIOChannel* channel, long offset, GSeekType type, GError** err);
		alias IOCloseFn = GIOStatus function(GIOChannel* channel, GError** err);
		alias IOCreateWatchFn = GSource function(GIOChannel* channel, GIOCondition condition);
		alias IOFreeFn = void function(GIOChannel* channel);
		alias IOSetFlagsFn = GIOStatus function(GIOChannel* channel, GIOFlags flags, GError** err);
		alias IOGetFlagsFn = GIOFlags function(GIOChannel* channel);
	}
	IOReadFn ioRead;
	IOWriteFn ioWrite;
	IOSeekFn ioSeek;
	IOCloseFn ioClose;
	IOCreateWatchFn ioCreateWatch;
	IOFreeFn ioFree;
	IOSetFlagsFn ioSetFlags;
	IOGetFlagsFn ioGetFlags;
	alias io_read = ioRead;
	alias io_write = ioWrite;
	alias io_seek = ioSeek;
	alias io_close = ioClose;
	alias io_create_watch = ioCreateWatch;
	alias io_free = ioFree;
	alias io_set_flags = ioSetFlags;
	alias io_get_flags = ioGetFlags;
}

version(Windows){
	enum G_WIN32_MSG_HANDLE = 19981206;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{g_io_channel_init}, q{GIOChannel* channel}},
		{q{GIOChannel*}, q{g_io_channel_ref}, q{GIOChannel* channel}},
		{q{void}, q{g_io_channel_unref}, q{GIOChannel* channel}},
		{q{GIOStatus}, q{g_io_channel_shutdown}, q{GIOChannel* channel, gboolean flush, GError** err}},
		{q{uint}, q{g_io_add_watch_full}, q{GIOChannel* channel, int priority, GIOCondition condition, GIOFunc func, void* userData, GDestroyNotify notify}},
		{q{GSource*}, q{g_io_create_watch}, q{GIOChannel* channel, GIOCondition condition}},
		{q{uint}, q{g_io_add_watch}, q{GIOChannel* channel, GIOCondition condition, GIOFunc func, void* userData}},
		{q{void}, q{g_io_channel_set_buffer_size}, q{GIOChannel* channel, size_t size}},
		{q{size_t}, q{g_io_channel_get_buffer_size}, q{GIOChannel* channel}},
		{q{GIOCondition}, q{g_io_channel_get_buffer_condition}, q{GIOChannel* channel}},
		{q{GIOStatus}, q{g_io_channel_set_flags}, q{GIOChannel* channel, GIOFlags flags, GError** error}},
		{q{GIOFlags}, q{g_io_channel_get_flags}, q{GIOChannel* channel}},
		{q{void}, q{g_io_channel_set_line_term}, q{GIOChannel* channel, const(char)* lineTerm, int length}},
		{q{const(char)*}, q{g_io_channel_get_line_term}, q{GIOChannel* channel, int* length}},
		{q{void}, q{g_io_channel_set_buffered}, q{GIOChannel* channel, gboolean buffered}},
		{q{gboolean}, q{g_io_channel_get_buffered}, q{GIOChannel* channel}},
		{q{GIOStatus}, q{g_io_channel_set_encoding}, q{GIOChannel* channel, const(char)* encoding, GError** error}},
		{q{const(char)*}, q{g_io_channel_get_encoding}, q{GIOChannel* channel}},
		{q{void}, q{g_io_channel_set_close_on_unref}, q{GIOChannel* channel, gboolean doClose}},
		{q{gboolean}, q{g_io_channel_get_close_on_unref}, q{GIOChannel* channel}},
		{q{GIOStatus}, q{g_io_channel_flush}, q{GIOChannel* channel, GError** error}},
		{q{GIOStatus}, q{g_io_channel_read_line}, q{GIOChannel* channel, char** strReturn, size_t* length, size_t* terminatorPos, GError** error}},
		{q{GIOStatus}, q{g_io_channel_read_line_string}, q{GIOChannel* channel, GString* buffer, size_t* terminatorPos, GError** error}},
		{q{GIOStatus}, q{g_io_channel_read_to_end}, q{GIOChannel* channel, char** strReturn, size_t* length, GError** error}},
		{q{GIOStatus}, q{g_io_channel_read_chars}, q{GIOChannel* channel, char* buf, size_t count, size_t* bytesRead, GError** error}},
		{q{GIOStatus}, q{g_io_channel_read_unichar}, q{GIOChannel* channel, dchar* theChar, GError** error}},
		{q{GIOStatus}, q{g_io_channel_write_chars}, q{GIOChannel* channel, const(char)* buf, ptrdiff_t count, size_t* bytesWritten, GError** error}},
		{q{GIOStatus}, q{g_io_channel_write_unichar}, q{GIOChannel* channel, dchar theChar, GError** error}},
		{q{GIOStatus}, q{g_io_channel_seek_position}, q{GIOChannel* channel, long offset, GSeekType type, GError** error}},
		{q{GIOChannel*}, q{g_io_channel_new_file}, q{const(char)* filename, const(char)* mode, GError** error}},
		{q{GQuark}, q{g_io_channel_error_quark}, q{}, aliases: [q{G_IO_CHANNEL_ERROR}]},
		{q{GIOChannelError}, q{g_io_channel_error_from_errno}, q{int en}},
		{q{GIOChannel*}, q{g_io_channel_unix_new}, q{int fd}},
		{q{int}, q{g_io_channel_unix_get_fd}, q{GIOChannel* channel}},
	];
	version(Windows){
		{
			FnBind[] add = [
				{q{void}, q{g_io_channel_win32_make_pollfd}, q{GIOChannel* channel, GIOCondition condition, GPollFD* fd}},
				{q{int}, q{g_io_channel_win32_poll}, q{GPollFD* fds, int nFDs, int timeout}},
				{q{GIOChannel*}, q{g_io_channel_win32_new_fd}, q{int fd}},
				{q{int}, q{g_io_channel_win32_get_fd}, q{GIOChannel* channel}},
				{q{GIOChannel*}, q{g_io_channel_win32_new_socket}, q{int socket}},
				{q{void}, q{g_io_channel_win32_set_debug}, q{GIOChannel* channel, gboolean flag}},
			];
			ret ~= add;
		}
		version(D_LP64){{
			FnBind[] add = [
				{q{GIOChannel*}, q{g_io_channel_win32_new_messages}, q{size_t hwnd}},
			];
			ret ~= add;
		}}else{{
			FnBind[] add = [
				{q{GIOChannel*}, q{g_io_channel_win32_new_messages}, q{uint hwnd}},
			];
			ret ~= add;
		}}
	}
	return ret;
}()));
