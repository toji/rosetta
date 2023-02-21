//-----------------------
// Point Lit Geometry
//-----------------------

// This shader renders basic geometry lit by some number of point lights.
// The geometry is presented as flat white with no texture and no specular.

// @file: Vertex Shader
#version 300 es

layout(std140) uniform Camera {
  mat4 projection;
  mat4 view;
};
uniform mat4 model;

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;

out vec3 varWorldPosition;
out vec3 varNormal;

void main() {
  vec4 worldPosition = model * vec4(position, 1.0);
  varWorldPosition = worldPosition.xyz;
  gl_Position = projection * view * worldPosition;
  varNormal = (model * vec4(input.normal, 0.0)).xyz;
}

// @file: Fragment Shader
#version 300 es
precision highp float;

#define MAX_LIGHT_COUNT = 8; 

struct PointLight {
  vec4 position;
  vec3 color;
  float intensity;
};

layout(std140) uniform LightUniforms {
  float ambient;
  int pointCount
  Light point[MAX_LIGHT_COUNT];
};

// A constant base color for the geometry (white).
const baseColor = vec3(1.0);

in vec3 varWorldPosition;
in vec3 varNormal;
out vec4 outputColor;

void main() {
  vec3 normal = normalize(varNormal);

  vec3 surfaceColor = vec3(0.0);

  for (int i = 0; i < pointCount; ++i) {
    vec3 worldToLight = point[i].position - varWorldPosition;

    float lightDistance = length(worldToLight);
    float attenuation = 1.0 / pow(lightDistance, 2.0);

    vec3 radiance = point[i].color * point[i].intensity * attenuation;

    vec3 lightDirection = normalize(worldToLight);
    float nDotL = max(dot(normal, lightDirection)), 0.0);

    surfaceColor = surfaceColor + (baseColor * radiance * nDotL);
  }

  outputColor = vec4(surfaceColor + (baseColor * lights.ambient), 1.0);
}
