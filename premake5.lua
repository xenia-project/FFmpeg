group("third_party")

--
-- Call this function in subproject scope to set the needed include
-- dirs and defines.
--
function ffmpeg_common()
  defines({
    "HAVE_AV_CONFIG_H",
    "_USE_MATH_DEFINES", -- For M_PI/etc
  })

  local ffmpeg_root = ".."
  includedirs({ 
    ffmpeg_root,
  })
  filter({"platforms:Windows-*", "configurations:Debug or configurations:Checked"})
    optimize("Size") -- dead code elimination is mandatory
    removebuildoptions({
      "/RTCsu",      -- '/O1' and '/RTCs' command-line options are incompatible
    })
  filter({"platforms:Windows-*", "configurations:Release"})
    removeflags({
      "LinkTimeOptimization", -- disable whole program optimization, breaks dead code elimination
    })
  filter("platforms:Windows-*")
    includedirs({
      ffmpeg_root .. "/compat/atomics/win32",
    })
    links({
      "bcrypt",
    })
  filter("platforms:Linux")
    includedirs({
      ffmpeg_root .. "/compat/atomics/gcc",
    })
  filter({})
end

include("libavcodec/premake5.lua")
include("libavutil/premake5.lua")
