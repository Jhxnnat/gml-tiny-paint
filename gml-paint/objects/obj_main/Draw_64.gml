/// @description UI
draw_set_font(fnt_main)
draw_set_alpha(1)

//debug
//draw_set_halign(fa_left)
//draw_set_valign(fa_top)
//draw_set_color(c_black)
////draw_text(10, 10, $"fps: {fps_real}")
//draw_text(10, 10, $"{camera_get_view_x(global.cam)} x {camera_get_view_y(global.cam)}")
//draw_text(10, 25, $"tool: {global.selected_tool}")

//Actual UI
	
draw_set_color(c_black)
draw_rectangle(ui_coord[0]-1, ui_coord[1]-1, ui_coord[2]+1, ui_coord[3]+1, false) //side
draw_rectangle(0,guih-status_h-1,status_w,guih,false) //status
draw_set_color(c_white)
draw_rectangle(ui_coord[0], ui_coord[1], ui_coord[2], ui_coord[3], false) //side
draw_rectangle(0,guih-status_h,status_w,guih,false) //status

//status bar info
draw_set_color(c_black)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
var __color = "Color: "
draw_text(3, guih-3, __color)
draw_set_halign(fa_right)
draw_text(ui_coord[0]-3, guih-3, $"Zoom: {floor(1/global.cv_zoom*100)}% | {CW}x{CH}")

var __x = 7 + (string_width("w") * string_length(__color) / 2)
draw_set_color(c_black)
draw_rectangle(__x-1,guih-17,__x+17,guih-2,false)
draw_set_color(global.cv_color)
draw_rectangle(__x,guih-16,__x+16,guih-3,false)

draw_set_halign(fa_left)
draw_set_color(c_black)
draw_text(__x + 27, guih-3, $"Size: {global.cv_pencil_width}")

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
	draw_rectangle(_x-1,_y-1,_w+1,_h+1,false)
	draw_set_color(c_white)
	draw_rectangle(_x,_y,_w,_h,false)
	
	draw_set_color(c_white)
	draw_sprite(_t.sprite, 0 ,_x, _y)
	
	if (point_in_rectangle(MX,MY, _x,_y,_w,_h) and mouse_check_button_pressed(mb_left)) {
		if (_t.tool != TOOL.ACTION) {
			global.selected_tool = _t.tool
			cursor = _t.cursor
		} else {
			_t.action()
		}
	}
	
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
	
	draw_set_color(c_black)
	draw_rectangle(_x-1,_y+1,_w+1,_h-1,false)
	
	draw_set_color(_c)
	draw_rectangle(_x,_y,_w,_h,false)
	
	if (point_in_rectangle(MX,MY, _x,_h,_w,_y) and mouse_check_button_pressed(mb_left)) {
		global.cv_color = _c
	}
	
	_col++
	if (_col > _colmax) {
		_col = 0
		_row++
	}
}

draw_set_color(c_white)

draw_sprite(cursor, 0, MX,MY)