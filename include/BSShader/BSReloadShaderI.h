#pragma once

class BSIStream;

namespace BSShader
{
	class BSReloadShaderI
	{
	public:
		virtual void ReloadShaders(BSIStream* Stream) = 0;
	};
}