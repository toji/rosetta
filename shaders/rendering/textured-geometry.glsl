//-----------------------
// Textured Geometry
//-----------------------

// ----- Vertex Shader -----
uniform mat4 projection;
uniform mat4 view;
uniform mat4 model;

attribute vec3 position;
attribute vec3 texcoord;

varying vec2 varTexcoord;

void main() {
  varTexcoord = texcoord;
  gl_Position = projection * view * model * vec4(position, 1.0);
}

// ----- Fragment Shader -----
precision highp float;

varying vec2 varTexcoord;

uniform sampler2D baseColorTexture;

void main() {
  gl_FragColor = texture2D(baseColorTexture, varTexcoord);
}