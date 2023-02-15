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
