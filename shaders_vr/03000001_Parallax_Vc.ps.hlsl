// Lighting
// TechniqueID: 0x3000001
//
// Technique: 0Sh0_Vc_Parallax

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
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = dot(v6.xyz, v6.xyz);
  r0.x = rsqrt(r0.x);
  r0.xy = v6.xy * r0.xx;
  r0.xy = GetParallaxCoords(v1.xy, v6.xyz, v3.xyz, v4.xyz, v5.xyz);
  r1.xyzw = TexDiffuseSampler.Sample(DiffuseSampler, r0.xy).xyzw;
  r0.xyzw = TexNormalSampler.Sample(NormalSampler, r0.xy).xyzw;
  r0.xyz = r0.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r2.x = min(7, cb2[29].x);
  r3.x = dot(v3.xyz, r0.xyz);
  r3.y = dot(v4.xyz, r0.xyz);
  r3.z = dot(v5.xyz, r0.xyz);
  r2.y = dot(r3.xyz, r3.xyz);
  r2.y = rsqrt(r2.y);
  r3.xyz = r3.xyz * r2.yyy;
  r2.y = saturate(dot(r3.xyz, cb2[0].xyz));
  r2.yzw = cb2[1].xyz * r2.yyy;
  r4.x = cmp(0 < r2.x);
  if (r4.x != 0) {
    r4.xyz = r2.yzw;
    r4.w = 0;
    while (true) {
      r5.x = cmp(r4.w >= r2.x);
      if (r5.x != 0) break;
      r5.x = (int)r4.w;
      r5.yzw = cb2[r5.x+15].xyz + -v2.xyz;
      r6.x = dot(r5.yzw, r5.yzw);
      r6.y = sqrt(r6.x);
      r6.y = saturate(r6.y / cb2[r5.x+15].w);
      r6.y = -r6.y * r6.y + 1;
      r6.x = rsqrt(r6.x);
      r5.yzw = r6.xxx * r5.yzw;
      r5.y = saturate(dot(r3.xyz, r5.yzw));
      r5.xyz = cb2[r5.x+22].xyz * r5.yyy;
      r4.xyz = r5.xyz * r6.yyy + r4.xyz;
      r4.w = 1 + r4.w;
    }
    r2.yzw = r4.xyz;
  }
  r3.w = 1;
  r4.x = dot(cb2[11].xyzw, r3.xyzw);
  r4.y = dot(cb2[12].xyzw, r3.xyzw);
  r4.z = dot(cb2[13].xyzw, r3.xyzw);
  r3.xyz = cb2[4].yzw + r4.xyz;
  r2.xyz = r3.xyz + r2.yzw;
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