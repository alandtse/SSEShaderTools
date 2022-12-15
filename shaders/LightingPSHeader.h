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

SamplerState MTLandDiffuseBase : register(s0);
Texture2D<float4> TexMTLandDiffuseBase : register(t0);
SamplerState MTLandDiffuse1 : register(s1);
Texture2D<float4> TexMTLandDiffuse1 : register(t1);
SamplerState MTLandDiffuse2 : register(s2);
Texture2D<float4> TexMTLandDiffuse2 : register(t2);
SamplerState MTLandDiffuse3 : register(s3);
Texture2D<float4> TexMTLandDiffuse3 : register(t3);
SamplerState MTLandDiffuse4 : register(s4);
Texture2D<float4> TexMTLandDiffuse4 : register(t4);
SamplerState MTLandDiffuse5 : register(s5);
Texture2D<float4> TexMTLandDiffuse5 : register(t5);
SamplerState MTLandNormalBase : register(s7);
Texture2D<float4> TexMTLandNormalBase : register(t7);
SamplerState MTLandNormal1 : register(s8);
Texture2D<float4> TexMTLandNormal1 : register(t8);
SamplerState MTLandNormal2 : register(s9);
Texture2D<float4> TexMTLandNormal2 : register(t9);
SamplerState MTLandNormal3 : register(s10);
Texture2D<float4> TexMTLandNormal3 : register(t10);
SamplerState MTLandNormal4 : register(s11);
Texture2D<float4> TexMTLandNormal4 : register(t11);
SamplerState MTLandNormal5 : register(s12);
Texture2D<float4> TexMTLandNormal5 : register(t12);

SamplerState Unknown : register(s14);
Texture2D<float4> TexUnknown : register(t14);