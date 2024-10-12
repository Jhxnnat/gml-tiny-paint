/// @description UI

draw_set_alpha(1)

//debug
draw_set_font(fnt_main)
draw_set_color(c_black)
draw_text(10, 10, $"fps: {fps_real}")
draw_text(10, 25, $"fps: {fps}")
draw_text(10, 40, $"tool: {global.selected_tool}")
draw_text(10, 55, $"cv: {CW}x{CH}")


//Actual UI
draw_set_color(c_gray)
draw_rectangle(ui_coord[0], ui_coord[1], ui_coord[2], ui_coord[3], false)

var _col = 0
var _colmax = 2
var _row = 0
var _icon_size = 16
var _gap = 4
var _margin = 4

//Icons - btns
for (var _i = 0; _i < array_length(global.tool_arr); _i++) {
	
	var _t = global.tool_arr[_i]
	
	
	var _x = ui_coord[0] + (_col*(_icon_size+_gap)) + _margin
	var _y = ui_coord[1] + (_row*(_icon_size+_gap)) + _margin
	var _w = _x + 16
	var _h = _y + 16
	
	draw_set_color(c_dkgray)
	draw_rectangle(_x,_y,_w,_h,false)
	
	draw_set_color(c_white)
	draw_sprite(_t.sprite, 0 ,_x, _y)
	
	_col++
	if (_col > _colmax) {
		_col = 0
		_row++
	}
}

// Colors

_col = 0
_row = 0
for (var _i = 0; _i < array_length(global.colors); _i++) {
	var _c = global.colors[_i]
	
	var _x = ui_coord[0] + (_col*(_icon_size+_gap)) + _margin
	var _y = ui_coord[3] - (_row*(_icon_size+_gap)) - _margin
	var _w = _x + 16
	var _h = _y - 16
	
	draw_set_color(_c)
	draw_rectangle(_x,_y,_w,_h,false)
	
	_col++
	if (_col > _colmax) {
		_col = 0
		_row++
	}
}

draw_set_color(c_white)