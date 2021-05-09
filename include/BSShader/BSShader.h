#pragma once

#include "RE/BSShaderMaterial.h"
#include "RE/NiRefObject.h"

#include "BSShader/BSReloadShaderI.h"
#include "BSShader/NiBoneMatrixSetterI.h"

#include "BSShader/BSShaderTypes.h"

class BSRenderPass;

namespace BSShader
{
	class BSShader : public RE::NiRefObject, public NiBoneMatrixSetterI, public BSReloadShaderI
	{
	public:
		virtual ~BSShader();																	// 00

		// add
		virtual bool SetupTechnique(TechniqueID Technique) = 0;									// 02
		virtual void RestoreTechnique(TechniqueID Technique) = 0;								// 03
		virtual void SetupMaterial(RE::BSShaderMaterial const* Material);						// 04
		virtual void RestoreMaterial(RE::BSShaderMaterial const* Material);						// 05
		virtual void SetupGeometry(BSRenderPass* Pass, uint32_t Flags) = 0;						// 06
		virtual void RestoreGeometry(BSRenderPass* Pass, uint32_t RenderFlags) = 0;				// 07
		virtual void GetTechniqueName(TechniqueID Technique, char* Buffer, uint32_t BufferSize);// 08
		virtual void ReloadShaders(bool Unknown);												// 09

		// BSReloadShaderI
		void ReloadShaders(BSIStream* Stream) override; // 00

		// NiBoneMatrixSetterI
		void SetBoneMatrix(RE::NiSkinInstance* SkinInstance, RE::NiSkinPartition::Partition* Partition, const RE::NiTransform* Transform) override; // 01

		// members
		uint32_t m_Type;
		TechniqueIDMap<VertexShader*> m_VertexShaderTable;
		TechniqueIDMap<PixelShader*> m_PixelShaderTable;
		const char* m_LoaderType;
	};

	STATIC_ASSERT(sizeof(BSShader) == 0x90);
	STATIC_ASSERT(offsetof(BSShader, m_Type) == 0x20);
	STATIC_ASSERT(offsetof(BSShader, m_VertexShaderTable) == 0x28);
	STATIC_ASSERT(offsetof(BSShader, m_PixelShaderTable) == 0x58);
	STATIC_ASSERT(offsetof(BSShader, m_LoaderType) == 0x88);
}