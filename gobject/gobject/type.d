/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module gobject.type;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib;
import gobject.typeplugin;
import gobject.value;
import gobject.valuecollector;

enum G_TYPE_FUNDAMENTAL_SHIFT = 2;
enum G_TYPE_FUNDAMENTAL_MAX = 255 << G_TYPE_FUNDAMENTAL_SHIFT;
enum{
	G_TYPE_INVALID    = G_TYPE_MAKE_FUNDAMENTAL(0),
	G_TYPE_NONE       = G_TYPE_MAKE_FUNDAMENTAL(1),
	G_TYPE_INTERFACE  = G_TYPE_MAKE_FUNDAMENTAL(2),
	G_TYPE_CHAR       = G_TYPE_MAKE_FUNDAMENTAL(3),
	G_TYPE_UCHAR      = G_TYPE_MAKE_FUNDAMENTAL(4),
	G_TYPE_BOOLEAN    = G_TYPE_MAKE_FUNDAMENTAL(5),
	G_TYPE_INT        = G_TYPE_MAKE_FUNDAMENTAL(6),
	G_TYPE_UINT       = G_TYPE_MAKE_FUNDAMENTAL(7),
	G_TYPE_LONG       = G_TYPE_MAKE_FUNDAMENTAL(8),
	G_TYPE_ULONG      = G_TYPE_MAKE_FUNDAMENTAL(9),
	G_TYPE_INT64      = G_TYPE_MAKE_FUNDAMENTAL(10),
	G_TYPE_UINT64     = G_TYPE_MAKE_FUNDAMENTAL(11),
	G_TYPE_ENUM       = G_TYPE_MAKE_FUNDAMENTAL(12),
	G_TYPE_FLAGS      = G_TYPE_MAKE_FUNDAMENTAL(13),
	G_TYPE_FLOAT      = G_TYPE_MAKE_FUNDAMENTAL(14),
	G_TYPE_DOUBLE     = G_TYPE_MAKE_FUNDAMENTAL(15),
	G_TYPE_STRING     = G_TYPE_MAKE_FUNDAMENTAL(16),
	G_TYPE_POINTER    = G_TYPE_MAKE_FUNDAMENTAL(17),
	G_TYPE_BOXED      = G_TYPE_MAKE_FUNDAMENTAL(18),
	G_TYPE_PARAM      = G_TYPE_MAKE_FUNDAMENTAL(19),
	G_TYPE_OBJECT     = G_TYPE_MAKE_FUNDAMENTAL(20),
}
static if(glibVersion >= Version(2,26,0))
enum{
	G_TYPE_VARIANT    = G_TYPE_MAKE_FUNDAMENTAL(21),
}
enum{
	G_TYPE_RESERVED_GLIB_FIRST  = 22,
	G_TYPE_RESERVED_GLIB_LAST   = 31,
	G_TYPE_RESERVED_BSE_FIRST   = 32,
	G_TYPE_RESERVED_BSE_LAST    = 48,
	G_TYPE_RESERVED_USER_FIRST  = 49,
}

pragma(inline,true) nothrow @nogc{
	GType G_TYPE_MAKE_FUNDAMENTAL(GType x) pure @safe =>
		cast(GType)(x << G_TYPE_FUNDAMENTAL_SHIFT);
	
	bool G_TYPE_IS_FUNDAMENTAL(GType type) pure @safe =>
		type <= G_TYPE_FUNDAMENTAL_MAX;
	
	bool G_TYPE_IS_DERIVED(GType type) pure @safe =>
		type > G_TYPE_FUNDAMENTAL_MAX;
	
	bool G_TYPE_IS_INTERFACE(GType type) =>
		G_TYPE_FUNDAMENTAL(type) == G_TYPE_INTERFACE;
	
	bool G_TYPE_IS_CLASSED(GType type) =>
		g_type_test_flags(type, G_TYPE_FLAG_CLASSED) != 0;
	
	bool G_TYPE_IS_INSTANTIATABLE(GType type) =>
		g_type_test_flags(type, G_TYPE_FLAG_INSTANTIATABLE) != 0;
	
	bool G_TYPE_IS_DERIVABLE(GType type) =>
		g_type_test_flags(type, G_TYPE_FLAG_DERIVABLE) != 0;
	
	bool G_TYPE_IS_DEEP_DERIVABLE(GType type) =>
		g_type_test_flags(type, G_TYPE_FLAG_DEEP_DERIVABLE) != 0;
	
	bool G_TYPE_IS_ABSTRACT(GType type) =>
		g_type_test_flags(type, G_TYPE_FLAG_ABSTRACT) != 0;
	
	bool G_TYPE_IS_VALUE_ABSTRACT(GType type) =>
		g_type_test_flags(type, G_TYPE_FLAG_VALUE_ABSTRACT) != 0;
	
	bool G_TYPE_IS_VALUE_TYPE(GType type) =>
		g_type_check_is_value_type(type) != 0;
	
	bool G_TYPE_HAS_VALUE_TABLE(GType type) =>
		g_type_value_table_peek(type) !is null;
	
	static if(glibVersion >= Version(2,70,0))
	bool G_TYPE_IS_FINAL(GType type) pure =>
		g_type_test_flags(type, G_TYPE_FLAG_FINAL) != 0;
	
	static if(glibVersion >= Version(2,76,0))
	bool G_TYPE_IS_DEPRECATED(GType type) pure =>
		g_type_test_flags(type, G_TYPE_FLAG_DEPRECATED) != 0;
}

alias GType = size_t;

struct GTypeClass{
	GType gType;
	alias g_type = gType;
}

struct GTypeInstance{
	GTypeClass* gClass;
	alias g_class = gClass;
}

struct GTypeInterface{
	GType gType;
	GType gInstanceType;
	alias g_type = gType;
	alias g_instance_type = gInstanceType;
}

struct GTypeQuery{
	GType type;
	const(char)* typeName;
	uint classSize;
	uint instanceSize;
	alias type_name = typeName;
	alias class_size = classSize;
	alias instance_size = instanceSize;
}

pragma(inline,true) nothrow @nogc{
	GType G_TYPE_FROM_INSTANCE(GTypeInstance* instance) pure @safe =>
		G_TYPE_FROM_CLASS(instance.gClass);
	
	GType G_TYPE_FROM_CLASS(GTypeClass* gClass) pure @safe =>
		gClass.gType;
	
	GType G_TYPE_FROM_INTERFACE(GTypeInterface* gIFace) pure @safe =>
		gIFace.gType;
	
	T* G_TYPE_INSTANCE_GET_PRIVATE(T)(GTypeInstance* instance, GType gType) =>
		cast(T*)g_type_instance_get_private(instance, gType);
	
	T* G_TYPE_CLASS_GET_PRIVATE(T)(GTypeClass* gClass, GType gType) =>
		cast(T*)g_type_class_get_private(gClass, gType);
}

extern(C) nothrow{
	alias GBaseInitFunc = void function(void* gClass);
	alias GBaseFinaliseFunc = void function(void* gClass);
	alias GClassInitFunc = void function(void* gClass, void* classData);
	alias GClassFinaliseFunc = void function(void* gClass, void* classData);
	alias GInstanceInitFunc = void function(GTypeInstance* instance, void* gClass);
	alias GInterfaceInitFunc = void function(void* gIFace, void* ifaceData);
	alias GInterfaceFinaliseFunc = void function(void* gIFace, void* ifaceData);
	alias GTypeClassCacheFunc = gboolean function(void* cacheData, GTypeClass* gClass);
	alias GTypeInterfaceCheckFunc = void function(void* checkData, void* gIFace);
	alias GBaseFinalizeFunc = GBaseFinaliseFunc;
	alias GClassFinalizeFunc = GClassFinaliseFunc;
	alias GInterfaceFinalizeFunc = GInterfaceFinaliseFunc;
}

mixin(makeEnumBind(q{GTypeFundamentalFlags}, aliases: [q{GTypeFundamentalFlag}], members: (){
	EnumMember[] ret = [
		{{q{classed},         q{G_TYPE_FLAG_CLASSED}},         q{1 << 0}},
		{{q{instantiatable},  q{G_TYPE_FLAG_INSTANTIATABLE}},  q{1 << 1}},
		{{q{derivable},       q{G_TYPE_FLAG_DERIVABLE}},       q{1 << 2}},
		{{q{deepDerivable},   q{G_TYPE_FLAG_DEEP_DERIVABLE}},  q{1 << 3}},
	];
	return ret;
}()));

mixin(makeEnumBind(q{GTypeFlags}, aliases: [q{GTypeFlag}], members: (){
	EnumMember[] ret = [
		{{q{abstract_},        q{G_TYPE_FLAG_ABSTRACT}},        q{1 << 4}},
		{{q{valueAbstract},    q{G_TYPE_FLAG_VALUE_ABSTRACT}},  q{1 << 5}},
	];
	if(glibVersion >= Version(2,70,0)){
		EnumMember[] add = [
			{{q{final_},       q{G_TYPE_FLAG_FINAL}},           q{1 << 6}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,74,0)){
		EnumMember[] add = [
			{{q{none},         q{G_TYPE_FLAG_NONE}},            q{0}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,76,0)){
		EnumMember[] add = [
			{{q{deprecated_},  q{G_TYPE_FLAG_DEPRECATED}},      q{1 << 7}},
		];
		ret ~= add;
	}
	return ret;
}()));

struct GTypeInfo{
	ushort classSize;
	alias class_size = classSize;
	
	GBaseInitFunc baseInit;
	GBaseFinaliseFunc baseFinalise;
	alias base_init = baseInit;
	alias base_finalise = baseFinalise;
	alias base_finalize = baseFinalise;
	alias baseFinalize = baseFinalise;
	
	GClassInitFunc classInit;
	GClassFinaliseFunc classFinalise;
	const(void)* classData;
	alias class_init = classInit;
	alias class_finalise = classFinalise;
	alias class_finalize = classFinalise;
	alias classFinalize = classFinalise;
	alias class_data = classData;
	
	/* instantiated types */
	ushort instanceSize;
	ushort nPreAllocs;
	GInstanceInitFunc instanceInit;
	alias instance_size = instanceSize;
	alias n_preallocs = nPreAllocs;
	alias instance_init = instanceInit;
	
	const(GTypeValueTable)* valueTable;
	alias value_table = valueTable;
}

struct GTypeFundamentalInfo{
	GTypeFundamentalFlags typeFlags;
	alias type_flags = typeFlags;
}

struct GInterfaceInfo{
	GInterfaceInitFunc interfaceInit;
	GInterfaceFinaliseFunc interfaceFinalise;
	void* interfaceData;
	alias interface_init = interfaceInit;
	alias interface_finalise = interfaceFinalise;
	alias interface_finalize = interfaceFinalise;
	alias interfaceFinalize = interfaceFinalise;
	alias interface_data = interfaceData;
}

extern(C) nothrow{
	alias GTypeValueInitFunc = void function(GValue* value);
	alias GTypeValueFreeFunc = void function(GValue* value);
	alias GTypeValueCopyFunc = void function(const(GValue)* srcValue, GValue* destValue);
	alias GTypeValuePeekPointerFunc = void* function(const(GValue)* value);
	alias GTypeValueCollectFunc = char* function(GValue* value, uint nCollectValues, GTypeCValue* collectValues, uint collectFlags);
	alias GTypeValueLCopyFunc = char* function(const(GValue)* value, uint nCollectValues, GTypeCValue* collectValues, uint collectFlags);
}

struct GTypeValueTable{
	GTypeValueInitFunc valueInit;
	GTypeValueFreeFunc valueFree;
	GTypeValueCopyFunc valueCopy;
	GTypeValuePeekPointerFunc valuePeekPointer;
	alias value_init = valueInit;
	alias value_free = valueFree;
	alias value_copy = valueCopy;
	alias value_peek_pointer = valuePeekPointer;
	
	const(char)* collectFormat;
	GTypeValueCollectFunc collectValue;
	alias collect_format = collectFormat;
	alias collect_value = collectValue;
	
	const(char)* lCopyFormat;
	GTypeValueLCopyFunc lCopyValue;
	alias lcopy_format = lCopyFormat;
	alias lcopy_value = lCopyValue;
}

enum G_DECLARE_FINAL_TYPE = (string ModuleObjName, string module_obj_name, string MODULE, string OBJ_NAME, string ParentName) => "
alias "~ModuleObjName~" = _"~ModuleObjName~";
struct _"~ModuleObjName~"Class{
	"~ParentName~"Class parentClass;
	alias parent_class = parentClass;
}
alias "~ModuleObjName~"Class = _"~ModuleObjName~"Class;
"~_GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, ParentName)
~G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName~"Class", "g_type_class_unref")~"

pragma(inline,true) extern(C) nothrow @nogc{
	"~ModuleObjName~"* "~MODULE~"_"~OBJ_NAME~"(void* ptr) =>
		G_TYPE_CHECK_INSTANCE_CAST!"~ModuleObjName~"(ptr, "~module_obj_name~"_get_type());
	gboolean "~MODULE~"_IS_"~OBJ_NAME~"(void* ptr) =>
		G_TYPE_CHECK_INSTANCE_TYPE(ptr, "~module_obj_name~"_get_type());
}";

enum G_DECLARE_DERIVABLE_TYPE = (string ModuleObjName, string module_obj_name, string MODULE, string OBJ_NAME, string ParentName) => "
alias "~ModuleObjName~"Class = _"~ModuleObjName~"Class;
struct _"~ModuleObjName~"{
	"~ParentName~" parentInstance;
	alias parent_instance = parentInstance;
}
alias "~ModuleObjName~" = _"~ModuleObjName~";
"~_GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, ParentName)
~G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName~"Class", "g_type_class_unref")~"

pragma(inline,true) extern(C) nothrow @nogc{
	"~ModuleObjName~"* "~MODULE~"_"~OBJ_NAME~"(void* ptr) =>
		G_TYPE_CHECK_INSTANCE_CAST!"~ModuleObjName~"(ptr, "~module_obj_name~"_get_type());
	"~ModuleObjName~"Class* "~MODULE~"_"~OBJ_NAME~"_CLASS(void* ptr) =>
		G_TYPE_CHECK_CLASS_CAST!"~ModuleObjName~"Class(ptr, "~module_obj_name~"_get_type());
	gboolean "~MODULE~"_IS_"~OBJ_NAME~"(void* ptr){
		G_TYPE_CHECK_INSTANCE_TYPE(ptr, "~module_obj_name~"_get_type());
	gboolean "~MODULE~"_IS_"~OBJ_NAME~"_CLASS (void* ptr) {
		G_TYPE_CHECK_CLASS_TYPE(ptr, "~module_obj_name~"_get_type());
	"~ModuleObjName~"Class* "~MODULE~"_"~OBJ_NAME~"_GET_CLASS(void* ptr) =>
		G_TYPE_INSTANCE_GET_CLASS!"~ModuleObjName~"Class(ptr, "~module_obj_name~"_get_type());
}";

enum G_DECLARE_INTERFACE = (string ModuleObjName, string module_obj_name, string MODULE, string OBJ_NAME, string PrerequisiteName) => "
alias "~ModuleObjName~" = _"~ModuleObjName~";
alias "~ModuleObjName~"Interface = _"~ModuleObjName~"Interface;"~
_GLIB_DEFINE_AUTOPTR_CHAINUP(ModuleObjName, PrerequisiteName)~"

pragma(inline,true) extern(C) nothrow @nogc{
	"~ModuleObjName~"* "~MODULE~"_"~OBJ_NAME~"(void* ptr) =>
		G_TYPE_CHECK_INSTANCE_CAST(ptr, "~module_obj_name~"_get_type(), "~ModuleObjName~");
	gboolean "~MODULE~"_IS_"~OBJ_NAME~"(void* ptr) =>
		G_TYPE_CHECK_INSTANCE_TYPE(ptr, "~module_obj_name~"_get_type());
	"~ModuleObjName~"Interface* "~MODULE~"_"~OBJ_NAME~"_GET_IFACE(void* ptr) =>
		G_TYPE_INSTANCE_GET_INTERFACE(ptr, "~module_obj_name~"_get_type(), "~ModuleObjName~"Interface);
}";

enum G_DEFINE_TYPE = (string TN, string t_n, string T_P) =>
	G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, q{0}, "");

enum G_DEFINE_TYPE_WITH_CODE = (string TN, string t_n, string T_P, string _C_) =>
	_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, q{0}) ~ _C_ ~ _G_DEFINE_TYPE_EXTENDED_END();

enum G_DEFINE_ABSTRACT_TYPE = (string TN, string t_n, string T_P) =>
	G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, q{GTypeFlag.abstract_}, q{});

enum G_DEFINE_ABSTRACT_TYPE_WITH_CODE = (string TN, string t_n, string T_P, string _C_) =>
	_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, q{GTypeFlag.abstract_}) ~ _C_ ~ _G_DEFINE_TYPE_EXTENDED_END();

static if(glibVersion >= Version(2,38)){
	enum G_ADD_PRIVATE = (string TypeName) => "
		"~TypeName~"_private_offset = g_type_add_instance_private(&g_define_type_id, "~TypeName~"Private.sizeof);";
	
	enum G_DEFINE_TYPE_WITH_PRIVATE = (string TN, string t_n, string T_P) =>
		G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, q{0}, G_ADD_PRIVATE(TN));
	
	enum G_DEFINE_ABSTRACT_TYPE_WITH_PRIVATE = (string TN, string t_n, string T_P) =>
		G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, q{GTypeFlag.abstract_}, G_ADD_PRIVATE(TN));
	
	pragma(inline,true) nothrow @nogc @safe{
		int G_PRIVATE_OFFSET(string TypeName, string field)() =>
			mixin(TypeName~"_private_offset + "~TypeName~"Private."~field~".offsetof");
		
		void* G_PRIVATE_FIELD_P(string field_name, T)(T* inst) =>
			G_STRUCT_MEMBER_P(inst, G_PRIVATE_OFFSET!(__traits(identifier, T), field_name));
		
		FieldType G_PRIVATE_FIELD(FieldType, string field_name, T)(T* inst) =>
			G_STRUCT_MEMBER!(FieldType, T)(inst, G_PRIVATE_OFFSET!(__traits(identifier, T), field_name));
	}
}

static if(glibVersion >= Version(2,70,0)){
	enum G_DEFINE_FINAL_TYPE = (string TN, string t_n, string T_P) =>
		G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, q{GTypeFlag.final_}, q{});
	
	enum G_DEFINE_FINAL_TYPE_WITH_CODE = (string TN, string t_n, string T_P, string _C_) =>
		_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, q{GTypeFlag.final_}) ~ _C_ ~ _G_DEFINE_TYPE_EXTENDED_END();
	
	enum G_DEFINE_FINAL_TYPE_WITH_PRIVATE = (string TN, string t_n, string T_P) =>
		G_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, q{GTypeFlag.final_}, G_ADD_PRIVATE(TN));
}

enum G_DEFINE_TYPE_EXTENDED = (string TN, string t_n, string T_P, string _f_, string _C_) =>
	_G_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, _f_) ~ _C_ ~ _G_DEFINE_TYPE_EXTENDED_END();

enum G_DEFINE_INTERFACE = (string TN, string t_n, string T_P) =>
	G_DEFINE_INTERFACE_WITH_CODE(TN, t_n, T_P, q{});

enum G_DEFINE_INTERFACE_WITH_CODE = (string TN, string t_n, string T_P, string _C_) =>
	_G_DEFINE_INTERFACE_EXTENDED_BEGIN(TN, t_n, T_P) ~ _C_ ~ _G_DEFINE_INTERFACE_EXTENDED_END();

enum G_IMPLEMENT_INTERFACE = (string TYPE_IFACE, string iface_init) => "
		const g_implement_interface_info = GInterfaceInfo(cast(GInterfaceInitFunc)&"~iface_init~", null, null);
		g_type_add_interface_static(g_define_type_id, "~TYPE_IFACE~", &g_implement_interface_info);";

enum _G_DEFINE_TYPE_EXTENDED_CLASS_INIT = (string TypeName, string type_name) => "
private extern(C) void "~type_name~"_class_intern_init(void* class_){
	"~type_name~"_parent_class = g_type_class_peek_parent(class_);" ~ (
glibVersion >= Version(2,38) ? "
	if("~TypeName~"_private_offset != 0)
		g_type_class_adjust_private_offset(class_, &"~TypeName~"_private_offset);"
: "") ~ "
	"~type_name~"_class_init(cast("~TypeName~"Class*) class_);
}";

static if(glibVersion >= Version(2,80)){
	alias _g_type_once_init_type = GType;
	alias _g_type_once_init_enter = g_once_init_enter_pointer;
	alias _g_type_once_init_leave = g_once_init_leave_pointer;
}else{
	alias _g_type_once_init_type = size_t;
	alias _g_type_once_init_enter = g_once_init_enter;
	alias _g_type_once_init_leave = g_once_init_leave;
}

enum _G_DEFINE_TYPE_EXTENDED_BEGIN_PRE = (string TypeName, string type_name, string TYPE_PARENT) => "
private{
	void* "~type_name~"_parent_class = null;
	int "~TypeName~"_private_offset;
}
"~_G_DEFINE_TYPE_EXTENDED_CLASS_INIT(TypeName, type_name)~"

pragma(inline,true) private extern(C) void* "~type_name~"_get_instance_private("~TypeName~"* self) nothrow @nogc{
	return (cast(void*)self) + "~TypeName~"_private_offset;
}

extern(C) GType "~type_name~"_get_type() nothrow @nogc{
	static _g_type_once_init_type static_g_define_type_id = 0;";

enum _G_DEFINE_TYPE_EXTENDED_BEGIN_REGISTER = (string TypeName, string type_name, string TYPE_PARENT, string flags) => "
	if(_g_type_once_init_enter(&static_g_define_type_id)){
		GType g_define_type_id = "~type_name~"_get_type_once();
		_g_type_once_init_leave(&static_g_define_type_id, cast(void*)g_define_type_id);
	}
	return static_g_define_type_id;
} /+closes <type_name>_get_type()+/

pragma(inline,false) private extern(C) GType "~type_name~"_get_type_once() nothrow @nogc{
	GType g_define_type_id = g_type_register_static_simple(
		"~TYPE_PARENT~",
		g_intern_static_string(`"~TypeName~"`),
		"~TypeName~"Class.sizeof,
		cast(GClassInitFunc)&"~type_name~"_class_intern_init,
		"~TypeName~".sizeof,
		cast(GInstanceInitFunc)&"~type_name~"_init,
		cast(GTypeFlags)("~flags~"),
	);
	{ /+custom code follows+/";

enum _G_DEFINE_TYPE_EXTENDED_END = () => "
		/+following custom code+/
	}
	return g_define_type_id;
} /+closes <type_name>_get_type_once()+/";

enum _G_DEFINE_TYPE_EXTENDED_BEGIN = (string TypeName, string type_name, string TYPE_PARENT, string flags) =>
	_G_DEFINE_TYPE_EXTENDED_BEGIN_PRE(TypeName, type_name, TYPE_PARENT) ~
	_G_DEFINE_TYPE_EXTENDED_BEGIN_REGISTER(TypeName, type_name, TYPE_PARENT, flags);

enum _G_DEFINE_INTERFACE_EXTENDED_BEGIN = (string TypeName, string type_name, string TYPE_PREREQ) => "
extern(C) GType "~type_name~"_get_type() nothrow @nogc{
	static _g_type_once_init_type static_g_define_type_id = 0;
	if(_g_type_once_init_enter(&static_g_define_type_id)){
		GType g_define_type_id = g_type_register_static_simple(
			G_TYPE_INTERFACE,
			g_intern_static_string(`"~TypeName~"`),
			sizeof("~TypeName~"Interface),
			cast(GClassInitFunc)&"~type_name~"_default_init,
			0,
			cast(GInstanceInitFunc)null,
			cast(GTypeFlags)0,
		);
		if(TYPE_PREREQ != G_TYPE_INVALID)
			g_type_interface_add_prerequisite(g_define_type_id, TYPE_PREREQ);
		
		{ /+custom code follows+/";

enum _G_DEFINE_INTERFACE_EXTENDED_END = () => "
			/+following custom code+/
		}
		_g_type_once_init_leave(&static_g_define_type_id, g_define_type_id);
	}
	return static_g_define_type_id;
} /+closes <type_name>_get_type()+/";

enum G_DEFINE_BOXED_TYPE = (string TypeName, string type_name, string copyFunc, string freeFunc) =>
	G_DEFINE_BOXED_TYPE_WITH_CODE(TypeName, type_name, copyFunc, freeFunc, q{});

enum G_DEFINE_BOXED_TYPE_WITH_CODE = (string TypeName, string type_name, string copyFunc, string freeFunc, string _C_) =>
	_G_DEFINE_BOXED_TYPE_BEGIN(TypeName, type_name, copyFunc, freeFunc) ~ _C_ ~ _G_DEFINE_TYPE_EXTENDED_END();

enum _G_DEFINE_BOXED_TYPE_BEGIN = (string TypeName, string type_name, string copyFunc, string freeFunc) => "
extern(C) GType "~type_name~"_get_type() nothrow @nogc{
	static _g_type_once_init_type static_g_define_type_id = 0;
	if(_g_type_once_init_enter(&static_g_define_type_id)){
		GType g_define_type_id = "~type_name~"_get_type_once();
		_g_type_once_init_leave(&static_g_define_type_id, g_define_type_id);
	}
	return static_g_define_type_id;
}

pragma(inline,false) GType "~type_name~"_get_type_once(){
	GType g_define_type_id = g_boxed_type_register_static(
		g_intern_static_string(`"~TypeName~"`),
		cast(GBoxedCopyFunc)&"~copyFunc~",
		cast(GBoxedFreeFunc)&"~freeFunc~",
	);
	{ /+custom code follows+/";

enum G_DEFINE_POINTER_TYPE = (string TypeName, string type_name) =>
	G_DEFINE_POINTER_TYPE_WITH_CODE(TypeName, type_name, q{});

enum G_DEFINE_POINTER_TYPE_WITH_CODE = (string TypeName, string type_name, string _C_) =>
	_G_DEFINE_POINTER_TYPE_BEGIN(TypeName, type_name) ~ _C_ ~ _G_DEFINE_TYPE_EXTENDED_END();

enum _G_DEFINE_POINTER_TYPE_BEGIN = (string TypeName, string type_name) => "
extern(C) GType "~type_name~"_get_type() nothrow @nogc{
	static _g_type_once_init_type static_g_define_type_id = 0;
	if(_g_type_once_init_enter(&static_g_define_type_id)){
		GType g_define_type_id = "~type_name~"_get_type_once();
		_g_type_once_init_leave(&static_g_define_type_id, g_define_type_id);
	}
	return static_g_define_type_id;
}

pragma(inline,false) private extern(C) GType "~type_name~"_get_type_once(){
	GType g_define_type_id = g_pointer_type_register_static(g_intern_static_string(`"~TypeName~"`));
	{ /+custom code follows+/";

pragma(inline,true) nothrow @nogc{
	T* _G_TYPE_CIC(T)(GTypeInstance* instance, GType gType){
		version(D_Optimized){
			return cast(T*)instance;
		}else{
			return cast(T*)g_type_check_instance_cast(instance, gType);
		}
	}
	T* _G_TYPE_CCC(T)(GTypeClass* gClass, GType gType){
		version(D_Optimized){
			cast(T*)gClass;
		}else{
			cast(T*)g_type_check_class_cast(gClass, gType);
		}
	}
	
	bool _G_TYPE_CHI(GTypeInstance* instance) =>
		g_type_check_instance(instance) != 0;
	bool _G_TYPE_CHV(GValue* value) =>
		g_type_check_value(value) != 0;
	T* _G_TYPE_IGC(T)(GTypeInstance* instance, GType gType) =>
		cast(T*)instance.gClass;
	T* _G_TYPE_IGI(T)(GTypeInstance* instance, GType gType) =>
		cast(T*)g_type_interface_peek(instance.gClass, gType);
	static if(glibVersion >= Version(2,42,0))
	bool _G_TYPE_CIFT(GTypeInstance* instance, GType gType) =>
		g_type_check_instance_is_fundamentally_a(instance, gType) != 0;
	
	bool _G_TYPE_CIT(GTypeInstance* instance, GType gType){
		if(!instance){
			return false;
		}else if(instance.gClass && instance.gClass.gType == gType){
			return true;
		}else{
			return g_type_check_instance_is_a(instance, gType) != 0;
		}
	}
	bool _G_TYPE_CCT(GTypeClass* gClass, GType gType){
		if(!gClass){
			return false;
		}else if(gClass.gType == gType){
			return true;
		}else{
			return g_type_check_class_is_a(gClass, gType) != 0;
		}
	}
	bool _G_TYPE_CVH(GValue* value, GType gType){
		if(!value){
			return false;
		}else if(value.gType == gType){
			return true;
		}else{
			return g_type_check_value_holds(value, gType) != 0;
		}
	}
}
alias G_TYPE_CHECK_INSTANCE_CAST = _G_TYPE_CIC;
alias G_TYPE_CHECK_INSTANCE_TYPE = _G_TYPE_CIT;
static if(glibVersion >= Version(2,42,0))
alias G_TYPE_CHECK_INSTANCE_FUNDAMENTAL_TYPE = _G_TYPE_CIFT;
alias G_TYPE_INSTANCE_GET_CLASS = _G_TYPE_IGC;
alias G_TYPE_INSTANCE_GET_INTERFACE = _G_TYPE_IGI;
alias G_TYPE_CHECK_CLASS_CAST = _G_TYPE_CCC;
alias G_TYPE_CHECK_CLASS_TYPE = _G_TYPE_CCT;
alias G_TYPE_CHECK_VALUE = _G_TYPE_CHV;
alias G_TYPE_CHECK_VALUE_TYPE = _G_TYPE_CVH;

enum G_TYPE_FLAG_RESERVED_ID_BIT = cast(GType)1 << 0;

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{const(char)*}, q{g_type_name}, q{GType type}},
		{q{GQuark}, q{g_type_qname}, q{GType type}},
		{q{GType}, q{g_type_from_name}, q{const(char)* name}},
		{q{GType}, q{g_type_parent}, q{GType type}},
		{q{uint}, q{g_type_depth}, q{GType type}},
		{q{GType}, q{g_type_next_base}, q{GType leafType, GType rootType}},
		{q{gboolean}, q{g_type_is_a}, q{GType type, GType isAType}},
		{q{void*}, q{g_type_class_ref}, q{GType type}},
		{q{void*}, q{g_type_class_peek}, q{GType type}},
		{q{void*}, q{g_type_class_peek_static}, q{GType type}},
		{q{void}, q{g_type_class_unref}, q{void* gClass}},
		{q{void*}, q{g_type_class_peek_parent}, q{void* gClass}},
		{q{void*}, q{g_type_interface_peek}, q{void* instanceClass, GType ifaceType}},
		{q{void*}, q{g_type_interface_peek_parent}, q{void* gIFace}},
		{q{void*}, q{g_type_default_interface_ref}, q{GType gType}},
		{q{void*}, q{g_type_default_interface_peek}, q{GType gType}},
		{q{void}, q{g_type_default_interface_unref}, q{void* gIFace}},
		{q{GType*}, q{g_type_children}, q{GType type, uint* nChildren}},
		{q{GType*}, q{g_type_interfaces}, q{GType type, uint* nInterfaces}},
		{q{void}, q{g_type_set_qdata}, q{GType type, GQuark quark, void* data}},
		{q{void*}, q{g_type_get_qdata}, q{GType type, GQuark quark}},
		{q{void}, q{g_type_query}, q{GType type, GTypeQuery* query}},
		{q{GType}, q{g_type_register_static}, q{GType parentType, const(char)* typeName, const(GTypeInfo)* info, GTypeFlags flags}},
		{q{GType}, q{g_type_register_static_simple}, q{GType parentType, const(char)* typeName, uint classSize, GClassInitFunc classInit, uint instanceSize, GInstanceInitFunc instanceInit, GTypeFlags flags}},
		{q{GType}, q{g_type_register_dynamic}, q{GType parentType, const(char)* typeName, GTypePlugin* plugin, GTypeFlags flags}},
		{q{GType}, q{g_type_register_fundamental}, q{GType typeID, const(char)* typeName, const(GTypeInfo)* info, const(GTypeFundamentalInfo)* fInfo, GTypeFlags flags}},
		{q{void}, q{g_type_add_interface_static}, q{GType instanceType, GType interfaceType, const(GInterfaceInfo)* info}},
		{q{void}, q{g_type_add_interface_dynamic}, q{GType instanceType, GType interfaceType, GTypePlugin* plugin}},
		{q{void}, q{g_type_interface_add_prerequisite}, q{GType interfaceType, GType prerequisiteType}},
		{q{GType*}, q{g_type_interface_prerequisites}, q{GType interfaceType, uint* nPrerequisites}},
		{q{void*}, q{g_type_instance_get_private}, q{GTypeInstance* instance, GType privateType}},
		{q{void}, q{g_type_add_class_private}, q{GType classType, size_t privateSize}},
		{q{void*}, q{g_type_class_get_private}, q{GTypeClass* gType, GType privateType}},
		{q{GTypePlugin*}, q{g_type_get_plugin}, q{GType type}},
		{q{GTypePlugin*}, q{g_type_interface_get_plugin}, q{GType instanceType, GType interfaceType}},
		{q{GType}, q{g_type_fundamental_next}, q{}},
		{q{GType}, q{g_type_fundamental}, q{GType typeID}, aliases: [q{G_TYPE_FUNDAMENTAL}]},
		{q{GTypeInstance*}, q{g_type_create_instance}, q{GType type}},
		{q{void}, q{g_type_free_instance}, q{GTypeInstance* instance}},
		{q{void}, q{g_type_add_class_cache_func}, q{void* cacheData, GTypeClassCacheFunc cacheFunc}},
		{q{void}, q{g_type_remove_class_cache_func}, q{void* cacheData, GTypeClassCacheFunc cacheFunc}},
		{q{void}, q{g_type_class_unref_uncached}, q{void* gClass}},
		{q{void}, q{g_type_add_interface_check}, q{void* checkData, GTypeInterfaceCheckFunc checkFunc}},
		{q{void}, q{g_type_remove_interface_check}, q{void* checkData, GTypeInterfaceCheckFunc checkFunc}},
		{q{GTypeValueTable*}, q{g_type_value_table_peek}, q{GType type}},
		{q{gboolean}, q{g_type_check_instance}, q{GTypeInstance* instance}, aliases: [q{G_TYPE_CHECK_INSTANCE}]},
		{q{GTypeInstance*}, q{g_type_check_instance_cast}, q{GTypeInstance* instance, GType ifaceType}},
		{q{gboolean}, q{g_type_check_instance_is_a}, q{GTypeInstance* instance, GType ifaceType}},
		{q{GTypeClass*}, q{g_type_check_class_cast}, q{GTypeClass* gClass, GType isAType}},
		{q{gboolean}, q{g_type_check_class_is_a}, q{GTypeClass* gClass, GType isAType}},
		{q{gboolean}, q{g_type_check_is_value_type}, q{GType type}, attr: q{pure}},
		{q{gboolean}, q{g_type_check_value}, q{const(GValue)* value}},
		{q{gboolean}, q{g_type_check_value_holds}, q{const(GValue)* value, GType type}},
		{q{gboolean}, q{g_type_test_flags}, q{GType type, uint flags}, attr: q{pure}},
		{q{const(char)*}, q{g_type_name_from_instance}, q{GTypeInstance* instance}},
		{q{const(char)*}, q{g_type_name_from_class}, q{GTypeClass* gClass}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{void}, q{g_type_ensure}, q{GType type}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,36,0)){
		FnBind[] add = [
			{q{uint}, q{g_type_get_type_registration_serial}, q{}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,38,0)){
		FnBind[] add = [
			{q{int}, q{g_type_add_instance_private}, q{GType classType, size_t privateSize}},
			{q{void}, q{g_type_class_adjust_private_offset}, q{void* gClass, int* privateSizeOrOffset}},
			{q{int}, q{g_type_class_get_instance_private_offset}, q{void* gClass}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,42,0)){
		FnBind[] add = [
			{q{gboolean}, q{g_type_check_instance_is_fundamentally_a}, q{GTypeInstance* instance, GType fundamentalType}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,44,0)){
		FnBind[] add = [
			{q{int}, q{g_type_get_instance_count}, q{GType type}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,68,0)){
		FnBind[] add = [
			{q{GType}, q{g_type_interface_instantiatable_prerequisite}, q{GType interfaceType}},
		];
		ret ~= add;
	}
	return ret;
}()));
