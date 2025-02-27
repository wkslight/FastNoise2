project("FastNoise2")
    location(path.join(g_wkslight.workspacedir, g_wkslight.placeholders[2], "%{prj.name}"))
    targetdir(g_wkslight.targetdir)
    objdir(path.join(g_wkslight.baseobjdir, g_wkslight.placeholders[2], "%{prj.name}"))
    kind("StaticLib")
    language("C++")
    cppdialect("C++17")
    files({
        "src/FastNoise/*.cpp",
        "src/FastSIMD/FastSIMD.cpp",
        "src/FastSIMD/FastSIMD_Level_Scalar.cpp",
    })
    includedirs({
        g_wkslight.workspace.libraries.projects.FastNoise2.includedirs,
    })
    defines({
        g_wkslight.workspace.libraries.projects.FastNoise2.defines,
    })
    filter({ "architecture:armv7 or aarch64 or ARM64" })
        files({
            "src/FastSIMD/FastSIMD_Level_NEON.cpp",
        })
    filter({ "architecture:x86*" })
        files({
            "src/FastSIMD/FastSIMD_Level_AVX*.cpp",
            "src/FastSIMD/FastSIMD_Level_SSE*.cpp",
            "src/FastSIMD/FastSIMD_Level_SSSE3.cpp",
        })
    filter({ "toolset:msc*" })
        buildoptions({ "/GL- /GS- /fp:fast /wd4251 /wd4307" })
    filter({ "toolset:not msc*" })
        buildoptions({ "-ffast-math -fno-stack-protector" })
    filter({ "architecture:x86", "files:src/FastSIMD/FastSIMD_Level_Scalar.cpp" })
        vectorextensions("SSE")
    filter({ "architecture:x86", "files:src/FastSIMD/FastSIMD_Level_SSE*.cpp", "toolset:msc*" })
        buildoptions({ "/arch:SSE2" })
    filter({ "architecture:x86", "files:src/FastSIMD/FastSIMD_Level_SSE2.cpp", "toolset:not msc*" })
        buildoptions({ "-msse2" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_SSE3.cpp", "toolset:not msc*" })
        buildoptions({ "-msse3" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_SSSE3.cpp", "toolset:not msc*" })
        buildoptions({ "-mssse3" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_SSE41.cpp", "toolset:not msc*" })
        buildoptions({ "-msse4.1" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_SSE42.cpp", "toolset:not msc*" })
        buildoptions({ "-msse4.2" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_AVX2.cpp" })
        vectorextensions("AVX2")
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_AVX*.cpp", "toolset:not msc*" })
        buildoptions({ "-mfma" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_AVX512.cpp", "toolset:msc*" })
        buildoptions({ "/arch:AVX512" })
    filter({ "architecture:x86*", "files:src/FastSIMD/FastSIMD_Level_AVX512.cpp", "toolset:not msc*" })
        buildoptions({ "-mavx512f -mavx512dq" })
    filter({ "architecture:armv7", "files:src/FastSIMD/FastSIMD_Level_NEON.cpp" })
        vectorextensions("NEON")