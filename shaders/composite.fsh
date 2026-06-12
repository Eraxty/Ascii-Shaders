#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D asciiAtlas;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main()
{
    float cellSize = 0.009;

    vec2 cellUV =
        floor(texcoord / cellSize) * cellSize;

    vec3 scene =
        texture(colortex0, cellUV).rgb;

    float brightness =
        dot(scene, vec3(0.299, 0.587, 0.114));

    float index =
        floor(brightness * 90.0);

    float atlasX =
        mod(index, 16.0);

    float atlasY =
        floor(index / 16.0);

    vec2 local =
        fract(texcoord / cellSize);

    vec2 atlasUV =
        (vec2(atlasX, atlasY) + local)
        / vec2(16.0, 6.0);

    float glyph =
        texture(asciiAtlas, atlasUV).r;

    vec3 finalColor =
        scene * (0.15 + glyph * 0.85);

    float gray =
        dot(finalColor, vec3(0.299, 0.587, 0.114));

    finalColor =
        mix(vec3(gray), finalColor, 1);

    finalColor =
        pow(finalColor, vec3(0.8));

    color =
        vec4(finalColor, 1.0);
}