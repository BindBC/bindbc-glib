/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.param;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.type;
import gobject.value;

pragma(inline,true) nothrow @nogc{
	bool G_TYPE_IS_PARAM(GType type) =>
		G_TYPE_FUNDAMENTAL(type) == G_TYPE_PARAM;
	
	GParamSpec* G_PARAM_SPEC(T)(T* pSpec) =>
		G_TYPE_CHECK_INSTANCE_CAST!GParamSpec(cast(GTypeInstance*)pSpec, G_TYPE_PARAM);
	
	bool G_IS_PARAM_SPEC(T)(T* pSpec){
		static if(glibVersion >= Version(2,42,0)){
			return G_TYPE_CHECK_INSTANCE_FUNDAMENTAL_TYPE(cast(GTypeInstance*)pSpec, G_TYPE_PARAM);
		}else{
			return G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)pSpec, G_TYPE_PARAM);
		}
	}
	GParamSpecClass* G_PARAM_SPEC_CLASS(T)(T* pClass) =>
		G_TYPE_CHECK_CLASS_CAST!GParamSpecClass(cast(GTypeClass*)pClass, G_TYPE_PARAM);
	
	bool G_IS_PARAM_SPEC_CLASS(T)(T* pClass) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)pClass, G_TYPE_PARAM);
	
	GParamSpecClass* G_PARAM_SPEC_GET_CLASS(GParamSpec* pSpec) =>
		G_TYPE_INSTANCE_GET_CLASS!GParamSpecClass(cast(GTypeInstance*)pSpec, G_TYPE_PARAM);
	
	GType G_PARAM_SPEC_TYPE(GParamSpec* pSpec) =>
		G_TYPE_FROM_INSTANCE(cast(GTypeInstance*)pSpec);
	
	const(char)* G_PARAM_SPEC_TYPE_NAME(GParamSpec* pSpec) =>
		g_type_name(G_PARAM_SPEC_TYPE(pSpec));
	
	GType G_PARAM_SPEC_VALUE_TYPE(GParamSpec* pSpec) =>
		G_PARAM_SPEC(pSpec).valueType;
	
	bool G_VALUE_HOLDS_PARAM(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_PARAM);
}

mixin(makeEnumBind(q{GParamFlags}, aliases: [q{GParamFlag}, q{GParam}], members: (){
	EnumMember[] ret = [
		{{q{readable},            q{G_PARAM_READABLE}},         q{1 << 0}},
		{{q{writable},            q{G_PARAM_WRITABLE}},         q{1 << 1}},
		{{q{readWrite},           q{G_PARAM_READWRITE}},        q{GParam.readable | GParam.writable}},
		{{q{construct},           q{G_PARAM_CONSTRUCT}},        q{1 << 2}},
		{{q{constructOnly},       q{G_PARAM_CONSTRUCT_ONLY}},   q{1 << 3}},
		{{q{laxValidation},       q{G_PARAM_LAX_VALIDATION}},   q{1 << 4}},
	];
	if(glibVersion >= Version(2,8,0)){
		EnumMember[] add = [
			{{q{staticName},      q{G_PARAM_STATIC_NAME}},      q{1 << 5}, aliases: [{q{private_}, q{G_PARAM_PRIVATE}}]},
			{{q{staticNick},      q{G_PARAM_STATIC_NICK}},      q{1 << 6}},
			{{q{staticBlurb},     q{G_PARAM_STATIC_BLURB}},     q{1 << 7}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,13,0)){
		EnumMember[] add = [
			{{q{staticStrings},   q{G_PARAM_STATIC_STRINGS}},   q{GParam.staticName | GParam.staticNick | GParam.staticBlurb}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,26,0)){
		EnumMember[] add = [
			{{q{deprecated_},     q{G_PARAM_DEPRECATED}},       q{1 << 31}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,42,0)){
		EnumMember[] add = [
			{{q{explicitNotify},  q{G_PARAM_EXPLICIT_NOTIFY}},  q{1 << 30}},
		];
		ret ~= add;
	}
	{
		EnumMember[] add = [
			{{q{mask},            q{G_PARAM_MASK}},             q{0x0000_00FF}},
			{{q{userShift},       q{G_PARAM_USER_SHIFT}},       q{8}},
		];
		ret ~= add;
	}
	return ret;
}()));

struct GParamSpecPool;

struct GParamSpec{
	GTypeInstance gTypeInstance;
	alias g_type_instance = gTypeInstance;
	
	const(char)* name;
	GParamFlags flags;
	GType valueType;
	GType ownerType;
	alias value_type = valueType;
	alias owner_type = ownerType;
	
	char* nick;
	char* blurb;
	GData* qData;
	uint refCount;
	uint paramID;
	alias _nick = nick;
	alias _blurb = blurb;
	alias qdata = qData;
	alias ref_count = refCount;
	alias param_id = paramID;
}

struct GParamSpecClass{
	GTypeClass gTypeClass;
	alias g_type_class = gTypeClass;
	
	GType valueType;
	alias value_type = valueType;
	
	extern(C) nothrow{
		alias FinaliseFn = void function(GParamSpec* pSpec);
		alias ValueSetDefaultFn = void function(GParamSpec* pSpec, GValue* value);
		alias ValueValidateFn = gboolean function(GParamSpec* pSpec, GValue* value);
		alias ValuesCmpFn = int function(GParamSpec* pSpec, const(GValue)* value1, const(GValue)* value2);
		alias ValueIsValidFn = gboolean function(GParamSpec* pSpec, const(GValue)* value);
	}
	FinaliseFn finalise;
	ValueSetDefaultFn valueSetDefault;
	ValueValidateFn valueValidate;
	ValuesCmpFn valuesCmp;
	ValueIsValidFn valueIsValid;
	alias finalize = finalise;
	alias value_set_default = valueSetDefault;
	alias value_validate = valueValidate;
	alias values_cmp = valuesCmp;
	alias value_is_valid = valueIsValid;
	
	void*[3] dummy;
}

struct GParameter{
	const(char)* name;
	GValue value;
}

struct GParamSpecTypeInfo{
	ushort instanceSize;
	ushort nPreallocs;
	alias instance_size = instanceSize;
	alias n_preallocs = nPreallocs;
	
	extern(C) nothrow{
		alias InstanceInitFn = void function(GParamSpec* pSpec);
		alias FinaliseFn = void function(GParamSpec* pSpec);
		alias ValueSetDefaultFn = void function(GParamSpec* pSpec, GValue* value);
		alias ValueValidateFn = gboolean function(GParamSpec* pSpec, GValue* value);
		alias ValuesCmpFn = int function(GParamSpec* pSpec, const(GValue)* value1, const(GValue)* value2);
	}
	InstanceInitFn instanceInit;
	GType valueType;
	FinaliseFn finalise;
	ValueSetDefaultFn valueSetDefault;
	ValueValidateFn valueValidate;
	ValuesCmpFn valuesCmp;
	alias instance_init = instanceInit;
	alias value_type = valueType;
	alias finalize = finalise;
	alias value_set_default = valueSetDefault;
	alias value_validate = valueValidate;
	alias values_cmp = valuesCmp;
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GParamSpec*}, q{g_param_spec_ref}, q{GParamSpec* pSpec}},
		{q{void}, q{g_param_spec_unref}, q{GParamSpec* pSpec}},
		{q{void}, q{g_param_spec_sink}, q{GParamSpec* pSpec}},
		{q{GParamSpec*}, q{g_param_spec_ref_sink}, q{GParamSpec* pSpec}},
		{q{void*}, q{g_param_spec_get_qdata}, q{GParamSpec* pSpec, GQuark quark}},
		{q{void}, q{g_param_spec_set_qdata}, q{GParamSpec* pSpec, GQuark quark, void* data}},
		{q{void}, q{g_param_spec_set_qdata_full}, q{GParamSpec* pSpec, GQuark quark, void* data, GDestroyNotify destroy}},
		{q{void*}, q{g_param_spec_steal_qdata}, q{GParamSpec* pSpec, GQuark quark}},
		{q{GParamSpec*}, q{g_param_spec_get_redirect_target}, q{GParamSpec* pSpec}},
		{q{void}, q{g_param_value_set_default}, q{GParamSpec* pSpec, GValue* value}},
		{q{gboolean}, q{g_param_value_defaults}, q{GParamSpec* pSpec, const(GValue)* value}},
		{q{gboolean}, q{g_param_value_validate}, q{GParamSpec* pSpec, GValue* value}},
		{q{gboolean}, q{g_param_value_convert}, q{GParamSpec* pSpec, const(GValue)* srcValue, GValue* destValue, gboolean strictValidation}},
		{q{int}, q{g_param_values_cmp}, q{GParamSpec* pSpec, const(GValue)* value1, const(GValue)* value2}},
		{q{const(char)*}, q{g_param_spec_get_name}, q{GParamSpec* pSpec}},
		{q{const(char)*}, q{g_param_spec_get_nick}, q{GParamSpec* pSpec}},
		{q{const(char)*}, q{g_param_spec_get_blurb}, q{GParamSpec* pSpec}},
		{q{void}, q{g_value_set_param}, q{GValue* value, GParamSpec* param}},
		{q{GParamSpec*}, q{g_value_get_param}, q{const(GValue)* value}},
		{q{GParamSpec*}, q{g_value_dup_param}, q{const(GValue)* value}},
		{q{void}, q{g_value_take_param}, q{GValue* value, GParamSpec* param}},
		{q{GType}, q{g_param_type_register_static}, q{const(char)* name, const(GParamSpecTypeInfo)* pSpecInfo}},
		{q{void*}, q{g_param_spec_internal}, q{GType paramType, const(char)* name, const(char)* nick, const(char)* blurb, GParamFlags flags}},
		{q{GParamSpecPool*}, q{g_param_spec_pool_new}, q{gboolean typePrefixing}},
		{q{void}, q{g_param_spec_pool_insert}, q{GParamSpecPool* pool, GParamSpec* pSpec, GType ownerType}},
		{q{void}, q{g_param_spec_pool_remove}, q{GParamSpecPool* pool, GParamSpec* pSpec}},
		{q{GParamSpec*}, q{g_param_spec_pool_lookup}, q{GParamSpecPool* pool, const(char)* paramName, GType ownerType, gboolean walkAncestors}},
		{q{GList*}, q{g_param_spec_pool_list_owned}, q{GParamSpecPool* pool, GType ownerType}},
		{q{GParamSpec**}, q{g_param_spec_pool_list}, q{GParamSpecPool* pool, GType ownerType, uint* nPSpecsP}},
	];
	if(glibVersion >= Version(2,36,0)){
		FnBind[] add = [
			{q{const(GValue)*}, q{g_param_spec_get_default_value}, q{GParamSpec* pSpec}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,46,0)){
		FnBind[] add = [
			{q{GQuark}, q{g_param_spec_get_name_quark}, q{GParamSpec* pSpec}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,66,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_param_spec_is_valid_name}, q{const(char)* name}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_param_value_is_valid}, q{GParamSpec* pSpec, const(GValue)* value}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,80,0)){
		FnBind[] add = [
			{q{void}, q{g_param_spec_pool_free}, q{GParamSpecPool* pool}},
		];
		ret ~= add;
	}
	return ret;
}()));
