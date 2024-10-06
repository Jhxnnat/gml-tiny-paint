/// @description get track of mouse
if(mouse_check_button_pressed(mb_left)){
	x1 = mouse_x; y1 = mouse_y;
	x2 = mouse_x; y2 = mouse_y;
	is_drawing = true
	
}
if(mouse_check_button_released(mb_left)){
	is_drawing = false
	history_write()
}

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
global.cv_zoom = clamp(global.cv_zoom, 0.1, 10);

if (keyboard_check_pressed(ord("Q"))) { global.cv_color = c_red } 
else if (keyboard_check_pressed(ord("W"))) { global.cv_color = c_green }
else if (keyboard_check_pressed(ord("E"))) { global.cv_color = c_blue }
else if (keyboard_check_pressed(ord("R"))) { global.cv_color = c_black }
else if (keyboard_check_pressed(ord("T"))) { global.cv_color = c_white }