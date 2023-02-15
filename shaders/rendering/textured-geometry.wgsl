//-----------------------
// Textured Geometry
//-----------------------

struct Camera {
  projection : mat4x4f,
  view : mat4x4f
};
@group(0) @binding(0) var<uniform> camera : Camera;
@group(1) @binding(0) var<uniform> model : mat4x4f;

struct VertexInput {
  @location(0) position : vec3f,
  @location(1) texcoord : vec2f,
};

struct VertexOutput {
  @builtin(position) position : vec4f,
  @location(0) texcoord : vec2f,
};

@vertex
fn vertexMain(input : VertexInput) -> VertexOutput {
  var output : VertexOutput;

  output.position = camera.projection * camera.view * model * vec4(input.position, 1.0);
  output.texcoord = input.texcoord;

  return output;
}

@group(2) @binding(0) var baseColorSampler : sampler;
@group(2) @binding(1) var baseColorTexture : texture_2d<f32>;

@fragment
fn fragmentMain(input : VertexOutput) -> @location(0) vec4f {
  return textureSample(baseColorTexture, baseColorSampler, input.texcoord);
}