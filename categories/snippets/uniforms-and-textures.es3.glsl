#version 300 es

//-----------------------
// Basic Uniforms
//-----------------------

// Uniform buffer objects pack multiple uniforms into a single buffer, which
// is given a layout within the shader. The buffer is set with a combination of
// uniformBlockBinding and bindBufferBase in the application. The uniform
// binding indices are associated with the struct by name in the application.
layout(std140) uniform FrameUniforms {
  mat4 projectionMatrix;
  mat4 viewMatrix;
  vec3 cameraPosition;
};

// Individual uniforms may still be set with uniformMatrix4fv() or similar.
uniform mat4 modelMatrix;

vec4 transformPosition(vec4 postion) {
  // Values within a struct are still accessed directly by name.
  mat4 viewProjectionMatrix = projectionMatrix * viewMatrix;

  // Individual values are also accessed directly by name.
  mat4 modelViewProjectionMatrix = viewProjectionMatrix * modelMatrix;

  return modelViewProjectionMatrix * position;
}

//-----------------------
// Textures and Samplers
//-----------------------

layout(std140) uniform MaterialUniforms {
  vec4 baseColorFactor;
};

// Even though textures and samplers are separate in WebGL 2/OpenGL ES 3, they
// are associated in the application and still exposed to the shader as a single
// sampler object.
uniform sampler2D baseColorTexture;

vec4 getBaseColor(vec2 texCoord) {
  // The texture() function is used for sampling, which figures out the type of
  // sample that's required based on the texture being passed.
  vec4 baseColor = texture(baseColorTexture, texCoord);
  return baseColorFactor * baseColor;
}

//-----------------------
// Uniform Arrays
//-----------------------

struct PointLight {
  vec4 position;
  vec4 color;
};

layout(std140) uniform LightUniforms {
  vec3 ambientLight;
  PointLight pointLights[8];
}