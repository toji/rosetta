//-----------------------
// Textured Geometry
//-----------------------

// @file: Vertex Shader
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

attribute vec3 position;
attribute vec2 texcoord;

varying vec2 varTexcoord;

// The vertex shader transforms the geometry positions by the
// model/view/projection matrices, and passes the texture coordinate along
// unchanged
void main() {
  gl_Position = projection * view * model * vec4(position, 1.0);
  varTexcoord = texcoord;
}

// @file: Fragment Shader
precision highp float;

uniform sampler2D baseColorTexture;

varying vec2 varTexcoord;

// The fragment shader returns the texture color at the texture coordinate
// passed from the vertex shader.
void main() {
  gl_FragColor = texture2D(baseColorTexture, varTexcoord);
}
