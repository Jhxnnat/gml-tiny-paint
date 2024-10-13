/// @description Draw the canvas

if(surface_exists(global.surf_canvas)){
	draw_set_alpha(1)
	draw_set_color(c_white)
	draw_surface_ext(global.surf_canvas,0,0, 1, 1, 0, c_white, 1)
	
	if (is_drawing_line) {
		cv_draw_line(line_start_x,line_start_y,mouse_x,mouse_y,global.cv_pencil_width,global.cv_color)
	}
	
	draw_set_color(c_black)
	draw_rectangle(0,0,CW,CH,true)
	draw_set_color(c_white)
}

if (clicked_ui) {
	clicked_ui = false
	exit
}

switch (global.selected_tool) {
	case TOOL.HAND:
		
		var _mx = display_mouse_get_x()
		var _my = display_mouse_get_y()
		
		if (mouse_check_button(mb_left)) {
			var _cx = camera_get_view_x(global.cam)
			var _cy = camera_get_view_y(global.cam)
			var __x = _cx+(drag_prev_x-_mx)* .5
			var __y = _cy+(drag_prev_y-_my)* .5
			camera_set_view_pos(global.cam, __x, __y)
		}
		
		drag_prev_x = _mx
		drag_prev_y = _my
	
		break
	
	case TOOL.PENCIL:
		
		if(mouse_check_button_pressed(mb_left)){
			x1 = mouse_x; y1 = mouse_y;
			x2 = mouse_x; y2 = mouse_y;
			is_drawing = true
			
		}
		if(mouse_check_button_released(mb_left) && is_drawing){
			is_drawing = false
			history_write()
		}	

		if (is_drawing && surface_exists(global.surf_canvas)) {
			
			x2 = mouse_x
			y2 = mouse_y
			
			surface_set_target(global.surf_canvas)
			draw_set_color(global.cv_color)
			
			cv_draw_line(x1,y1,x2,y2,global.cv_pencil_width,global.cv_color)
			
			draw_set_color(c_white)
			surface_reset_target()
			
			x1 = x2
			y1 = y2
			
		}
		
		break;
	
	case TOOL.LINE:
		
		if (mouse_check_button_pressed(mb_left)) {
			line_start_x = mouse_x
			line_start_y = mouse_y
			is_drawing_line = true
		}
	
		if (mouse_check_button_released(mb_left) && is_drawing_line) {
			is_drawing_line = false
			
			surface_set_target(global.surf_canvas)
			draw_set_color(global.cv_color)
			
			cv_draw_line(line_start_x,line_start_y,mouse_x,mouse_y,global.cv_pencil_width,global.cv_color)
			
			draw_set_color(c_white)
			surface_reset_target()
			
			history_write()
		}
	
		break
	
	case TOOL.FILL:
	
		if (mouse_check_button_pressed(mb_left)) {
			cv_scanfill(mouse_x,mouse_y,global.cv_color)
			draw_set_color(c_white)
			history_write()
		}
	
		break;
}


