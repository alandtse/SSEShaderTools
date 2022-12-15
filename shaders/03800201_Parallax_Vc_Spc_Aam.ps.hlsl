// Lighting
// TechniqueID: 0x3800201
//
// Technique: 0Sh0_Vc_Spc_Aam_Parallax

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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.yz = v6.xy * r0.xx;
  r0.yz = GetParallaxCoords(v1.xy, v6.xyz, v3.xyz, v4.xyz, v5.xyz);
  r1.xyzw = TexDiffuseSampler.Sample(DiffuseSampler, r0.yz).xyzw;
  r2.xyzw = TexNormalSampler.Sample(NormalSampler, r0.yz).xyzw;
  r0.yzw = r2.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.x = min(7, cb2[29].x);
  r3.x = dot(v3.xyz, r0.yzw);
  r3.y = dot(v4.xyz, r0.yzw);
  r3.z = dot(v5.xyz, r0.yzw);
  r2.y = dot(r3.xyz, r3.xyz);
  r2.y = rsqrt(r2.y);
  r3.xyz = r3.xyz * r2.yyy;
  r2.y = saturate(dot(r3.xyz, cb2[0].xyz));
  r4.xyz = cb2[1].xyz * r2.yyy;
  r5.xyz = v6.xyz * r0.xxx + cb2[0].xyz;
  r2.y = dot(r5.xyz, r5.xyz);
  r2.y = rsqrt(r2.y);
  r5.xyz = r5.xyz * r2.yyy;
  r2.y = saturate(dot(r5.xyz, r3.xyz));
  r2.y = log2(r2.y);
  r2.y = cb1[4].w * r2.y;
  r2.y = exp2(r2.y);
  r5.xyz = cb2[1].xyz * r2.yyy;
  r2.y = cmp(0 < r2.x);
  if (r2.y != 0) {
    r6.xyz = r4.xyz;
    r7.xyz = r5.xyz;
    r2.y = 0;
    while (true) {
      r2.z = cmp(r2.y >= r2.x);
      if (r2.z != 0) break;
      r2.z = (int)r2.y;
      r8.xyz = cb2[r2.z+15].xyz + -v2.xyz;
      r4.w = dot(r8.xyz, r8.xyz);
      r5.w = sqrt(r4.w);
      r5.w = saturate(r5.w / cb2[r2.z+15].w);
      r5.w = -r5.w * r5.w + 1;
      r4.w = rsqrt(r4.w);
      r8.xyz = r8.xyz * r4.www;
      r4.w = saturate(dot(r3.xyz, r8.xyz));
      r9.xyz = cb2[r2.z+22].xyz * r4.www;
      r8.xyz = v6.xyz * r0.xxx + r8.xyz;
      r4.w = dot(r8.xyz, r8.xyz);
      r4.w = rsqrt(r4.w);
      r8.xyz = r8.xyz * r4.www;
      r4.w = saturate(dot(r8.xyz, r3.xyz));
      r4.w = log2(r4.w);
      r4.w = cb1[4].w * r4.w;
      r4.w = exp2(r4.w);
      r8.xyz = cb2[r2.z+22].xyz * r4.www;
      r7.xyz = r8.xyz * r5.www + r7.xyz;
      r6.xyz = r9.xyz * r5.www + r6.xyz;
      r2.y = 1 + r2.y;
    }
    r4.xyz = r6.xyz;
    r5.xyz = r7.xyz;
  }
  r3.w = 1;
  r2.x = dot(cb2[11].xyzw, r3.xyzw);
  r2.y = dot(cb2[12].xyzw, r3.xyzw);
  r2.z = dot(cb2[13].xyzw, r3.xyzw);
  r2.xyz = cb2[4].yzw + r2.xyz;
  r2.xyz = r2.xyz + r4.xyz;
  r2.xyz = cb1[8].yzw * cb1[8].xxx + r2.xyz;
  r1.xyz = r2.xyz * r1.xyz;
  r2.xyz = v12.xyz * r1.xyz;
  r3.x = dot(cb12[12].xyzw, v10.xyzw);
  r3.y = dot(cb12[13].xyzw, v10.xyzw);
  r0.x = dot(cb12[15].xyzw, v10.xyzw);
  r3.xy = r3.xy / r0.xx;
  r4.x = dot(cb12[16].xyzw, v11.xyzw);
  r4.y = dot(cb12[17].xyzw, v11.xyzw);
  r0.x = dot(cb12[19].xyzw, v11.xyzw);
  r3.zw = r4.xy / r0.xx;
  r3.xy = r3.xy + -r3.zw;
  r3.xy = float2(-0.5,0.5) * r3.xy;
  r4.xyz = r5.xyz * r2.www;
  r4.xyz = cb2[3].yyy * r4.xyz;
  r1.xyz = -r1.xyz * v12.xyz + v13.xyz;
  r1.xyz = v13.www * r1.xyz + r2.xyz;
  r1.xyz = -r1.xyz * cb0[0].www + r2.xyz;
  r1.xyz = r1.xyz * cb12[42].yyy + cb0[1].xxx;
  r1.xyz = min(r2.xyz, r1.xyz);
  r1.xyz = r4.xyz * cb1[4].xyz + r1.xyz;
  r2.xyz = v13.xyz + -r1.xyz;
  r2.xyz = v13.www * r2.xyz + r1.xyz;
  r2.xyz = -r2.xyz * cb0[0].www + r1.xyz;
  r4.xyz = cb12[42].yyy * r2.xyz;
  r2.xyz = r2.xyz * cb12[42].yyy + cb0[1].zzz;
  r1.xyz = min(r2.xyz, r1.xyz);
  r2.xy = (uint2)v0.xy;
  bitmask.x = ((~(-1 << 2)) << 2) & 0xffffffff;  r0.x = (((uint)r2.x << 2) & bitmask.x) | ((uint)0 & ~bitmask.x);
  bitmask.x = ((~(-1 << 2)) << 0) & 0xffffffff;  r0.x = (((uint)r2.y << 0) & bitmask.x) | ((uint)r0.x & ~bitmask.x);
  r0.x = -icb[r0.x+0].x + cb2[3].z;
  r0.x = cmp(r0.x < 0);
  if (r0.x != 0) discard;
  o0.w = v12.w * r1.w;
  o0.xyz = -r4.xyz * cb12[42].zzz + r1.xyz;
  r0.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r0.xx ? float2(1,0) : r3.xy;
  r1.x = dot(v7.xyz, r0.yzw);
  r1.y = dot(v8.xyz, r0.yzw);
  r1.z = dot(v9.xyz, r0.yzw);
  r0.x = dot(r1.xyz, r1.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = r1.xyz * r0.xxx;
  r0.w = -0.000010 + cb2[7].x;
  r1.x = cb2[7].y + -r0.w;
  r0.w = r2.w + -r0.w;
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
  return;
}