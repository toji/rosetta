//-----------------------
// Skybox
//-----------------------

// This shader renders a cubemap skybox that's infinitely far away in the
// background. It achieves the effect by dropping any translation and forcing
// the geometry depth to the far plane. When combined with a depth func of
// "less-equal" this causes the skybox to write to any depth fragment that has
// not been written to yet. This ensures that there will be no clipping against
// other geometry and, if the skybox is rendered last, prevents any overdraw.

// Shader is intended to be called with a vertex buffer containing a cube that
// extends from [-1, -1, -1] to [1, 1, 1].

// @file: Vertex Shader
#version 300 es

layout(std140) uniform Camera {
  mat4 projection;
  mat4 view;
};
uniform mat4 model;

layout(location = 0) in vec4 position;

out vec3 varTexcoord;

void main() {
  // Assuming that the geometry is a unit cube and we're using a cubemap, the
  // texture coordinates are just the vertex positions.
  varTexcoord = position.xyz;

  mat4 modelView = view;
  // Drop the translation portion of the modelView matrix
  modelView[3] = vec4(0, 0, 0, modelView[3].w);
  gl_Position = projection * modelView * worldPosition;

  // Returning the W component for both Z and W forces the geometry depth to
  // the far plane.
  gl_Position = gl_Position.xyww;
}

// @file: Fragment Shader
#version 300 es
precision highp float;

uniform samplerCube skyboxTexture;

in vec3 varTexcoord;
out vec4 outputColor;

void main() {
  outputColor = texture(skyboxTexture, varTexcoord);
}