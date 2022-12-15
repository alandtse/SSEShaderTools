// Lighting
// TechniqueID: 0x8026001
//
// Technique: 0Sh0_Vc_Shd_DfSh_Aspc_MTLand

#include "Common.h"
#include "LightingPSHeader.h"
#include "ParallaxEffect.h"

void main(
  float4 v0 : SV_POSITION0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD4,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD2,
  float4 v5 : TEXCOORD3,
  float4 v6 : TEXCOORD5,
  float4 v7 : TEXCOORD6,
  float4 v8 : TEXCOORD7,
  float4 v9 : TEXCOORD8,
  float4 v10 : TEXCOORD9,
  float3 v11 : TEXCOORD10,
  float4 v12 : POSITION1,
  float4 v13 : POSITION2,
  float4 v14 : COLOR0,
  float4 v15 : COLOR1,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2)
{
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v6.xyz * r0.xxx;
  float3 viewDir = r0.xyz;
  float height = TexMTLandDiffuseBase.Sample(MTLandDiffuseBase, v1.xy).w;
  float2 parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r1.xyz = TexMTLandDiffuseBase.Sample(MTLandDiffuseBase, parallaxCoords).xyz;
  r2.xyzw = TexMTLandNormalBase.Sample(MTLandNormalBase, parallaxCoords).xyzw;
  r2.xyz = r2.xyz * float3(2,2,2) + float3(-1,-1,-1);
  height = TexMTLandDiffuse1.Sample(MTLandDiffuse1, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r3.xyz = TexMTLandDiffuse1.Sample(MTLandDiffuse1, parallaxCoords).xyz;
  r3.xyz = v7.yyy * r3.xyz;
  r1.xyz = v7.xxx * r1.xyz + r3.xyz;
  r3.xyzw = TexMTLandNormal1.Sample(MTLandNormal1, parallaxCoords).xyzw;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.xyz = v7.yyy * r3.xyz;
  r2.xyz = v7.xxx * r2.xyz + r3.xyz;
  r0.w = v7.y * r3.w;
  r0.w = v7.x * r2.w + r0.w;
  height = TexMTLandDiffuse2.Sample(MTLandDiffuse2, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r3.xyz = TexMTLandDiffuse2.Sample(MTLandDiffuse2, parallaxCoords).xyz;
  r1.xyz = v7.zzz * r3.xyz + r1.xyz;
  r3.xyzw = TexMTLandNormal2.Sample(MTLandNormal2, parallaxCoords).xyzw;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xyz = v7.zzz * r3.xyz + r2.xyz;
  r0.w = v7.z * r3.w + r0.w;
  height = TexMTLandDiffuse3.Sample(MTLandDiffuse3, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r3.xyz = TexMTLandDiffuse3.Sample(MTLandDiffuse3, parallaxCoords).xyz;
  r1.xyz = v7.www * r3.xyz + r1.xyz;
  r3.xyzw = TexMTLandNormal3.Sample(MTLandNormal3, parallaxCoords).xyzw;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xyz = v7.www * r3.xyz + r2.xyz;
  r0.w = v7.w * r3.w + r0.w;
  height = TexMTLandDiffuse4.Sample(MTLandDiffuse4, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r3.xyz = TexMTLandDiffuse4.Sample(MTLandDiffuse4, parallaxCoords).xyz;
  r1.xyz = v8.xxx * r3.xyz + r1.xyz;
  r3.xyzw = TexMTLandNormal4.Sample(MTLandNormal4, parallaxCoords).xyzw;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xyz = v8.xxx * r3.xyz + r2.xyz;
  r0.w = v8.x * r3.w + r0.w;
  height = TexMTLandDiffuse5.Sample(MTLandDiffuse5, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r3.xyz = TexMTLandDiffuse5.Sample(MTLandDiffuse5, parallaxCoords).xyz;
  r1.xyz = v8.yyy * r3.xyz + r1.xyz;
  r3.xyzw = TexMTLandNormal5.Sample(MTLandNormal5, parallaxCoords).xyzw;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xyz = v8.yyy * r3.xyz + r2.xyz;
  r0.w = v8.y * r3.w + r0.w;
  r1.w = min(7, cb2[29].x);
  r3.x = dot(v3.xyz, r2.xyz);
  r3.y = dot(v4.xyz, r2.xyz);
  r3.z = dot(v5.xyz, r2.xyz);
  r2.w = dot(r3.xyz, r3.xyz);
  r2.w = rsqrt(r2.w);
  r3.xyz = r3.xyz * r2.www;
  r4.xy = cb12[44].xy * v0.xy;
  r4.xy = r4.xy * cb0[2].xy + cb0[2].zw;
  r4.xy = cb12[43].xy * r4.xy;
  r4.xy = max(float2(0,0), r4.xy);
  r5.x = min(cb12[44].z, r4.x);
  r5.y = min(cb12[43].y, r4.y);
  r4.xyzw = TexUnknown.Sample(Unknown, r5.xy).xyzw;
  r5.xyz = cb2[1].xyz * r4.xxx;
  r2.w = saturate(dot(r3.xyz, cb2[0].xyz));
  r5.xyz = r5.xyz * r2.www;
  r2.w = cmp(0 < r1.w);
  if (r2.w != 0) {
    r2.w = min(4, cb2[29].y);
    r6.xyz = r5.xyz;
    r5.w = 0;
    while (true) {
      r6.w = cmp(r5.w >= r1.w);
      if (r6.w != 0) break;
      r6.w = cmp(r5.w < r2.w);
      if (r6.w != 0) {
        r6.w = (uint)r5.w;
        r6.w = dot(cb2[2].xyzw, icb[r6.w+0].xyzw);
        r6.w = (uint)r6.w;
        r6.w = dot(r4.xyzw, icb[r6.w+0].xyzw);
      } else {
        r6.w = 1;
      }
      r7.x = (int)r5.w;
      r7.yzw = cb2[r7.x+15].xyz + -v2.xyz;
      r8.x = dot(r7.yzw, r7.yzw);
      r8.y = sqrt(r8.x);
      r8.y = saturate(r8.y / cb2[r7.x+15].w);
      r8.y = -r8.y * r8.y + 1;
      r9.xyz = cb2[r7.x+22].xyz * r6.www;
      r6.w = rsqrt(r8.x);
      r7.xyz = r7.yzw * r6.www;
      r6.w = saturate(dot(r3.xyz, r7.xyz));
      r7.xyz = r9.xyz * r6.www;
      r6.xyz = r7.xyz * r8.yyy + r6.xyz;
      r5.w = 1 + r5.w;
    }
    r5.xyz = r6.xyz;
  }
  r3.w = 1;
  r4.x = dot(cb2[11].xyzw, r3.xyzw);
  r4.y = dot(cb2[12].xyzw, r3.xyzw);
  r4.z = dot(cb2[13].xyzw, r3.xyzw);
  r4.xyz = cb2[4].yzw + r4.xyz;
  r4.xyz = r4.xyz + r5.xyz;
  r4.xyz = cb1[8].yzw * cb1[8].xxx + r4.xyz;
  r1.xyz = r4.xyz * r1.xyz;
  r4.xyz = v14.xyz * r1.xyz;
  r5.x = dot(cb12[12].xyzw, v12.xyzw);
  r5.y = dot(cb12[13].xyzw, v12.xyzw);
  r1.w = dot(cb12[15].xyzw, v12.xyzw);
  r5.xy = r5.xy / r1.ww;
  r6.x = dot(cb12[16].xyzw, v13.xyzw);
  r6.y = dot(cb12[17].xyzw, v13.xyzw);
  r1.w = dot(cb12[19].xyzw, v13.xyzw);
  r5.zw = r6.xy / r1.ww;
  r5.xy = r5.xy + -r5.zw;
  r5.xy = float2(-0.5,0.5) * r5.xy;
  r0.x = saturate(dot(r3.xyz, r0.xyz));
  r0.x = 1 + -r0.x;
  r0.x = log2(r0.x);
  r0.x = cb2[14].w * r0.x;
  r0.x = exp2(r0.x);
  r3.w = 0.150000;
  r6.x = saturate(dot(cb2[11].xyzw, r3.xyzw));
  r6.y = saturate(dot(cb2[12].xyzw, r3.xyzw));
  r6.z = saturate(dot(cb2[13].xyzw, r3.xyzw));
  r3.xyz = cb2[14].xyz * r6.xyz;
  r1.xyz = -r1.xyz * v14.xyz + v15.xyz;
  r1.xyz = v15.www * r1.xyz + r4.xyz;
  r1.xyz = -r1.xyz * cb0[0].www + r4.xyz;
  r1.xyz = r1.xyz * cb12[42].yyy + cb0[1].xxx;
  r1.xyz = min(r4.xyz, r1.xyz);
  r0.xyz = r3.xyz * r0.xxx + r1.xyz;
  r1.xyz = v15.xyz + -r0.xyz;
  r1.xyz = v15.www * r1.xyz + r0.xyz;
  r1.xyz = -r1.xyz * cb0[0].www + r0.xyz;
  r3.xyz = cb12[42].yyy * r1.xyz;
  r1.xyz = r1.xyz * cb12[42].yyy + cb0[1].zzz;
  r0.xyz = min(r1.xyz, r0.xyz);
  o0.xyz = -r3.xyz * cb12[42].zzz + r0.xyz;
  r0.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r0.xx ? float2(1,0) : r5.xy;
  r0.x = dot(v9.xyz, r2.xyz);
  r0.y = dot(v10.xyz, r2.xyz);
  r0.z = dot(v11.xyz, r2.xyz);
  r1.x = dot(r0.xyz, r0.xyz);
  r1.x = rsqrt(r1.x);
  r0.xyz = r1.xxx * r0.xyz;
  r1.x = -0.000010 + cb2[7].x;
  r1.y = cb2[7].y + -r1.x;
  r0.w = -r1.x + r0.w;
  r1.x = 1 / r1.y;
  r0.w = saturate(r1.x * r0.w);
  r1.x = r0.w * -2 + 3;
  r0.w = r0.w * r0.w;
  r0.w = r1.x * r0.w;
  o2.w = cb2[7].w * r0.w;
  r0.z = r0.z * -8 + 8;
  r0.z = sqrt(r0.z);
  r0.z = max(0.001000, r0.z);
  r0.xy = r0.xy / r0.zz;
  o2.xy = float2(0.5,0.5) + r0.xy;
  o0.w = 0;
  o1.zw = float2(0,1);
  o2.z = 0;
  return;
}