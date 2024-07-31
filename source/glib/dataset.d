/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module glib.dataset;

import bindbc.glib.config;
import bindbc.glib.codegen;

import glib.quark;
import glib.types;

struct GData;

extern(C) nothrow{
	alias GDataForeachFunc = void function(GQuark keyID, void* data, void* userData);
	alias GDuplicateFunc = void* function(void* data, void* userData);
}

enum G_DATALIST_FLAGS_MASK = 0x3;

pragma(inline,true) nothrow @nogc{
	void g_datalist_id_set_data(GData** dataList, GQuark keyID, void* data){
		g_datalist_id_set_data_full(dataList, keyID, data, null);
	}
	void g_datalist_id_remove_data(GData** dataList, GQuark q){
		g_datalist_id_set_data(dataList, q, null);
	}
	void g_datalist_set_data_full(GData** dataList, const(char)* keyID, void* data, GDestroyNotify destroyFunc){
		g_datalist_id_set_data_full(dataList, g_quark_from_string(keyID), data, destroyFunc);
	}
	auto g_datalist_remove_no_notify(GData** dataList, const(char)* keyID) =>
		g_datalist_id_remove_no_notify(dataList, g_quark_try_string(keyID));
	
	void g_datalist_set_data(GData** dataList, const(char)* keyID, void* data){
		g_datalist_set_data_full(dataList, keyID, data, null);
	}
	void g_datalist_remove_data(GData** dataList, const(char)* keyID){
		g_datalist_id_set_data(dataList, g_quark_try_string(keyID), null);
	}
	
	void g_dataset_id_set_data(const(void)* datasetLocation, GQuark keyID, void* data){
		g_dataset_id_set_data_full(datasetLocation, keyID, data, null);
	}
	void g_dataset_id_remove_data(const(void)* datasetLocation, GQuark keyID){
		g_dataset_id_set_data(datasetLocation, keyID, null);
	}
	auto g_dataset_get_data(const(void)* datasetLocation, const(char)* keyID) =>
		g_dataset_id_get_data(datasetLocation, g_quark_try_string(keyID));
	
	void g_dataset_set_data_full(const(void)* datasetLocation, const(char)* keyID, void* data, GDestroyNotify destroyFunc){
		g_dataset_id_set_data_full(datasetLocation, g_quark_from_string(keyID), data, destroyFunc);
	}
	auto g_dataset_remove_no_notify(const(void)* datasetLocation, const(char)* keyID) =>
		g_dataset_id_remove_no_notify(datasetLocation, g_quark_try_string(keyID));
	
	void g_dataset_set_data(const(void)* datasetLocation, const(char)* keyID, void* data){
		g_dataset_set_data_full (datasetLocation, keyID, data, null);
	}
	void g_dataset_remove_data(const(void)* datasetLocation, const(char)* keyID){
		g_dataset_id_set_data(datasetLocation, g_quark_try_string(keyID), null);
	}
}

mixin(joinFnBinds((){
	FnBind[] ret = [
		{q{void}, q{g_datalist_init}, q{GData** dataList}},
		{q{void}, q{g_datalist_clear}, q{GData** dataList}},
		{q{void*}, q{g_datalist_id_get_data}, q{GData** dataList, GQuark keyID}},
		{q{void}, q{g_datalist_id_set_data_full}, q{GData** dataList, GQuark keyID, void* data, GDestroyNotify destroyFunc}},
		{q{void*}, q{g_datalist_id_remove_no_notify}, q{GData** dataList, GQuark keyID}},
		{q{void}, q{g_datalist_foreach}, q{GData** dataList, GDataForeachFunc func, void* userData}},
		{q{void}, q{g_datalist_set_flags}, q{GData** dataList, uint flags}},
		{q{void}, q{g_datalist_unset_flags}, q{GData** dataList, uint flags}},
		{q{uint}, q{g_datalist_get_flags}, q{GData** dataList}},
		{q{void}, q{g_dataset_destroy}, q{const(void)* datasetLocation}},
		{q{void*}, q{g_dataset_id_get_data}, q{const(void)* datasetLocation, GQuark keyID}},
		{q{void*}, q{g_datalist_get_data}, q{GData** dataList, const(char)* key}},
		{q{void}, q{g_dataset_id_set_data_full}, q{const(void)* datasetLocation, GQuark keyID, void* data, GDestroyNotify destroyFunc}},
		{q{void*}, q{g_dataset_id_remove_no_notify}, q{const(void)* datasetLocation, GQuark keyID}},
		{q{void}, q{g_dataset_foreach}, q{const(void)* datasetLocation, GDataForeachFunc func, void* userData}},
	];
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{void*}, q{g_datalist_id_dup_data}, q{GData** dataList, GQuark keyID, GDuplicateFunc dupFunc, void* userData}},
			{q{gboolean}, q{g_datalist_id_replace_data}, q{GData** dataList, GQuark keyID, void* oldval, void* newval, GDestroyNotify destroy, GDestroyNotify* oldDestroy}},
		];
		ret ~= add;
	}
	if(glibVersion >= Version(2,34,0)){
		FnBind[] add = [
			{q{void}, q{g_datalist_id_remove_multiple}, q{GData** dataList, GQuark* keys, size_t nKeys}},
		];
		ret ~= add;
	}
	return ret;
}()));
