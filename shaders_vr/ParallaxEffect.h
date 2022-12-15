//POM shader based off https://github.com/tgjones/slimshader-cpp/blob/master/src/Shaders/Sdk/Direct3D11/DetailTessellation11/POM.hlsl under MIT
//v1, v6, v3,v4,v5
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
  
  float2 output;
  float distSquared = dot(viewDir.xyz,viewDir.xyz);
  if(distSquared<1000000.0)
  {
	float2 dx = ddx(coords);
	float2 dy = ddy(coords);
	
    int numSteps = (int)(lerp(16,4,tangentViewDir.z)*(8.0-(distSquared*0.000007)));
	
	float currHeight = 0.0;
	float stepSize = 1.0/ (float)numSteps;
	float prevHeight = 1.0;
	
	float2 offsetPerStep = tangentViewDir.xy * float2(0.0800,0.0800) * stepSize.xx;
	float2 currentOffset = tangentViewDir.xy * float2(0.0400,0.0400) + coords.xy;
	float currentBound = 1.0;
	float parallaxAmount = 0.0;
	
	float2 pt1 = 0;
	float2 pt2 = 0;
	
	while(numSteps>0)
	{
		currentOffset -= offsetPerStep;
		
		currHeight = t3.SampleGrad(s3_s, currentOffset,dx,dy).x;
		
		currentBound -= stepSize;
		if(currHeight>currentBound)
		{
			pt1 = float2(currentBound, currHeight);
			pt2 = float2(currentBound + stepSize, prevHeight);
			
			break;
		}
		else
		{
			numSteps-=1;
			prevHeight=currHeight;
		}
	}
	
	float delta2 = pt2.x - pt2.y;
	float delta1 = pt1.x - pt1.y;
	float denominator = delta2-delta1;
	
	if(denominator==0.0){
		parallaxAmount=0.0;
	}
	else{
		parallaxAmount = (pt1.x * delta2 - pt2.x * delta1) / denominator;
	}
	
	float offset3 = (1.0 - parallaxAmount) * -0.0800 + 0.0400;
	output = tangentViewDir.xy * offset3.xx + coords.xy;
  }
  else{
    float height = t3.Sample(s3_s, coords.xy).x;
    height = height * 0.0800 - 0.0400;
    output = tangentViewDir.xy * height.xx + coords.xy;
  }
  
  return output;
}