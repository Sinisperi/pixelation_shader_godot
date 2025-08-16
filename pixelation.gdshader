shader_type canvas_item;

uniform sampler2D noise: repeat_enable;
uniform float speed: hint_range(0.0, 100.0, 1.0);
uniform float opacity: hint_range(0.0, 1.0, 0.01);
uniform float detail: hint_range(0.0, 1.0, 0.01);
void fragment() {
	float t = (TIME / 1000.0 * speed); // maybe no sin
	vec2 pixel_size = TEXTURE_PIXEL_SIZE;
	vec2 pos = UV * vec2(textureSize(TEXTURE, 0)); // converting uv coords to texture coords
	vec2 pix_uv = floor(pos) * pixel_size + t; // flooring position to make it pixelated and scaling it to the pixel size 
	vec4 noise_color_at = texture(noise, pix_uv); // getting noise at that position
	if(COLOR.b > 0.6)
	{
		COLOR.rgb += COLOR.rgb * smoothstep(1.0 - detail, 1.0, noise_color_at.r) * opacity;	
	}
	//COLOR.rgb += COLOR.rgb * ( smoothstep(0.1, 1.0, noise_color_at.r)) * 0.2;
	if(COLOR.a > 0.5 && COLOR.a < 1.0)
	{
		COLOR.a -= smoothstep(1.0 - detail, 1.0, noise_color_at.r) * opacity;
	}
}