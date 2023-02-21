//-----------------------
// Point Lit Geometry
//-----------------------

// This shader renders basic geometry lit by some number of point lights.
// The geometry is presented as flat white with no texture and no specular.

struct Camera {
  projection : mat4x4f,
  view : mat4x4f
};
@group(0) @binding(0) var<uniform> camera : Camera;
@group(1) @binding(0) var<uniform> model : mat4x4f;

struct VertexInput {
  @location(0) position : vec3f,
  @location(1) normal : vec3f,
};

struct VertexOutput {
  @builtin(position) position : vec4f,
  @location(0) worldPosition : vec3f,
  @location(1) normal : vec3f,
};

@vertex
fn vertexMain(input : VertexInput) -> VertexOutput {
  var output : VertexOutput;

  let worldPosition = model * vec4(input.position, 1.0);
  output.worldPosition = worldPosition.xyz;
  output.position = camera.projection * camera.view * worldPosition;
  output.normal = (model * vec4(input.normal, 0.0)).xyz;

  return output;
}

struct PointLight {
  position : vec3f;
  color : vec3f;
  intensity : f32;
};

// Arrays are allowed to be "runtime-sized" if they're the last element in a
// storage struct, so we don't have to put a cap on the maximum number of lights
// here.
struct LightUniforms {
  ambient : vec3f;
  pointCount : u32;
  point : array<Light>;
};
@group(0) @binding(2) var<storage> lights : LightUniforms;

// A constant base color for the geometry (white).
const baseColor = vec3(1.0);

@fragment
fn fragmentMain(input : VertexOutput) -> @location(0) vec4f {
  let normal = normalize(input.normal);

  var surfaceColor = vec3(0.0);

  for (var i = 0u; i < lights.pointCount; i = i + 1u) {
    let worldToLight = lights.point[i].position - input.worldPosition;

    let lightDistance = length(worldToLight);
    let attenuation = 1.0 / pow(lightDistance, 2.0);

    let radiance = lights.point[i].color * lights.point[i].intensity * attenuation;

    let lightDirection = normalize(worldToLight);
    let nDotL = max(dot(normal, lightDirection)), 0.0);

    surfaceColor = surfaceColor + (baseColor * radiance * nDotL);
  }

  return vec4(surfaceColor + (baseColor * lights.ambient), 1.0);
}
