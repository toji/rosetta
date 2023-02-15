#version 300 es

//-----------------------
// Textures and Samplers
//-----------------------

// Even though textures and samplers are separate in WebGL 2/OpenGL ES 3, they
// are associated in the application and still exposed to the shader as a single
// sampler object.
uniform sampler2D baseColorTexture;

vec4 getBaseColor(vec2 texCoord) {
  // The texture() function is used for sampling, rather than texture2D as used
  // in older GLSL shaders.
  return texture(baseColorTexture, texCoord);
}

// Cube maps use a separate texture type
uniform samplerCube skybox;

vec4 getSkyboxColor(vec3 texCoord) {
  // The texture() has overloads to handle the different texture types.
  return texture(baseColorTexture, texCoord);
}
