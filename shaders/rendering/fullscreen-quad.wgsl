//-----------------------
// Fullscreen Quad
//-----------------------

// This shader renders a quad that covers the entire viewport with a given
// texture. It defines the geometry needed in the shader so that no vertex or
// index buffers need to be bound.

// In order to render with minimal geometry a singled triangle is defined that
// is large enough to fully cover the viewport.
var<private> verts : array<vec2f, 3> = array<vec2f, 3>(
  vec2f(-1, -1),
  vec2f(-1, 3),
  vec2f(3, -1)
);

struct VertexOutput {
  @builtin(position) position : vec4f,
  @location(0) texcoord : vec2f,
};

@vertex
fn vertexMain(@builtin(vertex_index) vertexIndex : u32) -> VertexOutput {
  var output : VertexOutput;

  output.position = vec4f(verts[vertexIndex], 1, 1);
  output.texcoord = output.position.xy * 0.5 + 0.5;
  // WebGPU texture coords have an inverted Y axis compared to WebGL.
  output.texcoord.y *= -1.0; 

  return output;
}

@group(0) @binding(0) var fullscreenSampler : sampler;
@group(0) @binding(1) var fullscreenTexture : texture_2d<f32>;

// For demonstration purposes a simple fragment shader is provided which returns
// a texture color, but the above vertex shader can be used for many different
// "fullscreen" effects.
@fragment
fn fragmentMain(@location(0) texcoord : vec2f) -> @location(0) vec4f {
  return textureSample(fullscreenTexture, fullscreenSampler, texcoord);
}
