//-----------------------
// Basic Uniforms
//-----------------------

// Each uniform must be individually set with uniformMatrix4fv() or similar,
// with an index queried by uniform name in the application.
uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform vec3 cameraPosition;
uniform mat4 modelMatrix;

vec4 transformPosition(vec4 postion) {
  mat4 viewProjectionMatrix = projectionMatrix * viewMatrix;

  mat4 modelViewProjectionMatrix = viewProjectionMatrix * modelMatrix;

  return modelViewProjectionMatrix * position;
}

//-----------------------
// Textures and Samplers
//-----------------------

uniform vec4 baseColorFactor;

uniform sampler2D baseColorTexture;

vec4 getBaseColor(vec2 texCoord) {
  // Different functions are used depending on what type of sampler object is
  // being sampled. For sampler2D we use texture2D.
  vec4 baseColor = texture2D(baseColorTexture, texCoord);
  return baseColorFactor * baseColor;
}

//-----------------------
// Uniform Arrays
//-----------------------

struct PointLight {
  vec4 position;
  vec4 color;
};

uniform vec3 ambientLight;
uniform PointLight pointLights[8];
