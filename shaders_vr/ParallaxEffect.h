float2 GetParallaxCoords(float2 coords, float3 viewDir, float3 bitangent, float3 tangent, float3 normal)
{
  float3x3 modelTangentMatrix = transpose(float3x3(bitangent, tangent, normal));
  float4 tangentViewDir;
  tangentViewDir.x = dot(modelTangentMatrix[0].xyz, viewDir.xyz);
  tangentViewDir.y = dot(modelTangentMatrix[1].xyz, viewDir.xyz);
  tangentViewDir.z = dot(modelTangentMatrix[2].xyz, viewDir.xyz);
  tangentViewDir.w = dot(tangentViewDir.xyz, tangentViewDir.xyz);
  tangentViewDir.w = rsqrt(tangentViewDir.w);
  tangentViewDir.xyz = tangentViewDir.xyz * tangentViewDir.www; 

  float height = TexHeightSampler.Sample(HeightSampler, coords.xy).x;
  height = height * 0.0800 + -0.0400;
  float2 output = tangentViewDir.xy * height.xx + coords.xy;
  
  return output;
}

float2 GetParallaxCoordsMTLand(float2 coords, float3 viewDir, float3 bitangent, float3 tangent, float3 normal, float height)
{
  float3x3 modelTangentMatrix = transpose(float3x3(bitangent, tangent, normal));
  float4 tangentViewDir;
  tangentViewDir.x = dot(modelTangentMatrix[0].xyz, viewDir.xyz);
  tangentViewDir.y = dot(modelTangentMatrix[1].xyz, viewDir.xyz);
  tangentViewDir.z = dot(modelTangentMatrix[2].xyz, viewDir.xyz);
  tangentViewDir.w = dot(tangentViewDir.xyz, tangentViewDir.xyz);
  tangentViewDir.w = rsqrt(tangentViewDir.w);
  tangentViewDir.xyz = tangentViewDir.xyz * tangentViewDir.www; 

  float height2 = height * 0.0800 + -0.0400;
  float2 output = tangentViewDir.xy * height2.xx + coords.xy;
  
  return output;
}