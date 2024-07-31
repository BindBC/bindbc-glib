/+
+               Copyright 2024 Aya Partridge
+ Distributed under the Boost Software License, Version 1.0.
+     (See accompanying file LICENSE_1_0.txt or copy at
+           http://www.boost.org/LICENSE_1_0.txt)
+/
module bindbc.glib.config;

public import bindbc.common.types: c_long, c_ulong, va_list;
public import bindbc.common.versions: Version;

enum staticBinding = (){
	version(BindBC_Static)         return true;
	else version(BindGLib_Static) return true;
	else return false;
}();

enum cStyleEnums = (){
	version(GLib_C_Enums_Only)       return true;
	else version(BindBC_D_Enums_Only) return false;
	else version(GLib_D_Enums_Only)  return false;
	else return true;
}();

enum dStyleEnums = (){
	version(GLib_D_Enums_Only)       return true;
	else version(BindBC_C_Enums_Only) return false;
	else version(GLib_C_Enums_Only)  return false;
	else return true;
}();

enum glibVersion = (){
	version(GLib_2_80_0)       return Version(2,80,0);
	else version(GLib_2_78_0)  return Version(2,78,0);
	else version(GLib_2_76_0)  return Version(2,76,0);
	else version(GLib_2_74_0)  return Version(2,74,0);
	else version(GLib_2_72_0)  return Version(2,72,0);
	else version(GLib_2_70_0)  return Version(2,70,0);
	else version(GLib_2_68_0)  return Version(2,68,0);
	else version(GLib_2_66_0)  return Version(2,66,0);
	else version(GLib_2_64_0)  return Version(2,64,0);
	else version(GLib_2_62_0)  return Version(2,62,0);
	else version(GLib_2_60_0)  return Version(2,60,0);
	else version(GLib_2_58_0)  return Version(2,58,0);
	else version(GLib_2_56_0)  return Version(2,56,0);
	else version(GLib_2_54_0)  return Version(2,54,0);
	else version(GLib_2_52_0)  return Version(2,52,0);
	else version(GLib_2_50_0)  return Version(2,50,0);
	else version(GLib_2_48_0)  return Version(2,48,0);
	else version(GLib_2_46_0)  return Version(2,46,0);
	else version(GLib_2_44_0)  return Version(2,44,0);
	else version(GLib_2_42_0)  return Version(2,42,0);
	else version(GLib_2_40_0)  return Version(2,40,0);
	else version(GLib_2_38_0)  return Version(2,38,0);
	else version(GLib_2_36_0)  return Version(2,36,0);
	else version(GLib_2_34_0)  return Version(2,34,0);
	else version(GLib_2_32_0)  return Version(2,32,0);
	else version(GLib_2_30_0)  return Version(2,30,0);
	else version(GLib_2_28_0)  return Version(2,28,0);
	else version(GLib_2_26_0)  return Version(2,26,0);
	else version(GLib_2_24_0)  return Version(2,24,0);
	else version(GLib_2_22_0)  return Version(2,22,0);
	else version(GLib_2_20_0)  return Version(2,20,0);
	else version(GLib_2_18_0)  return Version(2,18,0);
	else version(GLib_2_16_3)  return Version(2,16,3);
	else version(GLib_2_16_0)  return Version(2,16,0);
	else version(GLib_2_14_0)  return Version(2,14,0);
	else version(GLib_2_12_0)  return Version(2,12,0);
	else version(GLib_2_10_0)  return Version(2,10,0);
	else version(GLib_2_8_0)   return Version(2,8,0);
	else version(GLib_2_6_0)   return Version(2,6,0);
	else version(GLib_2_4_0)   return Version(2,4,0);
	else                       return Version(2,2,0);
}();
