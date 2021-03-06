#version 300 es

precision mediump float;

uniform mat4 matrix;
uniform float time;

layout(location = 1) in vec4 vertex_position;
layout(location = 2) in vec4 vertex_color;
layout(location = 3) in vec2 vertex_uv;

out vec2 uv;
out vec4 color;

#define MESH_FIXUP vec4(-0.5, -0.5, -0.5, 0.0)

void main(void)
{
    vec4 pos = (vertex_position + MESH_FIXUP) * vec4(0.75, 0.75, 0.75, 1.0);

    // Rotation
    float pz = pos.z * cos(time) - pos.y * sin(time);
    float py = pos.z * sin(time) + pos.y * cos(time);
    pos.z = pz;
    pos.y = py;

    // Translate
    pos.z += 1.0;

    // Projection
    pos.x /= pos.z;
    pos.y /= pos.z;

    // Output
    gl_Position = pos;
    uv = vertex_uv;
    color = vertex_color;
}
