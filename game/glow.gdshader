shader_type spatial;

void vertex() {
    // Transform the normal to world space
    NORMAL = mat3(modelview_matrix) * NORMAL;
}

void fragment() {
    // Normalize the normal
    vec3 normal = normalize(NORMAL);

    // Set up a directional light direction
    vec3 light_direction = normalize(vec3(1.0, -1.0, -1.0));

    // Calculate the light intensity (dot product of normal and light direction)
    float light_intensity = max(dot(normal, light_direction), 0.0);

    // Set the output color by multiplying the light color and intensity
    COLOR.rgb = vec3(1.0, 1.0, 1.0) * light_intensity;

    // Set full alpha (1.0) for the emitted light
    COLOR.a = 1.0;
}
