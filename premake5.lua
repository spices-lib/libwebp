solution.DefineCStaticLibrary("libwebp", function()

	files
	{
		"src/dec/**.h",
		"src/dec/**.c",
		"src/dsp/**.h",
		"src/dsp/**.c",
		"src/utils/**.c",
		"src/utils/**.h",
		"src/webp/**.h",
	}

	includedirs
	{
		"."
	}

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++20"

	filter { "system:windows", "toolset:clang", "files:src/dsp/**_sse41.c" }
		buildoptions { "-msse4.1" }          -- Implies SSE2/SSE3/SSSE3.

	filter { "system:windows", "toolset:clang", "files:src/dsp/**_avx2.c" }
		buildoptions { "-mavx2" }

	filter { "system:windows", "toolset:clang", "files:src/dsp/**_sse2.c" }
		buildoptions { "-msse2" }            -- Baseline on x64, required on Win32.

	filter { "system:linux", "architecture:x86_64" }
		defines
		{
			"WEBP_HAVE_SSE41",               -- Register the *InitSSE41() entry points.
			"WEBP_HAVE_AVX2",                -- Register the lossless AVX2 entry points.
		}

	filter { "system:linux", "architecture:x86_64", "files:src/dsp/**_sse41.c" }
		buildoptions { "-msse4.1" }

	filter { "system:linux", "architecture:x86_64", "files:src/dsp/**_avx2.c" }
		buildoptions { "-mavx2" }

	filter { "system:linux", "architecture:x86_64", "files:src/dsp/**_sse2.c" }
		buildoptions { "-msse2" }            -- Baseline on x86_64, required on i386.

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++20"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++20"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

end)
