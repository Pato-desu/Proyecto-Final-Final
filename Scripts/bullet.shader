shader_type canvas_item;

uniform vec4 new;

void fragment() {
	//vec4 newtest = vec4(0, 1, 0, 1);
	vec4 old = vec4(1, 1, 1, 1);
	float tolerance = 1.5;
	float intensity = 0.8;
	vec4 color = texture(TEXTURE, UV);
	vec3 col = color.rgb;
    vec3 diff = col - old.rgb;
    float m = length(diff);
    col = mix(col, new.rgb, step(m, tolerance) * intensity);
	COLOR = vec4(col.rgb, color.a);
}
