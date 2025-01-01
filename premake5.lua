workspace "Real"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Real"
	location "Real"
	kind "SharedLib"
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
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"RE_PLATFORM_WINDOW",
			"RE_BUILD_DLL"
		}

		buildoptions
		{
			("/utf-8")
		}

		postbuildcommands
		{
			("{COPYFILE} %[C:/dev/Real/bin/" .. outputdir .. "/%{prj.name}/%{prj.name}.dll]" 
			.. " %[C:/dev/Real/bin/" .. outputdir .. "/Sandbox]")
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

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"RE_PLATFORM_WINDOW"
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