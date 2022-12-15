cbuffer PerTechnique : register(b0)
{
	float4 cb0[3];
}

cbuffer PerMaterial : register(b1)
{
	float4 cb1[15];
}

cbuffer PerGeometry : register(b2)
{
	float4 cb2[30];
}

cbuffer PerFrame : register(b12)
{
	float4 cb12[45];
}

SamplerState DiffuseSampler : register(s0);
Texture2D<float4> TexDiffuseSampler : register(t0);
SamplerState NormalSampler : register(s1);
Texture2D<float4> TexNormalSampler : register(t1);
SamplerState SpecularSampler : register(s2);
Texture2D<float4> TexSpecularSampler : register(t2);
SamplerState HeightSampler : register(s3);
Texture2D<float4> TexHeightSampler : register(t3);
SamplerState EnvSampler : register(s4);
Texture2D<float4> TexEnvSampler : register(t4);
SamplerState EnvMaskSampler : register(s5);
Texture2D<float4> TexEnvMaskSampler : register(t5);
SamplerState GlowSampler : register(s6);
Texture2D<float4> TexGlowSampler : register(t6);
SamplerState LandscapeNormalSampler : register(s7);
Texture2D<float4> TexLandscapeNormalSampler : register(t7);
SamplerState MultiLayerParallaxSampler : register(s8);
Texture2D<float4> TexMultiLayerParallaxSampler : register(t8);
SamplerState BackLightMaskSampler : register(s9);
Texture2D<float4> TexBackLightMaskSampler : register(t9);
SamplerState ProjectedNormalDetailSampler : register(s10);
Texture2D<float4> TexProjectedNormalDetailSampler : register(t10);
SamplerState ProjectedNoiseSampler : register(s11);
Texture2D<float4> TexProjectedNoiseSampler : register(t11);
SamplerState SubSurfaceSampler : register(s12);
Texture2D<float4> TexSubSurfaceSampler : register(t12);
SamplerState LODBlendSampler : register(s13);
Texture2D<float4> TexLODBlendSampler : register(t13);
SamplerState ShadowMaskSampler : register(s14);
Texture2D<float4> TexShadowMaskSampler : register(t14);
SamplerState LODNoiseSampler : register(s15);
Texture2D<float4> TexLODNoiseSampler : register(t15);