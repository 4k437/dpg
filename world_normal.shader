shader_type spatial;
render_mode specular_disabled, diffuse_lambert;

void fragment() {
	vec3 world_normal = vec3(1f) * mat3(CAMERA_MATRIX) * VIEW;
	vec3 display_color = clamp((world_normal + 1f) / 2f, 0f, 1f);
	
	ALBEDO = display_color;
}