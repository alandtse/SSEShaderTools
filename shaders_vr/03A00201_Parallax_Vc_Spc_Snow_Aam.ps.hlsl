// Lighting
// TechniqueID: 0x3A00201
//
// Technique: 0Sh0_Vc_Spc_Snow_Aam_Parallax

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
  out float4 o2 : SV_Target2,
  out float2 o3 : SV_Target3)
{
  const float4 icb[] = { { 0.003922, 0, 0, 0},
                              { 0.533333, 0, 0, 0},
                              { 0.133333, 0, 0, 0},
                              { 0.666667, 0, 0, 0},
                              { 0.800000, 0, 0, 0},
                              { 0.266667, 0, 0, 0},
                              { 0.933333, 0, 0, 0},
                              { 0.400000, 0, 0, 0},
                              { 0.200000, 0, 0, 0},
                              { 0.733333, 0, 0, 0},
                              { 0.066667, 0, 0, 0},
                              { 0.600000, 0, 0, 0},
                              { 0.996078, 0, 0, 0},
                              { 0.466667, 0, 0, 0},
                              { 0.866667, 0, 0, 0},
                              { 0.333333, 0, 0, 0} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.yzw = v6.xyz * r0.xxx;
  r1.xy = GetParallaxCoords(v1.xy, v6.xyz, v3.xyz, v4.xyz, v5.xyz);
  r2.xyzw = TexDiffuseSampler.Sample(DiffuseSampler, r1.xy).xyzw;
  r1.xyzw = TexNormalSampler.Sample(NormalSampler, r1.xy).xyzw;
  r1.xyz = r1.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.x = min(7, cb2[29].x);
  r4.x = dot(v3.xyz, r1.xyz);
  r4.y = dot(v4.xyz, r1.xyz);
  r4.z = dot(v5.xyz, r1.xyz);
  r3.y = dot(r4.xyz, r4.xyz);
  r3.y = rsqrt(r3.y);
  r4.xyz = r4.xyz * r3.yyy;
  r3.y = saturate(dot(r4.xyz, cb2[0].xyz));
  r3.yzw = cb2[1].xyz * r3.yyy;
  r5.x = cmp(0.000010 < cb1[13].w);
  r6.x = v3.z;
  r6.y = v4.z;
  r6.z = v5.z;
  r5.y = dot(r6.xyz, r6.xyz);
  r5.y = rsqrt(r5.y);
  r5.yzw = r6.xyz * r5.yyy;
  r6.x = saturate(dot(r4.xyz, r0.yzw));
  r6.x = 1 + -r6.x;
  r0.y = saturate(dot(r5.yzw, r0.yzw));
  r0.y = 1 + -r0.y;
  r0.y = log2(r0.y);
  r0.y = cb1[13].y * r0.y;
  r0.y = exp2(r0.y);
  r0.z = log2(r6.x);
  r0.z = cb1[13].z * r0.z;
  r0.z = exp2(r0.z);
  r0.y = r0.y * r0.z;
  r0.y = cb1[13].x * r0.y;
  r0.yzw = r5.xxx ? r0.yyy : 0;
  r5.x = cmp(0 < r3.x);
  if (r5.x != 0) {
    r5.xyz = r3.yzw;
    r6.xyz = r0.www;
    r5.w = 0;
    while (true) {
      r6.w = cmp(r5.w >= r3.x);
      if (r6.w != 0) break;
      r6.w = (int)r5.w;
      r7.xyz = cb2[r6.w+15].xyz + -v2.xyz;
      r7.w = dot(r7.xyz, r7.xyz);
      r8.x = sqrt(r7.w);
      r8.x = saturate(r8.x / cb2[r6.w+15].w);
      r8.x = -r8.x * r8.x + 1;
      r7.w = rsqrt(r7.w);
      r7.xyz = r7.xyz * r7.www;
      r7.w = saturate(dot(r4.xyz, r7.xyz));
      r8.yzw = cb2[r6.w+22].xyz * r7.www;
      r7.xyz = v6.xyz * r0.xxx + r7.xyz;
      r7.w = dot(r7.xyz, r7.xyz);
      r7.w = rsqrt(r7.w);
      r7.xyz = r7.xyz * r7.www;
      r7.x = saturate(dot(r7.xyz, r4.xyz));
      r7.x = log2(r7.x);
      r7.x = cb1[4].w * r7.x;
      r7.x = exp2(r7.x);
      r7.xyz = cb2[r6.w+22].xyz * r7.xxx;
      r6.xyz = r7.xyz * r8.xxx + r6.xyz;
      r5.xyz = r8.yzw * r8.xxx + r5.xyz;
      r5.w = 1 + r5.w;
    }
    r3.yzw = r5.xyz;
    r0.yzw = r6.xyz;
  }
  r4.w = 1;
  r5.x = dot(cb2[11].xyzw, r4.xyzw);
  r5.y = dot(cb2[12].xyzw, r4.xyzw);
  r5.z = dot(cb2[13].xyzw, r4.xyzw);
  r4.xyz = cb2[4].yzw + r5.xyz;
  r3.xyz = r4.xyz + r3.yzw;
  r3.xyz = cb1[8].yzw * cb1[8].xxx + r3.xyz;
  r2.xyz = r3.xyz * r2.xyz;
  r3.xyz = v12.xyz * r2.xyz;
  r4.x = dot(cb12[12].xyzw, v10.xyzw);
  r4.y = dot(cb12[13].xyzw, v10.xyzw);
  r0.x = dot(cb12[15].xyzw, v10.xyzw);
  r4.xy = r4.xy / r0.xx;
  r5.x = dot(cb12[16].xyzw, v11.xyzw);
  r5.y = dot(cb12[17].xyzw, v11.xyzw);
  r0.x = dot(cb12[19].xyzw, v11.xyzw);
  r4.zw = r5.xy / r0.xx;
  r4.xy = r4.xy + -r4.zw;
  r4.xy = float2(-0.5,0.5) * r4.xy;
  r2.xyz = -r2.xyz * v12.xyz + v13.xyz;
  r2.xyz = v13.www * r2.xyz + r3.xyz;
  r2.xyz = -r2.xyz * cb0[0].www + r3.xyz;
  r2.xyz = r2.xyz * cb12[42].yyy + cb0[1].xxx;
  r2.xyz = min(r3.xyz, r2.xyz);
  r3.xyz = v13.xyz + -r2.xyz;
  r3.xyz = v13.www * r3.xyz + r2.xyz;
  r3.xyz = -r3.xyz * cb0[0].www + r2.xyz;
  r5.xyz = cb12[42].yyy * r3.xyz;
  r3.xyz = r3.xyz * cb12[42].yyy + cb0[1].zzz;
  r2.xyz = min(r3.xyz, r2.xyz);
  r3.xy = (uint2)v0.xy;
  bitmask.x = ((~(-1 << 2)) << 2) & 0xffffffff;  r0.x = (((uint)r3.x << 2) & bitmask.x) | ((uint)0 & ~bitmask.x);
  bitmask.x = ((~(-1 << 2)) << 0) & 0xffffffff;  r0.x = (((uint)r3.y << 0) & bitmask.x) | ((uint)r0.x & ~bitmask.x);
  r0.x = -icb[r0.x+0].x + cb2[3].z;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.w = v12.w * r2.w;
  o0.xyz = -r5.xyz * cb12[42].zzz + r2.xyz;
  o3.x = dot(r0.yzw, float3(0.300000,0.590000,0.110000));
  r0.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r0.xx ? float2(1,0) : r4.xy;
  r0.x = dot(v7.xyz, r1.xyz);
  r0.y = dot(v8.xyz, r1.xyz);
  r0.z = dot(v9.xyz, r1.xyz);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.w = -0.000010 + cb2[7].x;
  r1.x = cb2[7].y + -r0.w;
  r0.w = r1.w + -r0.w;
  r1.x = 1 / r1.x;
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
  o3.y = r2.w;
  return;
}