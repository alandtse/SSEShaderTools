// Lighting
// TechniqueID: 0x8024201
//
// Technique: 0Sh0_Vc_Spc_DfSh_Aspc_MTLand

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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v7.xyzw, cb1[11].xyzw);
  r0.x = v8.x * cb1[12].x + r0.x;
  r0.x = v8.y * cb1[12].y + r0.x;
  r0.y = dot(v6.xyz, v6.xyz);
  r0.y = rsqrt(r0.y);
  r1.xyz = v6.xyz * r0.yyy;
  float3 viewDir = r1.xyz;
  float height = TexMTLandDiffuseBase.Sample(MTLandDiffuseBase, v1.xy).w;
  float2 parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r2.xyz = TexMTLandDiffuseBase.Sample(MTLandDiffuseBase, parallaxCoords).xyz;
  r3.xyzw = TexMTLandNormalBase.Sample(MTLandNormalBase, parallaxCoords).xyzw;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  height = TexMTLandDiffuse1.Sample(MTLandDiffuse1, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r4.xyz = TexMTLandDiffuse1.Sample(MTLandDiffuse1, parallaxCoords).xyz;
  r4.xyz = v7.yyy * r4.xyz;
  r2.xyz = v7.xxx * r2.xyz + r4.xyz;
  r4.xyzw = TexMTLandNormal1.Sample(MTLandNormal1, parallaxCoords).xyzw;
  r4.xyz = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r4.xyz = v7.yyy * r4.xyz;
  r3.xyz = v7.xxx * r3.xyz + r4.xyz;
  r0.z = v7.y * r4.w;
  r0.z = v7.x * r3.w + r0.z;
  height = TexMTLandDiffuse2.Sample(MTLandDiffuse2, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r4.xyz = TexMTLandDiffuse2.Sample(MTLandDiffuse2, parallaxCoords).xyz;
  r2.xyz = v7.zzz * r4.xyz + r2.xyz;
  r4.xyzw = TexMTLandNormal2.Sample(MTLandNormal2, parallaxCoords).xyzw;
  r4.xyz = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.xyz = v7.zzz * r4.xyz + r3.xyz;
  r0.z = v7.z * r4.w + r0.z;
  height = TexMTLandDiffuse3.Sample(MTLandDiffuse3, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r4.xyz = TexMTLandDiffuse3.Sample(MTLandDiffuse3, parallaxCoords).xyz;
  r2.xyz = v7.www * r4.xyz + r2.xyz;
  r4.xyzw = TexMTLandNormal3.Sample(MTLandNormal3, parallaxCoords).xyzw;
  r4.xyz = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.xyz = v7.www * r4.xyz + r3.xyz;
  r0.z = v7.w * r4.w + r0.z;
  height = TexMTLandDiffuse4.Sample(MTLandDiffuse4, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r4.xyz = TexMTLandDiffuse4.Sample(MTLandDiffuse4, parallaxCoords).xyz;
  r2.xyz = v8.xxx * r4.xyz + r2.xyz;
  r4.xyzw = TexMTLandNormal4.Sample(MTLandNormal4, parallaxCoords).xyzw;
  r4.xyz = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.xyz = v8.xxx * r4.xyz + r3.xyz;
  r0.z = v8.x * r4.w + r0.z;
  height = TexMTLandDiffuse5.Sample(MTLandDiffuse5, v1.xy).w;
  parallaxCoords = GetParallaxCoordsMTLand(v1.xy, viewDir, v3.xyz, v4.xyz, v5.xyz, height);
  r4.xyz = TexMTLandDiffuse5.Sample(MTLandDiffuse5, parallaxCoords).xyz;
  r2.xyz = v8.yyy * r4.xyz + r2.xyz;
  r4.xyzw = TexMTLandNormal5.Sample(MTLandNormal5, parallaxCoords).xyzw;
  r4.xyz = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.xyz = v8.yyy * r4.xyz + r3.xyz;
  r0.z = v8.y * r4.w + r0.z;
  r4.xy = min(float2(4,7), cb2[29].yx);
  r5.x = dot(v3.xyz, r3.xyz);
  r5.y = dot(v4.xyz, r3.xyz);
  r5.z = dot(v5.xyz, r3.xyz);
  r0.w = dot(r5.xyz, r5.xyz);
  r0.w = rsqrt(r0.w);
  r5.xyz = r5.xyz * r0.www;
  r4.zw = cmp(float2(0,0) < r4.xy);
  if (r4.z != 0) {
    r6.xy = cb12[44].xy * v0.xy;
    r6.xy = r6.xy * cb0[2].xy + cb0[2].zw;
    r6.xy = cb12[43].xy * r6.xy;
    r6.xy = max(float2(0,0), r6.xy);
    r7.x = min(cb12[44].z, r6.x);
    r7.y = min(cb12[43].y, r6.y);
    r6.xyzw = TexUnknown.Sample(Unknown, r7.xy).xyzw;
  } else {
    r6.xyzw = float4(1,1,1,1);
  }
  r0.w = saturate(dot(r5.xyz, cb2[0].xyz));
  r7.xyz = cb2[1].xyz * r0.www;
  r8.xyz = v6.xyz * r0.yyy + cb2[0].xyz;
  r0.w = dot(r8.xyz, r8.xyz);
  r0.w = rsqrt(r0.w);
  r8.xyz = r8.xyz * r0.www;
  r0.w = saturate(dot(r8.xyz, r5.xyz));
  r0.w = log2(r0.w);
  r0.w = r0.x * r0.w;
  r0.w = exp2(r0.w);
  r8.xyz = cb2[1].xyz * r0.www;
  if (r4.w != 0) {
    r9.xyz = r7.xyz;
    r10.xyz = r8.xyz;
    r0.w = 0;
    while (true) {
      r1.w = cmp(r0.w >= r4.y);
      if (r1.w != 0) break;
      r1.w = cmp(r0.w < r4.x);
      if (r1.w != 0) {
        r1.w = (uint)r0.w;
        r1.w = dot(cb2[2].xyzw, icb[r1.w+0].xyzw);
        r1.w = (uint)r1.w;
        r1.w = dot(r6.xyzw, icb[r1.w+0].xyzw);
      } else {
        r1.w = 1;
      }
      r2.w = (int)r0.w;
      r11.xyz = cb2[r2.w+15].xyz + -v2.xyz;
      r3.w = dot(r11.xyz, r11.xyz);
      r4.z = sqrt(r3.w);
      r4.z = saturate(r4.z / cb2[r2.w+15].w);
      r4.z = -r4.z * r4.z + 1;
      r12.xyz = cb2[r2.w+22].xyz * r1.www;
      r1.w = rsqrt(r3.w);
      r11.xyz = r11.xyz * r1.www;
      r1.w = saturate(dot(r5.xyz, r11.xyz));
      r13.xyz = r12.xyz * r1.www;
      r11.xyz = v6.xyz * r0.yyy + r11.xyz;
      r1.w = dot(r11.xyz, r11.xyz);
      r1.w = rsqrt(r1.w);
      r11.xyz = r11.xyz * r1.www;
      r1.w = saturate(dot(r11.xyz, r5.xyz));
      r1.w = log2(r1.w);
      r1.w = r1.w * r0.x;
      r1.w = exp2(r1.w);
      r11.xyz = r12.xyz * r1.www;
      r10.xyz = r11.xyz * r4.zzz + r10.xyz;
      r9.xyz = r13.xyz * r4.zzz + r9.xyz;
      r0.w = 1 + r0.w;
    }
    r7.xyz = r9.xyz;
    r8.xyz = r10.xyz;
  }
  r5.w = 1;
  r4.x = dot(cb2[11].xyzw, r5.xyzw);
  r4.y = dot(cb2[12].xyzw, r5.xyzw);
  r4.z = dot(cb2[13].xyzw, r5.xyzw);
  r0.xyw = cb2[4].yzw + r4.xyz;
  r0.xyw = r0.xyw + r7.xyz;
  r0.xyw = cb1[8].yzw * cb1[8].xxx + r0.xyw;
  r0.xyw = r0.xyw * r2.xyz;
  r2.xyz = v14.xyz * r0.xyw;
  r4.x = dot(cb12[12].xyzw, v12.xyzw);
  r4.y = dot(cb12[13].xyzw, v12.xyzw);
  r1.w = dot(cb12[15].xyzw, v12.xyzw);
  r4.xy = r4.xy / r1.ww;
  r6.x = dot(cb12[16].xyzw, v13.xyzw);
  r6.y = dot(cb12[17].xyzw, v13.xyzw);
  r1.w = dot(cb12[19].xyzw, v13.xyzw);
  r4.zw = r6.xy / r1.ww;
  r4.xy = r4.xy + -r4.zw;
  r4.xy = float2(-0.5,0.5) * r4.xy;
  r6.xyz = r8.xyz * r0.zzz;
  r6.xyz = cb2[3].yyy * r6.xyz;
  r1.x = saturate(dot(r5.xyz, r1.xyz));
  r1.x = 1 + -r1.x;
  r1.x = log2(r1.x);
  r1.x = cb2[14].w * r1.x;
  r1.x = exp2(r1.x);
  r5.w = 0.150000;
  r7.x = saturate(dot(cb2[11].xyzw, r5.xyzw));
  r7.y = saturate(dot(cb2[12].xyzw, r5.xyzw));
  r7.z = saturate(dot(cb2[13].xyzw, r5.xyzw));
  r1.yzw = cb2[14].xyz * r7.xyz;
  r1.xyz = r1.yzw * r1.xxx;
  r1.xyz = r6.xyz * cb1[4].xyz + r1.xyz;
  r0.xyw = -r0.xyw * v14.xyz + v15.xyz;
  r0.xyw = v15.www * r0.xyw + r2.xyz;
  r0.xyw = -r0.xyw * cb0[0].www + r2.xyz;
  r0.xyw = r0.xyw * cb12[42].yyy + cb0[1].xxx;
  r0.xyw = min(r2.xyz, r0.xyw);
  r0.xyw = r0.xyw + r1.xyz;
  r1.xyz = v15.xyz + -r0.xyw;
  r1.xyz = v15.www * r1.xyz + r0.xyw;
  r1.xyz = -r1.xyz * cb0[0].www + r0.xyw;
  r2.xyz = cb12[42].yyy * r1.xyz;
  r1.xyz = r1.xyz * cb12[42].yyy + cb0[1].zzz;
  r0.xyw = min(r1.xyz, r0.xyw);
  o0.xyz = -r2.xyz * cb12[42].zzz + r0.xyw;
  r0.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r0.xx ? float2(1,0) : r4.xy;
  r1.x = dot(v9.xyz, r3.xyz);
  r1.y = dot(v10.xyz, r3.xyz);
  r1.z = dot(v11.xyz, r3.xyz);
  r0.x = dot(r1.xyz, r1.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyw = r1.xyz * r0.xxx;
  r1.x = -0.000010 + cb2[7].x;
  r1.y = cb2[7].y + -r1.x;
  r0.z = -r1.x + r0.z;
  r1.x = 1 / r1.y;
  r0.z = saturate(r1.x * r0.z);
  r1.x = r0.z * -2 + 3;
  r0.z = r0.z * r0.z;
  r0.z = r1.x * r0.z;
  o2.w = cb2[7].w * r0.z;
  r0.z = r0.w * -8 + 8;
  r0.z = sqrt(r0.z);
  r0.z = max(0.001000, r0.z);
  r0.xy = r0.xy / r0.zz;
  o2.xy = float2(0.5,0.5) + r0.xy;
  o0.w = 0;
  o1.zw = float2(0,1);
  o2.z = 0;
  return;
}