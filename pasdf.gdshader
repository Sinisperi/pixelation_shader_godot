shader_type canvas_item;

uniform sampler2D noise: repeat_enable, filter_nearest;
uniform float pixelation: hint_range(0.001, 10.0, 2.0);
void fragment() {
	float t = (TIME / 1000.0 * speed); // maybe no sin
	//vec2 pixel_size = vec2(1.0) / vec2(128.0, 128.0); //TEXTURE_PIXEL_SIZE; // lies
	//vec2 pos = UV * (vec2(textureSize(TEXTURE, 0)) / pixelation); // converting uv coords to texture coords
	// UV from vec2(0.0) to vec2(1.0) -> vec2(0.0) to vec2(128.0, 128.0)
	vec2 pos = floor(UV * vec2(128.0, 128.0) / pixelation); // converting uv coords to texture coords and flooring it, so that
	// 1.0 unit == one pixel if not scaling up then flooring will result in being 0.0 all the time
	//vec2 pix_uv = pos * pixel_size * pixelation ; // scaling it back down to the pixel size 
	vec2 pix_uv = pos / vec2(128.0, 128.0) * pixelation; // normalizing position, so it's in UV coords now 
	vec4 color = texture(TEXTURE, pix_uv);
	
	vec4 noise_color_at = texture(noise, pix_uv + t); // getting noise at that position
	float luminance = 0.21 * color.r + 0.72 * color.g + 0.07 * color.b;
	//color.rgb += vec3(luminance) * 1.0 - pixelation;
	//COLOR = mix(color, vec4(1.0, 0.0, 0.0, 1.0), noise_color_at.r);
	COLOR = color;
	COLOR.r = noise_color_at.r;
}
