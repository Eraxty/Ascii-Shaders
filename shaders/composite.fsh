#version 330 compatibility

uniform sampler2D colortex0;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main()
{
    float size = 0.003;

    vec2 uv = floor(texcoord / size) * size;

    vec4 c = texture(colortex0, uv);

    float brightness =
        dot(c.rgb, vec3(0.299, 0.587, 0.114));

    vec2 local =
        fract(texcoord / size);

    float glyph = 0.0;

    if (brightness > 0.8)
    {
        if (length(local - vec2(0.5)) < 0.45)
            glyph = 1.0;
    }
    else if (brightness > 0.6)
    {
        if (length(local - vec2(0.5)) < 0.35)
            glyph = 1.0;
    }
    else if (brightness > 0.4)
    {
        if (length(local - vec2(0.5)) < 0.25)
            glyph = 1.0;
    }
    else if (brightness > 0.2)
    {
        if (length(local - vec2(0.5)) < 0.15)
            glyph = 1.0;
    }

    color = vec4(vec3(glyph), 1.0);
}