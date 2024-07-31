/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.signal;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.closure;
import gobject.marshal;
import gobject.param;
import gobject.type;
import gobject.value;

alias GSignalCMarshaller = GClosureMarshal;
alias GSignalCVaMarshaller = GVaClosureMarshal;

extern(C) nothrow{
	alias GSignalEmissionHook = gboolean function(GSignalInvocationHint* iHint, uint nParamValues, const(GValue)* paramValues, void* data);
	alias GSignalAccumulator = gboolean function(GSignalInvocationHint* iHint, GValue* returnAccu, const(GValue)* handlerReturn, void* data);
}

mixin(makeEnumBind(q{GSignalFlags}, aliases: [q{GSignalFlag}, q{GSignal}], members: (){
	EnumMember[] ret = [
		{{q{runFirst},                 q{G_SIGNAL_RUN_FIRST}},              q{1 << 0}},
		{{q{runLast},                  q{G_SIGNAL_RUN_LAST}},               q{1 << 1}},
		{{q{runCleanup},               q{G_SIGNAL_RUN_CLEANUP}},            q{1 << 2}},
		{{q{noRecurse},                q{G_SIGNAL_NO_RECURSE}},             q{1 << 3}},
		{{q{detailed},                 q{G_SIGNAL_DETAILED}},               q{1 << 4}},
		{{q{action},                   q{G_SIGNAL_ACTION}},                 q{1 << 5}},
		{{q{noHooks},                  q{G_SIGNAL_NO_HOOKS}},               q{1 << 6}},
	];
	if(glibVersion >= Version(2,30,0)){
		EnumMember[] add = [
			{{q{mustCollect},          q{G_SIGNAL_MUST_COLLECT}},           q{1 << 7}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,32,0)){
		EnumMember[] add = [
			{{q{deprecated_},          q{G_SIGNAL_DEPRECATED}},             q{1 << 8}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		EnumMember[] add = [
			{{q{accumulatorFirstRun},  q{G_SIGNAL_ACCUMULATOR_FIRST_RUN}},  q{1 << 17}},
		];
		ret ~= add;
	}
	{
		EnumMember[] add = [
			{{q{mask},                 q{G_SIGNAL_FLAGS_MASK}},             q{0x1FF}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{GConnectFlags}, aliases: [q{GConnectFlag}, q{GConnect}], members: (){
	EnumMember[] ret = [
		{{q{after},         q{G_CONNECT_AFTER}},    q{1 << 0}},
		{{q{swapped},       q{G_CONNECT_SWAPPED}},  q{1 << 1}},
	];
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{default_},  q{G_CONNECT_DEFAULT}},  q{0}},
		];
		ret ~= add;
	}
	return ret;
}()));

mixin(makeEnumBind(q{GSignalMatchType}, aliases: [q{GSignalMatch}], members: (){
	EnumMember[] ret = [
		{{q{id},         q{G_SIGNAL_MATCH_ID}},         q{1 << 0}},
		{{q{detail},     q{G_SIGNAL_MATCH_DETAIL}},     q{1 << 1}},
		{{q{closure},    q{G_SIGNAL_MATCH_CLOSURE}},    q{1 << 2}},
		{{q{func},       q{G_SIGNAL_MATCH_FUNC}},       q{1 << 3}},
		{{q{data},       q{G_SIGNAL_MATCH_DATA}},       q{1 << 4}},
		{{q{unblocked},  q{G_SIGNAL_MATCH_UNBLOCKED}},  q{1 << 5}},
	];
	{
		EnumMember[] add = [
			{{q{mask},   q{G_SIGNAL_MATCH_MASK}},       q{0x3F}},
		];
		ret ~= add;
	}
	return ret;
}()));

enum G_SIGNAL_TYPE_STATIC_SCOPE = G_TYPE_FLAG_RESERVED_ID_BIT;

struct GSignalInvocationHint{
	uint signalID;
	alias signal_id = signalID;
	GQuark detail;
	GSignalFlags runType;
	alias run_type = runType;
}

struct GSignalQuery{
	uint signalID;
	const(char)* signalName;
	GType iType;
	GSignalFlags signalFlags;
	GType returnType;
	uint nParams;
	const(GType)* paramTypes;
	alias signal_id = signalID;
	alias signal_name = signalName;
	alias itype = iType;
	alias signal_flags = signalFlags;
	alias return_type = returnType;
	alias n_params = nParams;
	alias param_types = paramTypes;
}

pragma(inline,true) nothrow @nogc{
	static if(glibVersion < Version(2,62,0))
	extern(C) void g_clear_signal_handler(c_ulong* handlerIDPtr, void* instance){
		const handlerID = *handlerIDPtr;
		if(handlerID > 0){
			*handlerIDPtr = 0;
			g_signal_handler_disconnect(instance, handlerID);
		}
	}
	
	c_ulong g_signal_connect(void* instance, const(char)* detailedSignal, GCallback cHandler, void* data) =>
		g_signal_connect_data(instance, detailedSignal, cHandler, data, null, cast(GConnectFlags)0);
	
	c_ulong g_signal_connect_after(void* instance, const(char)* detailedSignal, GCallback cHandler, void* data) =>
		g_signal_connect_data(instance, detailedSignal, cHandler, data, null, GConnect.after);
	
	c_ulong g_signal_connect_swapped(void* instance, const(char)* detailedSignal, GCallback cHandler, void* data) =>
		g_signal_connect_data(instance, detailedSignal, cHandler, data, null, GConnect.swapped);
	
	uint g_signal_handlers_disconnect_by_func(void* instance, void* func, void* data) =>
		g_signal_handlers_disconnect_matched(instance, GSignalMatch.func | GSignalMatch.data, 0, 0, null, func, data);
	
	uint g_signal_handlers_disconnect_by_data(void* instance, void* data) =>
		g_signal_handlers_disconnect_matched(instance, GSignalMatch.data, 0, 0, null, null, data);
	
	uint g_signal_handlers_block_by_func(void* instance, void* func, void* data) =>
		g_signal_handlers_block_matched(instance, GSignalMatch.func | GSignalMatch.data, 0, 0, null, func, data);
	
	uint g_signal_handlers_unblock_by_func(void* instance, void* func, void* data) =>
		g_signal_handlers_unblock_matched(instance, GSignalMatch.func | GSignalMatch.data, 0, 0, null, func, data);
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{uint}, q{g_signal_newv}, q{const(char)* signalName, GType iType, GSignalFlags signalFlags, GClosure* classClosure, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams, GType* paramTypes}},
		{q{uint}, q{g_signal_new_valist}, q{const(char)* signalName, GType iType, GSignalFlags signalFlags, GClosure* classClosure, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams, va_list args}},
		{q{uint}, q{g_signal_new}, q{const(char)* signalName, GType iType, GSignalFlags signalFlags, uint classOffset, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams, ...}},
		{q{uint}, q{g_signal_new_class_handler}, q{const(char)* signalName, GType iType, GSignalFlags signalFlags, GCallback classHandler, GSignalAccumulator accumulator, void* accuData, GSignalCMarshaller cMarshaller, GType returnType, uint nParams, ...}},
		{q{void}, q{g_signal_set_va_marshaller}, q{uint signalId, GType instanceType, GSignalCVaMarshaller vaMarshaller}},
		{q{void}, q{g_signal_emitv}, q{const(GValue)* instanceAndParams, uint signalID, GQuark detail, GValue* returnValue}},
		{q{void}, q{g_signal_emit_valist}, q{void* instance, uint signalID, GQuark detail, va_list varArgs}},
		{q{void}, q{g_signal_emit}, q{void* instance, uint signalID, GQuark detail, ...}},
		{q{void}, q{g_signal_emit_by_name}, q{void* instance, const(char)* detailedSignal, ...}},
		{q{uint}, q{g_signal_lookup}, q{const(char)* name, GType iType}},
		{q{const(char)*}, q{g_signal_name}, q{uint signalID}},
		{q{void}, q{g_signal_query}, q{uint signalID, GSignalQuery* query}},
		{q{uint*}, q{g_signal_list_ids}, q{GType iType, uint* nIDs}},
		{q{gboolean}, q{g_signal_parse_name}, q{const(char)* detailedSignal, GType iType, uint* signalIDP, GQuark* detailP, gboolean forceDetailQuark}},
		{q{GSignalInvocationHint*}, q{g_signal_get_invocation_hint}, q{void* instance}},
		{q{void}, q{g_signal_stop_emission}, q{void* instance, uint signalID, GQuark detail}},
		{q{void}, q{g_signal_stop_emission_by_name}, q{void* instance, const(char)* detailedSignal}},
		{q{c_ulong}, q{g_signal_add_emission_hook}, q{uint signalID, GQuark detail, GSignalEmissionHook hookFunc, void* hookData, GDestroyNotify dataDestroy}},
		{q{void}, q{g_signal_remove_emission_hook}, q{uint signalID, c_ulong hookID}},
		{q{gboolean}, q{g_signal_has_handler_pending}, q{void* instance, uint signalID, GQuark detail, gboolean mayBeBlocked}},
		{q{c_ulong}, q{g_signal_connect_closure_by_id}, q{void* instance, uint signalID, GQuark detail, GClosure* closure, gboolean after}},
		{q{c_ulong}, q{g_signal_connect_closure}, q{void* instance, const(char)* detailedSignal, GClosure* closure, gboolean after}},
		{q{c_ulong}, q{g_signal_connect_data}, q{void* instance, const(char)* detailedSignal, GCallback cHandler, void* data, GClosureNotify destroyData, GConnectFlags connectFlags}},
		{q{void}, q{g_signal_handler_block}, q{void* instance, c_ulong handlerID}},
		{q{void}, q{g_signal_handler_unblock}, q{void* instance, c_ulong handlerID}},
		{q{void}, q{g_signal_handler_disconnect}, q{void* instance, c_ulong handlerID}},
		{q{gboolean}, q{g_signal_handler_is_connected}, q{void* instance, c_ulong handlerID}},
		{q{c_ulong}, q{g_signal_handler_find}, q{void* instance, GSignalMatchType mask, uint signalID, GQuark detail, GClosure* closure, void* func, void* data}},
		{q{uint}, q{g_signal_handlers_block_matched}, q{void* instance, GSignalMatchType mask, uint signalID, GQuark detail, GClosure* closure, void* func, void* data}},
		{q{uint}, q{g_signal_handlers_unblock_matched}, q{void* instance, GSignalMatchType mask, uint signalID, GQuark detail, GClosure* closure, void* func, void* data}},
		{q{uint}, q{g_signal_handlers_disconnect_matched}, q{void* instance, GSignalMatchType mask, uint signalID, GQuark detail, GClosure* closure, void* func, void* data}},
		{q{void}, q{g_signal_override_class_closure}, q{uint signalID, GType instanceType, GClosure* classClosure}},
		{q{void}, q{g_signal_override_class_handler}, q{const(char)* signalName, GType instanceType, GCallback classHandler}},
		{q{void}, q{g_signal_chain_from_overridden}, q{const(GValue)* instanceAndParams, GValue* returnValue}},
		{q{void}, q{g_signal_chain_from_overridden_handler}, q{void* instance, ...}},
		{q{gboolean}, q{g_signal_accumulator_true_handled}, q{GSignalInvocationHint* iHint, GValue* returnAccu, const(GValue)* handlerReturn, void* dummy}},
		{q{gboolean}, q{g_signal_accumulator_first_wins}, q{GSignalInvocationHint* iHint, GValue* returnAccu, const(GValue)* handlerReturn, void* dummy}},
	];
	if(glibVersion >= Version(2,62,0)){
		FnBind[] add = [
			{q{void}, q{g_clear_signal_handler}, q{c_ulong* handlerIDPtr, void* instance}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,66,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_signal_is_valid_name}, q{const(char)* name}},
		];
		ret ~= add;
	}
	return ret;
}()));
