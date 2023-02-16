//-----------------------
// Textured Geometry
//-----------------------

// GLSL requires each entry point (vertex, fragment) to be in separate shaders.
// This file will show them both for easy reference, but in real use they would
// need to be compiled separately.

// ----- Vertex Shader -----
#version 300 es

layout(std140) uniform Camera {
  mat4 projection;
  mat4 view;
};
uniform mat4 model;

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 texcoord;

out vec2 varTexcoord;

// The vertex shader transforms the geometry positions by the
// model/view/projection matrices, and passes the texture coordinate along
// unchanged
void main() {
  gl_Position = projection * view * model * vec4(position, 1.0);
  varTexcoord = texcoord;
}

// ----- Fragment Shader -----
#version 300 es
precision highp float;

uniform sampler2D baseColorTexture;

in vec2 varTexcoord;
out vec4 outputColor;

// The fragment shader returns the texture color at the texture coordinate
// passed from the vertex shader.
void main() {
  outputColor = texture(baseColorTexture, varTexcoord);
}
