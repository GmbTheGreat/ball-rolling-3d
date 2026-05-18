shader_type spatial;
render_mode unshaded, cull_back;

uniform vec4 WATER_COL : source_color = vec4(0.04, 0.38, 0.88, 1.0);
uniform vec4 WATER2_COL : source_color = vec4(0.08, 0.50, 0.95, 1.0);
uniform vec4 FOAM_COL : source_color = vec4(0.8125, 0.9609, 0.9648, 1.0);

uniform float wave_speed = 0.12;
uniform float wave_scale = 8.0;
uniform float foam_density = 10.0;
uniform float foam_strength = 0.3;

void fragment()
{
	vec2 uv = UV * wave_scale;

	float wave1 = sin(uv.x + TIME * wave_speed);
	float wave2 = cos(uv.y + TIME * wave_speed * 0.8);

	float mix_val = (wave1 + wave2) * 0.5;
	mix_val = mix_val * 0.5 + 0.5;
	mix_val = mix(0.35, 1.0, mix_val);

	vec3 water_col = mix(WATER_COL.rgb, WATER2_COL.rgb, mix_val);

	// bold distant foam streaks
	float foam1 = sin(uv.x * foam_density + TIME * 0.25);
	float foam2 = sin((uv.x + uv.y * 0.2) * foam_density * 0.5 + TIME * 0.18);

	float foam = smoothstep(0.82, 1.0, foam1) * 0.8;
	foam += smoothstep(0.85, 1.0, foam2) * 0.6;

	foam = clamp(foam * foam_strength, 0.0, 1.0);

	ALBEDO = mix(water_col, FOAM_COL.rgb, foam);
}