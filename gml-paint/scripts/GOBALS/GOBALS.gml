game_set_speed(30, gamespeed_fps)

#macro WINDOW_W 980
#macro WINDOW_H 560 
#macro CW 960
#macro CH 540  

global.surf_canvas = -1
global.surf_draw = -1
function canvas_init(){
	if(surface_exists(global.surf_canvas)) {
		surface_free(global.surf_canvas)
	}
	
	global.surf_canvas = surface_create(CW,CH)
	
	if (surface_exists(global.surf_draw)) {
		surface_free(global.surf_draw);
	}
	
	global.surf_draw = surface_create(CW,CH)
}


//#region tools

global.cv_color = c_black;
global.cv_pencil_width = 10;
global.cv_zoom = 1;


/// Draw func

/// @desc Function Description
/// @param {real} x1 Description
/// @param {real} y1 Description
/// @param {real} x2 Description
/// @param {real} y2 Description
/// @param {real} [width]=10 Description
function cv_draw_line(x1,y1,x2,y2,width=10,color=c_black) {
	if (abs(x2-x1) > abs(y2-y1)) cv_draw_line_h(x1,y1,x2,y2,width,color);
	else cv_draw_line_v(x1,y1,x2,y2,width,color);
}

function cv_draw_line_h(x1,y1,x2,y2,width=10,color=c_red) {
	if (x1 > x2) {
		var _temp = x1;
		x1 = x2;
		x2 = _temp;
		
		_temp = y1;
		y1 = y2;
		y2 = _temp;
	}
	
	var _dx = x2-x1;
	var _dy = y2-y1;
	
	var _dir = _dy < 0 ? -1 : 1;
	_dy *= _dir;
	
	//if (_dx != 0) {
	if (true) {
		var _y = y1;
		var _p = 2*_dy - _dx;
		for (var _i = 0; _i < _dx+1; _i++) {
			draw_circle_color(x1+_i,_y,width,color,color,false);
			if (_p >= 0) {
				_y += _dir;
				_p = _p - 2*_dx;
			}
			_p = _p + 2*_dy;
		}
	}
}

function cv_draw_line_v(x1,y1,x2,y2,width=10,color=c_red) {
	if (y1 > y2) {
		var _temp = x1;
		x1 = x2;
		x2 = _temp;
		
		_temp = y1;
		y1 = y2;
		y2 = _temp;
	}
	
	var _dx = x2-x1;
	var _dy = y2-y1;
	
	var _dir = _dx < 0 ? -1 : 1;
		_dx *= _dir;
	
	//if (_dy != 0) {
	if (true) {
		var _x = x1;
		var _p = 2*_dx - _dy;
		for (var _i = 0; _i < _dy+1; _i++) {
			draw_circle_color(_x,y1+_i,width,color,color,false);
			if (_p >= 0) {
			_x += _dir;
			_p = _p - 2*_dy;
		}
		_p = _p + 2*_dx;
		}
	}
}


////Utis

/// @desc better show_debug_message
/// @param {any} ... whatever to log in console
function print() {
	if (argument_count > 0) {
		var _log = "", i = 0;
		repeat(argument_count) {
			_log += string(argument[i]);
			if (argument_count > 1) _log += " | ";
			++i;
		}
		show_debug_message(_log);
	}
}

//// Undo-Redo

global.undo = [surface_create(CW,CH)]
global.redo = [surface_create(CW,CH)]

function history_write() {
	var _len = array_length(global.undo)
	surface_copy(global.undo[_len-1], 0, 0, global.surf_canvas)
	array_push(global.undo, surface_create(CW,CH))
	print(global.undo)
}

function history_undo() {
	var _len = array_length(global.undo)
	if (_len > 2) { 
		
		var __rlen = array_length(global.redo)
		surface_copy(global.redo[__rlen-1], 0, 0, global.surf_canvas)
		array_push(global.redo, surface_create(CW,CH))
		
		surface_copy(global.surf_canvas, 0, 0, global.undo[_len-3])
		array_pop(global.undo)
		
	} else if (_len > 1) {
		surface_free(global.surf_canvas)
		global.surf_canvas = surface_create(CW,CH)
		array_pop(global.undo)
	}
	print("Undo: ", global.undo)
	print("Redo: ", global.redo)
}

function history_redo() { //TODO: check memory, use surface free
	/*
	 * 1. set the canvas to redo canvas ref 
	 * 2. pop the last (top, in terms of stack) element of redo
	 * 3. append to undo
	*/
	var _len = array_length(global.redo)
	if (_len > 1) {
		var _i = _len-2
		
		var __ulen = array_length(global.undo)
		surface_copy(global.undo[__ulen-1], 0, 0, global.redo[_i])
		array_push(global.undo, surface_create(CW,CH))
		
		surface_copy(global.surf_canvas, 0, 0, global.redo[_i])
		surface_free(global.redo[_i])
		array_delete(global.redo, _i, 1);
	}
	print("\nRedo: ", global.redo)
	print("\n")
}




