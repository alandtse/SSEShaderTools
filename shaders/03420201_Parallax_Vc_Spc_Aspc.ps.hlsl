// Lighting
// TechniqueID: 0x3420201
//
// Technique: 0Sh0_Vc_Spc_Aspc_Parallax

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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
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
  r5.xyz = v6.xyz * r0.xxx + cb2[0].xyz;
  r5.w = dot(r5.xyz, r5.xyz);
  r5.w = rsqrt(r5.w);
  r5.xyz = r5.xyz * r5.www;
  r5.x = saturate(dot(r5.xyz, r4.xyz));
  r5.x = log2(r5.x);
  r5.x = cb1[4].w * r5.x;
  r5.x = exp2(r5.x);
  r5.xyz = cb2[1].xyz * r5.xxx;
  r5.w = cmp(0 < r3.x);
  if (r5.w != 0) {
    r6.xyz = r3.yzw;
    r7.xyz = r5.xyz;
    r5.w = 0;
    while (true) {
      r6.w = cmp(r5.w >= r3.x);
      if (r6.w != 0) break;
      r6.w = (int)r5.w;
      r8.xyz = cb2[r6.w+15].xyz + -v2.xyz;
      r7.w = dot(r8.xyz, r8.xyz);
      r8.w = sqrt(r7.w);
      r8.w = saturate(r8.w / cb2[r6.w+15].w);
      r8.w = -r8.w * r8.w + 1;
      r7.w = rsqrt(r7.w);
      r8.xyz = r8.xyz * r7.www;
      r7.w = saturate(dot(r4.xyz, r8.xyz));
      r9.xyz = cb2[r6.w+22].xyz * r7.www;
      r8.xyz = v6.xyz * r0.xxx + r8.xyz;
      r7.w = dot(r8.xyz, r8.xyz);
      r7.w = rsqrt(r7.w);
      r8.xyz = r8.xyz * r7.www;
      r7.w = saturate(dot(r8.xyz, r4.xyz));
      r7.w = log2(r7.w);
      r7.w = cb1[4].w * r7.w;
      r7.w = exp2(r7.w);
      r8.xyz = cb2[r6.w+22].xyz * r7.www;
      r7.xyz = r8.xyz * r8.www + r7.xyz;
      r6.xyz = r9.xyz * r8.www + r6.xyz;
      r5.w = 1 + r5.w;
    }
    r3.yzw = r6.xyz;
    r5.xyz = r7.xyz;
  }
  r0.x = saturate(dot(r0.yzw, r4.xyz));
  r0.y = saturate(dot(float2(0.164398998,-0.986393988), r4.yz));
  r0.y = cb1[14].y * r0.y;
  r0.y = r0.x * cb1[14].x + r0.y;
  r0.z = TexProjectedNoiseSampler.Sample(ProjectedNoiseSampler, float2(1,1)).x;
  r0.z = cb1[14].z * r0.z;
  r0.z = max(0, r0.z);
  r0.z = min(cb1[14].w, r0.z);
  r0.yzw = r0.yyy * r0.zzz + r3.yzw;
  r4.w = 1;
  r3.x = dot(cb2[11].xyzw, r4.xyzw);
  r3.y = dot(cb2[12].xyzw, r4.xyzw);
  r3.z = dot(cb2[13].xyzw, r4.xyzw);
  r3.xyz = cb2[4].yzw + r3.xyz;
  r0.yzw = r3.xyz + r0.yzw;
  r0.yzw = cb1[8].yzw * cb1[8].xxx + r0.yzw;
  r0.yzw = r0.yzw * r2.xyz;
  r2.xyz = v12.xyz * r0.yzw;
  r3.x = dot(cb12[12].xyzw, v10.xyzw);
  r3.y = dot(cb12[13].xyzw, v10.xyzw);
  r3.z = dot(cb12[15].xyzw, v10.xyzw);
  r3.xy = r3.xy / r3.zz;
  r6.x = dot(cb12[16].xyzw, v11.xyzw);
  r6.y = dot(cb12[17].xyzw, v11.xyzw);
  r3.z = dot(cb12[19].xyzw, v11.xyzw);
  r3.zw = r6.xy / r3.zz;
  r3.xy = r3.xy + -r3.zw;
  r3.xy = float2(-0.5,0.5) * r3.xy;
  r5.xyz = r5.xyz * r1.www;
  r5.xyz = cb2[3].yyy * r5.xyz;
  r0.x = 1 + -r0.x;
  r0.x = log2(r0.x);
  r0.x = cb2[14].w * r0.x;
  r0.x = exp2(r0.x);
  r4.w = 0.150000;
  r6.x = saturate(dot(cb2[11].xyzw, r4.xyzw));
  r6.y = saturate(dot(cb2[12].xyzw, r4.xyzw));
  r6.z = saturate(dot(cb2[13].xyzw, r4.xyzw));
  r4.xyz = cb2[14].xyz * r6.xyz;
  r4.xyz = r4.xyz * r0.xxx;
  r4.xyz = r5.xyz * cb1[4].xyz + r4.xyz;
  r0.xyz = -r0.yzw * v12.xyz + v13.xyz;
  r0.xyz = v13.www * r0.xyz + r2.xyz;
  r0.xyz = -r0.xyz * cb0[0].www + r2.xyz;
  r0.xyz = r0.xyz * cb12[42].yyy + cb0[1].xxx;
  r0.xyz = min(r2.xyz, r0.xyz);
  r0.xyz = r0.xyz + r4.xyz;
  r2.xyz = v13.xyz + -r0.xyz;
  r2.xyz = v13.www * r2.xyz + r0.xyz;
  r2.xyz = -r2.xyz * cb0[0].www + r0.xyz;
  r4.xyz = cb12[42].yyy * r2.xyz;
  r2.xyz = r2.xyz * cb12[42].yyy + cb0[1].zzz;
  r0.xyz = min(r2.xyz, r0.xyz);
  r0.w = cb2[3].z * r2.w;
  o0.w = v12.w * r0.w;
  o0.xyz = -r4.xyz * cb12[42].zzz + r0.xyz;
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
  return;
}