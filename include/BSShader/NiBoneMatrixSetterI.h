#pragma once

#include "RE/NiSkinInstance.h"
#include "RE/NiSkinPartition.h"
#include "RE/NiTransform.h"

namespace BSShader
{
	class NiBoneMatrixSetterI
	{
	public:
		virtual ~NiBoneMatrixSetterI()
		{
		}

		virtual void SetBoneMatrix(RE::NiSkinInstance* SkinInstance, RE::NiSkinPartition::Partition* Partition, const RE::NiTransform* Transform) = 0;
	};
}
