// ---- Created with 3Dmigoto v1.3.16 on Sun Jan 09 20:21:35 2022
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t1 : register(t1);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s3_s : register(s3);

SamplerState s1_s : register(s1);

SamplerState s0_s : register(s0);

cbuffer cb2 : register(b2)
{
  float4 cb2[49];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[9];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[3];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[87];
}

cbuffer cb13 : register(b13)
{
  float4 cb13[1];
}




// 3Dmigoto declarations
#define cmp -
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
  float4 v10 : COLOR0,
  float4 v11 : COLOR1,
  float v12 : SV_ClipDistance0,
  float w12 : SV_CullDistance0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2)
{
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = v0.xy * cb0[2].xy + cb0[2].zw;
  r0.x = cb12[86].x * r0.x;
  r0.z = cmp(r0.x >= 0.5);
  r0.z = r0.z ? 1.000000 : 0;
  r0.w = (uint)cb13[0].y;
  r0.z = (int)r0.w * (int)r0.z;
  r1.x = (uint)r0.z;
  r1.y = -r1.x * 0.5 + r0.x;
  r1.y = r1.y + r1.y;
  r2.x = r0.w ? r1.y : r0.x;
  r2.y = -r0.y * cb12[86].y + 1;
  r2.xy = r2.xy * float2(2,2) + float2(-1,-1);
  r0.x = (uint)r0.z << 2;
  r2.z = v0.z;
  r2.w = 1;
  r3.x = dot(cb12[r0.x+64].xyzw, r2.xyzw);
  r3.y = dot(cb12[r0.x+65].xyzw, r2.xyzw);
  r3.z = dot(cb12[r0.x+66].xyzw, r2.xyzw);
  r0.y = dot(cb12[r0.x+67].xyzw, r2.xyzw);
  r2.xyz = r3.xyz / r0.yyy;
  r0.y = (int)r0.z * 0;
  r2.w = 1;
  r3.x = dot(cb2[r0.y+1].xyzw, r2.xyzw);
  r3.y = dot(cb2[r0.y+2].xyzw, r2.xyzw);
  r3.z = dot(cb2[r0.y+3].xyzw, r2.xyzw);
  r3.w = 1;
  r4.x = dot(cb2[r0.y+7].xyzw, r3.xyzw);
  r4.y = dot(cb2[r0.y+8].xyzw, r3.xyzw);
  r4.z = dot(cb2[r0.y+9].xyzw, r3.xyzw);
  r0.y = dot(v6.xyz, v6.xyz);
  r0.y = rsqrt(r0.y);
  r0.yzw = v6.xyz * r0.yyy;
  r1.yz = GetParallaxCoords(v1.xy, v6.xyz, v3.xyz, v4.xyz, v5.xyz);
  r3.xyzw = t0.Sample(s0_s, r1.yz).xyzw;
  r5.xyzw = t1.Sample(s1_s, r1.yz).xyzw;
  r1.yzw = r5.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r5.xy = min(float2(4,7), cb2[48].yx);
  r6.x = dot(v3.xyz, r1.yzw);
  r6.y = dot(v4.xyz, r1.yzw);
  r6.z = dot(v5.xyz, r1.yzw);
  r5.z = dot(r6.xyz, r6.xyz);
  r5.z = rsqrt(r5.z);
  r6.xyz = r6.xyz * r5.zzz;
  r7.xy = cmp(float2(0,0) < r5.xy);
  if (r7.x != 0) {
    r7.xz = cb12[86].xy * v0.xy;
    r7.xz = r7.xz * cb0[2].xy + cb0[2].zw;
    r7.zw = cb12[85].xy * r7.xz;
    r5.z = cmp(r7.x >= 0.5);
    r7.x = r5.z ? 1.000000 : 0;
    r7.x = cb12[86].z * r7.x;
    r8.x = 0.5 * r7.x;
    r5.z = r5.z ? 2 : 1;
    r5.z = cb12[86].z * r5.z;
    r9.x = 0.5 * r5.z;
    r8.y = 0;
    r7.xz = max(r8.xy, r7.zw);
    r9.y = cb12[85].y;
    r7.xz = min(r9.xy, r7.xz);
    r8.xyzw = t14.Sample(s14_s, r7.xz).xyzw;
  } else {
    r8.xyzw = float4(1,1,1,1);
  }
  r5.z = saturate(dot(r6.xyz, cb2[0].xyz));
  r7.xzw = cb2[13].xyz * r5.zzz;
  if (r7.y != 0) {
    r9.xyz = r7.xzw;
    r5.z = 0;
    while (true) {
      r7.y = cmp(r5.z >= r5.y);
      if (r7.y != 0) break;
      r7.y = cmp(r5.z < r5.x);
      if (r7.y != 0) {
        r7.y = (uint)r5.z;
        r7.y = dot(cb2[14].xyzw, icb[r7.y+0].xyzw);
        r7.y = min(3, r7.y);
        r7.y = (uint)r7.y;
        r7.y = dot(r8.xyzw, icb[r7.y+0].xyzw);
      } else {
        r7.y = 1;
      }
      r9.w = r1.x * r5.y + r5.z;
      r9.w = (int)r9.w;
      r10.xyz = cb2[r9.w+27].xyz + -v2.xyz;
      r9.w = (int)r5.z;
      r10.w = dot(r10.xyz, r10.xyz);
      r11.x = sqrt(r10.w);
      r11.x = saturate(r11.x / cb2[r9.w+27].w);
      r11.x = -r11.x * r11.x + 1;
      r11.yzw = cb2[r9.w+41].xyz * r7.yyy;
      r7.y = rsqrt(r10.w);
      r10.xyz = r10.xyz * r7.yyy;
      r7.y = saturate(dot(r6.xyz, r10.xyz));
      r10.xyz = r11.yzw * r7.yyy;
      r9.xyz = r10.xyz * r11.xxx + r9.xyz;
      r5.z = 1 + r5.z;
    }
    r7.xzw = r9.xyz;
  }
  r6.w = 1;
  r5.x = dot(cb2[23].xyzw, r6.xyzw);
  r5.y = dot(cb2[24].xyzw, r6.xyzw);
  r5.z = dot(cb2[25].xyzw, r6.xyzw);
  r5.xyz = cb2[16].yzw + r5.xyz;
  r5.xyz = r5.xyz + r7.xzw;
  r5.xyz = cb1[8].yzw * cb1[8].xxx + r5.xyz;
  r3.xyz = r5.xyz * r3.xyz;
  r5.xyz = v10.xyz * r3.xyz;
  r7.x = dot(cb12[r0.x+24].xyzw, r2.xyzw);
  r7.y = dot(cb12[r0.x+25].xyzw, r2.xyzw);
  r1.x = dot(cb12[r0.x+27].xyzw, r2.xyzw);
  r2.xy = r7.xy / r1.xx;
  r4.w = 1;
  r7.x = dot(cb12[r0.x+32].xyzw, r4.xyzw);
  r7.y = dot(cb12[r0.x+33].xyzw, r4.xyzw);
  r0.x = dot(cb12[r0.x+35].xyzw, r4.xyzw);
  r2.zw = r7.xy / r0.xx;
  r2.xy = r2.xy + -r2.zw;
  r2.xy = float2(-0.5,0.5) * r2.xy;
  r0.x = saturate(dot(r6.xyz, r0.yzw));
  r0.x = 1 + -r0.x;
  r0.x = log2(r0.x);
  r0.x = cb2[26].w * r0.x;
  r0.x = exp2(r0.x);
  r6.w = 0.150000006;
  r4.x = saturate(dot(cb2[23].xyzw, r6.xyzw));
  r4.y = saturate(dot(cb2[24].xyzw, r6.xyzw));
  r4.z = saturate(dot(cb2[25].xyzw, r6.xyzw));
  r0.yzw = cb2[26].xyz * r4.xyz;
  r3.xyz = -r3.xyz * v10.xyz + v11.xyz;
  r3.xyz = v11.www * r3.xyz + r5.xyz;
  r3.xyz = -r3.xyz * cb0[0].www + r5.xyz;
  r3.xyz = r3.xyz * cb12[84].yyy + cb0[1].xxx;
  r3.xyz = min(r5.xyz, r3.xyz);
  r0.xyz = r0.yzw * r0.xxx + r3.xyz;
  r3.xyz = v11.xyz + -r0.xyz;
  r3.xyz = v11.www * r3.xyz + r0.xyz;
  r3.xyz = -r3.xyz * cb0[0].www + r0.xyz;
  r4.xyz = cb12[84].yyy * r3.xyz;
  r3.xyz = r3.xyz * cb12[84].yyy + cb0[1].zzz;
  r0.xyz = min(r3.xyz, r0.xyz);
  r0.w = cb2[15].z * r3.w;
  o0.w = v10.w * r0.w;
  o0.xyz = -r4.xyz * cb12[84].zzz + r0.xyz;
  r0.x = cmp(9.99999975e-006 < cb2[19].z);
  o1.xy = r0.xx ? float2(1,0) : r2.xy;
  r0.x = dot(v7.xyz, r1.yzw);
  r0.y = dot(v8.xyz, r1.yzw);
  r0.z = dot(v9.xyz, r1.yzw);
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.w = -9.99999975e-006 + cb2[19].x;
  r1.x = cb2[19].y + -r0.w;
  r0.w = r5.w + -r0.w;
  r1.x = 1 / r1.x;
  r0.w = saturate(r1.x * r0.w);
  r1.x = r0.w * -2 + 3;
  r0.w = r0.w * r0.w;
  r0.w = r1.x * r0.w;
  o2.w = cb2[19].w * r0.w;
  r0.z = r0.z * -8 + 8;
  r0.z = sqrt(r0.z);
  r0.z = max(0.00100000005, r0.z);
  r0.xy = r0.xy / r0.zz;
  o2.xy = float2(0.5,0.5) + r0.xy;
  o1.zw = float2(0,1);
  o2.z = 0;
  return;
}