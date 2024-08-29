/// @description get track of mouse
if(mouse_check_button_pressed(mb_left)){
	x1 = mouse_x; y1 = mouse_y;
	x2 = mouse_x; y2 = mouse_y;
	is_drawing = true
}
if(mouse_check_button_released(mb_left)){
	is_drawing = false
}

if(is_drawing){
	x2 = mouse_x; y2 = mouse_y;
	
	if(point_distance(x1,y1,x2,y2)>1){
		array_push(draw_list, [x1,y1,x2,y2]);
		x1 = x2;
		y1 = y2;
	}
}