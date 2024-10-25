
# BindBC-GLib
This project provides a set of both static and dynamic bindings to [GLib & GObject](https://gitlab.gnome.org/GNOME/glib/). They are compatible with `@nogc` and `nothrow`, and can be compiled with BetterC compatibility.

| Table of Contents |
|-------------------|
|[License](#license)|
|[GLib documentation](#glib-documentation)|
|[Quickstart guide](#quickstart-guide)|
|[Binding-specific changes](#binding-specific-changes)|
|[Configurations](#configurations)|
|[Library versions](#library-versions)|

## License
BindBC-GLib&mdash;as well as every other binding in the [BindBC project](https://github.com/BindBC)&mdash;is licensed under the [Boost Software License](https://www.boost.org/LICENSE_1_0.txt).

Bear in mind that you still need to abide by [GLib's license](https://gitlab.gnome.org/GNOME/glib/-/blob/main/COPYING) if you use it through these bindings.

## GLib documentation
This readme describes how to use BindBC-GLib, *not* GLib and GObject themselves. BindBC-GLib does have minor API changes from GLib and GObject, which are listed in [Binding-specific changes](#binding-specific-changes). Otherwise BindBC-GLib is a direct D binding to the GLib & GObject C APIs, so any existing GLib/GObject documentation and tutorials can be adapted with only minor modifications.
* [GLib's API documentation](https://docs.gtk.org/glib/).
* [GObject's API documentation](https://docs.gtk.org/gobject/).
* [GObject Tutorial for beginners](https://toshiocp.github.io/Gobject-tutorial/).

## Quickstart guide
To use BindBC-GLib in your dub project, add it and BindBC-GLib to the list of `dependencies` in your dub configuration file. The easiest way is by running `dub add bindbc-glib` in your project folder. The result should look something like this:

Example __dub.json__
```json
"dependencies": {
	"bindbc-glib": "~>1.0",
},
```
Example __dub.sdl__
```sdl
dependency "bindbc-glib" version="~>1.0"
```

If you want to use the GObject bindings, you'll have to add the `:gobject` submodule as a dependency:

Example __dub.json__
```json
"dependencies": {
	"bindbc-glib": "~>1.0",
	"bindbc-glib:gobject": "~>1.0",
},
```
Example __dub.sdl__
```sdl
dependency "bindbc-glib" version="~>1.0"
dependency "bindbc-glib:gobject" version="~>1.0"
```

By default, BindBC-GLib is configured to compile as a dynamic binding that is not BetterC-compatible. If you prefer static bindings or need BetterC compatibility, they can be enabled via `subConfigurations` in your dub configuration file. For configuration naming & more details, see [Configurations](#configurations).

Example __dub.json__
```json
"subConfigurations": {
	"bindbc-glib": "staticBC",
},
```
Example __dub.sdl__
```sdl
subConfiguration "bindbc-glib" "staticBC"
```

If you need to use versions of GLib & GObject newer than 2.2.0, then you will have to add the appropriate version identifier to `versions` in your dub configuration. For a list of library version identifiers, see [Library versions](#library-versions).

If you're using static bindings, then you will also need to add the name of the GLib library (and the GObject library if you're using it) to `libs`.

Example __dub.json__
```json
"versions": [
	"GLib_2_40_0",
],
"libs": [
	"glib-2.0", "gobject-2.0",
],
```
Example __dub.sdl__
```sdl
versions "GLib_2_40_0"
libs "glib-2.0" "gobject-2.0"
```

**If you're using static bindings**: `import bindbc.glib` in your code, and then you can use all of GLib just like you would in C. That's it!
```d
import bindbc.glib;

void main(){
	auto heapInt = cast(int*)g_malloc0(int.sizeof);
	
	//etc.
	
	g_free(heapInt);
}
```

**If you're using dynamic bindings**: you need to load each library you need with the appropriate load function. `loadGLib` for GLib, and `loadGObject` for GObject.

For most use cases, it's best to use BindBC-Loader's [error handling API](https://github.com/BindBC/bindbc-loader#error-handling) to see if there were any errors while loading the library. This information can be written to a log file before aborting the program.

The load function will also return a member of the `LoadMsg` enum, which can be used for debugging:

* `noLibrary` means the library couldn't be found.
* `badLibrary` means there was an error while loading the library.
* `success` means that the library was loaded without any errors.

Here's a simple example using only the load function's return value:

```d
import bindbc.glib;
import bindbc.loader;

/*
This code attempts to load the GLib shared library using
well-known variations of the library name for the host system.
*/
LoadMsg ret = loadGLib();
if(ret != LoadMsg.success){
	/*
	Error handling. For most use cases, it's best to use the error handling API in
	BindBC-Loader to retrieve error messages for logging and then abort.
	If necessary, it's possible to determine the root cause via the return value:
	*/
	if(ret == LoadMsg.noLibrary){
		//The GLib shared library failed to load
	}else if(ret == LoadMsg.badLibrary){
		//One or more symbols failed to load.
	}
}

/*
This code attempts to load GLib using a user-supplied file name.
Usually, the name and/or path used will be platform specific, as in this
example which attempts to load `glib.dll` from the `libs` subdirectory,
relative to the executable, only on Windows.
*/
version(Windows) loadGLib("libs/glib.dll");
```

[The error handling API](https://github.com/BindBC/bindbc-loader#error-handling) in BindBC-Loader can be used to log error messages:
```d
import bindbc.glib;

/*
Import the sharedlib module for error handling. Assigning an alias ensures that the
function names do not conflict with other public APIs. This isn't strictly necessary,
but the API names are common enough that they could appear in other packages.
*/
import loader = bindbc.loader.sharedlib;

bool loadLib(){
	LoadMsg ret = loadGLib();
	if(ret != LoadMsg.success){
		//Log the error info
		foreach(info; loader.errors){
			/*
			A hypothetical logging function. Note that `info.error` and
			`info.message` are `const(char)*`, not `string`.
			*/
			logError(info.error, info.message);
		}
		
		//Optionally construct a user-friendly error message for the user
		string msg;
		if(ret == LoadMsg.noLibrary){
			msg = "This application requires the GLib library.";
		}else{
			if(auto versionMsg = glib_check_version(glibVersion.major, glibVersion.minor, glibVersion.patch)){
				msg = versionMsg;
			}else{
				msg = "There should be a version mismatch, but there isn't. Submit an issue to BindBC-GLib.";
			}
		}
		//A hypothetical message box function
		showMessageBox(msg);
		return false;
	}
	return true;
}
```

## Binding-specific changes
Features that have been deprecated since the creation of these bindings are omitted. Some modules have also been omitted for simplicity (e.g. modules with atomics, multi-threading, time, and dates). If you need any of these features, please create a PR or open an issue.

Complex code-generation `#defines` have been converted to string mixin generators. Most cases where identifiers are passed in C are string parameters instead:
```d
mixin(G_DEFINE_TYPE("GStringSubclass", "gstring_subclass", "G_TYPE_GSTRING"));
```

Enums are available both in their original C-style `UPPER_SNAKE_CASE` form, and as the D-style `PascalCase.camelCase`. Both variants are enabled by default, but can be selectively chosen using the version identifiers `GLib_C_Enums_Only` or `GLib_D_Enums_Only` respectively.

> [!NOTE]\
> The version identifiers `BindBC_C_Enums_Only` and `BindBC_D_Enums_Only` can be used to configure all of the applicable _official_ BindBC packages used in your program. Package-specific version identifiers override this.

`camelCase`d variants are available for struct fields using `snake_case` or `lowercase`.

## Configurations
BindBC-GLib has the following configurations:

|      ┌      |  DRuntime  |   BetterC   |
|-------------|------------|-------------|
| **Dynamic** | `dynamic`  | `dynamicBC` |
| **Static**  | `static`   | `staticBC`  |

For projects that don't use dub, if BindBC-GLib is compiled for static bindings then the version identifier `BindGLib_Static` must be passed to your compiler when building your project.

> [!NOTE]\
> The version identifier `BindBC_Static` can be used to configure all of the _official_ BindBC packages used in your program. (i.e. those maintained in [the BindBC GitHub organisation](https://github.com/BindBC)) Some third-party BindBC packages may support it as well.

### Dynamic bindings
The dynamic bindings have no link-time dependency on GLib, so the GLib shared library must be manually loaded at runtime from the shared library search path of the user's system.
On Windows, this is typically handled by distributing the GLib DLLs with your program.
On other systems, it usually means installing the GLib shared library through a package manager.

The function `isGLibLoaded` returns `true` if any version of the shared library has been loaded and `false` if not. `unloadGLib` can be used to unload a successfully loaded shared library.

### Static bindings
Static _bindings_ do not require static _linking_. The static bindings have a link-time dependency on either the shared _or_ static GLib library. On Windows, you can link with the static library or, to use the DLLs, the import library. On other systems, you can link with either the static library or directly with the shared library.

When linking with the shared (or import) library, there is a runtime dependency on the shared library just as there is when using the dynamic bindings. The difference is that the shared library are no longer loaded manually&mdash;loading is handled automatically by the system when the program is launched. Attempting to call `loadGLib` with the static bindings enabled will result in a compilation error.

Static linking requires GLib's development packages be installed on your system. The [GLib repository](https://gitlab.gnome.org/GNOME/glib/) provides the library's source code. You can also install them via your system's package manager. For example, on Debian-based Linux distributions `sudo apt install libglib2.0-dev` will install both the development and runtime packages for GLib.

When linking with the static library, there is no runtime dependency on GLib.

## Library Versions

| Version |Version identifier|
|---------|------------------|
| 2.80.0  | `GLib_2_80_0`    |
| 2.78.0  | `GLib_2_78_0`    |
| 2.76.0  | `GLib_2_76_0`    |
| 2.74.0  | `GLib_2_74_0`    |
| 2.72.0  | `GLib_2_72_0`    |
| 2.70.0  | `GLib_2_70_0`    |
| 2.68.0  | `GLib_2_68_0`    |
| 2.66.0  | `GLib_2_66_0`    |
| 2.64.0  | `GLib_2_64_0`    |
| 2.62.7  | `GLib_2_62_0`    |
| 2.60.0  | `GLib_2_60_0`    |
| 2.58.0  | `GLib_2_58_0`    |
| 2.56.0  | `GLib_2_56_0`    |
| 2.54.0  | `GLib_2_54_0`    |
| 2.52.0  | `GLib_2_52_0`    |
| 2.50.0  | `GLib_2_50_0`    |
| 2.48.1  | `GLib_2_48_0`    |
| 2.46.0  | `GLib_2_46_0`    |
| 2.44.0  | `GLib_2_44_0`    |
| 2.42.0  | `GLib_2_42_0`    |
| 2.40.0  | `GLib_2_40_0`    |
| 2.38.0  | `GLib_2_38_0`    |
| 2.36.0  | `GLib_2_36_0`    |
| 2.34.0  | `GLib_2_34_0`    |
| 2.32.0  | `GLib_2_32_0`    |
| 2.30.0  | `GLib_2_30_0`    |
| 2.28.0  | `GLib_2_28_0`    |
| 2.26.0  | `GLib_2_26_0`    |
| 2.24.0  | `GLib_2_24_0`    |
| 2.22.0  | `GLib_2_22_0`    |
| 2.20.0  | `GLib_2_20_0`    |
| 2.18.0  | `GLib_2_18_0`    |
| 2.16.3  | `GLib_2_16_3`    |
| 2.16.0  | `GLib_2_16_0`    |
| 2.14.0  | `GLib_2_14_0`    |
| 2.12.0  | `GLib_2_12_0`    |
| 2.10.0  | `GLib_2_10_0`    |
| 2.8.0   | `GLib_2_8_0`     |
| 2.6.0   | `GLib_2_6_0`     |
| 2.4.0   | `GLib_2_4_0`     |
| 2.2.0   | (none; default)  |
