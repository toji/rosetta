//-----------------------
// Textured Geometry
//-----------------------

cbuffer Camera : register(b0) {
    float4x4 projection;
    float4x4 view;
    float4x4 model;
};

struct VertexInput {
    float4 position : POSITION;
    float2 texcoord : TEXCOORD0;
};

struct VertexOutput {
    float4 position : SV_POSITION;
    float2 texcoord : TEXCOORD0;
};

// The vertex shader transforms the geometry positions by the
// model/view/projection matrices, and passes the texture coordinate along
// unchanged
VertexOutput vertexMain(VertexInput input) {
    VertexOutput output;

    output.position = float4(input.position, 1.0f);
    output.position = mul(output.position, model);
    output.position = mul(output.position, view);
    output.position = mul(output.position, projection);

    output.texcoord = input.texcoord;

    return output;
}

SamplerState baseColorSampler : register(s0);
Texture2D baseColorTexture : register(t0);

// The fragment shader returns the texture color at the texture coordinate
// passed from the vertex shader.
float4 fragmentMain(VertexOutput input) : SV_TARGET {
    return baseColorTexture.Sample(baseColorSampler, input.texcoord);
}
