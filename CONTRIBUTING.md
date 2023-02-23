# Contributing

Either new shader snippets or translations of existing snippets to new shading languages are very welcome!

This shaders on this page are maintained as part of the [Rosetta GitHub repo](https://github.com/toji/rosetta/).
Changed made to the repository are automatically reflected on the site.

## Guidelines

**Please read this section carefully before submitting any shaders to the site!**

It is expected that shaders submitted to the site will use idiomatic patterns for the shading language, and represent any best practices that may apply where reasonable.

It is preferred to have at least two shading languages represented for any given shader, with strong preference given to web-facing languages like WGSL and GLSL (since that's what this page was originally created to provide references for). Shaders covering a topic that only applies to a single shading language are allowed, but should be clearly commented to denote which features are unique to the language.

When multiple shading languages are represented some effort should be given to keeping structure, order, and naming consistent across each variant of a shader where it's reasonable to do so and does not disadvantage a given language. This helps developers compare languages. When large differences in structure are necessary please provide comments explaining why.

Shaders are expected to be well commented, especially regarding the topic they are focused on. Providing matching comments across multiple variants of the shader is encouraged, as it helps developers match up corresponding code blocks.

Shaders frequently need well formatted data from the application (uniforms, textures, vertex buffers) to function. If the required inputs are not self evident please include a comment explaining what inputs are expected for the shader to operate correctly.