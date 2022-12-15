// Lighting
// TechniqueID: 0x3004001
//
// Technique: 0Sh0_Vc_DfSh_Parallax

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
  float4 v7 : TEXCOORD8,
  float4 v8 : TEXCOORD9,
  float3 v9 : TEXCOORD10,
  float4 v10 : POSITION1,
  float4 v11 : POSITION2,
  float4 v12 : COLOR0,
  float4 v13 : COLOR1,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2)
{
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.xy = v6.xy * r0.xx;
  r0.xy = GetParallaxCoords(v1.xy, v6.xyz, v3.xyz, v4.xyz, v5.xyz);
  r1.xyzw = TexDiffuseSampler.Sample(DiffuseSampler, r0.xy).xyzw;
  r0.xyzw = TexNormalSampler.Sample(NormalSampler, r0.xy).xyzw;
  r0.xyz = r0.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.xy = min(float2(4,7), cb2[29].yx);
  r3.x = dot(v3.xyz, r0.xyz);
  r3.y = dot(v4.xyz, r0.xyz);
  r3.z = dot(v5.xyz, r0.xyz);
  r2.z = dot(r3.xyz, r3.xyz);
  r2.z = rsqrt(r2.z);
  r3.xyz = r3.xyz * r2.zzz;
  r2.zw = cmp(float2(0,0) < r2.xy);
  if (r2.z != 0) {
    r4.xy = cb12[44].xy * v0.xy;
    r4.xy = r4.xy * cb0[2].xy + cb0[2].zw;
    r4.xy = cb12[43].xy * r4.xy;
    r4.xy = max(float2(0,0), r4.xy);
    r5.x = min(cb12[44].z, r4.x);
    r5.y = min(cb12[43].y, r4.y);
    r4.xyzw = TexShadowMaskSampler.Sample(ShadowMaskSampler, r5.xy).xyzw;
  } else {
    r4.xyzw = float4(1,1,1,1);
  }
  r2.z = saturate(dot(r3.xyz, cb2[0].xyz));
  r5.xyz = cb2[1].xyz * r2.zzz;
  if (r2.w != 0) {
    r6.xyz = r5.xyz;
    r2.z = 0;
    while (true) {
      r2.w = cmp(r2.z >= r2.y);
      if (r2.w != 0) break;
      r2.w = cmp(r2.z < r2.x);
      if (r2.w != 0) {
        r2.w = (uint)r2.z;
        r2.w = dot(cb2[2].xyzw, icb[r2.w+0].xyzw);
        r2.w = (uint)r2.w;
        r2.w = dot(r4.xyzw, icb[r2.w+0].xyzw);
      } else {
        r2.w = 1;
      }
      r5.w = (int)r2.z;
      r7.xyz = cb2[r5.w+15].xyz + -v2.xyz;
      r6.w = dot(r7.xyz, r7.xyz);
      r7.w = sqrt(r6.w);
      r7.w = saturate(r7.w / cb2[r5.w+15].w);
      r7.w = -r7.w * r7.w + 1;
      r8.xyz = cb2[r5.w+22].xyz * r2.www;
      r2.w = rsqrt(r6.w);
      r7.xyz = r7.xyz * r2.www;
      r2.w = saturate(dot(r3.xyz, r7.xyz));
      r7.xyz = r8.xyz * r2.www;
      r6.xyz = r7.xyz * r7.www + r6.xyz;
      r2.z = 1 + r2.z;
    }
    r5.xyz = r6.xyz;
  }
  r3.w = 1;
  r2.x = dot(cb2[11].xyzw, r3.xyzw);
  r2.y = dot(cb2[12].xyzw, r3.xyzw);
  r2.z = dot(cb2[13].xyzw, r3.xyzw);
  r2.xyz = cb2[4].yzw + r2.xyz;
  r2.xyz = r2.xyz + r5.xyz;
  r2.xyz = cb1[8].yzw * cb1[8].xxx + r2.xyz;
  r1.xyz = r2.xyz * r1.xyz;
  r2.xyz = v12.xyz * r1.xyz;
  r3.x = dot(cb12[12].xyzw, v10.xyzw);
  r3.y = dot(cb12[13].xyzw, v10.xyzw);
  r2.w = dot(cb12[15].xyzw, v10.xyzw);
  r3.xy = r3.xy / r2.ww;
  r4.x = dot(cb12[16].xyzw, v11.xyzw);
  r4.y = dot(cb12[17].xyzw, v11.xyzw);
  r2.w = dot(cb12[19].xyzw, v11.xyzw);
  r3.zw = r4.xy / r2.ww;
  r3.xy = r3.xy + -r3.zw;
  r3.xy = float2(-0.5,0.5) * r3.xy;
  r1.xyz = -r1.xyz * v12.xyz + v13.xyz;
  r1.xyz = v13.www * r1.xyz + r2.xyz;
  r1.xyz = -r1.xyz * cb0[0].www + r2.xyz;
  r4.xyz = cb12[42].yyy * r1.xyz;
  r1.xyz = r1.xyz * cb12[42].yyy + cb0[1].xxx;
  r1.xyz = min(r2.xyz, r1.xyz);
  r1.w = cb2[3].z * r1.w;
  o0.w = v12.w * r1.w;
  o0.xyz = -r4.xyz * cb12[42].zzz + r1.xyz;
  r1.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r1.xx ? float2(1,0) : r3.xy;
  r1.x = dot(v7.xyz, r0.xyz);
  r1.y = dot(v8.xyz, r0.xyz);
  r1.z = dot(v9.xyz, r0.xyz);
  r0.x = dot(r1.xyz, r1.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = r1.xyz * r0.xxx;
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
  o1.zw = float2(0,1);
  o2.z = 0;
  return;
}