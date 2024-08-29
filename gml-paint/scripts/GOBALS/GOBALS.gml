game_set_speed(30, gamespeed_fps)

#macro WINDOW_W 980
#macro WINDOW_H 560 

global.surf_canvas = -1;
#macro CW 960
#macro CH 540  

function canvas_init(){
	if(surface_exists(global.surf_canvas)) {
		surface_free(global.surf_canvas)
	}
	
	global.surf_canvas = surface_create(CW,CH)
}


#region styles

global.cv_color = c_black;
global.cv_pencil_width = 9;

#endregion


#region utis

function print(args=["print"]) {
	var _text = "";
	var _len = array_length(args);
	var _i=0;
	repeat (_len) {
		_text += string(args[_i]);
		if(_i >= 1){_text += " | "}
		_i++;
	}
	show_debug_message(_text)
}

#endregion