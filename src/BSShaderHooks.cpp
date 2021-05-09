#include <xbyak/xbyak.h>

#include <cinttypes>
#include <filesystem>

#include "skse64_common/Utilities.h"

#include "REL/Relocation.h"
#include "BSShader/BSShader.h"
#include "BSShader/BSShaderInfo.h"

#include "ShaderCompiler.h"
#include "offsets.h"
#include "skse64_common/BranchTrampoline.h"

class BSShaderEX : BSShader::BSShader
{
public:
	void hk_LoadShaders(BSIStream * stream)
	{
		_LoadShaders(this, stream);

		if (strcmp("Lighting", m_LoaderType) == 0)
		{
			_MESSAGE("BSShader::LoadShaders called on %d, %s (%" PRIXPTR "), vs count: %d ps count: %d", m_Type, m_LoaderType, this, m_VertexShaderTable.size(), m_PixelShaderTable.size());

			std::unordered_map<::BSShader::TechniqueID, std::wstring> techniqueFileMap;
			
			const auto shaderDir = GetRuntimeDirectory() + R"(Data\SKSE\plugins\shaders\)";
			
			 size_t foundCount = 0;
			 size_t successCount = 0;
			 size_t failedCount = 0;
			
			 for (const auto & entry : std::filesystem::directory_iterator(shaderDir))
			 {
			 	if (entry.path().extension().string() != ".hlsl")
			 		continue;
			 	
			 	auto filenameStr = entry.path().filename().string();
			 	auto techniqueIdStr = filenameStr.substr(0, filenameStr.find('_'));
			 	const ::BSShader::TechniqueID techniqueId = std::strtoul(techniqueIdStr.c_str(), nullptr, 16);
			 	_MESSAGE("found shader technique id %08X with path %s", techniqueId, entry.path().string().c_str());
			 	foundCount++;
			   	techniqueFileMap.insert(std::make_pair(techniqueId, std::filesystem::absolute(entry.path()).wstring()));
			 }
			
			 for (const auto & entry : m_PixelShaderTable)
			 {
			 	auto tFileIt = techniqueFileMap.find(entry->m_TechniqueID);
			 	if (tFileIt != techniqueFileMap.end())
			 	{
			 		const auto shader = ShaderCompiler::CompileAndRegisterPixelShader(tFileIt->second);
			
			 		if (shader)
			 		{
			 			_DMESSAGE("shader compiled successfully, replacing old shader");
			 			successCount++;
			 			entry->m_Shader = shader;
			 		}
			 		else
			 		{
			 			failedCount++;
			 		}
			 	}
			 }
			
			 _MESSAGE("found shaders: %d successfully replaced: %d failed to replace: %d", foundCount, successCount, failedCount);

			//const auto lightingVSpath = std::filesystem::path(shaderDir + R"(lighting\BSLightingShader.hlsl)");
			//if (std::filesystem::exists(lightingVSpath))
			//{
			//	_MESSAGE("replacing vertex shaders");
			//	size_t replaceCount = 0;
			//	for (const auto & entry : m_VertexShaderTable)
			//	{
			//		_MESSAGE("replacing shader technique %08X", entry->m_TechniqueID);

			//		auto defines = BSShaderInfo::BSLightingShader::Defines::GetArray(entry->m_TechniqueID);
			//		auto newShader = ShaderCompiler::CompileVertexShader(lightingVSpath.wstring(), defines);
			//		if (newShader)
			//		{
			//			newShader->m_TechniqueID = entry->m_TechniqueID;
			//			for (int i = 0; i < ::BSShader::CONSTANT_GROUP_LEVEL_COUNT; i++)
			//			{
			//				newShader->m_ConstantGroups[i].m_Buffer = entry->m_ConstantGroups[i].m_Buffer;
			//				newShader->m_ConstantGroups[i].m_Data = entry->m_ConstantGroups[i].m_Data;
			//			}
			//			for (int i = 0; i < ::BSShader::MAX_VS_CONSTANTS; i++)
			//				newShader->m_ConstantOffsets[i] = entry->m_ConstantOffsets[i];
			//			newShader->m_VertexDescription = entry->m_VertexDescription;
			//			m_VertexShaderTable.insert_or_assign(newShader);
			//			replaceCount++;
			//		}
			//	}
			//	_MESSAGE("replaced %d shaders, map size %d", replaceCount, m_VertexShaderTable.size());
			//}

			//const auto lightingPSpath = std::filesystem::path(shaderDir + R"(lighting\BSLightingShader.hlsl)");
			//if (std::filesystem::exists(lightingVSpath))
			//{
			//	_MESSAGE("replacing pixel shaders");
			//	size_t replaceCount = 0;
			//	size_t skipCount = 0;
			//	size_t failedCount = 0;
			//	for (const auto& entry : m_PixelShaderTable)
			//	{
			//		const uint32_t baseTechniqueID = (entry->m_TechniqueID >> 24) & 0x3F;
			//		
			//		_MESSAGE("replacing shader technique %08X (%d)", entry->m_TechniqueID, baseTechniqueID);

			//		if (baseTechniqueID == 14)
			//		{
			//			_MESSAGE("8, 14, 19 unavailable, skipping");
			//			skipCount++;
			//			continue;
			//		}

			//		auto defines = BSShaderInfo::BSLightingShader::Defines::GetArray(entry->m_TechniqueID);
			//		auto newShader = ShaderCompiler::CompilePixelShader(lightingPSpath.wstring(), defines);
			//		if (newShader)
			//		{
			//			newShader->m_TechniqueID = entry->m_TechniqueID;
			//			for (int i = 0; i < ::BSShader::CONSTANT_GROUP_LEVEL_COUNT; i++)
			//			{
			//				newShader->m_ConstantGroups[i].m_Buffer = entry->m_ConstantGroups[i].m_Buffer;
			//				newShader->m_ConstantGroups[i].m_Data = entry->m_ConstantGroups[i].m_Data;
			//			}
			//			for (int i = 0; i < ::BSShader::MAX_PS_CONSTANTS; i++)
			//				newShader->m_ConstantOffsets[i] = entry->m_ConstantOffsets[i];
			//			m_PixelShaderTable.insert_or_assign(newShader);
			//			replaceCount++;
			//		}
			//		else
			//		{
			//			failedCount++;
			//		}
			//	}
			//	_MESSAGE("replaced %d shaders, skipped %d shaders, failed compile %d shaders, map size %d", replaceCount, skipCount, failedCount, m_PixelShaderTable.size());
			//}
		}
		
	}

	static void InstallHooks()
	{
		_DMESSAGE("Installing BSShader::LoadShaders hook");
		REL::Offset<LoadShaders_t*> loadShadersFuncAddr(Offsets::BSShader::LoadShaders);

		struct BSShader_LoadShaders_Code : Xbyak::CodeGenerator
		{
			BSShader_LoadShaders_Code(void * buf, std::size_t a_funcAddr) : Xbyak::CodeGenerator(4096, buf)
			{
				Xbyak::Label origFuncJzLabel;
				Xbyak::Label origFuncOutLabel;

				test(rdx, rdx);
				jz(origFuncJzLabel);
				jmp(ptr[rip + origFuncOutLabel]);

				L(origFuncJzLabel);
				jmp(ptr[rip]);
				dq(a_funcAddr + 0x2F1);

				L(origFuncOutLabel);
				dq(a_funcAddr + 0x9);

				
			}
		};

		void* patchBuf = g_localTrampoline.StartAlloc();
		BSShader_LoadShaders_Code patch(patchBuf, loadShadersFuncAddr.GetAddress());
		g_localTrampoline.EndAlloc(patch.getCurr());

		_LoadShaders = unrestricted_cast<LoadShaders_t>(patch.getCode());
		g_branchTrampoline.Write6Branch(loadShadersFuncAddr.GetAddress(), unrestricted_cast<uintptr_t>(&hk_LoadShaders));
	}

	using LoadShaders_t = decltype(&BSShaderEX::hk_LoadShaders);

	static inline REL::Function<LoadShaders_t> _LoadShaders;
};

void InstallBSShaderHooks()
{
	BSShaderEX::InstallHooks();
}