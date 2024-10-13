game_set_speed(30, gamespeed_fps)

#macro WINDOW_W 980
#macro WINDOW_H 560 
#macro CW global.__cw__
#macro CH global.__ch__
CW = 128
CH = 128

#macro MX global.__mx__
#macro MY global.__my__
MX = 0
MY = 0

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

global.cam = view_camera[0]
function reset_canvas_pos() {
	camera_set_view_pos(global.cam, 0, 0)
	global.cv_zoom = 1
}

//#region tools

enum TOOL {
	HAND,
	PENCIL,
	LINE,
	
	FILL,
	
	ACTION
}
global.selected_tool = TOOL.HAND;

global.cv_color = c_orange;
global.cv_pencil_width = 10;
global.cv_zoom = 1;

function brush_set_bigger() {
	global.cv_pencil_width += 2
	global.cv_pencil_width = clamp(global.cv_pencil_width, 1, 40)
}

function brush_set_smaller() {
	global.cv_pencil_width -= 2
	global.cv_pencil_width = clamp(global.cv_pencil_width, 1, 40)
}

/// @desc Function Description
/// @param {string} name Description
/// @param {enum.TOOL} tool Description
/// @param {asset.GMSprite} [sprite]=spr_pencil Description
/// @param {asset.GMSprite} [cursor]=spr_pencil Description
/// @param {function} [action]=function(){} Description
function _tool(name, tool, sprite = spr_pencil, cursor = spr_pencil, action = function(){}) constructor {
	self.name = name
	self.tool = tool
	self.sprite = sprite
	self.cursor = cursor
	self.action = action
}

global.tool_arr = [
	new _tool("Pencil", TOOL.PENCIL, spr_pencil, spr_pencil_cur),
	new _tool("Line", TOOL.LINE, spr_line, spr_line_cur),
	new _tool("Hand", TOOL.HAND, spr_arrow, spr_arrow_cur),
	new _tool("Focus", TOOL.ACTION, spr_pencil, 0, function(){
		reset_canvas_pos()
	}),
	new _tool("brush+", TOOL.ACTION, spr_pencil, 0, function(){
		brush_set_bigger()
	}),
	new _tool("brush-", TOOL.ACTION, spr_pencil, 0, function(){
		brush_set_smaller()
	}),
]

/// Colors

global.colors = []
array_push(global.colors, #282828)
array_push(global.colors, #cc241d)
array_push(global.colors, #98971a)

array_push(global.colors, #928374)
array_push(global.colors, #fb4934)
array_push(global.colors, #b8bb26)

array_push(global.colors, #d79921)
array_push(global.colors, #458588)
array_push(global.colors, #b16286)

array_push(global.colors, #fabd2f)
array_push(global.colors, #83a598)
array_push(global.colors, #d8369b)

array_push(global.colors, #689d6a)
array_push(global.colors, #a89984)
array_push(global.colors, #d65d0e)

array_push(global.colors, #8ec07c)
array_push(global.colors, #ebdbb2)
array_push(global.colors, #fe8019)

array_push(global.colors, #282828)
array_push(global.colors, #504945)
array_push(global.colors, #928374)

array_push(global.colors, #d5c4a1)
array_push(global.colors, #fbf1c7)

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

function cv_fill(_x,_y,color=c_red) {
	var _prev_color = surface_getpixel(global.surf_canvas,_x,_y);
	if (_prev_color = color) return;
	
	surface_set_target(global.surf_canvas)
	draw_set_color(color)
	//??¡
	surface_reset_target()
	draw_set_color(c_white)
}
function __ffill(_x,_y,_w,_h,_prev_color,_new_color) {
	if (surface_getpixel(global.surf_canvas,_x,_y) != _prev_color) return;
	
	print("ffil draw point")
	draw_point(_x,_y)
	
	//if (_x - 1 >= 0) __ffill(_x-1,_y,_w,_h,_prev_color,_new_color);
	//if (_y + 1 < _h) __ffill(_x,_y+1,_w,_h,_prev_color,_new_color);
	//if (_x + 1 < _w) __ffill(_x+1,_y,_w,_h,_prev_color,_new_color);
	//if (_y - 1 >= 0) __ffill(_x,_y-1,_w,_h,_prev_color,_new_color);
}

function cv_scanfill(_x,_y,color=c_red){
	if (!__inside(_x,_y)) return;
	
	var _getcolor = draw_get_color()
	draw_set_color(color)
	surface_set_target(global.surf_canvas)
	
	var _prev_color = surface_getpixel(global.surf_canvas,_x,_y)
	if (_prev_color = color) return
	
	var _s = ds_stack_create()
	ds_stack_push(_s, [_x,_y])
	
	while (ds_stack_size(_s) > 0) {
		
		var __temp = ds_stack_pop(_s)
		var _curx = __temp[0]
		var _cury = __temp[1]
		
		var _old_color = surface_getpixel(global.surf_canvas, _curx, _cury)
		if (__inside(_curx,_cury) && _old_color == _prev_color) {
			
			draw_point(_curx, _cury)
			
			ds_stack_push(_s, [_curx + 1, _cury])
			ds_stack_push(_s, [_curx - 1, _cury])
			ds_stack_push(_s, [_curx, _cury + 1])
			ds_stack_push(_s, [_curx, _cury - 1])
			
		}
		
	}
	
	ds_stack_destroy(_s)
	
	draw_set_color(_getcolor)
	surface_reset_target()
}
function __inside(_x,_y) {
	if (_x > CW or _x < 0) return false;
	if (_y > CH or _y < 0) return false;
		
	return true
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
