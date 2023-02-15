//-----------------------
// Textured Geometry
//-----------------------

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

void main() {
  varTexcoord = texcoord;
  gl_Position = projection * view * model * vec4(position, 1.0);
}

// ----- Fragment Shader -----
#version 300 es
precision highp float;

in vec2 varTexcoord;

uniform sampler2D baseColorTexture;

out vec4 outputColor;
void main() {
  outputColor = texture(baseColorTexture, varTexcoord);
}