/// @description get track of mouse

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
}
keyboard_lastkey = -1