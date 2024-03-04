//
//  GlassEffect.metal
//  GlassEffect
//
//  Created by Maciek Czarnik on 28/02/2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>

using namespace metal;

constexpr sampler s(address::repeat, filter::bicubic);

uint2 getResolution(texture2d<half> t) {
  return (t.get_width(), t.get_height());
}

float2 texturePosition(float2 position, texture2d<half> texture) {
  uint2 textureResolution = getResolution(texture);
  return position / float2(textureResolution);
}

float fresnel(
  half3 eye,
  half3 normal,
  half power
) {
  half fresnelFactor = max(half(0.), dot(eye, normal));
  half inverseFresnelFactor = 1.0 - fresnelFactor;

  return pow(inverseFresnelFactor, power);
}

[[ stitchable ]] half4 glassEffect(
  float2 position,
  SwiftUI::Layer layer,
  texture2d<half> normalMap,
  float distance,
  half4 baseColor,
  float transparencyFactor,
  float reflectionFactor,
  float2 lightPosition,
  float detailFactor
) {
  half3 incident = normalize(half3(0, 0, 1));
  half3 eye = -incident;
  half3 light = half3(half2(lightPosition), -1);
  
  float2 normalPosition = texturePosition(position, normalMap);
  half3 normal = normalize((normalMap.sample(s, normalPosition) - 0.5).xyz);
  normal.z *= -1;
  
  half fresnelFactor = fresnel(eye, normal, 0.5);
  
  half3 refraction = refract(incident, normal, 1 / 1.49);
  half4 refractedLayerColor = layer.sample(position + float2(refraction.xy * refraction.z) * distance);
  refractedLayerColor.xyz *= 1 - fresnelFactor;
  
  half3 eyeLight = eye + light;
  half3 eyeLightHalf = eyeLight / length(eyeLight);
  half k = pow(max(half(0.), dot(normal, eyeLightHalf)), half(1000.));
  half E = max(half(0.), dot(normal, light));
  half3 lightReflectionColor = fresnelFactor * k * E * reflectionFactor;

  half3 detail = reflect(incident, normal);
  half3 detailColor = half3(detail.x * detail.y * detail.z) * detailFactor;
  
  return mix(
    baseColor,
    refractedLayerColor,
    transparencyFactor
  )
  + half4(lightReflectionColor + detailColor, 0);
}
