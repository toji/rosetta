//-----------------------
// Textures and Samplers
//-----------------------

// Samplers are bound separately from textures.
@group(0) @binding(0) var baseSampler : sampler;
@group(0) @binding(1) var baseColorTexture : texture_2d<f32>;

fn getBaseColor(texCoord : vec2f) -> vec4f {
  // Textures are sampled with both the texture and sampler.
  return textureSample(baseColorTexture, baseSampler, texCoord);
}

// Cube maps use a separate texture type, but can use the same samplers.
@group(0) @binding(2) var skybox : texture_cube<f32>;

fn getSkyboxColor(texCoord : vec3f) -> vec4f {
  // textureSample() has overloads to handle the different texture types.
  return textureSample(skybox, baseSampler, texCoord);
}