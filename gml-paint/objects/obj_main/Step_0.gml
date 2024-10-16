/// @description 

MX = (window_mouse_get_x()/window_get_width()) * display_get_gui_width();
MY = (window_mouse_get_y()/window_get_height()) * display_get_gui_height();

if (keyboard_check(vk_control)) {
	if (keyboard_check_pressed(ord("Z"))) {
		if (keyboard_check(vk_shift)) {
			history_redo()
		} else {
			history_undo()
		}
	}
}

//Zooming
var _scroll = mouse_wheel_down() - mouse_wheel_up();
global.cv_zoom += _scroll*0.1;
global.cv_zoom = clamp(global.cv_zoom, 0.1, 10)
if (_scroll != 0) {
	camera_set_view_size(global.cam,WINDOW_W*global.cv_zoom,WINDOW_H*global.cv_zoom)
}

switch (keyboard_lastkey) {
	case ord("H"):
		global.selected_tool = TOOL.HAND
		break;
		
	case ord("D"):
		global.selected_tool = TOOL.PENCIL
		break;
	
	case ord("L"):
		global.selected_tool = TOOL.LINE
		break;
	
	case ord("F"):
		global.selected_tool = TOOL.FILL
		break;
	
	case ord("A"):
		reset_canvas_pos()
		break;
}
keyboard_lastkey = -1

var _guimx = window_mouse_get_x()
var _guimy = window_mouse_get_y()
if (mouse_check_button(mb_left) and point_in_rectangle(_guimx, _guimy, ui_coord[0]*2, ui_coord[1]*2, ui_coord[2]*2, ui_coord[3]*2)) {
	clicked_ui = true
}