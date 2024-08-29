/// @description Draw the GUI && canvas

if(surface_exists(global.surf_canvas)){
	
	//setting stuff on canvas
	surface_set_target(global.surf_canvas)
	
	draw_set_color(global.cv_color);
	
	var _l = draw_list;
	var _len = array_length(_l);
	for(var _i=0; _i<_len; _i++){
		var _x1 = _l[_i][0],
			_y1 = _l[_i][1],
			_x2 = _l[_i][2],
			_y2 = _l[_i][3];
		
		draw_line_width(_x1,_y1,_x2,_y2,global.cv_pencil_width);
	}
	
	surface_reset_target()
	
	//final canvas drawing
	draw_surface(global.surf_canvas,20,20)
}
