//-----------------------
// Basic Uniforms
//-----------------------

// Most uniforms will be packed into a uniform buffer, the layout of which is
// defined by a struct:
struct FrameUniforms {
  projectionMatrix : mat4x4f,
  viewMatrix : mat4x4f,
  cameraPosition : vec3f,
};
// Bindings are done exclusively by group and binding number.
@group(0) @binding(0) var<uniform> frame : FrameUniforms;

// Individual uniform values can be exposed without a struct, but are still
// passed with a uniform buffer.
@group(1) @binding(0) var<uniform> modelMatrix : mat4x4f;

fn transformPosition(postion : vec4f) -> vec4f {
  // Values within a struct must be accessed by the uniform name first, then the
  // struct value name.
  let viewProjectionMatrix = frame.projectionMatrix * frame.viewMatrix;

  // Individual values can be accessed directly.
  let modelViewProjectionMatrix = viewProjectionMatrix * modelMatrix;

  return modelViewProjectionMatrix * position;
}
