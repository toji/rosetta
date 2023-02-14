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
