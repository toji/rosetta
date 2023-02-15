//-----------------------
// Textures and Samplers
//-----------------------

uniform sampler2D baseColorTexture;

vec4 getBaseColor(vec2 texCoord) {
  // Different functions are used depending on what type of sampler object is
  // being sampled. For sampler2D we use texture2D().
  return texture2D(baseColorTexture, texCoord);
}

uniform samplerCube skybox;

vec4 getSkyboxColor(vec3 texCoord) {
  // For samplerCube textures the textureCube() function is used.
  return textureCube(baseColorTexture, texCoord);
}