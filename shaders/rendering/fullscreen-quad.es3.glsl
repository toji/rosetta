//-----------------------
// Fullscreen Quad
//-----------------------

// This shader renders a quad that covers the entire viewport with a given
// texture. It defines the geometry needed in the shader so that no vertex or
// index buffers need to be bound.

// @file: Vertex Shader
#version 300 es

out vec2 varTexcoord;

// The vertex shader transforms the geometry positions by the
// model/view/projection matrices, and passes the texture coordinate along
// unchanged
void main() {
  // In order to render with minimal geometry a singled triangle is defined that
  // is large enough to fully cover the viewport.
  const vec2 verts[3] = vec2[](
    vec2(-1, -1),
    vec2(-1, 3),
    vec2(3, -1)
  );

  gl_Position = vec4(verts[gl_VertexID], 1, 1);
  varTexcoord = gl_Position.xy * 0.5 + vec2(0.5);
}

// @file: Fragment Shader
#version 300 es
precision highp float;

uniform sampler2D fullscreenTexture;

in vec2 varTexcoord;
out vec4 outputColor;

// For demonstration purposes a simple fragment shader is provided which returns
// a texture color, but the above vertex shader can be used for many different
// "fullscreen" effects.
void main() {
  outputColor = texture(fullscreenTexture, varTexcoord);
}