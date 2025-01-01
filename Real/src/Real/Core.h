#pragma once

#ifdef RE_PLATFORM_WINDOW
	#ifdef RE_BUILD_DLL
		#define REAL_API __declspec(dllexport)
	#else
		#define REAL_API __declspec(dllimport)
	#endif // RE_BUILD_DLL
#else
	#error Real only supports Windows!
#endif // RE_PLATFORM_WINDOW

#define BIT(x) (1 << x)
