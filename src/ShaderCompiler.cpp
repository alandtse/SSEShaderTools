#include <functional>

#include "d3dcompiler.h"

#include "REL/Relocation.h"

#include "BSShader/BSShaderTypes.h"
#include "offsets.h"


namespace ShaderCompiler
{
	REL::Offset<ID3D11Device**> g_ID3D11Device_ptr(Offsets::BSShader::g_ID3D11Device);

	BSShader::VertexShader* CompileVertexShader(const std::wstring a_filePath, const std::vector<std::pair<const char*, const char*>>& Defines)
	{
		D3D_SHADER_MACRO macros[20+3+1];
		memset(macros, 0, sizeof macros);
		
		for (size_t i = 0; i < Defines.size(); i++)
		{
			macros[i].Name = Defines[i].first;
			macros[i].Definition = Defines[i].second;
		}

		macros[Defines.size() + 0].Name = "WINPC";
		macros[Defines.size() + 0].Definition = "";
		macros[Defines.size() + 1].Name = "DX11";
		macros[Defines.size() + 1].Definition = "";
		macros[Defines.size() + 2].Name = "VERTEXSHADER";
		macros[Defines.size() + 2].Definition = "";


		UINT compilerFlags = D3DCOMPILE_DEBUG | D3DCOMPILE_ENABLE_STRICTNESS | D3DCOMPILE_OPTIMIZATION_LEVEL3;
		ID3DBlob* shaderBlob = nullptr;
		ID3DBlob* shaderErrors = nullptr;

		if (FAILED(D3DCompileFromFile(a_filePath.c_str(), macros, D3D_COMPILE_STANDARD_FILE_INCLUDE, "VSMain", "vs_5_0", compilerFlags, 0, &shaderBlob, &shaderErrors)))
		{
			_ERROR("Vertex shader compilation failed:\n%s", shaderErrors ? (const char*)shaderErrors->GetBufferPointer() : "Unknown error");

			if (shaderBlob)
				shaderBlob->Release();

			if (shaderErrors)
				shaderErrors->Release();

			return nullptr;
		}

		if (shaderErrors)
			shaderErrors->Release();

		_DMESSAGE("shader compilation succeeded");

		_DMESSAGE("registering shader");

		ID3D11VertexShader* regShader;

		if (FAILED((*g_ID3D11Device_ptr)->CreateVertexShader(shaderBlob->GetBufferPointer(), shaderBlob->GetBufferSize(), nullptr, &regShader)))
		{
			_ERROR("vertex shader registration failed");

			if (shaderBlob)
				shaderBlob->Release();

			return nullptr;
		}

		_DMESSAGE("shader registration succeeded");

		void* rawPtr = malloc(sizeof(BSShader::VertexShader) + shaderBlob->GetBufferSize());
		BSShader::VertexShader* vs = new (rawPtr) BSShader::VertexShader;

		vs->m_Shader = regShader;
		
		memcpy(vs->m_RawBytecode, shaderBlob->GetBufferPointer(), shaderBlob->GetBufferSize());
		vs->m_ShaderLength = (uint32_t)shaderBlob->GetBufferSize();
		
		return vs;
	}

	BSShader::PixelShader* CompilePixelShader(const std::wstring a_filePath, const std::vector<std::pair<const char*, const char*>>& Defines)
	{
		D3D_SHADER_MACRO macros[20 + 4 + 1];
		memset(macros, 0, sizeof macros);

		for (size_t i = 0; i < Defines.size(); i++)
		{
			macros[i].Name = Defines[i].first;
			macros[i].Definition = Defines[i].second;
		}

		macros[Defines.size() + 0].Name = "WINPC";
		macros[Defines.size() + 0].Definition = "";
		macros[Defines.size() + 1].Name = "DX11";
		macros[Defines.size() + 1].Definition = "";
		macros[Defines.size() + 2].Name = "FIX_VANILLA_BUGS";
		macros[Defines.size() + 2].Definition = "";
		macros[Defines.size() + 3].Name = "PIXELSHADER";
		macros[Defines.size() + 3].Definition = "";

		UINT compilerFlags = D3DCOMPILE_DEBUG | D3DCOMPILE_ENABLE_STRICTNESS | D3DCOMPILE_OPTIMIZATION_LEVEL3;
		ID3DBlob* shaderBlob = nullptr;
		ID3DBlob* shaderErrors = nullptr;

		if (FAILED(D3DCompileFromFile(a_filePath.c_str(), macros, D3D_COMPILE_STANDARD_FILE_INCLUDE, "PSMain", "ps_5_0", compilerFlags, 0, &shaderBlob, &shaderErrors)))
		{
			_ERROR("pixel shader compilation failed:\n%s", shaderErrors ? (const char*)shaderErrors->GetBufferPointer() : "Unknown error");

			if (shaderBlob)
				shaderBlob->Release();

			if (shaderErrors)
				shaderErrors->Release();

			return nullptr;
		}

		if (shaderErrors)
			shaderErrors->Release();

		_DMESSAGE("shader compilation succeeded");

		_DMESSAGE("registering shader");

		ID3D11PixelShader* regShader;

		if (FAILED((*g_ID3D11Device_ptr)->CreatePixelShader(shaderBlob->GetBufferPointer(), shaderBlob->GetBufferSize(), nullptr, &regShader)))
		{
			_ERROR("pixel shader registration failed");

			if (shaderBlob)
				shaderBlob->Release();

			return nullptr;
		}

		_DMESSAGE("shader registration succeeded");

		void* rawPtr = malloc(sizeof(BSShader::PixelShader));
		BSShader::PixelShader* ps = new (rawPtr) BSShader::PixelShader;

		ps->m_Shader = regShader;

		return ps;
	}
	
	ID3D11PixelShader* CompileAndRegisterPixelShader(const std::wstring a_filePath)
	{
		D3D_SHADER_MACRO macros[3];
		memset(macros, 0, sizeof macros);

		macros[0].Name = "WINPC";
		macros[0].Definition = "";
		macros[1].Name = "DX11";
		macros[1].Definition = "";

		UINT compilerFlags = D3DCOMPILE_DEBUG | D3DCOMPILE_ENABLE_STRICTNESS | D3DCOMPILE_OPTIMIZATION_LEVEL3;
		ID3DBlob* shaderBlob = nullptr;
		ID3DBlob* shaderErrors = nullptr;

		if (FAILED(D3DCompileFromFile(a_filePath.c_str(), macros, D3D_COMPILE_STANDARD_FILE_INCLUDE, "main", "ps_5_0", compilerFlags, 0, &shaderBlob, &shaderErrors)))
		{
			_ERROR( "Pixel shader compilation failed:\n%s", shaderErrors ? (const char*)shaderErrors->GetBufferPointer() : "Unknown error");

			if (shaderBlob)
				shaderBlob->Release();

			if (shaderErrors)
				shaderErrors->Release();

			return nullptr;
		}

		if (shaderErrors)
			shaderErrors->Release();

		_DMESSAGE("shader compilation succeeded");
	
		_DMESSAGE("registering shader");

		ID3D11PixelShader* regShader;

		if (FAILED((*g_ID3D11Device_ptr)->CreatePixelShader(shaderBlob->GetBufferPointer(), shaderBlob->GetBufferSize(), nullptr, &regShader)))
		{
			_ERROR("pixel shader registration failed");

			if (shaderBlob)
				shaderBlob->Release();

			return nullptr;
		}

		_DMESSAGE("shader registration succeeded");
		
		return regShader;
	}
}
