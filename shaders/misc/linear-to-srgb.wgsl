// Converts a linear color to sRGB
fn linearTosRGB(linear : vec3f) -> vec3f {
  if (all(linear <= vec3(0.0031308))) {
    return linear * 12.92;
  }
  return (pow(abs(linear), vec3(1.0/2.4)) * 1.055) - vec3(0.055);
}

// A faster approximated version that's good enough for many cases.
fn linearTosRGBApprox(linear : vec3f) -> vec3f {
  return pow(linear, vec3(1.0/2.2));
}
