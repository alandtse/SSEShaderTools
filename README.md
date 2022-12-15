# ShaderTools

Plugin for SSE Parallax Shader Fix.
  * [SSE/AE](https://www.nexusmods.com/skyrimspecialedition/mods/70760)
  * [VR](https://www.nexusmods.com/skyrimspecialedition/mods/62090)

## Requirements
* [CMake](https://cmake.org/)
	* Add this to your `PATH`
* [PowerShell](https://github.com/PowerShell/PowerShell/releases/latest)
* [Vcpkg](https://github.com/microsoft/vcpkg)
	* Add the environment variable `VCPKG_ROOT` with the value as the path to the folder containing vcpkg
* [Visual Studio Community 2019](https://visualstudio.microsoft.com/)
	* Desktop development with C++

## Register Visual Studio as a Generator
* Open `x64 Native Tools Command Prompt`
* Run `cmake`
* Close the cmd window

## Building
```
git clone https://github.com/aers/SSEShaderTools
cd SSEShaderTools
git submodule update --init --recursive
cmake -B build -S .
```

## Credits
* Originally written by [aers](https://github.com/aers/SSEShaderTools). [Nexus](https://www.nexusmods.com/skyrimspecialedition/mods/31963)
* CommonlibNG port by [doodlum](https://github.com/doodlum).
* VR offsets by [alandtse](https://github.com/alandtse)
* VR shader port by [shadowking97](https://www.nexusmods.com/skyrimspecialedition/users/2336911)
* VR TAA/DLAA shader fix by [PureDark](https://github.com/PureDark)

