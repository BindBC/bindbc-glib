/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.thread;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.error;
import glib.quark;
import glib.types;
import glib.utils;


mixin(makeEnumBind(q{GThreadError}, members: (){
	EnumMember[] ret = [
		{{q{again},  q{G_THREAD_ERROR_AGAIN}}},
	];
	return ret;
}()));

alias GThreadFunc = extern(C) void* function(void* data) nothrow;

struct GThread;

union GMutex{
	void* p;
	uint[2] i;
}

struct GRWLock{
	void* p;
	uint[2] i;
};

struct GCond{
	void* p;
	uint[2] i;
}

struct GRecMutex{
	void* p;
	uint[2] i;
}

struct GPrivate{
	void* p;
	GDestroyNotify notify;
	void*[2] future;
}

mixin(makeEnumBind(q{GOnceStatus}, members: (){
	EnumMember[] ret = [
		{{q{notCalled},  q{G_ONCE_STATUS_NOTCALLED}}},
		{{q{progress},   q{G_ONCE_STATUS_PROGRESS}}},
		{{q{ready},      q{G_ONCE_STATUS_READY}}},
	];
	return ret;
}()));

struct GOnce{
	GOnceStatus status = GOnceStatus.notCalled; //volatile
	void* retVal; //volatile
}

static if(glibVersion >= Version(2,44,0)){
	alias GMutexLocker = void;
	
	pragma(inline,true) nothrow @nogc{
		GMutexLocker* g_mutex_locker_new(GMutex* mutex){
			g_mutex_lock(mutex);
			return cast(GMutexLocker*)mutex;
		}
		void g_mutex_locker_free(GMutexLocker* locker){
			g_mutex_unlock(cast(GMutex*)locker);
		}
	}
}

static if(glibVersion >= Version(2,60,0)){
	alias GRecMutexLocker = void;
	
	pragma(inline,true) nothrow @nogc{
		GRecMutexLocker* g_rec_mutex_locker_new(GRecMutex* recMutex){
			g_rec_mutex_lock(recMutex);
			return cast(GRecMutexLocker*)recMutex;
		}
		void g_rec_mutex_locker_free(GRecMutexLocker* locker){
			g_rec_mutex_unlock(cast(GRecMutex*)locker);
		}
	}
}

static if(glibVersion >= Version(2,62,0)){
	alias GRWLockWriterLocker = void;
	alias GRWLockReaderLocker = void;
	
	pragma(inline,true) nothrow @nogc{
		GRWLockWriterLocker* g_rw_lock_writer_locker_new(GRWLock* rwLock){
			g_rw_lock_writer_lock(rwLock);
			return cast(GRWLockWriterLocker*)rwLock;
		}
		void g_rw_lock_writer_locker_free(GRWLockWriterLocker* locker){
			g_rw_lock_writer_unlock(cast(GRWLock*)locker);
		}
		
		GRWLockReaderLocker* g_rw_lock_reader_locker_new(GRWLock* rwLock){
			g_rw_lock_reader_lock(rwLock);
			return cast(GRWLockReaderLocker*)rwLock;
		}
		void g_rw_lock_reader_locker_free(GRWLockReaderLocker* locker){
			g_rw_lock_reader_unlock(cast(GRWLock*)locker);
		}
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GQuark}, q{g_thread_error_quark}, q{}, aliases: [q{G_THREAD_ERROR}]},
		{q{GThread*}, q{g_thread_self}, q{}},
		{q{noreturn}, q{g_thread_exit}, q{void* retVal}},
		{q{void*}, q{g_thread_join}, q{GThread* thread}},
		{q{void}, q{g_thread_yield}, q{}},
		{q{void}, q{g_mutex_lock}, q{GMutex* mutex}},
		{q{gboolean}, q{g_mutex_trylock}, q{GMutex* mutex}},
		{q{void}, q{g_mutex_unlock}, q{GMutex* mutex}},
		{q{void}, q{g_cond_wait}, q{GCond* cond, GMutex* mutex}},
		{q{void}, q{g_cond_signal}, q{GCond* cond}},
		{q{void}, q{g_cond_broadcast}, q{GCond* cond}},
		{q{void*}, q{g_private_get}, q{GPrivate* key}},
		{q{void}, q{g_private_set}, q{GPrivate* key, void* value}},
		{q{void*}, q{g_once_impl}, q{GOnce* once, GThreadFunc func, void* arg}},
		{q{gboolean}, q{g_once_init_enter}, q{void* location}},
		{q{void}, q{g_once_init_leave}, q{void* location, size_t result}},
	];
	if(glibVersion >= Version(2,32,0)){
		FnBind[] add = [
			{q{GThread*}, q{g_thread_ref}, q{GThread* thread}},
			{q{void}, q{g_thread_unref}, q{GThread* thread}},
			{q{GThread*}, q{g_thread_new}, q{const(char)* name, GThreadFunc func, void* data}},
			{q{GThread*}, q{g_thread_try_new}, q{const(char)* name, GThreadFunc func, void* data, GError** error}},
			{q{void}, q{g_mutex_init}, q{GMutex* mutex}},
			{q{void}, q{g_mutex_clear}, q{GMutex* mutex}},
			{q{void}, q{g_rw_lock_init}, q{GRWLock* rwLock}},
			{q{void}, q{g_rw_lock_clear}, q{GRWLock* rwLock}},
			{q{void}, q{g_rw_lock_writer_lock}, q{GRWLock* rwLock}},
			{q{gboolean}, q{g_rw_lock_writer_trylock}, q{GRWLock* rwLock}},
			{q{void}, q{g_rw_lock_writer_unlock}, q{GRWLock* rwLock}},
			{q{void}, q{g_rw_lock_reader_lock}, q{GRWLock* rwLock}},
			{q{gboolean}, q{g_rw_lock_reader_trylock}, q{GRWLock* rwLock}},
			{q{void}, q{g_rw_lock_reader_unlock}, q{GRWLock* rwLock}},
			{q{void}, q{g_rec_mutex_init}, q{GRecMutex* recMutex}},
			{q{void}, q{g_rec_mutex_clear}, q{GRecMutex* recMutex}},
			{q{void}, q{g_rec_mutex_lock}, q{GRecMutex* recMutex}},
			{q{gboolean}, q{g_rec_mutex_trylock}, q{GRecMutex* recMutex}},
			{q{void}, q{g_rec_mutex_unlock}, q{GRecMutex* recMutex}},
			{q{void}, q{g_cond_init}, q{GCond* cond}},
			{q{void}, q{g_cond_clear}, q{GCond* cond}},
			{q{gboolean}, q{g_cond_wait_until}, q{GCond* cond, GMutex* mutex, long endTime}},
			{q{void}, q{g_private_replace}, q{GPrivate* key, void* value}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,36,0)){
		FnBind[] add = [
			{q{uint}, q{g_get_num_processors}, q{}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,80,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_once_init_enter_pointer}, q{void* location}},
			{q{void}, q{g_once_init_leave_pointer}, q{void* location, void* result}},
		];
		ret ~= add;
	}
	return ret;
}()));
