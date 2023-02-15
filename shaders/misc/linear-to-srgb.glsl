// Converts a linear color to sRGB
vec3 linearTosRGB(vec3 linear) {
  if (all(linear <= vec3(0.0031308))) {
    return linear * 12.92;
  }
  return (pow(abs(linear), vec3(1.0/2.4)) * 1.055) - vec3(0.055);
}

// A faster approximated version that's good enough for many cases.
vec3 linearTosRGBApprox(vec3 linear) {
  return pow(linear, vec3(1.0/2.2));
}
