// Lighting
// TechniqueID: 0x3200001
//
// Technique: 0Sh0_Vc_Snow_Parallax

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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v6.xyz * r0.xxx;
  r1.xy = GetParallaxCoords(v1.xy, v6.xyz, v3.xyz, v4.xyz, v5.xyz);
  r2.xyzw = TexDiffuseSampler.Sample(DiffuseSampler, r1.xy).xyzw;
  r1.xyzw = TexNormalSampler.Sample(NormalSampler, r1.xy).xyzw;
  r1.xyz = r1.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r0.w = min(7, cb2[29].x);
  r3.x = dot(v3.xyz, r1.xyz);
  r3.y = dot(v4.xyz, r1.xyz);
  r3.z = dot(v5.xyz, r1.xyz);
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r4.x = saturate(dot(r3.xyz, cb2[0].xyz));
  r4.xyz = cb2[1].xyz * r4.xxx;
  r4.w = cmp(0.000010 < cb1[13].w);
  r5.x = v3.z;
  r5.y = v4.z;
  r5.z = v5.z;
  r5.w = dot(r5.xyz, r5.xyz);
  r5.w = rsqrt(r5.w);
  r5.xyz = r5.xyz * r5.www;
  r5.w = saturate(dot(r3.xyz, r0.xyz));
  r5.w = 1 + -r5.w;
  r0.x = saturate(dot(r5.xyz, r0.xyz));
  r0.x = 1 + -r0.x;
  r0.x = log2(r0.x);
  r0.x = cb1[13].y * r0.x;
  r0.x = exp2(r0.x);
  r0.y = log2(r5.w);
  r0.y = cb1[13].z * r0.y;
  r0.y = exp2(r0.y);
  r0.x = r0.x * r0.y;
  r0.x = cb1[13].x * r0.x;
  r0.x = r4.w ? r0.x : 0;
  r0.y = cmp(0 < r0.w);
  if (r0.y != 0) {
    r5.xyz = r4.xyz;
    r0.y = 0;
    while (true) {
      r0.z = cmp(r0.y >= r0.w);
      if (r0.z != 0) break;
      r0.z = (int)r0.y;
      r6.xyz = cb2[r0.z+15].xyz + -v2.xyz;
      r4.w = dot(r6.xyz, r6.xyz);
      r5.w = sqrt(r4.w);
      r5.w = saturate(r5.w / cb2[r0.z+15].w);
      r5.w = -r5.w * r5.w + 1;
      r4.w = rsqrt(r4.w);
      r6.xyz = r6.xyz * r4.www;
      r4.w = saturate(dot(r3.xyz, r6.xyz));
      r6.xyz = cb2[r0.z+22].xyz * r4.www;
      r5.xyz = r6.xyz * r5.www + r5.xyz;
      r0.y = 1 + r0.y;
    }
    r4.xyz = r5.xyz;
  }
  r3.w = 1;
  r5.x = dot(cb2[11].xyzw, r3.xyzw);
  r5.y = dot(cb2[12].xyzw, r3.xyzw);
  r5.z = dot(cb2[13].xyzw, r3.xyzw);
  r0.yzw = cb2[4].yzw + r5.xyz;
  r0.yzw = r0.yzw + r4.xyz;
  r0.yzw = cb1[8].yzw * cb1[8].xxx + r0.yzw;
  r0.yzw = r0.yzw * r2.xyz;
  r2.xyz = v12.xyz * r0.yzw;
  r3.x = dot(cb12[12].xyzw, v10.xyzw);
  r3.y = dot(cb12[13].xyzw, v10.xyzw);
  r3.z = dot(cb12[15].xyzw, v10.xyzw);
  r3.xy = r3.xy / r3.zz;
  r4.x = dot(cb12[16].xyzw, v11.xyzw);
  r4.y = dot(cb12[17].xyzw, v11.xyzw);
  r3.z = dot(cb12[19].xyzw, v11.xyzw);
  r3.zw = r4.xy / r3.zz;
  r3.xy = r3.xy + -r3.zw;
  r3.xy = float2(-0.5,0.5) * r3.xy;
  r0.yzw = -r0.yzw * v12.xyz + v13.xyz;
  r0.yzw = v13.www * r0.yzw + r2.xyz;
  r0.yzw = -r0.yzw * cb0[0].www + r2.xyz;
  r4.xyz = cb12[42].yyy * r0.yzw;
  r0.yzw = r0.yzw * cb12[42].yyy + cb0[1].xxx;
  r0.yzw = min(r2.xyz, r0.yzw);
  r2.x = cb2[3].z * r2.w;
  o0.w = v12.w * r2.x;
  o0.xyz = -r4.xyz * cb12[42].zzz + r0.yzw;
  o3.x = dot(r0.xxx, float3(0.300000,0.590000,0.110000));
  r0.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r0.xx ? float2(1,0) : r3.xy;
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