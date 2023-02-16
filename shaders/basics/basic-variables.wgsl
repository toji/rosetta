//-----------------------
// Basic Variables
//-----------------------

// const values can be declared outside of functions, and must be set from
// constant expressions.
const PI = 3.14159;

fn variableUsage() {
  // Values which can be modified after definition are declared with `var`.
  var position = vec3(1.0, 2.0, 3.0);
  position.x = 4.0;

  // Values which cannot be modified after definition are declared with `let`.
  let gamma = 2.2;

  // Values cannot change type after declaration, even if they are mutable.
  // position = 1.0; // ERROR! Reassignment of type.

  // Value types are given after the name.
  var normal : vec3f;
  normal = vec3(0.0, 0.0, 1.0);

  // But the type can be implied in most cases from the value being assigned.
  var texCoord = vec2(1.0, 1.0); // texCoord is a vec2f.

  // Vector and matrix types have a template type which can be declared
  // explicitly, but can also be implied from the given value in many cases.
  // Additionally all vectors matrices have built-in aliases which can be used
  // as shorthand in cases where the full type needs to be declared.

  // All of the following are equivalent.
  let a0 : vec3<f32> = vec3<f32>(0.0, 0.0, 0.0);
  let a1 : vec3f = vec3f(0.0, 0.0, 0.0);
  let a2 : vec3f = vec3(0.0, 0.0, 0.0);
  let a3 = vec3(0.0, 0.0, 0.0);
  let a4 = vec3(0.0);
}

fn variableTypes() {
  // There are float, unsigned int, and signed int types.
  var n0 : f32 = 1.0; // 32 bit float
  var n1 : u32 = 1u; // 32 bit unsigned int
  var n1 : i32 = -1; // 32 bit signed int

  // Vectors have 2, 3, or 4 elements of one of the above types.
  // The full definition uses templates to declare the type:
  var uv4 : vec4<u32> = vec4<u32>(1u, 2u, 3u, 4u);

  // But it's frequently easier to use the built-in aliases and type inferrence:
  var v0 : vec2f;
  var v1 : vec4u = vec4u(1u, 2u, 3u, 4u);
  var v2 = vec3i(1, -2, 3);
  var v3 = vec2(1u, 2u); // vec2<u32> 

  // Matrices have 2, 3, or 4 rows and columns of one of the above types.
  // Again, the full definition uses templates to declare the type:
  var fm4 : matrix4x4<f32> = mat4x4<f32>(1.0, 0.0, 0.0, 0.0,
                                         0.0, 1.0, 0.0, 0.0,
                                         0.0, 0.0, 1.0, 0.0,
                                         0.0, 0.0, 0.0, 1.0);

  // But again, it's frequently easier to use the built-in-aliases.
  var m0 : mat2x2f;
  var m1 : mat3x2u = mat3x2u();
  var m2 : mat3x3i = mat3x3<i32>();
  var m3 = mat4x4f();
}