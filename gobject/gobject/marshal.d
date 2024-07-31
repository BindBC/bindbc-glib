/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.marshal;

import bindbc.glib.config;
import bindbc.glib.codegen;

import gobject.closure;
import gobject.type;
import gobject.value;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{g_cclosure_marshal_VOID__VOID}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__VOIDv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__BOOLEAN}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__BOOLEANv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__CHAR}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__CHARv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__UCHAR}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__UCHARv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__INT}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__INTv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__UINT}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__UINTv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__LONG}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__LONGv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__ULONG}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__ULONGv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__ENUM}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__ENUMv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__FLAGS}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__FLAGSv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__FLOAT}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__FLOATv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__DOUBLE}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__DOUBLEv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__STRING}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__STRINGv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__PARAM}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__PARAMv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__BOXED}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__BOXEDv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__POINTER}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__POINTERv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__OBJECT}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__OBJECTv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__VARIANT}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__VARIANTv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_VOID__UINT_POINTER}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_VOID__UINT_POINTERv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_BOOLEAN__FLAGS}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}, aliases: [q{g_cclosure_marshal_BOOL__FLAGS}]},
		{q{void}, q{g_cclosure_marshal_BOOLEAN__FLAGSv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}, aliases: [q{g_cclosure_marshal_BOOL__FLAGSv}]},
		{q{void}, q{g_cclosure_marshal_STRING__OBJECT_POINTER}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}},
		{q{void}, q{g_cclosure_marshal_STRING__OBJECT_POINTERv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}},
		{q{void}, q{g_cclosure_marshal_BOOLEAN__BOXED_BOXED}, q{GClosure* closure, GValue* returnValue, uint nParamValues, const(GValue)* paramValues, void* invocationHint, void* marshalData}, aliases: [q{g_cclosure_marshal_BOOL__BOXED_BOXED}]},
		{q{void}, q{g_cclosure_marshal_BOOLEAN__BOXED_BOXEDv}, q{GClosure* closure, GValue* returnValue, void* instance, va_list args, void* marshalData, int nParams, GType* paramTypes}, aliases: [q{g_cclosure_marshal_BOOL__BOXED_BOXEDv}]},
	];
	return ret;
}()));
