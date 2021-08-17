#pragma once

namespace Offsets
{
	namespace BSShader
	{
		// E8 ? ? ? ? 43 8B 1C 26 89 9D ? ? ? ? 
		//constexpr uintptr_t LoadShaders = 0x0131F810;
		constexpr uintptr_t LoadShaders = 0x013656b0;

		// 48 8B 0D ? ? ? ? 48 8B 01 4C 8B C7 48 8D 54 24 ? FF 90 ? ? ? ? 48 83 C7 08 
		//constexpr uintptr_t g_ID3D11Device = 0x03025F08;
		constexpr uintptr_t g_ID3D11Device = 0x0317e798;
	}
}