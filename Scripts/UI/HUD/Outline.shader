shader_type canvas_item;

uniform bool modulate = false;
uniform bool corners = true;
uniform bool rounded_corners = true;
uniform float width : hint_range(0.0, 16.0) = 1.0;
uniform vec4 outline_color : hint_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment(){
	vec4 sprite_color = texture(TEXTURE, UV);
	vec4 color = sprite_color;
	if(sprite_color.a == 0.0){
		float size_x = width/float(textureSize(TEXTURE, 0).x);
		float size_y = width/float(textureSize(TEXTURE, 0).y);
		if(texture(TEXTURE, UV + vec2(size_x, 0)).a != 0.0 
		|| texture(TEXTURE, UV + vec2(size_x, 0)).a != 0.0
		|| texture(TEXTURE, UV + vec2(-size_x, 0)).a != 0.0
		|| texture(TEXTURE, UV + vec2(0, size_y)).a != 0.0
		|| texture(TEXTURE, UV + vec2(0, -size_y)).a != 0.0){
			if (!modulate) color = outline_color / MODULATE;
			else color = outline_color;
		}
		else if (corners){
			if (rounded_corners){
				size_x *= 0.7;
				size_y *= 0.7;
			}
			if(texture(TEXTURE, UV + vec2(size_x, size_y)).a != 0.0
			|| texture(TEXTURE, UV + vec2(-size_x, size_y)).a != 0.0
			|| texture(TEXTURE, UV + vec2(-size_x, -size_y)).a != 0.0
			|| texture(TEXTURE, UV + vec2(size_x, -size_y)).a != 0.0){	
				if (!modulate) color = outline_color / MODULATE;
				else color = outline_color;
			}
		}
	}
	COLOR = color * MODULATE;
}