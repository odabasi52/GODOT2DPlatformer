shader_type canvas_item;

//export 
uniform vec4 baseColor : source_color;

void fragment() {
	vec4 texcolor = texture(TEXTURE, UV);
	COLOR.rgba = vec4(baseColor.r,baseColor.g,baseColor.b,texcolor.a);
}
