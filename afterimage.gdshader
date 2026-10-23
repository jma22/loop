shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(0.4, 0.8, 1.0, 1.0);
uniform float alpha : hint_range(0.0, 1.0) = 0.6;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	// solid light-blue silhouette that fades via the alpha uniform
	COLOR = vec4(tint_color.rgb, tex.a * alpha);
}
