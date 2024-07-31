/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.main;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.iochannel;
import glib.poll;
import glib.slist;
import glib.types;

static if(glibVersion >= Version(2,72,0))
mixin(makeEnumBind(q{GMainContextFlags}, members: (){
	EnumMember[] ret = [
		{{q{none},              q{G_MAIN_CONTEXT_FLAGS_NONE}},               q{0}},
		{{q{ownerlessPolling},  q{G_MAIN_CONTEXT_FLAGS_OWNERLESS_POLLING}},  q{1}},
	];
	return ret;
}()));

struct GMainContext;

struct GMainLoop;

struct GSourcePrivate;

version(Windows){
	alias GPID = void*;
	enum G_PID_FORMAT = "p";
}else{
	alias GPID = int;
	enum G_PID_FORMAT = "i";
}

alias GPid = GPID;

extern(C) nothrow{
	alias GSourceFunc = gboolean function(void* userData);
	static if(glibVersion >= Version(2,58,0))
	alias GSourceOnceFunc = void function(void* userData);
	alias GChildWatchFunc = void function(GPID pid, int waitStatus, void* userData);
	static if(glibVersion >= Version(2,64,0))
	alias GSourceDisposeFunc = void function(GSource* source);
	alias GSourceDummyMarshal = void function();
	alias GClearHandleFunc = void function(uint handleID);
}

struct GSource{
	void* callbackData;
	GSourceCallbackFuncs* callbackFuncs;
	alias callback_data = callbackData;
	alias callback_funcs = callbackFuncs;
	
	const(GSourceFuncs)* sourceFuncs;
	uint refCount;
	alias source_funcs = sourceFuncs;
	alias ref_count = refCount;
	
	GMainContext* context;
	
	int priority;
	uint flags;
	uint sourceID;
	alias source_id = sourceID;
	
	GSList* pollFDs;
	alias poll_fds = pollFDs;
	
	GSource* prev;
	GSource* next;
	
	char* name;
	
	GSourcePrivate* priv;
}

struct GSourceCallbackFuncs{
	extern(C) nothrow{
		alias RefFn = void function(void* cbData);
		alias GetFn = void function(void* cbData, GSource* source, GSourceFunc* func, void** data);
	}
	RefFn ref_;
	RefFn unRef;
	alias unref = unRef;
	GetFn get;
}

struct GSourceFuncs{
	extern(C) nothrow{
		alias PrepareFn = gboolean function(GSource* source, int* timeout);
		alias CheckFn = gboolean function(GSource* source);
		alias DispatchFn = gboolean function(GSource* source, GSourceFunc callback, void* userData);
		alias FinaliseFn = void function(GSource* source);
	}
	PrepareFn prepare;
	CheckFn check;
	DispatchFn dispatch;
	FinaliseFn finalise;
	alias finalize = finalise;
	
	GSourceFunc closureCallback;        
	GSourceDummyMarshal closureMarshal;
}

enum{
	G_PRIORITY_HIGH          = -100,
	G_PRIORITY_DEFAULT       =    0,
	G_PRIORITY_HIGH_IDLE     =  100,
	G_PRIORITY_DEFAULT_IDLE  =  200,
	G_PRIORITY_LOW           =  300,
}

static if(glibVersion >= Version(2,32,0))
enum{
	G_SOURCE_REMOVE    = false,
	G_SOURCE_CONTINUE  = true,
}

static if(glibVersion >= Version(2,64,0)){
	alias GMainContextPusher = void;
	
	pragma(inline,true) nothrow @nogc{
		GMainContextPusher* g_main_context_pusher_new(GMainContext* mainContext){
			g_main_context_push_thread_default(mainContext);
			return cast(GMainContextPusher*)mainContext;
		}
		void g_main_context_pusher_free(GMainContextPusher* pusher){
			g_main_context_pop_thread_default(cast(GMainContext*)pusher);
		}
	}
}

static if(glibVersion < Version(2,56,0))
pragma(inline,true) void g_clear_handle_id(uint* tagPtr, GClearHandleFunc clearFunc) nothrow{
	uint handleID = *tagPtr;
	if(handleID > 0){
		*tagPtr = 0;
		clearFunc(handleID);
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
			{q{GMainContext*}, q{g_main_context_new}, q{}},
			{q{GMainContext*}, q{g_main_context_ref}, q{GMainContext* context}},
			{q{void}, q{g_main_context_unref}, q{GMainContext* context}},
			{q{GMainContext*}, q{g_main_context_default}, q{}},
			{q{gboolean}, q{g_main_context_iteration}, q{GMainContext* context, gboolean mayBlock}},
			{q{gboolean}, q{g_main_context_pending}, q{GMainContext* context}},
			{q{GSource*}, q{g_main_context_find_source_by_id}, q{GMainContext* context, uint sourceID}},
			{q{GSource*}, q{g_main_context_find_source_by_user_data}, q{GMainContext* context, void* userData}},
			{q{GSource*}, q{g_main_context_find_source_by_funcs_user_data}, q{GMainContext* context, GSourceFuncs* funcs, void* userData}},
			{q{void}, q{g_main_context_wakeup}, q{GMainContext* context}},
			{q{gboolean}, q{g_main_context_acquire}, q{GMainContext* context}},
			{q{void}, q{g_main_context_release}, q{GMainContext* context}},
			{q{gboolean}, q{g_main_context_is_owner}, q{GMainContext* context}},
			{q{gboolean}, q{g_main_context_prepare}, q{GMainContext* context, int* priority}},
			{q{int}, q{g_main_context_query}, q{GMainContext* context, int maxPriority, int* timeout, GPollFD* fds, int nFDs}},
			{q{gboolean}, q{g_main_context_check}, q{GMainContext* context, int maxPriority, GPollFD* fds, int nFDs}},
			{q{void}, q{g_main_context_dispatch}, q{GMainContext* context}},
			{q{void}, q{g_main_context_set_poll_func}, q{GMainContext* context, GPollFunc func}},
			{q{GPollFunc}, q{g_main_context_get_poll_func}, q{GMainContext* context}},
			{q{void}, q{g_main_context_add_poll}, q{GMainContext* context, GPollFD* fd, int priority}},
			{q{void}, q{g_main_context_remove_poll}, q{GMainContext* context, GPollFD* fd}},
			{q{int}, q{g_main_depth}, q{}},
			{q{GSource*}, q{g_main_current_source}, q{}},
			{q{void}, q{g_main_context_push_thread_default}, q{GMainContext* context}},
			{q{void}, q{g_main_context_pop_thread_default}, q{GMainContext* context}},
			{q{GMainContext*}, q{g_main_context_get_thread_default}, q{}},
			{q{GMainContext*}, q{g_main_context_ref_thread_default}, q{}},
			{q{GMainLoop*}, q{g_main_loop_new}, q{GMainContext* context, gboolean isRunning}},
			{q{void}, q{g_main_loop_run}, q{GMainLoop* loop}},
			{q{void}, q{g_main_loop_quit}, q{GMainLoop* loop}},
			{q{GMainLoop*}, q{g_main_loop_ref}, q{GMainLoop* loop}},
			{q{void}, q{g_main_loop_unref}, q{GMainLoop* loop}},
			{q{gboolean}, q{g_main_loop_is_running}, q{GMainLoop* loop}},
			{q{GMainContext*}, q{g_main_loop_get_context}, q{GMainLoop* loop}},
			{q{GSource*}, q{g_source_new}, q{GSourceFuncs* sourceFuncs, uint structSize}},
			{q{GSource*}, q{g_source_ref}, q{GSource* source}},
			{q{void}, q{g_source_unref}, q{GSource* source}},
			{q{uint}, q{g_source_attach}, q{GSource* source, GMainContext* context}},
			{q{void}, q{g_source_destroy}, q{GSource* source}},
			{q{void}, q{g_source_set_priority}, q{GSource* source, int priority}},
			{q{int}, q{g_source_get_priority}, q{GSource* source}},
			{q{void}, q{g_source_set_can_recurse}, q{GSource* source, gboolean canRecurse}},
			{q{gboolean}, q{g_source_get_can_recurse}, q{GSource* source}},
			{q{uint}, q{g_source_get_id}, q{GSource* source}},
			{q{GMainContext*}, q{g_source_get_context}, q{GSource* source}},
			{q{void}, q{g_source_set_callback}, q{GSource* source, GSourceFunc func, void* data, GDestroyNotify notify}},
			{q{void}, q{g_source_set_funcs}, q{GSource* source, GSourceFuncs* funcs}},
			{q{gboolean}, q{g_source_is_destroyed}, q{GSource* source}},
			{q{void}, q{g_source_set_name}, q{GSource* source, const(char)* name}},
			{q{const(char)*}, q{g_source_get_name}, q{GSource* source}},
			{q{void}, q{g_source_set_name_by_id}, q{uint tag, const(char)* name}},
			{q{void}, q{g_source_set_callback_indirect}, q{GSource* source, void* callbackData, GSourceCallbackFuncs* callbackFuncs}},
			{q{void}, q{g_source_add_poll}, q{GSource* source, GPollFD* fd}},
			{q{void}, q{g_source_remove_poll}, q{GSource* source, GPollFD* fd}},
			{q{void}, q{g_source_add_child_source}, q{GSource* source, GSource* childSource}},
			{q{void}, q{g_source_remove_child_source}, q{GSource* source, GSource* childSource}},
			{q{long}, q{g_source_get_time}, q{GSource* source}},
			{q{GSource*}, q{g_idle_source_new}, q{}},
			{q{GSource*}, q{g_child_watch_source_new}, q{GPID pid}},
			{q{GSource*}, q{g_timeout_source_new}, q{uint interval}},
			{q{GSource*}, q{g_timeout_source_new_seconds}, q{uint interval}},
			{q{long}, q{g_get_monotonic_time}, q{}},
			{q{long}, q{g_get_real_time}, q{}},
			{q{gboolean}, q{g_source_remove}, q{uint tag}},
			{q{gboolean}, q{g_source_remove_by_user_data}, q{void* userData}},
			{q{gboolean}, q{g_source_remove_by_funcs_user_data}, q{GSourceFuncs* funcs, void* userData}},
			{q{uint}, q{g_timeout_add_full}, q{int priority, uint interval, GSourceFunc function_, void* data, GDestroyNotify notify}},
			{q{uint}, q{g_timeout_add}, q{uint interval, GSourceFunc function_, void* data}},
			{q{uint}, q{g_timeout_add_seconds_full}, q{int priority, uint interval, GSourceFunc function_, void* data, GDestroyNotify notify}},
			{q{uint}, q{g_timeout_add_seconds}, q{uint interval, GSourceFunc function_, void* data}},
			{q{uint}, q{g_child_watch_add_full}, q{int priority, GPID pid, GChildWatchFunc function_, void* data, GDestroyNotify notify}},
			{q{uint}, q{g_child_watch_add}, q{GPID pid, GChildWatchFunc function_, void* data}},
			{q{uint}, q{g_idle_add}, q{GSourceFunc function_, void* data}},
			{q{uint}, q{g_idle_add_full}, q{int priority, GSourceFunc function_, void* data, GDestroyNotify notify}},
			{q{gboolean}, q{g_idle_remove_by_data}, q{void* data}},
			{q{void}, q{g_main_context_invoke_full}, q{GMainContext* context, int priority, GSourceFunc function_, void* data, GDestroyNotify notify}},
			{q{void}, q{g_main_context_invoke}, q{GMainContext* context, GSourceFunc function_, void* data}},
	];
	if(glibVersion >= Version(2,36,0)){
		{
			FnBind[] add = [
				{q{void}, q{g_source_set_ready_time}, q{GSource* source, long readyTime}},
				{q{long}, q{g_source_get_ready_time}, q{GSource* source}},
			];
			ret ~= add;
		}
		version(Posix){{
			FnBind[] add = [
				{q{void*}, q{g_source_add_unix_fd}, q{GSource* source, int fd, GIOCondition events}},
				{q{void}, q{g_source_modify_unix_fd}, q{GSource* source, void* tag, GIOCondition newEvents}},
				{q{void}, q{g_source_remove_unix_fd}, q{GSource* source, void* tag}},
				{q{GIOCondition}, q{g_source_query_unix_fd}, q{GSource* source, void* tag}},
			];
			ret ~= add;
		}}
	}
	if(glibVersion >= Version(2,56,0)){
		FnBind[] add = [
			{q{void}, q{g_clear_handle_id}, q{uint* tagPtr, GClearHandleFunc clearFunc}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,64,0)){
		FnBind[] add = [
			{q{void}, q{g_source_set_dispose_function}, q{GSource* source, GSourceDisposeFunc dispose}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{void}, q{g_source_set_static_name}, q{GSource* source, const(char)* name}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,72,0)){
		FnBind[] add = [
			{q{GMainContext*}, q{g_main_context_new_with_flags}, q{GMainContextFlags flags}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		FnBind[] add = [
			{q{uint}, q{g_timeout_add_once}, q{uint interval, GSourceOnceFunc function_, void* data}},
			{q{uint}, q{g_idle_add_once}, q{GSourceOnceFunc function_, void* data}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,78,0)){
		FnBind[] add = [
			{q{uint}, q{g_timeout_add_seconds_once}, q{uint interval, GSourceOnceFunc function_, void* data}},
		];
		ret ~= add;
	}
	return ret;
}()));
