/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.closure;

import bindbc.glib.config;
import bindbc.glib.codegen;

import gobject.type;
import gobject.value;

pragma(inline,true) nothrow @nogc pure @safe{
	bool G_CLOSURE_NEEDS_MARSHAL(GClosure* closure) =>
		closure.marshal is null;
	
	uint G_CLOSURE_N_NOTIFIERS(GClosure* cl) =>
		(cl.nGuards << 1L) + cl.nFNotifiers + cl.nINotifiers;
	
	bool G_CCLOSURE_SWAP_DATA(GCClosure* cClosure) =>
		cClosure.closure.derivativeFlag != 0;
}

extern(C) nothrow{
	alias GCallback = void function();
	alias GClosureNotify = void function(void* data, GClosure* closure);
	alias GClosureMarshal = void function(GClosure* closure, GValue* returnValue, uint nParamValues, const GValue* paramValues, void* invocationHint, void* marshalData);
	alias GVaClosureMarshal = void function(GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes);
}

struct GClosureNotifyData{
	void* data;
	GClosureNotify notify;
}

struct GClosure{
	import std.bitmanip: bitfields;
	mixin(bitfields!(
		uint, q{refCount},          15,
		uint, q{metaMarshalNoUse},  1,
		uint, q{nGuards},           1,
		uint, q{nFNotifiers},       2,
		uint, q{nINotifiers},       8,
		uint, q{inINotify},         1,
		uint, q{floating},          1,
		uint, q{derivativeFlag},    1,
		uint, q{inMarshal},         1,
		uint, q{isInvalid},         1,
	));
	alias ref_count = refCount;
	alias meta_marshal_nouse = metaMarshalNoUse;
	alias n_guards = nGuards;
	alias n_fnotifiers = nFNotifiers;
	alias n_inotifiers = nINotifiers;
	alias in_inotify = inINotify;
	alias derivative_flag = derivativeFlag;
	alias in_marshal = inMarshal;
	alias is_invalid = isInvalid;
	
	alias MarshalFn = extern(C) void function(GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData) nothrow;
	MarshalFn marshal;
	void* data;
	
	GClosureNotifyData* notifiers;
}

struct GCClosure{
	GClosure closure;
	void* callback;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GClosure*}, q{g_cclosure_new}, q{GCallback callbackFunc, void* userData, GClosureNotify destroyData}},
		{q{GClosure*}, q{g_cclosure_new_swap}, q{GCallback callbackFunc, void* userData, GClosureNotify destroyData}},
		{q{GClosure*}, q{g_signal_type_cclosure_new}, q{GType itype, uint structOffset}},
		{q{GClosure*}, q{g_closure_ref}, q{GClosure* closure}},
		{q{void}, q{g_closure_sink}, q{GClosure* closure}},
		{q{void}, q{g_closure_unref}, q{GClosure* closure}},
		{q{GClosure*}, q{g_closure_new_simple}, q{uint sizeOfClosure, void* data}},
		{q{void}, q{g_closure_add_finalize_notifier}, q{GClosure* closure, void* notifyData, GClosureNotify notifyFunc}, aliases: [q{g_closure_add_finalise_notifier}]},
		{q{void}, q{g_closure_remove_finalize_notifier}, q{GClosure* closure, void* notifyData, GClosureNotify notifyFunc}, aliases: [q{g_closure_remove_finalise_notifier}]},
		{q{void}, q{g_closure_add_invalidate_notifier}, q{GClosure* closure, void* notifyData, GClosureNotify notifyFunc}},
		{q{void}, q{g_closure_remove_invalidate_notifier}, q{GClosure* closure, void* notifyData, GClosureNotify notifyFunc}},
		{q{void}, q{g_closure_add_marshal_guards}, q{GClosure* closure, void* preMarshalData, GClosureNotify preMarshalNotify, void* postMarshalData, GClosureNotify postMarshalNotify}},
		{q{void}, q{g_closure_set_marshal}, q{GClosure* closure, GClosureMarshal marshal}},
		{q{void}, q{g_closure_set_meta_marshal}, q{GClosure* closure, void* marshalData, GClosureMarshal metaMarshal}},
		{q{void}, q{g_closure_invalidate}, q{GClosure* closure}},
		{q{void}, q{g_closure_invoke}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint}},
		{q{void}, q{g_cclosure_marshal_generic}, q{GClosure* closure, GValue* returnGValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_generic_va}, q{GClosure* closure, GValue* returnValue, void* instance, va_list argsList, void* marshalData, int nParams, GType* paramTypes}},
	];
	return ret;
}()));
