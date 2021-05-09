#pragma once

// This code is taken from Nukem's work here - https://github.com/Nukem9/SkyrimSETest/blob/master/skyrim64_test/src/patches/TES/BSGraphicsTypes.h

#include "d3d11.h"

namespace BSShader
{
	constexpr uint32_t MAX_VS_CONSTANTS = 20;
	constexpr uint32_t MAX_PS_CONSTANTS = 64;
	
	using TechniqueID = uint32_t;
	
	//
	// General resources
	//

	struct Buffer
	{
		ID3D11Buffer* m_Buffer;	// Selected from pool in Load*ShaderFromFile()
		void* m_Data;			// m_Data = DeviceContext->Map(m_Buffer)

		// Based on shader load flags, these **can be null**. At least one of the
		// pointers is guaranteed to be non-null.
	};

	//
	// Constant group types used for shader parameters
	//
	const uint8_t INVALID_CONSTANT_BUFFER_OFFSET = 0xFF;

	enum ConstantGroupLevel
	{
		CONSTANT_GROUP_LEVEL_TECHNIQUE = 0x0,		// Varies between PS/VS shaders
		CONSTANT_GROUP_LEVEL_MATERIAL = 0x1,		// Varies between PS/VS shaders
		CONSTANT_GROUP_LEVEL_GEOMETRY = 0x2,		// Varies between PS/VS shaders
		CONSTANT_GROUP_LEVEL_COUNT = 0x3,

		// Slot 7 is used for grass but unknown
		CONSTANT_GROUP_LEVEL_INSTANCE = 0x8,		// Instanced geometry such as grass and trees
		CONSTANT_GROUP_LEVEL_PREVIOUS_BONES = 0x9,
		CONSTANT_GROUP_LEVEL_BONES = 0xA,
		CONSTANT_GROUP_LEVEL_ALPHA_TEST_REF = 0xB,	// PS/VS. Used as a single float value for alpha testing (16 bytes allocated)
		CONSTANT_GROUP_LEVEL_PERFRAME = 0xC,		// PS/VS. Per-frame constants. Contains view projections and some other variables.
	};

	//
	// Shaders
	//
#pragma warning(push)
#pragma warning(disable:4200) // MSVC
#pragma warning(disable:94)   // Intel C++ Compiler
	struct VertexShader
	{
		uint32_t m_TechniqueID;						// Bit flags
		ID3D11VertexShader* m_Shader;				// DirectX handle
		uint32_t m_ShaderLength;					// Raw bytecode length

		union
		{
			struct
			{
				Buffer m_PerTechnique;				// CONSTANT_GROUP_LEVEL_TECHNIQUE
				Buffer m_PerMaterial;				// CONSTANT_GROUP_LEVEL_MATERIAL
				Buffer m_PerGeometry;				// CONSTANT_GROUP_LEVEL_GEOMETRY
			};

			Buffer m_ConstantGroups[CONSTANT_GROUP_LEVEL_COUNT];
		};

		uint64_t m_VertexDescription;				// ID3D11Device::CreateInputLayout lookup (for VSMain)
		uint8_t m_ConstantOffsets[MAX_VS_CONSTANTS];// Actual offset is multiplied by 4
		uint8_t __padding[4];
		uint8_t m_RawBytecode[0];					// Raw bytecode
	};

	STATIC_ASSERT(sizeof(VertexShader) == 0x68);
	STATIC_ASSERT(offsetof(VertexShader, m_PerTechnique) == 0x18);
	STATIC_ASSERT(offsetof(VertexShader, m_PerMaterial) == 0x28);
	STATIC_ASSERT(offsetof(VertexShader, m_RawBytecode) == 0x68);

	struct PixelShader
	{
		uint32_t m_TechniqueID;						// Bit flags
		ID3D11PixelShader* m_Shader;				// DirectX handle

		union
		{
			struct
			{
				Buffer m_PerTechnique;				// CONSTANT_GROUP_LEVEL_TECHNIQUE
				Buffer m_PerMaterial;				// CONSTANT_GROUP_LEVEL_MATERIAL
				Buffer m_PerGeometry;				// CONSTANT_GROUP_LEVEL_GEOMETRY
			};

			Buffer m_ConstantGroups[CONSTANT_GROUP_LEVEL_COUNT];
		};

		uint8_t m_ConstantOffsets[MAX_PS_CONSTANTS];// Actual offset is multiplied by 4
	};

	STATIC_ASSERT(sizeof(PixelShader) == 0x80);
	STATIC_ASSERT(offsetof(PixelShader, m_PerMaterial) == 0x20);
	STATIC_ASSERT(offsetof(PixelShader, m_ConstantOffsets) == 0x40);
#pragma warning(pop)

	template <class Key>
	struct TechniqueIDHasher
	{
	public:
		UInt32 operator()(const Key& a_key) const
		{
			return a_key->m_TechniqueID;
		}
	};


	template <class T>
	struct TechniqueIDCompare
	{
	public:
		bool operator()(const T& a_lhs, const T& a_rhs) const
		{
			return a_lhs->m_TechniqueID == a_rhs->m_TechniqueID;
		}
	};


	template <class Key> using TechniqueIDMap = RE::BSTSet<Key, TechniqueIDHasher<Key>, TechniqueIDCompare<Key>>;
}