#pragma once
#include "BSShader/BSShaderTypes.h"

namespace ShaderCompiler
{
	BSShader::VertexShader* CompileVertexShader(const std::wstring a_filePath, const std::vector<std::pair<const char*, const char*>>& Defines);
	BSShader::PixelShader* CompilePixelShader(const std::wstring a_filePath, const std::vector<std::pair<const char*, const char*>>& Defines);
	ID3D11PixelShader* CompileAndRegisterPixelShader(const std::wstring a_filePath);
}
