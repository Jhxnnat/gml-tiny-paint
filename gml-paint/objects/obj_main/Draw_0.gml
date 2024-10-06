/// @description Draw the GUI && canvas

if (is_drawing && surface_exists(global.surf_canvas)) {
	
	x2 = mouse_x; y2 = mouse_y;
	
	surface_set_target(global.surf_canvas)
	draw_set_color(global.cv_color)
	
	//draw_circle(x1,y1,10,false)
	cv_draw_line(x1,y1,x2,y2,global.cv_pencil_width,global.cv_color);
	
	draw_set_color(c_white)
	surface_reset_target()
	
	//surface_copy(global.surf_canvas, 0, 0, global.surf_draw)	
	
	x1 = x2;
	y1 = y2;
	
}

if(surface_exists(global.surf_canvas)){
	draw_surface_ext(global.surf_canvas,0,0, global.cv_zoom, global.cv_zoom, 0, c_white, 1);
}

//draw_circle_color(mouse_x,mouse_y,10,c_red,c_red,true);

draw_set_color(c_black);
draw_text(10, 10, $"fps: {fps_real}");
draw_set_color(c_white);