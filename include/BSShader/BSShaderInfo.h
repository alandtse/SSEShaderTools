#pragma once

#pragma push_macro("TEST_BIT")
#undef TEST_BIT
#define TEST_BIT(index) (Technique & (1u << (index)))

namespace BSShaderInfo::BSLightingShader::Defines
{
			static auto GetArray(uint32_t Technique)
			{
				std::vector<std::pair<const char*, const char*>> defines;
				uint32_t subType = (Technique >> 24) & 0x3F;

				if (TEST_BIT(0)) defines.emplace_back("VC", "");
				if (TEST_BIT(1)) defines.emplace_back("SKINNED", "");
				if (TEST_BIT(2)) defines.emplace_back("MODELSPACENORMALS", "");
				if (TEST_BIT(9)) defines.emplace_back("SPECULAR", "");
				if (TEST_BIT(10)) defines.emplace_back("SOFT_LIGHTING", "");
				if (TEST_BIT(13)) defines.emplace_back("SHADOW_DIR", "");
				if (TEST_BIT(14)) defines.emplace_back("DEFSHADOW", "");
				if (TEST_BIT(11)) defines.emplace_back("RIM_LIGHTING", "");
				if (TEST_BIT(12)) defines.emplace_back("BACK_LIGHTING", "");
				if (TEST_BIT(15) && subType != 6) defines.emplace_back("PROJECTED_UV", "");
				if (TEST_BIT(16)) defines.emplace_back("ANISO_LIGHTING", "");
				if (TEST_BIT(17)) defines.emplace_back("AMBIENT_SPECULAR", "");
				if (TEST_BIT(18)) defines.emplace_back("WORLD_MAP", "");
				if (TEST_BIT(20)) defines.emplace_back("DO_ALPHA_TEST", "");
				if (TEST_BIT(21)) defines.emplace_back("SNOW", "");
				if (TEST_BIT(19)) defines.emplace_back("BASE_OBJECT_IS_SNOW", "");
				if (TEST_BIT(22)) defines.emplace_back("CHARACTER_LIGHT", "");
				if (TEST_BIT(15) && subType == 6) defines.emplace_back("DEPTH_WRITE_DECALS", "");
				if (TEST_BIT(23)) defines.emplace_back("ADDITIONAL_ALPHA_MASK", "");

				switch (subType)
				{
				case 0:break;
				case 1:defines.emplace_back("ENVMAP", ""); break;
				case 2:defines.emplace_back("GLOWMAP", ""); break;
				case 3:defines.emplace_back("PARALLAX", ""); break;
				case 4:defines.emplace_back("FACEGEN", ""); break;
				case 5:defines.emplace_back("FACEGEN_RGB_TINT", ""); break;
				case 6:defines.emplace_back("HAIR", ""); break;
				case 7:defines.emplace_back("PARALLAX_OCC", ""); break;
				case 8:defines.emplace_back("MULTI_TEXTURE", ""); defines.emplace_back("LANDSCAPE", ""); break;
				case 9:defines.emplace_back("LODLANDSCAPE", ""); break;
				case 10:/* I have no idea what this does */break;
				case 11:defines.emplace_back("MULTI_LAYER_PARALLAX", ""); defines.emplace_back("ENVMAP", ""); break;
				case 12:defines.emplace_back("TREE_ANIM", ""); break;
				case 13:defines.emplace_back("LODOBJECTS", ""); break;
				case 14:defines.emplace_back("MULTI_INDEX", "SPARKLE"); defines.emplace_back("SPARKLE", ""); break;
				case 15:defines.emplace_back("LODOBJECTSHD", ""); break;
				case 16:defines.emplace_back("EYE", ""); break;
				case 17:defines.emplace_back("CLOUD", ""); defines.emplace_back("INSTANCED", ""); break;
				case 18:defines.emplace_back("LODLANDSCAPE", ""); defines.emplace_back("LODLANDNOISE", ""); break;
				case 19:defines.emplace_back("MULTI_TEXTURE", ""); defines.emplace_back("LANDSCAPE", "LOD_LAND_BLEND"); break;
				default:__debugbreak(); break;
				}

				return defines;
			}
}

#undef TEST_BIT
#pragma pop_macro("TEST_BIT")