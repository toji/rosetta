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

struct Camera {
  projection : mat4x4f,
  view : mat4x4f
};
@group(0) @binding(0) var<uniform> camera : Camera;

struct VertexOutput {
  @builtin(position) position : vec4f,
  @location(0) texcoord : vec3f,
};

@vertex
fn vertexMain(@location(0) position : vec4f) -> VertexOutput {
  var output : VertexOutput;

  // Assuming that the geometry is a unit cube and we're using a cubemap, the
  // texture coordinates are just the vertex positions.
  output.texCoord = position.xyz;

  var modelView = camera.view;
  // Drop the translation portion of the modelView matrix
  modelView[3] = vec4f(0, 0, 0, modelView[3].w);
  output.position = camera.projection * modelView * position;

  // Returning the W component for both Z and W forces the geometry depth to
  // the far plane.
  output.position = output.position.xyww;

  return output;
}

@group(1) @binding(0) var skyboxSampler : sampler;
@group(1) @binding(1) var skyboxTexture : texture_cube<f32>;

@fragment
fn fragmentMain(@location(0) texCoord : vec3f) -> @location(0) vec4f {
  return textureSample(skyboxTexture, skyboxSampler, texCoord);
}