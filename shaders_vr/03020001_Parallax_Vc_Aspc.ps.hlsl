// Lighting
// TechniqueID: 0x3020001
//
// Technique: 0Sh0_Vc_Aspc_Parallax

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
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
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
  r4.w = cmp(0 < r0.w);
  if (r4.w != 0) {
    r5.xyz = r4.xyz;
    r4.w = 0;
    while (true) {
      r5.w = cmp(r4.w >= r0.w);
      if (r5.w != 0) break;
      r5.w = (int)r4.w;
      r6.xyz = cb2[r5.w+15].xyz + -v2.xyz;
      r6.w = dot(r6.xyz, r6.xyz);
      r7.x = sqrt(r6.w);
      r7.x = saturate(r7.x / cb2[r5.w+15].w);
      r7.x = -r7.x * r7.x + 1;
      r6.w = rsqrt(r6.w);
      r6.xyz = r6.xyz * r6.www;
      r6.x = saturate(dot(r3.xyz, r6.xyz));
      r6.xyz = cb2[r5.w+22].xyz * r6.xxx;
      r5.xyz = r6.xyz * r7.xxx + r5.xyz;
      r4.w = 1 + r4.w;
    }
    r4.xyz = r5.xyz;
  }
  r3.w = 1;
  r5.x = dot(cb2[11].xyzw, r3.xyzw);
  r5.y = dot(cb2[12].xyzw, r3.xyzw);
  r5.z = dot(cb2[13].xyzw, r3.xyzw);
  r5.xyz = cb2[4].yzw + r5.xyz;
  r4.xyz = r5.xyz + r4.xyz;
  r4.xyz = cb1[8].yzw * cb1[8].xxx + r4.xyz;
  r2.xyz = r4.xyz * r2.xyz;
  r4.xyz = v12.xyz * r2.xyz;
  r5.x = dot(cb12[12].xyzw, v10.xyzw);
  r5.y = dot(cb12[13].xyzw, v10.xyzw);
  r0.w = dot(cb12[15].xyzw, v10.xyzw);
  r5.xy = r5.xy / r0.ww;
  r6.x = dot(cb12[16].xyzw, v11.xyzw);
  r6.y = dot(cb12[17].xyzw, v11.xyzw);
  r0.w = dot(cb12[19].xyzw, v11.xyzw);
  r5.zw = r6.xy / r0.ww;
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
  r0.yzw = cb2[14].xyz * r6.xyz;
  r2.xyz = -r2.xyz * v12.xyz + v13.xyz;
  r2.xyz = v13.www * r2.xyz + r4.xyz;
  r2.xyz = -r2.xyz * cb0[0].www + r4.xyz;
  r2.xyz = r2.xyz * cb12[42].yyy + cb0[1].xxx;
  r2.xyz = min(r4.xyz, r2.xyz);
  r0.xyz = r0.yzw * r0.xxx + r2.xyz;
  r2.xyz = v13.xyz + -r0.xyz;
  r2.xyz = v13.www * r2.xyz + r0.xyz;
  r2.xyz = -r2.xyz * cb0[0].www + r0.xyz;
  r3.xyz = cb12[42].yyy * r2.xyz;
  r2.xyz = r2.xyz * cb12[42].yyy + cb0[1].zzz;
  r0.xyz = min(r2.xyz, r0.xyz);
  r0.w = cb2[3].z * r2.w;
  o0.w = v12.w * r0.w;
  o0.xyz = -r3.xyz * cb12[42].zzz + r0.xyz;
  r0.x = cmp(0.000010 < cb2[7].z);
  o1.xy = r0.xx ? float2(1,0) : r5.xy;
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
  return;
}