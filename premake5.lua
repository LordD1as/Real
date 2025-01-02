workspace "Real"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Real/vendor/GLFW/include"
IncludeDir["Glad"] = "Real/vendor/Glad/include"

include "Real/vendor/GLFW"
include "Real/vendor/Glad"

project "Real"
	location "Real"
	kind "SharedLib"
	language "C++"
	
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "repch.h"
	pchsource "Real/src/repch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}"
	}

	links
	{
		"GLFW",
		"Glad",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"RE_PLATFORM_WINDOWS",
			"RE_BUILD_DLL"
		}

		buildoptions
		{
			("/utf-8")
		}		

	filter "configurations:Debug"
		defines 
		{
			"RE_DEBUG",
			"RE_ENABLE_ASSERTS",
			"GLFW_INCLUDE_NONE"
		}		
		buildoptions "/MDd"
		staticruntime "off"
		runtime "Debug"
		symbols "On"	

	filter "configurations:Release"
		defines "RE_RELEASE"
		buildoptions "/MD"
		staticruntime "off"
		runtime "Release"
		optimize "On"
		
	filter "configurations:Dist"
		defines "RE_DIST"
		buildoptions "/MD"
		staticruntime "off"
		runtime "Release"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	
	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Real/src",
		"Real/vendor/spdlog/include"
	}

	links
	{
		"Real"
	}

	postbuildcommands
	{
		("{COPYFILE} %[C:/dev/Real/bin/" .. outputdir .. "/Real/Real.dll]" 
		.. " %[C:/dev/Real/bin/" .. outputdir .. "/Sandbox]")
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"RE_PLATFORM_WINDOWS"
		}

		buildoptions
		{
			("/utf-8")
		}

	filter "configurations:Debug"
		defines "RE_DEBUG"
		symbols "On"	

	filter "configurations:Release"
		defines "RE_RELEASE"
		optimize "On"
		
	filter "configurations:Dist"
		defines "RE_DIST"
		optimize "On"