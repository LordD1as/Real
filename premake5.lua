workspace "Real"
	architecture "x64"	
	startproject "Sandbox"

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
IncludeDir["ImGui"] = "Real/vendor/imgui"
IncludeDir["glm"] = "Real/vendor/glm"

group "Dependecies"
	include "Real/vendor/GLFW"
	include "Real/vendor/Glad"
	include "Real/vendor/imgui"
group ""

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
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
	}

	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	postbuildcommands
	{		
		("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
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
		"Real/vendor/spdlog/include",
		"%{IncludeDir.glm}"
	}

	links
	{
		"Real"
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