/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.macros;

import bindbc.glib.config;
import bindbc.glib.codegen;

enum G_STRLOC = (string file=__FILE__, size_t line=__LINE__) => file ~ ":" ~ line.stringof;

pragma(inline,true) nothrow @nogc pure @safe{
	bool G_APPROX_VALUE(F)(F a, F b, F epsilon)
	if(__traits(isFloating, F)) =>
		(a > b ? a - b : b - a) < epsilon;
	
	void* G_STRUCT_MEMBER_P(S)(S* structP, size_t structOffset) =>
		cast(void*)structP + structOffset;
	MemberType G_STRUCT_MEMBER(MemberType, S)(S* structP, size_t structOffset) =>
		*cast(MemberType*)G_STRUCT_MEMBER_P!S(structP, structOffset);
}

enum _GLIB_AUTOPTR_FUNC_NAME = (string TypeName) => "glib_autoptr_cleanup_"~TypeName;
enum _GLIB_AUTOPTR_CLEAR_FUNC_NAME = (string TypeName) => "glib_autoptr_clear_"~TypeName;
enum _GLIB_AUTOPTR_TYPENAME = (string TypeName) => TypeName~"_autoptr";
enum _GLIB_AUTOPTR_LIST_FUNC_NAME = (string TypeName) => "glib_listautoptr_cleanup_"~TypeName;
enum _GLIB_AUTOPTR_LIST_TYPENAME = (string TypeName) => TypeName~"_listautoptr";
enum _GLIB_AUTOPTR_SLIST_FUNC_NAME = (string TypeName) => "glib_slistautoptr_cleanup_"~TypeName;
enum _GLIB_AUTOPTR_SLIST_TYPENAME = (string TypeName) => TypeName~"_slistautoptr";
enum _GLIB_AUTOPTR_QUEUE_FUNC_NAME = (string TypeName) => "glib_queueautoptr_cleanup_"~TypeName;
enum _GLIB_AUTOPTR_QUEUE_TYPENAME = (string TypeName) => TypeName~"_queueautoptr";
enum _GLIB_AUTO_FUNC_NAME = (string TypeName) => "glib_auto_cleanup_"~TypeName;
enum _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS = (string TypeName, string ParentName, string cleanup) => "
extern(C) nothrow{
	alias "~_GLIB_AUTOPTR_TYPENAME(TypeName)~" = "~TypeName~"*;
	alias "~_GLIB_AUTOPTR_LIST_TYPENAME(TypeName)~" = GList*;
	alias "~_GLIB_AUTOPTR_SLIST_TYPENAME(TypeName)~" = GSList*;
	alias "~_GLIB_AUTOPTR_QUEUE_TYPENAME(TypeName)~" = GQueue*;
}
pragma(inline,true) nothrow @nogc{
	void "~_GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName)~"("~TypeName~"* ptr){
		if(ptr) "~cleanup~"(cast("~ParentName~"*)ptr);
	}
	void "~_GLIB_AUTOPTR_FUNC_NAME(TypeName)~"("~TypeName~"** ptr){
		"~_GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName)~"(*ptr);
	}
	void "~_GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName)~"(GList** l){
		g_list_free_full(*l, cast(GDestroyNotify)&"~cleanup~");
	}
	void "~_GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName)~"(GSList** l){
		g_slist_free_full(*l, cast(GDestroyNotify)&"~cleanup~");
	}
	void "~_GLIB_AUTOPTR_QUEUE_FUNC_NAME(TypeName)~"(GQueue** q){
		if(*q)
			g_queue_free_full(*q, cast(GDestroyNotify)&"~cleanup~");
	}
}";
enum _GLIB_DEFINE_AUTOPTR_CHAINUP = (string ModuleObjName, string ParentName) =>
	_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(ModuleObjName, ParentName, _GLIB_AUTOPTR_CLEAR_FUNC_NAME(ParentName));

enum G_DEFINE_AUTOPTR_CLEANUP_FUNC = (string TypeName, string func) =>
	_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func);
enum G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC = (string TypeName, string func) => "
pragma(inline,true) void "~_GLIB_AUTO_FUNC_NAME(TypeName)~"("~TypeName~"* ptr) nothrow @nogc{
	"~func~"(ptr);
}";
enum G_DEFINE_AUTO_CLEANUP_FREE_FUNC = (string TypeName, string func, string none) => "
pragma(inline,true) void "~_GLIB_AUTO_FUNC_NAME(TypeName)~"("~TypeName~"* ptr) nothrow @nogc{
	if(*ptr != "~none~") "~func~"(*ptr);
}";
