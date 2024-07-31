/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.object;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.boxed;
import gobject.closure;
import gobject.param;
import gobject.signal;
import gobject.type;
import gobject.value;

pragma(inline,true) nothrow @nogc{
	bool G_TYPE_IS_OBJECT(GType type) =>
		G_TYPE_FUNDAMENTAL(type) == G_TYPE_OBJECT;
	
	GObject* G_OBJECT(T)(T* object) =>
		G_TYPE_CHECK_INSTANCE_CAST!GObject(cast(GTypeInstance*)object, G_TYPE_OBJECT);
	
	GObjectClass* G_OBJECT_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_CAST!GObjectClass(cast(GTypeClass*)class_, G_TYPE_OBJECT);
	
	bool G_IS_OBJECT(T)(T* object){
		static if(glibVersion >= Version(2,42,0)){
			return G_TYPE_CHECK_INSTANCE_FUNDAMENTAL_TYPE(cast(GTypeInstance*)object, G_TYPE_OBJECT);
		}else{
			return G_TYPE_CHECK_INSTANCE_TYPE(object, G_TYPE_OBJECT);
		}
	}
	bool G_IS_OBJECT_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)class_, G_TYPE_OBJECT);
	
	GObjectClass* G_OBJECT_GET_CLASS(GObject* object) =>
		G_TYPE_INSTANCE_GET_CLASS!GObjectClass(cast(GTypeInstance*)object, G_TYPE_OBJECT);
	
	GType G_OBJECT_TYPE(GObject* object) =>
		G_TYPE_FROM_INSTANCE(cast(GTypeInstance*)object);
	
	const(char)* G_OBJECT_TYPE_NAME(GObject* object) =>
		g_type_name(G_OBJECT_TYPE(object));
	
	GType G_OBJECT_CLASS_TYPE(GObjectClass* class_) =>
		G_TYPE_FROM_CLASS(cast(GTypeClass*)class_);
	
	const(char)* G_OBJECT_CLASS_NAME(GObjectClass* class_) =>
		g_type_name(G_OBJECT_CLASS_TYPE(class_));
	
	bool G_VALUE_HOLDS_OBJECT(GValue* value) =>
		G_TYPE_CHECK_VALUE_TYPE(value, G_TYPE_OBJECT);
	
	GInitiallyUnowned* G_INITIALLY_UNOWNED(T)(T* object) =>
		G_TYPE_CHECK_INSTANCE_CAST!GInitiallyUnowned(cast(GTypeInstance*)object, G_TYPE_INITIALLY_UNOWNED);
	
	GInitiallyUnownedClass* G_INITIALLY_UNOWNED_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_CAST!GInitiallyUnownedClass(class_, G_TYPE_INITIALLY_UNOWNED);
	
	bool G_IS_INITIALLY_UNOWNED(T)(T* object) =>
		G_TYPE_CHECK_INSTANCE_TYPE(cast(GTypeInstance*)object, G_TYPE_INITIALLY_UNOWNED);
	
	bool G_IS_INITIALLY_UNOWNED_CLASS(T)(T* class_) =>
		G_TYPE_CHECK_CLASS_TYPE(cast(GTypeClass*)class_, G_TYPE_INITIALLY_UNOWNED);
	
	GInitiallyUnownedClass* G_INITIALLY_UNOWNED_GET_CLASS(T)(T* object) =>
		G_TYPE_INSTANCE_GET_CLASS!GInitiallyUnownedClass(object, G_TYPE_INITIALLY_UNOWNED);
}

alias GInitiallyUnowned = GObject;
alias GInitiallyUnownedClass = GObjectClass;

extern(C) nothrow{
	alias GObjectGetPropertyFunc = void function(GObject* object, uint propertyID, GValue* value, GParamSpec* pSpec);
	alias GObjectSetPropertyFunc = void function(GObject* object, uint propertyID, const(GValue)* value, GParamSpec* pSpec);
	alias GObjectFinaliseFunc = void function(GObject* object);
	alias GObjectFinalizeFunc = GObjectFinaliseFunc;
	alias GWeakNotify = void function(void* data, GObject* whereTheObjectWas);
}

struct GObject{
	GTypeInstance gTypeInstance;
	alias g_type_instance = gTypeInstance;
	
	uint refCount;
	GData* qData;
	alias ref_count = refCount;
	alias qdata = qData;
}

struct GObjectClass{
	GTypeClass gTypeClass;
	alias g_type_class = gTypeClass;
	
	GSList* constructProperties;
	alias construct_properties = constructProperties;
	
	extern(C) nothrow{
		alias ConstructorFn = GObject* function(GType type, uint nConstructProperties, GObjectConstructParam* constructProperties);
		alias SetPropertyFn = void function(GObject* object, uint propertyID, const(GValue)* value, GParamSpec* pSpec);
		alias GetPropertyFn = void function(GObject* object, uint propertyID, GValue* value, GParamSpec* pSpec);
		alias DisposeFn = void function(GObject* object);
		alias FinaliseFn = void function(GObject* object);
		alias DispatchPropertiesChangedFn = void function(GObject* object, uint nPSpecs, GParamSpec** pSpecs);
		alias NotifyFn = void function(GObject* object, GParamSpec* pSpec);
		alias ConstructedFn = void function(GObject* object);
	}
	ConstructorFn constructor;
	SetPropertyFn setProperty;
	GetPropertyFn getProperty;
	DisposeFn dispose;
	FinaliseFn finalise;
	DispatchPropertiesChangedFn dispatchPropertiesChanged;
	NotifyFn notify;
	ConstructedFn constructed;
	alias set_property = setProperty;
	alias get_property = getProperty;
	alias finalize = finalise;
	alias dispatch_properties_changed = dispatchPropertiesChanged;
	
	size_t flags;
	
	size_t nConstructProperties;
	alias n_construct_properties = nConstructProperties;
	
	void* pSpecs;
	size_t nPspecs;
	alias pspecs = pSpecs;
	alias n_pspecs = nPspecs;
	
	void*[3] pdummy;
}

struct GObjectConstructParam{
	GParamSpec* pSpec;
	GValue* value;
}

alias GToggleNotify = void function(void* data, GObject* object, gboolean isLastRef);

pragma(inline,true) nothrow @nogc{
	bool g_set_object(T)(T** objectPtr, T* newObject){
		T* oldObject = *objectPtr;
		
		if(oldObject == newObject)
			return false;
		
		if(newObject !is null)
			g_object_ref(newObject);
		
		*objectPtr = newObject;
		
		if(oldObject !is null)
			g_object_unref(oldObject);
		
		return true;
	}
	
	void g_assert_finalise_object(T)(T* object){
		void* weakPointer = object;
		
		assert(G_IS_OBJECT(weakPointer));
		g_object_add_weak_pointer(object, &weakPointer);
		g_object_unref(weakPointer);
		assert(weakPointer is null);
	}
	alias g_assert_finalize_object = g_assert_finalise_object;
	
	void g_clear_weak_pointer(T)(T** weakPointerLocation){
		GObject* object = cast(GObject*)*weakPointerLocation;
		
		if(object !is null){
			g_object_remove_weak_pointer(object, weakPointerLocation);
			*weakPointerLocation = null;
		}
	}
	
	bool g_set_weak_pointer(T)(T** weakPointerLocation, T* newObject){
		GObject* oldObject = cast(GObject*)*weakPointerLocation;
		
		if(oldObject == newObject)
			return false;
		
		if(oldObject !is null)
			g_object_remove_weak_pointer(oldObject, weakPointerLocation);
		
		*weakPointerLocation = newObject;
		
		if(newObject !is null)
			g_object_add_weak_pointer(newObject, weakPointerLocation);
		
		return true;
	}
}

struct GWeakRef{
	union{
		void* p;
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{GType}, q{g_initially_unowned_get_type}, q{}, aliases: [q{G_TYPE_INITIALLY_UNOWNED}]},
		{q{void}, q{g_object_class_install_property}, q{GObjectClass* oClass, uint propertyID, GParamSpec* pspec}},
		{q{GParamSpec*}, q{g_object_class_find_property}, q{GObjectClass* oClass, const(char)* propertyName}},
		{q{GParamSpec**}, q{g_object_class_list_properties}, q{GObjectClass* oClass, uint* nProperties}},
		{q{void}, q{g_object_class_override_property}, q{GObjectClass* oClass, uint propertyID, const(char)* name}},
		{q{void}, q{g_object_class_install_properties}, q{GObjectClass* oClass, uint nPSpecs, GParamSpec** pSpecs}},
		{q{void}, q{g_object_interface_install_property}, q{void* gIFace, GParamSpec* pSpec}},
		{q{GParamSpec*}, q{g_object_interface_find_property}, q{void* gIFace, const(char)* propertyName}},
		{q{GParamSpec**}, q{g_object_interface_list_properties}, q{void* gIFace, uint* nPropertiesP}},
		{q{GType}, q{g_object_get_type}, q{}, attr: q{pure}},
		{q{void*}, q{g_object_new}, q{GType objectType, const(char)* firstPropertyName, ...}},
		{q{GObject*}, q{g_object_new_valist}, q{GType objectType, const(char)* firstPropertyName, va_list varArgs}},
		{q{void}, q{g_object_set}, q{void* object, const(char)* firstPropertyName, ...}},
		{q{void}, q{g_object_get}, q{void* object, const(char)* firstPropertyName, ...}},
		{q{void*}, q{g_object_connect}, q{void* object, const(char)* signalSpec, ...}},
		{q{void}, q{g_object_disconnect}, q{void* object, const(char)* signalSpec, ...}},
		{q{void}, q{g_object_set_valist}, q{GObject* object, const(char)* firstPropertyName, va_list varArgs}},
		{q{void}, q{g_object_get_valist}, q{GObject* object, const(char)* firstPropertyName, va_list varArgs}},
		{q{void}, q{g_object_set_property}, q{GObject* object, const(char)* propertyName, const(GValue)* value}},
		{q{void}, q{g_object_get_property}, q{GObject* object, const(char)* propertyName, GValue* value}},
		{q{void}, q{g_object_freeze_notify}, q{GObject* object}},
		{q{void}, q{g_object_notify}, q{GObject* object, const(char)* propertyName}},
		{q{void}, q{g_object_notify_by_pspec}, q{GObject* object, GParamSpec* pSpec}},
		{q{void}, q{g_object_thaw_notify}, q{GObject* object}},
		{q{gboolean}, q{g_object_is_floating}, q{void* object}},
		{q{void*}, q{g_object_ref_sink}, q{void* object}},
		{q{void*}, q{g_object_ref}, q{void* object}},
		{q{void}, q{g_object_unref}, q{void* object}},
		{q{void}, q{g_object_weak_ref}, q{GObject* object, GWeakNotify notify, void* data}},
		{q{void}, q{g_object_weak_unref}, q{GObject* object, GWeakNotify notify, void* data}},
		{q{void}, q{g_object_add_weak_pointer}, q{GObject* object, void** weakPointerLocation}},
		{q{void}, q{g_object_remove_weak_pointer}, q{GObject* object, void** weakPointerLocation}},
		{q{void}, q{g_object_add_toggle_ref}, q{GObject* object, GToggleNotify notify, void* data}},
		{q{void}, q{g_object_remove_toggle_ref}, q{GObject* object, GToggleNotify notify, void* data}},
		{q{void*}, q{g_object_get_qdata}, q{GObject* object, GQuark quark}},
		{q{void}, q{g_object_set_qdata}, q{GObject* object, GQuark quark, void* data}},
		{q{void}, q{g_object_set_qdata_full}, q{GObject* object, GQuark quark, void* data, GDestroyNotify destroy}},
		{q{void*}, q{g_object_steal_qdata}, q{GObject* object, GQuark quark}},
		{q{void*}, q{g_object_get_data}, q{GObject* object, const(char)* key}},
		{q{void}, q{g_object_set_data}, q{GObject* object, const(char)* key, void* data}},
		{q{void}, q{g_object_set_data_full}, q{GObject* object, const(char)* key, void* data, GDestroyNotify destroy}},
		{q{void*}, q{g_object_steal_data}, q{GObject* object, const(char)* key}},
		{q{void}, q{g_object_watch_closure}, q{GObject* object, GClosure* closure}},
		{q{GClosure*}, q{g_cclosure_new_object}, q{GCallback callbackFunc, GObject* object}},
		{q{GClosure*}, q{g_cclosure_new_object_swap}, q{GCallback callbackFunc, GObject* object}},
		{q{GClosure*}, q{g_closure_new_object}, q{uint sizeOfClosure, GObject* object}},
		{q{void}, q{g_value_set_object}, q{GValue* value, void* vObject}},
		{q{void*}, q{g_value_get_object}, q{const(GValue)* value}},
		{q{void*}, q{g_value_dup_object}, q{const(GValue)* value}},
		{q{c_ulong}, q{g_signal_connect_object}, q{void* instance, const(char)* detailedSignal, GCallback cHandler, void* gObject, GConnectFlags connectFlags}},
		{q{void}, q{g_object_force_floating}, q{GObject* object}},
		{q{void}, q{g_object_run_dispose}, q{GObject* object}},
		{q{void}, q{g_value_take_object}, q{GValue* value, void* vObject}},
		{q{void}, q{g_clear_object}, q{GObject** objectPtr}},
		{q{void}, q{g_weak_ref_init}, q{GWeakRef* weakRef, void* object}},
		{q{void}, q{g_weak_ref_clear}, q{GWeakRef* weakRef}},
		{q{void*}, q{g_weak_ref_get}, q{GWeakRef* weakRef}},
		{q{void}, q{g_weak_ref_set}, q{GWeakRef* weakRef, void* object}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{void*}, q{g_object_dup_qdata}, q{GObject* object, GQuark quark, GDuplicateFunc dupFunc, void* userData}},
			{q{gboolean}, q{g_object_replace_qdata}, q{GObject* object, GQuark quark, void* oldVal, void* newVal, GDestroyNotify destroy, GDestroyNotify* oldDestroy}},
			{q{void*}, q{g_object_dup_data}, q{GObject* object, const(char)* key, GDuplicateFunc dupFunc, void* userData}},
			{q{gboolean}, q{g_object_replace_data}, q{GObject* object, const(char)* key, void* oldVal, void* newVal, GDestroyNotify destroy, GDestroyNotify* oldDestroy}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,54,0)){
		FnBind[] add = [
			{q{GObject*}, q{g_object_new_with_properties}, q{GType objectType, uint nProperties, const(char)** names, const(GValue)* values}},
			{q{void}, q{g_object_setv}, q{GObject* object, uint nProperties, const(char)** names, const(GValue)* values}},
			{q{void}, q{g_object_getv}, q{GObject* object, uint nProperties, const(char)** names, GValue* values}},
		];
		ret ~= add;
	}else{
		FnBind[] add = [
			{q{void*}, q{g_object_newv}, q{GType objectType, uint nParameters, GParameter* parameters}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,70,0)){
		FnBind[] add = [
			{q{void*}, q{g_object_take_ref}, q{void* object}},
		];
		ret ~= add;
	}
	return ret;
}()));
